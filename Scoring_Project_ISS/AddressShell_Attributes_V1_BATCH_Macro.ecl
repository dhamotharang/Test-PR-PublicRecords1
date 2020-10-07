EXPORT AddressShell_Attributes_V1_BATCH_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, RiskProcessing, Scoring, Gateway, Address_Shell;

		unsigned8 no_of_records := records_ToRun;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;
		
		//*********** SETTINGS ********************************

		GLB :=scoring_project_pip.User_Settings_Module.AddressShell_Attributes_V1_BATCH_Generic_settings.GLB;  
		DRM :=scoring_project_pip.User_Settings_Module.AddressShell_Attributes_V1_BATCH_Generic_settings.DRM;  
		DLPurpose:=scoring_project_pip.User_Settings_Module.AddressShell_Attributes_V1_BATCH_Generic_settings.DLPurpose;
		Address_Attributes_Version := scoring_project_pip.User_Settings_Module.AddressShell_Attributes_V1_BATCH_Generic_settings.Address_Attributes_Version;
		Property_Info_Attributes_Version := scoring_project_pip.User_Settings_Module.AddressShell_Attributes_V1_BATCH_Generic_settings.Property_Info_Attributes_Version;
		ERC_Attributes_Version := scoring_project_pip.User_Settings_Module.AddressShell_Attributes_V1_BATCH_Generic_settings.ERC_Attributes_Version;

		 // REF: email from Nathan 10/21/2015 sub: Address Shell Monitoring
			 // <Options> 
      // <RequestedAttributeGroups>
        // <Name>AddressBasedPRAttrV1</Name>
        // <Name>PropertyInfoAttrV1</Name>
        // <Name>ERCAttrV0</Name>
      // </RequestedAttributeGroups>
    // </Options>
    // <User>
      // <GLBPurpose>1</GLBPurpose>
      // <DLPurpose>6</DLPurpose>
      // <DataRestrictionMask>00000000000000000000</DataRestrictionMask>
    // </User>

		//*****************************************************

	  //************** INPUT FILE GENERATION ****************
		
		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

    ds_raw_input := DISTRIBUTE(IF(no_of_records > 0, CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records),
                            DATASET( infile_name, layout_input, thor)),(integer)AccountNumber);

		//*********** AddressShell SETUP AND SOAPCALL ******************

		layout_soap_input := RECORD
		  string seq;
			string acctno;
			dataset(iesp.addressattributesreport.t_AddressAttributesReportRequest) AddressAttributesReportRequest;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
		  boolean ReturnFlatLayout;
			STRING50 DataRestrictionMask;	
			STRING30 AddressBasedPRAttrVersion;
			STRING30 PropertyInfoAttrVersion;	
			STRING30 ERCAttrVersion;	
		END;

		layout_soap_input make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			self.seq := (string)c;
			SELF.acctno := (string)le.AccountNumber;
			AccountNumber := le.AccountNumber;
	    Address := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address,
																		SELF.StreetAddress1 := le.StreetAddress;
																		SELF.City := le.city;
																		SELF.State := le.state;
																		SELF.Zip5 := le.zip;
																		SELF := []
																		))[1];
	    SELF.AddressAttributesReportRequest := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.addressattributesreport.t_AddressAttributesReportRequest,
																					SELF.SearchBy.Address := Address;
																					SELF.User.AccountNumber :=(string)le.AccountNumber;
																					SELF.User.GLBpurpose :=(string)GLB;
																					SELF.User.DataRestrictionMask :=(string)DRM;
																					SELF.User.DLPurpose :=(string)DLPurpose;
																					SELF := []));

      SELF.ReturnFlatLayout := TRUE;	   
		  SELF.gateways := DATASET([{'reportservice', roxieIP}], risk_indicators.layout_gateways_in);
	    SELF.DataRestrictionMask := DRM;
			SELF.AddressBasedPRAttrVersion := Address_Attributes_Version;
			SELF.PropertyInfoAttrVersion := Property_Info_Attributes_Version;
			SELF.ERCAttrVersion := ERC_Attributes_Version;
			SELF := [];
    END;

		//ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, make_batch_in(LEFT, counter)), RANDOM());

		//Soap output layout
		layout_Soap_output := RECORD
		  string acctno;
			unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  
	    Address_Shell.layoutPropertyCharacteristics;
			STRING errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.acctno:= le.acctno;
			SELF := le;
			SELF := [];
		END;

		//*********** PERFORMING SOAPCALL TO ROXIE ************

		Soap_output := SOAPCALL(soap_in, roxieIP,
						'Address_Shell.Address_Attributes_Service', {soap_in}, 
						DATASET(layout_Soap_output),
						PARALLEL(threads), onFail(myFail(LEFT)));			
						
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
				
	  //GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.AddressShell_Attributes_V1_BATCH_Generic_Global_Layout;		
		END;				
		
    Soap_output_pjt:=project(soap_output,transform(Global_output_lay,self.acctno:=left.input.accountnumber;self:=left));
		
		//final file out to thor
	  final_output := output(Soap_output_pjt ,,outfile_name, thor, compressed, overwrite);
		
		// output(choosen(ds_raw_input,50),named('ds_raw_input'));
		// output(choosen(soap_in,50),named('soap_in'));
		
		RETURN final_output;

ENDMACRO;