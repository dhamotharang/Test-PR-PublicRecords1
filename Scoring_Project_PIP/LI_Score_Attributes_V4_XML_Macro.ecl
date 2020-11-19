EXPORT LI_Score_Attributes_V4_XML_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name1_score, Output_file_name2_attr, records_ToRun):= FUNCTIONMacro


IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;
IMPORT UT, scoring , Scoring_Project_PIP;


		// unsigned8 no_of_records := 25;
		// integer eyeball := 50;
		// integer retry := 3;
		// integer timeout := 15;
		// integer threads := 50;
		// String roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; ; 
		// model := 'msn1106_0' ;
		// gateways := '';
		// Infile_name :=  scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;
		// String outfile_name1 :=  '~bbraaten_LIv4_scores' ;
		// String outfile_name2 :=  '~bbraaten_LIv4_attribtues' ;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := Retry;
		integer timeout := Timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		model := 'msn1106_0' ;
		gateways := Gateway_dummy;
		Infile_name :=  Input_file_name;
		String outfile_name1 :=  Output_file_name1_score ;
		String outfile_name2 :=  Output_file_name2_attr ;

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
			
	  ds_raw_input := distribute(IF(no_of_records = 0, 
										DATASET(Infile_name, layout_input, thor),
										CHOOSEN(DATASET(Infile_name, layout_input, thor), no_of_records)),(integer)accountnumber);
										
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
			
// files := zz_bbraaten2.Test_lead_integrity_Macro(Soap_output, soap_in, outfile_name1, outfile_name2);
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

Global_output_lay2:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout;			 
		END;
		
		Global_output_lay2 v4_trans(Soap_output le ) := TRANSFORM
			self.time_ms := le.time_ms;
			self.accountnumber :='';
			SELF.seq := le.Result.InputEcho.Seq; 
			self.AgeOldestRecord                      := le.Result.Attributes[1].Value;
			self.AgeNewestRecord                      := le.Result.Attributes[2].Value;
			self.RecentUpdate                         := le.Result.Attributes[3].Value;
			self.SrcsConfirmIDAddrCount               := le.Result.Attributes[4].Value;
			self.CreditBureauRecord                   := le.Result.Attributes[5].Value;
			self.VerificationFailure                  := le.Result.Attributes[6].Value;
			self.SSNNotFound                          := le.Result.Attributes[7].Value;
			self.SSNFoundOther                        := le.Result.Attributes[8].Value;
			self.VerifiedName                         := le.Result.Attributes[9].Value;
			self.VerifiedSSN                          := le.Result.Attributes[10].Value;
			self.VerifiedPhone                        := le.Result.Attributes[11].Value;
			self.VerifiedAddress                      := le.Result.Attributes[12].Value;
			self.VerifiedDOB                          := le.Result.Attributes[13].Value;
			self.AgeRiskIndicator                     := le.Result.Attributes[14].Value;
			self.SubjectSSNCount                      := le.Result.Attributes[15].Value;
			self.SubjectAddrCount                     := le.Result.Attributes[16].Value;
			self.SubjectPhoneCount                    := le.Result.Attributes[17].Value;
			self.SubjectSSNRecentCount                := le.Result.Attributes[18].Value;
			self.SubjectAddrRecentCount               := le.Result.Attributes[19].Value;
			self.SubjectPhoneRecentCount              := le.Result.Attributes[20].Value;
			self.SSNIdentitiesCount                   := le.Result.Attributes[21].Value;
			self.SSNAddrCount                         := le.Result.Attributes[22].Value;
			self.SSNIdentitiesRecentCount             := le.Result.Attributes[23].Value;
			self.SSNAddrRecentCount                   := le.Result.Attributes[24].Value;
			self.InputAddrPhoneCount                  := le.Result.Attributes[25].Value;
			self.InputAddrPhoneRecentCount            := le.Result.Attributes[26].Value;
			self.PhoneIdentitiesCount                 := le.Result.Attributes[27].Value;
			self.PhoneIdentitiesRecentCount           := le.Result.Attributes[28].Value;
			self.PhoneOther                           := le.Result.Attributes[29].Value;
			self.SSNLastNameCount                     := le.Result.Attributes[30].Value;
			self.SubjectLastNameCount                 := le.Result.Attributes[31].Value;
			self.LastNameChangeAge                    := le.Result.Attributes[32].Value;
			self.LastNameChangeCount01                := le.Result.Attributes[33].Value;
			self.LastNameChangeCount03                := le.Result.Attributes[34].Value;
			self.LastNameChangeCount06                := le.Result.Attributes[35].Value;
			self.LastNameChangeCount12                := le.Result.Attributes[36].Value;
			self.LastNameChangeCount24                := le.Result.Attributes[37].Value;
			self.LastNameChangeCount60                := le.Result.Attributes[38].Value;
			self.SFDUAddrIdentitiesCount              := le.Result.Attributes[39].Value;
			self.SFDUAddrSSNCount                     := le.Result.Attributes[40].Value;
			self.SSNAgeDeceased                       := le.Result.Attributes[41].Value;
			self.SSNRecent                            := le.Result.Attributes[42].Value;
			self.SSNLowIssueAge                       := le.Result.Attributes[43].Value;
			self.SSNHighIssueAge                      := le.Result.Attributes[44].Value;
			self.SSNIssueState                        := le.Result.Attributes[45].Value;
			self.SSNNonUS                             := le.Result.Attributes[46].Value;
			self.SSN3Years                            := le.Result.Attributes[47].Value;
			self.SSNAfter5                            := le.Result.Attributes[48].Value;
			self.SSNProblems                          := le.Result.Attributes[49].Value;
			self.RelativesCount                       := le.Result.Attributes[50].Value;
			self.RelativesBankruptcyCount             := le.Result.Attributes[51].Value;
			self.RelativesFelonyCount                 := le.Result.Attributes[52].Value;
			self.RelativesPropOwnedCount              := le.Result.Attributes[53].Value;
			self.RelativesPropOwnedTaxTotal           := le.Result.Attributes[54].Value;
			self.RelativesDistanceClosest             := le.Result.Attributes[55].Value;
			self.InputAddrAgeOldestRecord             := le.Result.Attributes[56].Value;
			self.InputAddrAgeNewestRecord             := le.Result.Attributes[57].Value;
			self.InputAddrHistoricalMatch             := le.Result.Attributes[58].Value;
			self.InputAddrLenOfRes                    := le.Result.Attributes[59].Value;
			self.InputAddrDwellType                   := le.Result.Attributes[60].Value;
			self.InputAddrDelivery                    := le.Result.Attributes[61].Value;
			self.InputAddrApplicantOwned              := le.Result.Attributes[62].Value;
			self.InputAddrFamilyOwned                 := le.Result.Attributes[63].Value;
			self.InputAddrOccupantOwned               := le.Result.Attributes[64].Value;
			self.InputAddrAgeLastSale                 := le.Result.Attributes[65].Value;
			self.InputAddrLastSalesPrice              := le.Result.Attributes[66].Value;
			self.InputAddrMortgageType                := le.Result.Attributes[67].Value;
			self.InputAddrNotPrimaryRes               := le.Result.Attributes[68].Value;
			self.InputAddrActivePhoneList             := le.Result.Attributes[69].Value;
			self.InputAddrTaxValue                    := le.Result.Attributes[70].Value;
			self.InputAddrTaxYr                       := le.Result.Attributes[71].Value;
			self.InputAddrTaxMarketValue              := le.Result.Attributes[72].Value;
			self.InputAddrAVMValue                    := le.Result.Attributes[73].Value;
			self.InputAddrAVMValue12                  := le.Result.Attributes[74].Value;
			self.InputAddrAVMValue60                  := le.Result.Attributes[75].Value;
			self.InputAddrCountyIndex                 := le.Result.Attributes[76].Value;
			self.InputAddrTractIndex                  := le.Result.Attributes[77].Value;
			self.InputAddrBlockIndex                  := le.Result.Attributes[78].Value;
			self.InputAddrMedianIncome                := le.Result.Attributes[79].Value;
			self.InputAddrMedianValue                 := le.Result.Attributes[80].Value;
			self.InputAddrMurderIndex                 := le.Result.Attributes[81].Value;
			self.InputAddrCarTheftIndex               := le.Result.Attributes[82].Value;
			self.InputAddrBurglaryIndex               := le.Result.Attributes[83].Value;
			self.InputAddrCrimeIndex                  := le.Result.Attributes[84].Value;
			self.InputAddrMobilityIndex               := le.Result.Attributes[85].Value;
			self.InputAddrVacantPropCount             := le.Result.Attributes[86].Value;
			self.InputAddrBusinessCount               := le.Result.Attributes[87].Value;
			self.InputAddrSingleFamilyCount           := le.Result.Attributes[88].Value;
			self.InputAddrMultiFamilyCount            := le.Result.Attributes[89].Value;
			self.CurrAddrAgeOldestRecord              := le.Result.Attributes[90].Value;
			self.CurrAddrAgeNewestRecord              := le.Result.Attributes[91].Value;
			self.CurrAddrLenOfRes                     := le.Result.Attributes[92].Value;
			self.CurrAddrDwellType                    := le.Result.Attributes[93].Value;
			self.CurrAddrApplicantOwned               := le.Result.Attributes[94].Value;
			self.CurrAddrFamilyOwned                  := le.Result.Attributes[95].Value;
			self.CurrAddrOccupantOwned                := le.Result.Attributes[96].Value;
			self.CurrAddrAgeLastSale                  := le.Result.Attributes[97].Value;
			self.CurrAddrLastSalesPrice               := le.Result.Attributes[98].Value;
			self.CurrAddrMortgageType                 := le.Result.Attributes[99].Value;
			self.CurrAddrActivePhoneList              := le.Result.Attributes[100].Value;
			self.CurrAddrTaxValue                     := le.Result.Attributes[101].Value;
			self.CurrAddrTaxYr                        := le.Result.Attributes[102].Value;
			self.CurrAddrTaxMarketValue               := le.Result.Attributes[103].Value;
			self.CurrAddrAVMValue                     := le.Result.Attributes[104].Value;
			self.CurrAddrAVMValue12                   := le.Result.Attributes[105].Value;
			self.CurrAddrAVMValue60                   := le.Result.Attributes[106].Value;
			self.CurrAddrCountyIndex                  := le.Result.Attributes[107].Value;
			self.CurrAddrTractIndex                   := le.Result.Attributes[108].Value;
			self.CurrAddrBlockIndex                   := le.Result.Attributes[109].Value;
			self.CurrAddrMedianIncome                 := le.Result.Attributes[110].Value;
			self.CurrAddrMedianValue                  := le.Result.Attributes[111].Value;
			self.CurrAddrMurderIndex                  := le.Result.Attributes[112].Value;
			self.CurrAddrCarTheftIndex                := le.Result.Attributes[113].Value;
			self.CurrAddrBurglaryIndex                := le.Result.Attributes[114].Value;
			self.CurrAddrCrimeIndex                   := le.Result.Attributes[115].Value;
			self.PrevAddrAgeOldestRecord              := le.Result.Attributes[116].Value;
			self.PrevAddrAgeNewestRecord              := le.Result.Attributes[117].Value;
			self.PrevAddrLenOfRes                     := le.Result.Attributes[118].Value;
			self.PrevAddrDwellType                    := le.Result.Attributes[119].Value;
			self.PrevAddrApplicantOwned               := le.Result.Attributes[120].Value;
			self.PrevAddrFamilyOwned                  := le.Result.Attributes[121].Value;
			self.PrevAddrOccupantOwned                := le.Result.Attributes[122].Value;
			self.PrevAddrAgeLastSale                  := le.Result.Attributes[123].Value;
			self.PrevAddrLastSalesPrice               := le.Result.Attributes[124].Value;
			self.PrevAddrTaxValue                     := le.Result.Attributes[125].Value;
			self.PrevAddrTaxYr                        := le.Result.Attributes[126].Value;
			self.PrevAddrTaxMarketValue               := le.Result.Attributes[127].Value;
			self.PrevAddrAVMValue                     := le.Result.Attributes[128].Value;
			self.PrevAddrCountyIndex                  := le.Result.Attributes[129].Value;
			self.PrevAddrTractIndex                   := le.Result.Attributes[130].Value;
			self.PrevAddrBlockIndex                   := le.Result.Attributes[131].Value;
			self.PrevAddrMedianIncome                 := le.Result.Attributes[132].Value;
			self.PrevAddrMedianValue                  := le.Result.Attributes[133].Value;
			self.PrevAddrMurderIndex                  := le.Result.Attributes[134].Value;
			self.PrevAddrCarTheftIndex                := le.Result.Attributes[135].Value;
			self.PrevAddrBurglaryIndex                := le.Result.Attributes[136].Value;
			self.PrevAddrCrimeIndex                   := le.Result.Attributes[137].Value;
			self.AddrMostRecentDistance               := le.Result.Attributes[138].Value;
			self.AddrMostRecentStateDiff              := le.Result.Attributes[139].Value;
			self.AddrMostRecentTaxDiff                := le.Result.Attributes[140].Value;
			self.AddrMostRecentMoveAge                := le.Result.Attributes[141].Value;
			self.AddrMostRecentIncomeDiff             := le.Result.Attributes[142].Value;
			self.AddrMostRecentValueDIff              := le.Result.Attributes[143].Value;
			self.AddrMostRecentCrimeDiff              := le.Result.Attributes[144].Value;
			self.AddrRecentEconTrajectory             := le.Result.Attributes[145].Value;
			self.AddrRecentEconTrajectoryIndex        := le.Result.Attributes[146].Value;
			self.EducationAttendedCollege             := le.Result.Attributes[147].Value;
			self.EducationProgram2Yr                  := le.Result.Attributes[148].Value;
			self.EducationProgram4Yr                  := le.Result.Attributes[149].Value;
			self.EducationProgramGraduate             := le.Result.Attributes[150].Value;
			self.EducationInstitutionPrivate          := le.Result.Attributes[151].Value;
			self.EducationInstitutionRating           := le.Result.Attributes[152].Value;
			self.EducationFieldofStudyType            := le.Result.Attributes[153].Value;
			self.AddrStability                        := le.Result.Attributes[154].Value;
			self.StatusMostRecent                     := le.Result.Attributes[155].Value;
			self.StatusPrevious                       := le.Result.Attributes[156].Value;
			self.StatusNextPrevious                   := le.Result.Attributes[157].Value;
			self.AddrChangeCount01                    := le.Result.Attributes[158].Value;
			self.AddrChangeCount03                    := le.Result.Attributes[159].Value;
			self.AddrChangeCount06                    := le.Result.Attributes[160].Value;
			self.AddrChangeCount12                    := le.Result.Attributes[161].Value;
			self.AddrChangeCount24                    := le.Result.Attributes[162].Value;
			self.AddrChangeCount60                    := le.Result.Attributes[163].Value;
			self.EstimatedAnnualIncome                := le.Result.Attributes[164].Value;
			self.AssetOwner                           := le.Result.Attributes[165].Value;
			self.PropertyOwner                        := le.Result.Attributes[166].Value;
			self.PropOwnedCount                       := le.Result.Attributes[167].Value;
			self.PropOwnedTaxTotal                    := le.Result.Attributes[168].Value;
			self.PropOwnedHistoricalCount             := le.Result.Attributes[169].Value;
			self.PropAgeOldestPurchase                := le.Result.Attributes[170].Value;
			self.PropAgeNewestPurchase                := le.Result.Attributes[171].Value;
			self.PropAgeNewestSale                    := le.Result.Attributes[172].Value;
			self.PropNewestSalePrice                  := le.Result.Attributes[173].Value;
			self.PropNewestSalePurchaseIndex          := le.Result.Attributes[174].Value;
			self.PropPurchasedCount01                 := le.Result.Attributes[175].Value;
			self.PropPurchasedCount03                 := le.Result.Attributes[176].Value;
			self.PropPurchasedCount06                 := le.Result.Attributes[177].Value;
			self.PropPurchasedCount12                 := le.Result.Attributes[178].Value;
			self.PropPurchasedCount24                 := le.Result.Attributes[179].Value;
			self.PropPurchasedCount60                 := le.Result.Attributes[180].Value;
			self.PropSoldCount01                      := le.Result.Attributes[181].Value;
			self.PropSoldCount03                      := le.Result.Attributes[182].Value;
			self.PropSoldCount06                      := le.Result.Attributes[183].Value;
			self.PropSoldCount12                      := le.Result.Attributes[184].Value;
			self.PropSoldCount24                      := le.Result.Attributes[185].Value;
			self.PropSoldCount60                      := le.Result.Attributes[186].Value;
			self.WatercraftOwner                      := le.Result.Attributes[187].Value;
			self.WatercraftCount                      := le.Result.Attributes[188].Value;
			self.WatercraftCount01                    := le.Result.Attributes[189].Value;
			self.WatercraftCount03                    := le.Result.Attributes[190].Value;
			self.WatercraftCount06                    := le.Result.Attributes[191].Value;
			self.WatercraftCount12                    := le.Result.Attributes[192].Value;
			self.WatercraftCount24                    := le.Result.Attributes[193].Value;
			self.WatercraftCount60                    := le.Result.Attributes[194].Value;
			self.AircraftOwner                        := le.Result.Attributes[195].Value;
			self.AircraftCount                        := le.Result.Attributes[196].Value;
			self.AircraftCount01                      := le.Result.Attributes[197].Value;
			self.AircraftCount03                      := le.Result.Attributes[198].Value;
			self.AircraftCount06                      := le.Result.Attributes[199].Value;
			self.AircraftCount12                      := le.Result.Attributes[200].Value;
			self.AircraftCount24                      := le.Result.Attributes[201].Value;
			self.AircraftCount60                      := le.Result.Attributes[202].Value;
			self.WealthIndex                          := le.Result.Attributes[203].Value;
			self.BusinessActiveAssociation            := le.Result.Attributes[204].Value;
			self.BusinessInactiveAssociation          := le.Result.Attributes[205].Value;
			self.BusinessAssociationAge               := le.Result.Attributes[206].Value;
			self.BusinessTitle                        := le.Result.Attributes[207].Value;
			self.BusinessInputAddrCount               := le.Result.Attributes[208].Value;
			self.DerogSeverityIndex                   := le.Result.Attributes[209].Value;
			self.DerogCount                           := le.Result.Attributes[210].Value;
			self.DerogRecentCount                     := le.Result.Attributes[211].Value;
			self.DerogAge                             := le.Result.Attributes[212].Value;
			self.FelonyCount                          := le.Result.Attributes[213].Value;
			self.FelonyAge                            := le.Result.Attributes[214].Value;
			self.FelonyCount01                        := le.Result.Attributes[215].Value;
			self.FelonyCount03                        := le.Result.Attributes[216].Value;
			self.FelonyCount06                        := le.Result.Attributes[217].Value;
			self.FelonyCount12                        := le.Result.Attributes[218].Value;
			self.FelonyCount24                        := le.Result.Attributes[219].Value;
			self.FelonyCount60                        := le.Result.Attributes[220].Value;
			self.ArrestCount                          := le.Result.Attributes[221].Value;
			self.ArrestAge                            := le.Result.Attributes[222].Value;
			self.ArrestCount01                        := le.Result.Attributes[223].Value;
			self.ArrestCount03                        := le.Result.Attributes[224].Value;
			self.ArrestCount06                        := le.Result.Attributes[225].Value;
			self.ArrestCount12                        := le.Result.Attributes[226].Value;
			self.ArrestCount24                        := le.Result.Attributes[227].Value;
			self.ArrestCount60                        := le.Result.Attributes[228].Value;
			self.LienCount                            := le.Result.Attributes[229].Value;
			self.LienFiledCount                       := le.Result.Attributes[230].Value;
			self.LienFiledTotal                       := le.Result.Attributes[231].Value;
			self.LienFiledAge                         := le.Result.Attributes[232].Value;
			self.LienFiledCount01                     := le.Result.Attributes[233].Value;
			self.LienFiledCount03                     := le.Result.Attributes[234].Value;
			self.LienFiledCount06                     := le.Result.Attributes[235].Value;
			self.LienFiledCount12                     := le.Result.Attributes[236].Value;
			self.LienFiledCount24                     := le.Result.Attributes[237].Value;
			self.LienFiledCount60                     := le.Result.Attributes[238].Value;
			self.LienReleasedCount                    := le.Result.Attributes[239].Value;
			self.LienReleasedTotal                    := le.Result.Attributes[240].Value;
			self.LienReleasedAge                      := le.Result.Attributes[241].Value;
			self.LienReleasedCount01                  := le.Result.Attributes[242].Value;
			self.LienReleasedCount03                  := le.Result.Attributes[243].Value;
			self.LienReleasedCount06                  := le.Result.Attributes[244].Value;
			self.LienReleasedCount12                  := le.Result.Attributes[245].Value;
			self.LienReleasedCount24                  := le.Result.Attributes[246].Value;
			self.LienReleasedCount60                  := le.Result.Attributes[247].Value;
			self.BankruptcyCount                      := le.Result.Attributes[248].Value;
			self.BankruptcyAge                        := le.Result.Attributes[249].Value;
			self.BankruptcyType                       := le.Result.Attributes[250].Value;
			self.BankruptcyStatus                     := le.Result.Attributes[251].Value;
			self.BankruptcyCount01                    := le.Result.Attributes[252].Value;
			self.BankruptcyCount03                    := le.Result.Attributes[253].Value;
			self.BankruptcyCount06                    := le.Result.Attributes[254].Value;
			self.BankruptcyCount12                    := le.Result.Attributes[255].Value;
			self.BankruptcyCount24                    := le.Result.Attributes[256].Value;
			self.BankruptcyCount60                    := le.Result.Attributes[257].Value;
			self.EvictionCount                        := le.Result.Attributes[258].Value;
			self.EvictionAge                          := le.Result.Attributes[259].Value;
			self.EvictionCount01                      := le.Result.Attributes[260].Value;
			self.EvictionCount03                      := le.Result.Attributes[261].Value;
			self.EvictionCount06                      := le.Result.Attributes[262].Value;
			self.EvictionCount12                      := le.Result.Attributes[263].Value;
			self.EvictionCount24                      := le.Result.Attributes[264].Value;
			self.EvictionCount60                      := le.Result.Attributes[265].Value;
			self.AccidentCount                        := le.Result.Attributes[266].Value;
			self.AccidentAge                          := le.Result.Attributes[267].Value;
			self.RecentActivityIndex                  := le.Result.Attributes[268].Value;
			self.NonDerogCount                        := le.Result.Attributes[269].Value;
			self.NonDerogCount01                      := le.Result.Attributes[270].Value;
			self.NonDerogCount03                      := le.Result.Attributes[271].Value;
			self.NonDerogCount06                      := le.Result.Attributes[272].Value;
			self.NonDerogCount12                      := le.Result.Attributes[273].Value;
			self.NonDerogCount24                      := le.Result.Attributes[274].Value;
			self.NonDerogCount60                      := le.Result.Attributes[275].Value;
			self.VoterRegistrationRecord              := le.Result.Attributes[276].Value;
			self.ProfLicCount                         := le.Result.Attributes[277].Value;
			self.ProfLicAge                           := le.Result.Attributes[278].Value;
			self.ProfLicTypeCategory                  := le.Result.Attributes[279].Value;
			self.ProfLicExpired                       := le.Result.Attributes[280].Value;
			self.ProfLicCount01                       := le.Result.Attributes[281].Value;
			self.ProfLicCount03                       := le.Result.Attributes[282].Value;
			self.ProfLicCount06                       := le.Result.Attributes[283].Value;
			self.ProfLicCount12                       := le.Result.Attributes[284].Value;
			self.ProfLicCount24                       := le.Result.Attributes[285].Value;
			self.ProfLicCount60                       := le.Result.Attributes[286].Value;
			self.PRSearchLocateCount                  := le.Result.Attributes[287].Value;
			self.PRSearchLocateCount01                := le.Result.Attributes[288].Value;
			self.PRSearchLocateCount03                := le.Result.Attributes[289].Value;
			self.PRSearchLocateCount06                := le.Result.Attributes[290].Value;
			self.PRSearchLocateCount12                := le.Result.Attributes[291].Value;
			self.PRSearchLocateCount24                := le.Result.Attributes[292].Value;
			self.PRSearchPersonalFinanceCount         := le.Result.Attributes[293].Value;
			self.PRSearchPersonalFinanceCount01       := le.Result.Attributes[294].Value;
			self.PRSearchPersonalFinanceCount03       := le.Result.Attributes[295].Value;
			self.PRSearchPersonalFinanceCount06       := le.Result.Attributes[296].Value;
			self.PRSearchPersonalFinanceCount12       := le.Result.Attributes[297].Value;
			self.PRSearchPersonalFinanceCount24       := le.Result.Attributes[298].Value;
			self.PRSearchOtherCount                   := le.Result.Attributes[299].Value;
			self.PRSearchOtherCount01                 := le.Result.Attributes[300].Value;
			self.PRSearchOtherCount03                 := le.Result.Attributes[301].Value;
			self.PRSearchOtherCount06                 := le.Result.Attributes[302].Value;
			self.PRSearchOtherCount12                 := le.Result.Attributes[303].Value;
			self.PRSearchOtherCount24                 := le.Result.Attributes[304].Value;
			self.PRSearchIdentitySSNs                 := le.Result.Attributes[305].Value;
			self.PRSearchIdentityAddrs                := le.Result.Attributes[306].Value;
			self.PRSearchIdentityPhones               := le.Result.Attributes[307].Value;
			self.PRSearchSSNIdentities                := le.Result.Attributes[308].Value;
			self.PRSearchAddrIdentities               := le.Result.Attributes[309].Value;
			self.PRSearchPhoneIdentities              := le.Result.Attributes[310].Value;
			self.SubPrimeOfferRequestCount            := le.Result.Attributes[311].Value;
			self.SubPrimeOfferRequestCount01          := le.Result.Attributes[312].Value;
			self.SubPrimeOfferRequestCount03          := le.Result.Attributes[313].Value;
			self.SubPrimeOfferRequestCount06          := le.Result.Attributes[314].Value;
			self.SubPrimeOfferRequestCount12          := le.Result.Attributes[315].Value;
			self.SubPrimeOfferRequestCount24          := le.Result.Attributes[316].Value;
			self.SubPrimeOfferRequestCount60          := le.Result.Attributes[317].Value;
			self.InputPhoneMobile                     := le.Result.Attributes[318].Value;
			self.InputPhoneType                       := le.Result.Attributes[319].Value;
			self.InputPhoneServiceType                := le.Result.Attributes[320].Value;
			self.InputAreaCodeChange                  := le.Result.Attributes[321].Value;
			self.PhoneEDAAgeOldestRecord              := le.Result.Attributes[322].Value;
			self.PhoneEDAAgeNewestRecord              := le.Result.Attributes[323].Value;
			self.PhoneOtherAgeOldestRecord            := le.Result.Attributes[324].Value;
			self.PhoneOtherAgeNewestRecord            := le.Result.Attributes[325].Value;
			self.InputPhoneHighRisk                   := le.Result.Attributes[326].Value;
			self.InputPhoneProblems                   := le.Result.Attributes[327].Value;
			self.OnlineDirectory                      := le.Result.Attributes[328].Value;
			self.InputAddrSICCode                     := le.Result.Attributes[329].Value;
			self.InputAddrValidation                  := le.Result.Attributes[330].Value;
			self.InputAddrErrorCode                   := le.Result.Attributes[331].Value;
			self.InputAddrHighRisk                    := le.Result.Attributes[332].Value;
			self.CurrAddrCorrectional                 := le.Result.Attributes[333].Value;
			self.PrevAddrCorrectional                 := le.Result.Attributes[334].Value;
			self.HistoricalAddrCorrectional           := le.Result.Attributes[335].Value;
			self.InputAddrProblems                    := le.Result.Attributes[336].Value;
			self.DoNotMail                            := le.Result.Attributes[337].Value;
			SELF.IdentityRiskLevel                    := le.Result.Attributes[338].Value;
			SELF.IDVerRiskLevel                       := le.Result.Attributes[339].Value;
			SELF.IDVerAddressAssocCount 							:= le.Result.Attributes[340].Value;
			SELF.IDVerSSNCreditBureauCount 						:= le.Result.Attributes[341].Value;
			SELF.IDVerSSNCreditBureauDelete 					:= le.Result.Attributes[342].Value;
			SELF.SourceRiskLevel 											:= le.Result.Attributes[343].Value;
			SELF.SourceWatchList 											:= le.Result.Attributes[344].Value;
			SELF.SourceOrderActivity 									:= le.Result.Attributes[345].Value;
			SELF.SourceOrderSourceCount 							:= le.Result.Attributes[346].Value;
			SELF.SourceOrderAgeLastOrder 							:= le.Result.Attributes[347].Value;
			SELF.VariationRiskLevel 									:= le.Result.Attributes[348].Value;
			SELF.VariationIdentityCount 							:= le.Result.Attributes[349].Value;
			SELF.VariationMSourcesSSNCount 						:= le.Result.Attributes[350].Value;
			SELF.VariationMSourcesSSNUnrelCount 			:= le.Result.Attributes[351].Value;
			SELF.VariationDOBCount 										:= le.Result.Attributes[352].Value;
			SELF.VariationDOBCountNew 								:= le.Result.Attributes[353].Value;
			SELF.SearchVelocityRiskLevel 							:= le.Result.Attributes[354].Value;
			SELF.SearchUnverifiedSSNCountYear 				:= le.Result.Attributes[355].Value;
			SELF.SearchUnverifiedAddrCountYear 				:= le.Result.Attributes[356].Value;
			SELF.SearchUnverifiedDOBCountYear 				:= le.Result.Attributes[357].Value;
			SELF.SearchUnverifiedPhoneCountYear 			:= le.Result.Attributes[358].Value;
			SELF.AssocRiskLevel 											:= le.Result.Attributes[359].Value;
			SELF.AssocSuspicousIdentitiesCount 				:= le.Result.Attributes[360].Value;
			SELF.AssocCreditBureauOnlyCount 					:= le.Result.Attributes[361].Value;
			SELF.AssocCreditBureauOnlyCountNew 				:= le.Result.Attributes[362].Value;
			SELF.AssocCreditBureauOnlyCountMonth 			:= le.Result.Attributes[363].Value;
			SELF.AssocHighRiskTopologyCount 					:= le.Result.Attributes[364].Value;
			SELF.ValidationRiskLevel 									:= le.Result.Attributes[365].Value;
			SELF.CorrelationRiskLevel 								:= le.Result.Attributes[366].Value;
			SELF.DivRiskLevel 												:= le.Result.Attributes[367].Value;
			SELF.DivSSNIdentityMSourceCount 					:= le.Result.Attributes[368].Value;
			SELF.DivSSNIdentityMSourceUrelCount 			:= le.Result.Attributes[369].Value;
			SELF.DivSSNLNameCountNew 									:= le.Result.Attributes[370].Value;
			SELF.DivSSNAddrMSourceCount 							:= le.Result.Attributes[371].Value;
			SELF.DivAddrIdentityCount 								:= le.Result.Attributes[372].Value;
			SELF.DivAddrIdentityCountNew 							:= le.Result.Attributes[373].Value;
			SELF.DivAddrIdentityMSourceCount 					:= le.Result.Attributes[374].Value;
			SELF.DivAddrSuspIdentityCountNew 					:= le.Result.Attributes[375].Value;
			SELF.DivAddrSSNCount 											:= le.Result.Attributes[376].Value;
			SELF.DivAddrSSNCountNew 									:= le.Result.Attributes[377].Value;
			SELF.DivAddrSSNMSourceCount 							:= le.Result.Attributes[378].Value;
			SELF.DivSearchAddrSuspIdentityCount 			:= le.Result.Attributes[379].Value;
			SELF.SearchComponentRiskLevel 						:= le.Result.Attributes[380].Value;
			SELF.SearchSSNSearchCount 								:= le.Result.Attributes[381].Value;
			SELF.SearchAddrSearchCount 								:= le.Result.Attributes[382].Value;
			SELF.SearchPhoneSearchCount 							:= le.Result.Attributes[383].Value;
			SELF.ComponentCharRiskLevel 							:= le.Result.Attributes[384].Value;
			self.errorcode:=le.errorcode;
		  self.DID := le.did; 
		  self := [];
    END;
		
		ds_slim := project(Soap_output, v4_trans(left) );
			
		//Appeding additional internal extras to Soap output file 
		ds_with_extras2 := JOIN(soap_in, ds_slim,LEFT.LeadIntegrityRequest[1].SearchBy.Seq=RIGHT.seq,
				                          TRANSFORM(Global_output_lay2,
																	            SELF.AccountNumber := LEFT.LeadIntegrityRequest[1].SearchBy.Seq;
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
																							self := right
				                                   ),
																					keep(1)
																				);
																				
output(ds_with_extras,, outfile_name1, thor, compressed, OVERWRITE);
output(ds_with_extras,, outfile_name1+'_CSV_copy', CSV(heading(single), quote('"')), overwrite,expire(14));
output(ds_with_extras2,, outfile_name2, thor, compressed, OVERWRITE);
output(ds_with_extras2,, outfile_name2+'_CSV_copy', CSV(heading(single), quote('"')), overwrite,expire(14));
// end;
		RETURN 0;
// export scores;
// export attribtues;	
	// files := sequential(Soap_output, scores, attributes)															
	
ENDMACRO;