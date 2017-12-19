#workunit('name','NonFCRA BT-ST Bocashell 4.0 Process');

/* *** Note that Netacuity is turned ON *** needs to use Cert gateway  */

import risk_indicators, riskwise;

unsigned record_limit :=   0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 10;
string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 12 restricts ADVO
unsigned1 glba := 1;
unsigned1 dppa := 3;
unsigned3 LastSeenThreshold := 0;	//# of days to consider header records as being recent for verification.  0 will use default (41 and lower = 365 days, 50 and higher = include all) 

//===================  input-output files  ======================
infile_name  := '~jpyon::in::dell_1545_new_bt_st_input_in';
outfile_name := '~dvstemp::out::btst40_out_'+ thorlib.wuid();	// this will output your work unit number in your filename

roxieIP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
// roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP;   

//==============  Program uses Consumer Data Only  ====================
//==================  bt-st input file layout  ========================
BTST_in := record
      string30 	accountnumber := '';
      string30 	firstname := '';
	    string30 	middlename := '';
      string30 	lastname := '';
	    string5	  suffix := '';
      string120	streetaddress := '';
      string25 	city := '';
      string2 	state := '';
      string5 	zip := '';
	    string25	country := '';
      string9 	ssn := '';
      string8 	dateofbirth := '';
	    unsigned1	age := 0;       // not used
      string20 	dlnumber := '';
      string2 	dlstate := '';
	    string100	email := '';
	    string120	ipaddress := '';
	    string10 	homephone := '';
      string10 	workphone := '';
	    string100	employername := '';
      string30	formername := '';
      string30 	firstname2 := '';
	    string30 	middlename2 := '';
      string30 	lastname2 := '';
	    string5	suffix2 := '';
      string120	streetaddress2 := '';
      string25 	city2 := '';
      string2 	state2 := '';
      string5 	zip2 := '';
	    string25	country2 := '';
      string9 	ssn2 := '';
      string8 	dateofbirth2 := '';
	    unsigned1	age2 := 0;       // not used
      string20 	dlnumber2 := '';
      string2 	dlstate2 := '';
	    string100	email2 := '';
	    string120	ipaddress2 := '';
	    string10 	homephone2 := '';
      string10 	workphone2 := '';
	    string100	employername2 := '';
      string30	formername2 := '';
      string6 	historydateyyyymm := '';
end;

//====================================================
//=====================  R U N  ======================
//====================================================
// load sample data
ds_in := dataset (infile_name, BTST_in, csv(quote('"'), maxlength(8192)));

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input, eyeball), NAMED ('input'));


l :=	RECORD
	string old_accountnumber := '';
	string AccountNumber := '';
	string FirstName := '';
	string MiddleName := '';
	string LastName := '';
	string NameSuffix := '';
	string StreetAddress := '';
	string City := '';
	string State := '';
	string Zip := '';
	string Country := '';
	string SSN := '';
	string DateOfBirth := '';
	unsigned Age := 0;
	string DLNumber := '';
	string DLState := '';
	string Email := '';
	string IPAddress := '';
	string HomePhone := '';
	string WorkPhone := '';
	string EmployerName := '';
	string FormerName := '';
	string FirstName2 := '';
	string MiddleName2 := '';
	string LastName2 := '';
	string NameSuffix2 := '';
	string StreetAddress2 := '';
	string City2 := '';
	string State2 := '';
	string Zip2 := '';
	string Country2 := '';
	string SSN2 := '';
	string DateOfBirth2 := '';
	unsigned Age2 := 0;
	string DLNumber2 := '';
	string DLState2 := '';
	string Email2 := '';
	string IPAddress2 := '';
	string HomePhone2 := '';
	string WorkPhone2 := '';
	string EmployerName2 := '';
	string FormerName2 := '';
	unsigned DPPAPurpose := 3;
	unsigned GLBPurpose := 1;
	string IndustryClass := '';
	unsigned HistoryDateYYYYMM := 999999;
	string DataRestrictionMask;
	dataset(risk_indicators.Layout_Gateways_In) gateways;
	integer bsversion;
	unsigned3 LastSeenThreshold;
END;

l t_f(ds_input le, INTEGER c) := TRANSFORM
	self.old_accountnumber := le.accountnumber;
	SELF.accountnumber := (string)C;
  // self.historydateyyyymm := 200412;  
	// self.historydateyyyymm := (unsigned)le.historydateyyyymm;
  SELF.HistoryDateYYYYMM := (Integer) le.historydateyyyymm[1..6];	
	
	self.dppapurpose := dppa;
	self.glbpurpose := glba;
	self.gateways := riskwise.shortcuts.gw_netacuity;
	SELF.datarestrictionmask := datarestrictionmask;
	SELF.LastSeenThreshold := LastSeenThreshold;
	self.bsversion := 4;		
	SELF := le;
	//SELF := [];
END;


indata := PROJECT(ds_input, t_f(LEFT,COUNTER));
output(choosen(indata, eyeball), named('indata'));


temp_layout := record
	STRING30 AccountNumber;
	risk_indicators.layout_bocashell_btst_out;
	STRING200 errorcode;	
END;

temp_layout myFail(indata le) :=	TRANSFORM
	self.Bill_To_Out.seq := ((unsigned)le.accountnumber) * 2;
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.accountnumber := le.old_AccountNumber;
	SELF := [];
END;
	

resu := soapcall(indata, roxieIP,
				  'Risk_Indicators.Boca_Shell_BtSt_Service', {indata},
				  DATASET(temp_layout),
				  PARALLEL(parallel_calls), onFail(myFail(LEFT)));


final_layout := record
	string30 accountnumber;
	risk_indicators.Layout_Boca_Shell Bill_To_Out;
	risk_indicators.Layout_Boca_Shell Ship_To_Out;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
	string50 errorcode;
end;

fin := project(resu, transform(final_layout, self:=left));
final := join(indata,fin, ((unsigned)left.accountnumber)*2 = right.bill_to_out.seq, 
			transform(final_layout, self.accountnumber := left.old_accountnumber, self := right));


res_err := final(errorcode<>'');

OUTPUT (choosen(final, eyeball), NAMED ('final'));
OUTPUT (choosen(res_err, eyeball), NAMED ('res_err'));

OUTPUT (final, , outfile_name, CSV(QUOTE('"')),overwrite );
OUTPUT (res_err, , outfile_name + '_err', CSV(QUOTE('"')),overwrite);


// --------------- the conversion portion -----------------------------------------

	
f := dataset(outfile_name, final_layout, csv(quote('"'), maxlength(25000)));
output(choosen(f, eyeball), named('infile'));



ox := record
	risk_indicators.Layout_Boca_Shell_Edina_v4 bto;
	risk_indicators.Layout_Boca_Shell_Edina_v4 sto;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
end;


ox convertToEdina_v4(f le) := transform
	self.bto.accountnumber := le.accountnumber;
	self.bto.address_verification.input_address_information.lres := le.Bill_To_Out.lres;
	self.bto.address_verification.address_history_1.lres := le.Bill_To_Out.lres2;
	self.bto.address_verification.address_history_2.lres := le.Bill_To_Out.lres3;
	self.bto.address_verification.input_address_information.addrPop := le.Bill_To_Out.addrPop;
	self.bto.address_verification.address_history_1.addrPop := le.Bill_To_Out.addrPop2;
	self.bto.address_verification.address_history_2.addrPop := le.Bill_To_Out.addrPop3;
	self.bto.address_verification.input_address_information.avm_land_use_code := le.Bill_To_Out.avm.input_address_information.avm_land_use_code;
	self.bto.address_verification.input_address_information.avm_recording_date := le.Bill_To_Out.avm.input_address_information.avm_recording_date;
	self.bto.address_verification.input_address_information.avm_assessed_value_year := le.Bill_To_Out.avm.input_address_information.avm_assessed_value_year;
	self.bto.address_verification.input_address_information.avm_sales_price := le.Bill_To_Out.avm.input_address_information.avm_sales_price;  
	self.bto.address_verification.input_address_information.avm_assessed_total_value := le.Bill_To_Out.avm.input_address_information.avm_assessed_total_value;
	self.bto.address_verification.input_address_information.avm_market_total_value := le.Bill_To_Out.avm.input_address_information.avm_market_total_value;
	self.bto.address_verification.input_address_information.avm_tax_assessment_valuation := le.Bill_To_Out.avm.input_address_information.avm_tax_assessment_valuation;
	self.bto.address_verification.input_address_information.avm_price_index_valuation := le.Bill_To_Out.avm.input_address_information.avm_price_index_valuation;
	self.bto.address_verification.input_address_information.avm_hedonic_valuation := le.Bill_To_Out.avm.input_address_information.avm_hedonic_valuation;
	self.bto.address_verification.input_address_information.avm_automated_valuation := le.Bill_To_Out.avm.input_address_information.avm_automated_valuation;
	self.bto.address_verification.input_address_information.avm_confidence_score := le.Bill_To_Out.avm.input_address_information.avm_confidence_score;
	self.bto.address_verification.input_address_information.avm_median_fips_level := le.Bill_To_Out.avm.input_address_information.avm_median_fips_level;
	self.bto.address_verification.input_address_information.avm_median_geo11_level := le.Bill_To_Out.avm.input_address_information.avm_median_geo11_level;
	self.bto.address_verification.input_address_information.avm_median_geo12_level := le.Bill_To_Out.avm.input_address_information.avm_median_geo12_level;
	
	self.bto.address_verification.address_history_1.avm_land_use_code := le.Bill_To_Out.avm.address_history_1.avm_land_use_code;
	self.bto.address_verification.address_history_1.avm_recording_date := le.Bill_To_Out.avm.address_history_1.avm_recording_date;
	self.bto.address_verification.address_history_1.avm_assessed_value_year := le.Bill_To_Out.avm.address_history_1.avm_assessed_value_year;
	self.bto.address_verification.address_history_1.avm_sales_price := le.Bill_To_Out.avm.address_history_1.avm_sales_price;  
	self.bto.address_verification.address_history_1.avm_assessed_total_value := le.Bill_To_Out.avm.address_history_1.avm_assessed_total_value;
	self.bto.address_verification.address_history_1.avm_market_total_value := le.Bill_To_Out.avm.address_history_1.avm_market_total_value;
	self.bto.address_verification.address_history_1.avm_tax_assessment_valuation := le.Bill_To_Out.avm.address_history_1.avm_tax_assessment_valuation;
	self.bto.address_verification.address_history_1.avm_price_index_valuation := le.Bill_To_Out.avm.address_history_1.avm_price_index_valuation;
	self.bto.address_verification.address_history_1.avm_hedonic_valuation := le.Bill_To_Out.avm.address_history_1.avm_hedonic_valuation;
	self.bto.address_verification.address_history_1.avm_automated_valuation := le.Bill_To_Out.avm.address_history_1.avm_automated_valuation;
	self.bto.address_verification.address_history_1.avm_confidence_score := le.Bill_To_Out.avm.address_history_1.avm_confidence_score;
	self.bto.address_verification.address_history_1.avm_median_fips_level := le.Bill_To_Out.avm.address_history_1.avm_median_fips_level;
	self.bto.address_verification.address_history_1.avm_median_geo11_level := le.Bill_To_Out.avm.address_history_1.avm_median_geo11_level;
	self.bto.address_verification.address_history_1.avm_median_geo12_level := le.Bill_To_Out.avm.address_history_1.avm_median_geo12_level;
	
	self.bto.Velocity_Counters.adlPerSSN_count := le.Bill_To_Out.SSN_Verification.adlPerSSN_count;
	
	self.bto.iid.socllowissue := (unsigned)le.Bill_To_Out.iid.socllowissue;
	self.bto.iid.soclhighissue := (unsigned)le.Bill_To_Out.iid.soclhighissue;
	self.bto.iid.areacodesplitdate := (unsigned)le.Bill_To_Out.iid.areacodesplitdate;
	self.bto.student.date_first_seen := (unsigned)le.Bill_To_Out.student.date_first_seen;
	self.bto.student.date_last_seen := (unsigned)le.Bill_To_Out.student.date_last_seen;
	self.bto.student.dob_formatted := (unsigned)le.Bill_To_Out.student.dob_formatted;
	
	// new shell 2.5 fields
	self.bto.isFCRA := '0';
	self.bto.rv_scores := [];	// riskview not populated in non-fcra
	////////////
	
		//// new shell 3.0 fields
	self.bto.cb_allowed := map(	dataRestrictionMask[6]<>'1' and dataRestrictionMask[8]<>'1' and dataRestrictionMask[10]<>'1' => 'ALL',
								dataRestrictionMask[8]<>'1' => 'EQ',
								dataRestrictionMask[6]<>'1' => 'EN',
								dataRestrictionMask[10]<>'1' => 'TN',
								'NONE');		// this should not happen
							
	self.bto.iid.ConsumerFlags := le.Bill_To_Out.ConsumerFlags;
	
	self.bto.ssn_verification.inputsocscharflag := le.Bill_To_Out.ssn_verification.validation.inputsocscharflag;
	
	self.bto.Address_Verification.Address_History_1.addr_type := le.Bill_To_Out.Address_Verification.addr_type2;
	self.bto.Address_Verification.Address_History_2.addr_type := le.Bill_To_Out.Address_Verification.addr_type3;

	self.bto.input_dob_age := le.Bill_To_Out.shell_input.age;
	
	self.bto.Address_Verification.Input_Address_Information.building_area := (string)le.Bill_To_Out.address_verification.input_address_information.building_area ;
	self.bto.Address_Verification.Input_Address_Information.no_of_buildings := (string)le.Bill_To_Out.address_verification.input_address_information.no_of_buildings ;
	self.bto.Address_Verification.Input_Address_Information.no_of_stories := (string)le.Bill_To_Out.address_verification.input_address_information.no_of_stories ;
	self.bto.Address_Verification.Input_Address_Information.no_of_rooms := (string)le.Bill_To_Out.address_verification.input_address_information.no_of_rooms ;
	self.bto.Address_Verification.Input_Address_Information.no_of_bedrooms := (string)le.Bill_To_Out.address_verification.input_address_information.no_of_bedrooms ;
	self.bto.Address_Verification.Input_Address_Information.no_of_baths := (string)le.Bill_To_Out.address_verification.input_address_information.no_of_baths;
	self.bto.Address_Verification.Input_Address_Information.no_of_partial_baths := (string)le.Bill_To_Out.address_verification.input_address_information.no_of_partial_baths ;
	self.bto.Address_Verification.Input_Address_Information.parking_no_of_cars := (string)le.Bill_To_Out.address_verification.input_address_information.parking_no_of_cars;
	self.bto.Address_Verification.Input_Address_Information.avm_automated_valuation2 := le.Bill_To_Out.avm.input_address_information.avm_automated_valuation2;
	self.bto.Address_Verification.Input_Address_Information.avm_automated_valuation3 := le.Bill_To_Out.avm.input_address_information.avm_automated_valuation3;
	self.bto.Address_Verification.Input_Address_Information.avm_automated_valuation4 := le.Bill_To_Out.avm.input_address_information.avm_automated_valuation4;
	self.bto.Address_Verification.Input_Address_Information.avm_automated_valuation5 := le.Bill_To_Out.avm.input_address_information.avm_automated_valuation5;
	self.bto.Address_Verification.Input_Address_Information.avm_automated_valuation6 := le.Bill_To_Out.avm.input_address_information.avm_automated_valuation6;
	
	self.bto.address_verification.address_history_1.building_area := (string)le.Bill_To_Out.address_verification.address_history_1.building_area ;
	self.bto.address_verification.address_history_1.no_of_buildings := (string)le.Bill_To_Out.address_verification.address_history_1.no_of_buildings ;
	self.bto.address_verification.address_history_1.no_of_stories := (string)le.Bill_To_Out.address_verification.address_history_1.no_of_stories ;
	self.bto.address_verification.address_history_1.no_of_rooms := (string)le.Bill_To_Out.address_verification.address_history_1.no_of_rooms ;
	self.bto.address_verification.address_history_1.no_of_bedrooms := (string)le.Bill_To_Out.address_verification.address_history_1.no_of_bedrooms ;
	self.bto.address_verification.address_history_1.no_of_baths := (string)le.Bill_To_Out.address_verification.address_history_1.no_of_baths;
	self.bto.address_verification.address_history_1.no_of_partial_baths := (string)le.Bill_To_Out.address_verification.address_history_1.no_of_partial_baths ;
	self.bto.address_verification.address_history_1.parking_no_of_cars := (string)le.Bill_To_Out.address_verification.address_history_1.parking_no_of_cars;
	self.bto.Address_Verification.Address_History_1.avm_automated_valuation2 := le.Bill_To_Out.avm.address_history_1.avm_automated_valuation2;
	self.bto.Address_Verification.Address_History_1.avm_automated_valuation3 := le.Bill_To_Out.avm.address_history_1.avm_automated_valuation3;
	self.bto.Address_Verification.Address_History_1.avm_automated_valuation4 := le.Bill_To_Out.avm.address_history_1.avm_automated_valuation4;
	self.bto.Address_Verification.Address_History_1.avm_automated_valuation5 := le.Bill_To_Out.avm.address_history_1.avm_automated_valuation5;
	self.bto.Address_Verification.Address_History_1.avm_automated_valuation6 := le.Bill_To_Out.avm.address_history_1.avm_automated_valuation6;
	
	self.bto.bjl.liens := le.Bill_To_Out.liens;
	
	// attribute fields added
	self.bto.attributes.addrs_last30 := le.Bill_To_Out.other_address_info.addrs_last30;
	self.bto.attributes.addrs_last90 := le.Bill_To_Out.other_address_info.addrs_last90;
	self.bto.attributes.addrs_last12 := le.Bill_To_Out.other_address_info.addrs_last12;
	self.bto.attributes.addrs_last24 := le.Bill_To_Out.other_address_info.addrs_last24;
	self.bto.attributes.addrs_last36 := le.Bill_To_Out.other_address_info.addrs_last36;
	self.bto.attributes.date_first_purchase := le.Bill_To_Out.other_address_info.date_first_purchase;	
	self.bto.attributes.date_most_recent_purchase := le.Bill_To_Out.other_address_info.date_most_recent_purchase;	
	self.bto.attributes.date_most_recent_sale := le.Bill_To_Out.other_address_info.date_most_recent_sale;	
	self.bto.attributes.num_purchase30 := le.Bill_To_Out.other_address_info.num_purchase30;
	self.bto.attributes.num_purchase90 := le.Bill_To_Out.other_address_info.num_purchase90;
	self.bto.attributes.num_purchase180 := le.Bill_To_Out.other_address_info.num_purchase180;
	self.bto.attributes.num_purchase12 := le.Bill_To_Out.other_address_info.num_purchase12;
	self.bto.attributes.num_purchase24 := le.Bill_To_Out.other_address_info.num_purchase24;
	self.bto.attributes.num_purchase36 := le.Bill_To_Out.other_address_info.num_purchase36;
	self.bto.attributes.num_purchase60 := le.Bill_To_Out.other_address_info.num_purchase60;
	self.bto.attributes.num_sold30 := le.Bill_To_Out.other_address_info.num_sold30;
	self.bto.attributes.num_sold90 := le.Bill_To_Out.other_address_info.num_sold90;
	self.bto.attributes.num_sold180 := le.Bill_To_Out.other_address_info.num_sold180;
	self.bto.attributes.num_sold12 := le.Bill_To_Out.other_address_info.num_sold12;
	self.bto.attributes.num_sold24 := le.Bill_To_Out.other_address_info.num_sold24;
	self.bto.attributes.num_sold36 := le.Bill_To_Out.other_address_info.num_sold36;
	self.bto.attributes.num_sold60 := le.Bill_To_Out.other_address_info.num_sold60;
	self.bto.attributes.num_watercraft30 := le.Bill_To_Out.watercraft.watercraft_count30;
	self.bto.attributes.num_watercraft90 := le.Bill_To_Out.watercraft.watercraft_count90;
	self.bto.attributes.num_watercraft180 := le.Bill_To_Out.watercraft.watercraft_count180;
	self.bto.attributes.num_watercraft12 := le.Bill_To_Out.watercraft.watercraft_count12;
	self.bto.attributes.num_watercraft24 := le.Bill_To_Out.watercraft.watercraft_count24;
	self.bto.attributes.num_watercraft36 := le.Bill_To_Out.watercraft.watercraft_count36;
	self.bto.attributes.num_watercraft60 := le.Bill_To_Out.watercraft.watercraft_count60;
	self.bto.attributes.num_aircraft := le.Bill_To_Out.aircraft.aircraft_count;
	self.bto.attributes.num_aircraft30 := le.Bill_To_Out.aircraft.aircraft_count30;
	self.bto.attributes.num_aircraft90 := le.Bill_To_Out.aircraft.aircraft_count90;
	self.bto.attributes.num_aircraft180 := le.Bill_To_Out.aircraft.aircraft_count180;
	self.bto.attributes.num_aircraft12 := le.Bill_To_Out.aircraft.aircraft_count12;
	self.bto.attributes.num_aircraft24 := le.Bill_To_Out.aircraft.aircraft_count24;
	self.bto.attributes.num_aircraft36 := le.Bill_To_Out.aircraft.aircraft_count36;
	self.bto.attributes.num_aircraft60 := le.Bill_To_Out.aircraft.aircraft_count60;
	self.bto.attributes.total_number_derogs := le.Bill_To_Out.total_number_derogs;
	self.bto.attributes.date_last_derog := le.Bill_To_Out.date_last_derog;
	self.bto.attributes.felonies30 := le.Bill_To_Out.bjl.criminal_count30;
	self.bto.attributes.felonies90 := le.Bill_To_Out.bjl.criminal_count90;
	self.bto.attributes.felonies180 := le.Bill_To_Out.bjl.criminal_count180;
	self.bto.attributes.felonies12 := le.Bill_To_Out.bjl.criminal_count12;
	self.bto.attributes.felonies24 := le.Bill_To_Out.bjl.criminal_count24;
	self.bto.attributes.felonies36 := le.Bill_To_Out.bjl.criminal_count36;
	self.bto.attributes.felonies60 := le.Bill_To_Out.bjl.criminal_count60;
	self.bto.attributes.arrests := le.Bill_To_Out.bjl.arrests_count;
	self.bto.attributes.date_last_arrest := le.Bill_To_Out.bjl.date_last_arrest;	
	self.bto.attributes.arrests30 := le.Bill_To_Out.bjl.arrests_count30;
	self.bto.attributes.arrests90 := le.Bill_To_Out.bjl.arrests_count90;
	self.bto.attributes.arrests180 := le.Bill_To_Out.bjl.arrests_count180;
	self.bto.attributes.arrests12 := le.Bill_To_Out.bjl.arrests_count12;
	self.bto.attributes.arrests24 := le.Bill_To_Out.bjl.arrests_count24;
	self.bto.attributes.arrests36 := le.Bill_To_Out.bjl.arrests_count36;
	self.bto.attributes.arrests60 := le.Bill_To_Out.bjl.arrests_count60;
	self.bto.attributes.num_unreleased_liens30 := le.Bill_To_Out.bjl.liens_unreleased_count30;
	self.bto.attributes.num_unreleased_liens90 := le.Bill_To_Out.bjl.liens_unreleased_count90;
	self.bto.attributes.num_unreleased_liens180 := le.Bill_To_Out.bjl.liens_unreleased_count180;
	self.bto.attributes.num_unreleased_liens12 := le.Bill_To_Out.bjl.liens_unreleased_count12;
	self.bto.attributes.num_unreleased_liens24 := le.Bill_To_Out.bjl.liens_unreleased_count24;
	self.bto.attributes.num_unreleased_liens36 := le.Bill_To_Out.bjl.liens_unreleased_count36;
	self.bto.attributes.num_unreleased_liens60 := le.Bill_To_Out.bjl.liens_unreleased_count60;
	self.bto.attributes.num_released_liens30 := le.Bill_To_Out.bjl.liens_released_count30;
	self.bto.attributes.num_released_liens90 := le.Bill_To_Out.bjl.liens_released_count90;
	self.bto.attributes.num_released_liens180 := le.Bill_To_Out.bjl.liens_released_count180;
	self.bto.attributes.num_released_liens12 := le.Bill_To_Out.bjl.liens_released_count12;
	self.bto.attributes.num_released_liens24 := le.Bill_To_Out.bjl.liens_released_count24;
	self.bto.attributes.num_released_liens36 := le.Bill_To_Out.bjl.liens_released_count36;
	self.bto.attributes.num_released_liens60 := le.Bill_To_Out.bjl.liens_released_count60;
	self.bto.attributes.bankruptcy_count30 := le.Bill_To_Out.bjl.bk_count30;
	self.bto.attributes.bankruptcy_count90 := le.Bill_To_Out.bjl.bk_count90;
	self.bto.attributes.bankruptcy_count180 := le.Bill_To_Out.bjl.bk_count180;
	self.bto.attributes.bankruptcy_count12 := le.Bill_To_Out.bjl.bk_count12;
	self.bto.attributes.bankruptcy_count24 := le.Bill_To_Out.bjl.bk_count24;
	self.bto.attributes.bankruptcy_count36 := le.Bill_To_Out.bjl.bk_count36;
	self.bto.attributes.bankruptcy_count60 := le.Bill_To_Out.bjl.bk_count60;
	self.bto.attributes.eviction_count := le.Bill_To_Out.bjl.eviction_count;
	self.bto.attributes.date_last_eviction := le.Bill_To_Out.bjl.last_eviction_date;
	self.bto.attributes.eviction_count30 := le.Bill_To_Out.bjl.eviction_count30;
	self.bto.attributes.eviction_count90 := le.Bill_To_Out.bjl.eviction_count90;
	self.bto.attributes.eviction_count180 := le.Bill_To_Out.bjl.eviction_count180;
	self.bto.attributes.eviction_count12 := le.Bill_To_Out.bjl.eviction_count12;
	self.bto.attributes.eviction_count24 := le.Bill_To_Out.bjl.eviction_count24;
	self.bto.attributes.eviction_count36 := le.Bill_To_Out.bjl.eviction_count36;
	self.bto.attributes.eviction_count60 := le.Bill_To_Out.bjl.eviction_count60;
	self.bto.attributes.num_nonderogs := le.Bill_To_Out.source_verification.num_nonderogs;
	self.bto.attributes.num_nonderogs30 := le.Bill_To_Out.source_verification.num_nonderogs30;
	self.bto.attributes.num_nonderogs90 := le.Bill_To_Out.source_verification.num_nonderogs90;
	self.bto.attributes.num_nonderogs180 := le.Bill_To_Out.source_verification.num_nonderogs180;
	self.bto.attributes.num_nonderogs12 := le.Bill_To_Out.source_verification.num_nonderogs12;
	self.bto.attributes.num_nonderogs24 := le.Bill_To_Out.source_verification.num_nonderogs24;
	self.bto.attributes.num_nonderogs36 := le.Bill_To_Out.source_verification.num_nonderogs36;
	self.bto.attributes.num_nonderogs60 := le.Bill_To_Out.source_verification.num_nonderogs60;
	self.bto.attributes.num_proflic30 := le.Bill_To_Out.professional_license.proflic_count30;
	self.bto.attributes.num_proflic90 := le.Bill_To_Out.professional_license.proflic_count90;
	self.bto.attributes.num_proflic180 := le.Bill_To_Out.professional_license.proflic_count180;
	self.bto.attributes.num_proflic12 := le.Bill_To_Out.professional_license.proflic_count12;
	self.bto.attributes.num_proflic24 := le.Bill_To_Out.professional_license.proflic_count24;
	self.bto.attributes.num_proflic36 := le.Bill_To_Out.professional_license.proflic_count36;
	self.bto.attributes.num_proflic60 := le.Bill_To_Out.professional_license.proflic_count60;
	self.bto.attributes.num_proflic_exp30 := le.Bill_To_Out.professional_license.expire_count30;
	self.bto.attributes.num_proflic_exp90 := le.Bill_To_Out.professional_license.expire_count90;
	self.bto.attributes.num_proflic_exp180 := le.Bill_To_Out.professional_license.expire_count180;
	self.bto.attributes.num_proflic_exp12 := le.Bill_To_Out.professional_license.expire_count12;
	self.bto.attributes.num_proflic_exp24 := le.Bill_To_Out.professional_license.expire_count24;
	self.bto.attributes.num_proflic_exp36 := le.Bill_To_Out.professional_license.expire_count36;
	self.bto.attributes.num_proflic_exp60 := le.Bill_To_Out.professional_license.expire_count60;
	
	self.bto.infutor := le.Bill_To_Out.infutor_phone;	// puts the infutor phone results into the infutor spot to match previous output
	self.bto.iid.correctlast := if(le.Bill_To_Out.iid.correctlast<>'', '1','0');	// brent doesn't want to see lastnames, so populate with a 1 or 0
	
	// new mappings for shell 4.0
	self.bto.student.college_major := le.Bill_To_Out.student.college_major;  // won't need this when college major put into the student section correctly
	self.bto.velocity_counters.lnames_per_adl_created_6months := le.Bill_To_Out.velocity_counters.lnames_per_adl180;
	self.bto.address_verification.address_history_2.avm_automated_valuation := le.Bill_To_Out.avm.address_history_2.avm_automated_valuation;

	self.bto.address_verification.input_address_information.market_total_value := le.Bill_To_Out.address_verification.input_address_information.assessed_amount;
	self.bto.address_verification.address_history_1.market_total_value := le.Bill_To_Out.address_verification.address_history_1.assessed_amount;
	self.bto.address_verification.address_history_2.market_total_value := le.Bill_To_Out.address_verification.address_history_2.assessed_amount;
	
	self.bto.Other_Address_Info.unique_addr_cnt := le.Bill_To_Out.address_history_summary.unique_addr_cnt;
	self.bto.Other_Address_Info.avg_mo_per_addr := le.Bill_To_Out.address_history_summary.avg_mo_per_addr;
	self.bto.Other_Address_Info.addr_count2 := le.Bill_To_Out.address_history_summary.addr_count2;
	self.bto.Other_Address_Info.addr_count3 := le.Bill_To_Out.address_history_summary.addr_count3;
	self.bto.Other_Address_Info.addr_count6 := le.Bill_To_Out.address_history_summary.addr_count6;
	self.bto.Other_Address_Info.addr_count10 := le.Bill_To_Out.address_history_summary.addr_count10;
	self.bto.Other_Address_Info.lres_2mo_count := le.Bill_To_Out.address_history_summary.lres_2mo_count;
	self.bto.Other_Address_Info.lres_6mo_count := le.Bill_To_Out.address_history_summary.lres_6mo_count ;
	self.bto.Other_Address_Info.lres_12mo_count := le.Bill_To_Out.address_history_summary.lres_12mo_count;
	self.bto.Other_Address_Info.hist_addr_match := le.Bill_To_Out.address_history_summary.hist_addr_match;	
	self.bto.Other_Address_Info.address_history_advo_college_hit := le.Bill_To_Out.address_history_summary.address_history_advo_college_hit;
	
	self.bto.Address_Verification.Input_Address_Information.Address_Vacancy_Indicator	:= le.Bill_To_Out.advo_input_addr.Address_Vacancy_Indicator	;
	self.bto.Address_Verification.Input_Address_Information.Throw_Back_Indicator := le.Bill_To_Out.advo_input_addr.Throw_Back_Indicator	;
	self.bto.Address_Verification.Input_Address_Information.Seasonal_Delivery_Indicator := le.Bill_To_Out.advo_input_addr.Seasonal_Delivery_Indicator;
	self.bto.Address_Verification.Input_Address_Information.DND_Indicator := le.Bill_To_Out.advo_input_addr.DND_Indicator	;
	self.bto.Address_Verification.Input_Address_Information.College_Indicator := le.Bill_To_Out.advo_input_addr.College_Indicator;
	self.bto.Address_Verification.Input_Address_Information.Drop_Indicator	:= le.Bill_To_Out.advo_input_addr.Drop_Indicator;
	self.bto.Address_Verification.Input_Address_Information.Residential_or_Business_Ind	:= le.Bill_To_Out.advo_input_addr.Residential_or_Business_Ind	;
	self.bto.Address_Verification.Input_Address_Information.Mixed_Address_Usage := le.Bill_To_Out.advo_input_addr.Mixed_Address_Usage;
	
	self.bto.Address_Verification.Input_Address_Information.occupants_1yr := le.Bill_To_Out.addr_risk_summary.occupants_1yr ;
	self.bto.Address_Verification.Input_Address_Information.turnover_1yr_in := le.Bill_To_Out.addr_risk_summary.turnover_1yr_in ;
	self.bto.Address_Verification.Input_Address_Information.turnover_1yr_out := le.Bill_To_Out.addr_risk_summary.turnover_1yr_out ;
	self.bto.Address_Verification.Input_Address_Information.N_Vacant_Properties := le.Bill_To_Out.addr_risk_summary.N_Vacant_Properties;
	self.bto.Address_Verification.Input_Address_Information.N_Business_Count := le.Bill_To_Out.addr_risk_summary.N_Business_Count ;
	self.bto.Address_Verification.Input_Address_Information.N_SFD_Count := le.Bill_To_Out.addr_risk_summary.N_SFD_Count ;
	self.bto.Address_Verification.Input_Address_Information.N_MFD_Count := le.Bill_To_Out.addr_risk_summary.N_MFD_Count;
	self.bto.Address_Verification.Input_Address_Information.N_ave_building_age := le.Bill_To_Out.addr_risk_summary.N_ave_building_age;
	self.bto.Address_Verification.Input_Address_Information.N_ave_purchase_amount := le.Bill_To_Out.addr_risk_summary.N_ave_purchase_amount ;
	self.bto.Address_Verification.Input_Address_Information.N_ave_mortgage_amount := le.Bill_To_Out.addr_risk_summary.N_ave_mortgage_amount ;
	self.bto.Address_Verification.Input_Address_Information.N_ave_assessed_amount := le.Bill_To_Out.addr_risk_summary.N_ave_assessed_amount ;
	self.bto.Address_Verification.Input_Address_Information.N_ave_building_area := le.Bill_To_Out.addr_risk_summary.N_ave_building_area ;
	self.bto.Address_Verification.Input_Address_Information.N_ave_price_per_sf := le.Bill_To_Out.addr_risk_summary.N_ave_price_per_sf ;
	self.bto.Address_Verification.Input_Address_Information.N_ave_no_of_stories_count := le.Bill_To_Out.addr_risk_summary.N_ave_no_of_stories_count ;
	self.bto.Address_Verification.Input_Address_Information.N_ave_no_of_rooms_count := le.Bill_To_Out.addr_risk_summary.N_ave_no_of_rooms_count ;
	self.bto.Address_Verification.Input_Address_Information.N_ave_no_of_bedrooms_count := le.Bill_To_Out.addr_risk_summary.N_ave_no_of_bedrooms_count ;
	self.bto.Address_Verification.Input_Address_Information.N_ave_no_of_baths_count := le.Bill_To_Out.addr_risk_summary.N_ave_no_of_baths_count ;	

	self.bto.Address_Verification.Address_History_1.Address_Vacancy_Indicator	:= le.Bill_To_Out.advo_addr_hist1.Address_Vacancy_Indicator	;
	self.bto.Address_Verification.Address_History_1.Throw_Back_Indicator := le.Bill_To_Out.advo_addr_hist1.Throw_Back_Indicator	;
	self.bto.Address_Verification.Address_History_1.Seasonal_Delivery_Indicator := le.Bill_To_Out.advo_addr_hist1.Seasonal_Delivery_Indicator;
	self.bto.Address_Verification.Address_History_1.DND_Indicator := le.Bill_To_Out.advo_addr_hist1.DND_Indicator	;
	self.bto.Address_Verification.Address_History_1.College_Indicator := le.Bill_To_Out.advo_addr_hist1.College_Indicator;
	self.bto.Address_Verification.Address_History_1.Drop_Indicator	:= le.Bill_To_Out.advo_addr_hist1.Drop_Indicator;
	self.bto.Address_Verification.Address_History_1.Residential_or_Business_Ind	:= le.Bill_To_Out.advo_addr_hist1.Residential_or_Business_Ind	;
	self.bto.Address_Verification.Address_History_1.Mixed_Address_Usage := le.Bill_To_Out.advo_addr_hist1.Mixed_Address_Usage;
	
	self.bto.Address_Verification.Address_History_1.occupants_1yr := le.Bill_To_Out.addr_risk_summary2.occupants_1yr ;
	self.bto.Address_Verification.Address_History_1.turnover_1yr_in := le.Bill_To_Out.addr_risk_summary2.turnover_1yr_in ;
	self.bto.Address_Verification.Address_History_1.turnover_1yr_out := le.Bill_To_Out.addr_risk_summary2.turnover_1yr_out ;
	self.bto.Address_Verification.Address_History_1.N_Vacant_Properties := le.Bill_To_Out.addr_risk_summary2.N_Vacant_Properties;
	self.bto.Address_Verification.Address_History_1.N_Business_Count := le.Bill_To_Out.addr_risk_summary2.N_Business_Count ;
	self.bto.Address_Verification.Address_History_1.N_SFD_Count := le.Bill_To_Out.addr_risk_summary2.N_SFD_Count ;
	self.bto.Address_Verification.Address_History_1.N_MFD_Count := le.Bill_To_Out.addr_risk_summary2.N_MFD_Count;
	self.bto.Address_Verification.Address_History_1.N_ave_building_age := le.Bill_To_Out.addr_risk_summary2.N_ave_building_age;
	self.bto.Address_Verification.Address_History_1.N_ave_purchase_amount := le.Bill_To_Out.addr_risk_summary2.N_ave_purchase_amount ;
	self.bto.Address_Verification.Address_History_1.N_ave_mortgage_amount := le.Bill_To_Out.addr_risk_summary2.N_ave_mortgage_amount ;
	self.bto.Address_Verification.Address_History_1.N_ave_assessed_amount := le.Bill_To_Out.addr_risk_summary2.N_ave_assessed_amount ;
	self.bto.Address_Verification.Address_History_1.N_ave_building_area := le.Bill_To_Out.addr_risk_summary2.N_ave_building_area ;
	self.bto.Address_Verification.Address_History_1.N_ave_price_per_sf := le.Bill_To_Out.addr_risk_summary2.N_ave_price_per_sf ;
	self.bto.Address_Verification.Address_History_1.N_ave_no_of_stories_count := le.Bill_To_Out.addr_risk_summary2.N_ave_no_of_stories_count ;
	self.bto.Address_Verification.Address_History_1.N_ave_no_of_rooms_count := le.Bill_To_Out.addr_risk_summary2.N_ave_no_of_rooms_count ;
	self.bto.Address_Verification.Address_History_1.N_ave_no_of_bedrooms_count := le.Bill_To_Out.addr_risk_summary2.N_ave_no_of_bedrooms_count ;
	self.bto.Address_Verification.Address_History_1.N_ave_no_of_baths_count := le.Bill_To_Out.addr_risk_summary2.N_ave_no_of_baths_count ;	
	
	
	
	self.bto.errorCode := le.errorCode;
	
	self.bto.student.file_type := le.bill_to_out.student.file_type2;
	
	self.bto.fd_scores.fraudpointV4 := le.Bill_To_Out.FD_Scores.fraudpointV2;
	self.bto.fd_scores.reason1FPV4  := le.Bill_To_Out.FD_Scores.reason1FPV2;
	self.bto.fd_scores.reason2FPV4  := le.Bill_To_Out.FD_Scores.reason2FPV2;
	self.bto.fd_scores.reason3FPV4  := le.Bill_To_Out.FD_Scores.reason3FPV2;
	self.bto.fd_scores.reason4FPV4  := le.Bill_To_Out.FD_Scores.reason4FPV2;
	self.bto.fd_scores.reason5FPV4  := le.Bill_To_Out.FD_Scores.reason5FPV2;
	self.bto.fd_scores.reason6FPV4  := le.Bill_To_Out.FD_Scores.reason6FPV2;	
	
	self.bto := le.Bill_To_Out;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// Shipto Output
	self.sto.accountnumber := le.accountnumber;
	self.sto.address_verification.input_address_information.lres := le.Ship_To_Out.lres;
	self.sto.address_verification.address_history_1.lres := le.Ship_To_Out.lres2;
	self.sto.address_verification.address_history_2.lres := le.Ship_To_Out.lres3;
	self.sto.address_verification.input_address_information.addrPop := le.Ship_To_Out.addrPop;
	self.sto.address_verification.address_history_1.addrPop := le.Ship_To_Out.addrPop2;
	self.sto.address_verification.address_history_2.addrPop := le.Ship_To_Out.addrPop3;
	self.sto.address_verification.input_address_information.avm_land_use_code := le.Ship_To_Out.avm.input_address_information.avm_land_use_code;
	self.sto.address_verification.input_address_information.avm_recording_date := le.Ship_To_Out.avm.input_address_information.avm_recording_date;
	self.sto.address_verification.input_address_information.avm_assessed_value_year := le.Ship_To_Out.avm.input_address_information.avm_assessed_value_year;
	self.sto.address_verification.input_address_information.avm_sales_price := le.Ship_To_Out.avm.input_address_information.avm_sales_price;  
	self.sto.address_verification.input_address_information.avm_assessed_total_value := le.Ship_To_Out.avm.input_address_information.avm_assessed_total_value;
	self.sto.address_verification.input_address_information.avm_market_total_value := le.Ship_To_Out.avm.input_address_information.avm_market_total_value;
	self.sto.address_verification.input_address_information.avm_tax_assessment_valuation := le.Ship_To_Out.avm.input_address_information.avm_tax_assessment_valuation;
	self.sto.address_verification.input_address_information.avm_price_index_valuation := le.Ship_To_Out.avm.input_address_information.avm_price_index_valuation;
	self.sto.address_verification.input_address_information.avm_hedonic_valuation := le.Ship_To_Out.avm.input_address_information.avm_hedonic_valuation;
	self.sto.address_verification.input_address_information.avm_automated_valuation := le.Ship_To_Out.avm.input_address_information.avm_automated_valuation;
	self.sto.address_verification.input_address_information.avm_confidence_score := le.Ship_To_Out.avm.input_address_information.avm_confidence_score;
	self.sto.address_verification.input_address_information.avm_median_fips_level := le.Ship_To_Out.avm.input_address_information.avm_median_fips_level;
	self.sto.address_verification.input_address_information.avm_median_geo11_level := le.Ship_To_Out.avm.input_address_information.avm_median_geo11_level;
	self.sto.address_verification.input_address_information.avm_median_geo12_level := le.Ship_To_Out.avm.input_address_information.avm_median_geo12_level;
	
	self.sto.address_verification.address_history_1.avm_land_use_code := le.Ship_To_Out.avm.address_history_1.avm_land_use_code;
	self.sto.address_verification.address_history_1.avm_recording_date := le.Ship_To_Out.avm.address_history_1.avm_recording_date;
	self.sto.address_verification.address_history_1.avm_assessed_value_year := le.Ship_To_Out.avm.address_history_1.avm_assessed_value_year;
	self.sto.address_verification.address_history_1.avm_sales_price := le.Ship_To_Out.avm.address_history_1.avm_sales_price;  
	self.sto.address_verification.address_history_1.avm_assessed_total_value := le.Ship_To_Out.avm.address_history_1.avm_assessed_total_value;
	self.sto.address_verification.address_history_1.avm_market_total_value := le.Ship_To_Out.avm.address_history_1.avm_market_total_value;
	self.sto.address_verification.address_history_1.avm_tax_assessment_valuation := le.Ship_To_Out.avm.address_history_1.avm_tax_assessment_valuation;
	self.sto.address_verification.address_history_1.avm_price_index_valuation := le.Ship_To_Out.avm.address_history_1.avm_price_index_valuation;
	self.sto.address_verification.address_history_1.avm_hedonic_valuation := le.Ship_To_Out.avm.address_history_1.avm_hedonic_valuation;
	self.sto.address_verification.address_history_1.avm_automated_valuation := le.Ship_To_Out.avm.address_history_1.avm_automated_valuation;
	self.sto.address_verification.address_history_1.avm_confidence_score := le.Ship_To_Out.avm.address_history_1.avm_confidence_score;
	self.sto.address_verification.address_history_1.avm_median_fips_level := le.Ship_To_Out.avm.address_history_1.avm_median_fips_level;
	self.sto.address_verification.address_history_1.avm_median_geo11_level := le.Ship_To_Out.avm.address_history_1.avm_median_geo11_level;
	self.sto.address_verification.address_history_1.avm_median_geo12_level := le.Ship_To_Out.avm.address_history_1.avm_median_geo12_level;
	
	self.sto.Velocity_Counters.adlPerSSN_count := le.Ship_To_Out.SSN_Verification.adlPerSSN_count;
	
	self.sto.iid.socllowissue := (unsigned)le.Ship_To_Out.iid.socllowissue;
	self.sto.iid.soclhighissue := (unsigned)le.Ship_To_Out.iid.soclhighissue;
	self.sto.iid.areacodesplitdate := (unsigned)le.Ship_To_Out.iid.areacodesplitdate;
	self.sto.student.date_first_seen := (unsigned)le.Ship_To_Out.student.date_first_seen;
	self.sto.student.date_last_seen := (unsigned)le.Ship_To_Out.student.date_last_seen;
	self.sto.student.dob_formatted := (unsigned)le.Ship_To_Out.student.dob_formatted;
	
	// new shell 2.5 fields
	self.sto.isFCRA := '0';
	self.sto.rv_scores := [];	// riskview not populated in non-fcra
	////////////
	
		//// new shell 3.0 fields
	self.sto.cb_allowed := map(	dataRestrictionMask[6]<>'1' and dataRestrictionMask[8]<>'1' and dataRestrictionMask[10]<>'1' => 'ALL',
								dataRestrictionMask[8]<>'1' => 'EQ',
								dataRestrictionMask[6]<>'1' => 'EN',
								dataRestrictionMask[10]<>'1' => 'TN',
								'NONE');		// this should not happen
							
	self.sto.iid.ConsumerFlags := le.Ship_To_Out.ConsumerFlags;
	
	self.sto.ssn_verification.inputsocscharflag := le.Ship_To_Out.ssn_verification.validation.inputsocscharflag;
	
	self.sto.Address_Verification.Address_History_1.addr_type := le.Ship_To_Out.Address_Verification.addr_type2;
	self.sto.Address_Verification.Address_History_2.addr_type := le.Ship_To_Out.Address_Verification.addr_type3;

	self.sto.input_dob_age := le.Ship_To_Out.shell_input.age;
	
	self.sto.Address_Verification.Input_Address_Information.building_area := (string)le.Ship_To_Out.address_verification.input_address_information.building_area ;
	self.sto.Address_Verification.Input_Address_Information.no_of_buildings := (string)le.Ship_To_Out.address_verification.input_address_information.no_of_buildings ;
	self.sto.Address_Verification.Input_Address_Information.no_of_stories := (string)le.Ship_To_Out.address_verification.input_address_information.no_of_stories ;
	self.sto.Address_Verification.Input_Address_Information.no_of_rooms := (string)le.Ship_To_Out.address_verification.input_address_information.no_of_rooms ;
	self.sto.Address_Verification.Input_Address_Information.no_of_bedrooms := (string)le.Ship_To_Out.address_verification.input_address_information.no_of_bedrooms ;
	self.sto.Address_Verification.Input_Address_Information.no_of_baths := (string)le.Ship_To_Out.address_verification.input_address_information.no_of_baths;
	self.sto.Address_Verification.Input_Address_Information.no_of_partial_baths := (string)le.Ship_To_Out.address_verification.input_address_information.no_of_partial_baths ;
	self.sto.Address_Verification.Input_Address_Information.parking_no_of_cars := (string)le.Ship_To_Out.address_verification.input_address_information.parking_no_of_cars;
	self.sto.Address_Verification.Input_Address_Information.avm_automated_valuation2 := le.Ship_To_Out.avm.input_address_information.avm_automated_valuation2;
	self.sto.Address_Verification.Input_Address_Information.avm_automated_valuation3 := le.Ship_To_Out.avm.input_address_information.avm_automated_valuation3;
	self.sto.Address_Verification.Input_Address_Information.avm_automated_valuation4 := le.Ship_To_Out.avm.input_address_information.avm_automated_valuation4;
	self.sto.Address_Verification.Input_Address_Information.avm_automated_valuation5 := le.Ship_To_Out.avm.input_address_information.avm_automated_valuation5;
	self.sto.Address_Verification.Input_Address_Information.avm_automated_valuation6 := le.Ship_To_Out.avm.input_address_information.avm_automated_valuation6;
	
	self.sto.address_verification.address_history_1.building_area := (string)le.Ship_To_Out.address_verification.address_history_1.building_area ;
	self.sto.address_verification.address_history_1.no_of_buildings := (string)le.Ship_To_Out.address_verification.address_history_1.no_of_buildings ;
	self.sto.address_verification.address_history_1.no_of_stories := (string)le.Ship_To_Out.address_verification.address_history_1.no_of_stories ;
	self.sto.address_verification.address_history_1.no_of_rooms := (string)le.Ship_To_Out.address_verification.address_history_1.no_of_rooms ;
	self.sto.address_verification.address_history_1.no_of_bedrooms := (string)le.Ship_To_Out.address_verification.address_history_1.no_of_bedrooms ;
	self.sto.address_verification.address_history_1.no_of_baths := (string)le.Ship_To_Out.address_verification.address_history_1.no_of_baths;
	self.sto.address_verification.address_history_1.no_of_partial_baths := (string)le.Ship_To_Out.address_verification.address_history_1.no_of_partial_baths ;
	self.sto.address_verification.address_history_1.parking_no_of_cars := (string)le.Ship_To_Out.address_verification.address_history_1.parking_no_of_cars;
	self.sto.Address_Verification.Address_History_1.avm_automated_valuation2 := le.Ship_To_Out.avm.address_history_1.avm_automated_valuation2;
	self.sto.Address_Verification.Address_History_1.avm_automated_valuation3 := le.Ship_To_Out.avm.address_history_1.avm_automated_valuation3;
	self.sto.Address_Verification.Address_History_1.avm_automated_valuation4 := le.Ship_To_Out.avm.address_history_1.avm_automated_valuation4;
	self.sto.Address_Verification.Address_History_1.avm_automated_valuation5 := le.Ship_To_Out.avm.address_history_1.avm_automated_valuation5;
	self.sto.Address_Verification.Address_History_1.avm_automated_valuation6 := le.Ship_To_Out.avm.address_history_1.avm_automated_valuation6;
	
	self.sto.bjl.liens := le.Ship_To_Out.liens;
	
	// attribute fields added
	self.sto.attributes.addrs_last30 := le.Ship_To_Out.other_address_info.addrs_last30;
	self.sto.attributes.addrs_last90 := le.Ship_To_Out.other_address_info.addrs_last90;
	self.sto.attributes.addrs_last12 := le.Ship_To_Out.other_address_info.addrs_last12;
	self.sto.attributes.addrs_last24 := le.Ship_To_Out.other_address_info.addrs_last24;
	self.sto.attributes.addrs_last36 := le.Ship_To_Out.other_address_info.addrs_last36;
	self.sto.attributes.date_first_purchase := le.Ship_To_Out.other_address_info.date_first_purchase;	
	self.sto.attributes.date_most_recent_purchase := le.Ship_To_Out.other_address_info.date_most_recent_purchase;	
	self.sto.attributes.date_most_recent_sale := le.Ship_To_Out.other_address_info.date_most_recent_sale;	
	self.sto.attributes.num_purchase30 := le.Ship_To_Out.other_address_info.num_purchase30;
	self.sto.attributes.num_purchase90 := le.Ship_To_Out.other_address_info.num_purchase90;
	self.sto.attributes.num_purchase180 := le.Ship_To_Out.other_address_info.num_purchase180;
	self.sto.attributes.num_purchase12 := le.Ship_To_Out.other_address_info.num_purchase12;
	self.sto.attributes.num_purchase24 := le.Ship_To_Out.other_address_info.num_purchase24;
	self.sto.attributes.num_purchase36 := le.Ship_To_Out.other_address_info.num_purchase36;
	self.sto.attributes.num_purchase60 := le.Ship_To_Out.other_address_info.num_purchase60;
	self.sto.attributes.num_sold30 := le.Ship_To_Out.other_address_info.num_sold30;
	self.sto.attributes.num_sold90 := le.Ship_To_Out.other_address_info.num_sold90;
	self.sto.attributes.num_sold180 := le.Ship_To_Out.other_address_info.num_sold180;
	self.sto.attributes.num_sold12 := le.Ship_To_Out.other_address_info.num_sold12;
	self.sto.attributes.num_sold24 := le.Ship_To_Out.other_address_info.num_sold24;
	self.sto.attributes.num_sold36 := le.Ship_To_Out.other_address_info.num_sold36;
	self.sto.attributes.num_sold60 := le.Ship_To_Out.other_address_info.num_sold60;
	self.sto.attributes.num_watercraft30 := le.Ship_To_Out.watercraft.watercraft_count30;
	self.sto.attributes.num_watercraft90 := le.Ship_To_Out.watercraft.watercraft_count90;
	self.sto.attributes.num_watercraft180 := le.Ship_To_Out.watercraft.watercraft_count180;
	self.sto.attributes.num_watercraft12 := le.Ship_To_Out.watercraft.watercraft_count12;
	self.sto.attributes.num_watercraft24 := le.Ship_To_Out.watercraft.watercraft_count24;
	self.sto.attributes.num_watercraft36 := le.Ship_To_Out.watercraft.watercraft_count36;
	self.sto.attributes.num_watercraft60 := le.Ship_To_Out.watercraft.watercraft_count60;
	self.sto.attributes.num_aircraft := le.Ship_To_Out.aircraft.aircraft_count;
	self.sto.attributes.num_aircraft30 := le.Ship_To_Out.aircraft.aircraft_count30;
	self.sto.attributes.num_aircraft90 := le.Ship_To_Out.aircraft.aircraft_count90;
	self.sto.attributes.num_aircraft180 := le.Ship_To_Out.aircraft.aircraft_count180;
	self.sto.attributes.num_aircraft12 := le.Ship_To_Out.aircraft.aircraft_count12;
	self.sto.attributes.num_aircraft24 := le.Ship_To_Out.aircraft.aircraft_count24;
	self.sto.attributes.num_aircraft36 := le.Ship_To_Out.aircraft.aircraft_count36;
	self.sto.attributes.num_aircraft60 := le.Ship_To_Out.aircraft.aircraft_count60;
	self.sto.attributes.total_number_derogs := le.Ship_To_Out.total_number_derogs;
	self.sto.attributes.date_last_derog := le.Ship_To_Out.date_last_derog;
	self.sto.attributes.felonies30 := le.Ship_To_Out.bjl.criminal_count30;
	self.sto.attributes.felonies90 := le.Ship_To_Out.bjl.criminal_count90;
	self.sto.attributes.felonies180 := le.Ship_To_Out.bjl.criminal_count180;
	self.sto.attributes.felonies12 := le.Ship_To_Out.bjl.criminal_count12;
	self.sto.attributes.felonies24 := le.Ship_To_Out.bjl.criminal_count24;
	self.sto.attributes.felonies36 := le.Ship_To_Out.bjl.criminal_count36;
	self.sto.attributes.felonies60 := le.Ship_To_Out.bjl.criminal_count60;
	self.sto.attributes.arrests := le.Ship_To_Out.bjl.arrests_count;
	self.sto.attributes.date_last_arrest := le.Ship_To_Out.bjl.date_last_arrest;	
	self.sto.attributes.arrests30 := le.Ship_To_Out.bjl.arrests_count30;
	self.sto.attributes.arrests90 := le.Ship_To_Out.bjl.arrests_count90;
	self.sto.attributes.arrests180 := le.Ship_To_Out.bjl.arrests_count180;
	self.sto.attributes.arrests12 := le.Ship_To_Out.bjl.arrests_count12;
	self.sto.attributes.arrests24 := le.Ship_To_Out.bjl.arrests_count24;
	self.sto.attributes.arrests36 := le.Ship_To_Out.bjl.arrests_count36;
	self.sto.attributes.arrests60 := le.Ship_To_Out.bjl.arrests_count60;
	self.sto.attributes.num_unreleased_liens30 := le.Ship_To_Out.bjl.liens_unreleased_count30;
	self.sto.attributes.num_unreleased_liens90 := le.Ship_To_Out.bjl.liens_unreleased_count90;
	self.sto.attributes.num_unreleased_liens180 := le.Ship_To_Out.bjl.liens_unreleased_count180;
	self.sto.attributes.num_unreleased_liens12 := le.Ship_To_Out.bjl.liens_unreleased_count12;
	self.sto.attributes.num_unreleased_liens24 := le.Ship_To_Out.bjl.liens_unreleased_count24;
	self.sto.attributes.num_unreleased_liens36 := le.Ship_To_Out.bjl.liens_unreleased_count36;
	self.sto.attributes.num_unreleased_liens60 := le.Ship_To_Out.bjl.liens_unreleased_count60;
	self.sto.attributes.num_released_liens30 := le.Ship_To_Out.bjl.liens_released_count30;
	self.sto.attributes.num_released_liens90 := le.Ship_To_Out.bjl.liens_released_count90;
	self.sto.attributes.num_released_liens180 := le.Ship_To_Out.bjl.liens_released_count180;
	self.sto.attributes.num_released_liens12 := le.Ship_To_Out.bjl.liens_released_count12;
	self.sto.attributes.num_released_liens24 := le.Ship_To_Out.bjl.liens_released_count24;
	self.sto.attributes.num_released_liens36 := le.Ship_To_Out.bjl.liens_released_count36;
	self.sto.attributes.num_released_liens60 := le.Ship_To_Out.bjl.liens_released_count60;
	self.sto.attributes.bankruptcy_count30 := le.Ship_To_Out.bjl.bk_count30;
	self.sto.attributes.bankruptcy_count90 := le.Ship_To_Out.bjl.bk_count90;
	self.sto.attributes.bankruptcy_count180 := le.Ship_To_Out.bjl.bk_count180;
	self.sto.attributes.bankruptcy_count12 := le.Ship_To_Out.bjl.bk_count12;
	self.sto.attributes.bankruptcy_count24 := le.Ship_To_Out.bjl.bk_count24;
	self.sto.attributes.bankruptcy_count36 := le.Ship_To_Out.bjl.bk_count36;
	self.sto.attributes.bankruptcy_count60 := le.Ship_To_Out.bjl.bk_count60;
	self.sto.attributes.eviction_count := le.Ship_To_Out.bjl.eviction_count;
	self.sto.attributes.date_last_eviction := le.Ship_To_Out.bjl.last_eviction_date;
	self.sto.attributes.eviction_count30 := le.Ship_To_Out.bjl.eviction_count30;
	self.sto.attributes.eviction_count90 := le.Ship_To_Out.bjl.eviction_count90;
	self.sto.attributes.eviction_count180 := le.Ship_To_Out.bjl.eviction_count180;
	self.sto.attributes.eviction_count12 := le.Ship_To_Out.bjl.eviction_count12;
	self.sto.attributes.eviction_count24 := le.Ship_To_Out.bjl.eviction_count24;
	self.sto.attributes.eviction_count36 := le.Ship_To_Out.bjl.eviction_count36;
	self.sto.attributes.eviction_count60 := le.Ship_To_Out.bjl.eviction_count60;
	self.sto.attributes.num_nonderogs := le.Ship_To_Out.source_verification.num_nonderogs;
	self.sto.attributes.num_nonderogs30 := le.Ship_To_Out.source_verification.num_nonderogs30;
	self.sto.attributes.num_nonderogs90 := le.Ship_To_Out.source_verification.num_nonderogs90;
	self.sto.attributes.num_nonderogs180 := le.Ship_To_Out.source_verification.num_nonderogs180;
	self.sto.attributes.num_nonderogs12 := le.Ship_To_Out.source_verification.num_nonderogs12;
	self.sto.attributes.num_nonderogs24 := le.Ship_To_Out.source_verification.num_nonderogs24;
	self.sto.attributes.num_nonderogs36 := le.Ship_To_Out.source_verification.num_nonderogs36;
	self.sto.attributes.num_nonderogs60 := le.Ship_To_Out.source_verification.num_nonderogs60;
	self.sto.attributes.num_proflic30 := le.Ship_To_Out.professional_license.proflic_count30;
	self.sto.attributes.num_proflic90 := le.Ship_To_Out.professional_license.proflic_count90;
	self.sto.attributes.num_proflic180 := le.Ship_To_Out.professional_license.proflic_count180;
	self.sto.attributes.num_proflic12 := le.Ship_To_Out.professional_license.proflic_count12;
	self.sto.attributes.num_proflic24 := le.Ship_To_Out.professional_license.proflic_count24;
	self.sto.attributes.num_proflic36 := le.Ship_To_Out.professional_license.proflic_count36;
	self.sto.attributes.num_proflic60 := le.Ship_To_Out.professional_license.proflic_count60;
	self.sto.attributes.num_proflic_exp30 := le.Ship_To_Out.professional_license.expire_count30;
	self.sto.attributes.num_proflic_exp90 := le.Ship_To_Out.professional_license.expire_count90;
	self.sto.attributes.num_proflic_exp180 := le.Ship_To_Out.professional_license.expire_count180;
	self.sto.attributes.num_proflic_exp12 := le.Ship_To_Out.professional_license.expire_count12;
	self.sto.attributes.num_proflic_exp24 := le.Ship_To_Out.professional_license.expire_count24;
	self.sto.attributes.num_proflic_exp36 := le.Ship_To_Out.professional_license.expire_count36;
	self.sto.attributes.num_proflic_exp60 := le.Ship_To_Out.professional_license.expire_count60;
	
	self.sto.infutor := le.Ship_To_Out.infutor_phone;	// puts the infutor phone results into the infutor spot to match previous output
	self.sto.iid.correctlast := if(le.Ship_To_Out.iid.correctlast<>'', '1','0');	// brent doesn't want to see lastnames, so populate with a 1 or 0
	
	
		// new mappings for shell 4.0
	self.sto.student.college_major := le.Ship_To_Out.student.college_major;  // won't need this when college major put into the student section correctly
	self.sto.velocity_counters.lnames_per_adl_created_6months := le.Ship_To_Out.velocity_counters.lnames_per_adl180;
	self.sto.address_verification.address_history_2.avm_automated_valuation := le.Ship_To_Out.avm.address_history_2.avm_automated_valuation;

	self.sto.address_verification.input_address_information.market_total_value := le.Ship_To_Out.address_verification.input_address_information.assessed_amount;
	self.sto.address_verification.address_history_1.market_total_value := le.Ship_To_Out.address_verification.address_history_1.assessed_amount;
	self.sto.address_verification.address_history_2.market_total_value := le.Ship_To_Out.address_verification.address_history_2.assessed_amount;
	
	self.sto.Other_Address_Info.unique_addr_cnt := le.Ship_To_Out.address_history_summary.unique_addr_cnt;
	self.sto.Other_Address_Info.avg_mo_per_addr := le.Ship_To_Out.address_history_summary.avg_mo_per_addr;
	self.sto.Other_Address_Info.addr_count2 := le.Ship_To_Out.address_history_summary.addr_count2;
	self.sto.Other_Address_Info.addr_count3 := le.Ship_To_Out.address_history_summary.addr_count3;
	self.sto.Other_Address_Info.addr_count6 := le.Ship_To_Out.address_history_summary.addr_count6;
	self.sto.Other_Address_Info.addr_count10 := le.Ship_To_Out.address_history_summary.addr_count10;
	self.sto.Other_Address_Info.lres_2mo_count := le.Ship_To_Out.address_history_summary.lres_2mo_count;
	self.sto.Other_Address_Info.lres_6mo_count := le.Ship_To_Out.address_history_summary.lres_6mo_count ;
	self.sto.Other_Address_Info.lres_12mo_count := le.Ship_To_Out.address_history_summary.lres_12mo_count;
	self.sto.Other_Address_Info.hist_addr_match := le.Ship_To_Out.address_history_summary.hist_addr_match;	
	self.sto.Other_Address_Info.address_history_advo_college_hit := le.Ship_To_Out.address_history_summary.address_history_advo_college_hit;
	
	self.sto.Address_Verification.Input_Address_Information.Address_Vacancy_Indicator	:= le.Ship_To_Out.advo_input_addr.Address_Vacancy_Indicator	;
	self.sto.Address_Verification.Input_Address_Information.Throw_Back_Indicator := le.Ship_To_Out.advo_input_addr.Throw_Back_Indicator	;
	self.sto.Address_Verification.Input_Address_Information.Seasonal_Delivery_Indicator := le.Ship_To_Out.advo_input_addr.Seasonal_Delivery_Indicator;
	self.sto.Address_Verification.Input_Address_Information.DND_Indicator := le.Ship_To_Out.advo_input_addr.DND_Indicator	;
	self.sto.Address_Verification.Input_Address_Information.College_Indicator := le.Ship_To_Out.advo_input_addr.College_Indicator;
	self.sto.Address_Verification.Input_Address_Information.Drop_Indicator	:= le.Ship_To_Out.advo_input_addr.Drop_Indicator;
	self.sto.Address_Verification.Input_Address_Information.Residential_or_Business_Ind	:= le.Ship_To_Out.advo_input_addr.Residential_or_Business_Ind	;
	self.sto.Address_Verification.Input_Address_Information.Mixed_Address_Usage := le.Ship_To_Out.advo_input_addr.Mixed_Address_Usage;
	
	self.sto.Address_Verification.Input_Address_Information.occupants_1yr := le.Ship_To_Out.addr_risk_summary.occupants_1yr ;
	self.sto.Address_Verification.Input_Address_Information.turnover_1yr_in := le.Ship_To_Out.addr_risk_summary.turnover_1yr_in ;
	self.sto.Address_Verification.Input_Address_Information.turnover_1yr_out := le.Ship_To_Out.addr_risk_summary.turnover_1yr_out ;
	self.sto.Address_Verification.Input_Address_Information.N_Vacant_Properties := le.Ship_To_Out.addr_risk_summary.N_Vacant_Properties;
	self.sto.Address_Verification.Input_Address_Information.N_Business_Count := le.Ship_To_Out.addr_risk_summary.N_Business_Count ;
	self.sto.Address_Verification.Input_Address_Information.N_SFD_Count := le.Ship_To_Out.addr_risk_summary.N_SFD_Count ;
	self.sto.Address_Verification.Input_Address_Information.N_MFD_Count := le.Ship_To_Out.addr_risk_summary.N_MFD_Count;
	self.sto.Address_Verification.Input_Address_Information.N_ave_building_age := le.Ship_To_Out.addr_risk_summary.N_ave_building_age;
	self.sto.Address_Verification.Input_Address_Information.N_ave_purchase_amount := le.Ship_To_Out.addr_risk_summary.N_ave_purchase_amount ;
	self.sto.Address_Verification.Input_Address_Information.N_ave_mortgage_amount := le.Ship_To_Out.addr_risk_summary.N_ave_mortgage_amount ;
	self.sto.Address_Verification.Input_Address_Information.N_ave_assessed_amount := le.Ship_To_Out.addr_risk_summary.N_ave_assessed_amount ;
	self.sto.Address_Verification.Input_Address_Information.N_ave_building_area := le.Ship_To_Out.addr_risk_summary.N_ave_building_area ;
	self.sto.Address_Verification.Input_Address_Information.N_ave_price_per_sf := le.Ship_To_Out.addr_risk_summary.N_ave_price_per_sf ;
	self.sto.Address_Verification.Input_Address_Information.N_ave_no_of_stories_count := le.Ship_To_Out.addr_risk_summary.N_ave_no_of_stories_count ;
	self.sto.Address_Verification.Input_Address_Information.N_ave_no_of_rooms_count := le.Ship_To_Out.addr_risk_summary.N_ave_no_of_rooms_count ;
	self.sto.Address_Verification.Input_Address_Information.N_ave_no_of_bedrooms_count := le.Ship_To_Out.addr_risk_summary.N_ave_no_of_bedrooms_count ;
	self.sto.Address_Verification.Input_Address_Information.N_ave_no_of_baths_count := le.Ship_To_Out.addr_risk_summary.N_ave_no_of_baths_count ;	

	self.sto.Address_Verification.Address_History_1.Address_Vacancy_Indicator	:= le.Ship_To_Out.advo_addr_hist1.Address_Vacancy_Indicator	;
	self.sto.Address_Verification.Address_History_1.Throw_Back_Indicator := le.Ship_To_Out.advo_addr_hist1.Throw_Back_Indicator	;
	self.sto.Address_Verification.Address_History_1.Seasonal_Delivery_Indicator := le.Ship_To_Out.advo_addr_hist1.Seasonal_Delivery_Indicator;
	self.sto.Address_Verification.Address_History_1.DND_Indicator := le.Ship_To_Out.advo_addr_hist1.DND_Indicator	;
	self.sto.Address_Verification.Address_History_1.College_Indicator := le.Ship_To_Out.advo_addr_hist1.College_Indicator;
	self.sto.Address_Verification.Address_History_1.Drop_Indicator	:= le.Ship_To_Out.advo_addr_hist1.Drop_Indicator;
	self.sto.Address_Verification.Address_History_1.Residential_or_Business_Ind	:= le.Ship_To_Out.advo_addr_hist1.Residential_or_Business_Ind	;
	self.sto.Address_Verification.Address_History_1.Mixed_Address_Usage := le.Ship_To_Out.advo_addr_hist1.Mixed_Address_Usage;
	
	self.sto.Address_Verification.Address_History_1.occupants_1yr := le.Ship_To_Out.addr_risk_summary2.occupants_1yr ;
	self.sto.Address_Verification.Address_History_1.turnover_1yr_in := le.Ship_To_Out.addr_risk_summary2.turnover_1yr_in ;
	self.sto.Address_Verification.Address_History_1.turnover_1yr_out := le.Ship_To_Out.addr_risk_summary2.turnover_1yr_out ;
	self.sto.Address_Verification.Address_History_1.N_Vacant_Properties := le.Ship_To_Out.addr_risk_summary2.N_Vacant_Properties;
	self.sto.Address_Verification.Address_History_1.N_Business_Count := le.Ship_To_Out.addr_risk_summary2.N_Business_Count ;
	self.sto.Address_Verification.Address_History_1.N_SFD_Count := le.Ship_To_Out.addr_risk_summary2.N_SFD_Count ;
	self.sto.Address_Verification.Address_History_1.N_MFD_Count := le.Ship_To_Out.addr_risk_summary2.N_MFD_Count;
	self.sto.Address_Verification.Address_History_1.N_ave_building_age := le.Ship_To_Out.addr_risk_summary2.N_ave_building_age;
	self.sto.Address_Verification.Address_History_1.N_ave_purchase_amount := le.Ship_To_Out.addr_risk_summary2.N_ave_purchase_amount ;
	self.sto.Address_Verification.Address_History_1.N_ave_mortgage_amount := le.Ship_To_Out.addr_risk_summary2.N_ave_mortgage_amount ;
	self.sto.Address_Verification.Address_History_1.N_ave_assessed_amount := le.Ship_To_Out.addr_risk_summary2.N_ave_assessed_amount ;
	self.sto.Address_Verification.Address_History_1.N_ave_building_area := le.Ship_To_Out.addr_risk_summary2.N_ave_building_area ;
	self.sto.Address_Verification.Address_History_1.N_ave_price_per_sf := le.Ship_To_Out.addr_risk_summary2.N_ave_price_per_sf ;
	self.sto.Address_Verification.Address_History_1.N_ave_no_of_stories_count := le.Ship_To_Out.addr_risk_summary2.N_ave_no_of_stories_count ;
	self.sto.Address_Verification.Address_History_1.N_ave_no_of_rooms_count := le.Ship_To_Out.addr_risk_summary2.N_ave_no_of_rooms_count ;
	self.sto.Address_Verification.Address_History_1.N_ave_no_of_bedrooms_count := le.Ship_To_Out.addr_risk_summary2.N_ave_no_of_bedrooms_count ;
	self.sto.Address_Verification.Address_History_1.N_ave_no_of_baths_count := le.Ship_To_Out.addr_risk_summary2.N_ave_no_of_baths_count ;	

	self.sto.errorCode := le.errorCode;
	
	self.sto.student.file_type := le.ship_to_out.student.file_type2;
		
	self.sto.fd_scores.fraudpointV4 := le.Ship_To_Out.FD_Scores.fraudpointV2;
	self.sto.fd_scores.reason1FPV4  := le.Ship_To_Out.FD_Scores.reason1FPV2;
	self.sto.fd_scores.reason2FPV4  := le.Ship_To_Out.FD_Scores.reason2FPV2;
	self.sto.fd_scores.reason3FPV4  := le.Ship_To_Out.FD_Scores.reason3FPV2;
	self.sto.fd_scores.reason4FPV4  := le.Ship_To_Out.FD_Scores.reason4FPV2;
	self.sto.fd_scores.reason5FPV4  := le.Ship_To_Out.FD_Scores.reason5FPV2;
	self.sto.fd_scores.reason6FPV4  := le.Ship_To_Out.FD_Scores.reason6FPV2;		
	
	self.sto := le.Ship_To_Out;
	self := le;
end;
edina := project(f, convertToEdina_v4(left));
output(edina, named('edina'));
output(edina,, outfile_name+'_edina_v4',CSV(QUOTE('"'),maxlength(8192)),overwrite);