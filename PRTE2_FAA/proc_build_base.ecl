 import ut, PromoteSupers, Data_Services, prte2, BIPV2,prte_bip, AID, Address, AID_Support,std, mdr,census_data;
 #workunit('name','PRTE FAA Build');
 // #constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
																	
//Uppercase, CleanSpaces, and remove unprintable characters
PRTE2.CleanFields(Files.raw_airmen,dsClnAirmen);
PRTE2.CleanFields(Files.raw_aircraft_reg,dsClnAircraft);
PRTE2.CleanFields(Files.raw_airmen_certs,dsClnAirmen_Cert);


//Existing Records
dsAirmenExistingRecords  	:= dsClnAirmen(cust_name = '');
dsAircraftExistingRecords := dsClnAircraft(cust_name = '');

//New Records
dsAirmenNewRecords 		:= dsClnAirmen(cust_name <> '');
dsAircraftNewRecords 	:= dsClnAircraft(cust_name <> '');

//Prepping Airmen/Aircraft Records for Address Cleaner
PrepAddrLayout := record
	string33 	street;
	string33 	street2;
	string18 	city;
	string5 	state;
	string10 	zip_code;
	string150	Append_PrepAddr1;
	string100	Append_PrepAddr2;
	AID.Common.xAID	RawAID	:=	0;
	address.Layout_Clean182;
	string18	county_name;
end;

PrepAddrLayout		tAppendPrepAddrAircraft(dsAircraftNewRecords l) := transform
	self.Append_PrepAddr1	:= address.fn_addr_clean_prep(std.str.cleanspaces(L.street + ' '+ L.street2),'first');        
	self.Append_PrepAddr2	:= address.fn_addr_clean_prep(Address.Addr2FromComponents(L.city, L.state, L.zip_code),'last');
	self := L;
	self := [];
end;
dAddressPrepAircraft	:= PROJECT(dsAircraftNewRecords, tAppendPrepAddrAircraft(LEFT));

PrepAddrLayout		tAppendPrepAddrAirmen(dsAirmenNewRecords l) := transform
  self.street 					:= L.street1;
	self.Append_PrepAddr1	:= address.fn_addr_clean_prep(std.str.cleanspaces(L.street1 + ' '+ L.street2),'first');        
	self.Append_PrepAddr2	:= address.fn_addr_clean_prep(Address.Addr2FromComponents(L.city, L.state, L.zip_code),'last');
	self := L;
	self := [];
end;
dAddressPrepAirmen	:= PROJECT(dsAirmenNewRecords, tAppendPrepAddrAirmen(LEFT));


//Concatenate Address Records
dsAddressPrep := dedup(dAddressPrepAircraft + dAddressPrepAirmen, all);

//New Records- Aderess Cleaning
unsigned4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords|AID.Common.eReturnValues.NoNewCacheFiles;

AID.MacAppendFromRaw_2Line(dsAddressPrep, Append_PrepAddr1, Append_PrepAddr2, RawAID, dAddressCleaned, lAIDAppendFlags);		

//New Records- Join Address Records back to original Incoming files
PrepAddrLayout  tCleanAddressAppended(dAddressCleaned pInput) := transform
	self.RawAID				:= pInput.AIDWork_RawAID;
	self.prim_range		:= pInput.AIDWork_ACECache.prim_range;
	self.predir				:= pInput.AIDWork_ACECache.predir;
	self.prim_name		:= pInput.AIDWork_ACECache.prim_name;
	self.addr_suffix	:= pInput.AIDWork_ACECache.addr_suffix;
	self.postdir			:= pInput.AIDWork_ACECache.postdir;
	self.unit_desig		:= pInput.AIDWork_ACECache.unit_desig;
	self.sec_range		:= pInput.AIDWork_ACECache.sec_range;
	self.p_city_name	:= pInput.AIDWork_ACECache.p_city_name;
	self.v_city_name	:= pInput.AIDWork_ACECache.v_city_name;
	self.st						:= pInput.AIDWork_ACECache.st;
	self.zip					:= pInput.AIDWork_ACECache.zip5;
	self.zip4					:= pInput.AIDWork_ACECache.zip4;		
	self.cart					:= pInput.AIDWork_ACECache.cart;
	self.cr_sort_sz		:= pInput.AIDWork_ACECache.cr_sort_sz;
	self.lot					:= pInput.AIDWork_ACECache.lot;
	self.lot_order		:= pInput.AIDWork_ACECache.lot_order;
	self.dbpc					:= pInput.AIDWork_ACECache.dbpc;
	self.chk_digit		:= pInput.AIDWork_ACECache.chk_digit;
	self.rec_type			:= pInput.AIDWork_ACECache.rec_type;
	self.county				:= pInput.AIDWork_ACECache.county;
	self.geo_lat			:= pInput.AIDWork_ACECache.geo_lat;
	self.geo_long			:= pInput.AIDWork_ACECache.geo_long;
	self.msa					:= pInput.AIDWork_ACECache.msa;
	self.geo_blk			:= pInput.AIDWork_ACECache.geo_blk;
	self.geo_match		:= pInput.AIDWork_ACECache.geo_match;
	self.err_stat			:= pInput.AIDWork_ACECache.err_stat;
	self :=	pInput;
	self := [];
end;
					
dCleanAddressAppended	:=	project(dAddressCleaned,tCleanAddressAppended(left));	

//Appending County Name
PrepAddrLayout getCounty(dCleanAddressAppended L, census_data.File_Fips2County R) := transform
	self.county_name := R.county_name;
	self := L;
end;

jCountyName := join(dCleanAddressAppended, census_data.file_fips2county, 
										left.county[3..5] = right.county_fips and
										left.st = right.state_code,
										getCounty(LEFT,RIGHT),left outer, lookup);


//Populating Airmen Records with Clean Address
Layouts.Airmen  AppendCleanAddrAirmen(dsAirmenNewRecords l, jCountyName r) := transform
	self.dpbc 				:= r.dbpc;
	self.ace_fips_st	:= r.county[1..2];
	self.county				:= r.county[3..5];
	self := r;
	self := l;
end;
	
j1 := join(dsAirmenNewRecords, jCountyName,
					 left.street1 = right.street	and
					 left.street2 = right.street2 and
					 left.city		= right.city		and
					 left.state		= right.state		and 
					 left.zip_code = right.zip_code,
								AppendCleanAddrAirmen(left,right), left outer);


//Populating Aircraft Records with Clean Address											
Layouts.aircraft_registration  AppendCleanAddrAircraft(dsAircraftNewRecords l, jCountyName r) := transform
	self.dpbc 				:= r.dbpc;
	self.ace_fips_st	:= r.county[1..2];
	self.county				:= r.county[3..5];
	self := r;
	self := l;
end;

j2 := join(dsAircraftNewRecords, jCountyName,
					 left.street 	= right.street	and
					 left.street2 = right.street2 and
					 left.city		= right.city		and
					 left.state		= right.state		and 
					 left.zip_code = right.zip_code,
							AppendCleanAddrAircraft(left,right), left outer);
							



//New Records- Cleaning Names &  Appendind ID(s) to Airmen & Aircraft Records
Layouts.Airmen	tAppendCleanNameAirmen(j1 pInput) := transform
//Clean Name
v_clean_name					:= Address.CleanPersonFML73(STD.Str.CleanSpaces(trim(pInput.orig_fname+ ' '+ pInput.orig_lname))); 
self.fname						:= v_clean_name[6..25];
self.mname						:= v_clean_name[26..45];	
self.lname						:= v_clean_name[46..65];
self.name_suffix			:= v_clean_name[66..70];

//if BEST_SSN is blank, only populate for LN_PR records
self.best_ssn					:= if(pInput.cust_name = 'LN_PR', pInput.link_ssn, pInput.best_ssn);
//Append ID(s)
self.did	 						:= prte2.fn_AppendFakeID.did(self.fname, self.lname, pInput.link_ssn, pInput.link_dob, pInput.cust_name);
self.did_out 					:= (string12)self.did;
self := pInput;
self := [];
end;
dsAirmenNewRecordsFinal := project(j1, tAppendCleanNameAirmen(left));


Layouts.aircraft_registration	tAppendCleanNameAircraft(j2 pInput) := transform
//Clean Name
v_clean_name					:= if(pInput.type_registrant in Constants.indiv_ind, Address.CleanPersonFML73(trim(pInput.name)),''); 
v_firm_name						:= if(pInput.type_registrant in Constants.bus_ind, pInput.name,'');                              															 
self.fname						:= v_clean_name[6..25];
self.mname						:= v_clean_name[26..45];	
self.lname						:= v_clean_name[46..65];
self.name_suffix			:= v_clean_name[66..70];
self.compname					:= v_firm_name;

//if BEST_SSN is blank, only populate for LN_PR records
self.best_ssn					:= if(pInput.cust_name = 'LN_PR', pInput.link_ssn, pInput.best_ssn);

//Append ID(s)
self.did	 						:= prte2.fn_AppendFakeID.did(self.fname, self.lname, pInput.link_ssn, pInput.link_dob,  pInput.cust_name);
self.bd 							:= prte2.fn_AppendFakeID.bdid(self.compname, pInput.prim_range,  pInput.prim_name,  pInput.v_city_name,  pInput.st,  pInput.zip,  pInput.cust_name);

vLinkingIds := prte2.fn_AppendFakeID.LinkIds(v_firm_name, pInput.link_fein, pInput.link_inc_date,  pInput.prim_range,  pInput.prim_name,  pInput.sec_range,  pInput.v_city_name,  pInput.st,  pInput.zip,  pInput.cust_name);
self.powid	:= vLinkingIds.powid;
self.proxid	:= vLinkingIds.proxid;
self.seleid	:= vLinkingIds.seleid;
self.orgid	:= vLinkingIds.orgid;
self.ultid	:= vLinkingIds.ultid;

self.did_out 	:= (string12)self.did;
self.bdid_out	:= (string12)self.bd;
self := pInput;
self := [];
end;
dsAircraftNewRecordFinal := project(j2, tAppendCleanNameAircraft(left));



//Appending Persistent ID to ALL records
dsSearchAirmen := project(dsAirmenExistingRecords + dsAirmenNewRecordsFinal, 
															transform(Layouts.Search_Airmen, 
																				self.persistent_record_id := hash64(left.airmen_id +','+  //added to make unique
																																						trim(left.current_flag,left,right) +','+
																																						trim(left.record_type,left,right) +','+
																																						trim(left.letter_code,left,right) +','+
																																						trim(left.unique_id,left,right) +','+
																																						trim(left.orig_rec_type,left,right) +','+
																																						trim(left.orig_fname,left,right) +','+
																																						trim(left.orig_lname,left,right) +','+
																																						trim(left.street1,left,right) +','+
																																						trim(left.street2,left,right) +','+
																																						trim(left.city,left,right) +','+
																																						trim(left.state,left,right) +','+
																																						trim(left.zip_code,left,right) +','+
																																						trim(left.country,left,right) +','+
																																						trim(left.region,left,right) +','+
																																						trim(left.med_class,left,right) +','+
																																						trim(left.med_date,left,right) +','+
																																						trim(left.med_exp_date,left,right)), self := left, self := []));




dsSearchAircraftReg := project(dsAircraftExistingRecords + dsAircraftNewRecordFinal, 
																	transform(Layouts.Search_Aircraft, 
																						self.eng_mfr_mdl 					:= if(trim(left.eng_mfr_mdl) = '0', INTFORMAT((integer)left.eng_mfr_mdl,5,1), left.eng_mfr_mdl);
																						self.persistent_record_id := hash64(trim(left.n_number,left,right) +','+
																																							  trim(left.serial_number,left,right)+ ','+
																																								trim(left.mfr_mdl_code,left,right)+ ','+
																																								trim(left.eng_mfr_mdl,left,right)+ ','+
																																								trim(left.year_mfr,left,right)+ ','+
																																								trim(left.type_registrant,left,right)+ ','+
																																								trim(left.name,left,right)+ ','+
																																								trim(left.street,left,right)+ ','+
																																								trim(left.street2,left,right)+ ','+
																																								trim(left.city,left,right)+ ','+
																																								trim(left.state,left,right)+ ','+
																																								trim(left.zip_code,left,right)+ ','+
																																								trim(left.region,left,right)+ ','+
																																								trim(left.orig_county,left,right)+ ','+
																																								trim(left.country,left,right)+ ','+
																																								trim(left.last_action_date,left,right)+ ','+
																																								trim(left.cert_issue_date,left,right)+ ','+
																																								trim(left.certification,left,right)+ ','+
																																								trim(left.type_aircraft,left,right)+ ','+
																																								trim(left.type_engine,left,right)+ ','+
																																								trim(left.status_code,left,right)+ ','+
																																								trim(left.mode_s_code,left,right)+ ','+
																																								trim(left.fract_owner,left,right)+ ','+
																																								trim(left.aircraft_mfr_name,left,right)+ ','+
																																								trim(left.model_name,left,right)), self := left, self := [])); 



dsSearchAirmenCert := project(dsClnAirmen_Cert, transform(Layouts.base_airmen_cert, 
																										 self.persistent_record_id := hash64(trim(left.current_flag,left,right)+ ','+
																																									trim(left.letter,left,right)+ ','+
																																									trim(left.unique_id,left,right)+ ','+
																																									trim(left.rec_type,left,right)+ ','+
																																									trim(left.cer_type,left,right)+ ','+
																																									trim(left.cer_type_mapped,left,right)+ ','+
																																									trim(left.cer_level,left,right)+ ','+
																																									trim(left.cer_level_mapped,left,right)+ ','+
																																									trim(left.cer_exp_date,left,right)+ ','+
																																									trim(left.ratings,left,right)), self := left, self := [])); 
																
dsSearchAircraftReg_dedup:=dedup(dsSearchAircraftReg);

PromoteSupers.Mac_SF_BuildProcess(dsSearchAirmen,Constants.base_prefix_name+'airmen',airmen_out,2,,true);
PromoteSupers.Mac_SF_BuildProcess(dsSearchAircraftReg_dedup,Constants.base_prefix_name+'aircraft_reg',aircraft_reg_out,2,,true);
PromoteSupers.Mac_SF_BuildProcess(dsSearchAirmenCert,Constants.base_prefix_name+'airmen_certs',airmen_certs_out,2,,true);


EXPORT proc_build_base := sequential(airmen_out,aircraft_reg_out,airmen_certs_out);			