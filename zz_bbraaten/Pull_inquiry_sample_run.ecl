#workunit('name','Inquiries');

import risk_indicators, ut, scoring_project_Macros,  Inquiry_AccLogs, doxie, data_services;

eyeball := 25;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout;  // v3 or v4

// pii_layout := RECORD
  // Scoring_Project_Macros.Regression.global_layout;
	// Scoring_Project_Macros.Regression.pii_layout;
	// Scoring_Project_Macros.Regression.runtime_layout;
 // END;
  

basefilename := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v4_20180312_1';    // v3 or v4   XML or Batch
testfilename := '~scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v4_20180314_1';
// pii_name := scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;   


ds_baseline_daily := dataset(basefilename,input_layout, thor);
ds_new_daily := dataset(testfilename,input_layout, thor);


// ds_baseline_weekly := dataset(basefilename2,input_layout, thor);
// ds_new_weekly := dataset(testfilename2,input_layout, thor);
// ds_pii := dataset(pii_name, pii_layout, thor);

clean_ds_baseline_daily := ds_baseline_daily(errorcode='');
clean_ds_new_daily := ds_new_daily(errorcode='');

// clean_ds_baseline_weekly := ds_baseline_weekly(errorcode='');
// clean_ds_new_weekly := ds_new_weekly(errorcode='');
	
// output(count(clean_ds_baseline(errorcode <> '')),named('base_errors'));
// output(count(clean_ds_new(errorcode <> '')),named('prop_errors'));

// output(ave(clean_ds_baseline_daily, (integer)prsearchothercount), named('prev_ave_sample'));
// output(ave(clean_ds_new_daily, (integer)prsearchothercount), named('curr_ave_sample'));

j1 := join(clean_ds_baseline_daily, clean_ds_new_daily, left.accountnumber = right.accountnumber
					// AND (integer)LEFT.results.fp_score	<> (integer)RIGHT.results.fp_score	
					AND (integer)LEFT.PRSearchLocateCount > (integer)RIGHT.PRSearchLocateCount,
					TRANSFORM(input_layout, SELF := LEFT));

// j2 := join(clean_ds_baseline_daily, clean_ds_new_daily, left.acctno = right.acctno,
					// AND (integer)LEFT.results.fp_score	<> (integer)RIGHT.results.fp_score	
					// AND (integer)LEFT.prsearchothercount <> (integer)RIGHT.prsearchothercount,
					// TRANSFORM(input_layout, SELF := right));
					
	// j3 := join(clean_ds_baseline_weekly, clean_ds_new_weekly, left.acctno = right.acctno
					// AND (integer)LEFT.results.fp_score	<> (integer)RIGHT.results.fp_score	
					// AND (integer)LEFT.searchcount <> (integer)RIGHT.searchcount,
					// TRANSFORM(input_layout, SELF := LEFT));	
					
	// j4 := join(clean_ds_baseline_weekly, clean_ds_new_weekly, left.acctno = right.acctno
					// AND (integer)LEFT.results.fp_score	<> (integer)RIGHT.results.fp_score	
					// AND (integer)LEFT.searchcount <> (integer)RIGHT.searchcount,
					// TRANSFORM(input_layout, SELF := LEFT));				
					
					
					
// output(ave(j1, (integer)prsearchothercount), named('prev_ave_sub_sample'));
// output(ave(j2, (integer)prsearchothercount), named('curr_ave_sub_sample'));

// output(count(j1), named('diff_count'));

t1_daily := project(j1, transform({integer s_did}, self.s_did := (integer) left.did));
// t2_weekly := project(j3, transform({integer did}, self.did := (integer) left.did));

s1_daily := set(t1_daily, (integer)s_did);
// output(count(s1_daily));
// s2_weekly := set(t2_weekly, (integer)DID);

// output(s1);

// df := Inquiry_AccLogs.File_Inquiry_Base.history(bus_intel.industry <> '' and person_q.Appended_ADL > 0 and 
						// StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] and
					// stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

// inq := Inquiry_AccLogs.Key_Inquiry_DID;
// inq_Cert := Inquiry_AccLogs.Key_Inquiry_DID_Update;
// inq_Prod := INDEX(df, {unsigned6 s_did := person_q.appended_ADL}, {df},
																// Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry::20160209::did');

df := Inquiry_AccLogs.File_Inquiry_Base.history;

// (bus_intel.industry <> '' and person_q.Appended_ADL > 0 and 
						// StringLib.StringToUpperCase(trim(search_info.function_description)) not in ['MODELS.ITA_BATCH_SERVICE', 'RISKWISE IP SEARCH (NA99)'] and
					// stringlib.stringfind(search_info.function_description, 'INTERNATIONAL', 1) = 0 and stringlib.stringfind(search_info.function_description, 'INTL', 1) = 0);

// inq_Prod_daily1 := INDEX(df, {unsigned6 s_did := person_q.appended_ADL}, {df},
															// '~thor_data400::key::inquiry::20161212a::did_update');


// inq_cert_daily1 := INDEX(df, {unsigned6 s_did := person_q.appended_ADL}, {df},
															// '~thor_data400::key::inquiry::20161230::did_update');


// inq_prod_daily := choosen(inq_prod_daily1, 1000);
// inq_cert_daily := choosen(inq_cert_daily1, 1000);

// inq_prod_daily := pull(inq_prod_daily1);
// inq_cert_daily := pull(inq_cert_daily1);

key_weekly_cert := INDEX(df, {unsigned6 s_did := person_q.appended_ADL}, {df},
													'~foreign::' + '10.173.44.105' + '::'+'thor_data400::key::inquiry::20180301::did');
													
key_weekly_prod := INDEX(df, {unsigned6 s_did := person_q.appended_ADL}, {df},
													'~foreign::'+ '10.173.44.105' + '::'+'thor_data400::key::inquiry::20180216::did');



inq_prod_weekly_distr := key_weekly_prod(s_did in s1_daily );
inq_cert_weekly_distr := key_weekly_cert(s_did in s1_daily );
// results_weekly := key_weekly(s_did in s1_daily );

new := join(inq_cert_weekly_distr, inq_prod_weekly_distr, left.person_q.appended_adl = right.person_q.appended_adl 
										and left.search_info.transaction_id = right.search_info.transaction_id
										and left.search_info.sequence_number = right.search_info.sequence_number
										and left.search_info.datetime = right.search_info.datetime,
										right only);


output(choosen(new, 300));											
output(count(new), named('new'));

dedup_new := dedup(new,person_q.appended_adl);
// dedup_new := dedup(new,person_q.appended_adl);
output(count(dedup_new), named('dedup_new'));
output(choosen(dedup_new, 100));											

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