#workunit('name','FCRA Inquiries');

import risk_indicators, ut, scoring_project_Macros, Scoring_Project_PIP, Inquiry_AccLogs, doxie, data_services;

eyeball := 25;


// input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout;
// input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V201_AmericanExpress_Global_Layout;
// input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout;
// input_layout := scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V4_Global_Layout;  //V3 or V4


pii_layout := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
 

basefilename :=  '~scoringqa::out::fcra::bocashell_50_historydate_999999_cert_20170804_1';            //FCRA     
testfilename := '~scoringqa::out::fcra::bocashell_50_historydate_999999_cert_20170805_1';
Layout2 := Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;  //FCRA

ds_baseline_daily := dataset(basefilename,Layout2, thor);
ds_new_daily := dataset(testfilename,Layout2, thor);


clean_ds_baseline_daily := ds_baseline_daily(errorcode='');
clean_ds_new_daily := ds_new_daily(errorcode='');


// output(ave(clean_ds_baseline_daily, (integer)searchcount), named('prev_ave_sample'));
// output(ave(clean_ds_new_daily, (integer)searchcount), named('curr_ave_sample'));

j1 := join(clean_ds_baseline_daily, clean_ds_new_daily, left.AccountNumber = right.AccountNumber
					AND left.acc_logs.inquiries.counttotal <> RIGHT.acc_logs.inquiries.counttotal,
					TRANSFORM(Layout2, SELF := right));

// j2 := join(clean_ds_baseline_daily, clean_ds_new_daily, left.acctno = right.acctno
					// AND (integer)LEFT.results.fp_score	<> (integer)RIGHT.results.fp_score	
					// AND (integer)LEFT.searchcount <> (integer)RIGHT.searchcount,
					// TRANSFORM(Layout2, SELF := right));
					

					
					
// output(ave(j1, (integer)searchcount), named('prev_ave_sub_sample'));
// output(ave(j2, (integer)searchcount), named('curr_ave_sub_sample'));

// output(count(j1), named('diff_count'));

t1_daily := project(j1, transform({integer appended_adl}, self.appended_adl := (integer) left.did));
// t2_weekly := project(j3, transform({integer did}, self.did := (integer) left.did));

s1_daily := set(t1_daily, (integer)appended_adl);
output(count(s1_daily));
// s2_weekly := set(t2_weekly, (integer)DID);

HashDS := distribute(project(inquiry_acclogs.File_FCRA_Inquiry_Base(bus_intel.industry <> '' and person_q.appended_adl > 0 and
					trim(bus_intel.vertical)<>'' and
					StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
					['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']), 
																							transform(inquiry_acclogs.Layout.Common_Indexes_FCRA_DID_SBA,
																													self.mbs.company_id := '';
																													self.mbs.global_company_id := '',
																													self := left,
																													self := [] )), hash(person_q.appended_adl));

Key_FCRA_DID_old := index(HashDS, {person_q.appended_adl}, {HashDS}, 
					// '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+ 'thor_data400::key::inquiry::fcra::20161129::did');
					'~foreign::' + _control.IPAddress.prod_thor_dali + '::'+ 'thor_data400::key::inquiry::fcra::20170704a::did');

Key_FCRA_DID_new := index(HashDS, {person_q.appended_adl}, {HashDS}, 
					'~foreign::' + _control.IPAddress.prod_thor_dali + '::'+ 'thor_data400::key::inquiry::fcra::20170721::did');
				
results_daily_old := Key_FCRA_DID_old(appended_adl in s1_daily and search_info.datetime[1..6] > '201501');			
results_daily_new := Key_FCRA_DID_new(appended_adl in s1_daily and search_info.datetime[1..6] > '201501');			


datetime_cert_1 := table(results_daily_new, {mydatetime := search_info.datetime[1..8]; _count := count(group)}, search_info.datetime[1..8], local);
datetime_cert_2 := table(datetime_cert_1, {mydatetime; rec_count := sum(group, _count)}, mydatetime);

datetime_Prod_1 := table(results_daily_old , {mydatetime := search_info.datetime[1..8]; _count := count(group)}, search_info.datetime[1..8], local);
datetime_Prod_2 := table(datetime_Prod_1, {mydatetime; rec_count := sum(group, _count)}, mydatetime);


cmpr := record
	recordof(datetime_cert_2) cert;
	recordof(datetime_prod_2) prod;
end;

datetime_join := join(datetime_cert_2, datetime_prod_2, left.mydatetime=right.mydatetime,
	transform(cmpr, self.cert := left, self.prod := right),
	full outer);
output(datetime_join, all,  named('datetime_join'));
		
		
		

Industry_cert_1 := table(results_daily_new, {myindustry := bus_intel.Industry; _count := count(group)}, bus_intel.Industry, local);
Industry_cert_2 := table(Industry_cert_1, {myindustry; rec_count := sum(group, _count)}, myindustry);

Industry_Prod_1 := table(results_daily_old, {myindustry := bus_intel.Industry; _count := count(group)}, bus_intel.Industry);
Industry_Prod_2 := table(Industry_Prod_1, {myindustry; rec_count := sum(group, _count)}, myindustry);

cmpr2 := record
	recordof(industry_cert_2) cert;
	recordof(industry_prod_2) prod;
end;

industry_join := join(industry_cert_2, industry_prod_2, left.myindustry=right.myindustry,
	transform(cmpr2, self.cert := left, self.prod := right),
	full outer);
output(industry_join, all, named('industry_join'));

vertical_cert_1 := table(results_daily_new, {myvertical := bus_intel.vertical; _count := count(group)}, bus_intel.vertical, local);
vertical_cert_2 := table(vertical_cert_1, {myvertical; rec_count := sum(group, _count)}, myvertical);

vertical_Prod_1 := table(results_daily_old , {myvertical := bus_intel.vertical; _count := count(group)}, bus_intel.vertical, local);
vertical_Prod_2 := table(vertical_Prod_1, {myvertical; rec_count := sum(group, _count)}, myvertical);


cmpr3 := record
	recordof(vertical_cert_2) cert;
	recordof(vertical_prod_2) prod;
end;

vertical_join := join(vertical_cert_2, vertical_prod_2, left.myvertical=right.myvertical,
	transform(cmpr3, self.cert := left, self.prod := right),
	full outer);
output(vertical_join, all, named('vertical_join'));		
		
		
new := join(results_daily_old, results_daily_new, left.appended_adl = right.appended_adl 
										and left.search_info.transaction_id = right.search_info.transaction_id
										and left.search_info.sequence_number = right.search_info.sequence_number
										and left.search_info.datetime = right.search_info.datetime,
											left only);
											



output(new, named('inquiries_not_in_v20161129'));

		// new_dedup := dedup(	new, appended_adl);
		// output(count(new_dedup), named('number_of_did_with_inquiry_change_right_only'));	


tbl_did_new := table(new, {search_info.function_description; _count := count(group)}, search_info.function_description);
tbl_did_new2 := table(new, {Bus_intel.primary_market_code	; _count := count(group)}, Bus_intel.primary_market_code);
tbl_did_new3 := table(new, {Bus_intel.secondary_market_code	; _count := count(group)}, Bus_intel.secondary_market_code);
tbl_did_new4 := table(new, {Bus_intel.industry_1_code	; _count := count(group)}, Bus_intel.industry_1_code);
tbl_did_new5 := table(new, {Bus_intel.industry_2_code	; _count := count(group)}, Bus_intel.industry_2_code);
tbl_did_new6 := table(new, {Bus_intel.sub_market		; _count := count(group)}, Bus_intel.sub_market);
tbl_did_new7 := table(new, {Bus_intel.vertical		; _count := count(group)}, Bus_intel.vertical);
tbl_did_new8 := table(new, {Bus_intel.industry		; _count := count(group)}, Bus_intel.industry);
output(tbl_did_new, named('function_description'));
output(tbl_did_new2, named('primary_market_code'));
output(tbl_did_new3, named('secondary_market_code'));
output(tbl_did_new4, named('industry_1_code'));
output(tbl_did_new5, named('industry_2_code'));
output(tbl_did_new6, named('sub_market'));
output(tbl_did_new7, named('vertical'));
output(tbl_did_new8, named('industry'));

Models_rv_batch := new(search_info.function_description = 'MODELS.RISKVIEWBATCHSERVICE');

output(Models_rv_batch, named('Models_rv_batch_tranactions'));
