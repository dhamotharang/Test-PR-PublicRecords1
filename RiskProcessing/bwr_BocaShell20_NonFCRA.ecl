﻿#workunit('name','NonFCRA Bocashell version 2');
// Tests regular or FCRA BocaShell functionality

// Reads sample data from input file, makes a SOAP call to service specified and (optionally),
// saves results in output file. 
// Before running:
//   set IsFCRA flag (false for regular BocaShell)
//   choose (or define) input file name and, if needed, output file name as well;
//   choose (or define) input layout;
//   check the number of records to read from input;
//   verify the number of parallel SOAP calls (note that 'parallel_calls' params is being ignored now);
//   uncomment file-output, if needed;

IMPORT Risk_Indicators, riskwise;

boolean IsFCRA := false;          //true=FCRA Bocashell... false=NON-FCRA Bocashell
unsigned record_limit := 10;      //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
string DataRestrictionMask := '00000000010101000000000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

string DataPermissionMask := '000000000000000000000';

// found <_LoginId>IBOC0001</_LoginId> transactions in the roxie logs to find their exact DRM and DPM to run with
// <DataRestrictionMask>00000000010101000000000000000000000000000000</DataRestrictionMask>
// <DataPermissionMask>000000000000000000000</DataPermissionMask>
																								
//===================  input-output files  ======================
infile_name :=  '~jpyon::in::paro_8277_f_s_in';
outfile_name := '~jpyon::out::paro_8277_nonfcra20_out_' + thorlib.wuid();


//==================  input file layout  ========================
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
 

 
//====================================================
//=============  Service settings ====================
//====================================================
// Regular BocaShell service
bs_service := 'risk_indicators.Boca_Shell';
roxieIP := riskwise.shortcuts.prod_batch_analytics_roxie;

//====================================================
//=====================  R U N  ======================
//====================================================
// load sample data

ds_in := dataset (infile_name, layout_input, csv(quote('"')));
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (ds_input, NAMED ('input'));

l := RECORD
  STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
END;
	
l assignAccount (ds_input le, INTEGER c) := TRANSFORM
  SELF.old_account_number := le.Account;
  SELF.AccountNumber := (STRING)c;
  	
  SELF.GLBPurpose  := 1;
  SELF.DPPAPurpose := 3;
 
//this is left for convenience: history date from the input file may be overwritten here
// SELF.HistoryDateYYYYMM := (Integer)((string)le.historydateyyyymm[1..6]);
  
  self.historydateyyyymm :=If (le.historydateyyyymm <>999999, (integer) If (le.historydateyyyymm[5..6] <> '01', 
	                             le.historydateyyyymm[1..4] + intformat( ((integer)le.historydateyyyymm[5..6] -1), 2, 1), 
					             (string)((integer)le.historydateyyyymm[1..4] -1) + '12'),999999);  
  
  self.IncludeScore := true;
	SELF.datarestrictionmask := datarestrictionmask;
	SELF.DataPermissionMask := DataPermissionMask;
	self.bsversion := 2;
		
	SELF := le;
	SELF := [];
END;


	
layout_soap := record
	Risk_Indicators.Layout_InstID_SoapCall;
end;
	
p_f := PROJECT (ds_input, assignAccount (LEFT,COUNTER));
output(p_f, named('BSInput'));

s := Risk_Indicators.test_BocaShell_SoapCall (PROJECT (p_f, TRANSFORM (layout_soap, SELF := LEFT)),
                                                bs_service, roxieIP, parallel_calls);
		

ox :=
	RECORD
		STRING AccountNumber;
		risk_indicators.Layout_Boca_Shell;
		STRING errorcode;
	END;
	
ox getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;
	
res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
res_err := res (errorcode<>'');

OUTPUT (res, NAMED ('result'));
IF (EXISTS (res_err), OUTPUT (res_err, NAMED ('res_err')));

OUTPUT (res, , outfile_name);
IF (EXISTS (res_err), OUTPUT (res_err, , outfile_name + '_err'));


// the conversion portion-----------------------------------------------------------------------

f := dataset(outfile_name, ox, thor);
output(f, named('infile'));

risk_indicators.Layout_Boca_Shell_Edina convertToEdina(f le) := transform
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
	self.student.file_type := le.student.file_type2;
	
	// new shell 2.5 fields
	self.isFCRA := '0';
	self.rv_scores := [];	// riskview not populated in non-fcra
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
	
	self := le;
end;

edina := project(f, convertToEdina(left));
output(edina, named('edina'));
output(edina,, outfile_name+'_edina',csv(quote('"'), maxlength(20000)));
