Import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
	Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, STD, MDR;
	
	EXPORT Update_Base (string filedate, boolean pUseProd = false) := function
	//standardize input
	input := Files(filedate,pUseProd).input;

	Layouts.base hist(layouts.base L, C):= TRANSFORM
		SELF.record_type	:= 'H';
		//added for CCPA
		SELF.record_sid   := 0;
		SELF							:= L;
	END;

	base_file :=PROJECT(Files(filedate,pUseProd).base.built, hist(LEFT, COUNTER));
	
	// Function to format years with implied decimaal	
	fn_format_length_yrs(string years) := function
		remove_alpha		:= REGEXREPLACE('([A-Z]+)', trim(years),'');
		yrs_Decimal			:= (DECIMAL5_2)(trim(remove_alpha)+'.00');	
		yrs_Decimal_fmt	:= if(length(trim(remove_alpha)) > 2, REALFORMAT(yrs_Decimal/10,6,1), remove_alpha);
		yrs_Duration		:= trim(yrs_Decimal_fmt,left,right); 
		return yrs_Duration;
	end;	
	

	layouts.base tMapping(layouts.input L) := TRANSFORM
		SELF.src    										:= mdr.sourceTools.src_Infutornarc;							
		SELF.Date_vendor_first_reported := (unsigned)filedate;
		SELF.Date_vendor_last_reported 	:= (unsigned)filedate;
		SELF.clean_phone 								:= if(ut.CleanPhone(L.orig_TelephoneNumber_1) [1] not in ['0','1'],ut.CleanPhone(L.orig_TelephoneNumber_1), '') ;
		SELF.clean_dob 									:= if(L.orig_dob <> '', _validate.date.fCorrectedDateString(L.orig_dob,false), '');
		SELF.record_type								:= 'C';         	
		SELF  :=  L;
		SELF 	:= [];
	END;

	std_input := project(input, tMapping(LEFT));
	
	gStd_input:= MDR.macGetGlobalSid(std_input, 'InfutorNARC', '', 'global_sid');

	NID.Mac_CleanParsedNames(gStd_input, cleanNames0
												, firstname:=orig_FNAME,middlename:=orig_mname,lastname:=orig_LNAME,namesuffix:=orig_SUFFIX
												, includeInRepository:=true, normalizeDualNames:=false
											);

cleanNames := cleanNames0(nametype='P');

	cleanNames_t := project(cleanNames, transform({recordof(cleannames), string orig_addr1, string orig_addr2},
																								self.orig_addr1 := trim(stringlib.stringfilterout(left.orig_ADDRESS,'.^!$+<>@=%?*\''), left, right),			
																								self.orig_addr2 := trim(StringLib.StringCleanSpaces(
																																					trim(left.orig_city)
																																					+  if(left.orig_city <> '',',','')
																																					+ ' '+ left.orig_state
																																					+ ' '+ if(length(trim(left.orig_zip[..5],all)) = 5,
																																		left.orig_zip[..5],''))
																																		, left,right),
																								self := left));			


																		
	unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
	AID.MacAppendFromRaw_2Line(cleanNames_t,orig_addr1,orig_addr2,RawAID,cleanAddr, lFlags);

	 Layouts.base tr(cleanAddr l) := TRANSFORM
		self.title 				:= IF(l.cln_title IN ['MR', 'MS'], l.cln_title, '');
		self.fname 				:= l.cln_fname;
		self.mname 				:= l.cln_mname;
		self.lname 				:= l.cln_lname;
		self.name_suffix 	:= l.cln_suffix;
		self.RawAID     	:= l.aidwork_rawaid;
		self.prim_range 	:= l.aidwork_acecache.prim_range;
		self.predir      	:= l.aidwork_acecache.predir;
		self.addr_suffix  := l.aidwork_acecache.addr_suffix;
		self.postdir     	:= l.aidwork_acecache.postdir;
		self.unit_desig  	:= l.aidwork_acecache.unit_desig;
		self.sec_range   	:= stringlib.stringfilterout(l.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
		self.v_city_name 	:= if(length(std.str.filterout(std.str.ToUpperCase(l.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.v_city_name,'');
		self.p_city_name 	:= if(length(std.str.filterout(std.str.ToUpperCase(l.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.p_city_name,'');
		self.zip4        	:= l.aidwork_acecache.zip4;
		SELF.cart       	:= l.aidwork_acecache.cart;
		SELF.cr_sort_sz 	:= l.aidwork_acecache.cr_sort_sz;
		SELF.lot        	:= l.aidwork_acecache.lot;
		SELF.lot_order  	:= l.aidwork_acecache.lot_order;
		SELF.chk_digit  	:= l.aidwork_acecache.chk_digit;
		SELF.rec_type   	:= l.aidwork_acecache.rec_type;
		self.st          	:= l.aidwork_acecache.st;
		self.fips_st     	:= l.aidwork_acecache.county[1..2];
		self.fips_county 	:= l.aidwork_acecache.county[3..5];
		SELF.geo_lat    	:= l.aidwork_acecache.geo_lat;
		SELF.geo_long   	:= l.aidwork_acecache.geo_long;
		self.msa         	:= if(l.aidwork_acecache.msa='','',l.aidwork_acecache.msa+'0');
		SELF.geo_blk    	:= l.aidwork_acecache.geo_blk;
		SELF.geo_match  	:= l.aidwork_acecache.geo_match;
		SELF.err_stat   	:= l.aidwork_acecache.err_stat;
		SELF.prim_name  	:= std.str.filterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
    SELF.Zip         	:= L.aidwork_acecache.zip5;
    SELF.dbpc       	:= l.aidwork_acecache.dbpc;
		self:=l;
			END;



 cleanAdd_t := project(cleanAddr,tr(left)):persist('~thordata_400::infutor_narc::final_dataset::output');

	//Add to previous base
 base_and_update := if(nothor(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).lBaseTemplate_built)) = 0
	            				 ,cleanAdd_t,cleanAdd_t + base_file);


	new_base_d := distribute(base_and_update, hash(orig_fname,orig_mname,orig_lname,orig_SUFFIX,orig_address,clean_dob,orig_city,orig_state,orig_zip,orig_dpc,orig_gender,clean_phone));

	new_base_s := sort(new_base_d,
										 orig_fname,
										 orig_mname,
										 orig_lname,
										 orig_SUFFIX,
										 // orig_Zip,							
										 orig_address,					
										 clean_dob,
										 orig_city,
										 orig_state,
										 orig_zip,
										 orig_dpc,
										 orig_gender,
										 clean_phone,
								     record_type,
								     -date_vendor_last_reported,
										local);
					
	Layouts.base t_rollup (new_base_s  le, new_base_s ri) := transform
		self.date_first_seen            := (string)ut.EarliestDate ((integer)le.date_first_seen,(integer) ri.date_first_seen);
		self.date_last_seen             := (string)ut.LatestDate ((integer)le.date_last_seen, (integer)ri.date_last_seen);
		self.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
		self.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
		self.did := 0;
		self := le;
	end;

	base_f := rollup(new_base_s,
									left.orig_fname 	= right.orig_fname 	and
									left.orig_mname 	= right.orig_mname 	and
									left.orig_lname 	= right.orig_lname 	and
									left.orig_SUFFIX 	= right.orig_SUFFIX and
									left.orig_address = right.orig_address and				
									left.clean_dob 		= right.clean_dob 	and
									left.orig_city 		= right.orig_city 	and
									left.orig_state 	= right.orig_state 	and
									left.orig_zip  		= right.orig_zip 		and
									left.orig_dpc 		= right.orig_dpc 		and
									left.orig_gender 	= right.orig_gender and
									LEFT.clean_phone 	= RIGHT.clean_phone
									,t_rollup(left, right)
									,local);

//Appending DID
	matchset := ['A','Z','D','P'];
	did_add.MAC_Match_Flex
	(base_f, matchset,					
	 foo,clean_dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,clean_phone, 
	 DID, Layouts.base, true, did_score,
	 75, d_did);


//Temp Layout to append HHID
temp_Layout := record
Infutor_NARC.layouts.base;
unsigned6 hhid := 0;
end;

//Debugging code
d_did_hhid := project(d_did, temp_Layout):persist('~thordata_400::infutor_narc::final_dataset::d_did_redefined');


//append hhid 
append_value := 'HHID_PLUS';

//----Append HHID for recs with and without did
with_did 		:= d_did_hhid(did > 0);
without_did	:= d_did_hhid(did = 0);


didville.MAC_HHID_Append(with_did, append_value, 	Append_HHID1);

didville.MAC_HHID_Append_By_Address(without_did, Append_HHID2, hhid, lname, prim_range, prim_name, sec_range, st, zip);
infutor_narc_all := Append_HHID1+ Append_HHID2;

file_hhid := project(infutor_narc_all, transform(Infutor_NARC.layouts.base, self.lexhhid := left.hhid, self := left));


return file_hhid;
end;