#workunit('name','NGCDL2.CDL - IT1 - Results')

import ngcdl2;

iteration_name := 'IT1';

new_ch := dataset('~thor_data400::temp::cdl::ngcdl2::'+iteration_name,crim_header.layout_crim_header,flat);
ds := pull(ngcdl2.Keys.matchsample);
watchlist := new_ch(offender_key in crim_header.watchlist_offender_keys 
													or
									  did in crim_header.watchlist_dids);
//
used :=ds(conf>=47);
good :=used(
	(left_offender_key=right_offender_key) or
	(left_did=right_did and left_did<>0 and right_did<>0) or
	(left_fbi_num=right_fbi_num and left_fbi_num<>'' and right_fbi_num<>'') or
	(left_ncic_number=right_ncic_number and left_ncic_number<>'' and right_ncic_number<>'') or
	(left_dl_num=right_dl_num  and left_dl_num<>'' and right_dl_num<>'' and (left_dl_state=right_dl_state or left_dl_state='' or right_dl_state='')) or
	(left_dle_num=right_dle_num  and left_dle_num<>'' and right_dle_num<>'' and (left_state_origin=right_state_origin or left_state_origin='' or right_state_origin='')) or
	(left_doc_num=right_doc_num  and left_doc_num<>'' and right_doc_num<>'' and (left_state_origin=right_state_origin or left_state_origin='' or right_state_origin='')) or
	(left_case_number=right_case_number  and left_case_number<>'' and right_case_number<>'' and (left_state_origin=right_state_origin or left_state_origin='' or right_state_origin='')) or
	(left_state=right_state and left_p_city_name=right_p_city_name and left_lname=right_lname and left_fname=right_fname and left_dob=right_dob and 
		 left_state<>'' and right_state<>'' and 
		 left_p_city_name<>'' and right_p_city_name<>'' and 
		 left_lname<>'' and right_lname<>'' and 
		 left_fname<>'' and right_fname<>'' and
		 left_dob<>0 and right_dob<>0) or
	(false));
didx :=used(left_offender_key<>right_offender_key and left_did<>right_did and left_did<>0 and right_did<>0);
ofkx :=used(left_offender_key<>right_offender_key);
dlx	:=used(left_dl_num<>right_dl_num and left_dl_num<>'' and right_dl_num<>'');
namx := used(left_offender_key<>right_offender_key and left_lname<>right_lname);
watchlist_recs := table(watchlist,{cdl});
watchlist_cdls := dedup(sort(watchlist_recs,cdl),cdl);
//
ttl	:=count(ds);
ttl_used :=count(used);
ttl_good :=count(good);
ttl_didx := count(didx);
ttl_dlx := count(dlx);
ttl_namx := count(namx);
ttl_ofkx := count(ofkx);
ttl_watchlist_recs := count(watchlist_recs);
ttl_watchlist_cdls := count(watchlist_cdls);
//
test_matches := sort(dedup(sort(enth(didx,25)+enth(dlx,10)+enth(namx,25)+enth(ofkx(conf<=50),200)+enth(used(conf<=50),150)+enth(used(conf>50),90),record),record),cdl2);
//
s01:=output(ttl,named('Total_matched_records'));
s02:=output(ttl_used,named('Total_used_ge_47'));
s02g:=output(ttl_good,named('Total_easy_good'));
s02p:=output(100*ttl_good/ttl_used,named('Percent_easy_good'));
s03:=output(ttl_didx,named('Total_did_disagree'));
s04:=output(ttl_dlx,named('Total_dl_disagree'));
s05:=output(ttl_namx,named('Total_lname_disagree'));
s06:=output(ttl_ofkx,named('Total_offender_key_disagree'));
//
s07:=output(choosen(test_matches,100,1),  named('set1'));
s08:=output(choosen(test_matches,100,101),named('set2'));
s09:=output(choosen(test_matches,100,201),named('set3'));
s10:=output(choosen(test_matches,100,301),named('set4'));
s11:=output(choosen(test_matches,100,401),named('set5'));
s12:=output(choosen(test_matches,100,201),named('set6'));
//
w01:=output(ttl_watchlist_recs,named('Total_watchlist_records'));
w02:=output(ttl_watchlist_cdls,named('Total_watchlist_cdls'));
w03:=output(choosen(watchlist_cdls,1000),named('Watchlist_set'));
//
// update keys for get cdl service with this iterations data(new_ch)
//
k01:=fileservices.clearsuperfile('~thor_data400::key::crim_header_cdl_qa');
k02:=buildindex(new_ch,{unsigned6 i_cdl := cdl},{new_ch},'~thor_data400::key::crim_header_cdl_'+iteration_name,overwrite);
k03:=fileservices.addsuperfile('~thor_data400::key::crim_header_cdl_qa','~thor_data400::key::crim_header_cdl_'+iteration_name);
//
layout_sample_rids := record
unsigned6 rid;
end;
layout_sample_rids to_slim_sample(ds l,integer c) := transform
self.rid := choose(c,l.rid1,l.rid2);
end;
sample_rids := normalize(ds,2,to_slim_sample(left,counter));
//
k04:=fileservices.clearsuperfile('~thor_data400::key::crim_header_sample_rids_qa');
k05:=buildindex(sample_rids,{unsigned6 i_rid := rid},{sample_rids},'~thor_data400::key::crim_header_sample_rids_'+iteration_name,overwrite);
k06:=fileservices.addsuperfile('~thor_data400::key::crim_header_sample_rids_qa','~thor_data400::key::crim_header_sample_rids_'+iteration_name);
//
k07:=fileservices.clearsuperfile('~thor_data400::base::crim_header_match_sample_qa');
k08:=output(used,,'~thor_data400::base::crim_header_match_sample_'+iteration_name,__COMPRESSED__,overwrite);
k09:=fileservices.addsuperfile('~thor_data400::base::crim_header_match_sample_qa','~thor_data400::base::crim_header_match_sample_'+iteration_name);
//
sequential(s01,s02,s02g,s02p,s03,s04,s05,s06,s07,s08,s09,s10,s11,s12,w01,w02,w03,k01,k02,k03,k04,k05,k06,k07,k08,k09);
