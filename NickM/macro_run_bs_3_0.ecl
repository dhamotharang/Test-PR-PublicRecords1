export macro_run_bs_3_0() := macro

#workunit('name','Bocashell Creation for Tracking');
#option ('hthorMemoryLimit', 1000)

IMPORT Risk_Indicators, RiskWise;

////////////////////////////////////////////////////////////////////////////////////////////////////
//                   UNIVERSAL BOCASHELL FILE PROCESSING SETTINGS
////////////////////////////////////////////////////////////////////////////////////////////////////
eyeball := 10;
 
neutral_roxieIP := RiskWise.Shortcuts.prod_batch_neutral;
roxieIP_fcra := RiskWise.Shortcuts.prod_batch_fcra;
roxieIP_nonfcra :=  RiskWise.Shortcuts.prod_batch_neutral;

input_file := '~nmontpetit::in::first_inv_857_bs_input';
output_file := '~nmontpetit::bs_30_tracking::first_inv';

bs_service_fcra := 'risk_indicators.Boca_Shell_FCRA';
bs_service_nonfcra := 'risk_indicators.Boca_Shell';

unsigned1 glba := 1;
unsigned1 dppa := 3;
string DataRestrictionMask     := '00000000000001';
string fcraDataRestrictionMask := '10000100010001';
string history_date_archive := '200807';
today := ut.GetDate[3..];
unsigned1 parallel_calls := 30;
//unsigned1 parallel_calls := 5;  
//////////////////////////////////////////////////////////////////////////////////////////////////////

layout_input := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    integer historydateyyyymm;
  END;

ds_input := dataset (input_file, layout_input, csv(quote('"')));

output(choosen(ds_input, eyeball), named('ds_input'));

l := RECORD
  STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
l t_f(ds_input le, INTEGER c) := TRANSFORM
  	SELF.old_account_number := le.Account;
	SELF.AccountNumber := (STRING)c;	
	self.historyDateYYYYMM := (unsigned)history_date_archive;
	self.IncludeScore := true;
	self.bsversion := 3;
	self := le;
	SELF := [];
END;

p_f := PROJECT(ds_input,t_f(LEFT,COUNTER));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

l t_f_fcra_arch(p_f le) := TRANSFORM
	self.neutral_gateway := neutral_roxieIP;
	SELF.datarestrictionmask := fcradatarestrictionmask;
	self := le;
END;


l t_f_fcra_curr(p_f le) := TRANSFORM
	SELF.HistoryDateYYYYMM := 999999;
	self.neutral_gateway := neutral_roxieIP;
	SELF.datarestrictionmask := fcradatarestrictionmask;
	self := le;
END;


l t_f_nonfcra_arch(p_f le) := TRANSFORM
	SELF.GLBPurpose := glba;
	SELF.DPPAPurpose := dppa;
	SELF.datarestrictionmask := datarestrictionmask;
	self.neutral_gateway := ' ';
	self := le;
END;


l t_f_nonfcra_curr(p_f le) := TRANSFORM
	SELF.GLBPurpose := glba;
	SELF.DPPAPurpose := dppa;
	SELF.HistoryDateYYYYMM := 999999;
	SELF.datarestrictionmask := datarestrictionmask;
	self.neutral_gateway := ' ';
	self := le;
END;


p_f_fcra_arch :=    PROJECT(p_f,t_f_fcra_arch(LEFT));
p_f_fcra_curr :=    PROJECT(p_f,t_f_fcra_curr(LEFT));
p_f_nonfcra_arch := PROJECT(p_f,t_f_nonfcra_arch(LEFT));
p_f_nonfcra_curr := PROJECT(p_f,t_f_nonfcra_curr(LEFT));

dist_dataset_fcra_arch :=    distribute(p_f_fcra_arch, random());
dist_dataset_fcra_curr :=    distribute(p_f_fcra_curr, random());
dist_dataset_nonfcra_arch := distribute(p_f_nonfcra_arch, random());
dist_dataset_nonfcra_curr := distribute(p_f_nonfcra_curr, random());

output(choosen(dist_dataset_fcra_arch, eyeball),    named('bocashell_input_fcra_arch'));
output(choosen(dist_dataset_fcra_curr, eyeball),    named('bocashell_input_fcra_curr'));
output(choosen(dist_dataset_nonfcra_arch, eyeball), named('bocashell_input_nonfcra_arch'));
output(choosen(dist_dataset_nonfcra_curr, eyeball), named('bocashell_input_nonfcra_curr'));
										
roxie_results_fcra_arch := Risk_Indicators.test_BocaShell_SoapCall (	PROJECT (dist_dataset_fcra_arch, 
																		TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, 
																		SELF := LEFT)),
                                                bs_service_fcra, 
												roxieIP_fcra, 
												parallel_calls
												);
		
roxie_results_fcra_curr := Risk_Indicators.test_BocaShell_SoapCall (	PROJECT (dist_dataset_fcra_curr, 
																		TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, 
																		SELF := LEFT)),
                                                bs_service_fcra, 
												roxieIP_fcra, 
												parallel_calls
												);

		
roxie_results_nonfcra_arch := Risk_Indicators.test_BocaShell_SoapCall (	PROJECT (dist_dataset_nonfcra_arch, 
																		TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, 
																		SELF := LEFT)),
                                                bs_service_nonfcra, 
												roxieIP_nonfcra, 
												parallel_calls
												);

		
roxie_results_nonfcra_curr := Risk_Indicators.test_BocaShell_SoapCall (	PROJECT (dist_dataset_nonfcra_curr, 
																		TRANSFORM (Risk_Indicators.Layout_InstID_SoapCall, 
																		SELF := LEFT)),
                                                bs_service_nonfcra, 
												roxieIP_nonfcra, 
												parallel_calls
												);

ox := RECORD
	STRING30 AccountNumber;
	risk_indicators.Layout_Boca_Shell;
	STRING50 errorcode;
END;
	
ox getold(roxie_results_fcra_arch le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;
	
res_fcra_arch := 	JOIN (roxie_results_fcra_arch,    p_f, LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_fcra_curr := 	JOIN (roxie_results_fcra_curr,    p_f, LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_nonfcra_arch := JOIN (roxie_results_nonfcra_arch, p_f, LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_nonfcra_curr := JOIN (roxie_results_nonfcra_curr, p_f, LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));

res_err_fcra_arch := 	res_fcra_arch(errorcode<>'');
res_err_fcra_curr := 	res_fcra_curr(errorcode<>'');
res_err_nonfcra_arch :=	res_nonfcra_arch(errorcode<>'');
res_err_nonfcra_curr :=	res_nonfcra_curr(errorcode<>'');

OUTPUT (choosen(res_fcra_arch, eyeball), 	NAMED ('result_fcra_arch'));
OUTPUT (choosen(res_fcra_curr, eyeball), 	NAMED ('result_fcra_curr'));
OUTPUT (choosen(res_nonfcra_arch, eyeball), NAMED ('result_nonfcra_arch'));
OUTPUT (choosen(res_nonfcra_curr, eyeball), NAMED ('result_nonfcra_curr'));

IF (EXISTS (res_err_fcra_arch), 	OUTPUT (choosen(res_err_fcra_arch, eyeball),    NAMED ('res_err_fcra_arch')));
IF (EXISTS (res_err_fcra_curr), 	OUTPUT (choosen(res_err_fcra_curr, eyeball),    NAMED ('res_err_fcra_curr')));
IF (EXISTS (res_err_nonfcra_arch), 	OUTPUT (choosen(res_err_nonfcra_arch, eyeball), NAMED ('res_err_nonfcra_arch')));
IF (EXISTS (res_err_nonfcra_curr), 	OUTPUT (choosen(res_err_nonfcra_curr, eyeball), NAMED ('res_err_nonfcra_curr')));

// the conversion portion-----------------------------------------------------------------------
risk_indicators.Layout_Boca_Shell_Edina convertToEdina(res_fcra_arch le) := transform
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
	
	// new shell 2.5 fields				
	self.isFCRA := '1';
	//self.fd_scores := [];	// fraudpoint not populated in non-fcra
	////////////
	
	//// new shell 3.0 fields
	self.cb_allowed := map(	dataRestrictionMask[6]<>'1' and dataRestrictionMask[8]<>'1' and dataRestrictionMask[10]<>'1' => 'ALL',
								dataRestrictionMask[8]<>'1' => 'EQ',
								dataRestrictionMask[6]<>'1' => 'EN',
								dataRestrictionMask[10]<>'1' => 'TN',
								'NONE');		// this should not happen
							
	self.iid.ConsumerFlags := le.ConsumerFlags;
	
	self.ssn_verification.inputsocscharflag := le.ssn_verification.validation.inputsocscharflag;
	
	SELF.Address_Verification.Address_History_1.addr_type := le.Address_Verification.addr_type2;
	self.Address_Verification.Address_History_2.addr_type := le.Address_Verification.addr_type3;

	self.input_dob_age := le.shell_input.age;
	
	self.Address_Verification.Input_Address_Information.building_area := (string)le.address_verification.input_address_information.building_area ;
	self.Address_Verification.Input_Address_Information.no_of_buildings := (string)le.address_verification.input_address_information.no_of_buildings ;
	self.Address_Verification.Input_Address_Information.no_of_stories := (string)le.address_verification.input_address_information.no_of_stories ;
	self.Address_Verification.Input_Address_Information.no_of_rooms := (string)le.address_verification.input_address_information.no_of_rooms ;
	self.Address_Verification.Input_Address_Information.no_of_bedrooms := (string)le.address_verification.input_address_information.no_of_bedrooms ;
	self.Address_Verification.Input_Address_Information.no_of_baths := (string)le.address_verification.input_address_information.no_of_baths;
	self.Address_Verification.Input_Address_Information.no_of_partial_baths := (string)le.address_verification.input_address_information.no_of_partial_baths ;
	self.Address_Verification.Input_Address_Information.parking_no_of_cars := (string)le.address_verification.input_address_information.parking_no_of_cars;
	self.Address_Verification.Input_Address_Information.avm_automated_valuation2 := le.avm.input_address_information.avm_automated_valuation2;
	self.Address_Verification.Input_Address_Information.avm_automated_valuation3 := le.avm.input_address_information.avm_automated_valuation3;
	self.Address_Verification.Input_Address_Information.avm_automated_valuation4 := le.avm.input_address_information.avm_automated_valuation4;
	self.Address_Verification.Input_Address_Information.avm_automated_valuation5 := le.avm.input_address_information.avm_automated_valuation5;
	self.Address_Verification.Input_Address_Information.avm_automated_valuation6 := le.avm.input_address_information.avm_automated_valuation6;
	
	self.address_verification.address_history_1.building_area := (string)le.address_verification.address_history_1.building_area ;
	self.address_verification.address_history_1.no_of_buildings := (string)le.address_verification.address_history_1.no_of_buildings ;
	self.address_verification.address_history_1.no_of_stories := (string)le.address_verification.address_history_1.no_of_stories ;
	self.address_verification.address_history_1.no_of_rooms := (string)le.address_verification.address_history_1.no_of_rooms ;
	self.address_verification.address_history_1.no_of_bedrooms := (string)le.address_verification.address_history_1.no_of_bedrooms ;
	self.address_verification.address_history_1.no_of_baths := (string)le.address_verification.address_history_1.no_of_baths;
	self.address_verification.address_history_1.no_of_partial_baths := (string)le.address_verification.address_history_1.no_of_partial_baths ;
	self.address_verification.address_history_1.parking_no_of_cars := (string)le.address_verification.address_history_1.parking_no_of_cars;
	self.Address_Verification.Address_History_1.avm_automated_valuation2 := le.avm.address_history_1.avm_automated_valuation2;
	self.Address_Verification.Address_History_1.avm_automated_valuation3 := le.avm.address_history_1.avm_automated_valuation3;
	self.Address_Verification.Address_History_1.avm_automated_valuation4 := le.avm.address_history_1.avm_automated_valuation4;
	self.Address_Verification.Address_History_1.avm_automated_valuation5 := le.avm.address_history_1.avm_automated_valuation5;
	self.Address_Verification.Address_History_1.avm_automated_valuation6 := le.avm.address_history_1.avm_automated_valuation6;
	
	self.bjl.liens := le.liens;
	
	// attribute fields added
	self.attributes.addrs_last30 := le.other_address_info.addrs_last30;
	self.attributes.addrs_last90 := le.other_address_info.addrs_last90;
	self.attributes.addrs_last12 := le.other_address_info.addrs_last12;
	self.attributes.addrs_last24 := le.other_address_info.addrs_last24;
	self.attributes.addrs_last36 := le.other_address_info.addrs_last36;
	self.attributes.date_first_purchase := le.other_address_info.date_first_purchase;	
	self.attributes.date_most_recent_purchase := le.other_address_info.date_most_recent_purchase;	
	self.attributes.date_most_recent_sale := le.other_address_info.date_most_recent_sale;	
	self.attributes.num_purchase30 := le.other_address_info.num_purchase30;
	self.attributes.num_purchase90 := le.other_address_info.num_purchase90;
	self.attributes.num_purchase180 := le.other_address_info.num_purchase180;
	self.attributes.num_purchase12 := le.other_address_info.num_purchase12;
	self.attributes.num_purchase24 := le.other_address_info.num_purchase24;
	self.attributes.num_purchase36 := le.other_address_info.num_purchase36;
	self.attributes.num_purchase60 := le.other_address_info.num_purchase60;
	self.attributes.num_sold30 := le.other_address_info.num_sold30;
	self.attributes.num_sold90 := le.other_address_info.num_sold90;
	self.attributes.num_sold180 := le.other_address_info.num_sold180;
	self.attributes.num_sold12 := le.other_address_info.num_sold12;
	self.attributes.num_sold24 := le.other_address_info.num_sold24;
	self.attributes.num_sold36 := le.other_address_info.num_sold36;
	self.attributes.num_sold60 := le.other_address_info.num_sold60;
	self.attributes.num_watercraft30 := le.watercraft.watercraft_count30;
	self.attributes.num_watercraft90 := le.watercraft.watercraft_count90;
	self.attributes.num_watercraft180 := le.watercraft.watercraft_count180;
	self.attributes.num_watercraft12 := le.watercraft.watercraft_count12;
	self.attributes.num_watercraft24 := le.watercraft.watercraft_count24;
	self.attributes.num_watercraft36 := le.watercraft.watercraft_count36;
	self.attributes.num_watercraft60 := le.watercraft.watercraft_count60;
	self.attributes.num_aircraft := le.aircraft.aircraft_count;
	self.attributes.num_aircraft30 := le.aircraft.aircraft_count30;
	self.attributes.num_aircraft90 := le.aircraft.aircraft_count90;
	self.attributes.num_aircraft180 := le.aircraft.aircraft_count180;
	self.attributes.num_aircraft12 := le.aircraft.aircraft_count12;
	self.attributes.num_aircraft24 := le.aircraft.aircraft_count24;
	self.attributes.num_aircraft36 := le.aircraft.aircraft_count36;
	self.attributes.num_aircraft60 := le.aircraft.aircraft_count60;
	self.attributes.total_number_derogs := le.total_number_derogs;
	self.attributes.date_last_derog := le.date_last_derog;
	self.attributes.felonies30 := le.bjl.criminal_count30;
	self.attributes.felonies90 := le.bjl.criminal_count90;
	self.attributes.felonies180 := le.bjl.criminal_count180;
	self.attributes.felonies12 := le.bjl.criminal_count12;
	self.attributes.felonies24 := le.bjl.criminal_count24;
	self.attributes.felonies36 := le.bjl.criminal_count36;
	self.attributes.felonies60 := le.bjl.criminal_count60;
	self.attributes.arrests := le.bjl.arrests_count;
	self.attributes.date_last_arrest := le.bjl.date_last_arrest;	
	self.attributes.arrests30 := le.bjl.arrests_count30;
	self.attributes.arrests90 := le.bjl.arrests_count90;
	self.attributes.arrests180 := le.bjl.arrests_count180;
	self.attributes.arrests12 := le.bjl.arrests_count12;
	self.attributes.arrests24 := le.bjl.arrests_count24;
	self.attributes.arrests36 := le.bjl.arrests_count36;
	self.attributes.arrests60 := le.bjl.arrests_count60;
	self.attributes.num_unreleased_liens30 := le.bjl.liens_unreleased_count30;
	self.attributes.num_unreleased_liens90 := le.bjl.liens_unreleased_count90;
	self.attributes.num_unreleased_liens180 := le.bjl.liens_unreleased_count180;
	self.attributes.num_unreleased_liens12 := le.bjl.liens_unreleased_count12;
	self.attributes.num_unreleased_liens24 := le.bjl.liens_unreleased_count24;
	self.attributes.num_unreleased_liens36 := le.bjl.liens_unreleased_count36;
	self.attributes.num_unreleased_liens60 := le.bjl.liens_unreleased_count60;
	self.attributes.num_released_liens30 := le.bjl.liens_released_count30;
	self.attributes.num_released_liens90 := le.bjl.liens_released_count90;
	self.attributes.num_released_liens180 := le.bjl.liens_released_count180;
	self.attributes.num_released_liens12 := le.bjl.liens_released_count12;
	self.attributes.num_released_liens24 := le.bjl.liens_released_count24;
	self.attributes.num_released_liens36 := le.bjl.liens_released_count36;
	self.attributes.num_released_liens60 := le.bjl.liens_released_count60;
	self.attributes.bankruptcy_count30 := le.bjl.bk_count30;
	self.attributes.bankruptcy_count90 := le.bjl.bk_count90;
	self.attributes.bankruptcy_count180 := le.bjl.bk_count180;
	self.attributes.bankruptcy_count12 := le.bjl.bk_count12;
	self.attributes.bankruptcy_count24 := le.bjl.bk_count24;
	self.attributes.bankruptcy_count36 := le.bjl.bk_count36;
	self.attributes.bankruptcy_count60 := le.bjl.bk_count60;
	self.attributes.eviction_count := le.bjl.eviction_count;
	self.attributes.date_last_eviction := le.bjl.last_eviction_date;
	self.attributes.eviction_count30 := le.bjl.eviction_count30;
	self.attributes.eviction_count90 := le.bjl.eviction_count90;
	self.attributes.eviction_count180 := le.bjl.eviction_count180;
	self.attributes.eviction_count12 := le.bjl.eviction_count12;
	self.attributes.eviction_count24 := le.bjl.eviction_count24;
	self.attributes.eviction_count36 := le.bjl.eviction_count36;
	self.attributes.eviction_count60 := le.bjl.eviction_count60;
	self.attributes.num_nonderogs := le.source_verification.num_nonderogs;
	self.attributes.num_nonderogs30 := le.source_verification.num_nonderogs30;
	self.attributes.num_nonderogs90 := le.source_verification.num_nonderogs90;
	self.attributes.num_nonderogs180 := le.source_verification.num_nonderogs180;
	self.attributes.num_nonderogs12 := le.source_verification.num_nonderogs12;
	self.attributes.num_nonderogs24 := le.source_verification.num_nonderogs24;
	self.attributes.num_nonderogs36 := le.source_verification.num_nonderogs36;
	self.attributes.num_nonderogs60 := le.source_verification.num_nonderogs60;
	self.attributes.num_proflic30 := le.professional_license.proflic_count30;
	self.attributes.num_proflic90 := le.professional_license.proflic_count90;
	self.attributes.num_proflic180 := le.professional_license.proflic_count180;
	self.attributes.num_proflic12 := le.professional_license.proflic_count12;
	self.attributes.num_proflic24 := le.professional_license.proflic_count24;
	self.attributes.num_proflic36 := le.professional_license.proflic_count36;
	self.attributes.num_proflic60 := le.professional_license.proflic_count60;
	self.attributes.num_proflic_exp30 := le.professional_license.expire_count30;
	self.attributes.num_proflic_exp90 := le.professional_license.expire_count90;
	self.attributes.num_proflic_exp180 := le.professional_license.expire_count180;
	self.attributes.num_proflic_exp12 := le.professional_license.expire_count12;
	self.attributes.num_proflic_exp24 := le.professional_license.expire_count24;
	self.attributes.num_proflic_exp36 := le.professional_license.expire_count36;
	self.attributes.num_proflic_exp60 := le.professional_license.expire_count60;
	
	self.infutor := le.infutor_phone;	// puts the infutor phone results into the infutor spot to match previous output
	self.iid.correctlast := if(le.iid.correctlast<>'', '1','0');	// brent doesn't want to see lastnames, so populate with a 1 or 0

	self.student.file_type := le.student.file_type2;	

	self := le;
end;

edina_fcra_arch_temp := 	project(res_fcra_arch, convertToEdina(left));
edina_fcra_curr_temp := 	project(res_fcra_curr, convertToEdina(left));
edina_nonfcra_arch_temp := 	project(res_nonfcra_arch, convertToEdina(left));
edina_nonfcra_curr_temp := 	project(res_nonfcra_curr, convertToEdina(left));

risk_indicators.Layout_Boca_Shell_Edina set_fcra(risk_indicators.Layout_Boca_Shell_Edina le) := transform
	self.fd_scores := [];	
	self := le;
end;

risk_indicators.Layout_Boca_Shell_Edina set_nonfcra(risk_indicators.Layout_Boca_Shell_Edina le) := transform
	self.rv_scores := [];	
	self.isFCRA := '0';
	self := le;
end;

edina_fcra_arch := 		project(edina_fcra_arch_temp, 		set_fcra(LEFT)); 
edina_fcra_curr := 		project(edina_fcra_curr_temp, 		set_fcra(LEFT)); 
edina_nonfcra_arch := 	project(edina_nonfcra_arch_temp, 	set_nonfcra(LEFT)); 
edina_nonfcra_curr := 	project(edina_nonfcra_curr_temp, 	set_nonfcra(LEFT)); 

output(choosen(edina_fcra_arch, eyeball),    named('edina_fcra_arch'));
output(choosen(edina_fcra_curr, eyeball),    named('edina_fcra_curr'));
output(choosen(edina_nonfcra_arch, eyeball), named('edina_nonfcra_arch'));
output(choosen(edina_nonfcra_curr, eyeball), named('edina_nonfcra_curr'));

output(edina_fcra_arch,, 	output_file + '_30_fcra_' + 	today + '_' + history_date_archive, 	CSV(QUOTE('"')), overwrite);
output(edina_fcra_curr,, 	output_file + '_30_fcra_' + 	today + '_999999', 						CSV(QUOTE('"')), overwrite);
output(edina_nonfcra_arch,, output_file + '_30_nonfcra_' + 	today + '_' + history_date_archive, 	CSV(QUOTE('"')), overwrite);
output(edina_nonfcra_curr,, output_file + '_30_nonfcra_' + 	today + '_999999', 						CSV(QUOTE('"')), overwrite);

endmacro;