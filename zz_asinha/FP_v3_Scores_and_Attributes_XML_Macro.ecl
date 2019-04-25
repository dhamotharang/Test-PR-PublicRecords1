EXPORT FP_v3_Scores_and_Attributes_XML_Macro (roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT ut, Risk_Indicators, riskwise, models, RiskProcessing;

		unsigned8 no_of_records := records_ToRun;
		unsigned1 eyeball := 10;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		Gateway := DATASET([], Gateway.Layouts.Config);
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;

		//*********** SETTINGS ********************************

		DPPA:=Scoring_Project_PIP.User_Settings_Module.FP_V3_XML_Generic_FP31505_0_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.FP_V3_XML_Generic_FP31505_0_settings.GLB;
		DRM:=Scoring_Project_PIP.User_Settings_Module.FP_V3_XML_Generic_FP31505_0_settings.DRM;
		DPM:=Scoring_Project_PIP.User_Settings_Module.FP_V3_XML_Generic_FP31505_0_settings.DPM;
    HISTORYDATE := 999999;
			
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	

		layout_input := RECORD
				Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

		ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));


		
		//*********** FP Scores and Attributes XML SETUP AND SOAPCALL ******************	
		
		Layout_Attributes_In := RECORD
			string name;
		END;

		layout_soap_input := RECORD
			STRING AccountNumber;
			STRING FirstName;
			STRING MiddleName;
			STRING LastName;
			STRING NameSuffix;
			STRING StreetAddress;
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
			string datapermissionmask;		
			integer HistoryDateYYYYMM;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			dataset(Layout_Attributes_In) RequestedAttributeGroups;
			string Model;
			boolean IncludeRiskIndices;  
			string Channel;
			string Income;
			string OwnOrRent;
			string LocationIdentifier;
			string OtherApplicationIdentifier;
			string OtherApplicationIdentifier2;
			string OtherApplicationIdentifier3;
			string DateofApplication;
			string TimeofApplication;
			unsigned did := 0;
		END;
    
		layout_soap_input append_settings(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());


    // Soap_output layout
		Layout_Attribute := RECORD, maxlength(10000)
			DATASET(Models.Layout_Parameters) Attribute;
		END;
		
		Layout_AttributeGroup := RECORD, maxlength(70000)
			string name;
			string index;
			DATASET(Layout_Attribute) Attributes;
		END;
		
		layout_Soap_output := RECORD, maxlength(100000)
			string30 accountnumber;
			Risk_Indicators.Layout_Input input;
			DATASET(models.Layouts.Layout_Score_FP) Scores;
			// DATASET(Layout_AttributeGroup) AttributeGroup;
			string errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF.accountnumber := le.accountnumber;
			SELF := le;
			SELF := [];
		END;
		
    //*********** PERFORMING SOAPCALL TO ROXIE ************ 
		
		Soap_output := soapcall(soap_in, roxieIP,
						'Models.FraudAdvisor_Service', {soap_in}, 
						DATASET(layout_Soap_output),
						PARALLEL(threads), TIMEOUT(timeout),
						retry(retry),
						// XPATH('Models.FraudAdvisor_ServiceResponse/Results/Result/Dataset[@name=\'Results,Results2\']/Row'),
						onFail(myFail(LEFT)));
						
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
		
	
      		// GLOBAL OUTPUT LAYOUT
      		Global_output_lay:= RECORD	 
      		Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout;			 
      		// Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V2_Global_Layout - Models.Layout_FraudAttributes.version2;			 
      		END;
        
      		// soap_output_attributes := Soap_output(attributegroup[1].name  = 'Version2');
   		
   		    layout_Soap_output trans_rollup(layout_Soap_output l, layout_Soap_output r) := transform
						self.input.Did := r.input.Did;
						self := l;
					End;
					
					soap_output_withDID := rollup(soap_output, ((integer)left.accountnumber = (integer)right.input.seq and left.accountnumber <>''), trans_rollup(left,right));
					
      		Global_output_lay trans_flatten(layout_Soap_output L, soap_in R) := Transform
      						// self.IdentityRiskLevel	:=R.attributegroup.attributes.attribute[1].value;
      						 // self.IdentityAgeOldest	:= R.attributegroup.attributes.attribute[2].value;
            			 // self.IdentityAgeNewest	:= R.attributegroup.attributes.attribute[3].value;
            			 // self.IdentityRecentUpdate	:= R.attributegroup.attributes.attribute[4].value;
            			 // self.IdentityRecordCount	:= R.attributegroup.attributes.attribute[5].value;
            			 // self.IdentitySourceCount	:= R.attributegroup.attributes.attribute[6].value;
            			 // self.IdentityAgeRiskIndicator	:= R.attributegroup.attributes.attribute[7].value;
            			 // self.IDVerRiskLevel	:= R.attributegroup.attributes.attribute[8].value;
            			 // self.IDVerSSN	:= R.attributegroup.attributes.attribute[9].value;
            			 // self.IDVerName	:= R.attributegroup.attributes.attribute[10].value;
            			 // self.IDVerAddress	:= R.attributegroup.attributes.attribute[11].value;
            			 // self.IDVerAddressNotCurrent	:= R.attributegroup.attributes.attribute[12].value;
            			 // self.IDVerAddressAssocCount	:= R.attributegroup.attributes.attribute[13].value;
            			 // self.IDVerPhone	:= R.attributegroup.attributes.attribute[14].value;
            			 // self.IDVerDriversLicense	:= R.attributegroup.attributes.attribute[15].value;
            			 // self.IDVerDOB	:= R.attributegroup.attributes.attribute[16].value;
            			 // self.IDVerSSNSourceCount	:= R.attributegroup.attributes.attribute[17].value;
            			 // self.IDVerAddressSourceCount	:= R.attributegroup.attributes.attribute[19].value;
            			 // self.IDVerDOBSourceCount	:= R.attributegroup.attributes.attribute[1].value;
            			 // self.IDVerSSNCreditBureauCount	:= R.attributegroup.attributes.attribute[20].value;
            			 // self.IDVerSSNCreditBureauDelete	:= R.attributegroup.attributes.attribute[21].value;
            			 // self.IDVerAddrCreditBureauCount	:= R.attributegroup.attributes.attribute[22].value;  
            			 // self.SourceRiskLevel	:= R.attributegroup.attributes.attribute[23].value;
            			 // self.SourceFirstReportingIdentity	:= R.attributegroup.attributes.attribute[24].value;
            			 // self.SourceCreditBureau	:= R.attributegroup.attributes.attribute[25].value;
            			 // self.SourceCreditBureauCount	:= R.attributegroup.attributes.attribute[26].value;
            			 // self.SourceCreditBureauAgeOldest	:= R.attributegroup.attributes.attribute[27].value;
            			 // self.SourceCreditBureauAgeNewest	:= R.attributegroup.attributes.attribute[28].value;
            			 // self.SourceCreditBureauAgeChange	:= R.attributegroup.attributes.attribute[29].value;
            			 // self.SourcePublicRecord	:= R.attributegroup.attributes.attribute[30].value;
            			 // self.SourcePublicRecordCount	:= R.attributegroup.attributes.attribute[31].value;
            			 // self.SourcePublicRecordCountYear	:= R.attributegroup.attributes.attribute[32].value;
            			 // self.SourceEducation	:= R.attributegroup.attributes.attribute[33].value;
            			 // self.SourceOccupationalLicense	:= R.attributegroup.attributes.attribute[34].value;
            			 // self.SourceVoterRegistration	:= R.attributegroup.attributes.attribute[35].value;
            			 // self.SourceOnlineDirectory	:= R.attributegroup.attributes.attribute[36].value;
            			 // self.SourceDoNotMail	:= R.attributegroup.attributes.attribute[37].value;
            			 // self.SourceAccidents	:= R.attributegroup.attributes.attribute[38].value;
            			 // self.SourceBusinessRecords	:= R.attributegroup.attributes.attribute[39].value;
            			 // self.SourceProperty	:= R.attributegroup.attributes.attribute[40].value;
            			 // self.SourceAssets	:= R.attributegroup.attributes.attribute[41].value;
            			 // self.SourcePhoneDirectoryAssistance	:= R.attributegroup.attributes.attribute[42].value;
            			 // self.SourcePhoneNonPublicDirectory	:= R.attributegroup.attributes.attribute[43].value;
            			 // self.VariationRiskLevel	:= R.attributegroup.attributes.attribute[44].value;
            			 // self.VariationIdentityCount	:= R.attributegroup.attributes.attribute[45].value;
            			 // self.VariationSSNCount	:= R.attributegroup.attributes.attribute[46].value;
            			 // self.VariationSSNCountNew	:= R.attributegroup.attributes.attribute[47].value;
            			 // self.VariationMSourcesSSNCount	:= R.attributegroup.attributes.attribute[48].value;
            			 // self.VariationMSourcesSSNUnrelCount	:= R.attributegroup.attributes.attribute[49].value;
            			 // self.VariationLastNameCount	:= R.attributegroup.attributes.attribute[50].value;
            			 // self.VariationLastNameCountNew	:= R.attributegroup.attributes.attribute[51].value;
            			 // self.VariationAddrCountYear	:= R.attributegroup.attributes.attribute[52].value;
            			 // self.VariationAddrCountNew	:= R.attributegroup.attributes.attribute[53].value;
            			 // self.VariationAddrStability	:= R.attributegroup.attributes.attribute[54].value;
            			 // self.VariationAddrChangeAge	:= R.attributegroup.attributes.attribute[55].value;
            			 // self.VariationDOBCount	:= R.attributegroup.attributes.attribute[56].value;
            			 // self.VariationDOBCountNew	:= R.attributegroup.attributes.attribute[57].value;
            			 // self.VariationPhoneCount	:= R.attributegroup.attributes.attribute[58].value;
            			 // self.VariationPhoneCountNew	:= R.attributegroup.attributes.attribute[59].value;
            			 // self.VariationSearchSSNCount	:= R.attributegroup.attributes.attribute[60].value;
            			 // self.VariationSearchAddrCount	:= R.attributegroup.attributes.attribute[61].value;
            			 // self.VariationSearchPhoneCount	:= R.attributegroup.attributes.attribute[62].value;
            			 // self.SearchVelocityRiskLevel	:= R.attributegroup.attributes.attribute[63].value;
            			 // self.SearchCount	:= R.attributegroup.attributes.attribute[64].value;
            			 // self.SearchCountYear	:= R.attributegroup.attributes.attribute[65].value;
            			 // self.SearchCountMonth	:= R.attributegroup.attributes.attribute[66].value;
            			 // self.SearchCountWeek	:= R.attributegroup.attributes.attribute[67].value;
            			 // self.SearchCountDay	:= R.attributegroup.attributes.attribute[68].value;
            			 // self.SearchUnverifiedSSNCountYear	:= R.attributegroup.attributes.attribute[69].value;
            			 // self.SearchUnverifiedAddrCountYear	:= R.attributegroup.attributes.attribute[70].value;
            			 // self.SearchUnverifiedDOBCountYear	:= R.attributegroup.attributes.attribute[71].value;
            			 // self.SearchUnverifiedPhoneCountYear	:= R.attributegroup.attributes.attribute[72].value;
            			 // self.SearchBankingSearchCount	:= R.attributegroup.attributes.attribute[73].value;
            			 // self.SearchBankingSearchCountYear	:= R.attributegroup.attributes.attribute[74].value;
            			 // self.SearchBankingSearchCountMonth	:= R.attributegroup.attributes.attribute[75].value;
            			 // self.SearchBankingSearchCountWeek	:= R.attributegroup.attributes.attribute[76].value;
            			 // self.SearchBankingSearchCountDay	:= R.attributegroup.attributes.attribute[77].value;
            			 // self.SearchHighRiskSearchCount	:= R.attributegroup.attributes.attribute[78].value;
            			 // self.SearchHighRiskSearchCountYear	:= R.attributegroup.attributes.attribute[79].value;
            			 // self.SearchHighRiskSearchCountMonth	:= R.attributegroup.attributes.attribute[80].value;
            			 // self.SearchHighRiskSearchCountWeek	:= R.attributegroup.attributes.attribute[81].value;
            			 // self.SearchHighRiskSearchCountDay	:= R.attributegroup.attributes.attribute[82].value;
            			 // self.SearchFraudSearchCount	:= R.attributegroup.attributes.attribute[83].value;
            			 // self.SearchFraudSearchCountYear	:= R.attributegroup.attributes.attribute[84].value;
            			 // self.SearchFraudSearchCountMonth	:= R.attributegroup.attributes.attribute[85].value;
            			 // self.SearchFraudSearchCountWeek	:= R.attributegroup.attributes.attribute[86].value;
            			 // self.SearchFraudSearchCountDay	:= R.attributegroup.attributes.attribute[87].value;
            			 // self.SearchLocateSearchCount	:= R.attributegroup.attributes.attribute[88].value;
            			 // self.SearchLocateSearchCountYear	:= R.attributegroup.attributes.attribute[89].value;
            			 // self.SearchLocateSearchCountMonth	:= R.attributegroup.attributes.attribute[90].value;
            			 // self.SearchLocateSearchCountWeek	:= R.attributegroup.attributes.attribute[91].value;
            			 // self.SearchLocateSearchCountDay	:= R.attributegroup.attributes.attribute[92].value;
            			 // self.AssocRiskLevel	:= R.attributegroup.attributes.attribute[93].value;
            			 // self.AssocCount	:= R.attributegroup.attributes.attribute[94].value;
            			 // self.AssocDistanceClosest	:= R.attributegroup.attributes.attribute[95].value;
            			 // self.AssocSuspicousIdentitiesCount	:= R.attributegroup.attributes.attribute[96].value;
            			 // self.AssocCreditBureauOnlyCount	:= R.attributegroup.attributes.attribute[97].value;
            			 // self.AssocCreditBureauOnlyCountNew	:= R.attributegroup.attributes.attribute[98].value;
            			 // self.AssocCreditBureauOnlyCountMonth	:= R.attributegroup.attributes.attribute[99].value;
            			 // self.AssocHighRiskTopologyCount	:= R.attributegroup.attributes.attribute[100].value;
            			 // self.ValidationRiskLevel	:= R.attributegroup.attributes.attribute[101].value;
            			 // self.ValidationSSNProblems	:= R.attributegroup.attributes.attribute[102].value;
            			 // self.ValidationAddrProblems	:= R.attributegroup.attributes.attribute[103].value;
            			 // self.ValidationPhoneProblems	:= R.attributegroup.attributes.attribute[104].value;
            			 // self.ValidationDLProblems	:= R.attributegroup.attributes.attribute[105].value;
            			 // self.ValidationIPProblems	:= R.attributegroup.attributes.attribute[106].value;
            			 // self.CorrelationRiskLevel	:= R.attributegroup.attributes.attribute[107].value;
            			 // self.CorrelationSSNNameCount	:= R.attributegroup.attributes.attribute[108].value;
            			 // self.CorrelationSSNAddrCount	:= R.attributegroup.attributes.attribute[109].value;
            			 // self.CorrelationAddrNameCount	:= R.attributegroup.attributes.attribute[110].value;
            			 // self.CorrelationAddrPhoneCount	:= R.attributegroup.attributes.attribute[111].value;
            			 // self.CorrelationPhoneLastNameCount	:= R.attributegroup.attributes.attribute[112].value;
            			 // self.DivRiskLevel	:= R.attributegroup.attributes.attribute[113].value;
            			 // self.DivSSNIdentityCount	:= R.attributegroup.attributes.attribute[114].value;
            			 // self.DivSSNIdentityCountNew	:= R.attributegroup.attributes.attribute[115].value;
            			 // self.DivSSNIdentityMSourceCount	:= R.attributegroup.attributes.attribute[116].value;
            			 // self.DivSSNIdentityMSourceUrelCount	:= R.attributegroup.attributes.attribute[117].value;
            			 // self.DivSSNLNameCount	:= R.attributegroup.attributes.attribute[118].value;
            			 // self.DivSSNLNameCountNew	:= R.attributegroup.attributes.attribute[119].value;
            			 // self.DivSSNAddrCount	:= R.attributegroup.attributes.attribute[120].value;
            			 // self.DivSSNAddrCountNew	:= R.attributegroup.attributes.attribute[121].value;
            			 // self.DivSSNAddrMSourceCount	:= R.attributegroup.attributes.attribute[122].value;
            			 // self.DivAddrIdentityCount	:= R.attributegroup.attributes.attribute[123].value;
            			 // self.DivAddrIdentityCountNew	:= R.attributegroup.attributes.attribute[124].value;
            			 // self.DivAddrIdentityMSourceCount	:= R.attributegroup.attributes.attribute[125].value;
            			 // self.DivAddrSuspIdentityCountNew	:= R.attributegroup.attributes.attribute[126].value;
            			 // self.DivAddrSSNCount	:= R.attributegroup.attributes.attribute[127].value;
            			 // self.DivAddrSSNCountNew	:= R.attributegroup.attributes.attribute[128].value;
            			 // self.DivAddrSSNMSourceCount	:= R.attributegroup.attributes.attribute[129].value;
            			 // self.DivAddrPhoneCount	:= R.attributegroup.attributes.attribute[130].value;
            			 // self.DivAddrPhoneCountNew	:= R.attributegroup.attributes.attribute[131].value;
            			 // self.DivAddrPhoneMSourceCount	:= R.attributegroup.attributes.attribute[132].value;
            			 // self.DivPhoneIdentityCount	:= R.attributegroup.attributes.attribute[133].value;
            			 // self.DivPhoneIdentityCountNew	:= R.attributegroup.attributes.attribute[134].value;
            			 // self.DivPhoneIdentityMSourceCount	:= R.attributegroup.attributes.attribute[135].value;
            			 // self.DivPhoneAddrCount	:= R.attributegroup.attributes.attribute[136].value;
            			 // self.DivPhoneAddrCountNew	:= R.attributegroup.attributes.attribute[137].value;
            			 // self.DivSearchSSNIdentityCount	:= R.attributegroup.attributes.attribute[138].value;
            			 // self.DivSearchAddrIdentityCount	:= R.attributegroup.attributes.attribute[139].value;
            			 // self.DivSearchAddrSuspIdentityCount	:= R.attributegroup.attributes.attribute[140].value;
            			 // self.DivSearchPhoneIdentityCount	:= R.attributegroup.attributes.attribute[141].value;
            			 // self.SearchComponentRiskLevel	:= R.attributegroup.attributes.attribute[142].value;
            			 // self.SearchSSNSearchCount	:= R.attributegroup.attributes.attribute[143].value;
            			 // self.SearchSSNSearchCountYear	:= R.attributegroup.attributes.attribute[144].value;
            			 // self.SearchSSNSearchCountMonth	:= R.attributegroup.attributes.attribute[145].value;
            			 // self.SearchSSNSearchCountWeek	:= R.attributegroup.attributes.attribute[146].value;
            			 // self.SearchSSNSearchCountDay	:= R.attributegroup.attributes.attribute[147].value;
            			 // self.SearchAddrSearchCount	:= R.attributegroup.attributes.attribute[148].value;
            			 // self.SearchAddrSearchCountYear	:= R.attributegroup.attributes.attribute[149].value;
            			 // self.SearchAddrSearchCountMonth	:= R.attributegroup.attributes.attribute[150].value;
            			 // self.SearchAddrSearchCountWeek	:= R.attributegroup.attributes.attribute[151].value;
            			 // self.SearchAddrSearchCountDay	:= R.attributegroup.attributes.attribute[152].value;
            			 // self.SearchPhoneSearchCount	:= R.attributegroup.attributes.attribute[153].value;
            			 // self.SearchPhoneSearchCountYear	:= R.attributegroup.attributes.attribute[154].value;
            			 // self.SearchPhoneSearchCountMonth	:= R.attributegroup.attributes.attribute[155].value;
            			 // self.SearchPhoneSearchCountWeek	:= R.attributegroup.attributes.attribute[156].value;
            			 // self.SearchPhoneSearchCountDay	:= R.attributegroup.attributes.attribute[157].value;
            			 // self.ComponentCharRiskLevel	:= R.attributegroup.attributes.attribute[158].value;
            			 // self.SSNHighIssueAge	:= R.attributegroup.attributes.attribute[159].value;
            			 // self.SSNLowIssueAge	:= R.attributegroup.attributes.attribute[160].value;
            			 // self.SSNIssueState	:= R.attributegroup.attributes.attribute[161].value;
            			 // self.SSNNonUS	:= R.attributegroup.attributes.attribute[162].value;
            			 // self.InputPhoneType	:= R.attributegroup.attributes.attribute[163].value;
            			 // self.IPState	:= R.attributegroup.attributes.attribute[164].value;
            			 // self.IPCountry	:= R.attributegroup.attributes.attribute[165].value;
            			 // self.IPContinent	:= R.attributegroup.attributes.attribute[166].value;
            			 // self.InputAddrAgeOldest	:= R.attributegroup.attributes.attribute[167].value;
            			 // self.InputAddrAgeNewest	:= R.attributegroup.attributes.attribute[168].value;
            			 // self.InputAddrType	:= R.attributegroup.attributes.attribute[169].value;
            			 // self.InputAddrLenOfRes	:= R.attributegroup.attributes.attribute[170].value;
            			 // self.InputAddrDwellType	:= R.attributegroup.attributes.attribute[171].value;
            			 // self.InputAddrDelivery	:= R.attributegroup.attributes.attribute[172].value;
            			 // self.InputAddrActivePhoneList	:= R.attributegroup.attributes.attribute[173].value;
            			 // self.InputAddrOccupantOwned	:= R.attributegroup.attributes.attribute[174].value;
            			 // self.InputAddrBusinessCount	:= R.attributegroup.attributes.attribute[175].value;
            			 // self.InputAddrNBRHDBusinessCount	:= R.attributegroup.attributes.attribute[176].value;
            			 // self.InputAddrNBRHDSingleFamilyCount	:= R.attributegroup.attributes.attribute[177].value;
            			 // self.InputAddrNBRHDMultiFamilyCount	:= R.attributegroup.attributes.attribute[178].value;
            			 // self.InputAddrNBRHDMedianIncome	:= R.attributegroup.attributes.attribute[179].value;
            			 // self.InputAddrNBRHDMedianValue	:= R.attributegroup.attributes.attribute[180].value;
            			 // self.InputAddrNBRHDMurderIndex	:= R.attributegroup.attributes.attribute[181].value;
            			 // self.InputAddrNBRHDCarTheftIndex	:= R.attributegroup.attributes.attribute[182].value;
            			 // self.InputAddrNBRHDBurglaryIndex	:= R.attributegroup.attributes.attribute[183].value;
            			 // self.InputAddrNBRHDCrimeIndex	:= R.attributegroup.attributes.attribute[184].value;
            			 // self.InputAddrNBRHDMobilityIndex	:= R.attributegroup.attributes.attribute[185].value;
            			 // self.InputAddrNBRHDVacantPropCount	:= R.attributegroup.attributes.attribute[186].value;
            			 // self.AddrChangeDistance	:= R.attributegroup.attributes.attribute[187].value;
            			 // self.AddrChangeStateDiff	:= R.attributegroup.attributes.attribute[188].value;
            			 // self.AddrChangeIncomeDiff	:= R.attributegroup.attributes.attribute[189].value;
            			 // self.AddrChangeValueDiff	:= R.attributegroup.attributes.attribute[190].value;
            			 // self.AddrChangeCrimeDiff	:= R.attributegroup.attributes.attribute[191].value;
            			 // self.AddrChangeEconTrajectory	:= R.attributegroup.attributes.attribute[192].value;
            			 // self.AddrChangeEconTrajectoryIndex	:= R.attributegroup.attributes.attribute[193].value;
            			 // self.CurrAddrAgeOldest	:= R.attributegroup.attributes.attribute[194].value;
            			 // self.CurrAddrAgeNewest	:= R.attributegroup.attributes.attribute[195].value;
            			 // self.CurrAddrLenOfRes	:= R.attributegroup.attributes.attribute[196].value;
            			 // self.CurrAddrDwellType	:= R.attributegroup.attributes.attribute[197].value;
            			 // self.CurrAddrStatus	:= R.attributegroup.attributes.attribute[198].value;
            			 // self.CurrAddrActivePhoneList	:= R.attributegroup.attributes.attribute[199].value;
            			 // self.CurrAddrMedianIncome	:= R.attributegroup.attributes.attribute[200].value;
            			 // self.CurrAddrMedianValue	:= R.attributegroup.attributes.attribute[201].value;
            			 // self.CurrAddrMurderIndex	:= R.attributegroup.attributes.attribute[202].value;
            			 // self.CurrAddrCarTheftIndex	:= R.attributegroup.attributes.attribute[203].value;
            			 // self.CurrAddrBurglaryIndex	:= R.attributegroup.attributes.attribute[204].value;
            			 // self.CurrAddrCrimeIndex	:= R.attributegroup.attributes.attribute[205].value;
            			 // self.PrevAddrAgeOldest	:= R.attributegroup.attributes.attribute[206].value;
            			 // self.PrevAddrAgeNewest	:= R.attributegroup.attributes.attribute[207].value;
            			 // self.PrevAddrLenOfRes	:= R.attributegroup.attributes.attribute[208].value;
            			 // self.PrevAddrDwellType	:= R.attributegroup.attributes.attribute[209].value;
            			 // self.PrevAddrStatus	:= R.attributegroup.attributes.attribute[210].value;
            			 // self.PrevAddrOccupantOwned	:= R.attributegroup.attributes.attribute[211].value;
            			 // self.PrevAddrMedianIncome	:= R.attributegroup.attributes.attribute[212].value;
            			 // self.PrevAddrMedianValue	:= R.attributegroup.attributes.attribute[213].value;
            			 // self.PrevAddrMurderIndex	:= R.attributegroup.attributes.attribute[214].value;
            			 // self.PrevAddrCarTheftIndex	:= R.attributegroup.attributes.attribute[215].value;
            			 // self.PrevAddrBurglaryIndex	:= R.attributegroup.attributes.attribute[216].value;
            			 // self.PrevAddrCrimeIndex	:= R.attributegroup.attributes.attribute[217].value;
            			 self.accountnumber := l.accountnumber; 
            			 self.DID := (integer)l.input.did; 
            			 self.fp_score := L.scores[1].i;
            			 self.fp_reason := L.scores[1].reason_codes[1].reason_code;
            			 self.fp_reason2 := L.scores[1].reason_codes[2].reason_code;
            			 self.fp_reason3 := L.scores[1].reason_codes[3].reason_code;
            			 self.fp_reason4 := L.scores[1].reason_codes[4].reason_code;
            			 self.fp_reason5 := L.scores[1].reason_codes[5].reason_code;
            			 self.fp_reason6 := L.scores[1].reason_codes[6].reason_code;
            			 self.StolenIdentityIndex        := L.scores[1].StolenIdentityIndex;
            			 self.SyntheticIdentityIndex     := L.scores[1].SyntheticIdentityIndex;
            			 self.ManipulatedIdentityIndex   := L.scores[1].ManipulatedIdentityIndex;
            			 self.VulnerableVictimIndex      := L.scores[1].VulnerableVictimIndex;
            			 self.FriendlyFraudIndex         := L.scores[1].FriendlyFraudIndex;
            			 self.SuspiciousActivityIndex    := L.scores[1].SuspiciousActivityIndex;
            			 self.errorcode    := l.errorcode;
   							   self.historydate := (string)r.HistoryDateYYYYMM;
            			 self.FNamePop := r.firstname<>'';
            			 self.LNamePop := r.lastname<>'';
            			 self.AddrPop := r.streetaddress<>'';
            			 self.SSNLength := (string)(length(trim(r.ssn,left,right))) ;
            			 self.DOBPop := r.dateofbirth<>'';
            			 self.EmailPop := r.email<>'';
            			 self.IPAddrPop := r.ipaddress<>'';
            			 self.HPhnPop := r.homephone<>'';
   							   self := L;
            			 self := [];
            		End;
            			
            		ds_output_plus_input := join(soap_output_withDID,soap_in, LEFT.accountnumber=RIGHT.accountnumber, trans_flatten(Left, Right));  //this transform joins the soap output with the input file
      					
      					
            		// Global_output_lay v2_trans(Global_output_lay L, soap_in R) := TRANSFORM
            			 // self.AccountNumber := L.accountnumber;
            			 // self.historydate := (string)r.HistoryDateYYYYMM;
            			 // self.FNamePop := r.firstname<>'';
            			 // self.LNamePop := r.lastname<>'';
            			 // self.AddrPop := r.streetaddress<>'';
            			 // self.SSNLength := (string)(length(trim(r.ssn,left,right))) ;
            			 // self.DOBPop := r.dateofbirth<>'';
            			 // self.EmailPop := r.email<>'';
            			 // self.IPAddrPop := r.ipaddress<>'';
            			 // self.HPhnPop := r.homephone<>'';
            			 // self := l;
            		// END;
      
         			 
         		 // ds_output_plus_input := JOIN(soap_output_flatten, soap_in,LEFT.accountnumber=RIGHT.accountnumber, v2_trans(LEFT,RIGHT));
         			 
             ds_output_plus_input_sorted := group(sort(ds_output_plus_input, accountnumber), accountnumber);
         			 
         	  dedup_ds_output_plus_input_sorted := dedup(ds_output_plus_input_sorted, accountnumber);
						
						projected_acctno := project(dedup_ds_output_plus_input_sorted, transform(Global_output_lay,self.acctno:=left.accountnumber;self:=left));
             // final file out to thor
         		final_output :=   output(projected_acctno,, Output_file_name, thor, compressed, overwrite );
         			 
   
	  RETURN final_output;

ENDMACRO;
