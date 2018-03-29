import ut, Drivers, _Validate, DriversV2, lib_stringlib, AID, Std;

//EXPORT DL_Update := 'todo';

dNonExperianDLs := 	DriversV2.File_DL_Input_Mappers  //* All DL states mapped to a common layout (DriversV2.Layout_DL_Extended) - AS_DL_Mappers
										// filtering experian & Certegy records from the base, so they get added back again. And blanking the appended ssn's for base records
									+	project(DriversV2.File_DL_Extended(source_code not in ['AX','CY']), transform(DriversV2.Layout_DL_Extended, self.ssn := '', self :=left)) 
									+ project(DriversV2.File_DL_Restricted, transform(DriversV2.Layout_DL_Extended, self.ssn := '', self :=left));			
 
 
// Adding in Experian records below!
dExperianDist       :=    distribute(DriversV2.Mapping_Experian_as_DL,hash(orig_state,lname));
dNonExperianDist    :=    distribute(dNonExperianDLs,hash(orig_state,lname));
dExperianSort       :=    sort(dExperianDist,orig_state,lname,fname,mname,name_suffix,zip5,zip4,lic_issue_date,orig_expiration_date,local);
dNonExperianSort    :=    sort(dNonExperianDist,orig_state,lname,fname,mname,name_suffix,zip5,zip4,lic_issue_date,orig_expiration_date,local);

recordof(dExperianSort)    tExperianNotAlreadyHere(dExperianSort pExperian, dNonExperianSort pNonExperian)
 :=
  transform
    self    :=    pExperian;
  end
 ;

dExperianNotInHouse    :=    join(dExperianSort,dNonExperianSort,
                             left.orig_state            =    right.orig_state
                         and left.lname                 =    right.lname
                         and left.fname                 =    right.fname
                         and left.mname                 =    right.mname
                         and left.name_suffix           =    right.name_suffix
                         and left.zip5                  =    right.zip5
                         and left.zip4                  =    right.zip4
                         and left.lic_issue_date        =    right.lic_issue_date
                         and left.orig_expiration_date  =    right.orig_expiration_date,
                             tExperianNotAlreadyHere(left,right),
                             left only,
                             local
                           ) ;
                      
ldl := DriversV2.Layout_Base_withAID;

//****** Check each rec to make sure it did not expire b4 that states initial load
//         If it did, then zero out its dates

//drivers.MAC_Check_Expire(dNonExperianDLs, expiration_date, dNonExperianChecked)

rec := record
	dNonExperianDLs.orig_state;
	integer init_load := 100 * (integer)min(group, (integer)dNonExperianDLs.dt_first_seen);
end;

dt := table(dNonExperianDLs(dt_first_Seen > 190000), rec, orig_state, few);

// output(dt);
typeof(dNonExperianDLs) checkexp(dNonExperianDLs l, dt r) := transform
integer exp_date := if(l.orig_expiration_date=0,l.expiration_date,l.orig_expiration_date);
  self.dt_first_seen := if(exp_date > 19000000 and exp_date < r.init_load,
						   0, l.dt_first_seen);
  self.dt_last_seen := if(exp_date > 19000000 and exp_date < r.init_load,
						   0, l.dt_last_seen);
  self.dt_vendor_first_reported := if(exp_date > 19000000 and exp_date < r.init_load,
								   0, l.dt_vendor_first_reported);
  self.dt_vendor_last_reported := if(exp_date > 19000000 and exp_date < r.init_load,
								   0, l.dt_vendor_last_reported);
  self := l;
end;

dNonExperianChecked := join(dNonExperianDLs, dt, left.orig_state = right.orig_state, checkexp(left, right), left outer, lookup);

dCombinedDLs    :=    dNonExperianChecked    + dExperianNotInHouse;    // no need to check Experian DL dates...  already done there.

//------------------
//Begin AID cleaning  
//------------------
/* Transform to map the base format to base format with address prep fields */
DriversV2.Layout_Base_withAID tMapping(DriversV2.Layout_DL_Extended L) := TRANSFORM
	SELF.Append_MailAddress1		:= 	StringLib.StringCleanSpaces(TRIM(L.addr1));
	SELF.Append_MailAddressLast	:= 	
				IF (L.orig_state = 'FL'
						, (IF (L.City!=''
								, StringLib.StringCleanSpaces(TRIM(L.City) +', '+'FL'+' '+TRIM(L.Zip)) 
								, StringLib.StringCleanSpaces('FL'+' '+TRIM(L.Zip))))  
  					, (IF(L.City!=''
                , (IF ( L.State !=''   
                	    , StringLib.StringCleanSpaces(TRIM(L.City) +', '+TRIM(L.State) +' '+TRIM(L.Zip)) 
											, StringLib.StringCleanSpaces(TRIM(L.City) +' '+TRIM(L.Zip)))) 
								, (IF (L.State !=''  
											, StringLib.StringCleanSpaces(TRIM(L.State) +' '+TRIM(L.Zip)) 
											, StringLib.StringCleanSpaces(TRIM(L.Zip)))))));
	SELF.Append_MailRawAID := 0;
	SELF.Append_MailACEAID := 0;
	SELF  :=  L;
END;

/* Projection of the base format to the temp base format with address prep fields */	 
dMapping := PROJECT(dCombinedDLs,tMapping(LEFT));

/* Call the AID Address Cleaner macro */
HasAddress       := trim(dMapping.Append_MailAddressLast, left,right) != '';									
dWith_address		 := dMapping(HasAddress);
dWithout_address := dMapping(not(HasAddress));			
lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
AID.MacAppendFromRaw_2Line(dWith_address, Append_MailAddress1, Append_MailAddresslast, Append_MailRawAID, dwithAID, lFlags);

/* Populate the cleaned address fields with the ones being returned from the AID macro */
DriversV2.Layout_Base_withAID tGetStandardizedAddress(dwithAID l)	:=	transform
			self.Append_MailRawAID:= 	l.AIDWork_RawAID;
		  self.Append_MailACEAID:=  l.AIDWork_ACECache.aid; 						
			self.prim_range				:=	l.AIDWork_ACECache.prim_range;
			self.predir						:=	l.AIDWork_ACECache.predir;
			self.prim_name				:=	l.AIDWork_ACECache.prim_name;
			self.suffix						:=	l.AIDWork_ACECache.addr_suffix;
			self.postdir					:=	l.AIDWork_ACECache.postdir;
			self.unit_desig				:=	l.AIDWork_ACECache.unit_desig;
			self.sec_range				:=	l.AIDWork_ACECache.sec_range;		
			self.p_city_name			:=	l.AIDWork_ACECache.p_city_name;	
			self.v_city_name			:=	l.AIDWork_ACECache.v_city_name;	
			self.st								:=	l.AIDWork_ACECache.st;	
			self.zip5							:=	l.AIDWork_ACECache.zip5;	
			self.zip4							:=	l.AIDWork_ACECache.zip4;	
			self.cart							:=	l.AIDWork_ACECache.cart;	
			self.cr_sort_sz				:=	l.AIDWork_ACECache.cr_sort_sz;	
			self.lot							:=	l.AIDWork_ACECache.lot;				
			self.lot_order				:=	l.AIDWork_ACECache.lot_order;
			self.dpbc						  :=	l.AIDWork_ACECache.dbpc;	
			self.chk_digit				:=	l.AIDWork_ACECache.chk_digit;	
			self.rec_type					:=	l.AIDWork_ACECache.rec_type;
			self.ace_fips_st			:=	l.AIDWork_ACECache.county[1..2];	
			self.county						:=	l.AIDWork_ACECache.county[3..5];	
			self.geo_lat					:=	l.AIDWork_ACECache.geo_lat;	
			self.geo_long					:=	l.AIDWork_ACECache.geo_long;	
			self.msa							:=	l.AIDWork_ACECache.msa;	
			self.geo_blk					:=	l.AIDWork_ACECache.geo_blk;	
			self.geo_match				:=	l.AIDWork_ACECache.geo_match;
			self.err_stat					:=	l.AIDWork_ACECache.err_stat;
			self									:= 	l;
	end;
	
dCombinedDLs2	:=	project(dwithAID, tGetStandardizedAddress(left)) + dWithout_address ;
 											
//----------------
//End AID cleaning
//----------------

// stored values to override the default value of year low & year high to 1900 & current year.
#stored('_Validate_Year_Range_Low',  '1900');
year_high := ((STRING8)Std.Date.Today())[1..4];
#stored('_Validate_Year_Range_High', year_high);
// function to fix the invalid date values and returns the date value in ccyymmdd format.
string8 fixdate(string indate) := function
    outdate := _Validate.date.fCorrectedDateString(trim(indate,left,right));
	return(if((integer)trim(outdate,left,right) = 0, '', outdate));
end;

all_zeros := '00000000000000';

DriversV2.Layout_Base_withAID trfTOFixProvince(DriversV2.Layout_Base_withAID l) := transform
  boolean isProvince   := if (trim(l.state, left, right) in Driversv2.Table_DL_Province_Codes.Province_Codes, true, false);
  self.province        := if (isProvince, l.state, '');
  self.country         := if (isProvince, Driversv2.Table_DL_Province_Codes.Province_Country(self.province), '');
  self.postal_code     := if (isProvince, if((integer)l.zip = 0, '', trim(l.zip,left,right)), '');
  self.prim_range      := if (isProvince, '', l.prim_range);
  self.predir          := if (isProvince, '', l.predir);
  self.prim_name       := if (isProvince, '', l.prim_name);
  self.suffix          := if (isProvince, '', l.suffix);
  self.postdir         := if (isProvince, '', l.postdir);
  self.unit_desig      := if (isProvince, '', l.unit_desig);
  self.sec_range       := if (isProvince, '', l.sec_range);
  self.p_city_name     := if (isProvince, '', l.p_city_name);
  self.v_city_name     := if (isProvince, '', l.v_city_name);
  self.st              := if (isProvince, '', l.st);
  self.zip5            := if (isProvince, '', l.zip5);
  self.zip4            := if (isProvince, '', l.zip4);
  self.cart            := if (isProvince, '', l.cart);
  self.cr_sort_sz      := if (isProvince, '', l.cr_sort_sz);
  self.lot             := if (isProvince, '', l.lot);
  self.lot_order       := if (isProvince, '', l.lot_order);
  self.dpbc            := if (isProvince, '', l.dpbc);
  self.chk_digit       := if (isProvince, '', l.chk_digit);
  self.rec_type        := if (isProvince, '', l.rec_type);
  self.ace_fips_st     := if (isProvince, '', l.ace_fips_st);
  self.county          := if (isProvince, '', l.county);
  self.geo_lat         := if (isProvince, '', l.geo_lat);
  self.geo_long        := if (isProvince, '', l.geo_long);
  self.msa             := if (isProvince, '', l.msa);
  self.geo_blk         := if (isProvince, '', l.geo_blk);
  self.geo_match       := if (isProvince, '', l.geo_match);
  self.err_stat        := if (isProvince, '', l.err_stat);
  self.dob             := (integer)fixdate((string)l.dob);
  self.orig_issue_date := (integer)fixdate((string)l.orig_issue_date);
  self.lic_issue_date  := (integer)fixdate((string)l.lic_issue_date);
  self.expiration_date := if (l.expiration_date < self.lic_issue_date, 0, l.expiration_date); //logic added for bug#26592
  self.dl_number       := if (stringlib.StringCleanSpaces(l.dl_number) = all_zeros[1..length(stringlib.StringCleanSpaces(l.dl_number))],
                              '', l.dl_number
															); // Assigning empty string if the dl_number is all zero's
	self.ssn						 :=	if (trim(StringLib.StringFilterOut(l.SSN, '0')) = '' or trim(StringLib.StringFilterOut(l.SSN, '9')) = '', 
																'',
																l.SSN
															);
	self.ssn_safe				 :=	if (trim(StringLib.StringFilterOut(l.ssn_safe, '0')) = '' or trim(StringLib.StringFilterOut(l.ssn_safe, '9')) = '', 
																'',
																l.ssn_safe
															);								 
  self                 := l;
end;

dCombinedDLs_w_province := project(dCombinedDLs2, trfTOFixProvince(left));
 

//****** Get rid of recs that are just a state dumping the same thing again

dist := distribute(dCombinedDLs_w_province, hash(orig_state, dl_number));
srtd := sort(dist,orig_state,dl_number,name,addr1,city,state,zip,dob,race,sex_flag,license_type,
    attention_flag,dod,restrictions,orig_expiration_date,orig_issue_date,lic_issue_date,
    expiration_date,active_date,inactive_date,lic_endorsement,motorcycle_code,ssn_safe,age,
    privacy_flag,driver_edu_code,dup_lic_count,rcd_stat_flag,height,hair_color,eye_color,weight,
    oos_previous_dl_number,oos_previous_st,status,issuance,address_change,name_change,dob_change,
    sex_change,old_dl_number,dl_key_number, 
    //want to keep the oldest rec
    lic_issue_date, orig_expiration_date,-dt_last_seen,
    local);

mac_selfequalr(field) := macro
    self.field := r.field;
endmacro;

typeof(srtd) rollem(srtd l, srtd r) := transform
    //take the right (newer data) on cleaned fields
    mac_selfequalr(title)
    mac_selfequalr(fname)
    mac_selfequalr(mname)
    mac_selfequalr(lname)
    mac_selfequalr(name_suffix)
    mac_selfequalr(cleaning_score)
    mac_selfequalr(addr_fix_flag)
    mac_selfequalr(prim_range)
    mac_selfequalr(predir)
    mac_selfequalr(prim_name)
    mac_selfequalr(suffix)
    mac_selfequalr(postdir)
    mac_selfequalr(unit_desig)
    mac_selfequalr(sec_range)
    mac_selfequalr(p_city_name)
    mac_selfequalr(v_city_name)
    mac_selfequalr(st)
    mac_selfequalr(zip5)
    mac_selfequalr(zip4)
    mac_selfequalr(cart)
    mac_selfequalr(cr_sort_sz)
    mac_selfequalr(lot)
    mac_selfequalr(lot_order)
    mac_selfequalr(dpbc)
    mac_selfequalr(chk_digit)
    mac_selfequalr(rec_type)
    mac_selfequalr(ace_fips_st)
    mac_selfequalr(county)
    mac_selfequalr(geo_lat)
    mac_selfequalr(geo_long)
    mac_selfequalr(msa)
    mac_selfequalr(geo_blk)
    mac_selfequalr(geo_match)
    mac_selfequalr(err_stat)
		self.dt_first_seen                  := ut.EarliestDate(l.dt_first_seen,	r.dt_first_seen);
    self.dt_last_seen                   := max(l.dt_last_seen,r.dt_last_seen);
		self.dt_vendor_first_reported 			:= ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		self.dt_vendor_last_reported 				:= max(l.dt_vendor_last_reported,r.dt_vendor_last_reported);
    //otherwise take the orig
    self := l;
end;

ddpd := rollup(srtd,
    left.orig_state = right.orig_state and
    left.dl_number = right.dl_number and
    left.name = right.name and
    left.addr1 = right.addr1 and
    left.city = right.city and
    left.state = right.state and
    left.zip = right.zip and
    left.dob = right.dob and
    left.race = right.race and
    left.sex_flag = right.sex_flag and
    left.license_type = right.license_type and
    left.attention_flag = right.attention_flag and
    left.dod = right.dod and
    left.restrictions = right.restrictions and
    left.orig_expiration_date = right.orig_expiration_date and
    left.orig_issue_date = right.orig_issue_date and
    left.lic_issue_date = right.lic_issue_date and
    left.expiration_date = right.expiration_date and
    left.active_date = right.active_date and
    left.inactive_date = right.inactive_date and
    left.lic_endorsement = right.lic_endorsement and
    left.motorcycle_code = right.motorcycle_code and
    left.ssn_safe = right.ssn_safe and
    left.age = right.age and
    left.privacy_flag = right.privacy_flag and
    left.driver_edu_code = right.driver_edu_code and
    left.dup_lic_count = right.dup_lic_count and
    left.rcd_stat_flag = right.rcd_stat_flag and
    left.height = right.height and
    left.hair_color = right.hair_color and
    left.eye_color = right.eye_color and
    left.weight = right.weight and
    left.oos_previous_dl_number = right.oos_previous_dl_number and
    left.oos_previous_st = right.oos_previous_st and
    left.status = right.status and
    left.issuance = right.issuance and
    left.address_change = right.address_change and
    left.name_change = right.name_change and
    left.dob_change = right.dob_change and
    left.sex_change = right.sex_change and
    left.old_dl_number = right.old_dl_number and
    left.dl_key_number = right.dl_key_number, 
    rollem(left, right), local);
 

//****** Set the history flag where there is a newer rec for that person

rlup_same_grp := group(sort(ddpd(history <> 'E'),dl_number, orig_State,-dt_last_seen,-dt_first_seen,-lic_issue_Date,local),dl_number, orig_State,local);


ldl make_hist(ldl le,ldl ri) := transform
  self.history := map(ri.history <> '' => ri.history,
                      ri.expiration_Date > 0 and ri.expiration_Date < (unsigned4)((string8)Std.Date.Today()) => 'E',
                      le.orig_state='' => ri.history,
                      'H');
  self := ri;
end;

//--------------------------------------
//AID Address Cleaning for Certegy_as_DL  
//--------------------------------------
/* Projection of the base format to the temp base format with address prep fields */	 
cMapping 				 := PROJECT(Certegy_as_DL,tMapping(LEFT));
cHasAddress      := trim(cMapping.Append_MailAddressLast, left,right) != '';									
cWith_address		 := cMapping(cHasAddress);
cWithout_address := cMapping(not(cHasAddress));			
cFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
AID.MacAppendFromRaw_2Line(cWith_address, Append_MailAddress1, Append_MailAddresslast, Append_MailRawAID, cwithAID, cFlags);
	
Certegy_as_DL2	:=	project(cwithAID, tGetStandardizedAddress(left)) + cWithout_address : INDEPENDENT;
	
res := iterate(rlup_same_grp,make_hist(left,right) ) + ddpd(history = 'E') + Certegy_as_DL2;	
	
//group(res): persist(DriversV2.Constants.cluster + 'Persist::DL2::DrvLic_DL_Joined');

dis_res := distribute(group(res), hash64(orig_state, source_code, name, addr1, city, state, zip, dob, dl_number));

srt_dis_res := sort(dis_res, orig_state, source_code, history, name, addr1, city, state, zip, province, county, postal_code,
                    dob, race, sex_flag, license_class, license_type, moxie_license_type, attention_flag, dod, restrictions, restrictions_delimited,
					orig_expiration_date, orig_issue_date, lic_issue_date, expiration_date, active_date, inactive_date, lic_endorsement,
					motorcycle_code, dl_number, ssn_safe, age, privacy_flag, driver_edu_code, dup_lic_count, rcd_stat_flag, height, 
					hair_color, eye_color, weight, oos_previous_dl_number, oos_previous_st, title, fname, mname, lname, name_suffix, cleaning_score,
					addr_fix_flag, prim_range, predir, prim_name, suffix, postdir, unit_desig, sec_range, p_city_name, v_city_name, st, zip5, zip4,
	                cart, cr_sort_sz, lot, lot_order, dpbc, chk_digit, rec_type, ace_fips_st, county, geo_lat, geo_long, msa, geo_blk, geo_match,
	                err_stat, issuance, address_change, name_change, dob_change, sex_change, old_dl_number,
					dl_key_number, CDL_status, -dt_last_seen,
			        map(	orig_state + trim(status)  = 'CTVAL'  => 1,
							orig_state + trim(status)  = 'MEA'    => 1,
							orig_state + trim(status)  = 'MN0'    => 1,
						/* Removed MO data per bug# 37550 - reinstated MO on 20090716 */
						    orig_state + trim(status)  = 'MOV'    => 1,
							orig_state + trim(status)  = 'MOVR'   => 2,
							orig_state + trim(status)  = 'MOVX'   => 3,
							orig_state + trim(status)  = 'MOE'    => 4,
							orig_state + trim(status)  = 'MOWE'   => 5,
							orig_state + trim(status)  = 'MOW'    => 6,
							orig_state + trim(status)  = 'MOWV'   => 7,
							orig_state + trim(status)  = 'MOC'    => 8,
							orig_state + trim(status)  = 'MOS'    => 9,
							orig_state + trim(status)  = 'MOCS'   => 10,
							orig_state + trim(status)  = 'MOR'    => 11,
							orig_state + trim(status)  = 'MORR'   => 12,
							orig_state + trim(status)  = 'MOLT'   => 13,
							orig_state + trim(status)  = 'MOD'    => 14,
							orig_state + trim(status)  = 'MOO'    => 15,
							orig_state + trim(status)  = 'TN0'    => 1,
							orig_state + trim(status)  = 'TN1'    => 2,
							orig_state + trim(status)  = 'TN8'    => 3,
							orig_state + trim(status)  = 'WV01'   => 1,
							orig_state + trim(status)  = 'WV10'   => 2,
							100
				       ),
			        local);

export DL_Update := dedup(srt_dis_res, record, except dl_seq, status, dt_first_seen, dt_last_seen,
                          dt_vendor_first_reported, dt_vendor_last_reported, local) : persist(DriversV2.Constants.cluster + 'Persist::DL2::DrvLic_DL_Update');
																		
