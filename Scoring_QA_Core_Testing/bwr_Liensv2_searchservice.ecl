#workunit('name','LiensV2Service');
IMPORT Risk_Indicators, RiskWise, UT, LiensV2_Services;

		unsigned8 no_of_records := 0;
		integer eyeball := 20;
		integer retry := 3;
		integer timeout := 120;
		integer threads := 1;
		// String neutralroxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; 
		String neutralroxieIP :=  riskwise.shortcuts.core_97_roxieIP; // CoreRoxie		
		// String fcraroxieIP := riskwise.shortcuts.staging_fcra_roxieIP;
		String fcraroxieIP := riskwise.shortcuts.core_97_roxieIP;
		/* Infile_name :=  ut.foreign_aprod + 'thor::ncf::lj::lexids::d20170418';            //1,336,640 Sample size
		Infile_name :=  ut.foreign_aprod + 'thor::ncf::lj::lexids::d20170613';            //
		// Infile_name :=  '~bkarnatz::in::20170629::LJ_LexID_BatchErrors';            //1766 Sample size */
		// Infile_name :=  '~wema::in::lien::tiny_sample_slim.csv';            //
		// Infile_name :=  '~wema::multiple_filing_test.csv';            //
		Infile_name :=  '~wema::in::lien::final_sample_slim.csv';            //
		String outfile_name :=  '~wema::out::FCRA::LiensV2Service::'+thorlib.wuid();
	
		//*********** SETTINGS ********************************

		FCRAPurposeCode := 6;   //6 makes it use only Insurance Lien/Judgement  //-1 is the other option
		/* DPPA:=6;    //was 6 in Tech Doc.  No longer needed.
		GLB:= 1;    // was 1 in Tech Doc.  No longer needed. */

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************


		layout_input := RECORD       //INPUT FILE ONLY NEEDS LEXID POPULATED
			Unsigned6 lexid;
			String LN_MATCHKEY; 
		END;

		ds_raw_input := IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, csv),
										CHOOSEN(DATASET(Infile_name, layout_input, csv), no_of_records));
	
	  //*********** SETUP AND SOAPCALL ******************
		
		layout_soap_input := record
			unsigned6 did;
			Integer fcraPurpose;
			String LN_MATCHKEY;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
		end;

		layout_soap_input append_settings(ds_raw_input le, INTEGER c) := TRANSFORM
			self.did := le.lexid;
			self.fcraPurpose := FCRAPurposeCode;
			self.LN_MATCHKEY := le.LN_MATCHKEY;
			self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In);
			SELF := le;
			self := [];
		end;
	
    //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
		
		//Soap output layout
		layout_Soap_output := Record
			integer output_seq_no;
			LiensV2_Services.layout_lien_rollup;			
			string errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF := le;
			SELF := [];
		END;

  //*********** PERFORMING SOAPCALL TO ROXIE ************ 
	
		Soap_output := soapcall(soap_in, fcraroxieIP,
						'liensv2_services.lienssearchservicefcra', {soap_in}, 
						DATASET(layout_Soap_output),
						RETRY(retry), TIMEOUT(timeout), LITERAL,
						XPATH('liensv2_services.lienssearchservicefcraResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
						// XPATH('liensv2_services.lienssearchservicefcraResponse'),
						PARALLEL(threads), onFail(myFail(LEFT)));
						
	  // ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
		
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
			unsigned6 did;
			Integer fcraPurpose;
			String LN_MATCHKEY;
			layout_Soap_output;
		END;

    //Appending additional internal extras to Soap output file 
		Global_output_lay normit(Soap_output L, soap_in R) := transform
			self.fcraPurpose := R.fcraPurpose; 
			self.did := R.did; 
			self.LN_MATCHKEY := R.LN_MATCHKEY;
			self := L;
		  self := [];
		END;
		
Output(choosen(ds_raw_input,3), Named('ds_raw_input'));
Output(choosen(soap_in,3), Named('soap_in'));
Output(Soap_output, Named('Soap_output_all'));

		ds_with_extras := JOIN(Soap_output,soap_in,(integer)LEFT.debtors.parsed_parties[1].did=RIGHT.did,normit(LEFT,RIGHT));
		
	//******final file out to thor
		final_output := output(ds_with_extras,, outfile_name+ '_unflatten', thor,compressed, OVERWRITE);
		
Return final_output;	