//
// get the sample set
//
layout_dids := record
string12	did;
end;
sample_set_of_dids := dataset('~thor_200::temp::rvh_sample_set_dids',layout_dids,flat);
sample_set_of_dids_dist := distribute(sample_set_of_dids, hash(did));
layout_didi := record
unsigned integer6 did
end;
layout_didi dids_to_didi(sample_set_of_dids l) := transform
	self.did := (unsigned integer6) l.did;
end;
sample_set_of_didi := project(sample_set_of_dids,dids_to_didi(left));
sample_set_of_didi_dist := distribute(sample_set_of_didi,hash(did));

layout_bdids := record
string12 bdid
end;
sample_set_of_bdids := dataset('~thor_200::temp::rvh_sample_set_bdids',layout_bdids,flat);
sample_set_of_bdids_dist := distribute(sample_set_of_bdids,hash(bdid));
layout_bdidi := record
unsigned integer6 bdid;
end;
layout_bdidi  bdids_to_bdidi(sample_set_of_bdids l) := transform
	self.bdid := (unsigned integer6) l.bdid;
	end;
sample_set_of_bdidi := project(sample_set_of_bdids,bdids_to_bdidi(left));
sample_set_of_bdidi_dist := distribute(sample_set_of_bdidi,hash(bdid));
//
// output business set
// 
//business_header.Layout_Business_Contact_Plus business_contacts_from_did(business_header.File_Business_Contacts_Plus l, sample_set_of_didi_dist r) := transform
//self := l;
//end;
//my_file_business_contacts_plus := join(distribute(business_header.File_Business_Contacts_Plus(did<>0),hash(did)), sample_set_of_didi_dist(did<>0), left.did= right.did, business_contacts_from_did(left,right), local);
//output(my_file_business_contacts_plus,,'~thor_200::temp::file_business_contacts_plus',overwrite);
//
//*business_header.Layout_Business_Relative business_relatives_from_bdid(business_header.file_business_relatives l, sample_set_of_bdidi_dist r) := transform
//*self := l;
//*end;
//*my_file_business_relatives1 := join(distribute(business_header.file_business_relatives,hash(bdid1)), sample_set_of_bdidi_dist, left.bdid1=right.bdid, business_relatives_from_bdid(left,right),local);
//*my_file_business_relatives2 := join(distribute(business_header.file_business_relatives,hash(bdid2)), sample_set_of_bdidi_dist, left.bdid2=right.bdid, business_relatives_from_bdid(left,right),local);
//*my_file_business_relatives := my_file_business_relatives1+my_file_business_relatives2;
//*output(my_File_Business_Relatives,,'~thor_200::temp::file_business_relatives',overwrite);
//
//business_header.Layout_Business_Header_Base business_header_from_bdid(business_header.File_Business_Header_Base l, sample_set_of_bdidi_dist r) := transform
//self := l;
//end;
//my_file_business_header_base := join(distribute(business_header.file_business_header_base(bdid<>0),hash(bdid)), sample_set_of_bdidi_dist(bdid<>0), left.bdid=right.bdid, business_header_from_bdid(left,right), local);
//output(my_File_Business_Header_Base,,'~thor_200::temp::file_business_header_base',overwrite);
//
//business_header.Layout_Employment_Out employment_out_from_did(business_header.File_Employment_Out l, sample_set_of_dids_dist r) := transform
//self := l;
//end;
//my_file_employment_out := join(distribute(business_header.file_employment_out(did<>'' and did<>'000000000000'),hash(did)),sample_set_of_dids_dist, left.did=right.did, employment_out_from_did(left,right),local);
//output(my_file_employment_out,,'~thor_200::temp::file_employment_out',overwrite);
//
// gong history, gong and phones plus 400 way
// 
//gong.layout_history gong_file_history_from_did(gong.file_history l,sample_set_of_didi_dist r) := transform
//self := l;
//end;
//my_gong_file_history := join(distribute(gong.file_history(did<>0),hash(did)),sample_set_of_didi_dist, left.did=right.did, gong_file_history_from_did(left,right),local);
//output(my_gong_file_history,,'~thor_200::temp::file_gong.file_history',overwrite);
//
//gong.layout_gong gongbase_from_phone(gong.File_GongBase l,my_gong_file_history r) := transform
//self := l;
//end;
//my_file_gongbase := join(distribute(gong.file_gongbase(phoneno<>'' and phoneno<>'0000000000'),hash(phoneno)),distribute(my_gong_file_history(phone10<>'' and phone10<>'0000000000'),hash(phone10)), left.phoneno=right.phone10, gongbase_from_phone(left,right),local);
//output(my_file_gongbase,,'~thor_200::temp::file_gong_base',overwrite);
//
//phonesplus.layoutCommonOut phonesplus_from_did(phonesplus.file_phonesplus_base l,sample_set_of_didi_dist r) := transform
//self := l;
//end;
//my_file_phonesplus_base := join(distribute(phonesplus.file_phonesplus_base(did<>0),hash(did)), sample_set_of_didi_dist, left.did=right.did, phonesplus_from_did(left,right),local);
//output(my_file_phonesplus_base,,'~thor_200::temp::file_phonesplus_base',overwrite);
//
// output person set 
// 
//header.Layout_Relatives relatives_from_did(header.file_relatives l, sample_set_of_didi r) := transform
//self := l;
//end;
//my_file_relatives1 := join(distribute(header.file_relatives,hash(person1)), sample_set_of_didi_dist,left.person1=right.did, relatives_from_did(left,right),local);
//my_file_relatives2 := join(distribute(header.file_relatives,hash(person2)), sample_set_of_didi_dist,left.person2=right.did, relatives_from_did(left,right),local);
//my_file_relatives := my_file_relatives1+my_file_relatives2;
//output(my_file_relatives,,'~thor_200::temp::file_relatives',overwrite);
//
//drivers.Layout_DL file_dl_from_did(drivers.file_dl l, sample_set_of_didi r) := transform
//self := l;
//end;
//my_file_dl := join(distribute(drivers.file_dl(did<>0), hash(did)),sample_set_of_didi_dist, left.did=right.did,file_dl_from_did(left,right),local);
//output(my_file_dl,,'~thor_200::temp::file_dl',overwrite);
//
//emerges.layout_voters_out  file_voters_base_from_did(emerges.file_voters_base l, sample_set_of_dids r) := transform
//self := l;
//end;
//my_file_voters_base := join(distribute(emerges.file_voters_base(did_out<>'000000000000' and did_out<>''),hash(did_out)), sample_set_of_dids_dist, left.did_out=right.did, file_voters_base_from_did(left,right),local);
//output(my_file_voters_base,,'~thor_200::temp::file_voters_base',overwrite);
//
//header.Layout_Header file_headers_from_did(header.file_headers l, sample_set_of_didi r) := transform
//self := l;
//end;
//my_file_headers := join(header.file_headers, sample_set_of_didi_dist, left.did=right.did,file_headers_from_did(left,right),local);
//output(my_file_headers,,'~thor_200::temp::file_headers',overwrite);
//
//watchdog.Layout_Best file_best_from_did(watchdog.file_best l, sample_set_of_didi r) := transform
//self := l;
//end;
//my_file_best := join(distribute(watchdog.file_best,hash(did)), sample_set_of_didi_dist,left.did=right.did,file_best_from_did(left,right),local);
//output(my_file_best,,'~thor_200::temp::file_best_12345',overwrite);
//
// ln_fares_id dependant set
// 
//LN_Property.Layout_DID_Out file_search_from_did(ln_property.file_search_did l, sample_set_of_didi r) := transform
//self := l;
//end;
//LN_Property.Layout_DID_Out file_search_from_bdid(ln_property.file_search_did l, sample_set_of_bdidi r) := transform
//self := l;
//end;
//my_file_search_did := join(distribute(ln_property.File_Search_DID(did<>0),hash(did)),sample_set_of_didi_dist, left.did=right.did,file_search_from_did(left,right),local);
//my_file_search_bdid:= join(distribute(ln_property.File_Search_DID(bdid<>0),hash(bdid)),sample_set_of_bdidi_dist, left.bdid=right.bdid,file_search_from_bdid(left,right),local);
//my_file_search := my_file_search_did+my_file_search_bdid;
//output(my_file_search,,'~thor_200::temp::file_search_did',overwrite);
//
//layout_id_only := record
// string12  ln_fares_id;
//end;
//my_ids := dedup(sort(distribute(project(my_file_search,layout_id_only),hash(ln_fares_id)),ln_fares_id,local),ln_fares_id,local);
//ln_property.Layout_Property_Common_Model_BASE assessment_from_fares_id(ln_property.file_assessment l, my_ids r) := transform
//self := l;
//end;
//my_file_assessment := join(distribute(ln_property.file_assessment,hash(ln_fares_id)), my_ids, left.ln_fares_id=right.ln_fares_id, assessment_from_fares_id(left,right),local);
//output(my_file_assessment,,'~thor_200::temp::file_assessment',overwrite);
//
//ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base deed_from_fares_id(ln_property.file_deed l, my_ids r) := transform
//self := l;
//end;
//my_file_deed := join(distribute(ln_property.File_Deed,hash(ln_fares_id)),my_ids, left.ln_fares_id=right.ln_fares_id, deed_from_fares_id(left,right),local);
//output(my_file_deed,,'~thor_200::temp::file_deed',overwrite);
//
// eq utility
//utilfile.Layout_DID_Out file_util_daily_from_did(utilfile.file_util_daily l, sample_set_of_dids r) := transform
//self := l;
//end;
//my_file_util_daily := join(distribute(utilfile.file_util_daily,hash(did)), sample_set_of_dids_dist, left.did=right.did, file_util_daily_from_did(left,right),local);
//output(my_file_util_daily,,'~thor_200::temp::file_util_daily',overwrite);
//
