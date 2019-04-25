#workunit('name','LiensV2Service');
IMPORT Risk_Indicators, RiskWise, UT, LiensV2_Services;

		unsigned8 no_of_records := 0;
		integer eyeball := 20;
		integer retry := 3;
		integer timeout := 120;
		integer threads := 1;
		String neutralroxieIP := RiskWise.shortcuts.staging_neutral_roxieIP ; 
		String fcraroxieIP := riskwise.shortcuts.staging_fcra_roxieIP;
		Infile_name :=  ut.foreign_aprod + 'thor::ncf::lj::lexids::d20170306';         //1,059,936 Sample size
		String outfile_name :=  'bkarnatz::out::FCRA::LiensV2Service::Bothbcb::20170324';
		// String outfile_name :=  'bkarnatz::out::TEST';
		
		//*********** SETTINGS ********************************

		FCRAPurposeCode := -1;   //6 makes it use only Insurance Lien/Judgement
		// DPPA:=6;    //was 6 in Tech Doc.  No longer needed.
		// GLB:= 1;    // was 1 in Tech Doc.  No longer needed.
		// HistoryDate := 999999;

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************


		layout_input := RECORD       //INPUT FILE ONLY NEEDS LEXID POPULATED
			Unsigned6 lexid;
		END;

		ds_raw_input := IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records));

	// layout_input := RECORD 
			// INTEGER3 AccountNumber;
			// UNSIGNED6 	did;
		// END;		

// ds_raw_input := Dataset([{1, 46},{2,79},{3,129},{4,149}], layout_input); 
	
	  //*********** T_Mobile RVT1212 XML SETUP AND SOAPCALL ******************
		
		layout_soap_input := record
			// String AccountNumber;
			unsigned6 did;
			Integer fcraPurpose;
			// Integer GLBPurpose;
			// Integer DPPAPurpose;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			// integer HistoryDateYYYYMM := HistoryDate;
		end;


		layout_soap_input append_settings(ds_raw_input le, INTEGER c) := TRANSFORM
			// self.Accountnumber := (STRING)le.AccountNumber;	
			self.did := le.lexid;
			// self.HistoryDateYYYYMM := HistoryDate;
			self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In);
			// self.glbpurpose := GLB;
			// self.dppapurpose := DPPA;
			self.fcraPurpose := FCRAPurposeCode;
			SELF := le;
			self := [];
		end;
	
    //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
		
		//Soap output layout
		layout_Soap_output := Record
			// String AccountNumber;
			LiensV2_Services.layout_lien_rollup;
			integer output_seq_no;
			string errorcode;
		END;
		

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			// self.AccountNumber:=le.AccountNumber;
			SELF := le;
			SELF := [];
		END;

  //*********** PERFORMING SOAPCALL TO ROXIE ************ 
	
		Soap_output := soapcall(soap_in, fcraroxieIP,
						'liensv2_services.lienssearchservicefcra', {soap_in}, 
						DATASET(layout_Soap_output),
						RETRY(retry), TIMEOUT(timeout), LITERAL,
						XPATH('liensv2_services.lienssearchservicefcraResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
						PARALLEL(threads), onFail(myFail(LEFT)));
						
	  // ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
		
		//GLOBAL OUTPUT LAYOUT

		Global_output_lay:= RECORD	 
			unsigned6 did;
			Integer fcraPurpose;			
			layout_Soap_output;
			// String historydate;
		END;


    //Appending additional internal extras to Soap output file 
		Global_output_lay normit(Soap_output L, soap_in R) := transform
			// self.acctno := R.AccountNumber;
			self.fcraPurpose := R.fcraPurpose; 
			self.did := R.did; 
			// self.historydate := (string)r.HistoryDateYYYYMM;
			self := L;
		  self := [];
		END;

		ds_with_extras := JOIN(Soap_output,soap_in,(integer)LEFT.debtors.parsed_parties[1].did=RIGHT.did,normit(LEFT,RIGHT));
		
		
		
// Output(ds_raw_input, Named('ds_raw_input'));
// Output(Soap_output, Named('Soap_output'));
// Output(ds_with_extras, Named('final'));
	
	//******final file out to thor
		final_output := output(ds_with_extras,, outfile_name , thor,compressed, OVERWRITE);
		
Return final_output;	