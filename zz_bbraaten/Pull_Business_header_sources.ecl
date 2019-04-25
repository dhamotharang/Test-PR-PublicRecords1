#workunit('name','business header 20171215');
import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP,Business_Header;


eyeball := 30;

//need to sandbox Business_Header_SS.Key_BH_BDID_pl
// last line change to..... '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::business_header:://*Build Version*//::search::bdid.pl');
//need to import _control

//Pull key and output sample
results_Cert_Key_BH_BDID_pl := pull(Business_Header_SS.Key_BH_BDID_pl);//sandbox to run		
output(choosen(results_Cert_Key_BH_BDID_pl, eyeball),named('recs_from_header'));

//Distribute so it runs nicer
Cert_Key_BH_BDID_pl_distr := distribute(results_Cert_Key_BH_BDID_pl, hash64(bdid));

//Table All sources in above key
tbl_did_new_cert := table(Cert_Key_BH_BDID_pl_distr, {mysrc := source; _count := count(group)}, source, local);
cert_table	:= table(tbl_did_new_cert, {mysrc; rec_count := sum(group, _count)}, mysrc);


finduniqueBdid := dedup(Cert_Key_BH_BDID_pl_distr,bdid);
count_bdid := count(finduniqueBdid);
output(count_bdid, named('count_unique_bdid'));

sort_output := sort(cert_table, mysrc);
output(choosen(sort_output, all),Named('table_of_source_counts'));


