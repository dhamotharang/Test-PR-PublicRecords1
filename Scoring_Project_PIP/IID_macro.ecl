EXPORT IID_macro(ds_input, threads, roxieIP, DPPA, GLB, DRM, HistoryDate):= FUNCTIONMACRO
		
IMPORT ut, Risk_Indicators, riskwise, models;	

	  //*********** Instant_ID XML SETUP AND SOAPCALL ******************
	  layout_soap_input := record
			STRING AccountNumber;
			STRING FirstName;
			STRING MiddleName;
			STRING LastName;
			STRING NameSuffix;
			STRING StreetAddress;
			string PrimRange;
			string PreDir;
			string Primname;
			string AddrSuffix;
			string PostDir;
			string UnitDesignation;
			string SecRange;
			STRING City;
			STRING State;
			STRING Zip;
			STRING Country;
			STRING SSN;
			STRING DateOfBirth;
			STRING Age;
			STRING DLNumber;
			STRING DLState;
			STRING Email;
			STRING IPAddress;
			STRING HomePhone;
			STRING WorkPhone;
			STRING EmployerName;
			STRING FormerName;
			INTEGER GLBPurpose;
			INTEGER DPPAPurpose;
			string DataRestrictionMask;
			integer HistoryDateYYYYMM;
			string neutral_gateway := '';	
			dataset(Models.Layout_Score_Chooser) scores;				
			boolean OfacOnly;
			integer OFACversion;
			boolean IncludeOfac;
			boolean IncludeAdditionalWatchLists;
			real GlobalWatchlistThreshold;
			boolean PoBoxCompliance;
			boolean IncludeMSoverride;
			boolean IncludeCLoverride;
			boolean IncludeDLVerification;
			string44 PassportUpperLine;
			string44 PassportLowerLine;
			string6 Gender;
			integer DOBradius;
			boolean usedobfilter;				
			boolean ExactFirstNameMatch;
			boolean ExactFirstNameMatchAllowNicknames;
			boolean ExactLastNameMatch;
			boolean ExactPhoneMatch;
			boolean ExactSSNMatch;
			boolean IncludeAllRiskIndicators;			
			dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions;
		END;

		layout_soap_input append_settings(ds_input le) := TRANSFORM
					self.Accountnumber := (STRING)le.AccountNumber;	
					self.DPPAPurpose := DPPA;
					self.GLBPurpose := GLB;					
					self.DataRestrictionMask := DRM;																											
					self.PoBoxCompliance := false;
					self.IncludeMSoverride := false;
					self.IncludeCLoverride := false;
					self.usedobfilter := false;
					self.DOBradius := 2;
					self.OfacOnly := false;
					self.OFACversion := 2;
					self.IncludeOfac := true;
					self.IncludeAdditionalWatchLists := false;
					self.GlobalWatchlistThreshold := 0.84;				
					self.IncludeDLVerification := false;
					self.PassportUpperLine := '';
					self.PassportLowerLine := '';
					self.Gender := '';				
					self.HistoryDateYYYYMM := HistoryDate;
					self.ExactFirstNameMatch := false;
					self.ExactFirstNameMatchAllowNicknames := false;
					self.ExactLastNameMatch := false;
					self.ExactPhoneMatch := false;
					self.ExactSSNMatch := false;
					self.IncludeAllRiskIndicators := false;			
					self := le;
					self := [];
				END;
				
		//ds_soap_in
		soap_input := DISTRIBUTE(PROJECT(ds_input, append_settings(LEFT)), Random());
				
		//Soap output layout
		layout_Soap_output := RECORD
					STRING30 AcctNo;
					unsigned6 did;
					STRING errorcode;
		END;

		layout_Soap_output myFail(soap_input le) := TRANSFORM
					SELF.errorcode := FAILCODE + FAILMESSAGE;
					SELF.AcctNo := le.AccountNumber;
					SELF := le;
					SELF := [];
		END;

		//*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		Soap_out := 	soapcall(soap_input, roxieIP,
						'Risk_Indicators.InstantID', {soap_input}, 
						DATASET(layout_Soap_output), RETRY(3), TIMEOUT(120), //LITERAL,
						//XPATH('Risk_Indicators.InstantIDResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
						PARALLEL(threads), onFail(myFail(LEFT)));
			
		RETURN Soap_out;

ENDMACRO;