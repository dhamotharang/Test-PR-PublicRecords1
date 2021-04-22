unsigned record_limit :=  3;     //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls := 1;  //number of parallel soap calls to make [1..30]

//===================  input-output files  ======================
infile_name  := ut.foreign_prod+'tfuerstenberg::in::apple-bt_st-bocashell';
outfile_name := '~hthor::out::bocashell20_fcra_hist'+ thorlib.WUID();


//==================  input file layout  ========================
SD2I := record
      string30 accountnumber := '';
      string1 apptype := '';
      string15 firstname := '';
      string20 lastname := '';
      string30 employername := '';
      string50 streetaddress := '';
      string30 city := '';
      string2 state := '';
      string9 zip := '';
      string9 ssn := '';
      string8 dateofbirth := '';
      string10 homephone := '';
      string10 workphone := '';
      string20 dlnumber := '';
      string2 dlstate := '';
      string50 email := '';
      string1 apptype2 := '';
      string15 firstname2 := '';
      string20 lastname2 := '';
      string30 employername2 := '';
      string50 streetaddress2 := '';
      string30 city2 := '';
      string2 state2 := '';
      string9 zip2 := '';
      string9 ssn2 := '';
      string8 dateofbirth2 := '';
      string10 homephone2 := '';
      string10 workphone2 := '';
      string20 dlnumber2 := '';
      string2 dlstate2 := '';
      string50 email2 := '';
      string6 saleamt := '';
      string8 purchdate := '';
      string6 purchtime := '';
      string11 checkaba := '';
      string9 checkacct := '';
      string7 checknum := '';
      string40 bankname := '';
      string2 pymtmethod := '';
      string1 cctype := '';
      string2 avscode := '';
      string2 inquiries := '';
      string3 trades := '';
      string6 balance := '';
      string6 bankbalance := '';
      string6 highcredit := '';
      string3 delinquent90plus := '';
      string2 revolving := '';
      string2 autotrades := '';
      string2 autotradesopen := '';
      string6 income := '';
      string6 income2 := '';
      string39 ipaddress := '';
      string16 ccnum := '';
      string8 ccexpdate := '';
      string2 taxclass := '';
      string6 historydateyyyymm := '';
end;

//====================================================
//=====================  R U N  ======================
//====================================================
// load sample data
ds_in := dataset (infile_name, SD2I, csv(quote('"'), maxlength(8192)));

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (ds_input, NAMED ('input'));



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
	dataset(risk_indicators.Layout_Gateways_In) gateways;
	string veris_gateway := '';
END;

l t_f(ds_input le, INTEGER c) := TRANSFORM
	self.old_accountnumber := le.accountnumber;
	SELF.accountnumber := (string)C;
	self.historydateyyyymm := 200707;//(unsigned)le.historydateyyyymm;
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	self.gateways := dataset([{'netacuity', 'http://rw_data_prod:Password01@wsgatewaycert.sc.seisint.com:8090/WsGateway'}], risk_indicators.Layout_Gateways_In);
	self.veris_gateway := 'http://rw_data_prod:Password01@rwgatewaycert.br.seisint.com:8090/ws_ssn';
	SELF := le;
	//SELF := [];
END;
indata := PROJECT(ds_input, t_f(LEFT,COUNTER));
output(indata, named('indata'));


roxieIP := 'http://certstagingvip.hpcc.risk.regn.net:9876'; // staging vip


temp_layout := record
	STRING AccountNumber;
	risk_indicators.layout_bocashell_btst_out;
	STRING errorcode;	
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
	string accountnumber;
	risk_indicators.Layout_Boca_Shell Bill_To_Out;
	risk_indicators.Layout_Boca_Shell Ship_To_Out;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
	string errorcode;
end;

fin := project(resu, transform(final_layout, self:=left));
final := join(indata,fin, ((unsigned)left.accountnumber)*2 = right.bill_to_out.seq, 
			transform(final_layout, self.accountnumber := left.old_accountnumber, self := right));


res_err := final(errorcode<>'');

OUTPUT (final, NAMED ('final'));
IF (EXISTS (res_err), OUTPUT (res_err, NAMED ('res_err')));

OUTPUT (final, , outfile_name, CSV(QUOTE('"'),maxlength(8192)) );
IF (EXISTS (res_err), OUTPUT (res_err, , outfile_name + '_err', CSV(QUOTE('"'),maxlength(8192))));


// --------------- the conversion portion -----------------------------------------

x := record
	string accountnumber;
	risk_indicators.Layout_Boca_Shell bto;
	risk_indicators.Layout_Boca_Shell sto;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
	string errorcode;
end;	
f := dataset(outfile_name, x, csv(quote('"'), maxlength(8192)));
output(f, named('infile'));

ox := record
	risk_indicators.Layout_Boca_Shell_Edina bto;
	risk_indicators.Layout_Boca_Shell_Edina sto;
	risk_indicators.Layout_EDDO eddo;
	riskwise.Layout_IP2O ip2o;
end;


ox convertToEdina(f le) := transform
	self.bto.accountnumber := le.accountnumber;
	self.bto.address_verification.input_address_information.lres := le.bto.lres;
	self.bto.address_verification.address_history_1.lres := le.bto.lres2;
	self.bto.address_verification.address_history_2.lres := le.bto.lres3;
	self.bto.address_verification.input_address_information.addrPop := le.bto.addrPop;
	self.bto.address_verification.address_history_1.addrPop := le.bto.addrPop2;
	self.bto.address_verification.address_history_2.addrPop := le.bto.addrPop3;
	self.bto.address_verification.input_address_information.avm_land_use_code := le.bto.avm.input_address_information.avm_land_use_code;
	self.bto.address_verification.input_address_information.avm_recording_date := le.bto.avm.input_address_information.avm_recording_date;
	self.bto.address_verification.input_address_information.avm_assessed_value_year := le.bto.avm.input_address_information.avm_assessed_value_year;
	self.bto.address_verification.input_address_information.avm_sales_price := le.bto.avm.input_address_information.avm_sales_price;  
	self.bto.address_verification.input_address_information.avm_assessed_total_value := le.bto.avm.input_address_information.avm_assessed_total_value;
	self.bto.address_verification.input_address_information.avm_market_total_value := le.bto.avm.input_address_information.avm_market_total_value;
	self.bto.address_verification.input_address_information.avm_tax_assessment_valuation := le.bto.avm.input_address_information.avm_tax_assessment_valuation;
	self.bto.address_verification.input_address_information.avm_price_index_valuation := le.bto.avm.input_address_information.avm_price_index_valuation;
	self.bto.address_verification.input_address_information.avm_hedonic_valuation := le.bto.avm.input_address_information.avm_hedonic_valuation;
	self.bto.address_verification.input_address_information.avm_automated_valuation := le.bto.avm.input_address_information.avm_automated_valuation;
	self.bto.address_verification.input_address_information.avm_confidence_score := le.bto.avm.input_address_information.avm_confidence_score;
	self.bto.address_verification.input_address_information.avm_median_fips_level := le.bto.avm.input_address_information.avm_median_fips_level;
	self.bto.address_verification.input_address_information.avm_median_geo11_level := le.bto.avm.input_address_information.avm_median_geo11_level;
	self.bto.address_verification.input_address_information.avm_median_geo12_level := le.bto.avm.input_address_information.avm_median_geo12_level;
	
	self.bto.address_verification.address_history_1.avm_land_use_code := le.bto.avm.address_history_1.avm_land_use_code;
	self.bto.address_verification.address_history_1.avm_recording_date := le.bto.avm.address_history_1.avm_recording_date;
	self.bto.address_verification.address_history_1.avm_assessed_value_year := le.bto.avm.address_history_1.avm_assessed_value_year;
	self.bto.address_verification.address_history_1.avm_sales_price := le.bto.avm.address_history_1.avm_sales_price;  
	self.bto.address_verification.address_history_1.avm_assessed_total_value := le.bto.avm.address_history_1.avm_assessed_total_value;
	self.bto.address_verification.address_history_1.avm_market_total_value := le.bto.avm.address_history_1.avm_market_total_value;
	self.bto.address_verification.address_history_1.avm_tax_assessment_valuation := le.bto.avm.address_history_1.avm_tax_assessment_valuation;
	self.bto.address_verification.address_history_1.avm_price_index_valuation := le.bto.avm.address_history_1.avm_price_index_valuation;
	self.bto.address_verification.address_history_1.avm_hedonic_valuation := le.bto.avm.address_history_1.avm_hedonic_valuation;
	self.bto.address_verification.address_history_1.avm_automated_valuation := le.bto.avm.address_history_1.avm_automated_valuation;
	self.bto.address_verification.address_history_1.avm_confidence_score := le.bto.avm.address_history_1.avm_confidence_score;
	self.bto.address_verification.address_history_1.avm_median_fips_level := le.bto.avm.address_history_1.avm_median_fips_level;
	self.bto.address_verification.address_history_1.avm_median_geo11_level := le.bto.avm.address_history_1.avm_median_geo11_level;
	self.bto.address_verification.address_history_1.avm_median_geo12_level := le.bto.avm.address_history_1.avm_median_geo12_level;
	
	self.bto.Velocity_Counters.adlPerSSN_count := le.bto.SSN_Verification.adlPerSSN_count;
	
	self.bto.iid.socllowissue := (unsigned)le.bto.iid.socllowissue;
	self.bto.iid.soclhighissue := (unsigned)le.bto.iid.soclhighissue;
	self.bto.iid.areacodesplitdate := (unsigned)le.bto.iid.areacodesplitdate;
	self.bto.student.date_first_seen := (unsigned)le.bto.student.date_first_seen;
	self.bto.student.date_last_seen := (unsigned)le.bto.student.date_last_seen;
	self.bto.student.dob_formatted := (unsigned)le.bto.student.dob_formatted;
	
	self.bto.errorCode := le.errorCode;
	
	// Shipto Output
	self.sto.accountnumber := le.accountnumber;
	self.sto.address_verification.input_address_information.lres := le.sto.lres;
	self.sto.address_verification.address_history_1.lres := le.sto.lres2;
	self.sto.address_verification.address_history_2.lres := le.sto.lres3;
	self.sto.address_verification.input_address_information.addrPop := le.sto.addrPop;
	self.sto.address_verification.address_history_1.addrPop := le.sto.addrPop2;
	self.sto.address_verification.address_history_2.addrPop := le.sto.addrPop3;
	self.sto.address_verification.input_address_information.avm_land_use_code := le.sto.avm.input_address_information.avm_land_use_code;
	self.sto.address_verification.input_address_information.avm_recording_date := le.sto.avm.input_address_information.avm_recording_date;
	self.sto.address_verification.input_address_information.avm_assessed_value_year := le.sto.avm.input_address_information.avm_assessed_value_year;
	self.sto.address_verification.input_address_information.avm_sales_price := le.sto.avm.input_address_information.avm_sales_price;  
	self.sto.address_verification.input_address_information.avm_assessed_total_value := le.sto.avm.input_address_information.avm_assessed_total_value;
	self.sto.address_verification.input_address_information.avm_market_total_value := le.sto.avm.input_address_information.avm_market_total_value;
	self.sto.address_verification.input_address_information.avm_tax_assessment_valuation := le.sto.avm.input_address_information.avm_tax_assessment_valuation;
	self.sto.address_verification.input_address_information.avm_price_index_valuation := le.sto.avm.input_address_information.avm_price_index_valuation;
	self.sto.address_verification.input_address_information.avm_hedonic_valuation := le.sto.avm.input_address_information.avm_hedonic_valuation;
	self.sto.address_verification.input_address_information.avm_automated_valuation := le.sto.avm.input_address_information.avm_automated_valuation;
	self.sto.address_verification.input_address_information.avm_confidence_score := le.sto.avm.input_address_information.avm_confidence_score;
	self.sto.address_verification.input_address_information.avm_median_fips_level := le.sto.avm.input_address_information.avm_median_fips_level;
	self.sto.address_verification.input_address_information.avm_median_geo11_level := le.sto.avm.input_address_information.avm_median_geo11_level;
	self.sto.address_verification.input_address_information.avm_median_geo12_level := le.sto.avm.input_address_information.avm_median_geo12_level;
	
	self.sto.address_verification.address_history_1.avm_land_use_code := le.sto.avm.address_history_1.avm_land_use_code;
	self.sto.address_verification.address_history_1.avm_recording_date := le.sto.avm.address_history_1.avm_recording_date;
	self.sto.address_verification.address_history_1.avm_assessed_value_year := le.sto.avm.address_history_1.avm_assessed_value_year;
	self.sto.address_verification.address_history_1.avm_sales_price := le.sto.avm.address_history_1.avm_sales_price;  
	self.sto.address_verification.address_history_1.avm_assessed_total_value := le.sto.avm.address_history_1.avm_assessed_total_value;
	self.sto.address_verification.address_history_1.avm_market_total_value := le.sto.avm.address_history_1.avm_market_total_value;
	self.sto.address_verification.address_history_1.avm_tax_assessment_valuation := le.sto.avm.address_history_1.avm_tax_assessment_valuation;
	self.sto.address_verification.address_history_1.avm_price_index_valuation := le.sto.avm.address_history_1.avm_price_index_valuation;
	self.sto.address_verification.address_history_1.avm_hedonic_valuation := le.sto.avm.address_history_1.avm_hedonic_valuation;
	self.sto.address_verification.address_history_1.avm_automated_valuation := le.sto.avm.address_history_1.avm_automated_valuation;
	self.sto.address_verification.address_history_1.avm_confidence_score := le.sto.avm.address_history_1.avm_confidence_score;
	self.sto.address_verification.address_history_1.avm_median_fips_level := le.sto.avm.address_history_1.avm_median_fips_level;
	self.sto.address_verification.address_history_1.avm_median_geo11_level := le.sto.avm.address_history_1.avm_median_geo11_level;
	self.sto.address_verification.address_history_1.avm_median_geo12_level := le.sto.avm.address_history_1.avm_median_geo12_level;
	
	self.sto.Velocity_Counters.adlPerSSN_count := le.sto.SSN_Verification.adlPerSSN_count;
	
	self.sto.iid.socllowissue := (unsigned)le.sto.iid.socllowissue;
	self.sto.iid.soclhighissue := (unsigned)le.sto.iid.soclhighissue;
	self.sto.iid.areacodesplitdate := (unsigned)le.sto.iid.areacodesplitdate;
	self.sto.student.date_first_seen := (unsigned)le.sto.student.date_first_seen;
	self.sto.student.date_last_seen := (unsigned)le.sto.student.date_last_seen;
	self.sto.student.dob_formatted := (unsigned)le.sto.student.dob_formatted;
	
	self.sto.errorCode := le.errorCode;
	
	self := le;
end;
edina := project(f, convertToEdina(left));
if(~EXISTS(res_err),output(edina, named('edina')));
if(~EXISTS(res_err),output(edina,, outfile_name+'_edina',CSV(QUOTE('"'),maxlength(8192))));