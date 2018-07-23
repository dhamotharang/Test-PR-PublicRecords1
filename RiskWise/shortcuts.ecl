/*2014-11-16T00:19:09Z (Nathan Koubsky)
Added core roxie ip
*/
import risk_indicators, Phone_Shell, Data_Services;

// placeholder for all of the roxie VIPs to use when processing files using soapcall
export shortcuts := module

 export prod_batch_analytics_roxie := 'http://10.176.71.36:9856';  // use this VIP starting week of 2018-02-12

	export prod_batch_neutral := 'http://roxiebatch.br.seisint.com:9856';
	export prod_batch_fcra := 'http://fcrabatch.sc.seisint.com:9876';

	export DR_prod_neutral_roxieIP := 'http://aroxievip.sc.seisint.com:9876';
	export DR_prod_fcra_roxieIP := 'http://afcraroxievip.sc.seisint.com:9876';

	export cert_OSS_neutral_roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876'; 
	export staging_neutral_roxieIP := 'http://roxiestaging.sc.seisint.com:9876'; 
	export staging_fcra_roxieIP :='http://certfcraroxievip.sc.seisint.com:9876'; 

	export QA_neutral_roxieIP := 'http://roxieqavip.br.seisint.com:9876'; 

  export core_roxieIP := 'http://10.176.68.187:9876/';

	export dev190 := 'http://roxiedevvip.sc.seisint.com:9876'; // stu's roxie, 190
	export Dev192 := 'http://roxiedevvip2.sc.seisint.com:9876';  // dev roxie 192
	export Dev194 := 'http://roxiedevvip3.sc.seisint.com:9876';  // dev roxie 194
	export Dev196 := 'http://roxiedataqa.sc.seisint.com:9876';  // dev roxie 196
	
	// keep these 4 around just in case there are any scripts using them
	export Dev64RoxieIP := dev190;
	export Dev64 := dev190; 
	export Dev64b := dev192;
	export Dev64c := dev194;
	
	// prod one-way roxies:
	export p1 := 'http://10.173.3.41:9876';
	export p2 := 'http://10.173.3.42:9876';
	export p3 := 'http://10.173.3.43:9876';
	export p4 := 'http://10.173.3.44:9876';
	export p5 := 'http://10.173.3.45:9876';
	
	// dataland one-way roxies:
	export d1 := 'http://10.173.3.1:9876';
	export d2 := 'http://10.173.3.2:9876';
	export d3 := 'http://10.173.3.3:9876';
	export d4 := 'http://10.173.3.4:9876';
	export d5 := 'http://10.173.3.5:9876';
	export d6 := 'http://10.173.3.6:9876';
	export d7 := 'http://10.173.3.7:9876';
	export d8 := 'http://10.173.3.8:9876';
	export d9 := 'http://10.173.3.9:9876';
	export d10 := 'http://10.173.3.10:9876';
	
		// Core one-way roxies:
	export c1 := 'http://10.173.213.1:9876';
	export c2 := 'http://10.173.213.2:9876';
	export c3 := 'http://10.173.213.3:9876';
	
	// dataland testroxie
	export dtest := 'http://10.173.85.207:9876';
	// RoxieConfig: http://10.173.3.6:9050/
	// WsECL: http://10.173.3.6:9022/


	export gw_empty     := dataset( [], risk_indicators.layout_gateways_in );
	export gw_targus    := dataset( [{'targus','http://rw_data_dev:Password01@rwgatewaycert.br.seisint.com:8090/wsGateway'}], risk_indicators.layout_gateways_in );
	export gw_targus_sco:= dataset( [{'targus','http://rw_score_dev:Password01@rwgatewaycert.br.seisint.com:8090/wsGateway'}], risk_indicators.layout_gateways_in );
	export gw_attus     := dataset( [{'attus','http://rw_score_dev:Password01@rwgatewaycert.br.seisint.com:8090/wsGateway'}], risk_indicators.layout_gateways_in );
	export gw_netacuity := dataset( [{'netacuity','http://rw_score_dev:Password01@rwgatewaycert.sc.seisint.com:7726/WsGateway'}], risk_indicators.layout_gateways_in );
	export gw_netacuityv4 := dataset( [{'netacuity','http://rw_score_dev:Password01@rwgatewaycert.sc.seisint.com:7726/WsGateway/?ver_=1.93'}], risk_indicators.layout_gateways_in );
	export gw_FCRA      := dataset( [{'FCRA','http://roxieqavip.br.seisint.com:9876'}], risk_indicators.layout_gateways_in );
	export gw_personContext	:= dataset( [{'delta_personcontext','http://ln_api_dempsey_dev:g0n0l3s!@10.176.68.172:7534/WsSupport/?ver_=2'}], risk_indicators.layout_gateways_in );
	//deltabase gateways for Inquiries
	export gw_delta_dev := dataset( [{'delta_inquiry','http://rw_score_dev:Password01@10.176.68.151:7909/WsDeltaBase/preparedsql'}], risk_indicators.layout_gateways_in );
	export gw_delta_prod := dataset( [{'delta_inquiry','http://delta_iid_api_user:2rch%40p1$$@10.176.69.151:7909/WsDeltaBase/preparedsql'}], risk_indicators.layout_gateways_in );
	
	// export gw_FCRA      := dataset( [{'FCRA','http://rwgatewaycert.sc.seisint.com:7726'}], risk_indicators.layout_gateways_in );
	// export gw_FCRA      := dataset( [{'FCRA','http://rwgatewaycert.sc.seisint.com:7726'}], risk_indicators.layout_gateways_in );

// <gateways><row><servicename>insurancephoneheader</servicename><url>http://rw_score_dev:Password01@10.176.68.164:7526/WsPrism/?ver_=1.82</url></row></gateways>

	// DATA
	shared prii_layout := RECORD
		STRING AccountNumber;
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
	END;

	export IPs     := dataset( Data_Services.foreign_dataland + 'thor_data400::in::ips__layout_ip2o', riskwise.Layout_IP2O, csv(quote('"'), heading(1)) );

	export test_login_ids := ['RSKW0000','RSKW0010','webapp_roxie_test','amexdevxml', 'BurkeWSADL', 'eqngdevxml', 'falosdevxml', 'ndanamprod_realroxie', 'repubdevxml', 'webapp_roxie_qateam', 'ln_api_ivs2'];
	export test_company_ids := ['1385345','1006061','1448650','1488800','1028725','1104341','1357055','1005199', '1216650'];		
	
	shared r := record
		string firstname;
		string middlename;
		string streetaddress;
		string state;
		string ssn;
		string dateofbirth;
		string homephone;
		string city;
		string lastname;
		string zip;
		string accountnumber;
		string workphone;
		unsigned did;
	end;
	
	EXPORT s := RECORD
		STRING AccountNumber := '';
		STRING FirstName := '';
		STRING MiddleName := '';
		STRING LastName := '';
		STRING CompanyName := '';
		STRING StreetAddress := '';
		STRING City := '';
		STRING State := '';
		STRING Zip5 := '';
		STRING Zip4 := '';
		STRING HomePhone := '';
		STRING WorkPhone := '';
		STRING DateOfBirth := '';
		STRING SSN := '';
		STRING Age := '';
		STRING Email := '';
		STRING DLNumber := '';
		STRING DLState := '';
		STRING Gender := '';
		STRING IPAddress := '';
		STRING PassportUpper := '';
		STRING PassportLower := '';
		STRING DID := '';
		STRING DataSource := '';
	END;	
	
	EXPORT ts := RECORD
		STRING fname := '';
		STRING lname := '';
		STRING in_streetaddress := '';
		STRING in_city := '';
		STRING in_state := '';
		STRING in_zipcode := '';
		STRING p_city_name := '';
		STRING st := '';
		STRING z5 := '';
		STRING ssn := '';
		STRING dob := '';
		STRING phone10 := '';
		STRING wphone10 := '';
		STRING rc1 := '';
		STRING rc2 := '';
		STRING rc3 := '';
		STRING rc4 := '';
		STRING rc5 := '';
		STRING rc6 := '';
		STRING score := '';
	END;

	export validation_input_file108 := dataset(Data_Services.foreign_dataland + 'thor50_dev::in::validation_input_108', s, thor );
	export validation_input_file108_csv := dataset(Data_Services.foreign_dataland + 'thor50_dev02::in::validation_input_108_csv', s, csv(quote('"'), heading(single) ) );
	
	export testseed_input_file := dataset(Data_Services.foreign_dataland + 'thor_data50::in::testseed_input_file', ts, thor);
	
	// As of 10/1/2013 contains 633,301 unique records
	EXPORT input_file := DATASET(Data_Services.foreign_dataland + 'bpahl::out::sample_input_file_PROTECTED.csv', s, CSV(HEADING(single), QUOTE('"')));
	// Run this code to get a list of DataSources and counts available in our Input_File:
	// OUTPUT(Riskwise.shortcuts.input_file_sources, NAMED('Input_File_Source_Table'));
	EXPORT input_file_sources := SORT(TABLE(input_file, {STRING DataSource := input_file.DataSource, UNSIGNED8 DataSourceRecordCount := COUNT(GROUP), UNSIGNED8 TotalFileCount := COUNT(input_file), REAL8 PercentOfFullFile := (COUNT(GROUP) / COUNT(input_file)) * 100}, DataSource), -DataSourceRecordCount, DataSource);

	shared ox := RECORD
		unsigned8 time_ms := 0;
		STRING30 AccountNumber;
		Risk_Indicators.layout_bocashell_4temp;
		STRING200 errorcode;
	END;
	
	EXPORT ox50 := RECORD
		UNSIGNED8 time_ms := 0;
		INTEGER version := 0;
		STRING30 AccountNumber;
		Risk_Indicators.layout_bocashell_50temp;
		STRING200 errorcode;
	END;
	
	EXPORT ox50_in := RECORD
		unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
		INTEGER version := 0;
		risk_indicators.Layout_Boca_Shell -LnJ_datasets -consumerstatements;	
		string200 errorcode;
	end;
	
// keeping a copy of these shells on dataland thor50_dev cluster and prod pound_option_thor cluster
	export validation_fcra_shell108k_41    := dataset( '~thor50_dev::out::fcrashell41_validation_108k__w20150506-141026',  ox50, csv(quote('"'), maxlength(15000)) );
	export validation_nonfcra_shell108k_41 := dataset( '~thor50_dev::out::nonfcrashell41_validation_108k__w20150506-125953',  ox50, csv(quote('"'), maxlength(15000)) );
	
	export validation_fcra_shell108k_50    := dataset( '~thor50_dev::out::fcrashell50_validation_108k__w20150506-140238',  ox50, csv(quote('"'), maxlength(15000)) );
	export validation_nonfcra_shell108k_50 := dataset( '~thor50_dev::out::nonfcrashell50_validation_108k__w20150506-125241-1',  ox50, csv(quote('"'), maxlength(15000)) );
	
//commented out since the layout has changed too much. If need, recreate	
	// export	ox50btst := record
		// unsigned8 time_ms := 0;
		// string30 accountnumber;
		// risk_indicators.Layout_Boca_Shell -LnJ_datasets Bill_To_Out;
		// risk_indicators.Layout_Boca_Shell -LnJ_datasets Ship_To_Out;
		// risk_indicators.Layout_EDDO eddo;
		// riskwise.Layout_IP2O ip2o;
		// string50 errorcode;
	// end;

	// export validation_btst_shell_108k_50 := dataset( '~thor50_dev::out::validation_btst_out_w20150508-132819',  ox50btst, csv(quote('"'), maxlength(40000)) );
	
	// these files were also deleted because they were on old dataland.  if you need them will need to process the shell on demand when layout change goes to cert.  dev roxies not working at the moment
	// export validation_fcra_ADL_shell108k_41    := dataset( '~kvhtemp::out::fcra_adl_clam41__validation_108k__w20140102-161247-4',  ox, csv(quote('"'), maxlength(15000)) );
	// export validation_nonfcra_ADL_shell108k_41 := dataset( '~kvhtemp::out::nonfcra_adl_clam41__validation_108k__w20140102-180052',  ox, csv(quote('"'), maxlength(15000)) );
	export validation_fcra_ADL_shell108k_50    := dataset( '~akoenen::out::fcrashell50_adl_validation108kw20170622-102703',  ox50_in, csv(quote('"'), maxlength(15000)) );
		
	// The following are used for Phone Shell model validation - Boca Shell Version 41.  Join by Account Number AND Gathered Phone to get a unique record for validation. 95,000 inputs = 987,090 phones
	// Unique Join for full layout: Input_Echo.AcctNo AND Gathered_Phone
//file is too old so need to recreate if need it
//	// export validation_phone_shell95k_41 := dataset('~bpahl::validation::phone_shell_w20131217-152013.csv', Phone_Shell.Layout_Phone_Shell_Temp.Phone_Shell_Layout, CSV(HEADING(single), QUOTE('"')));
export validation_phone_shell95k_41_gatewaysoff := dataset('~njj::out::phone_shell_sample_mar18_1p-equifax_off_tmppsw20180522-155400.csv', Phone_Shell.Layout_Phone_Shell_Temp.Phone_Shell_Layout, CSV(HEADING(single), QUOTE('"')));
export validation_phone_shell95k_41_gatewayson := dataset('~njj::out::phone_shell_sample_mar18_1p-equifax_on_tmppsw20180522-155230.csv', Phone_Shell.Layout_Phone_Shell_Temp.Phone_Shell_Layout, CSV(HEADING(single), QUOTE('"')));
	// Unique Join for modeling layout: AcctNo AND Gathered_Ph
	// // export validation_phone_shell95k_modelinglayout_41 := dataset('~bpahl::validation::phone_shell_modelinglayout_w20131217-152013.csv', Phone_Shell.Layout_Modeling_Shell, CSV(HEADING(single), QUOTE('"')));
export validation_phone_shell95k_modelinglayout_41_gatewaysoff := dataset('~njj::out::phone_shell_sample_mar18_1p-equifax_off_modelinglayout_w20180522-155400.csv', Phone_Shell.Layout_Modeling_Shell, CSV(HEADING(single), QUOTE('"')));
export validation_phone_shell95k_modelinglayout_41_gatewayson := dataset('~njj::out::phone_shell_sample_mar18_1p-equifax_on_modelinglayout_w20180522-155230.csv', Phone_Shell.Layout_Modeling_Shell, CSV(HEADING(single), QUOTE('"')));

	// for converting PRII files from Nick's team to layout_batch_in:
	export PRII2Batch( dataset(prii_layout) prii_in ) := FUNCTION
		risk_indicators.Layout_Batch_In toBatch( prii_in le, integer c ) := TRANSFORM
			self.seq               := c;
			self.AcctNo            := le.accountnumber;
			self.SSN               := le.ssn;
			self.Name_First        := le.firstname;
			self.Name_Last         := le.lastname;
			self.DOB               := le.dateofbirth;
			self.street_addr       := le.streetaddress;
			self.p_City_name       := le.city;
			self.St                := le.state;
			self.Z5                := le.zip;
			self.DL_Number         := le.dlnumber;
			self.DL_State          := le.dlstate;
			self.Home_Phone        := le.homephone;
			self.Work_Phone        := le.workphone;
			self.HistoryDateYYYYMM := 999999;
			self := [];
		END;
		in_batch_layout := project( prii_in, toBatch(left, counter) );
		
		batched := project( in_batch_layout, transform( { dataset(Risk_Indicators.Layout_Batch_In) batch_in, integer GLBPurpose := 1, integer DPPAPurpose := 1 },
				self.batch_in := dataset( [left], Risk_Indicators.Layout_Batch_In )
			)
		);
		return batched;
	END;

end;