import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT Update_Base (string filedate, boolean pUseProd = false) := function
//standardize input
input := Files(filedate,pUseProd).input;
layouts.base tMapping(layouts.input L, C) := TRANSFORM
	SELF.src    := mdr.sourceTools.src_link2tek;							
	SELF.persistent_record_id := filedate+ '_'+ intformat(c,9,1);
	SELF.Dt_first_seen  := (unsigned)filedate;
	SELF.Dt_last_seen   := (unsigned)filedate;
	SELF.Dt_vendor_first_reported := (unsigned)filedate;
	SELF.Dt_vendor_last_reported := (unsigned)filedate;
	SELF.clean_phone := if(ut.CleanPhone(L.orig_phone) [1] not in ['0','1'],ut.CleanPhone(L.orig_phone), '') ;
									// raw file has po box number in the house number field, and "PO BOX" in the street name field - need to concatentate accordingly
	SELF.Pre_prepped_addr1  	:= IF((Stringlib.StringToUpperCase(L.orig_street_name) <> 'PO BOX'),
																							TRIM(Stringlib.StringToUpperCase(Stringlib.stringcleanspaces(L.orig_house_number)) 
																						+ IF(TRIM(L.orig_predirection) <> '',' '+(TRIM(Stringlib.StringToUpperCase(L.orig_predirection))),'')
																						+ IF(TRIM(L.orig_street_name) <> '',' '+(TRIM(Stringlib.StringToUpperCase(L.orig_street_name))),'')
																						+ IF(TRIM(L.orig_suffix) <> '',' '+(TRIM(Stringlib.StringToUpperCase(L.orig_suffix))),'')
																						+ IF(TRIM(L.orig_postdirection) <> '',' '+(TRIM(Stringlib.StringToUpperCase(L.orig_postdirection))),'')
																						+ IF(TRIM(L.orig_unit_name) <> '',' '+(TRIM(Stringlib.StringToUpperCase(L.orig_unit_name))),'')
																						+ IF(TRIM(L.orig_unit_number) <> '', ' '+(TRIM(Stringlib.StringToUpperCase(L.orig_unit_number))),''), LEFT,RIGHT),//;
																			TRIM(Stringlib.StringToUpperCase(L.orig_street_name)
																						+ ' ' + TRIM(Stringlib.StringToUpperCase(Stringlib.StringCleanSpaces(L.orig_house_number))), LEFT, RIGHT));
	SELF.IsUpdating	:= TRUE;
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

cleanNames_t := project(cleanNames, transform({recordof(cleanNames), string prepped_addr1, string prepped_addr2},
																		self.prepped_addr1 := trim(stringlib.stringfilterout(left.pre_prepped_addr1,'.^!$+<>@=%?*\''), left, right),	
																		self.prepped_addr2 := trim(StringLib.StringCleanSpaces(
																					trim(left.orig_city)
																					+ if(left.orig_city <> '',',','')
																					+ ' '+ left.orig_state
																					+ ' '+ if(length(trim(left.orig_zip[..5],all)) = 5,
																										left.orig_zip[..5],''))
																										,left,right),
																		self := left));			
																					
																			
unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(cleanNames_t,pre_prepped_addr1,prepped_addr2,RawAID,cleanAddr, lFlags);
																			
Layouts.base tr(cleanAddr l) := TRANSFORM
	self.title := IF(l.cln_title IN ['MR', 'MS'], l.cln_title, '');
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
											 ,cleanAdd_t + project(Files(filedate, pUseProd).base.qa, transform(layouts.Base, self.IsUpdating := false, self := left)));

new_base_d := distribute(base_and_update, hash(orig_first_name,orig_last_name,pre_prepped_addr1,orig_phone));  
new_base_s := sort(new_base_d,
									orig_first_name,					
									orig_last_name,						
									pre_prepped_addr1,
									orig_phone,
									orig_Zip,										
									orig_city,
									orig_state,
									orig_zip_4,
									orig_crte,
									orig_dpc, 
									-dt_vendor_last_reported,
									local);
						
Layouts.base t_rollup (new_base_s  le, new_base_s ri) := transform
 self.dt_vendor_first_reported := ut.EarliestDate(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := ut.LatestDate(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
 self.persistent_record_id     := if(le.persistent_record_id < ri.persistent_record_id,le.persistent_record_id, ri.persistent_record_id); 
 self.IsUpdating							 := if(le.isupdating = true, le.isupdating, ri.isupdating);
 self.did := 0;
 self 												 := if(le.isupdating = true, le, ri);
end;

base_f := rollup(new_base_s,
							/*		left.match_key = right.match_key and */
									left.orig_first_name = right.orig_first_name and				
									left.orig_last_name = right.orig_last_name and						
									left.orig_Zip = right.orig_Zip	 and					
									left.pre_prepped_addr1 = right.pre_prepped_addr1 and				
									left.orig_phone = right.orig_phone and													
									left.orig_city = right.orig_city and
									left.orig_state = right.orig_state and
									left.orig_zip_4  = right.orig_zip_4 and
									left.orig_crte = right.orig_crte and
									left.orig_dpc = right.orig_dpc
																	,t_rollup(left, right)
																	,local);

//DID

matchset := ['A','Z','P'];
did_add.MAC_Match_Flex
	(base_f, matchset,					
	 foo, foo, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,clean_phone, 
	 DID, Layouts.base, true, did_score,
	 75, d_did,true, src);
	 

return d_did;
end;