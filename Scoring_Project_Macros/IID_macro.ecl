export IID_macro(ds_input,threads,roxieIP,DPPA,GLB,DRM,HistoryDate):= functionmacro
		
import ut, Risk_Indicators, riskwise, models;	

layout_soap := record
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

		end;

	

	layout_soap iid_soap_trans(ds_input le) := TRANSFORM
			SELF.Accountnumber := (STRING)le.AccountNumber;	
			SELF.DPPAPurpose := DPPA;
			SELF.GLBPurpose := GLB;
			
			self.DataRestrictionMask := DRM;	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																										// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data

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
			
			// possible input options 'FuzzyCCYYMMDD','FuzzyCCYYMM''ExactCCYYMMDD''ExactCCYYMM''RadiusCCYY', if using the radius, then 0-3 is the range
			// self.DOBMatchOptions := dataset([{'RadiusCCYY','3'}], risk_indicators.layouts.Layout_DOB_Match_Options);

			SELF := le;
			self := [];
		end;

	dist_dataset := distribute(PROJECT(ds_input, iid_soap_trans(left)), random());
		
		
	xlayout := RECORD
			STRING30 AcctNo;
			unsigned6 did;
				// (risk_indicators.Layout_InstandID_NuGen);
			STRING errorcode;
		END;

	xlayout myFail(dist_dataset le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF.AcctNo := le.AccountNumber;
			SELF := le;
			SELF := [];
		END;

	iid_results := 	soapcall(dist_dataset, roxieIP,
				'Risk_Indicators.InstantID', {dist_dataset}, 
				DATASET(xlayout), RETRY(3), TIMEOUT(120), LITERAL,
				XPATH('Risk_Indicators.InstantIDResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));
	
		return iid_results;

endmacro;