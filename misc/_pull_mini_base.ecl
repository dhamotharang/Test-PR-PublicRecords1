//
import demo_data, business_header;
//

layout_demo_data_dids := record
unsigned6 did;
end;
file_demo_data_dids := dataset('~thor_200::base::mini_build_dids_20090220',layout_demo_data_dids,flat);
layout_demo_data_dids_add := record
string did;
end;
file_demo_data_dids_add :=  dataset('~thor_200::in::mini_build_dids_20090320',layout_demo_data_dids_add,csv);
file_demo_data_dids_add2 := dataset('~thor_200::in::mini_build_dids_20090420',layout_demo_data_dids_add,csv);
file_demo_data_dids_add3 := dataset('~thor_200::in::mini_build_dids_20090727',layout_demo_data_dids_add,csv);
layout_demo_data_dids did_to_int(file_demo_data_dids_add l) := transform
self.did := (unsigned6) l.did;
end;

//
layout_demo_data_bdids := record
unsigned6 bdid;
end;
file_demo_data_bdids := dataset('~thor_200::base::mini_build_bdids_20090220',layout_demo_data_bdids,flat);
layout_demo_data_bdids_add := record
string bdid;
end;
file_demo_data_bdids_add :=  dataset('~thor_200::in::mini_build_bdids_20090320',layout_demo_data_bdids_add,csv);
file_demo_data_bdids_add2 := dataset('~thor_200::in::mini_build_bdids_20090420',layout_demo_data_bdids_add,csv);
layout_demo_data_bdids bdid_to_int(file_demo_data_bdids_add l) := transform
self.bdid := (unsigned6) l.bdid;
end;

//
file_headers  				:= demo_data.base_files.file_headers; 
file_relatives 				:= demo_data.base_files.file_relatives; 
file_watchdog_best			:= demo_data.base_files.file_watchdog_best; 
file_business_contacts_plus := demo_data.base_files.file_business_contacts_plus; 
file_business_relatives 	:= demo_data.base_files.file_business_relatives; 
file_business_relatives_group := demo_data.base_files.file_business_relatives_group; 
File_Business_Header_Base 	:= demo_data.base_files.File_Business_Header_Base; 
File_Business_Header_best 	:= demo_data.base_files.File_Business_Header_best; 
file_dl_searchv2		 	:= demo_data.base_files.file_dl_searchv2; 
file_gongbase			 	:= demo_data.base_files.file_gongbase; 
file_gonghist			 	:= demo_data.base_files.file_gonghist; 
file_votersv2_base			:= demo_data.base_files.file_votersv2_base; 
file_paw 					:= demo_data.base_files.file_paw;	
file_corpdata				:= demo_data.base_files.file_corpdata;	
file_paw_stats 				:= business_header.File_Business_Contacts_Stats;

file_ln_propertyv2_file_search_did 	:= demo_data.base_files.file_ln_propertyv2_file_search_did;
file_ln_propertyv2_file_deed		:= demo_data.base_files.file_ln_propertyv2_file_deed;
file_ln_propertyv2_file_assessment	:= demo_data.base_files.file_ln_propertyv2_file_assessment;   
file_ln_propertyv2_file_addl_fares_deed 	:= demo_data.base_files.file_ln_propertyv2_file_addl_fares_deed;	
file_ln_propertyv2_file_addl_fares_tax		:= demo_data.base_files.file_ln_propertyv2_file_addl_fares_tax;	
file_ln_propertyv2_file_addl_legal	:= demo_data.base_files.file_ln_propertyv2_file_addl_legal;		

file_vehiclev2_main 	:= demo_data.base_files.file_vehiclev2_main; 
file_vehiclev2_party	:= demo_data.base_files.file_vehiclev2_party; 
//
//
my_dids := file_demo_data_dids+project(file_demo_data_dids_add,did_to_int(left))
							  +project(file_demo_data_dids_add2,did_to_int(left))
							  +project(file_demo_data_dids_add3,did_to_int(left));
my_bdids := file_demo_data_bdids+project(file_demo_data_bdids_add,bdid_to_int(left))
								+project(file_demo_data_bdids_add2,bdid_to_int(left));		


//
// extracts start here
//
// 400_84*
// file_headers to_get_file_headers(file_headers l, my_dids r) := transform
// self := l;
// end;
// my_headers := join(file_headers, my_dids,left.did=right.did,to_get_file_headers(left,right), lookup);
// output(my_headers ,,'~thor_data400::base::header_prod_minix',overwrite,__compressed__);
// file_relatives to_get_file_relatives(file_relatives l, my_dids r) := transform
// self := l;
// end; 
// my_relatives1 := join(file_relatives, my_dids,left.person1=right.did,to_get_file_relatives(left,right), lookup);
// my_relatives2 := join(file_relatives, my_dids,left.person2=right.did,to_get_file_relatives(left,right), lookup);
// my_relatives := dedup(sort(my_relatives1+my_relatives2,record),record);
// output(my_relatives ,,'~thor_data400::base::relatives_minix',overwrite,__compressed__);
// file_watchdog_best to_get_file_watchdog_best(file_watchdog_best l, my_dids r) := transform
// self := l;
// end;
// my_watchdog_best := join(file_watchdog_best, my_dids, left.did=right.did, to_get_file_watchdog_best(left,right),lookup);
// output(my_watchdog_best ,,'~thor_data400::base::watchdog_best_minix',overwrite,__compressed__);

// 200*
// file_dl_searchv2 to_get_file_dl_searchv2(file_dl_searchv2 l, my_dids r) := transform
// self := l;
// end;
// my_dl_searchv2 := join(file_dl_searchv2,my_dids,left.did=right.did,to_get_file_dl_searchv2(left,right),lookup);
// output(my_dl_searchv2 ,,'~thor_data400::base::dl2::dlsearch_public_minix',overwrite,__compressed__);
//
// 400_84*
// file_gonghist to_get_file_gonghist_dids(file_gonghist l, my_dids r) := transform
// self := l;
// end;
// my_gonghist_dids := join(file_gonghist, my_dids(did<>0),left.did=right.did,to_get_file_gonghist_dids(left,right), lookup);
// file_gonghist to_get_file_gonghist_bdids(file_gonghist l, my_bdids r) := transform
// self := l;
// end;
// my_gonghist_bdids := join(file_gonghist, my_bdids(bdid<>0),left.bdid=right.bdid,to_get_file_gonghist_bdids(left,right), lookup);
// my_gonghist_t := my_gonghist_dids+my_gonghist_bdids;
// file_gonghist to_get_file_gonghist_phone(file_gonghist l, my_gonghist_t r) := transform
// self := l;
// end;
// my_gonghist_phone := join(file_gonghist(phone10<>''),my_gonghist_t ,left.phone10=right.phone10,to_get_file_gonghist_phone(left,right), lookup);
// my_gonghist := dedup(sort(distribute(my_gonghist_phone+my_gonghist_dids+my_gonghist_bdids,hash(phone10)),record,local),all,local);
// output(my_gonghist ,,'~thor_data400::base::gong_history_minix',overwrite,__compressed__);
// (really 200, but it uses my_gonghist from above)
// file_gongbase to_get_file_gongbase(file_gongbase l, my_gonghist r) := transform
// self := l;
// end;
// my_gongbase_phone := join(file_gongbase(phoneno<>''), my_gonghist,left.phoneno=right.phone10,to_get_file_gongbase(left,right), lookup);
// my_gongbase := dedup(sort(distribute(my_gongbase_phone,hash(phoneno)),record,local),all,local);
// output(my_gongbase ,,'~thor_data400::base::gong_minix',overwrite,__compressed__);

// 400_84*
// file_votersv2_base to_get_file_votersv2_base(file_votersv2_base l, my_dids r) := transform
// self := l;
// end;
// my_votersv2_base := join(file_votersv2_base, my_dids, left.did=right.did,to_get_file_votersv2_base(left,right), lookup);
// output(my_votersv2_base,,'~thor_data400::base::voters_reg_minix',overwrite,__compressed__);

// 400_92*
// file_business_contacts_plus to_get1_file_business_contacts_plus(file_business_contacts_plus l, my_dids r) := transform
// self := l;
// end;
// my_business_contacts_plus1 := join(file_business_contacts_plus, my_dids, left.did=right.did, to_get1_file_business_contacts_plus(left,right), lookup);
// file_business_contacts_plus to_get2_file_business_contacts_plus(file_business_contacts_plus l, my_bdids r) := transform
// self := l;
// end;
// my_business_contacts_plus2 := join(file_business_contacts_plus, my_bdids, left.bdid=right.bdid, to_get2_file_business_contacts_plus(left,right), lookup);
// my_business_contacts_plus := dedup(sort(my_business_contacts_plus1+my_business_contacts_plus2,record),all);
// output(my_business_contacts_plus ,,'~thor_data400::base::business_contacts_minix',overwrite,__compressed__);
// output(my_business_contacts_plus ,,'~thor_data400::base::business_contacts_plus_minix',overwrite,__compressed__);
// file_business_relatives to_get_file_business_relatives(file_business_relatives l, my_bdids r) := transform
// self := l;
// end; 
// my_business_relatives1 := join(file_business_relatives, my_bdids,left.bdid1=right.bdid,to_get_file_business_relatives(left,right), lookup);
// my_business_relatives2 := join(file_business_relatives, my_bdids,left.bdid2=right.bdid,to_get_file_business_relatives(left,right), lookup);
// my_business_relatives := dedup(sort(my_business_relatives1+my_business_relatives2,record),record);
// output(my_business_relatives ,,'~thor_data400::base::business_relatives_minix',overwrite,__compressed__);
// file_business_relatives_group to_get_file_business_relatives_group(file_business_relatives_group l, my_bdids r) := transform
// self := l;
// end; 
// my_business_relatives_group := join(file_business_relatives_group, my_bdids,left.bdid=right.bdid,to_get_file_business_relatives_group(left,right), lookup);
// output(my_business_relatives_group ,,'~thor_data400::base::business_relatives_group_minix',overwrite,__compressed__);
// file_business_header_base to_get_file_business_header_base(file_business_header_base l, my_bdids r) := transform
// self := l;
// end;
// my_business_header_base := join(file_business_header_base, my_bdids,left.bdid=right.bdid,to_get_file_business_header_base(left,right), lookup);
// output(my_business_header_base ,,'~thor_data400::base::business_header_minix',overwrite,__compressed__);
// file_business_header_best to_get_file_business_header_best(file_business_header_best l, my_bdids r) := transform
// self := l;
// end;
// my_business_header_best := join(file_business_header_best, my_bdids,left.bdid=right.bdid,to_get_file_business_header_best(left,right), lookup);
// output(my_business_header_best ,,'~thor_data400::base::business_header.best_minix',overwrite,__compressed__);
// file_paw to_get_file_paw1(file_paw l,my_dids r) := transform
// self := l;
// end;
// my_file_paw1 := join(file_paw, my_dids, left.did=right.did, to_get_file_paw1(left,right), lookup);
// file_paw to_get_file_paw2(file_paw l,my_bdids r) := transform
// self := l;
// end;
// my_file_paw2 := join(file_paw, my_bdids, left.bdid=right.bdid, to_get_file_paw2(left,right), lookup);
// my_file_paw := dedup(sort(my_file_paw1+my_file_paw2,record),all);
// output(my_file_paw,,'~thor_data400::base::paw::built::data_minix',overwrite,__compressed__);
// file_corpdata to_get_file_corpdata(file_corpdata l, my_bdids r) := transform
// self := l;
// end;
// my_corpdata := join(file_corpdata, my_bdids,left.bdid=right.bdid,to_get_file_corpdata(left,right), lookup);
// output(my_corpdata ,,'~thor_data400::base::corp2::qa::corp_minix',overwrite,__compressed__);
// file_paw_stats to_get1_file_paw_stats(file_paw_stats l, my_dids r) := transform
// self := l;
// end;
// my_paw_stats1 := join(file_paw_stats, my_dids, left.did=right.did, to_get1_file_paw_stats(left,right), lookup);
// file_paw_stats to_get2_file_paw_stats(file_paw_stats l, my_bdids r) := transform
// self := l;
// end;
// my_paw_stats2 := join(file_paw_stats, my_bdids, left.bdid=right.bdid, to_get2_file_paw_stats(left,right), lookup);
// my_paw_stats := dedup(sort(my_paw_stats1+my_paw_stats2,record),all);
// output(my_paw_stats ,,'~thor_data400::base::people_at_work_stats_minix',overwrite,__compressed__);
// output(my_paw_stats ,,'~thor_data400::base::people_at_work_stats_plus_minix',overwrite,__compressed__);

// 400_84*
// file_ln_propertyv2_file_search_did to_get_file_ln_propertyv2_file_search_did_d(file_ln_propertyv2_file_search_did l, my_dids r) := transform
// self := l;
// end;
// my_ln_propertyv2_file_search_did_d := join(file_ln_propertyv2_file_search_did(did<>0), my_dids, left.did=right.did, to_get_file_ln_propertyv2_file_search_did_d(left,right), lookup);
// file_ln_propertyv2_file_search_did to_get_file_ln_propertyv2_file_search_did_b(file_ln_propertyv2_file_search_did l, my_bdids r) := transform
// self := l;
// end;
// my_ln_propertyv2_file_search_did_b := join(file_ln_propertyv2_file_search_did(bdid<>0), my_bdids, left.bdid=right.bdid, to_get_file_ln_propertyv2_file_search_did_b(left,right), lookup);
// my_ln_propertyv2_file_search_did := dedup(sort(my_ln_propertyv2_file_search_did_b+my_ln_propertyv2_file_search_did_d,record),all);
// output(my_ln_propertyv2_file_search_did ,,'~thor_data400::base::ln_propertyv2::search_minix',overwrite,__compressed__);
// file_ln_propertyv2_file_deed to_get_file_ln_propertyv2_file_deed(file_ln_propertyv2_file_deed l, my_ln_propertyv2_file_search_did r):= transform
// self := l;
// end;
// my_ln_propertyv2_file_deed := join(file_ln_propertyv2_file_deed, my_ln_propertyv2_file_search_did, left.ln_fares_id=right.ln_fares_id, to_get_file_ln_propertyv2_file_deed(left,right), lookup);
// output(my_ln_propertyv2_file_deed ,,'~thor_data400::base::ln_propertyv2::deed_minix',overwrite,__compressed__);
// file_ln_propertyv2_file_assessment to_get_file_ln_propertyv2_file_assessment(file_ln_propertyv2_file_assessment l, my_ln_propertyv2_file_search_did r):= transform
// self := l;
// end;
// my_ln_propertyv2_file_assessment := join(file_ln_propertyv2_file_assessment, my_ln_propertyv2_file_search_DID, left.ln_fares_id=right.ln_fares_id, to_get_file_ln_propertyv2_file_assessment(left,right), lookup);
// output(my_ln_propertyv2_file_assessment ,,'~thor_data400::base::ln_propertyv2::assesor_minix',overwrite,__compressed__);
// file_ln_propertyv2_file_addl_fares_deed to_get_file_ln_propertyv2_file_addl_fares_deed(file_ln_propertyv2_file_addl_fares_deed l, my_ln_propertyv2_file_search_did r):= transform
// self := l;
// end;
// my_ln_propertyv2_file_addl_fares_deed := join(file_ln_propertyv2_file_addl_fares_deed, my_ln_propertyv2_file_search_did, left.ln_fares_id=right.ln_fares_id, to_get_file_ln_propertyv2_file_addl_fares_deed(left,right), lookup);
// output(my_ln_propertyv2_file_addl_fares_deed ,,'~thor_data400::base::ln_propertyv2::addl::fares_deed_minix',overwrite,__compressed__);
// file_ln_propertyv2_file_addl_fares_tax to_get_file_ln_propertyv2_file_addl_fares_tax(file_ln_propertyv2_file_addl_fares_tax l, my_ln_propertyv2_file_search_did r):= transform
// self := l;
// end;
// my_ln_propertyv2_file_addl_fares_tax := join(file_ln_propertyv2_file_addl_fares_tax, my_ln_propertyv2_file_search_did, left.ln_fares_id=right.ln_fares_id, to_get_file_ln_propertyv2_file_addl_fares_tax(left,right), lookup);
// output(my_ln_propertyv2_file_addl_fares_tax ,,'~thor_data400::base::ln_propertyv2::addl::fares_tax_minix',overwrite,__compressed__);
// file_ln_propertyv2_file_addl_legal to_get_file_ln_propertyv2_file_addl_legal(file_ln_propertyv2_file_addl_legal l, my_ln_propertyv2_file_search_did r):= transform
// self := l;
// end;
// my_ln_propertyv2_file_addl_legal := join(file_ln_propertyv2_file_addl_legal, my_ln_propertyv2_file_search_did, left.ln_fares_id=right.ln_fares_id, to_get_file_ln_propertyv2_file_addl_legal(left,right), lookup);
// output(my_ln_propertyv2_file_addl_legal,,'~thor_data400::base::ln_propertyv2::addl::legal_minix',overwrite,__compressed__);

// 400_84*
// file_vehiclev2_party   to_get_file_vehiclev2_party_d(file_vehiclev2_party l, my_dids r) := transform
// self := l;
// end;
// my_vehiclev2_party_d := join(file_vehiclev2_party, my_dids(did<>0), left.append_did=right.did, to_get_file_vehiclev2_party_d(left,right), lookup);
// file_vehiclev2_party   to_get_file_vehiclev2_party_b(file_vehiclev2_party l, my_bdids r) := transform
// self := l;
// end;
// my_vehiclev2_party_b := join(file_vehiclev2_party, my_bdids(bdid<>0), left.append_bdid=right.bdid, to_get_file_vehiclev2_party_b(left,right), lookup);
// my_vehiclev2_party := dedup(sort(my_vehiclev2_party_d(append_did<>0)+my_vehiclev2_party_b(append_bdid<>0),record),all);
// output(my_vehiclev2_party,,'~thor_data400::base::vehiclev2::party_minix', overwrite,__compressed__);
// file_vehiclev2_main to_get_file_vehiclev2_main(file_vehiclev2_main l, my_vehiclev2_party r) := transform
// self := l;
// end;
// my_vehiclev2_main := join(file_vehiclev2_main, my_vehiclev2_party, left.vehicle_key=right.vehicle_key, to_get_file_vehiclev2_main(left,right), lookup);
// output(my_vehiclev2_main,,'~thor_data400::base::vehiclev2::main_minix',overwrite,__compressed__);
