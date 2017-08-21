//
wuid := '20091130';
//
my_bdids := dedup(sort(demo_data.base_files.file_demo_data_bdids(bdid<>0),record),all);
my_dids  := dedup(sort(demo_data.base_files.file_demo_data_dids(did<>0),record),all);
//
file_lookups 				:= demo_data.base_files.file_lookups; //done
file_headers  			:= demo_data.base_files.file_headers; //done
file_header_quick  	:= demo_data.base_files.file_header_quick; //done
file_relatives 			:= demo_data.base_files.file_relatives; //done
file_util	 					:= demo_data.base_files.file_util; //done
file_watchdog_best	:= demo_data.base_files.file_watchdog_best; //done
//
file_business_contacts_plus := demo_data.base_files.file_business_contacts_plus; //done
file_business_relatives 	:= demo_data.base_files.file_business_relatives; //done
file_business_relatives_group := demo_data.base_files.file_business_relatives_group; //done
File_Business_Header_Base 	:= demo_data.base_files.File_Business_Header_Base; //done
File_Business_Header_best 	:= demo_data.base_files.File_Business_Header_best; //done
//
file_corpdata 				:= demo_data.base_files.file_corpdata; //done
file_contdata 				:= demo_data.base_files.file_contdata; //done
file_eventdata 				:= demo_data.base_files.file_eventdata; //done
file_stockdata 				:= demo_data.base_files.file_stockdata; //done
file_ardata 				:= demo_data.base_files.file_ardata; //done
//
file_did_death_masterv2 		:= demo_data.base_files.File_Did_Death_MasterV2; //TODO
//
file_dl_searchv2		 		:= demo_data.base_files.file_dl_searchv2; //done
//
file_gongbase			 		:= demo_data.base_files.file_gongbase; // done
file_gonghist			 		:= demo_data.base_files.file_gonghist; // done
//
file_ln_propertyv2_file_search_did  	:= demo_data.base_files.file_ln_propertyv2_File_Search_DID; //done
file_ln_propertyv2_file_deed 			:= demo_data.base_files.file_ln_propertyv2_File_Deed; //done
file_ln_propertyv2_file_assessment  	:= demo_data.base_files.file_ln_propertyv2_File_Assessment; //done
file_ln_propertyv2_file_addl_fares_deed := demo_data.base_files.file_ln_propertyv2_File_addl_fares_deed; //done
file_ln_propertyv2_file_addl_fares_tax 	:= demo_data.base_files.file_ln_propertyv2_File_addl_fares_tax; //done
file_ln_propertyv2_file_addl_legal		:= demo_data.base_files.file_ln_propertyv2_File_addl_legal; //done
//
file_vehiclev2_main := demo_data.base_files.file_vehiclev2_main; //done
file_vehiclev2_party:= demo_data.base_files.file_vehiclev2_party;  //done 
//
file_bankruptcy_search 	:= demo_data.base_files.file_bankruptcy_search; //TODO
file_bankruptcy_main 	:= demo_data.base_files.file_bankruptcy_main; //TODO
//
file_bankruptcy_search_v3 	:= demo_data.base_files.file_bankruptcy_search_v3; //TODO
file_bankruptcy_main_v3 	:= demo_data.base_files.file_bankruptcy_main_v3; //TODO
//
file_proflic_base 	:= demo_data.base_files.file_ProfLic_Base; //done
//
file_ccw_base 		:= demo_data.base_files.file_ccw_base; //done
file_voters_base	:= demo_data.base_files.file_voters_base; //done
file_votersv2_base	:= demo_data.base_files.file_votersv2_base; //done
file_hvccw_base 	:= demo_data.base_files.file_hvccw_base; //done
//
file_foreclosure 	:= demo_data.base_files.file_foreclosure; // done
file_foreclosure2 := demo_data.base_files.file_foreclosure2;	// new "base file" from autokey/roxie migration

//
file_liens_main 	:= demo_data.base_files.file_liens_main; //done
file_liens_party 	:= demo_data.base_files.file_liens_party; //done
//
file_mar_div_search := demo_data.base_files.file_mar_div_search; //TODO
file_mar_div_base 	:= demo_data.base_files.file_mar_div_base; //TODO
//
file_uccv2_main_base 	:= demo_data.base_files.File_UCCv2_Main_Base; // done
file_uccv2_party_base	:= demo_data.base_files.File_UCCv2_Party_Base; // done
file_uccv2_party_name	:= demo_data.base_files.File_UCCv2_Party_Name; // done
//
file_offenders_keybuilding 		:= 	demo_data.base_files.file_offenders_keybuilding; //done
file_offenses_keybuilding 		:= 	demo_data.base_files.file_offenses_keybuilding; //done
file_courtoffenses_keybuilding 	:= 	demo_data.base_files.file_courtoffenses_keybuilding; //done
file_activity_keybuilding 		:= 	demo_data.base_files.file_activity_keybuilding; //done
file_punishment_keybuilding 	:= 	demo_data.base_files.file_punishment_keybuilding; //done
//
file_so_main		:= demo_data.base_files.file_so_main;
file_so_offenses 	:= demo_data.base_files.file_so_offenses;
//
file_phonesplus_base := demo_data.base_files.file_phonesplus_base;
file_qsent_base	:= demo_data.base_files.file_qsent_base;
file_neustar := demo_data.base_files.file_neustar;
//
file_watercraft_base_coastguard := demo_data.base_files.file_watercraft_base_coastguard;
file_watercraft_base_main				:= demo_data.base_files.file_watercraft_base_main;
file_watercraft_base_search			:= demo_data.base_files.file_watercraft_base_search;
//
file_whois_base			:= demo_data.base_files.file_whois_base;
//
file_atf_firearms_explosives_base := demo_data.base_files.file_atf_firearms_explosives_base;
//
file_dea_doxie := demo_data.base_files.file_dea_doxie;
file_dea_modified := demo_data.base_files.file_dea_modified;
//
file_faa_aircraft_registration := demo_data.base_files.file_faa_aircraft_registration;
file_faa_airmen_data := demo_data.base_files.file_faa_airmen_data;
file_faa_airmen_certificate := demo_data.base_files.file_airmen_certificate;
//
file_fl_crash0 := demo_data.base_files.file_fl_crash0;
file_fl_crash1 := demo_data.base_files.file_fl_crash1;
file_fl_crash2v := demo_data.base_files.file_fl_crash2v;
file_fl_crash3v := demo_data.base_files.file_fl_crash3v;
file_fl_crash4 := demo_data.base_files.file_fl_crash4;
file_fl_crash5 := demo_data.base_files.file_fl_crash5;
file_fl_crash6 := demo_data.base_files.file_fl_crash6;
file_fl_crash7 := demo_data.base_files.file_fl_crash7;
file_fl_crash8 := demo_data.base_files.file_fl_crash8;
file_fl_crash_did := demo_data.base_files.file_fl_crash_did;
//
file_paw := demo_data.base_files.file_paw;

file_official_documents:=demo_data.base_files.file_official_records_document_base;
file_official_party:=demo_data.base_files.file_official_records_party_base;

file_civil_party_base := demo_data.base_files.file_civil_court_party_base(case_key <> '');
file_civil_matters_base := demo_data.base_files.file_civil_court_matter_base(case_key <> '');

//
// round 3 list starts here
//
file_patriot 			:= demo_data.base_files.file_patriot;
key_did_patriot 	:= demo_data.base_files.key_did_patriot;
key_bdid_patriot 	:= demo_data.base_files.key_bdid_patriot;
//
file_yellow_pages:= demo_data.base_files.file_yellow_pages;		// a persist???
//
file_bbb2_nonmember:= demo_data.base_files.file_bbb2_nonmember;
file_bbb2_member   := demo_data.base_files.file_bbb2_member;
//
File_BusReg_Company := demo_data.base_files.File_BusReg_Company;
File_BusReg_Contact := demo_data.base_files.File_BusReg_Contact;
//
file_dnb_base := demo_data.base_files.File_DNB_Base;
file_dnb_contacts_base := demo_data.base_files.File_DNB_Contacts_Base;
//
file_ebr_0010 := demo_data.base_files.File_ebr_0010;
file_ebr_1000 := demo_data.base_files.File_ebr_1000;
file_ebr_2000 := demo_data.base_files.File_ebr_2000;
file_ebr_2015 := demo_data.base_files.File_ebr_2015;
file_ebr_2025 := demo_data.base_files.File_ebr_2025;
file_ebr_4010 := demo_data.base_files.File_ebr_4010;
file_ebr_4020 := demo_data.base_files.File_ebr_4020;
file_ebr_4030 := demo_data.base_files.File_ebr_4030;
file_ebr_4035 := demo_data.base_files.File_ebr_4035;
file_ebr_4040 := demo_data.base_files.File_ebr_4040;
file_ebr_4500 := demo_data.base_files.File_ebr_4500;
file_ebr_4510 := demo_data.base_files.File_ebr_4510;
file_ebr_5000 := demo_data.base_files.File_ebr_5000;
file_ebr_5600 := demo_data.base_files.File_ebr_5600;
file_ebr_5610 := demo_data.base_files.File_ebr_5610;
file_ebr_6000 := demo_data.base_files.File_ebr_6000;
file_ebr_6500 := demo_data.base_files.File_ebr_6500;
file_ebr_6510 := demo_data.base_files.File_ebr_6510;
file_ebr_7000 := demo_data.base_files.File_ebr_7000;
file_ebr_7010 := demo_data.base_files.File_ebr_7010;
//
file_pcnsr:= demo_data.base_files.file_pcnsr;
//
file_globalwatchlists := demo_data.base_files.file_globalwatchlists;

file_fbnv2_business := demo_data.base_files.file_fbnv2_business;
file_fbnv2_contact  := demo_data.base_files.file_fbnv2_contact;

file_bdl2_base := demo_data.base_files.file_bdl2_base;

// extracts start here
//

// file_lookups to_get_file_lookups(file_lookups l,my_dids r) := transform 
// self := l;
// end;
// my_lookups := join(file_lookups, my_dids,left.did=right.did,to_get_file_lookups(left,right), lookup);
// output(my_lookups ,,'~thor_200::base::demo_data_file_lookups'+wuid,overwrite);

// file_headers to_get_file_headers(file_headers l, my_dids r) := transform
// self := l;
// end;
// my_headers := join(file_headers, my_dids,left.did=right.did,to_get_file_headers(left,right), lookup);
// output(my_headers ,,'~thor_200::base::demo_data_file_headers'+wuid,overwrite);

// file_header_quick to_get_file_header_quick(file_header_quick l, my_dids r) := transform
// self := l;
// end;
// my_header_quick := join(file_header_quick, my_dids,left.did=right.did,to_get_file_header_quick(left,right), lookup);
// output(my_header_quick ,,'~thor_200::base::demo_data_file_header_quick'+wuid,overwrite);

// file_relatives to_get_file_relatives(file_relatives l, my_dids r) := transform
// self := l;
// end; 
// my_relatives1 := join(file_relatives, my_dids,left.person1=right.did,to_get_file_relatives(left,right), lookup);
// my_relatives2 := join(file_relatives, my_dids,left.person2=right.did,to_get_file_relatives(left,right), lookup);
// my_relatives := dedup(sort(my_relatives1+my_relatives2,record),record);
// output(my_relatives ,,'~thor_200::base::demo_data_file_relatives'+wuid,overwrite);

// file_util to_get_file_util(file_util l,my_dids r) := transform
// self := l;
// end;
// my_util := join(file_util, my_dids,(unsigned6) left.did=right.did,to_get_file_util(left,right), lookup);
// output(my_util ,,'~thor_200::base::demo_data_file_util'+wuid,overwrite);

// file_watchdog_best to_get_file_watchdog_best(file_watchdog_best l, my_dids r) := transform
// self := l;
// end;
// my_watchdog_best := join(file_watchdog_best, my_dids, left.did=right.did, to_get_file_watchdog_best(left,right),lookup);
// output(my_watchdog_best ,,'~thor_200::base::demo_data_file_watchdog_best'+wuid,overwrite);

// file_did_death_masterv2 to_get_file_did_death_masterv2(file_did_death_masterv2 l, my_dids r) := transform
// self := l;
// end;
// my_did_death_masterv2 := join(file_did_death_masterv2,my_dids,(unsigned) left.did=right.did,to_get_file_did_death_masterv2(left,right),lookup);
// output(my_did_death_masterv2 ,,'~thor_200::base::demo_data_file_did_death_masterv2'+wuid,overwrite);

// file_dl_searchv2 to_get_file_dl_searchv2(file_dl_searchv2 l, my_dids r) := transform
// self := l;
// end;
// my_dl_searchv2 := join(file_dl_searchv2,my_dids,left.did=right.did,to_get_file_dl_searchv2(left,right),lookup);
// output(my_dl_searchv2 ,,'~thor_200::base::demo_data_file_dl_searchv2'+wuid,overwrite);


// file_gonghist to_get_file_gonghist_dids(file_gonghist l, my_dids r) := transform
// self := l;
// end;
// my_gonghist_dids := join(file_gonghist, my_dids,left.did=right.did,to_get_file_gonghist_dids(left,right), lookup);
// file_gonghist to_get_file_gonghist_bdids(file_gonghist l, my_bdids r) := transform
// self := l;
// end;
// my_gonghist_bdids := join(file_gonghist, my_bdids,left.bdid=right.bdid,to_get_file_gonghist_bdids(left,right), lookup);

// my_gonghist_zip := file_gonghist(z5='48009');

// my_gonghist_t := my_gonghist_dids+my_gonghist_bdids+my_gonghist_zip;
// file_gonghist to_get_file_gonghist_phone(file_gonghist l, my_gonghist_t r) := transform
// self := l;
// end;
// my_gonghist_phone := join(file_gonghist(phone10<>''),my_gonghist_t ,left.phone10=right.phone10,to_get_file_gonghist_phone(left,right), lookup);

// my_gonghist := dedup(sort(distribute(my_gonghist_phone+my_gonghist_dids+my_gonghist_bdids+my_gonghist_zip,hash(phone10)),record,local),all,local);

// output(my_gonghist ,,'~thor_200::base::demo_data_file_gonghist'+wuid,overwrite);



// my_official_party_county:= choosen(file_official_party(state_origin in ['MI','OH','FL']),1000);	// NO ZIP AVAIL
// my_official_party_t:=my_official_party_county;
// my_official_party_sort:=dedup(sort(distribute(my_official_party_t(official_record_key<>''), hash(official_record_key)),official_record_key, LOCAL));
// file_official_party to_get_official_party_final(file_official_party L, my_official_party_sort R):=TRANSFORM
// self:=L;
// END;
// my_official_party_final:=join(file_official_party,my_official_party_sort,left.official_record_key = right.official_record_key,to_get_official_party_final(LEFT,RIGHT),LOOKUP);
// output(my_official_party_final ,,'~thor_200::base::demo_data_file_official_party'+wuid,overwrite);


// file_official_documents  to_get_official_documents_final(file_official_documents L, my_official_party_sort R):=TRANSFORM
// self:=L;
// END;
// my_official_documents_final:=join(file_official_documents,my_official_party_sort, left.official_record_key = right.official_record_key,
      // to_get_official_documents_final(LEFT,RIGHT),lookup);
// output(my_official_documents_final ,,'~thor_200::base::demo_data_file_official_documents'+wuid,overwrite);	  

// filtered_civil_matters_for_michigan:= file_civil_matters_base(state_origin = 'MI');
// filtered_civil_matters_random:=ENTH(file_civil_matters_base, 5,100,1);
// my_civil_matters:=filtered_civil_matters_for_michigan+ filtered_civil_matters_random;
// my_civil_matters_final:=dedup(sort(distribute(my_civil_matters,hash(case_key)),case_key,LOCAL));

// recordof(file_civil_party_base) get_civil_party(file_civil_party_base L, my_civil_matters_final R):= TRANSFORM
// self:=L;
// END;
// my_civil_party_final:=join(file_civil_party_base, my_civil_matters_final,left.case_key=right.case_key, get_civil_party(LEFT,RIGHT),LOOKUP);
// output(my_civil_party_final ,,'~thor_200::base::demo_data_file_civil_party'+wuid,overwrite);	  
// output(my_civil_matters_final ,,'~thor_200::base::demo_data_file_civil_matters'+wuid,overwrite);	  


// file_gongbase to_get_file_gongbase(file_gongbase l, my_gonghist r) := transform
// self := l;
// end;
// my_gongbase_phone := join(file_gongbase(phoneno<>''), my_gonghist,left.phoneno=right.phone10,to_get_file_gongbase(left,right), lookup);

// my_gongbase_zip := file_gongbase(z5='48009');

// my_gongbase := dedup(sort(distribute(my_gongbase_phone+my_gongbase_zip,hash(phoneno)),record,local),all,local);

// output(my_gongbase ,,'~thor_200::base::demo_data_file_gongbase'+wuid,overwrite);


// file_ln_propertyv2_file_search_did to_get_file_ln_propertyv2_file_search_did_d(file_ln_propertyv2_file_search_did l, my_dids r) := transform
// self := l;
// end;
// my_ln_propertyv2_file_search_did_d := join(file_ln_propertyv2_file_search_did, my_dids, left.did=right.did, to_get_file_ln_propertyv2_file_search_did_d(left,right), lookup);

// file_ln_propertyv2_file_search_did to_get_file_ln_propertyv2_file_search_did_b(file_ln_propertyv2_file_search_did l, my_bdids r) := transform
// self := l;
// end;
// my_ln_propertyv2_file_search_did_b := join(file_ln_propertyv2_file_search_did, my_bdids, left.bdid=right.bdid, to_get_file_ln_propertyv2_file_search_did_b(left,right), lookup);

// my_ln_propertyv2_file_search_zip := file_ln_propertyv2_file_search_did(zip='48009');	// avm block 

// my_ln_propertyv2_file_search_did := dedup(sort(my_ln_propertyv2_file_search_did_b+my_ln_propertyv2_file_search_did_d+my_ln_propertyv2_file_search_zip,record),all);
 

// output(my_ln_propertyv2_file_search_did ,,'~thor_200::base::demo_data_file_ln_propertyv2_file_search_did'+wuid,overwrite);

// file_ln_propertyv2_file_deed to_get_file_ln_propertyv2_file_deed(file_ln_propertyv2_file_deed l, my_ln_propertyv2_file_search_did r):= transform
// self := l;
// end;
// my_ln_propertyv2_file_deed := join(file_ln_propertyv2_file_deed, my_ln_propertyv2_file_search_did, left.ln_fares_id=right.ln_fares_id, to_get_file_ln_propertyv2_file_deed(left,right), lookup);
// output(my_ln_propertyv2_file_deed ,,'~thor_200::base::demo_data_file_ln_propertyv2_file_deed'+wuid,overwrite);

// file_ln_propertyv2_file_assessment to_get_file_ln_propertyv2_file_assessment(file_ln_propertyv2_file_assessment l, my_ln_propertyv2_file_search_did r):= transform
// self := l;
// end;
// my_ln_propertyv2_file_assessment := join(file_ln_propertyv2_file_assessment, my_ln_propertyv2_file_search_DID, left.ln_fares_id=right.ln_fares_id, to_get_file_ln_propertyv2_file_assessment(left,right), lookup);
// output(my_ln_propertyv2_file_assessment ,,'~thor_200::base::demo_data_file_ln_propertyv2_file_assessment'+wuid,overwrite);

// file_ln_propertyv2_file_addl_fares_deed to_get_file_ln_propertyv2_file_addl_fares_deed(file_ln_propertyv2_file_addl_fares_deed l, my_ln_propertyv2_file_search_did r):= transform
// self := l;
// end;
// my_ln_propertyv2_file_addl_fares_deed := join(file_ln_propertyv2_file_addl_fares_deed, my_ln_propertyv2_file_search_did, left.ln_fares_id=right.ln_fares_id, to_get_file_ln_propertyv2_file_addl_fares_deed(left,right), lookup);
// output(my_ln_propertyv2_file_addl_fares_deed ,,'~thor_200::base::demo_data_file_ln_propertyv2_file_addl_fares_deed'+wuid,overwrite);

// file_ln_propertyv2_file_addl_fares_tax to_get_file_ln_propertyv2_file_addl_fares_tax(file_ln_propertyv2_file_addl_fares_tax l, my_ln_propertyv2_file_search_did r):= transform
// self := l;
// end;
// my_ln_propertyv2_file_addl_fares_tax := join(file_ln_propertyv2_file_addl_fares_tax, my_ln_propertyv2_file_search_did, left.ln_fares_id=right.ln_fares_id, to_get_file_ln_propertyv2_file_addl_fares_tax(left,right), lookup);
// output(my_ln_propertyv2_file_addl_fares_tax ,,'~thor_200::base::demo_data_file_ln_propertyv2_file_addl_fares_tax'+wuid,overwrite);

// file_ln_propertyv2_file_addl_legal to_get_file_ln_propertyv2_file_addl_legal(file_ln_propertyv2_file_addl_legal l, my_ln_propertyv2_file_search_did r):= transform
// self := l;
// end;
// my_ln_propertyv2_file_addl_legal := join(file_ln_propertyv2_file_addl_legal, my_ln_propertyv2_file_search_did, left.ln_fares_id=right.ln_fares_id, to_get_file_ln_propertyv2_file_addl_legal(left,right), lookup);
// output(my_ln_propertyv2_file_addl_legal,,'~thor_200::base::demo_data_file_ln_propertyv2_file_addl_legal'+wuid,overwrite);

// file_vehiclev2_party   to_get_file_vehiclev2_party_d(file_vehiclev2_party l, my_dids r) := transform
// self := l;
// end;
// my_vehiclev2_party_d := join(file_vehiclev2_party, my_dids, left.append_did=right.did, to_get_file_vehiclev2_party_d(left,right), lookup);
// file_vehiclev2_party   to_get_file_vehiclev2_party_b(file_vehiclev2_party l, my_bdids r) := transform
// self := l;
// end;
// my_vehiclev2_party_b := join(file_vehiclev2_party, my_bdids, left.append_bdid=right.bdid, to_get_file_vehiclev2_party_b(left,right), lookup);
// my_vehiclev2_party := dedup(sort(my_vehiclev2_party_d+my_vehiclev2_party_b,record),all);
// output(my_vehiclev2_party,,'~thor_200::base::demo_data_file_vehiclev2_party'+wuid,overwrite);

// file_vehiclev2_main to_get_file_vehiclev2_main(file_vehiclev2_main l, my_vehiclev2_party r) := transform
// self := l;
// end;
// my_vehiclev2_main := join(file_vehiclev2_main, my_vehiclev2_party, left.vehicle_key=right.vehicle_key, to_get_file_vehiclev2_main(left,right), lookup);
// output(my_vehiclev2_main,,'~thor_200::base::demo_data_file_vehiclev2_main'+wuid,overwrite);

// file_liens_party to_get_file_liens_party_d(file_liens_party l, my_dids r) := transform
// self := l;
// end;
// my_liens_party_d := join(file_liens_party, my_dids, (unsigned) left.did=right.did,to_get_file_liens_party_d(left,right), lookup);
// file_liens_party to_get_file_liens_party_b(file_liens_party l, my_bdids r) := transform
// self := l;
// end;
// my_liens_party_b := join(file_liens_party, my_bdids, (unsigned) left.bdid=right.bdid,to_get_file_liens_party_b(left,right), lookup);
// my_liens_party := dedup(sort(my_liens_party_b+my_liens_party_d,record),all);
// output(my_liens_party,,'~thor_200::base::demo_data_file_liens_party'+wuid,overwrite);

// file_liens_main  to_get_file_liens_main(file_liens_main l, my_liens_party r) := transform
// self := l;
// end;
// my_liens_main := join(file_liens_main, my_liens_party, left.tmsid=right.tmsid, to_get_file_liens_main(left,right), lookup);
// output(my_liens_main,,'~thor_200::base::demo_data_file_liens_main'+wuid,overwrite);

// file_proflic_base to_get_file_proflic_base(file_proflic_base l, my_dids r) := transform
// self := l;
// end;
// my_proflic_base := join(file_proflic_base, my_dids, (unsigned) left.did=right.did,to_get_file_proflic_base(left,right), lookup);
// output(my_proflic_base,,'~thor_200::base::demo_data_file_proflic_base'+wuid,overwrite);

// file_ccw_base to_get_file_ccw_base(file_ccw_base l, my_dids r) := transform
// self := l;
// end;
// my_ccw_base := join(file_ccw_base, my_dids, (unsigned) left.did_out=right.did,to_get_file_ccw_base(left,right), lookup);
// output(my_ccw_base,,'~thor_200::base::demo_data_file_ccw_base'+wuid,overwrite);

// file_voters_base to_get_file_voters_base(file_voters_base l, my_dids r) := transform
// self := l;
// end;
// my_voters_base := join(file_voters_base, my_dids, (unsigned) left.did_out=right.did,to_get_file_voters_base(left,right), lookup);
// output(my_voters_base,,'~thor_200::base::demo_data_file_voters_base'+wuid,overwrite);

// file_votersv2_base to_get_file_votersv2_base(file_votersv2_base l, my_dids r) := transform
// self := l;
// end;
// my_votersv2_base := join(file_votersv2_base, my_dids, left.did=right.did,to_get_file_votersv2_base(left,right), lookup);
// output(my_votersv2_base,,'~thor_200::base::demo_data_file_votersv2_base'+wuid,overwrite);

// file_hvccw_base to_get_file_hvccw_base(file_hvccw_base l, my_dids r) := transform
// self := l;
// end;
// my_hvccw_base := join(file_hvccw_base, my_dids, (unsigned) left.did_out=right.did,to_get_file_hvccw_base(left,right), lookup);
// output(my_hvccw_base,,'~thor_200::base::demo_data_file_hvccw_base'+wuid,overwrite);


// file_foreclosure to_get_file_foreclosure_d(file_foreclosure l, my_dids r) := transform
// self := l;
// end;
// my_foreclosure_d1 := join(file_foreclosure,my_dids(did<>0), (integer) left.name1_did=right.did , to_get_file_foreclosure_d(left,right), lookup);
// my_foreclosure_d2 := join(file_foreclosure,my_dids(did<>0), (integer) left.name2_did=right.did , to_get_file_foreclosure_d(left,right), lookup);
// my_foreclosure_d3 := join(file_foreclosure,my_dids(did<>0), (integer) left.name3_did=right.did , to_get_file_foreclosure_d(left,right), lookup);
// my_foreclosure_d4 := join(file_foreclosure,my_dids(did<>0), (integer) left.name4_did=right.did , to_get_file_foreclosure_d(left,right), lookup);

// file_foreclosure to_get_file_foreclosure_b(file_foreclosure l, my_bdids r) := transform
// self := l;
// end;
// my_foreclosure_b1 := join(file_foreclosure,my_bdids(bdid<>0), (integer) left.name1_bdid=right.bdid , to_get_file_foreclosure_b(left,right), lookup);
// my_foreclosure_b2 := join(file_foreclosure,my_bdids(bdid<>0), (integer) left.name2_bdid=right.bdid , to_get_file_foreclosure_b(left,right), lookup);
// my_foreclosure_b3 := join(file_foreclosure,my_bdids(bdid<>0), (integer) left.name3_bdid=right.bdid , to_get_file_foreclosure_b(left,right), lookup);
// my_foreclosure_b4 := join(file_foreclosure,my_bdids(bdid<>0), (integer) left.name4_bdid=right.bdid , to_get_file_foreclosure_b(left,right), lookup);

// my_foreclosure := dedup(sort(file_foreclosure(situs1_zip='48009')+
	// my_foreclosure_d1+my_foreclosure_d2+my_foreclosure_d3+my_foreclosure_d4+
	// my_foreclosure_b1+my_foreclosure_b2+my_foreclosure_b3+my_foreclosure_b4,record),all);
// output(my_foreclosure,,'~thor_200::base::demo_data_file_foreclosure'+wuid,overwrite);

// file_foreclosure2 to_get_file_foreclosure2(file_foreclosure2 l, my_foreclosure r) := transform
// self := l;
// end;
// my_foreclosure2 := join(file_foreclosure2,my_foreclosure(foreclosure_id<>''), left.foreclosure_id=right.foreclosure_id , to_get_file_foreclosure2(left,right), lookup);
// my_foreclosure2_dd := dedup(sort(my_foreclosure2,record),all);
// output(my_foreclosure2_dd,,'~thor_200::base::demo_data_file_foreclosure2'+wuid,overwrite);



// file_uccv2_party_base to_get_file_uccv2_party_base_d(file_uccv2_party_base l, my_dids r) := transform
// self := l;
// end;
// my_uccv2_party_base_d := join(file_uccv2_party_base, my_dids, left.did=right.did, to_get_file_uccv2_party_base_d(left,right), lookup);
// file_uccv2_party_base to_get_file_uccv2_party_base_b(file_uccv2_party_base l, my_bdids r) := transform
// self := l;
// end;
// my_uccv2_party_base_b := join(file_uccv2_party_base, my_bdids, left.bdid=right.bdid, to_get_file_uccv2_party_base_b(left,right), lookup);
// my_uccv2_party_base := dedup(sort(my_uccv2_party_base_b+my_uccv2_party_base_d,record),all);

// output(my_uccv2_party_base ,,'~thor_200::base::demo_data_file_uccv2_party_base'+wuid,overwrite);

// file_uccv2_main_base to_get_file_uccv2_main_base(file_uccv2_main_base l, my_uccv2_party_base r) := transform
// self := l;
// end;
// my_uccv2_main_base := join(file_uccv2_main_base,  my_uccv2_party_base, left.tmsid=right.tmsid, to_get_file_uccv2_main_base(left,right), lookup);
// output(my_uccv2_main_base ,,'~thor_200::base::demo_data_file_uccv2_main_base'+wuid,overwrite);

// file_uccv2_party_name to_get_file_uccv2_party_name(file_uccv2_party_name l, my_uccv2_party_base r) := transform
// self := l;
// end;
// my_uccv2_party_name := join(file_uccv2_party_name,  my_uccv2_party_base, left.tmsid=right.tmsid, to_get_file_uccv2_party_name(left,right), lookup);
// output(my_uccv2_party_name ,,'~thor_200::base::demo_data_file_uccv2_party_name'+wuid,overwrite);


// file_mar_div_search to_get_file_mar_div_search1(file_mar_div_search l, my_dids r) := transform
// self := l;
// end;
// my_mar_div_search1 := join(file_mar_div_search, my_dids, left.did=right.did, to_get_file_mar_div_search1(left,right), lookup);
// file_mar_div_search to_get_file_mar_div_search2(file_mar_div_search l, my_mar_div_search1 r) := transform
// self := l;
// end;
// my_mar_div_search2 := join(file_mar_div_search, my_mar_div_search1, left.record_id=right.record_id, to_get_file_mar_div_search2(left,right), lookup);
// output(dedup(sort(my_mar_div_search1+my_mar_div_search2,record),all) ,,'~thor_200::base::demo_data_file_mar_div_search'+wuid,overwrite);

// file_mar_div_base to_get_file_mar_div_base(file_mar_div_base l, my_mar_div_search1 r) := transform
// self := l;
// end;
// my_mar_div_base := join(file_mar_div_base, my_mar_div_search1, left.record_id=right.record_id, to_get_file_mar_div_base(left,right), lookup);
// output(my_mar_div_base ,,'~thor_200::base::demo_data_file_mar_div_base'+wuid,overwrite);


// file_business_contacts_plus to_get1_file_business_contacts_plus(file_business_contacts_plus l, my_dids r) := transform
// self := l;
// end;
// my_business_contacts_plus1 := join(file_business_contacts_plus, my_dids, left.did=right.did, to_get1_file_business_contacts_plus(left,right), lookup);

// file_business_contacts_plus to_get2_file_business_contacts_plus(file_business_contacts_plus l, my_bdids r) := transform
// self := l;
// end;
// my_business_contacts_plus2 := join(file_business_contacts_plus, my_bdids, left.bdid=right.bdid, to_get2_file_business_contacts_plus(left,right), lookup);
// my_business_contacts_plus := dedup(sort(my_business_contacts_plus1+my_business_contacts_plus2,record),all);
// output(my_business_contacts_plus ,,'~thor_200::base::demo_data_file_business_contacts_plus'+wuid,overwrite);


// file_business_relatives to_get_file_business_relatives(file_business_relatives l, my_bdids r) := transform
// self := l;
// end; 
// my_business_relatives1 := join(file_business_relatives, my_bdids,left.bdid1=right.bdid,to_get_file_business_relatives(left,right), lookup);
// my_business_relatives2 := join(file_business_relatives, my_bdids,left.bdid2=right.bdid,to_get_file_business_relatives(left,right), lookup);
// my_business_relatives := dedup(sort(my_business_relatives1+my_business_relatives2,record),record);
// output(my_business_relatives ,,'~thor_200::base::demo_data_file_business_relatives'+wuid,overwrite);

// file_business_relatives_group to_get_file_business_relatives_group(file_business_relatives_group l, my_bdids r) := transform
// self := l;
// end; 
// my_business_relatives_group := join(file_business_relatives_group, my_bdids,left.bdid=right.bdid,to_get_file_business_relatives_group(left,right), lookup);
// output(my_business_relatives_group ,,'~thor_200::base::demo_data_file_business_relatives_group'+wuid,overwrite);


// file_business_header_base to_get_file_business_header_base(file_business_header_base l, my_bdids r) := transform
// self := l;
// end;
// my_business_header_base := join(file_business_header_base, my_bdids,left.bdid=right.bdid,to_get_file_business_header_base(left,right), lookup);
// output(my_business_header_base ,,'~thor_200::base::demo_data_file_business_header_base'+wuid,overwrite);

// file_business_header_best to_get_file_business_header_best(file_business_header_best l, my_bdids r) := transform
// self := l;
// end;
// my_business_header_best := join(file_business_header_best, my_bdids,left.bdid=right.bdid,to_get_file_business_header_best(left,right), lookup);
// output(my_business_header_best ,,'~thor_200::base::demo_data_file_business_header_best'+wuid,overwrite);

// file_corpdata to_get_file_corpdata(file_corpdata l, my_bdids r) := transform
// self := l;
// end;
// my_corpdata := join(file_corpdata, my_bdids,left.bdid=right.bdid,to_get_file_corpdata(left,right), lookup);
// output(my_corpdata ,,'~thor_200::base::demo_data_file_corpdata'+wuid,overwrite);

// file_contdata to_get_file_contdata(file_contdata l, my_dids r) := transform
// self := l;
// end;
// my_contdata := join(file_contdata, my_dids,left.did=right.did,to_get_file_contdata(left,right), lookup);
// output(my_contdata ,,'~thor_200::base::demo_data_file_contdata'+wuid,overwrite);

// my_eventdata := file_eventdata(false=true);
// output(my_eventdata ,,'~thor_200::base::demo_data_file_eventdata'+wuid,overwrite);

// my_stockdata := file_stockdata(false=true);
// output(my_stockdata ,,'~thor_200::base::demo_data_file_stockdata'+wuid,overwrite);

// my_ardata 	 := file_ardata(false=true);
// output(my_ardata ,,'~thor_200::base::demo_data_file_ardata'+wuid,overwrite);

// file_offenders_keybuilding 		to_get_file_offenders_keybuilding(file_offenders_keybuilding l, my_dids r) := transform
// self := l;
// end;
// my_offenders_keybuilding := join(file_offenders_keybuilding, my_dids,(unsigned) left.did=right.did,to_get_file_offenders_keybuilding(left,right), lookup);
// output(my_offenders_keybuilding ,,'~thor_200::base::demo_data_file_offenders_keybuilding'+wuid,overwrite);

// file_offenses_keybuilding 		to_get_file_offenses_keybuilding(file_offenses_keybuilding l, my_offenders_keybuilding r) := transform
// self := l;
// end;
// my_offenses_keybuilding := join(file_offenses_keybuilding, my_offenders_keybuilding,left.offender_key=right.offender_key,to_get_file_offenses_keybuilding(left,right), lookup);
// output(my_offenses_keybuilding ,,'~thor_200::base::demo_data_file_offenses_keybuilding'+wuid,overwrite);

// file_courtoffenses_keybuilding 		to_get_file_courtoffenses_keybuilding(file_courtoffenses_keybuilding l, my_offenders_keybuilding r) := transform
// self := l;
// end;
// my_courtoffenses_keybuilding := join(file_courtoffenses_keybuilding, my_offenders_keybuilding,left.offender_key=right.offender_key,to_get_file_courtoffenses_keybuilding(left,right), lookup);
// output(my_courtoffenses_keybuilding ,,'~thor_200::base::demo_data_file_courtoffenses_keybuilding'+wuid,overwrite);//

// file_activity_keybuilding 		to_get_file_activity_keybuilding(file_activity_keybuilding l, my_offenders_keybuilding r) := transform
// self := l;
// end;
// my_activity_keybuilding := join(file_activity_keybuilding, my_offenders_keybuilding,left.offender_key=right.offender_key,to_get_file_activity_keybuilding(left,right), lookup);
// output(my_activity_keybuilding ,,'~thor_200::base::demo_data_file_activity_keybuilding'+wuid,overwrite);

// file_punishment_keybuilding 		to_get_file_punishment_keybuilding(file_punishment_keybuilding l, my_offenders_keybuilding r) := transform
// self := l;
// end;
// my_punishment_keybuilding := join(file_punishment_keybuilding, my_offenders_keybuilding,left.offender_key=right.offender_key,to_get_file_punishment_keybuilding(left,right), lookup);
// output(my_punishment_keybuilding ,,'~thor_200::base::demo_data_file_punishment_keybuilding'+wuid,overwrite);

// file_so_main 		to_get_file_so_main(file_so_main l, my_dids r) := transform
// self := l;
// end;
// my_so_main := join(file_so_main, my_dids,(unsigned) left.did=right.did,to_get_file_so_main(left,right), lookup);
// output(my_so_main ,,'~thor_200::base::demo_data_file_so_main'+wuid,overwrite);

// file_so_offenses 		to_get_file_so_offenses(file_so_offenses l, my_so_main r) := transform
// self := l;
// end;
// my_so_offenses := join(file_so_offenses, my_so_main,left.seisint_primary_key=right.seisint_primary_key,to_get_file_so_offenses(left,right), lookup);
// output(my_so_offenses ,,'~thor_200::base::demo_data_file_so_offenses'+wuid,overwrite);

// file_phonesplus_base		to_get_file_phonesplus_base(file_phonesplus_base l, my_dids r) := transform
// self := l;
// end;
// my_phonesplus_base := choosen(file_phonesplus_base(did=0),10)+join(file_phonesplus_base(did<>0), my_dids,(unsigned) left.did=right.did,to_get_file_phonesplus_base(left,right), lookup);
// output(my_phonesplus_base ,,'~thor_200::base::demo_data_file_phonesplus_base'+wuid,overwrite);

// file_qsent_base		to_get_file_qsent_base(file_qsent_base l, my_dids r) := transform
// self := l;
// end;
// my_qsent_base := choosen(file_qsent_base(did=0),10)+join(file_qsent_base(did<>0), my_dids,(unsigned) left.did=right.did,to_get_file_qsent_base(left,right), lookup);
// output(my_qsent_base ,,'~thor_200::base::demo_data_file_qsent_base'+wuid,overwrite);

// file_neustar		to_get_file_neustar(file_neustar l, my_dids r) := transform
// self := l;
// end;
// my_neustar := choosen(file_neustar,10);
// output(my_neustar ,,'~thor_200::base::demo_data_file_neustar'+wuid,overwrite);


// file_whois_base to_get_file_whois_base_b(file_whois_base l, my_bdids r) := transform
// self := l;
// end;
// my_whois_base_b := join(file_whois_base, my_bdids,left.bdid=right.bdid,to_get_file_whois_base_b(left,right), lookup);
// file_whois_base to_get_file_whois_base_d(file_whois_base l, my_dids r) := transform
// self := l;
// end;
// my_whois_base_d := join(file_whois_base, my_dids,left.did=right.did,to_get_file_whois_base_d(left,right), lookup);
// my_whois_base := dedup(sort(my_whois_base_b+my_whois_base_d,record),all);
// output(my_whois_base ,,'~thor_200::base::demo_data_file_whois_base'+wuid,overwrite);



// file_watercraft_base_search to_get_file_watercraft_base_search_b(file_watercraft_base_search l, my_bdids r) := transform
// self :=l;
// end;
// my_watercraft_base_search_b := join(file_watercraft_base_search, my_bdids, (integer) left.bdid=right.bdid,to_get_file_watercraft_base_search_b(left,right),lookup);
// file_watercraft_base_search to_get_file_watercraft_base_search_d(file_watercraft_base_search l, my_dids r) := transform
// self :=l;
// end;
// my_watercraft_base_search_d := join(file_watercraft_base_search, my_dids, (integer) left.did=right.did,to_get_file_watercraft_base_search_d(left,right),lookup);
// my_watercraft_base_search := dedup(sort(my_watercraft_base_search_d+my_watercraft_base_search_b,record),all);
// output(my_watercraft_base_search ,,'~thor_200::base::demo_data_file_watercraft_base_search'+wuid,overwrite);

// file_watercraft_base_coastguard to_get_file_watercraft_base_coastguard(file_watercraft_base_coastguard l, my_watercraft_base_search r) := transform
// self := l;
// end;
// my_file_watercraft_base_coastguard := join(file_watercraft_base_coastguard,my_watercraft_base_search,left.watercraft_key=right.watercraft_key,to_get_file_watercraft_base_coastguard(left,right), lookup);
// output(my_file_watercraft_base_coastguard,,'~thor_200::base::demo_data_file_watercraft_base_coastguard'+wuid,overwrite);

// file_watercraft_base_main to_get_file_watercraft_base_main(file_watercraft_base_main l,my_watercraft_base_search r) := transform
// self := l;
// end;
// my_file_watercraft_base_main := join(file_watercraft_base_main,my_watercraft_base_search,left.watercraft_key=right.watercraft_key,to_get_file_watercraft_base_main(left,right), lookup);
// output(my_file_watercraft_base_main,,'~thor_200::base::demo_data_file_watercraft_base_main'+wuid,overwrite);



// file_atf_firearms_explosives_base to_get_file_atf_firearms_explosives_base_b(file_atf_firearms_explosives_base l, my_bdids r) := transform
// self :=l;
// end;
// my_atf_firearms_explosives_base_b := join(file_atf_firearms_explosives_base, my_bdids, (integer) left.bdid=right.bdid,to_get_file_atf_firearms_explosives_base_b(left,right),lookup);
// file_atf_firearms_explosives_base to_get_file_atf_firearms_explosives_base_d(file_atf_firearms_explosives_base l, my_dids r) := transform
// self :=l;
// end;
// my_atf_firearms_explosives_base_d := join(file_atf_firearms_explosives_base, my_dids, (integer) left.did_out=right.did,to_get_file_atf_firearms_explosives_base_d(left,right),lookup);
// my_atf_firearms_explosives_base := dedup(sort(my_atf_firearms_explosives_base_d+my_atf_firearms_explosives_base_b,record),all);
// output(my_atf_firearms_explosives_base ,,'~thor_200::base::demo_data_file_atf_firearms_explosives_base'+wuid,overwrite);

// file_dea_doxie to_get_file_dea_doxie_b(file_dea_doxie l, my_bdids r) := transform
// self :=l;
// end;
// my_dea_doxie_b := join(file_dea_doxie, my_bdids, (integer) left.bdid=right.bdid,to_get_file_dea_doxie_b(left,right),lookup);
// file_dea_doxie to_get_file_dea_doxie_d(file_dea_doxie l, my_dids r) := transform
// self :=l;
// end;
// my_dea_doxie_d := join(file_dea_doxie, my_dids, (integer) left.did=right.did,to_get_file_dea_doxie_d(left,right),lookup);
// my_dea_doxie := dedup(sort(my_dea_doxie_d+my_dea_doxie_b,record),all);
// output(my_dea_doxie ,,'~thor_200::base::demo_data_file_dea_doxie'+wuid,overwrite);

// file_dea_modified to_get_file_dea_modified_b(file_dea_modified l, my_bdids r) := transform
// self :=l;
// end;
// my_dea_modified_b := join(file_dea_modified, my_bdids, (integer) left.bdid=right.bdid,to_get_file_dea_modified_b(left,right),lookup);
// file_dea_modified to_get_file_dea_modified_d(file_dea_modified l, my_dids r) := transform
// self :=l;
// end;
// my_dea_modified_d := join(file_dea_modified, my_dids, (integer) left.did=right.did,to_get_file_dea_modified_d(left,right),lookup);
// my_dea_modified := dedup(sort(my_dea_modified_d+my_dea_modified_b,record),all);
// output(my_dea_modified ,,'~thor_200::base::demo_data_file_dea_modified'+wuid,overwrite);

// file_faa_aircraft_registration to_get_file_faa_aircraft_registration_b(file_faa_aircraft_registration l, my_bdids r) := transform
// self :=l;
// end;
// my_faa_aircraft_registration_b := join(file_faa_aircraft_registration, my_bdids, (integer) left.bdid_out=right.bdid,to_get_file_faa_aircraft_registration_b(left,right),lookup);
// file_faa_aircraft_registration to_get_file_faa_aircraft_registration_d(file_faa_aircraft_registration l, my_dids r) := transform
// self :=l;
// end;
// my_faa_aircraft_registration_d := join(file_faa_aircraft_registration, my_dids, (integer) left.did_out=right.did,to_get_file_faa_aircraft_registration_d(left,right),lookup);
// my_faa_aircraft_registration := dedup(sort(my_faa_aircraft_registration_d+my_faa_aircraft_registration_b,record),all);
// output(my_faa_aircraft_registration ,,'~thor_200::base::demo_data_file_faa_aircraft_registration'+wuid,overwrite);

// file_faa_airmen_data to_get_file_faa_airmen_data_d(file_faa_airmen_data l, my_dids r) := transform
// self :=l;
// end;
// my_faa_airmen_data := join(file_faa_airmen_data, my_dids, (integer) left.did_out=right.did,to_get_file_faa_airmen_data_d(left,right),lookup);
// output(my_faa_airmen_data ,,'~thor_200::base::demo_data_file_faa_airmen_data'+wuid,overwrite);

// file_faa_airmen_certificate to_get_file_faa_airmen_certificate(file_faa_airmen_certificate l,my_faa_airmen_data r) := transform
// self := l;
// end;
// my_faa_airmen_certificate := join(file_faa_airmen_certificate,my_faa_airmen_data,left.unique_id=right.unique_id,to_get_file_faa_airmen_certificate(left,right), lookup);
// output(my_faa_airmen_certificate,,'~thor_200::base::demo_data_file_faa_airmen_certificate'+wuid,overwrite);

// my_fl_crash_did := file_fl_crash_did(accident_nbr in ['532282580','76832191','556096620','70330764']);
// output(my_fl_crash_did ,,'~thor_200::base::demo_data_file_fl_crash_did'+wuid,overwrite);

// file_fl_crash0 to_get_file_fl_crash0(file_fl_crash0 l, my_fl_crash_did r) := transform
// self := l;
// end;
// my_fl_crash0 := join(file_fl_crash0, my_fl_crash_did, left.accident_nbr=right.accident_nbr, to_get_file_fl_crash0(left,right),lookup);
// output(my_fl_crash0 ,,'~thor_200::base::demo_data_file_fl_crash0'+wuid,overwrite);

// file_fl_crash1 to_get_file_fl_crash1(file_fl_crash1 l, my_fl_crash_did r) := transform
// self := l;
// end;
// my_fl_crash1 := join(file_fl_crash1, my_fl_crash_did, left.accident_nbr=right.accident_nbr, to_get_file_fl_crash1(left,right),lookup);
// output(my_fl_crash1 ,,'~thor_200::base::demo_data_file_fl_crash1'+wuid,overwrite);

// file_fl_crash2v to_get_file_fl_crash2v(file_fl_crash2v l, my_fl_crash_did r) := transform
// self := l;
// end;
// my_fl_crash2v := join(file_fl_crash2v, my_fl_crash_did, left.accident_nbr=right.accident_nbr, to_get_file_fl_crash2v(left,right),lookup);
// output(my_fl_crash2v ,,'~thor_200::base::demo_data_file_fl_crash2v'+wuid,overwrite);

// file_fl_crash3v to_get_file_fl_crash3v(file_fl_crash3v l, my_fl_crash_did r) := transform
// self := l;
// end;
// my_fl_crash3v := join(file_fl_crash3v, my_fl_crash_did, left.accident_nbr=right.accident_nbr, to_get_file_fl_crash3v(left,right),lookup);
// output(my_fl_crash3v ,,'~thor_200::base::demo_data_file_fl_crash3v'+wuid,overwrite);

// file_fl_crash4 to_get_file_fl_crash4(file_fl_crash4 l, my_fl_crash_did r) := transform
// self := l;
// end;
// my_fl_crash4 := join(file_fl_crash4, my_fl_crash_did, left.accident_nbr=right.accident_nbr, to_get_file_fl_crash4(left,right),lookup);
// output(my_fl_crash4 ,,'~thor_200::base::demo_data_file_fl_crash4'+wuid,overwrite);

// file_fl_crash5 to_get_file_fl_crash5(file_fl_crash5 l, my_fl_crash_did r) := transform
// self := l;
// end;
// my_fl_crash5 := join(file_fl_crash5, my_fl_crash_did, left.accident_nbr=right.accident_nbr, to_get_file_fl_crash5(left,right),lookup);
// output(my_fl_crash5 ,,'~thor_200::base::demo_data_file_fl_crash5'+wuid,overwrite);

// file_fl_crash6 to_get_file_fl_crash6(file_fl_crash6 l, my_fl_crash_did r) := transform
// self := l;
// end;
// my_fl_crash6 := join(file_fl_crash6, my_fl_crash_did, left.accident_nbr=right.accident_nbr, to_get_file_fl_crash6(left,right),lookup);
// output(my_fl_crash6 ,,'~thor_200::base::demo_data_file_fl_crash6'+wuid,overwrite);

// file_fl_crash7 to_get_file_fl_crash7(file_fl_crash7 l, my_fl_crash_did r) := transform
// self := l;
// end;
// my_fl_crash7 := join(file_fl_crash7, my_fl_crash_did, left.accident_nbr=right.accident_nbr, to_get_file_fl_crash7(left,right),lookup);
// output(my_fl_crash7 ,,'~thor_200::base::demo_data_file_fl_crash7'+wuid,overwrite);

// file_fl_crash8 to_get_file_fl_crash8(file_fl_crash8 l, my_fl_crash_did r) := transform
// self := l;
// end;
// my_fl_crash8 := join(file_fl_crash8, my_fl_crash_did, left.accident_nbr=right.accident_nbr, to_get_file_fl_crash8(left,right),lookup);
// output(my_fl_crash8 ,,'~thor_200::base::demo_data_file_fl_crash8'+wuid,overwrite);

// file_bankruptcy_search to_get_file_bankruptcy_search_d(file_bankruptcy_search l, my_dids r) := transform
// self := l;
// end;
// my_bankruptcy_search_d := join(file_bankruptcy_search, my_dids, (unsigned6) left.did=right.did,to_get_file_bankruptcy_search_d(left,right), local);
// file_bankruptcy_search to_get_file_bankruptcy_search_b(file_bankruptcy_search l, my_bdids r) := transform
// self := l;
// end;
// my_bankruptcy_search_b := join(file_bankruptcy_search, my_bdids, (unsigned6) left.bdid=right.bdid,to_get_file_bankruptcy_search_b(left,right), local);
// my_bankruptcy_search := dedup(sort(choosen(file_bankruptcy_search,100)+my_bankruptcy_search_d+my_bankruptcy_search_b,record),all);

// output(my_bankruptcy_search,,'~thor_200::base::demo_data_file_bankruptcy_search'+wuid,overwrite);

// file_bankruptcy_main  to_get_file_bankruptcy_main(file_bankruptcy_main l, my_bankruptcy_search r) := transform
// self := l;
// end;
// my_bankruptcy_main := join(file_bankruptcy_main, my_bankruptcy_search, left.tmsid=right.tmsid, to_get_file_bankruptcy_main(left,right), lookup);
// output(my_bankruptcy_main,,'~thor_200::base::demo_data_file_bankruptcy_main'+wuid,overwrite);

// file_paw to_get_file_paw1(file_paw l,my_dids r) := transform
// self := l;
// end;
// my_file_paw1 := join(file_paw, my_dids, left.did=right.did, to_get_file_paw1(left,right), lookup);
// file_paw to_get_file_paw2(file_paw l,my_bdids r) := transform
// self := l;
// end;
// my_file_paw2 := join(my_file_paw1, my_bdids, left.bdid=right.bdid, to_get_file_paw2(left,right), lookup);
// output(my_file_paw2,,'~thor_200::base::demo_data_file_paw'+wuid,overwrite);


// key_did_patriot to_get_patriot_did_hits(key_did_patriot l, my_dids r) := transform
// self := l;
// end;
// my_did_patriot_hits := join(key_did_patriot(did<>0), my_dids, left.did=right.did, to_get_patriot_did_hits(left,right), lookup);
// key_bdid_patriot to_get_patriot_bdid_hits(key_bdid_patriot l, my_bdids r) := transform
// self := l;
// end;
// my_bdid_patriot_hits := join(key_bdid_patriot(bdid<>0), my_bdids, left.bdid=right.bdid, to_get_patriot_bdid_hits(left,right), lookup);
// my_patriot_hits := dedup(sort(my_did_patriot_hits+my_bdid_patriot_hits,record),all);
// file_patriot to_get_file_patriot(file_patriot l, my_patriot_hits r) := transform
// self := l
// end;
// my_file_patriot := join(file_patriot, my_patriot_hits,left.pty_key=right.pty_key,to_get_file_patriot(left,right),lookup);
// output(my_file_patriot,,'~thor_200::base::demo_data_file_patriot'+wuid,overwrite);
// output(my_did_patriot_hits,,'~thor_200::base::demo_data_file_patriot_did_hits'+wuid,overwrite);
// output(my_bdid_patriot_hits,,'~thor_200::base::demo_data_file_patriot_bdid_hits'+wuid,overwrite);
// file_globalwatchlists to_get_file_globalwatchlists(file_globalwatchlists l, my_patriot_hits r) := transform
// self := l;
// end;
// my_globalwatchlists := join(file_globalwatchlists, my_patriot_hits,left.pty_key=right.pty_key,to_get_file_globalwatchlists(left,right),lookup);
// output(my_globalwatchlists,,'~thor_200::base::demo_data_file_globalwatchlists'+wuid,overwrite);


// file_yellow_pages to_get_file_yellow_pages(file_yellow_pages l,my_bdids r) := transform
// self := l;
// end;
// my_file_yellow_pages := dedup(sort(choosen(file_yellow_pages,100)+ join(file_yellow_pages, my_bdids, left.bdid=right.bdid, to_get_file_yellow_pages(left,right), lookup),record),all);
// output(my_file_yellow_pages,,'~thor_200::base::demo_data_file_yellow_pages'+wuid,overwrite);


// file_bbb2_nonmember to_get_file_bbb2_nonmember(file_bbb2_nonmember l,my_bdids r) := transform
// self := l;
// end;
// my_file_bbb2_nonmember := dedup(sort(choosen(file_bbb2_nonmember,100)+ join(file_bbb2_nonmember, my_bdids, left.bdid=right.bdid, to_get_file_bbb2_nonmember(left,right), lookup),record),all);
// output(my_file_bbb2_nonmember,,'~thor_200::base::demo_data_file_bbb2_nonmember'+wuid,overwrite);
// file_bbb2_member to_get_file_bbb2_member(file_bbb2_member l,my_bdids r) := transform
// self := l;
// end;
// my_file_bbb2_member := dedup(sort(choosen(file_bbb2_member,100)+ join(file_bbb2_member, my_bdids, left.bdid=right.bdid, to_get_file_bbb2_member(left,right), lookup),record),all);
// output(my_file_bbb2_member,,'~thor_200::base::demo_data_file_bbb2_member'+wuid,overwrite);


// file_busreg_contact to_get_file_busreg_contact_b(file_busreg_contact l, my_bdids r) := transform
// self := l;
// end;
// my_busreg_contact_b := join(file_busreg_contact, my_bdids,left.bdid=right.bdid, to_get_file_busreg_contact_b(left,right),lookup);
// file_busreg_contact to_get_file_busreg_contact_d(file_busreg_contact l, my_dids r) := transform
// self := l;
// end;
// my_busreg_contact_d := join(file_busreg_contact, my_dids,left.did=right.did, to_get_file_busreg_contact_d(left,right),lookup);
// my_busreg_contact := dedup(sort(my_busreg_contact_d+my_busreg_contact_b,record),all);
// output(my_busreg_contact,,'~thor_200::base::demo_data_file_busreg_contact'+wuid,overwrite);
// file_busreg_company to_get_busreg_company(file_busreg_company l, my_busreg_contact r) := transform
// self := l;
// end;
// my_busreg_company := join(file_busreg_company,my_busreg_contact, left.br_id=right.br_id,to_get_busreg_company(left,right),lookup);
// output(my_busreg_company,,'~thor_200::base::demo_data_file_busreg_company'+wuid,overwrite);


// file_dnb_contacts_base to_get_file_dnb_contacts_base_b(file_dnb_contacts_base l, my_bdids r) := transform
// self := l;
// end;
// my_dnb_contacts_base_b := join(file_dnb_contacts_base, my_bdids,left.bdid=right.bdid, to_get_file_dnb_contacts_base_b(left,right),lookup);
// file_dnb_contacts_base to_get_file_dnb_contacts_base_d(file_dnb_contacts_base l, my_dids r) := transform
// self := l;
// end;
// my_dnb_contacts_base_d := join(file_dnb_contacts_base, my_dids,left.did=right.did, to_get_file_dnb_contacts_base_d(left,right),lookup);
// my_dnb_contacts_base := dedup(sort(my_dnb_contacts_base_d+my_dnb_contacts_base_b,record),all);
// output(my_dnb_contacts_base,,'~thor_200::base::demo_data_file_dnb_contacts_base'+wuid,overwrite);
// file_dnb_base to_get_dnb_base(file_dnb_base l, my_dnb_contacts_base r) := transform
// self := l;
// end;
// my_dnb_base := join(file_dnb_base,my_dnb_contacts_base, left.duns_number=right.duns_number,to_get_dnb_base(left,right),lookup);
// output(my_dnb_base,,'~thor_200::base::demo_data_file_dnb_base'+wuid,overwrite);

// my_ebr_bdids := 
// [47540543,
// 301075765,
// 1722197697,
// 619950757,
// 39346266,
// 476368705,
// 1724317214,
// 457311930,
// 39953053,
// 79482231,
// 402769117,
// 994817609,
// 1005133914,
// 692985825,
// 690216166,
// 175937782,
// 38334286,
// 1718351157,
// 469657876,
// 31258001,
// 45325217,
// 103908307,
// 146455538,
// 349879821,
// 993697229,
// 19044395,
// 705939897,
// 78147258,
// 1724506019,
// 1726037908,
// 53183219,
// 63064254,
// 450512302,
// 30370459,
// 62903691,
// 142636166,
// 33915027,
// 993741329,
// 18417889,
// 729949710,
// 797448633,
// 90837383,
// 455910930,
// 26032687,
// 458343902,
// 56897454,
// 650391052,
// 16751625,
// 362491404,
// 1064138754,
// 91463920,
// 780735743,
// 1723235392,
// 569667354,
// 96327156,
// 706775997,
// 27609462,
// 162689895,
// 1723305414,
// 38496769,
// 47152027,
// 75912520,
// 111372476,
// 24586592,
// 468515958,
// 698481212,
// 111474477,
// 108108868,
// 144974939,
// 709197199,
// 86794322,
// 706152521,
// 65807050,
// 83812893,
// 1722837910,
// 80412537,
// 35805997,
// 72104250,
// 33365710,
// 27878,
// 82666948,
// 706648263,
// 306893977,
// 42443948,
// 100359856,
// 62426,
// 10329397,
// 4497604,
// 114012598,
// 781618762,
// 25518400,
// 45392394,
// 333279881,
// 697500565,
// 1040777801,
// 34559877,
// 1796694,
// 108934009,
// 695117443,
// 671677300]; 

// output(file_ebr_0010(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_0010'+wuid,overwrite); 
// output(file_ebr_1000(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_1000'+wuid,overwrite); 
// output(file_ebr_2000(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_2000'+wuid,overwrite);
// output(file_ebr_2015(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_2015'+wuid,overwrite);
// output(file_ebr_2025(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_2025'+wuid,overwrite); 
// output(file_ebr_4010(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_4010'+wuid,overwrite); 
// output(file_ebr_4020(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_4020'+wuid,overwrite); 
// output(file_ebr_4030(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_4030'+wuid,overwrite); 
// output(file_ebr_4035(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_4035'+wuid,overwrite);
// output(file_ebr_4040(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_4040'+wuid,overwrite);
// output(file_ebr_4500(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_4500'+wuid,overwrite);
// output(file_ebr_4510(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_4510'+wuid,overwrite);
// output(file_ebr_5000(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_5000'+wuid,overwrite);
// output(file_ebr_5600(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_5600'+wuid,overwrite);
// output(file_ebr_5610(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_5610'+wuid,overwrite);
// output(file_ebr_6000(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_6000'+wuid,overwrite);
// output(file_ebr_6500(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_6500'+wuid,overwrite);
// output(file_ebr_6510(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_6510'+wuid,overwrite);
// output(file_ebr_7000(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_7000'+wuid,overwrite);
// output(file_ebr_7010(bdid in my_ebr_bdids),,'~thor_200::base::demo_data_file_ebr_7010'+wuid,overwrite);

// file_pcnsr to_get_file_pcnsr(file_pcnsr l, my_dids r) := transform
// self := l;
// end;
// my_pcnsr := join(file_pcnsr, my_dids,left.did=right.did, to_get_file_pcnsr(left,right),lookup);
// output(my_pcnsr,,'~thor_200::base::demo_data_file_pcnsr'+wuid,overwrite);

// file_fbnv2_contact to_get_file_fbnv2_contact_b(file_fbnv2_contact l, my_bdids r) := transform
// self := l;
// end;
// my_fbnv2_contact_b := join(file_fbnv2_contact, my_bdids,left.bdid=right.bdid, to_get_file_fbnv2_contact_b(left,right),lookup);
// file_fbnv2_contact to_get_file_fbnv2_contact_d(file_fbnv2_contact l, my_dids r) := transform
// self := l;
// end;
// my_fbnv2_contact_d := join(file_fbnv2_contact, my_dids,left.did=right.did, to_get_file_fbnv2_contact_d(left,right),lookup);
// my_fbnv2_contact := dedup(sort(my_fbnv2_contact_d+my_fbnv2_contact_b,record),all);
// output(my_fbnv2_contact,,'~thor_200::base::demo_data_file_fbnv2_contact'+wuid,overwrite);
// file_fbnv2_business to_get_fbnv2_business(file_fbnv2_business l, my_fbnv2_contact r) := transform
// self := l;
// end;
// my_fbnv2_business := join(file_fbnv2_business,my_fbnv2_contact, left.tmsid=right.tmsid,to_get_fbnv2_business(left,right),lookup);
// output(my_fbnv2_business,,'~thor_200::base::demo_data_file_fbnv2_business'+wuid,overwrite);



// file_bdl2_base to_get_file_bdl2_base(file_bdl2_base l, my_bdids r) := transform
// self := l;
// end;
// my_bdl2_base := join(file_bdl2_base, my_bdids,left.bdid=right.bdid, to_get_file_bdl2_base(left,right),lookup);
// output(my_bdl2_base,,'~thor_200::base::demo_data_file_bdl2_base'+wuid,overwrite);



file_bankruptcy_search_v3 to_get_file_bankruptcy_search_v3_d(file_bankruptcy_search_v3 l, my_dids r) := transform
self := l;
end;
my_bankruptcy_search_v3_d := join(file_bankruptcy_search_v3, my_dids, (unsigned6) left.did=right.did,to_get_file_bankruptcy_search_v3_d(left,right), local);
file_bankruptcy_search_v3 to_get_file_bankruptcy_search_v3_b(file_bankruptcy_search_v3 l, my_bdids r) := transform
self := l;
end;
my_bankruptcy_search_v3_b := join(file_bankruptcy_search_v3, my_bdids, (unsigned6) left.bdid=right.bdid,to_get_file_bankruptcy_search_v3_b(left,right), local);
my_bankruptcy_search_v3 := dedup(sort(choosen(file_bankruptcy_search_v3,500)+my_bankruptcy_search_v3_d+my_bankruptcy_search_v3_b,record),all);

output(my_bankruptcy_search_v3,,'~thor_200::base::demo_data_file_bankruptcy_search_v3'+wuid,overwrite);

file_bankruptcy_main_v3  to_get_file_bankruptcy_main_v3(file_bankruptcy_main_v3 l, my_bankruptcy_search_v3 r) := transform
self := l;
end;
my_bankruptcy_main_v3 := join(file_bankruptcy_main_v3, my_bankruptcy_search_v3, left.tmsid=right.tmsid, to_get_file_bankruptcy_main_v3(left,right), lookup);
output(my_bankruptcy_main_v3,,'~thor_200::base::demo_data_file_bankruptcy_main_v3'+wuid,overwrite);
