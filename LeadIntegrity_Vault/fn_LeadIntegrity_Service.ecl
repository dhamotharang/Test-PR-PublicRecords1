#workunit('name','Lead Integrity Attributes');
#option ('hthorMemoryLimit', 1000);

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, LeadIntegrity_Vault_Layout, LeadIntegrity_Vault, LeadIntegrity_Vault.Constants, ADDRESS;

/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/

EXPORT fn_LeadIntegrity_Service (STRING8 date_in, STRING part_nbr, STRING filename, STRING outputFileName) := FUNCTION

		recordsToRun := 0;
		eyeball := 50;

		version := Constants.version;
		threads := Constants.threads;
		roxieIP := Constants.roxieIP;
		// roxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie; // Production
		// roxieIP := RiskWise.shortcuts.prod_batch_neutral; // Production
		// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

		inputFile := filename;
		outputFile := outputFileName;

		//  Reads in the input file created by Melissas process
		f_inp := DATASET(inputFile, LeadIntegrity_Vault_Layout.Layout_LeadIntegrity_Inlayout, CSV);

		//  Does a transform into the layout needed by the LI service call
		// f_inp := project(input_ds, transform(LeadIntegrity_Vault_Layout.Layout_LeadIntegrity_Service_Input,
					// SELF.seq	:= left.seq;
					// self.lexid := left.lexid;
					// self.ssn  :=  left.ssn;
					// self.name_first := left.name_first;
					// self.name_middle := left.name_middle;
					// self.name_last := left.name_last;
					// self.name_suffix := left.name_suffix;
					// self.dob := left.dob;
					// self.p_city_name := left.p_city_name;
					// self.st := left.st;
					// self.z5 := left.z5;
					// self.dl_number := left.dl_number;
					// self.dl_state := left.dl_state;
					// self := []));

		// f_inp := DATASET(LI_input, layout_leadinteg_service_input, csv);
		// f_all := PROJECT(f_inp,TRANSFORM(inlayout_did,SELF.did:=LEFT.lexid,SELF:=LEFT));
		// f := IF(recordsToRun = 0, f_all, CHOOSEN(f_all, recordsToRun))(did=5898098);
		f := IF(recordsToRun = 0, f_inp, CHOOSEN(f_inp, recordsToRun));
		//OUTPUT(CHOOSEN(f, eyeball), NAMED('customer_file'));

		leadintegrity_soap_layout := record
			dataset(Models.layouts.Layout_LeadIntegrity_Batch_In) batch_in;
			integer DPPAPurpose;
			integer GLBPurpose;
			string DataRestrictionMask;
			string DataPermissionMask;
			string ModelName;
			integer Version;
		end;

		LeadIntegrity_input := project(f, transform(leadintegrity_soap_layout,
			
			SELF.BATCH_IN := PROJECT(LEFT, TRANSFORM(Models.layouts.Layout_LeadIntegrity_Batch_In, 
											// SELF.ACCTNO := (STRING)LEFT.SEQ;
											SELF.HISTORYDATEYYYYMM := 999999;
											// SELF.STREET_ADDR := ADDRESS.Addr1FromComponents(LEFT.PRIM_RANGE, LEFT.PREDIR, LEFT.PRIM_NAME,
													// LEFT.SUFFIX, LEFT.POSTDIR, LEFT.UNIT_DESIG, LEFT.SEC_RANGE);
											SELF := LEFT;
											SELF := []));

			SELF.VERSION := VERSION;
			
				
			// SETTINGS TO MATCH BATCH R3 KTR SETTINGS
			SELF.DataRestrictionMask := '0000000000000101000000000000000000000000';
			SELF.DataPermissionMask := '000000000000000000000000000000'; 
			SELF.DPPAPurpose := 0;
			SELF.GLBPurpose := 6;
			SELF.MODELNAME := 'msn1106_0';
		));

		//OUTPUT(CHOOSEN(LEADINTEGRITY_INPUT,EYEBALL), NAMED('LEADINTEGRITY_INPUT'));

		// Now run the LeadIntegrity attributes
		LeadIntegrityoutput := RECORD
			unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
			Models.layouts.layout_LeadIntegrity_attributes_batch_flattened;
			STRING errorcode;
		END;

		LeadIntegrityoutput myFail(LeadIntegrity_input le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF := le;
			SELF := [];
		END;

		LeadIntegrity_attributes := SOAPCALL(LeadIntegrity_input, roxieIP,
						'Models.LeadIntegrity_Batch_Service', {LeadIntegrity_input}, 
						DATASET(LeadIntegrityoutput),
						RETRY(5),
						PARALLEL(threads), onFail(myFail(LEFT)));
						
		//OUTPUT(CHOOSEN(LeadIntegrity_attributes(errorcode=''), eyeball), NAMED('LeadIntegrity_results'));
		//OUTPUT(CHOOSEN(LeadIntegrity_attributes(errorcode<>''), eyeball), NAMED('LeadIntegrity_errors'));
		
		Layout_LeadIntegrity_Layout_Slimmed := LeadIntegrity_Vault_Layout.Layout_LeadIntegrity_Layout_Slimmed;
		
		Layout_LeadIntegrity_Layout_Slimmed slim_v4( LeadIntegrity_attributes le ) := TRANSFORM
		self.AccountNumber	:= le.Acctno	;
		// self.Seq := (Integer)le.Seq;
		self.AgeOldestRecord	:= le.v4_AgeOldestRecord	;
		self.AgeNewestRecord	:= le.v4_AgeNewestRecord	;
		self.RecentUpdate	:= le.v4_RecentUpdate	;
		self.SrcsConfirmIDAddrCount	:= le.v4_SrcsConfirmIDAddrCount	;
		self.CreditBureauRecord	:= le.v4_CreditBureauRecord	;
		self.VerificationFailure	:= le.v4_VerificationFailure	;
		self.SSNNotFound	:= le.v4_SSNNotFound	;
		self.SSNFoundOther	:= le.v4_SSNFoundOther	;
		self.VerifiedName	:= le.v4_VerifiedName	;
		self.VerifiedSSN	:= le.v4_VerifiedSSN	;
		self.VerifiedPhone	:= le.v4_VerifiedPhone	;
		self.VerifiedAddress	:= le.v4_VerifiedAddress	;
		self.VerifiedDOB	:= le.v4_VerifiedDOB	;
		self.AgeRiskIndicator	:= le.v4_AgeRiskIndicator	;
		self.SubjectSSNCount	:= le.v4_SubjectSSNCount	;
		self.SubjectAddrCount	:= le.v4_SubjectAddrCount	;
		self.SubjectPhoneCount	:= le.v4_SubjectPhoneCount	;
		self.SubjectSSNRecentCount	:= le.v4_SubjectSSNRecentCount	;
		self.SubjectAddrRecentCount	:= le.v4_SubjectAddrRecentCount	;
		self.SubjectPhoneRecentCount	:= le.v4_SubjectPhoneRecentCount	;
		self.SSNIdentitiesCount	:= le.v4_SSNIdentitiesCount	;
		self.SSNAddrCount	:= le.v4_SSNAddrCount	;
		self.SSNIdentitiesRecentCount	:= le.v4_SSNIdentitiesRecentCount	;
		self.SSNAddrRecentCount	:= le.v4_SSNAddrRecentCount	;
		self.InputAddrPhoneCount	:= le.v4_InputAddrPhoneCount	;
		self.InputAddrPhoneRecentCount	:= le.v4_InputAddrPhoneRecentCount	;
		self.PhoneIdentitiesCount	:= le.v4_PhoneIdentitiesCount	;
		self.PhoneIdentitiesRecentCount	:= le.v4_PhoneIdentitiesRecentCount	;
		self.PhoneOther	:= le.v4_PhoneOther	;
		self.SSNLastNameCount	:= le.v4_SSNLastNameCount	;
		self.SubjectLastNameCount	:= le.v4_SubjectLastNameCount	;
		self.LastNameChangeAge	:= le.v4_LastNameChangeAge	;
		self.LastNameChangeCount01	:= le.v4_LastNameChangeCount01	;
		self.LastNameChangeCount03	:= le.v4_LastNameChangeCount03	;
		self.LastNameChangeCount06	:= le.v4_LastNameChangeCount06	;
		self.LastNameChangeCount12	:= le.v4_LastNameChangeCount12	;
		self.LastNameChangeCount24	:= le.v4_LastNameChangeCount24	;
		self.LastNameChangeCount60	:= le.v4_LastNameChangeCount60	;
		self.SFDUAddrIdentitiesCount	:= le.v4_SFDUAddrIdentitiesCount	;
		self.SFDUAddrSSNCount	:= le.v4_SFDUAddrSSNCount	;
		self.SSNAgeDeceased	:= le.v4_SSNAgeDeceased	;
		self.SSNRecent	:= le.v4_SSNRecent	;
		self.SSNLowIssueAge	:= le.v4_SSNLowIssueAge	;
		self.SSNHighIssueAge	:= le.v4_SSNHighIssueAge	;
		self.SSNIssueState	:= le.v4_SSNIssueState	;
		self.SSNNonUS	:= le.v4_SSNNonUS	;
		self.SSN3Years	:= le.v4_SSN3Years	;
		self.SSNAfter5	:= le.v4_SSNAfter5	;
		self.SSNProblems	:= le.v4_SSNProblems	;
		self.RelativesCount	:= le.v4_RelativesCount	;
		self.RelativesBankruptcyCount	:= le.v4_RelativesBankruptcyCount	;
		self.RelativesFelonyCount	:= le.v4_RelativesFelonyCount	;
		self.RelativesPropOwnedCount	:= le.v4_RelativesPropOwnedCount	;
		self.RelativesPropOwnedTaxTotal	:= le.v4_RelativesPropOwnedTaxTotal	;
		self.RelativesDistanceClosest	:= le.v4_RelativesDistanceClosest	;
		self.InputAddrAgeOldestRecord	:= le.v4_InputAddrAgeOldestRecord	;
		self.InputAddrAgeNewestRecord	:= le.v4_InputAddrAgeNewestRecord	;
		self.InputAddrHistoricalMatch	:= le.v4_InputAddrHistoricalMatch	;
		self.InputAddrLenOfRes	:= le.v4_InputAddrLenOfRes	;
		self.InputAddrDwellType	:= le.v4_InputAddrDwellType	;
		self.InputAddrDelivery	:= le.v4_InputAddrDelivery	;
		self.InputAddrApplicantOwned	:= le.v4_InputAddrApplicantOwned	;
		self.InputAddrFamilyOwned	:= le.v4_InputAddrFamilyOwned	;
		self.InputAddrOccupantOwned	:= le.v4_InputAddrOccupantOwned	;
		self.InputAddrAgeLastSale	:= le.v4_InputAddrAgeLastSale	;
		self.InputAddrLastSalesPrice	:= le.v4_InputAddrLastSalesPrice	;
		self.InputAddrMortgageType	:= le.v4_InputAddrMortgageType	;
		self.InputAddrNotPrimaryRes	:= le.v4_InputAddrNotPrimaryRes	;
		self.InputAddrActivePhoneList	:= le.v4_InputAddrActivePhoneList	;
		self.InputAddrTaxValue	:= le.v4_InputAddrTaxValue	;
		self.InputAddrTaxYr	:= le.v4_InputAddrTaxYr	;
		self.InputAddrTaxMarketValue	:= le.v4_InputAddrTaxMarketValue	;
		self.InputAddrAVMValue	:= le.v4_InputAddrAVMValue	;
		self.InputAddrAVMValue12	:= le.v4_InputAddrAVMValue12	;
		self.InputAddrAVMValue60	:= le.v4_InputAddrAVMValue60	;
		self.InputAddrCountyIndex	:= le.v4_InputAddrCountyIndex	;
		self.InputAddrTractIndex	:= le.v4_InputAddrTractIndex	;
		self.InputAddrBlockIndex	:= le.v4_InputAddrBlockIndex	;
		self.InputAddrMedianIncome	:= le.v4_InputAddrMedianIncome	;
		self.InputAddrMedianValue	:= le.v4_InputAddrMedianValue	;
		self.InputAddrMurderIndex	:= le.v4_InputAddrMurderIndex	;
		self.InputAddrCarTheftIndex	:= le.v4_InputAddrCarTheftIndex	;
		self.InputAddrBurglaryIndex	:= le.v4_InputAddrBurglaryIndex	;
		self.InputAddrCrimeIndex	:= le.v4_InputAddrCrimeIndex	;
		self.InputAddrMobilityIndex	:= le.v4_InputAddrMobilityIndex	;
		self.InputAddrVacantPropCount	:= le.v4_InputAddrVacantPropCount	;
		self.InputAddrBusinessCount	:= le.v4_InputAddrBusinessCount	;
		self.InputAddrSingleFamilyCount	:= le.v4_InputAddrSingleFamilyCount	;
		self.InputAddrMultiFamilyCount	:= le.v4_InputAddrMultiFamilyCount	;
		self.CurrAddrAgeOldestRecord	:= le.v4_CurrAddrAgeOldestRecord	;
		self.CurrAddrAgeNewestRecord	:= le.v4_CurrAddrAgeNewestRecord	;
		self.CurrAddrLenOfRes	:= le.v4_CurrAddrLenOfRes	;
		self.CurrAddrDwellType	:= le.v4_CurrAddrDwellType	;
		self.CurrAddrApplicantOwned	:= le.v4_CurrAddrApplicantOwned	;
		self.CurrAddrFamilyOwned	:= le.v4_CurrAddrFamilyOwned	;
		self.CurrAddrOccupantOwned	:= le.v4_CurrAddrOccupantOwned	;
		self.CurrAddrAgeLastSale	:= le.v4_CurrAddrAgeLastSale	;
		self.CurrAddrLastSalesPrice	:= le.v4_CurrAddrLastSalesPrice	;
		self.CurrAddrMortgageType	:= le.v4_CurrAddrMortgageType	;
		self.CurrAddrActivePhoneList	:= le.v4_CurrAddrActivePhoneList	;
		self.CurrAddrTaxValue	:= le.v4_CurrAddrTaxValue	;
		self.CurrAddrTaxYr	:= le.v4_CurrAddrTaxYr	;
		self.CurrAddrTaxMarketValue	:= le.v4_CurrAddrTaxMarketValue	;
		self.CurrAddrAVMValue	:= le.v4_CurrAddrAVMValue	;
		self.CurrAddrAVMValue12	:= le.v4_CurrAddrAVMValue12	;
		self.CurrAddrAVMValue60	:= le.v4_CurrAddrAVMValue60	;
		self.CurrAddrCountyIndex	:= le.v4_CurrAddrCountyIndex	;
		self.CurrAddrTractIndex	:= le.v4_CurrAddrTractIndex	;
		self.CurrAddrBlockIndex	:= le.v4_CurrAddrBlockIndex	;
		self.CurrAddrMedianIncome	:= le.v4_CurrAddrMedianIncome	;
		self.CurrAddrMedianValue	:= le.v4_CurrAddrMedianValue	;
		self.CurrAddrMurderIndex	:= le.v4_CurrAddrMurderIndex	;
		self.CurrAddrCarTheftIndex	:= le.v4_CurrAddrCarTheftIndex	;
		self.CurrAddrBurglaryIndex	:= le.v4_CurrAddrBurglaryIndex	;
		self.CurrAddrCrimeIndex	:= le.v4_CurrAddrCrimeIndex	;
		self.PrevAddrAgeOldestRecord	:= le.v4_PrevAddrAgeOldestRecord	;
		self.PrevAddrAgeNewestRecord	:= le.v4_PrevAddrAgeNewestRecord	;
		self.PrevAddrLenOfRes	:= le.v4_PrevAddrLenOfRes	;
		self.PrevAddrDwellType	:= le.v4_PrevAddrDwellType	;
		self.PrevAddrApplicantOwned	:= le.v4_PrevAddrApplicantOwned	;
		self.PrevAddrFamilyOwned	:= le.v4_PrevAddrFamilyOwned	;
		self.PrevAddrOccupantOwned	:= le.v4_PrevAddrOccupantOwned	;
		self.PrevAddrAgeLastSale	:= le.v4_PrevAddrAgeLastSale	;
		self.PrevAddrLastSalesPrice	:= le.v4_PrevAddrLastSalesPrice	;
		self.PrevAddrTaxValue	:= le.v4_PrevAddrTaxValue	;
		self.PrevAddrTaxYr	:= le.v4_PrevAddrTaxYr	;
		self.PrevAddrTaxMarketValue	:= le.v4_PrevAddrTaxMarketValue	;
		self.PrevAddrAVMValue	:= le.v4_PrevAddrAVMValue	;
		self.PrevAddrCountyIndex	:= le.v4_PrevAddrCountyIndex	;
		self.PrevAddrTractIndex	:= le.v4_PrevAddrTractIndex	;
		self.PrevAddrBlockIndex	:= le.v4_PrevAddrBlockIndex	;
		self.PrevAddrMedianIncome	:= le.v4_PrevAddrMedianIncome	;
		self.PrevAddrMedianValue	:= le.v4_PrevAddrMedianValue	;
		self.PrevAddrMurderIndex	:= le.v4_PrevAddrMurderIndex	;
		self.PrevAddrCarTheftIndex	:= le.v4_PrevAddrCarTheftIndex	;
		self.PrevAddrBurglaryIndex	:= le.v4_PrevAddrBurglaryIndex	;
		self.PrevAddrCrimeIndex	:= le.v4_PrevAddrCrimeIndex	;
		self.AddrMostRecentDistance	:= le.v4_AddrMostRecentDistance	;
		self.AddrMostRecentStateDiff	:= le.v4_AddrMostRecentStateDiff	;
		self.AddrMostRecentTaxDiff	:= le.v4_AddrMostRecentTaxDiff	;
		self.AddrMostRecentMoveAge	:= le.v4_AddrMostRecentMoveAge	;
		self.AddrMostRecentIncomeDiff	:= le.v4_AddrMostRecentIncomeDiff	;
		self.AddrMostRecentValueDIff	:= le.v4_AddrMostRecentValueDIff	;
		self.AddrMostRecentCrimeDiff	:= le.v4_AddrMostRecentCrimeDiff	;
		self.AddrRecentEconTrajectory	:= le.v4_AddrRecentEconTrajectory	;
		self.AddrRecentEconTrajectoryIndex	:= le.v4_AddrRecentEconTrajectoryIndex	;
		self.EducationAttendedCollege	:= le.v4_EducationAttendedCollege	;
		self.EducationProgram2Yr	:= le.v4_EducationProgram2Yr	;
		self.EducationProgram4Yr	:= le.v4_EducationProgram4Yr	;
		self.EducationProgramGraduate	:= le.v4_EducationProgramGraduate	;
		self.EducationInstitutionPrivate	:= le.v4_EducationInstitutionPrivate	;
		self.EducationInstitutionRating	:= le.v4_EducationInstitutionRating	;
		self.EducationFieldofStudyType	:= le.v4_EducationFieldofStudyType	;
		self.AddrStability	:= le.v4_AddrStability	;
		self.StatusMostRecent	:= le.v4_StatusMostRecent	;
		self.StatusPrevious	:= le.v4_StatusPrevious	;
		self.StatusNextPrevious	:= le.v4_StatusNextPrevious	;
		self.AddrChangeCount01	:= le.v4_AddrChangeCount01	;
		self.AddrChangeCount03	:= le.v4_AddrChangeCount03	;
		self.AddrChangeCount06	:= le.v4_AddrChangeCount06	;
		self.AddrChangeCount12	:= le.v4_AddrChangeCount12	;
		self.AddrChangeCount24	:= le.v4_AddrChangeCount24	;
		self.AddrChangeCount60	:= le.v4_AddrChangeCount60	;
		self.EstimatedAnnualIncome	:= le.v4_EstimatedAnnualIncome	;
		self.AssetOwner	:= le.v4_AssetOwner	;
		self.PropertyOwner	:= le.v4_PropertyOwner	;
		self.PropOwnedCount	:= le.v4_PropOwnedCount	;
		self.PropOwnedTaxTotal	:= le.v4_PropOwnedTaxTotal	;
		self.PropOwnedHistoricalCount	:= le.v4_PropOwnedHistoricalCount	;
		self.PropAgeOldestPurchase	:= le.v4_PropAgeOldestPurchase	;
		self.PropAgeNewestPurchase	:= le.v4_PropAgeNewestPurchase	;
		self.PropAgeNewestSale	:= le.v4_PropAgeNewestSale	;
		self.PropNewestSalePrice	:= le.v4_PropNewestSalePrice	;
		self.PropNewestSalePurchaseIndex	:= le.v4_PropNewestSalePurchaseIndex	;
		self.PropPurchasedCount01	:= le.v4_PropPurchasedCount01	;
		self.PropPurchasedCount03	:= le.v4_PropPurchasedCount03	;
		self.PropPurchasedCount06	:= le.v4_PropPurchasedCount06	;
		self.PropPurchasedCount12	:= le.v4_PropPurchasedCount12	;
		self.PropPurchasedCount24	:= le.v4_PropPurchasedCount24	;
		self.PropPurchasedCount60	:= le.v4_PropPurchasedCount60	;
		self.PropSoldCount01	:= le.v4_PropSoldCount01	;
		self.PropSoldCount03	:= le.v4_PropSoldCount03	;
		self.PropSoldCount06	:= le.v4_PropSoldCount06	;
		self.PropSoldCount12	:= le.v4_PropSoldCount12	;
		self.PropSoldCount24	:= le.v4_PropSoldCount24	;
		self.PropSoldCount60	:= le.v4_PropSoldCount60	;
		self.WatercraftOwner	:= le.v4_WatercraftOwner	;
		self.WatercraftCount	:= le.v4_WatercraftCount	;
		self.WatercraftCount01	:= le.v4_WatercraftCount01	;
		self.WatercraftCount03	:= le.v4_WatercraftCount03	;
		self.WatercraftCount06	:= le.v4_WatercraftCount06	;
		self.WatercraftCount12	:= le.v4_WatercraftCount12	;
		self.WatercraftCount24	:= le.v4_WatercraftCount24	;
		self.WatercraftCount60	:= le.v4_WatercraftCount60	;
		self.AircraftOwner	:= le.v4_AircraftOwner	;
		self.AircraftCount	:= le.v4_AircraftCount	;
		self.AircraftCount01	:= le.v4_AircraftCount01	;
		self.AircraftCount03	:= le.v4_AircraftCount03	;
		self.AircraftCount06	:= le.v4_AircraftCount06	;
		self.AircraftCount12	:= le.v4_AircraftCount12	;
		self.AircraftCount24	:= le.v4_AircraftCount24	;
		self.AircraftCount60	:= le.v4_AircraftCount60	;
		self.WealthIndex	:= le.v4_WealthIndex	;
		self.BusinessActiveAssociation	:= le.v4_BusinessActiveAssociation	;
		self.BusinessInactiveAssociation	:= le.v4_BusinessInactiveAssociation	;
		self.BusinessAssociationAge	:= le.v4_BusinessAssociationAge	;
		self.BusinessTitle	:= le.v4_BusinessTitle	;
		self.BusinessInputAddrCount	:= le.v4_BusinessInputAddrCount	;
		self.DerogSeverityIndex	:= le.v4_DerogSeverityIndex	;
		self.DerogCount	:= le.v4_DerogCount	;
		self.DerogRecentCount	:= le.v4_DerogRecentCount	;
		self.DerogAge	:= le.v4_DerogAge	;
		self.FelonyCount	:= le.v4_FelonyCount	;
		self.FelonyAge	:= le.v4_FelonyAge	;
		self.FelonyCount01	:= le.v4_FelonyCount01	;
		self.FelonyCount03	:= le.v4_FelonyCount03	;
		self.FelonyCount06	:= le.v4_FelonyCount06	;
		self.FelonyCount12	:= le.v4_FelonyCount12	;
		self.FelonyCount24	:= le.v4_FelonyCount24	;
		self.FelonyCount60	:= le.v4_FelonyCount60	;
		self.ArrestCount	:= le.v4_ArrestCount	;
		self.ArrestAge	:= le.v4_ArrestAge	;
		self.ArrestCount01	:= le.v4_ArrestCount01	;
		self.ArrestCount03	:= le.v4_ArrestCount03	;
		self.ArrestCount06	:= le.v4_ArrestCount06	;
		self.ArrestCount12	:= le.v4_ArrestCount12	;
		self.ArrestCount24	:= le.v4_ArrestCount24	;
		self.ArrestCount60	:= le.v4_ArrestCount60	;
		self.LienCount	:= le.v4_LienCount	;
		self.LienFiledCount	:= le.v4_LienFiledCount	;
		self.LienFiledTotal	:= le.v4_LienFiledTotal	;
		self.LienFiledAge	:= le.v4_LienFiledAge	;
		self.LienFiledCount01	:= le.v4_LienFiledCount01	;
		self.LienFiledCount03	:= le.v4_LienFiledCount03	;
		self.LienFiledCount06	:= le.v4_LienFiledCount06	;
		self.LienFiledCount12	:= le.v4_LienFiledCount12	;
		self.LienFiledCount24	:= le.v4_LienFiledCount24	;
		self.LienFiledCount60	:= le.v4_LienFiledCount60	;
		self.LienReleasedCount	:= le.v4_LienReleasedCount	;
		self.LienReleasedTotal	:= le.v4_LienReleasedTotal	;
		self.LienReleasedAge	:= le.v4_LienReleasedAge	;
		self.LienReleasedCount01	:= le.v4_LienReleasedCount01	;
		self.LienReleasedCount03	:= le.v4_LienReleasedCount03	;
		self.LienReleasedCount06	:= le.v4_LienReleasedCount06	;
		self.LienReleasedCount12	:= le.v4_LienReleasedCount12	;
		self.LienReleasedCount24	:= le.v4_LienReleasedCount24	;
		self.LienReleasedCount60	:= le.v4_LienReleasedCount60	;
		self.BankruptcyCount	:= le.v4_BankruptcyCount	;
		self.BankruptcyAge	:= le.v4_BankruptcyAge	;
		self.BankruptcyType	:= le.v4_BankruptcyType	;
		self.BankruptcyStatus	:= le.v4_BankruptcyStatus	;
		self.BankruptcyCount01	:= le.v4_BankruptcyCount01	;
		self.BankruptcyCount03	:= le.v4_BankruptcyCount03	;
		self.BankruptcyCount06	:= le.v4_BankruptcyCount06	;
		self.BankruptcyCount12	:= le.v4_BankruptcyCount12	;
		self.BankruptcyCount24	:= le.v4_BankruptcyCount24	;
		self.BankruptcyCount60	:= le.v4_BankruptcyCount60	;
		self.EvictionCount	:= le.v4_EvictionCount	;
		self.EvictionAge	:= le.v4_EvictionAge	;
		self.EvictionCount01	:= le.v4_EvictionCount01	;
		self.EvictionCount03	:= le.v4_EvictionCount03	;
		self.EvictionCount06	:= le.v4_EvictionCount06	;
		self.EvictionCount12	:= le.v4_EvictionCount12	;
		self.EvictionCount24	:= le.v4_EvictionCount24	;
		self.EvictionCount60	:= le.v4_EvictionCount60	;
		self.AccidentCount	:= le.v4_AccidentCount	;
		self.AccidentAge	:= le.v4_AccidentAge	;
		self.RecentActivityIndex	:= le.v4_RecentActivityIndex	;
		self.NonDerogCount	:= le.v4_NonDerogCount	;
		self.NonDerogCount01	:= le.v4_NonDerogCount01	;
		self.NonDerogCount03	:= le.v4_NonDerogCount03	;
		self.NonDerogCount06	:= le.v4_NonDerogCount06	;
		self.NonDerogCount12	:= le.v4_NonDerogCount12	;
		self.NonDerogCount24	:= le.v4_NonDerogCount24	;
		self.NonDerogCount60	:= le.v4_NonDerogCount60	;
		self.VoterRegistrationRecord	:= le.v4_VoterRegistrationRecord	;
		self.ProfLicCount	:= le.v4_ProfLicCount	;
		self.ProfLicAge	:= le.v4_ProfLicAge	;
		self.ProfLicTypeCategory	:= le.v4_ProfLicTypeCategory	;
		self.ProfLicExpired	:= le.v4_ProfLicExpired	;
		self.ProfLicCount01	:= le.v4_ProfLicCount01	;
		self.ProfLicCount03	:= le.v4_ProfLicCount03	;
		self.ProfLicCount06	:= le.v4_ProfLicCount06	;
		self.ProfLicCount12	:= le.v4_ProfLicCount12	;
		self.ProfLicCount24	:= le.v4_ProfLicCount24	;
		self.ProfLicCount60	:= le.v4_ProfLicCount60	;
		self.PRSearchLocateCount	:= le.v4_PRSearchLocateCount	;
		self.PRSearchLocateCount01	:= le.v4_PRSearchLocateCount01	;
		self.PRSearchLocateCount03	:= le.v4_PRSearchLocateCount03	;
		self.PRSearchLocateCount06	:= le.v4_PRSearchLocateCount06	;
		self.PRSearchLocateCount12	:= le.v4_PRSearchLocateCount12	;
		self.PRSearchLocateCount24	:= le.v4_PRSearchLocateCount24	;
		self.PRSearchPersonalFinanceCount	:= le.v4_PRSearchPersonalFinanceCount	;
		self.PRSearchPersonalFinanceCount01	:= le.v4_PRSearchPersonalFinanceCount01	;
		self.PRSearchPersonalFinanceCount03	:= le.v4_PRSearchPersonalFinanceCount03	;
		self.PRSearchPersonalFinanceCount06	:= le.v4_PRSearchPersonalFinanceCount06	;
		self.PRSearchPersonalFinanceCount12	:= le.v4_PRSearchPersonalFinanceCount12	;
		self.PRSearchPersonalFinanceCount24	:= le.v4_PRSearchPersonalFinanceCount24	;
		self.PRSearchOtherCount	:= le.v4_PRSearchOtherCount	;
		self.PRSearchOtherCount01	:= le.v4_PRSearchOtherCount01	;
		self.PRSearchOtherCount03	:= le.v4_PRSearchOtherCount03	;
		self.PRSearchOtherCount06	:= le.v4_PRSearchOtherCount06	;
		self.PRSearchOtherCount12	:= le.v4_PRSearchOtherCount12	;
		self.PRSearchOtherCount24	:= le.v4_PRSearchOtherCount24	;
		self.PRSearchIdentitySSNs	:= le.v4_PRSearchIdentitySSNs	;
		self.PRSearchIdentityAddrs	:= le.v4_PRSearchIdentityAddrs	;
		self.PRSearchIdentityPhones	:= le.v4_PRSearchIdentityPhones	;
		self.PRSearchSSNIdentities	:= le.v4_PRSearchSSNIdentities	;
		self.PRSearchAddrIdentities	:= le.v4_PRSearchAddrIdentities	;
		self.PRSearchPhoneIdentities	:= le.v4_PRSearchPhoneIdentities	;
		self.SubPrimeOfferRequestCount	:= le.v4_SubPrimeOfferRequestCount	;
		self.SubPrimeOfferRequestCount01	:= le.v4_SubPrimeOfferRequestCount01	;
		self.SubPrimeOfferRequestCount03	:= le.v4_SubPrimeOfferRequestCount03	;
		self.SubPrimeOfferRequestCount06	:= le.v4_SubPrimeOfferRequestCount06	;
		self.SubPrimeOfferRequestCount12	:= le.v4_SubPrimeOfferRequestCount12	;
		self.SubPrimeOfferRequestCount24	:= le.v4_SubPrimeOfferRequestCount24	;
		self.SubPrimeOfferRequestCount60	:= le.v4_SubPrimeOfferRequestCount60	;
		self.InputPhoneMobile	:= le.v4_InputPhoneMobile	;
		self.InputPhoneType	:= le.v4_InputPhoneType	;
		self.InputPhoneServiceType	:= le.v4_InputPhoneServiceType	;
		self.InputAreaCodeChange	:= le.v4_InputAreaCodeChange	;
		self.PhoneEDAAgeOldestRecord	:= le.v4_PhoneEDAAgeOldestRecord	;
		self.PhoneEDAAgeNewestRecord	:= le.v4_PhoneEDAAgeNewestRecord	;
		self.PhoneOtherAgeOldestRecord	:= le.v4_PhoneOtherAgeOldestRecord	;
		self.PhoneOtherAgeNewestRecord	:= le.v4_PhoneOtherAgeNewestRecord	;
		self.InputPhoneHighRisk	:= le.v4_InputPhoneHighRisk	;
		self.InputPhoneProblems	:= le.v4_InputPhoneProblems	;
		self.OnlineDirectory	:= le.v4_OnlineDirectory	;
		self.InputAddrSICCode	:= le.v4_InputAddrSICCode	;
		self.InputAddrValidation	:= le.v4_InputAddrValidation	;
		self.InputAddrErrorCode	:= le.v4_InputAddrErrorCode	;
		self.InputAddrHighRisk	:= le.v4_InputAddrHighRisk	;
		self.CurrAddrCorrectional	:= le.v4_CurrAddrCorrectional	;
		self.PrevAddrCorrectional	:= le.v4_PrevAddrCorrectional	;
		self.HistoricalAddrCorrectional	:= le.v4_HistoricalAddrCorrectional	;
		self.InputAddrProblems	:= le.v4_InputAddrProblems	;
		self.DoNotMail	:= le.v4_DoNotMail	;
		self.IdentityRiskLevel	:= le.v4_IdentityRiskLevel	;
		self.IDVerRiskLevel	:= le.v4_IDVerRiskLevel	;
		self.IDVerAddressAssocCount	:= le.v4_IDVerAddressAssocCount	;
		self.IDVerSSNCreditBureauCount	:= le.v4_IDVerSSNCreditBureauCount	;
		self.IDVerSSNCreditBureauDelete	:= le.v4_IDVerSSNCreditBureauDelete	;
		self.SourceRiskLevel	:= le.v4_SourceRiskLevel	;
		self.SourceWatchList	:= le.v4_SourceWatchList	;
		self.SourceOrderActivity	:= le.v4_SourceOrderActivity	;
		self.SourceOrderSourceCount	:= le.v4_SourceOrderSourceCount	;
		self.SourceOrderAgeLastOrder	:= le.v4_SourceOrderAgeLastOrder	;
		self.VariationRiskLevel	:= le.v4_VariationRiskLevel	;
		self.VariationIdentityCount	:= le.v4_VariationIdentityCount	;
		self.VariationMSourcesSSNCount	:= le.v4_VariationMSourcesSSNCount	;
		self.VariationMSourcesSSNUnrelCount	:= le.v4_VariationMSourcesSSNUnrelCount	;
		self.VariationDOBCount	:= le.v4_VariationDOBCount	;
		self.VariationDOBCountNew	:= le.v4_VariationDOBCountNew	;
		self.SearchVelocityRiskLevel	:= le.v4_SearchVelocityRiskLevel	;
		self.SearchUnverifiedSSNCountYear	:= le.v4_SearchUnverifiedSSNCountYear	;
		self.SearchUnverifiedAddrCountYear	:= le.v4_SearchUnverifiedAddrCountYear	;
		self.SearchUnverifiedDOBCountYear	:= le.v4_SearchUnverifiedDOBCountYear	;
		self.SearchUnverifiedPhoneCountYear	:= le.v4_SearchUnverifiedPhoneCountYear	;
		self.AssocRiskLevel	:= le.v4_AssocRiskLevel	;
		self.AssocSuspicousIdentitiesCount	:= le.v4_AssocSuspicousIdentitiesCount	;
		self.AssocCreditBureauOnlyCount	:= le.v4_AssocCreditBureauOnlyCount	;
		self.AssocCreditBureauOnlyCountNew	:= le.v4_AssocCreditBureauOnlyCountNew	;
		self.AssocCreditBureauOnlyCountMonth	:= le.v4_AssocCreditBureauOnlyCountMonth	;
		self.AssocHighRiskTopologyCount	:= le.v4_AssocHighRiskTopologyCount	;
		self.ValidationRiskLevel	:= le.v4_ValidationRiskLevel	;
		self.CorrelationRiskLevel	:= le.v4_CorrelationRiskLevel	;
		self.DivRiskLevel	:= le.v4_DivRiskLevel	;
		self.DivSSNIdentityMSourceCount	:= le.v4_DivSSNIdentityMSourceCount	;
		self.DivSSNIdentityMSourceUrelCount	:= le.v4_DivSSNIdentityMSourceUrelCount	;
		self.DivSSNLNameCountNew	:= le.v4_DivSSNLNameCountNew	;
		self.DivSSNAddrMSourceCount	:= le.v4_DivSSNAddrMSourceCount	;
		self.DivAddrIdentityCount	:= le.v4_DivAddrIdentityCount	;
		self.DivAddrIdentityCountNew	:= le.v4_DivAddrIdentityCountNew	;
		self.DivAddrIdentityMSourceCount	:= le.v4_DivAddrIdentityMSourceCount	;
		self.DivAddrSuspIdentityCountNew	:= le.v4_DivAddrSuspIdentityCountNew	;
		self.DivAddrSSNCount	:= le.v4_DivAddrSSNCount	;
		self.DivAddrSSNCountNew	:= le.v4_DivAddrSSNCountNew	;
		self.DivAddrSSNMSourceCount	:= le.v4_DivAddrSSNMSourceCount	;
		self.DivSearchAddrSuspIdentityCount	:= le.v4_DivSearchAddrSuspIdentityCount	;
		self.SearchComponentRiskLevel	:= le.v4_SearchComponentRiskLevel	;
		self.SearchSSNSearchCount	:= le.v4_SearchSSNSearchCount	;
		self.SearchAddrSearchCount	:= le.v4_SearchAddrSearchCount	;
		self.SearchPhoneSearchCount	:= le.v4_SearchPhoneSearchCount	;
		self.ComponentCharRiskLevel	:= le.v4_ComponentCharRiskLevel	;
		self := le;
		END;


		finalnolexid := project( LeadIntegrity_attributes, slim_v4(left) );
			
		finalLayout := RECORD
			unsigned4 seq;
			unsigned6 lexid;
			LeadIntegrity_Vault_Layout.Layout_LeadIntegrity_Layout_Slimmed;
		END;

		final := Project(finalnolexid, Transform(finalLayout,
																				 SELF.seq := 0;
																				 SELF.lexid := (INTEGER)LEFT.accountnumber;
																				 SELF := LEFT));

		LI_Output_File := output(final(accountnumber<>'acctno'),, outputFile, CSV(SEPARATOR('|'), TERMINATOR('\n'), QUOTE('"'), ASCII), overwrite, __COMPRESSED__);

		// Validate Attributes Output

		Validation := LeadIntegrity_Validation(TRIM(date_in), TRIM(part_nbr)).dset_Output_Validation(TRIM(date_in), TRIM(part_nbr))(Status = 'FAIL') : INDEPENDENT;	

		prj_validation := PROJECT(Validation,TRANSFORM({RECORDOF(Validation), STRING txt}, SELF.txt := LEFT.TestCase_Name; SELF := LEFT));

		RECORDOF(prj_validation) lay_rollup(RECORDOF(prj_validation) L ,RECORDOF(prj_validation) R) := TRANSFORM
			SELF.txt := L.txt+'\n\n'+R.txt+'\n';
			SELF := R;
		END;

		RolledupTestCases := ROLLUP(prj_validation,LEFT.Build_period=RIGHT.Build_period,lay_rollup(LEFT, RIGHT)); 

		subject := 'The LeadIntegrity output file validation failed for '+TRIM(date_in);
		body    := 'The LeadIntegrity output file validation failed for '+TRIM(date_in)+'\n\n'+
							 'Part number is '+ TRIM(part_nbr) +'\n\n'+
							 'The workunit is '+ WORKUNIT +'\n\n'+
							 'Failed Test Cases : '+ (STRING)RolledupTestCases[1].txt +'\n\n';

		ValidationFailEmail	:= Fileservices.Sendemail(Constants.TeamEmailList,subject,body);

		// End of output validation block

		RETURN SEQUENTIAL(LI_Output_File,
											IF(COUNT(Validation) > 0, ValidationFailEmail));

END;
