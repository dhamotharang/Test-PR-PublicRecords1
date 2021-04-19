export macro_run_bs2() := macro

#workunit('name','Bocashell Creation for Tracking');
#option ('hthorMemoryLimit', 1000)

////////////////////////////////////////////////////////////////////////////////////////////////////
//                   UNIVERSAL BOCASHELL FILE PROCESSING SETTINGS
////////////////////////////////////////////////////////////////////////////////////////////////////
eyeball := 10;
 
neutral_roxieIP := 'http://roxiethorvip.hpcc.risk.regn.net:9856';
roxieIP_fcra := 'http://fcrathorvip.hpcc.risk.regn.net:9876';

input_file := '~nmontpetit::in::first_inv_857_bs_input';
output_file := '~nmontpetit::out::first_inv';

string history_date_archive := '200807';
today := ut.GetDate[3..];
//////////////////////////////////////////////////////////////////////////////////////////////////////

r := record
	string	Account	;
	string	FirstName	;
	string	MiddleName	;
	string	lastname	;
	string	StreetAddress	;
	string	City	;
	string	State	;
	string	zip	;
	string	homephone	;
	string	ssn	;
	string	DateOfBirth	;
	string	workphone	;
	string	income	;
	string	DLNumber	;
	string	DLState	;
	string	BALANCE	;
	string	CHARGEOFFD	;
	string	FormerName	;
	string	EMAIL	;
	string	employername	;
	string	historydate	;
end;

ds_input := dataset(input_file, r, csv(quote('"')));  

output(choosen(ds_input, eyeball), named('ds_input'));

l := RECORD
	STRING original_account_number;
	STRING AccountNumber;
	STRING FirstName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING SSN;
	STRING DateOfBirth;
	STRING HomePhone;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	integer HistoryDateYYYYMM;
	boolean IncludeScore := false;
	boolean ADL_Based_Shell := false;
	string neutral_gateway := '';
END;

l t_f(ds_input le, INTEGER c) := TRANSFORM
	SELF.original_account_number := le.account;
	SELF.AccountNumber := (STRING)c;	
	SELF.GLBPurpose := 1;
	SELF.DPPAPurpose := 3;
	self.IncludeScore := true;
	self.historyDateYYYYMM := (unsigned)history_date_archive;
	self.ADL_Based_Shell := false;
	self := le;
END;

p_f := PROJECT(ds_input,t_f(LEFT,COUNTER));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

l t_f_fcra_arch(p_f le) := TRANSFORM
	self.neutral_gateway := neutral_roxieIP;
	self := le;
END;

l t_f_fcra_curr(p_f le) := TRANSFORM
	SELF.HistoryDateYYYYMM := 999999;
	self.neutral_gateway := neutral_roxieIP;
	self := le;
END;

l t_f_nonfcra_arch(p_f le) := TRANSFORM
	self.neutral_gateway := '';
	self := le;
END;

l t_f_nonfcra_curr(p_f le) := TRANSFORM
	SELF.HistoryDateYYYYMM := 999999;
	self.neutral_gateway := '';
	self := le;
END;

p_f_fcra_arch := PROJECT(p_f,t_f_fcra_arch(LEFT));
p_f_fcra_curr := PROJECT(p_f,t_f_fcra_curr(LEFT));
p_f_nonfcra_arch := PROJECT(p_f,t_f_nonfcra_arch(LEFT));
p_f_nonfcra_curr := PROJECT(p_f,t_f_nonfcra_curr(LEFT));

dist_dataset_fcra_arch := distribute(p_f_fcra_arch, random());
dist_dataset_fcra_curr := distribute(p_f_fcra_curr, random());
dist_dataset_nonfcra_arch := distribute(p_f_nonfcra_arch, random());
dist_dataset_nonfcra_curr := distribute(p_f_nonfcra_curr, random());

output(choosen(dist_dataset_fcra_arch, eyeball), named('bocashell_input_fcra_arch'));
output(choosen(dist_dataset_fcra_curr, eyeball), named('bocashell_input_fcra_curr'));
output(choosen(dist_dataset_nonfcra_arch, eyeball), named('bocashell_input_nonfcra_arch'));
output(choosen(dist_dataset_nonfcra_curr, eyeball), named('bocashell_input_nonfcra_curr'));

xlayout := record
	risk_indicators.Layout_Boca_Shell;	
	string200 errorcode;
end;
								
xlayout myFail(dist_dataset_fcra_arch le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.seq := (unsigned)le.accountnumber;
	SELF := [];
END;

roxie_results_fcra_arch := soapcall(dist_dataset_fcra_arch, roxieIP_fcra,
													'risk_indicators.Boca_shell_FCRA', 
													{dist_dataset_fcra_arch}, 
													DATASET(xlayout),
													parallel(30),
													onFail(myFail(LEFT)));

roxie_results_fcra_curr := soapcall(dist_dataset_fcra_curr, roxieIP_fcra,
													'risk_indicators.Boca_shell_FCRA', 
													{dist_dataset_fcra_curr}, 
													DATASET(xlayout),
													parallel(30),
													onFail(myFail(LEFT)));
													

roxie_results_nonfcra_arch := soapcall(dist_dataset_nonfcra_arch, neutral_roxieIP,
													'risk_indicators.Boca_shell', 
													{dist_dataset_nonfcra_arch}, 
													DATASET(xlayout),
													parallel(30),
													onFail(myFail(LEFT)));

roxie_results_nonfcra_curr := soapcall(dist_dataset_nonfcra_curr, neutral_roxieIP,
													'risk_indicators.Boca_shell', 
													{dist_dataset_nonfcra_curr}, 
													DATASET(xlayout),
													parallel(30),
													onFail(myFail(LEFT)));
													

errs_fcra_arch := roxie_results_fcra_arch(errorcode<>'');				
errs_fcra_curr := roxie_results_fcra_curr(errorcode<>'');				
errs_nonfcra_arch := roxie_results_nonfcra_arch(errorcode<>'');				
errs_nonfcra_curr := roxie_results_nonfcra_curr(errorcode<>'');				

output(choosen(roxie_results_fcra_arch, eyeball), named('roxie_results_fcra_arch'));
output(choosen(roxie_results_fcra_curr, eyeball), named('roxie_results_fcra_curr'));
output(choosen(roxie_results_nonfcra_arch, eyeball), named('roxie_results_nonfcra_arch'));
output(choosen(roxie_results_nonfcra_curr, eyeball), named('roxie_results_nonfcra_curr'));

output(choosen(errs_fcra_arch, eyeball), named('errors_fcra_arch'));
output(choosen(errs_fcra_curr, eyeball), named('errors_fcra_curr'));
output(choosen(errs_nonfcra_arch, eyeball), named('errors_nonfcra_arch'));
output(choosen(errs_nonfcra_curr, eyeball), named('errors_nonfcra_curr'));

output(count(errs_fcra_arch), named('err_count_fcra_arch'));
output(count(errs_fcra_curr), named('err_count_fcra_curr'));
output(count(errs_nonfcra_arch), named('err_count_nonfcra_arch'));
output(count(errs_nonfcra_curr), named('err_count_nonfcra_curr'));

//output(roxie_results,,output_file, csv(heading(single), quote('"')));


edina_plus_bob := record
	risk_indicators.iid_constants.adl_based_modeling_flags ADL_Shell_Flags;
	risk_indicators.Layout_Boca_Shell_Edina;
end;

edina_plus_bob convertToEdina(roxie_results_fcra_arch le, p_f_fcra_arch rt) := transform
	self.accountnumber := rt.original_account_number;
	self.address_verification.input_address_information.lres := le.lres;
	self.address_verification.address_history_1.lres := le.lres2;
	self.address_verification.address_history_2.lres := le.lres3;
	self.address_verification.input_address_information.addrPop := le.addrPop;
	self.address_verification.address_history_1.addrPop := le.addrPop2;
	self.address_verification.address_history_2.addrPop := le.addrPop3;
	self.address_verification.input_address_information.avm_land_use_code := le.avm.input_address_information.avm_land_use_code;
	self.address_verification.input_address_information.avm_recording_date := le.avm.input_address_information.avm_recording_date;
	self.address_verification.input_address_information.avm_assessed_value_year := le.avm.input_address_information.avm_assessed_value_year;
	self.address_verification.input_address_information.avm_sales_price := le.avm.input_address_information.avm_sales_price;  
	self.address_verification.input_address_information.avm_assessed_total_value := le.avm.input_address_information.avm_assessed_total_value;
	self.address_verification.input_address_information.avm_market_total_value := le.avm.input_address_information.avm_market_total_value;
	self.address_verification.input_address_information.avm_tax_assessment_valuation := le.avm.input_address_information.avm_tax_assessment_valuation;
	self.address_verification.input_address_information.avm_price_index_valuation := le.avm.input_address_information.avm_price_index_valuation;
	self.address_verification.input_address_information.avm_hedonic_valuation := le.avm.input_address_information.avm_hedonic_valuation;
	self.address_verification.input_address_information.avm_automated_valuation := le.avm.input_address_information.avm_automated_valuation;
	self.address_verification.input_address_information.avm_confidence_score := le.avm.input_address_information.avm_confidence_score;
	self.address_verification.input_address_information.avm_median_fips_level := le.avm.input_address_information.avm_median_fips_level;
	self.address_verification.input_address_information.avm_median_geo11_level := le.avm.input_address_information.avm_median_geo11_level;
	self.address_verification.input_address_information.avm_median_geo12_level := le.avm.input_address_information.avm_median_geo12_level;
	
	self.address_verification.address_history_1.avm_land_use_code := le.avm.address_history_1.avm_land_use_code;
	self.address_verification.address_history_1.avm_recording_date := le.avm.address_history_1.avm_recording_date;
	self.address_verification.address_history_1.avm_assessed_value_year := le.avm.address_history_1.avm_assessed_value_year;
	self.address_verification.address_history_1.avm_sales_price := le.avm.address_history_1.avm_sales_price;  
	self.address_verification.address_history_1.avm_assessed_total_value := le.avm.address_history_1.avm_assessed_total_value;
	self.address_verification.address_history_1.avm_market_total_value := le.avm.address_history_1.avm_market_total_value;
	self.address_verification.address_history_1.avm_tax_assessment_valuation := le.avm.address_history_1.avm_tax_assessment_valuation;
	self.address_verification.address_history_1.avm_price_index_valuation := le.avm.address_history_1.avm_price_index_valuation;
	self.address_verification.address_history_1.avm_hedonic_valuation := le.avm.address_history_1.avm_hedonic_valuation;
	self.address_verification.address_history_1.avm_automated_valuation := le.avm.address_history_1.avm_automated_valuation;
	self.address_verification.address_history_1.avm_confidence_score := le.avm.address_history_1.avm_confidence_score;
	self.address_verification.address_history_1.avm_median_fips_level := le.avm.address_history_1.avm_median_fips_level;
	self.address_verification.address_history_1.avm_median_geo11_level := le.avm.address_history_1.avm_median_geo11_level;
	self.address_verification.address_history_1.avm_median_geo12_level := le.avm.address_history_1.avm_median_geo12_level;
	
	SELF.Velocity_Counters.adlPerSSN_count := le.SSN_Verification.adlPerSSN_count;
	
	self.iid.socllowissue := (unsigned)le.iid.socllowissue;
	self.iid.soclhighissue := (unsigned)le.iid.soclhighissue;
	self.iid.areacodesplitdate := (unsigned)le.iid.areacodesplitdate;
	self.student.date_first_seen := (unsigned)le.student.date_first_seen;
	self.student.date_last_seen := (unsigned)le.student.date_last_seen;
	self.student.dob_formatted := (unsigned)le.student.dob_formatted;					

	self.isFCRA := '1';
	self := le;
end;

adl_edina_fcra_arch := join(roxie_results_fcra_arch, p_f_fcra_arch, left.seq=(unsigned)right.accountnumber, convertToEdina(left, right));
adl_edina_fcra_curr := join(roxie_results_fcra_curr, p_f_fcra_curr, left.seq=(unsigned)right.accountnumber, convertToEdina(left, right));
adl_edina_nonfcra_arch_temp := join(roxie_results_nonfcra_arch, p_f_nonfcra_arch, left.seq=(unsigned)right.accountnumber, convertToEdina(left, right));
adl_edina_nonfcra_curr_temp := join(roxie_results_nonfcra_curr, p_f_nonfcra_curr, left.seq=(unsigned)right.accountnumber, convertToEdina(left, right));

edina_plus_bob set_nonfcra(adl_edina_fcra_arch le) := TRANSFORM
	self.isFCRA := '0';
	self := le;
END;

adl_edina_nonfcra_arch := PROJECT(adl_edina_nonfcra_arch_temp, set_nonfcra(LEFT));
adl_edina_nonfcra_curr := PROJECT(adl_edina_nonfcra_curr_temp, set_nonfcra(LEFT));

edina_fcra_arch := project(adl_edina_fcra_arch, transform(risk_indicators.Layout_Boca_Shell_Edina, self := left));
edina_fcra_curr := project(adl_edina_fcra_curr, transform(risk_indicators.Layout_Boca_Shell_Edina, self := left));
edina_nonfcra_arch := project(adl_edina_nonfcra_arch, transform(risk_indicators.Layout_Boca_Shell_Edina, self := left));
edina_nonfcra_curr := project(adl_edina_nonfcra_curr, transform(risk_indicators.Layout_Boca_Shell_Edina, self := left));

output(choosen(edina_fcra_arch, eyeball), named('edina_fcra_arch'));
output(choosen(edina_fcra_curr, eyeball), named('edina_fcra_curr'));
output(choosen(edina_nonfcra_arch, eyeball), named('edina_nonfcra_arch'));
output(choosen(edina_nonfcra_curr, eyeball), named('edina_nonfcra_curr'));

output(edina_fcra_arch,,   output_file + '_fcra_' +    today + '_' + history_date_archive, csv(quote('"')), overwrite);
output(edina_fcra_curr,,   output_file + '_fcra_' +    today + '_999999',                  csv(quote('"')), overwrite);
output(edina_nonfcra_arch,,output_file + '_nonfcra_' + today + '_' + history_date_archive, csv(quote('"')), overwrite);
output(edina_nonfcra_curr,,output_file + '_nonfcra_' + today + '_999999',                  csv(quote('"')), overwrite);

endmacro;