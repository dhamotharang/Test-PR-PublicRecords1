EXPORT LI_Scores_V4_XML(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		model := 'msn1106_0' ;
		gateways := Gateway;
		Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;


	  //*********** SETTINGS ********************************

		GLB:= Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_XML_Generic_msn1106_0_settings.GLB;
		DRM:= Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_XML_Generic_msn1106_0_settings.DRM;
		Version := Scoring_Project_PIP.User_Settings_Module.LI_Scores_V4_XML_Generic_msn1106_0_settings.Version;
  	HistoryDate := 999999;
			
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************
		
		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;
			
	  ds_raw_input := IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records));
										
    //*********** LI Scores V4 XML SETUP AND SOAPCALL ******************


		layout_soap_input := RECORD
			DATASET(iesp.leadintegrity.t_LeadIntegrityRequest) LeadIntegrityRequest;
			unsigned6 did;
			unsigned3 HistoryDateYYYYMM;
			string AccountNumber;
		END;

		layout_soap_input append_settings(ds_raw_input le) := TRANSFORM
			u := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User, SELF.AccountNumber := (string)le.AccountNumber; SELF.DLPurpose := '0'; SELF.GLBPurpose := (string)GLB; SELF.DataRestrictionMask := DRM; SELF := []));
			o := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegrityOptions,
				SELF.AttributesVersionRequest := Version;
				self.IncludeModels.Integrity := model,
				SELF := [])
			);		
			n := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name, SELF.First := le.FirstName; SELF.Middle := le.MiddleName; SELF.Last := le.LastName; SELF := []));
			a := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, SELF.StreetAddress1 := le.StreetAddress; SELF.City := le.City; SELF.State := le.State; SELF.Zip5 := le.Zip; SELF := []));
			d := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, SELF.Year := (INTEGER)le.DateOfBirth[1..4]; SELF.Month := (INTEGER)le.DateOfBirth[5..6]; SELF.Day := (INTEGER)le.DateOfBirth[7..8]; SELF := []));
			s := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegritySearchBy, SELF.Seq := (string)le.AccountNumber; 
																																													SELF.Name := n[1]; 
																																													SELF.Address := a[1]; 
																																													SELF.DOB := d[1]; 
																																													SELF.SSN := le.SSN; 
																																													SELF.HomePhone := le.HomePhone; 
																																													SELF.WorkPhone := le.WorkPhone;
																																													SELF.DriverLicenseNumber := le.DLNumber;
																																													SELF.DriverLicenseState := le.DLState;
																																													SELF := []));
			r := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegrityRequest, SELF.User := u[1]; SELF.Options := o[1]; SELF.SearchBy := s[1]; SELF := []));
			SELF.LeadIntegrityRequest := r[1];
			SELF.HistoryDateYYYYMM := HistoryDate;
			SELF.AccountNumber :=(string) le.AccountNumber;
			SELF := [];
		END;

		//ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT)), Random());
		
    //Soap output layout
		layout_Soap_output := RECORD
		
			unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 		
			unsigned6 did;
			iesp.leadintegrity.t_LeadIntegrityResponse;
			string errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF.Result.InputEcho.Seq:=(string)le.AccountNumber;
			SELF := le;
			SELF := [];
		END;
		
	  //*********** PERFORMING SOAPCALL TO ROXIE ************ 
		 
		Soap_output := SOAPCALL(soap_in, roxieIP,
						'Models.LeadIntegrity_Service', {soap_in}, 
						DATASET(layout_Soap_output),
						RETRY(retry), TIMEOUT(timeout),
					 	PARALLEL(threads), onFail(myFail(LEFT)));
						
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
				
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
	  	Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout;			 
		END;

		//Appeding additional internal extras to Soap output file 
		ds_with_extras := JOIN(soap_in, Soap_output, LEFT.LeadIntegrityRequest[1].SearchBy.Seq=RIGHT.Result.InputEcho.Seq,
			                                  TRANSFORM(Global_output_lay,
																						self.time_ms := right.time_ms;
																						self.acctno := (string)left.accountnumber;
																						self.seq := left.leadintegrityrequest[1].searchby.seq;
																						self.score := (string3)right.result.models[1].scores[1].value;
																						self.rc1 := right.Result.Models[1].Scores[1].WarningCodeIndicators[1].WarningCode;
																						self.rc2 := right.Result.Models[1].Scores[1].WarningCodeIndicators[2].WarningCode;
																						self.rc3 := right.Result.Models[1].Scores[1].WarningCodeIndicators[3].WarningCode;
																						self.rc4 := right.Result.Models[1].Scores[1].WarningCodeIndicators[4].WarningCode;
																						self.DID := right.did; 
																						self.historydate := (string)left.HistoryDateYYYYMM;
																						self.FNamePop := left.leadintegrityrequest[1].searchby.name.first <> '';
																						self.LNamePop := left.leadintegrityrequest[1].searchby.name.last <> '';
																						self.AddrPop := left.leadintegrityrequest[1].searchby.address.streetaddress1 <> '';
																						self.SSNLength := (string)(length(trim(left.leadintegrityrequest[1].searchby.ssn))) ;
																						self.DOBPop := left.leadintegrityrequest[1].searchby.dob.year <> 0;
																						self.EmailPop := false; 
																						self.IPAddrPop := false; 
																						self.HPhnPop := left.leadintegrityrequest[1].searchby.homephone <> '';
																						self.errorcode:=right.errorcode;
																						), keep(1)
																				);


	  //final file out to thor
		final_output   := output(ds_with_extras,, outfile_name, thor, compressed, OVERWRITE);

		RETURN  final_output;
		
ENDMACRO;
