#workunit('name','FCRA Inquiries');

import risk_indicators, ut, scoring_project_Macros, Inquiry_AccLogs, doxie, data_services;

eyeball := 25;


HashDS := distribute(project(inquiry_acclogs.File_FCRA_Inquiry_Base(bus_intel.industry <> '' and person_q.appended_adl > 0 and
					trim(bus_intel.vertical)<>'' and
					StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
					['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']), 
																							transform(inquiry_acclogs.Layout.Common,
																													self.mbs.company_id := '';
																													self.mbs.global_company_id := '',
																													self := left)), hash(person_q.appended_adl));

Key_FCRA_DID_prod := index(HashDS, {person_q.appended_adl}, {HashDS}, 
					'~thor_data400::key::inquiry::fcra::20170122::did');

Key_FCRA_DID_cert := index(HashDS, {person_q.appended_adl}, {HashDS}, 
					'~thor_data400::key::inquiry::fcra::20170322::did');
				
results_daily_Prod := pull(Key_FCRA_DID_prod);			
results_daily_Cert := pull(Key_FCRA_DID_cert);			

inq_prod_FCRA_distr := distribute(results_daily_Prod, hash64(person_q.appended_adl));
inq_cert_FCRA_distr := distribute(results_daily_Cert, hash64(person_q.appended_adl));

//Joins Cert data with the Prod data on did, transaction, seq # and datatime.  

new := join(inq_cert_FCRA_distr, inq_prod_FCRA_distr, left.appended_adl = right.appended_adl 
										and left.search_info.transaction_id = right.search_info.transaction_id
										and left.search_info.sequence_number = right.search_info.sequence_number
										and left.search_info.datetime = right.search_info.datetime,
											right only, local);
											
// Will output data that is only in prod (not in cert build) & count

output(choosen(new,200));
output(count(new));

//table missing prod data for the Bus_intel section & some Search_info. 

tbl_did_new := table(new, {myfun := search_info.function_description; _count := count(group)}, search_info.function_description, local);
fun_table	:= table(tbl_did_new, {myfun; rec_count := sum(group, _count)}, myfun);

tbl_did_new2 := table(new, {my_market_code := Bus_intel.primary_market_code	; _count := count(group)}, Bus_intel.primary_market_code, local);
market_code_table	:= table(tbl_did_new2, {my_market_code; rec_count := sum(group, _count)}, my_market_code);

tbl_did_new3 := table(new, {my_2_market_code := Bus_intel.secondary_market_code	; _count := count(group)}, Bus_intel.secondary_market_code, local);
second_market_code_table	:= table(tbl_did_new3, {my_2_market_code; rec_count := sum(group, _count)}, my_2_market_code);

tbl_did_new4 := table(new, {my_industry_1 := Bus_intel.industry_1_code	; _count := count(group)}, Bus_intel.industry_1_code, local);
industry_1_table	:= table(tbl_did_new4, {my_industry_1; rec_count := sum(group, _count)}, my_industry_1);

tbl_did_new5 := table(new, {my_industry_2 := Bus_intel.industry_2_code	; _count := count(group)}, Bus_intel.industry_2_code, local);
industry_2_table	:= table(tbl_did_new5, {my_industry_2; rec_count := sum(group, _count)}, my_industry_2);

tbl_did_new6 := table(new, {my_sub_market := Bus_intel.sub_market		; _count := count(group)}, Bus_intel.sub_market, local);
sub_market_table	:= table(tbl_did_new6, {my_sub_market; rec_count := sum(group, _count)}, my_sub_market);

tbl_did_new7 := table(new, {my_vertical := Bus_intel.vertical		; _count := count(group)}, Bus_intel.vertical, local);
vertical_table	:= table(tbl_did_new7, {my_vertical; rec_count := sum(group, _count)}, my_vertical);

tbl_did_new8 := table(new, {my_industry := Bus_intel.industry		; _count := count(group)}, Bus_intel.industry, local);
industry_table	:= table(tbl_did_new8, {my_industry; rec_count := sum(group, _count)}, my_industry);

tbl_did_new9 := table(new, {mydate := search_info.datetime[1..8]; _count := count(group)}, search_info.datetime[1..8], local);
date_table	:= table(tbl_did_new9, {mydate; rec_count := sum(group, _count)},mydate);

output(fun_table, named('function_description'));
output(market_code_table, named('primary_market_code'));
output(second_market_code_table, named('secondary_market_code'));
output(industry_1_table, named('industry_1_code'));
output(industry_2_table, named('industry_2_code'));
output(sub_market_table, named('sub_market'));
output(vertical_table, named('vertical'));
output(industry_table, named('industry'));
output(date_table, named('datetime'));



datetime_cert_1 := table(inq_cert_FCRA_distr, {mydatetime := search_info.datetime[1..8]; _count := count(group)}, search_info.datetime[1..8], local);
datetime_cert_2 := table(datetime_cert_1, {mydatetime; rec_count := sum(group, _count)}, mydatetime);

datetime_Prod_1 := table(inq_prod_FCRA_distr, {mydatetime := search_info.datetime[1..8]; _count := count(group)}, search_info.datetime[1..8], local);
datetime_Prod_2 := table(datetime_Prod_1, {mydatetime; rec_count := sum(group, _count)}, mydatetime);


cmpr := record
	recordof(datetime_cert_2) cert;
	recordof(datetime_prod_2) prod;
end;

datetime_join := join(datetime_cert_2, datetime_prod_2, left.mydatetime=right.mydatetime,
	transform(cmpr, self.cert := left, self.prod := right),
	full outer);
output(datetime_join, all,  named('datetime_join'));
