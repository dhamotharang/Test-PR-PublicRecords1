#workunit('name','Inquiries Stats');

import risk_indicators, ut, scoring_project_Macros,  Inquiry_AccLogs, doxie, data_services;

eyeball := 25;


//NonFCRA Weekly & Daily


df := Inquiry_AccLogs.File_Inquiry_Base.Update(bus_intel.industry <> '' and person_q.Appended_ADL > 0 and 
						StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] and
					stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

// inq_Prod_daily1 := INDEX(df, {unsigned6 s_did := person_q.appended_ADL}, {df},   //daily prod
															// '~thor_data400::key::inquiry::20170324::did_update');


// inq_cert_daily1 := INDEX(df, {unsigned6 s_did := person_q.appended_ADL}, {df},  //daily cert
															// '~thor_data400::key::inquiry::20170409::did_update');

// inq_prod_daily := pull(inq_prod_daily1);
// inq_cert_daily := pull(inq_cert_daily1);

inq_prod_weekly1 :=  INDEX(df, {unsigned6 s_did := person_q.appended_ADL}, {df},  //weekly prod
													'~thor_data400::key::inquiry::20170208::did');
													
													
inq_cert_weekly1 :=  INDEX(df, {unsigned6 s_did := person_q.appended_ADL}, {df},  //weekly cert
													'~thor_data400::key::inquiry::20170314::did');


inq_prod_weekly := pull(inq_prod_weekly1);
inq_cert_weekly := pull(inq_cert_weekly1);



// inq_cert_daily_distr := distribute(inq_cert_daily1, hash64(person_q.appended_adl));
// inq_prod_daily_distr := distribute(inq_prod_daily, hash64(person_q.appended_adl));

inq_cert_weekly_distr := distribute(inq_cert_weekly, hash64(person_q.appended_adl));
inq_prod_weekly_distr := distribute(inq_prod_weekly, hash64(person_q.appended_adl));



//Joins Cert data with the Prod data on did, transaction, seq # and datatime.  
// new := join(inq_cert_daily_distr, inq_prod_daily_distr, left.person_q.appended_adl = right.person_q.appended_adl 
new := join(inq_cert_weekly_distr, inq_prod_weekly_distr, left.person_q.appended_adl = right.person_q.appended_adl 
										and left.search_info.transaction_id = right.search_info.transaction_id
										and left.search_info.sequence_number = right.search_info.sequence_number
										and left.search_info.datetime = right.search_info.datetime,
										right only,local);

// Will output data that is only in prod (not in cert build) & count
output(choosen(new, 300));											
output(count(new), named('new'));

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




//table counts datetime

// datetime_cert_1 := table(inq_cert_daily_distr, {mydatetime := search_info.datetime[1..8]; _count := count(group)}, search_info.datetime[1..8], local);
datetime_cert_1 := table(inq_cert_weekly_distr, {mydatetime := search_info.datetime[1..8]; _count := count(group)}, search_info.datetime[1..8], local);
datetime_cert_2 := table(datetime_cert_1, {mydatetime; rec_count := sum(group, _count)}, mydatetime);

// datetime_Prod_1 := table(inq_prod_daily_distr, {mydatetime := search_info.datetime[1..8]; _count := count(group)}, search_info.datetime[1..8], local);
datetime_Prod_1 := table(inq_prod_weekly_distr, {mydatetime := search_info.datetime[1..8]; _count := count(group)}, search_info.datetime[1..8], local);
datetime_Prod_2 := table(datetime_Prod_1, {mydatetime; rec_count := sum(group, _count)}, mydatetime);

cmpr := record
	recordof(datetime_cert_2) cert;
	recordof(datetime_prod_2) prod;
end;

datetime_join := join(datetime_cert_2, datetime_prod_2, left.mydatetime=right.mydatetime,
	transform(cmpr, self.cert := left, self.prod := right),
	full outer);
output(datetime_join, all,  named('datetime_join'));

//the below tables will not work on the nonFCRA weekly, too large and code fails due to skew limit errors

/*
Industry_cert_1 := table(inq_cert_weekly_distr, {myindustry := bus_intel.Industry; _count := count(group)}, bus_intel.Industry, local);
Industry_cert_2 := table(Industry_cert_1, {myindustry; rec_count := sum(group, _count)}, myindustry);

Industry_Prod_1 := table(inq_prod_weekly_distr, {myindustry := bus_intel.Industry; _count := count(group)}, bus_intel.Industry);
Industry_Prod_2 := table(Industry_Prod_1, {myindustry; rec_count := sum(group, _count)}, myindustry);

cmpr2 := record
	recordof(industry_cert_2) cert;
	recordof(industry_prod_2) prod;
end;

industry_join := join(industry_cert_2, industry_prod_2, left.myindustry=right.myindustry,
	transform(cmpr2, self.cert := left, self.prod := right),
	full outer);
output(industry_join, all, named('industry_join'));

vertical_cert_1 := table(inq_cert_weekly_distr, {myvertical := bus_intel.vertical; _count := count(group)}, bus_intel.vertical, local);
vertical_cert_2 := table(vertical_cert_1, {myvertical; rec_count := sum(group, _count)}, myvertical);

vertical_Prod_1 := table(inq_prod_weekly_distr, {myvertical := bus_intel.vertical; _count := count(group)}, bus_intel.vertical, local);
vertical_Prod_2 := table(vertical_Prod_1, {myvertical; rec_count := sum(group, _count)}, myvertical);


cmpr3 := record
	recordof(vertical_cert_2) cert;
	recordof(vertical_prod_2) prod;
end;

vertical_join := join(vertical_cert_2, vertical_prod_2, left.myvertical=right.myvertical,
	transform(cmpr3, self.cert := left, self.prod := right),
	full outer);
output(vertical_join, all, named('vertical_join'));
*/