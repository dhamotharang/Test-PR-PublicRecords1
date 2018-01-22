﻿EXPORT RV_Attributes_V3_BATCH_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String neutralroxieIP := neutralroxie_IP ; 
		String fcraroxieIP := fcraroxie_IP ;
		Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;

		//*********** SETTINGS ********************************

		DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_Generic_settings.DRM;
		isFCRA:=if(Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_Generic_settings.isFCRA=true,'FCRA','NONFCRA');
		IncludeVersion3:=if(Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_Generic_settings.IncludeVersion3,3,4);
		// IsPreScreen:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V3_BATCH_Generic_settings.IsPreScreen;
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
																
		
    //*********** RV Attributes V3 BATCH SETUP AND SOAPCALL ******************

		layout_soap_input := RECORD
			DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
			DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
			STRING DataRestrictionMask;
			boolean IncludeVersion3;
			// BOOLEAN IsPreScreen;	
		END;

		Risk_Indicators.Layout_Batch_In make_batch_in(ds_raw_input le, integer c) := TRANSFORM
			self.seq := c;
			SELF.acctno :=(string) le.accountnumber;
			SELF.Name_First := le.FirstName;
			SELF.Name_Middle := le.MiddleName;
			SELF.Name_Last := le.LastName;
			SELF.street_addr := le.StreetAddress;
			SELF.p_City_name := le.CITY;
			SELF.St := le.STATE;
			SELF.z5 := le.ZIP;
			SELF.Home_Phone := le.HomePhone;
			SELF.SSN := le.SSN;
			SELF.DOB := le.DateOfBirth;
			SELF.Work_Phone := le.WorkPhone;
			self.historydateyyyymm :=  HistoryDate;
			SELF := le;
			SELF := [];
		END;

		layout_soap_input append_settings(ds_raw_input le, integer c) := TRANSFORM
			batch := PROJECT(le, make_batch_in(LEFT, c));
			SELF.batch_in := batch;
			SELF.gateways := DATASET([{isFCRA, neutralroxieIP}], risk_indicators.layout_gateways_in);
			// SELF.IsPreScreen := IsPreScreen;		
			self.IncludeVersion3 := IncludeVersion3;
			SELF.DataRestrictionMask := DRM;
		END;
			
		//ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());
		
    //Soap output layout
		layout_Soap_output := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 		
		models.Layout_RiskView_Batch_Out;
			string200 errorcode;
		END;
					 
		layout_Soap_output myfail(soap_in L) := transform
			self.errorcode := FAILCODE + FAILMESSAGE;
			self.acctno := l.batch_in[1].acctno;
			self := [];
		end;

	 //*********** PERFORMING SOAPCALL TO ROXIE ************ 
	 
	 Soap_output := soapcall(soap_in, fcraroxieIP ,
												'models.RiskView_Batch_Service', 
												{soap_in},
												dataset(layout_Soap_output),
												RETRY(retry), TIMEOUT(timeout),
												parallel(threads) ,
												onfail(myfail(LEFT)));

		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
			
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD		 
   		Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_Attributes_V3_Global_Layout;		
		END;

    //Appeding additional internal extras to Soap output file 
		Global_output_lay normit(Soap_output L, soap_in R) := transform
self.time_ms := l.time_ms;			
			self.accountnumber := L.acctno;
			self.DID := (integer)l.did; 
			self.historydate := (string)r.batch_in[1].HistoryDateYYYYMM;
			self.FNamePop :=(string)r.batch_in[1].Name_First<>'';
			self.LNamePop := r.batch_in[1].Name_Last<>'';
			self.AddrPop :=r.batch_in[1].street_addr<>'';
			self.SSNLength := (string)(length(trim(r.batch_in[1].SSN,left,right))) ;
			self.DOBPop := r.batch_in[1].DOB<>'';
			self.IPAddrPop :=r.batch_in[1].ip_addr<>'';
			self.HPhnPop := r.batch_in[1].Home_Phone<>'';
			self.history_date := (string6)HistoryDate;
			self.invalidssn := L.isSSNInvalid;	
			SELF.verifiedphonefullname:=  L.isPhoneFullNameMatch ;
			SELF.verifiedphonelastname:=  L.isPhoneLastNameMatch ;
			SELF.invalidphone:=  L.isPhoneInvalid;
			SELF.invalidaddr:=  L.isAddrInvalid;
			SELF.invaliddl:=  L.isDLInvalid;
			SELF.ssndeceased:=  L.isDeceased;
			SELF.ssnvalid:=  L.isSSNValid;
			SELF.recentissue:=  L.isRecentIssue;
			SELF.nonus:=  L.isNonUS;
			SELF.issued3:=  L.isIssued3;
			SELF.issuedage5:=  L.isIssuedAge5;
			SELF.iaownedbysubject:=  L.IAisOwnedBySubject;
			SELF.iafamilyowned:=  L.IAisFamilyOwned;
			SELF.iaoccupantowned:=  L.IAisOccupantOwned;
			SELF.ianotprimaryres:=  L.IAisNotPrimaryRes;
			SELF.caownedbysubject:=  L.CAisOwnedBySubject;
			SELF.cafamilyowned:=  L.CAisFamilyOwned;
			SELF.caoccupantowned:=  L.CAisOccupantOwned;
			SELF.canotprimaryres:=  L.CAisNotPrimaryRes;
			SELF.paownedbysubject:=  L.PAisOwnedBySubject;
			SELF.pafamilyowned:=  L.PAisFamilyOwned;
			SELF.paoccupantowned:=  L.PAisOccupantOwned;
			SELF.inputcurrmatch:=  L.isInputCurrMatch;
			SELF.diffstate:=  L.isDiffState;
			SELF.inputprevmatch:=  L.isInputPrevMatch;
			SELF.diffstate2:=  L.isDiffState2;
			SELF.addrhighrisk:=  L.isAddrHighRisk;
			SELF.phonehighrisk:=  L.isPhoneHighRisk;
			SELF.addrprison:=  L.isAddrPrison;
			SELF.zippobox:=  L.isZipPOBox;
			SELF.zipcorpmil:=  L.isZipCorpMil;
			SELF.phonepager:=  L.isPhonePager;
			SELF.phonemobile:=  L.isPhoneMobile;
			SELF.phonezipmismatch:=  L.isPhoneZipMismatch; 
    	SELF := L;
      SELF := [];
	  END;
			 
		ds_with_extras := JOIN(Soap_output,soap_in,LEFT.Acctno=(string)RIGHT.batch_in[1].acctno,normit(LEFT,RIGHT));

		//final file out to thor
		final_output := output(ds_with_extras ,, outfile_name, thor, compressed, overwrite);

		RETURN final_output;

ENDMACRO; 