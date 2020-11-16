import  PRTE2_ECrash, ut, PromoteSupers, Data_Services, prte2, BIPV2,prte_bip, AID, Address, std, FLAccidents;

//Uppercase, CleanSpaces, and remove unprintable characters
PRTE2.CleanFields(Files.infile_boca, dsClnEcrash);

//Cleaning Address/Name fields for New Records
temp_layout := record
  layout_boca_in;
	// string5   suffix := '',
	BIPV2.IDlayouts.l_xlink_ids;
	AID.Common.xAID	rawaid	:=	0;
end;


//Split records
Orig_recs := project(dsClnEcrash(cust_name = ''), temp_layout);
New_recs  := project(dsClnEcrash(cust_name != ''), temp_layout);

																	
//Commented out due to issuw with AID cleaner
 dAddressCleaned := PRTE2.AddressCleaner(New_recs,
																														 ['orig_street_address1'],
																														 ['orig_street_address2'],
																														 [],
																														 [],
																														 [],
																														 ['clean_address'],
																														 ['temp_rawaid']
																														 );
																															

temp_layout  tCleanAddressAppended(dAddressCleaned pInput) := transform
	self 							:= pInput.clean_address;
	self.dpbc 				:= pInput.clean_address.dbpc;
	self.county 			:= pInput.clean_address.fips_county;
	self.rawaid				:= pInput.temp_rawaid;
	
	CleanName					:= Address.CleanPersonFML73(pInput.orig_full_name);
	self.title        := CleanName[1..5];
	self.fname				:= CleanName[6..25];
  self.mname				:= CleanName[26..45];
  self.lname				:= CleanName[46..65];
  self.suffix 			:= CleanName[66..70];
  self.cname        := if(length(trim(pInput.orig_fname+' '+ pInput.orig_lname+' '+pInput.orig_mname)) = 0 
																				and pInput.orig_full_name <> '', pInput.orig_full_name, '');
	
	
  self.report_code						     := if(pInput.report_code <> '', pInput.report_code, 'EA');
	// map(pInput.source_id ='TF'=>'TF', pInput.source_id ='TM' => 'TM', 'EA');
  self.report_category				     := CASE(pInput.report_code
																					,'A'=>'AUTO REPORT'
																					,'B'=>'AUTO REPORT'
																					,'C'=>'AUTO REPORT'
																					,'D'=>'OTHER REPORT'
																					,'E'=>'OTHER REPORT'
																					,'F'=>'OTHER REPORT'
																					,'G'=>'OTHER REPORT'
																					,'H'=>'AUTO REPORT'
																					,'I'=>'OTHER REPORT'
																					,'J'=>'AUTO REPORT'
																					,'K'=>'OTHER REPORT'
																					,'L'=>'OTHER REPORT'
																					,'M'=>'OTHER REPORT'
																					,'N'=>'OTHER REPORT'
																					,'O'=>'OTHER REPORT'
																					,'P'=>'AUTO REPORT'
																					,'Q'=>'AUTO REPORT'
																					,'R'=>'AUTO REPORT'
																					,'S'=>'CERTIFICATES'
																					,'T'=>'CERTIFICATES'
																					,'U'=>'OTHER REPORT'
																					,'V'=>'OTHER REPORT'
																					,'W'=>'OTHER REPORT'
																					,'X'=>'AUTO REPORT'
																					,'Y'=>'OTHER REPORT'
																					,'Z'=>'OTHER REPORT'
																					,'FS'=>'AUTO REPORT' 
																					,'0'=>'INTERACTIVE REPORT'
																				  ,'1'=>'INTERACTIVE REPORT'
																					,'2'=>'INTERACTIVE REPORT'
																					,'3'=>'INTERACTIVE REPORT'
																					,'4'=>'INTERACTIVE REPORT'
																					,'5'=>'INTERACTIVE REPORT'
																					,'6'=>'INTERACTIVE REPORT'
																					,'7'=>'INTERACTIVE REPORT'
																					,'8'=>'INTERACTIVE REPORT',
																								pInput.report_category);

  self.report_code_desc				     := CASE(pInput.report_code
																					,'A'=>'AUTO ACCIDENT'
																					,'B'=>'AUTO THEFT'
																					,'C'=>'AUTO THEFT RECOVERY'
																					,'D'=>'THEFT BURGLARY'
																					,'E'=>'FIRE BUILDING'
																					,'F'=>'FIRE CAR'
																					,'G'=>'VANDALISM'
																					,'H'=>'D.U.I. REPORT'
																					,'I'=>'MVR'
																					,'J'=>'REGISTERED VEHICLE OWNER'
																					,'K'=>'AUTOPSY/CORONER'
																					,'L'=>'HOMICIDE REPORT'
																					,'M'=>'PHOTOS'
																					,'N'=>'ISSUE LETTER INTEREST'
																					,'O'=>'OTHER'
																					,'P'=>'INSURANCE VERIFICATION'
																					,'Q'=>'TITLE HISTORY'
																					,'R'=>'ALL REGISTERED VEHICLES AT HOUSEHOLD'
																					,'S'=>'Death CERTIFICATE'
																					,'T'=>'Birth CERTIFICATE'
																					,'U'=>'ARREST REPORT'
																					,'V'=>'CITATION/CONVICTION REPORT'
																					,'W'=>'EMS REPORT'
																					,'X'=>'RECONSTRUCTION REPORT'
																					,'Y'=>'SUPPLEMENTAL REPORT'
																					,'Z'=>'TOXICOLOGY REPORT'
																					,'FS'=>'FACE SHEET/LOC SHEET'
																					,'0'=>'ALL REGISTERED VEHICLES AT HOUSEHOLD BY LAST NAME AND ADDRESS'
																					,'1'=>'VIN'
																					,'2'=>'VIN WITH REPORTED DAMAGE - VEHICLE CLAIM HISTORY'
																					,'3'=>'PLATE / TAG'
																					,'4'=>'VEHICLES BY NAME, ADDRESS, YEAR, MAKE AND MODEL'
																					,'5'=>'AUTOCHECKING - VIN HISTORY REPORT'
																					,'6'=>'CLAIMS MVR (DRIVING HISTORY)'
																					,'7'=>'CARRIER DISCOVERY'
																					,'8'=>'CLAIMS DISCOVERY',
																							pInput.report_code_desc);	
	
	self.dob := if(pInput.dob <> '', pInput.dob, pInput.link_dob);
	self :=	pInput;
	self := [];
end;
					
dCleanAddressAppended	:=	project(dAddressCleaned,tCleanAddressAppended(left));	

//Append ID(s)
temp_layout		trecs1(dCleanAddressAppended L) := transform
	v_bdid			:= prte2.fn_AppendFakeID.bdid(L.cname, L.prim_range, L.prim_name, L.v_city_name, L.st, l.zip, L.cust_name);
	v_did				:= prte2.fn_AppendFakeID.did(L.fname, L.lname, L.link_ssn, L.link_dob, L.cust_name);
	self.b_did 	:= intformat(v_bdid,12,1);
	self.did	 	:= intformat(v_did,12,1);

	vLinkingIds := prte2.fn_AppendFakeID.LinkIds(L.cname, L.link_fein, L.link_inc_date, L.prim_range, L.prim_name, L.sec_range, L.v_city_name, L.st, L.zip, L.cust_name);
	self.powid	:= vLinkingIds.powid;
	self.proxid	:= vLinkingIds.proxid;
	self.seleid	:= vLinkingIds.seleid;
	self.orgid	:= vLinkingIds.orgid;
	self.ultid	:= vLinkingIds.ultid;
	self := L;
	self := [];
end;
	
dsFileCln := project(dCleanAddressAppended,trecs1(left));

//Concatenate Files
combine_file := dsFileCln + Orig_recs;

//Create Base Files
layouts.Base	xform_base(temp_layout l) := transform
	self.did 										:= (integer)l.did;
	self.bdid										:= (integer)l.b_did;
	self.drivers_license_number := l.driver_license_nbr;
	self.ssn										:= l.link_ssn;
	self.date_of_birth					:= l.dob;
	self := l; 
	self := [];
end;	

basefile := project(combine_file, xform_base(left)); 
																					
																					
file_0 	:= project(combine_file, transform(layouts.base_flCrash0,  self.rec_type_o 	:= '0', 
																																	self.accident_nbr := left.l_accnbr;
																																	self := left;
																																	self := [];
																																	));

layouts.base_flCrash0 	xform_0(file_0 L, file_0 R)	:= transform
	self.microfilm_nbr	:= if(l.microfilm_nbr <> '', l.microfilm_nbr, r.microfilm_nbr);
	self.city_nbr				:= if(l.city_nbr <> '', l.city_nbr, r.city_nbr);
	self.ft_city_town		:= if(l.ft_city_town <> '', l.ft_city_town, r.ft_city_town);
	self.filler4				:= if(l.filler4 <> '', l.filler4, r.filler4);
	self.dot_county			:= if(l.dot_county <> '', l.dot_county, r.dot_county);
	self := L;
end;

file_0_rollup := rollup(sort(file_0, accident_nbr),
															left.accident_nbr		=	right.accident_nbr and
															left.accident_date 	=	right.accident_date,
																	xform_0(left, right));

												
file_1 	:= dedup(sort(project(combine_file, transform(layouts.base_flCrash1, self.rec_type_1 := '1', 
																																 self.accident_nbr := left.l_accnbr;
																																 self.filler4 := '';
																																 self := left;
																																 self := [];
																																 )), accident_nbr), record, all);


layouts.base_flCrash1 	xform_1(file_1 L, file_1 R)	:= transform
	self.day_week								:= if(l.day_week <> '', l.day_week, r.day_week);
	self.second_contrib_cause		:= if(l.second_contrib_cause <> '', l.second_contrib_cause, r.second_contrib_cause);
	self := L;
end;


file_1_roilup	:= rollup(sort(file_1, accident_nbr),
															left.accident_nbr		=	right.accident_nbr, 
																	xform_1(left, right));
																	
																	
																	
//Mapping linkid, did, bdid, clean name/address, associated vehicle data fields
layouts.Base_flcrash2v		xform_2(combine_file L) := transform
	self.rec_type_2 							:= '2';
	self.accident_nbr 						:= L.l_accnbr;
	self.vehicle_owner_name 			:= L.orig_full_name;
	self.vehicle_owner_address		:= L.orig_street_address1;

//parsing raw addressess
	v_city := L.orig_street_address2[..STD.Str.Find(L.orig_street_address2,',',1)-1];
	state_zip := STD.Str.CleanSpaces(L.orig_street_address2[length(v_city)+2..]);
	v_state := state_zip[..2];
	v_zip := STD.Str.CleanSpaces(state_zip[length(v_state)+1..]);
	self.vehicle_owner_st_city 		:= v_city;
	self.vehicle_owner_st					:= v_state;
	self.vehicle_owner_zip				:= v_zip;
	self.filler4 									:= '';
	self.ins_company_name					:= L.insurance_company_standardized;
	self.ins_policy_nbr						:= L.policy_num;
	self.vehicle_owner_dl_nbr			:= L.driver_license_nbr;
	self.vehicle_owner_dob				:= L.link_dob;
	self.vehicle_tag_nbr					:= L.tag_nbr;
	self.vehicle_reg_state				:= L.tagnbr_st;
	self.vehicle_id_nbr						:= L.vin;
	self := l;	
	self := [];
end;

file_2	:= dedup(sort(project(combine_file(record_type = 'VEHICLE OWNER' or orig_full_name <> ''), xform_2(left)), accident_nbr), record, all);


layouts.base_flcrash3v	xform_3(combine_file L) := transform
	self.rec_type_3 										:= '3',
	self.accident_nbr 									:= L.l_accnbr;
	self.towed_trlr_veh_owner_name 			:= L.orig_full_name;
	
	//parsing original city,st,zip field
	v_city := L.orig_street_address2[..STD.Str.Find(L.orig_street_address2,',',1)-1];
	state_zip := STD.Str.CleanSpaces(L.orig_street_address2[length(v_city)+2..]);
	v_state := state_zip[..2];
	v_zip := STD.Str.CleanSpaces(state_zip[length(v_state)+1..]);
	self.towed_trlr_veh_owner_st_city		:= v_city;
	self.towed_trlr_veh_owner_st				:= v_state;
	self.towed_trlr_veh_owner_zip				:= v_zip;
	self := L;
	self := [];
end;

file_3 	:= dedup(sort(project(combine_file(record_type = 'VEHICLE OWNER' or orig_full_name <> ''), xform_3(left)), accident_nbr), record, all); 
																																				

set_generation := ['II','11','2ND','III','111','3RD','IV','1V','4TH','FOURTH','JR','JUNIOR','SECOND','SENIOR','SR'];
layouts.base_flcrash4		xform_4(combine_file L) := transform
	self.rec_type_4		:= '4';
	self.accident_nbr 					:= L.l_accnbr;
	self.score									:= if(l.did <> '', (string)l.did_score,'');
	self.driver_dl_nbr					:= L.driver_license_nbr;
	self.driver_lic_st					:= L.dlnbr_st;
	self.driver_lic_type				:= if(L.driver_lic_type = '','0',L.driver_lic_type);
	
	//Parsing Original Address2
	v_city				:= L.orig_street_address2[..STD.Str.Find(L.orig_street_address2,',',1)-1];
	temp_address2 := STD.Str.CleanSpaces(L.orig_street_address2[length(v_city)+2..]);
	v_state				:= temp_address2[1..2];
	v_zipcode			:= STD.Str.CleanSpaces(temp_address2[length(v_state)+1..]);
	
	self.driver_address					:= l.orig_street_address1;
	self.driver_st_city					:= if(L.driver_st_city = '', v_city, L.driver_st_city);
	self.driver_resident_state	:= if(L.driver_resident_state = '', v_state, L.driver_resident_state);
	self.driver_zip							:= if(L.driver_zip = '', v_zipcode, L.driver_zip);
	self.driver_full_name				:= L.driver_full_name;
	self.driver_name_suffix			:= if(L.driver_name_suffix in set_generation, L.driver_name_suffix,''); 
	self.driver_dob							:= L.driver_dob;
	self.driver_injury_severity	:= L.driver_injury_severity;
	self.first_driver_safety		:= L.first_driver_safety;
	self.second_driver_safety		:= L.second_driver_safety;
	self.driver_eject_code			:= L.driver_eject_code;
	self.recommand_reexam				:= L.recommand_reexam;
	self.driver_physical_defects	:= L.driver_physical_defects;
	self.first_contrib_cause		:= L.first_contrib_cause;
	self.second_contrib_cause		:= L.second_contrib_cause;
	self.third_contrib_cause		:= L.third_contrib_cause;
	self.req_endorsement				:= if(L.req_endorsement = '', '0', L.req_endorsement);
	self.driver_phone_nbr				:= L.driver_phone_nbr;
	self.driver_bac_test_type		:= L.driver_bac_test_type;
	self.driver_alco_drug_code	:= L.driver_alco_drug_code;
	self.driver_residence				:= L.driver_residence;
	self.driver_race						:= L.driver_race;
	self.driver_sex							:= L.driver_sex;
	self.filler4 := '';	
	self.ins_company_name				:= L.insurance_company_standardized;
	self.ins_policy_nbr					:= L.policy_num;
	self := L;
	self := [];
end;	

file_4	:= dedup(sort(project(combine_file(record_type = 'VEHICLE DRIVER' or driver_full_name <> ''), xform_4(left)), accident_nbr), record, all);
																					
																
layouts.base_flcrash5		xform_5(combine_file L) := transform
	self.rec_type_5 						:= '5';
	self.accident_nbr 					:= L.l_accnbr;
	self.passenger_nbr					:= L.passenger_nbr;
	self.passenger_full_name 		:= L.passenger_full_name;
																			
	// parsing address fields
	v_street := L.passenger_st_city[..STD.Str.Find(L.passenger_st_city,',',1)-1];
	self.passenger_address			:= v_street;
	self.passenger_st_city			:= L.passenger_st_city;
	self.passenger_state				:= L.passenger_state;
	self.passenger_zip					:= L.passenger_zip;
	self.passenger_age					:= L.passenger_age;
	self.passenger_location			:= L.passenger_location;
	self.first_passenger_safe		:= L.first_passenger_safe;
	self.second_passenger_safe	:= L.second_passenger_safe;
	self.passenger_eject_code		:= L.passenger_eject_code;
	self := L;
	self := [];
end;
	
file_5	:= dedup(sort(project(combine_file(record_type = 'PASSENGER' or passenger_full_name <> ''), xform_5(left)), accident_nbr), record, all);
											
																

file_6 := project(combine_file(record_type = 'PEDESTRIAN'), transform(layouts.base_flcrash6,	
																																		self.rec_type_6 	:= '6', 
																																		self.accident_nbr := left.l_accnbr;
																																		self := left;
																																		self := [];));

layouts.base_flcrash7		xform_7(combine_file L)	:= transform
	self.rec_type_7 					:= '7';
	self.accident_nbr 				:= L.l_accnbr;
	self.prop_owner_name			:= L.orig_full_name;
						
	//parsing raw addressess
	v_city := L.orig_street_address2[..STD.Str.Find(L.orig_street_address2,',',1)-1];
	state_zip := STD.Str.CleanSpaces(L.orig_street_address2[length(v_city)+2..]);
	v_state := state_zip[..2];
	v_zip := STD.Str.CleanSpaces(state_zip[length(v_state)+1..]);
	self.prop_owner_address		:= L.orig_street_address1;
	self.prop_owner_st_city		:= v_city;
	self.prop_owner_state			:= v_state;
	self.prop_owner_zip				:= v_zip;
	self.prop_damage_amount		:= L.total_prop_damage_amt;
	self := L;
	self := [];
end;	

file_7 := dedup(sort(project(combine_file(record_type ='PROPERTY OWNER'), xform_7(left)), accident_nbr), record, all);

file_8 := project(combine_file, transform(layouts.base_flcrash8, self.rec_type_8 := '8', self.accident_nbr := left.l_accnbr; self := left,self := []));
file_9 := project(combine_file(record_type = 'WITNESS'), transform(layouts.base_flcrash9, self.rec_type_9 := '9', self.accident_nbr := left.l_accnbr; self := left,self := []));

////////////////////////////////////////////////////////////////////////////////////////
// Output Files
////////////////////////////////////////////////////////////////////////////////////////
PromoteSupers.MAC_SF_BuildProcess(basefile,Constants.base_prefix_name, base_file,,,true);
PromoteSupers.MAC_SF_BuildProcess(file_0_rollup,Constants.base_prefix_ecrash+ '0', ecrash0,,,true);
PromoteSupers.MAC_SF_BuildProcess(file_1_roilup,Constants.base_prefix_ecrash+ '1', ecrash1,,,true);
PromoteSupers.MAC_SF_BuildProcess(file_2,Constants.base_prefix_ecrash+ '2', ecrash2,,,true);
PromoteSupers.MAC_SF_BuildProcess(file_3,Constants.base_prefix_ecrash+ '3', ecrash3,,,true);
PromoteSupers.MAC_SF_BuildProcess(file_4,Constants.base_prefix_ecrash+ '4', ecrash4,,,true);
PromoteSupers.MAC_SF_BuildProcess(file_5,Constants.base_prefix_ecrash+ '5', ecrash5,,,true);
PromoteSupers.MAC_SF_BuildProcess(file_6(pedest_full_name <> ''),Constants.base_prefix_ecrash+ '6', ecrash6,,,true);
PromoteSupers.MAC_SF_BuildProcess(file_7,Constants.base_prefix_ecrash+ '7', ecrash7,,,true);
PromoteSupers.MAC_SF_BuildProcess(file_8(carrier_name <> ''),Constants.base_prefix_ecrash+ '8', ecrash8,,,true);
PromoteSupers.MAC_SF_BuildProcess(file_9(witness_full_name <> ''),Constants.base_prefix_ecrash+ '9', ecrash9,,,true);

export PROC_BUILD_BASE := sequential(base_file,ecrash0,ecrash1,ecrash2,ecrash3,ecrash4,ecrash5,ecrash6,ecrash7,ecrash8,ecrash9);