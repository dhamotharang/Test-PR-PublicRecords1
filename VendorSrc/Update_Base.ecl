import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;
EXPORT Update_Base (string filedate, boolean pUseProd = false) := function
//standardize input
input := Files(filedate,pUseProd).input;
layouts.base tMapping(layouts.input L, C) := TRANSFORM
	SELF.src    := mdr.sourceTools.src_AlloyMedia_Consumer;							
	SELF.persistent_record_id := filedate+ '_'+ intformat(c,9,1);
	SELF.Dt_first_seen  := (unsigned)filedate;
	SELF.Dt_last_seen   := (unsigned)filedate;
	SELF.Dt_vendor_first_reported := (unsigned)filedate;
	SELF.Dt_vendor_last_reported := (unsigned)filedate;
	SELF.clean_phone := if(ut.CleanPhone(L.orig_phone) [1] not in ['0','1'],ut.CleanPhone(L.orig_phone), '') ;
	SELF.clean_dob := if(L.orig_dob <> '', _validate.date.fCorrectedDateString(L.orig_dob,false), '');
	SELF  :=  L;
	SELF := [];
END;

std_input := project(Files(filedate,pUseProd).input, tMapping(LEFT, counter));
//Clean names
NID.Mac_CleanParsedNames(std_input, cleanNames
													, firstname:=orig_first_name,lastname:=orig_last_name
													, includeInRepository:=true, normalizeDualNames:=false
												);

//clean address

cleanNames_t := project(cleanNames, transform({recordof(cleanNames), string orig_addr1, string orig_addr2},
																		self.orig_addr1 := trim(stringlib.stringfilterout(left.orig_address1 + ' ' + left.orig_address2,'.^!$+<>@=%?*\''), left, right),			
																		self.orig_addr2 := trim(StringLib.StringCleanSpaces(
																					trim(left.orig_city)
																					+ if(left.orig_city <> '',',','')
																					+ ' '+ left.orig_state_province
																					+ ' '+ if(length(trim(left.orig_zip5[..5],all)) = 5,
																										left.orig_zip5[..5],''))
																										,left,right),
																		self := left));			
																					
																			
unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(cleanNames_t,orig_addr1,orig_addr2,RawAID,cleanAddr, lFlags);

Layouts.base tr(cleanAddr l) := TRANSFORM
	self.title := l.cln_title;
	self.fname := l.cln_fname;
	self.mname := l.cln_mname;
	self.lname := l.cln_lname;
	self.name_suffix := l.cln_suffix;
	self.RawAID     := l.aidwork_rawaid;
	self.ACEAID			:= l.	aidwork_acecache.aid;
	self.prim_range := stringlib.stringfilterout(l.aidwork_acecache.prim_range,'.');
	self.prim_name  := stringlib.stringfilterout(l.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
	self.sec_range  := stringlib.stringfilterout(l.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
	self.v_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.v_city_name,'');
	self.p_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.p_city_name,'');
	self.zip        := l.aidwork_acecache.zip5;
	self.fips_st    := l.aidwork_acecache.county[1..2];
	self.fips_county:= l.aidwork_acecache.county[3..5];
	self.msa        := if(l.aidwork_acecache.msa='','',l.aidwork_acecache.msa+'0');
	self            := l.aidwork_acecache;
	self            := l;
END;

cleanAdd_t := project(cleanAddr,tr(left));

//Add to previous base
base_and_update := if(nothor(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).lBaseTemplate_built)) = 0
											 ,cleanAdd_t
											 ,cleanAdd_t + Files(filedate, pUseProd).base.built);

new_base_d := distribute(base_and_update, hash(match_key, orig_first_name,orig_last_name,orig_address1,orig_phone,orig_email,orig_dob));  
new_base_s := sort(new_base_d,
									match_key,
									orig_first_name,					
									orig_last_name,						
									orig_Zip5,							
									orig_address1,					
									orig_phone,														
									orig_email,
									orig_dob,
									customer_name,
									orig_address2,
									orig_city,
									orig_state_province,
									orig_zip4,
									orig_carrier_route,
									orig_dpbc,
									orig_gender,
									orig_check_digit,
									orig_ethnicity,
									-dt_last_seen, 
									-dt_vendor_last_reported,
									local);
						
Layouts.base t_rollup (new_base_s  le, new_base_s ri) := transform
 self.dt_first_seen            := ut.EarliestDate (le.dt_first_seen, ri.dt_first_seen);
 self.dt_last_seen             := ut.LatestDate (le.dt_last_seen, ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.EarliestDate(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := ut.LatestDate(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
 self.persistent_record_id     := if(le.persistent_record_id < ri.persistent_record_id,le.persistent_record_id, ri.persistent_record_id); 
 self.did := 0;
 self := le;
end;

base_f := rollup(new_base_s,
									left.match_key = right.match_key and
									left.orig_first_name = right.orig_first_name and				
									left.orig_last_name = right.orig_last_name and						
									left.orig_Zip5 = right.orig_Zip5	 and					
									left.orig_address1 = right.orig_address1 and				
									left.orig_phone = right.orig_phone and														
									left.orig_email = right.orig_email and
									left.orig_dob = right.orig_dob and
									left.customer_name = right.customer_name and
									left.orig_address2 = right.orig_address2 and
									left.orig_city = right.orig_city and
									left.orig_state_province = right.orig_state_province and
									left.orig_zip4  = right.orig_zip4 and
									left.orig_carrier_route = right.orig_carrier_route and
									left.orig_dpbc = right.orig_dpbc and
									left.orig_gender = right.orig_gender and
									left.orig_check_digit = right.orig_check_digit and
									left.orig_ethnicity = right.orig_ethnicity
																	,t_rollup(left, right)
																	,local);

//DID

matchset := ['A','Z','D','P'];
did_add.MAC_Match_Flex
	(base_f, matchset,					
	 foo,clean_dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,clean_phone, 
	 DID, Layouts.base, true, did_score,
	 75, d_did,true, src);
	 

return d_did;
end;