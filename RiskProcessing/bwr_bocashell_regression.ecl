/*
Regression testing notes

1. _Control.LibraryUse => set ForceOff_AllLibraries := TRUE;  
	-this allows you to control the code contained in your transactions

2. Deploy your query (Risk_Indicators.Boca_Shell) to dev roxie for baseline

3. Save your code changes in your sandbox, deploy your query again (Risk_Indicators.Boca_Shell) to dev roxie for testing

4.  run a test sample through each version of the query using a soapcall script
(RiskProcessing.bwr_test_bocashells or RiskProcessing.bwr_test_FCRA_bocashells
)
5. compare the results  (bwr_bocashell_regression)

6. if there are differences and you want to see score impacts, use the runway which displays all of our models:  RiskProcessing.bwr_runway_regression

*/

#workunit('name', 'shell comparison');

import risk_indicators, ut, riskprocessing;

layout_internal := RECORD
	riskprocessing.layouts.layout_internal_shell_noDatasets;
END;

eyeball := 10;

basefilename := '~dvstemp::out::audit::nonfcrashell_test_w20200318-141536';  
testfilename := '~dvstemp::out::audit::nonfcrashell_test_w20200318-141546';  

baseline := dataset(basefilename, layout_internal, csv(quote('"'), maxlength(20000)))(errorcode='');
testfile := dataset(testfilename, layout_internal, csv(quote('"'), maxlength(20000)))(errorcode='');
output(choosen(baseline, eyeball), named('baseline'));
output(choosen(testfile, eyeball), named('testfile'));

diff_flags := record
	string4 did;
	string4 trueDID;
	string4 adlCategory;
	string4 Shell_Input;
	string4 iid;	
	string4 source_verification;
	string4 Available_Sources;
	string4 Input_Validation;
	string4 Name_Verification;
	string4 Utility;
	string4 Address_Verification;
	string4	Other_Address_Info;
	string4 Phone_Verification;
	string4 SSN_Verification;
	string4	Velocity_Counters;
	string4 Infutor;
	string4 Infutor_phone;
	string4 Impulse;
	string4 BJL;
	string4 Relatives;
	string4	Vehicles;
	string4	Watercraft;
	string4 accident_data;
	string4 aircraft;
	string4	Student;
	string4	Professional_License;
	string4 AVM; 
	string4 Liens; 
	string4	RV_Scores;
	string4	FD_Scores;
	string4 wealth_indicator;
	string4 reported_dob;
	string4 dobmatchlevel;
	string4 inferred_age;
	string4 mobility_indicator;
	string4 lres;  
	string4 lres2;  
	string4 lres3;  
	string4 addrPop;  
	string4 addrPop2;  
	string4 addrPop3;  
	string4 historydate;
	string4 estimated_income;
	string4 addrhist1zip4;  
	string4 addrhist2zip4;  
	string4 gong_ADL_dt_first_seen;  
	string4 gong_ADL_dt_last_seen;  
	string4 total_number_derogs;
	string4 date_last_derog;	
	string4 addr_stability;
	string4 header_summary;
	string4 advo_input_addr;
	string4 advo_addr_hist1;
	string4 acc_logs;
	string4 employment;
	string4 business_header_address_summary;
	string4 email_summary;
	string4 address_history_summary;
	string4 addr_risk_summary;
	string4 addr_risk_summary2;	
	string4 uspis_hotlist; 
	string4 iBehavior;
	string4 fdAttributesv2;
	string4 rhode_island_insufficient_verification;
	string4 AMLAttributes;
	string4 hhid_summary;
	string4 insurance_phones_summary;
	string4 Experian_Phone_Verification;
	string4 attended_college;
	string4 source_profile;
	string4 source_profile_index;
	string4 economic_trajectory;
	string4 economic_trajectory_index;
	string4 addrsMilitaryEver;
	string4 address_sources_summary;
	string4 Virtual_Fraud;
	string4 Test_Fraud;
	string4 Contributory_Fraud;
	string4 inquiryVerification;
	string4 fpAttributes201;
	string4 PII_Stability;
	string4 riskview_alerts;
	string4 best_flags;
	string4 LnJ_attributes;
	string4 VOO_attributes;
end;

cmpr := record, maxlength(45000)
	diff_flags;
	dataset(riskprocessing.layouts.layout_internal_shell_noDatasets) eyeball;
end;

// for cases when you want to compare one version of the shell to another version of the shell in the same file, use this logic
// version 5.0 are records between 300000 and 600000
// baseline_shell := project(baseline(seq between 300000 and 600000), transform(riskprocessing.layouts.layout_internal_shell_noDatasets, 
		// seq := left.seq - 300000;		self.seq := seq; 		self.shell_input.seq := seq;

// otherwise run with this normal logic when comparing 2 files			
baseline_shell := project(baseline, transform(riskprocessing.layouts.layout_internal_shell_noDatasets,
		self.time_ms := 0; // hard code the time_ms to blank during comparison step
		self.historydatetimestamp := '';  // hard code the timestamp to blank during the comparison step
		self := left, self := [];
					));
	
testfile_shell := project(testfile, transform(riskprocessing.layouts.layout_internal_shell_noDatasets, 		
		self.time_ms := 0; // hard code the time_ms to blank during comparison step
		self.historydatetimestamp := '';  // hard code the timestamp to blank during the comparison step
		self := left, self := [];
		));
		
// initial join to get high level differences
j := join(baseline_shell, testfile_shell, 
					left.seq=right.seq and 
					left<>right, 
			transform(cmpr,
								self.did := if(left.did <> right.did , 'Diff', '');
								self.trueDID := if(left.truedid <> right.truedid , 'Diff', '');
								self.adlCategory := if(left.adlCategory <> right.adlcategory , 'Diff', '');
								self.Shell_Input:= if(left.Shell_Input<> right.Shell_Input, 'Diff', '');
								self.iid:= if(left.iid<> right.iid, 'Diff', '');								
								self.Source_Verification:= if(left.Source_Verification<> right.Source_Verification, 'Diff', '');
								self.Available_Sources:= if(left.Available_Sources<> right.Available_Sources, 'Diff', '');
								self.Input_Validation:= if(left.Input_Validation<> right.Input_Validation, 'Diff', '');
								self.Name_Verification:= if(left.Name_Verification<> right.Name_Verification, 'Diff', '');		
								self.Utility := if(left.utility <> right.utility , 'Diff', '');
								self.Address_Verification:= if(left.Address_Verification<> right.Address_Verification, 'Diff', '');
								self.Other_Address_Info:= if(left.Other_Address_Info<> right.Other_Address_Info, 'Diff', '');
								self.Phone_Verification:= if(left.Phone_Verification<> right.Phone_Verification, 'Diff', '');
								self.SSN_Verification:= if(left.SSN_Verification<> right.SSN_Verification, 'Diff', '');
								self.Velocity_Counters:= if(left.Velocity_Counters<> right.Velocity_Counters, 'Diff', '');
								self.Infutor_phone := if(left.infutor_phone<>right.infutor_phone, 'Diff', '');
								self.Infutor := if(left.infutor <> right.infutor , 'Diff', '');
								self.Impulse := if(left.impulse <> right.impulse , 'Diff', '');
								self.BJL:= if(left.BJL<> right.BJL, 'Diff', '');
								self.Relatives:= if(left.Relatives<> right.Relatives, 'Diff', '');			
								self.Vehicles:= if(left.Vehicles<> right.Vehicles, 'Diff', '');
								self.Watercraft:= if(left.Watercraft<> right.Watercraft, 'Diff', '');
								self.Accident_Data:= if(left.Accident_Data<> right.Accident_Data, 'Diff', '');
								self.aircraft:= if(left.aircraft<> right.aircraft, 'Diff', '');
								self.Student:= if(left.Student<> right.Student, 'Diff', '');
								self.Professional_License:= if(left.Professional_License<> right.Professional_License, 'Diff', '');
								self.AVM:= if(left.AVM<> right.AVM, 'Diff', '');
								self.liens:= if(left.liens<> right.liens, 'Diff', '');								
								self.RV_Scores:= if(left.RV_Scores<> right.RV_Scores, 'Diff', '');
								self.FD_Scores:= if(left.FD_Scores<> right.FD_Scores, 'Diff', '');
								self.wealth_indicator:= if(left.wealth_indicator<> right.wealth_indicator, 'Diff', '');
								self.dobmatchlevel := if(left.dobmatchlevel <> right.dobmatchlevel , 'Diff', '');
								self.inferred_age:= if(left.inferred_age<> right.inferred_age, 'Diff', '');
								self.reported_dob := if(left.reported_dob <> right.reported_dob , 'Diff', '');
								self.mobility_indicator := if(left.mobility_indicator<> right.mobility_indicator, 'Diff', '');	
								self.lres := if(left.lres<> right.lres, 'Diff', '');
								self.lres2 := if(left.lres2<> right.lres2, 'Diff', '');
								self.lres3 := if(left.lres3<> right.lres3, 'Diff', '');
								self.addrPop := if(left.addrpop<> right.addrpop, 'Diff', '');
								self.addrPop2 := if(left.addrpop2<> right.addrpop2, 'Diff', '');
								self.addrPop3 := if(left.addrpop3<> right.addrpop3, 'Diff', '');						
								self.historydate := if(left.historydate <> right.historydate , 'Diff', '');
								self.estimated_income := if(left.estimated_income <> right.estimated_income , 'Diff', '');
								self.addrhist1zip4 := if(left.addrhist1zip4<> right.addrhist1zip4, 'Diff', '');
								self.addrhist2zip4 := if(left.addrhist2zip4<> right.addrhist2zip4, 'Diff', '');
								self.gong_ADL_dt_first_seen := if(left.gong_adl_dt_first_seen<> right.gong_adl_dt_first_seen, 'Diff', '');
								self.gong_ADL_dt_last_seen := if(left.gong_adl_dt_last_seen<> right.gong_adl_dt_last_seen, 'Diff', '');
								self.total_number_derogs := if(left.total_number_derogs<> right.total_number_derogs, 'Diff', '');
								self.date_last_derog := if(left.date_last_derog<> right.date_last_derog, 'Diff', '');		
								self.addr_stability := if(left.addr_stability <> right.addr_stability , 'Diff', '');
								self.header_summary := if(left.header_summary <> right.header_summary , 'Diff', '');
								self.advo_input_addr := if(left.advo_input_addr <> right.advo_input_addr , 'Diff', '');
								self.advo_addr_hist1 := if(left.advo_addr_hist1 <> right.advo_addr_hist1 , 'Diff', '');
								self.acc_logs := if(left.acc_logs <> right.acc_logs , 'Diff', '');
								self.employment := if(left.employment <> right.employment , 'Diff', '');
								self.business_header_address_summary := if(left.business_header_address_summary <> right.business_header_address_summary , 'Diff', '');
								self.email_summary := if(left.email_summary <> right.email_summary , 'Diff', '');
								self.address_history_summary := if(left.address_history_summary <> right.address_history_summary , 'Diff', '');
								self.addr_risk_summary := if(left.addr_risk_summary <> right.addr_risk_summary , 'Diff', '');
								self.addr_risk_summary2 := if(left.addr_risk_summary2 <> right.addr_risk_summary2 , 'Diff', '');		
								self.uspis_hotlist	:= if(left.uspis_hotlist	<> right.uspis_hotlist	, 'Diff', '');
								self.ibehavior := if(left.ibehavior <> right.ibehavior , 'Diff', '');		
								self.fdAttributesv2	:= if(left.fdAttributesv2	<> right.fdAttributesv2	, 'Diff', '');
								self.rhode_island_insufficient_verification	:= if(left.rhode_island_insufficient_verification	<> right.rhode_island_insufficient_verification	, 'Diff', '');
								self.AMLAttributes	:= if(left.AMLAttributes	<> right.AMLAttributes	, 'Diff', '');
								self.hhid_summary	:= if(left.hhid_summary	<> right.hhid_summary	, 'Diff', '');
								self.insurance_phones_summary	:= if(left.insurance_phones_summary	<> right.insurance_phones_summary	, 'Diff', '');
								self.Experian_Phone_Verification	:= if(left.Experian_Phone_Verification	<> right.Experian_Phone_Verification	, 'Diff', '');
								self.attended_college	:= if(left.attended_college	<> right.attended_college	, 'Diff', '');
								self.source_profile	:= if(left.source_profile	<> right.source_profile	, 'Diff', '');
								self.source_profile_index	:= if(left.source_profile_index	<> right.source_profile_index	, 'Diff', '');
								self.economic_trajectory	:= if(left.economic_trajectory	<> right.economic_trajectory	, 'Diff', '');
								self.economic_trajectory_index	:= if(left.economic_trajectory_index	<> right.economic_trajectory_index	, 'Diff', '');
								self.addrsMilitaryEver	:= if(left.addrsMilitaryEver	<> right.addrsMilitaryEver	, 'Diff', '');
								self.address_sources_summary	:= if(left.address_sources_summary	<> right.address_sources_summary	, 'Diff', '');
								self.Virtual_Fraud	:= if(left.Virtual_Fraud	<> right.Virtual_Fraud	, 'Diff', '');
								self.Test_Fraud	:= if(left.Test_Fraud	<> right.Test_Fraud	, 'Diff', '');
								self.Contributory_Fraud	:= if(left.Contributory_Fraud	<> right.Contributory_Fraud	, 'Diff', '');
								self.inquiryVerification	:= if(left.inquiryVerification	<> right.inquiryVerification	, 'Diff', '');
								self.fpAttributes201	:= if(left.fpAttributes201	<> right.fpAttributes201	, 'Diff', '');
								self.PII_Stability	:= if(left.PII_Stability	<> right.PII_Stability	, 'Diff', '');
								self.riskview_alerts	:= if(left.riskview_alerts	<> right.riskview_alerts	, 'Diff', '');
								self.best_flags	:= if(left.best_flags	<> right.best_flags	, 'Diff', '');
								self.LnJ_attributes	:= if(left.LnJ_attributes	<> right.LnJ_attributes	, 'Diff', '');
								self.VOO_attributes	:= if(left.VOO_attributes	<> right.VOO_attributes	, 'Diff', '');	
						self.eyeball := left + right;  
						));
						
output(choosen(j, eyeball), named('high_level_diffs_sample'));
output(choosen(j(iid='Diff'), eyeball), named('iid_diffs_sample'));

diff_stats := table(j, {total_differences := count(group),
		did_diffs := count(group, did='Diff'),
		trueDID_diffs := count(group, trueDID='Diff'),
		adlCategory_diffs := count(group, adlCategory='Diff'),
		Shell_Input_diffs := count(group, Shell_Input='Diff'),
		iid_diffs := count(group, iid='Diff'),
		Sources_Verification_diffs := count(group, Source_Verification='Diff'),
		Available_Sources_diffs := count(group, Available_Sources='Diff'),
		Input_Validation_diffs := count(group, Input_Validation='Diff'),
		Name_Verification_diffs := count(group, Name_Verification='Diff'),
		Utility_diffs := count(group, Utility='Diff'),
		Address_Verification_diffs := count(group, Address_Verification='Diff'),
		Other_Address_Info_diffs := count(group, Other_Address_Info='Diff'),
		Phone_Verification_diffs := count(group, Phone_Verification='Diff'),
		SSN_Verification_diffs := count(group, SSN_Verification='Diff'),
		Velocity_Counters_diffs := count(group, Velocity_Counters='Diff'),
		Infutor_diffs := count(group, Infutor='Diff'),
		Infutor_phone_diffs := count(group, Infutor_phone='Diff'),
		Impulse_diffs := count(group, Impulse='Diff'),
		BJL_diffs := count(group, BJL='Diff'),
		Relatives_diffs := count(group, Relatives='Diff'),
		Vehicles_diffs := count(group, Vehicles='Diff'),
		Watercraft_diffs := count(group, Watercraft='Diff'),
		Accident_Data_diffs := count(group, Accident_Data='Diff'),
		Aircraft_diffs := count(group, Aircraft='Diff'),
		Student_diffs := count(group, Student='Diff'),
		Professional_License_diffs := count(group, Professional_License='Diff'),
		AVM_diffs := count(group, AVM='Diff'),
		liens_diffs := count(group, liens='Diff'),
		RV_Scores_diffs := count(group, RV_Scores='Diff'),
		FD_Scores_diffs := count(group, FD_Scores='Diff'),
		wealth_indicator_diffs := count(group, wealth_indicator='Diff'),
		dobmatchlevel_diffs := count(group, dobmatchlevel='Diff'),
		inferred_age_diffs := count(group, inferred_age='Diff'),
		reported_dob_diffs := count(group, reported_dob='Diff'),
		mobility_indicator_diffs := count(group, mobility_indicator='Diff'),
		lres_diffs := count(group, lres='Diff'),
		lres2_diffs := count(group, lres2='Diff'),
		lres3_diffs := count(group, lres3='Diff'),
		addrpop_diffs := count(group, addrpop='Diff'),
		addrpop2_diffs := count(group, addrpop2='Diff'),
		addrpop3_diffs := count(group, addrpop3='Diff'),	
		estimated_income_diffs := count(group, estimated_income='Diff'),
		historydate_diffs := count(group, historydate='Diff'),
		addrhist1zip4_diffs := count(group, addrhist1zip4='Diff'),
		addrhist2zip4_diffs := count(group, addrhist2zip4='Diff'),
		gong_adl_dt_first_seen_diffs := count(group, gong_adl_dt_first_seen='Diff'),
		gong_adl_dt_last_seen_diffs := count(group, gong_adl_dt_last_seen='Diff'),
		total_number_derogs_diffs := count(group, total_number_derogs='Diff'),
		date_last_derog_diffs := count(group, date_last_derog='Diff'),
		addr_stability_diffs := count(group, addr_stability='Diff'),
		header_summary_diffs := count(group, header_summary='Diff'),
		advo_input_addr_diffs := count(group, advo_input_addr='Diff'),
		advo_addr_hist1_diffs := count(group, advo_addr_hist1='Diff'),
		acc_logs_diffs := count(group, acc_logs='Diff'),
		employment_diffs := count(group, employment='Diff'),
		business_header_address_summary_diffs := count(group, business_header_address_summary='Diff'),
		email_summary_diffs := count(group, email_summary='Diff'),
		address_history_summary_diffs := count(group, address_history_summary='Diff'),
		addr_risk_summary_diffs := count(group, addr_risk_summary='Diff'),
		addr_risk_summary2_diffs := count(group, addr_risk_summary2='Diff'),
		uspis_hotlist_diffs := count(group, 	uspis_hotlist	='Diff'),
		ibehavior_diffs := count(group, ibehavior='Diff'),
		fdAttributesv2_diffs := count(group, 	fdAttributesv2	='Diff'),
		rhode_island_insufficient_verification_diffs := count(group, 	rhode_island_insufficient_verification	='Diff'),
		AMLAttributes_diffs := count(group, 	AMLAttributes	='Diff'),
		hhid_summary_diffs := count(group, 	hhid_summary	='Diff'),
		insurance_phones_summary_diffs := count(group, 	insurance_phones_summary	='Diff'),
		Experian_Phone_Verification_diffs := count(group, 	Experian_Phone_Verification	='Diff'),
		attended_college_diffs := count(group, 	attended_college	='Diff'),
		source_profile_diffs := count(group, 	source_profile	='Diff'),
		source_profile_index_diffs := count(group, 	source_profile_index	='Diff'),
		economic_trajectory_diffs := count(group, 	economic_trajectory	='Diff'),
		economic_trajectory_index_diffs := count(group, 	economic_trajectory_index	='Diff'),
		addrsMilitaryEver_diffs := count(group, 	addrsMilitaryEver	='Diff'),
		address_sources_summary_diffs := count(group, 	address_sources_summary	='Diff'),
		Virtual_Fraud_diffs := count(group, 	Virtual_Fraud	='Diff'),
		Test_Fraud_diffs := count(group, 	Test_Fraud	='Diff'),
		Contributory_Fraud_diffs := count(group, 	Contributory_Fraud	='Diff'),
		inquiryVerification_diffs := count(group, 	inquiryVerification	='Diff'),
		fpAttributes201_diffs := count(group, 	fpAttributes201	='Diff'),
		PII_Stability_diffs := count(group, 	PII_Stability	='Diff'),
		riskview_alerts_diffs := count(group, 	riskview_alerts	='Diff'),
		best_flags_diffs := count(group, 	best_flags	='Diff'),
		LnJ_attributes_diffs := count(group, 	LnJ_attributes	='Diff'),
		VOO_attributes_diffs := count(group, 	VOO_attributes	='Diff')
		}, few);
output(diff_stats, named('diff_stats'));

/* ************************************************************************************************
// if the cursory test shows differences and you want to see the details, uncomment this section
**************************************************************************************************/

// models.flatten(baseline_shell, flatten_baseline);
// models.flatten(testfile_shell, flatten_testfile);
// Models.Diff_Macro(flatten_baseline, flatten_testfile, ['seq'], compared_results, 'shell' );

// OUTPUT(COUNT(compared_results), NAMED('macro_differences_count'));
// OUTPUT(CHOOSEN(compared_results, 10), NAMED('macro_differences'));