import ML;
EXPORT macComputeSuspectProviderAddressScore (Infile, 
																									 LNPID = '',
																									 PrimaryRange = '',
																									 PreDirectional = '',
																									 PrimaryName = '',
																									 AddressSuffix = '',
																									 PostDirectional = '',
																									 SecondaryRange = '',
																									 City = '',
																									 State = '',
																									 Zip5 = '',
																									 AddressPaidAmount = '',
																									 AddressExclusionFlag = '',
																									 SharedAddressIndicator = '',
																									 DMEIndicator = '',
																									 DMEOutlierRank = '',
																									 LABIndicator = '',
																									 LABOutlierRank = '',
																									 SingleAddressIndicator = '',
																									 TotalNPICount = 0,
																									 RecentNPICount = 0,
																									 StudentNPICount = 0,
																									 DNDIndicator = '',
																									 TotalChargeAmount = '',
																									 TotalLNPIDChargeAmount = '',
																									 TotalPaidAmount = '',
																									 TotalClaimCount = '',
																									 VacantAddressActivityIndicator = '',
																									 MailDropIndicator = '',
																									 AddressType = '',
																									 UsageType = '',
																									 PrisonIndicator = '',
																									 ResidentialAddressIndicator = '',
																									 ActiveStateExclusion = '',
																									 ActiveOIGExclusion = '',
																									 ActiveOPMExclusion = '',
																									 ActiveLicenseRevocation = '',
																									 PastStateExclusion = '',
																									 PastOIGExclusion = '',
																									 PastOPMExclusion = '',
																									 PastLicenseRevocation = '',
																									 LicenseExpiredFlag = '',
																									 DEAExpiredFlag = '',
																									 DeceasedFlag = '',
																									 DateofDeath = 0,
																									 BankruptcyFlag = '',
																									 CriminalHistoryFlag = '',
																									 DeceasedPatientsFlag = '',
																									 LargePatientGroupFlag = '',
																									 LicenseInactiveFlag = '',
																									 NPIDeactivatedFlag = '',
																									 LongPatientDrivingDistanceIndicator = '',
																									 LongPatientDrivingDistanceOutlierRank = '',
																									 HighPaidDollarsPerPatientIndicator = '',
																									 HighPaidDollarsPerPatientOutlierRank = '',																									 
																									 HighPaidDollarsPerClaimIndicator = '',
																									 HighPaidDollarsPerClaimOutlierRank = '',																									 
																									 HighNumberOfPatientsIndicator = '',
																									 HighNumberOfPatientsOutlierRank = '',																									 
																									 HighNumberOfClaimsIndicator = '',
																									 HighNumberOfClaimsOutlierRank = '',																									 
																									 HighPaidDollarsIndicator = '',
																									 HighPaidDollarsOutlierRank = '',																									 
																									 InNetworkCurrentExclusionFlag = '',
																									 InNetworkCurrentRevocationFlag = '',
																									 InNetworkPastExclusionFlag = '',
																									 InNetworkPastRevocationFlag = '',																									 
																									 InNetworkhasBankruptcy = '',																									 
																									 InNetworkhasCriminalHistory = '',																									 
																									 OutNetworkCurrentExclusionFlag = '',
																									 OutNetworkCurrentRevocationFlag = '',
																									 OutNetworkPastExclusionFlag = '',
																									 OutNetworkPastRevocationFlag = '',																									 
																									 OutNetworkhasBankruptcy = '',																									 
																									 OutNetworkhasCriminalHistory = '',																									 
																									 RelativeCriminalFlag = '',
																									 RelativeBankruptcyFlag = '',
																									 AssociateCriminalFlag = '',
																									 AssociateBankruptcyFlag = '',
																									 NoOfProviderAtAddress = '',
																									 NoOfPatientAtAddress = '',
																									 HighPaidAmountPerPatient = '',
																									 HighPaidAmountPerClaim = '',
																									 ClaimMedian = 0,
																									 PatientMedian = 0,
																									 HighPaidAmountMedian = 0,
																									 HighPaidAmountPerClaimMedian = 0,
																									 HighPaidAmountPerPatientMedian = 0,
																									 
																									 DMEPatientMedian = 0,
																									 DMEClaimMedian = 0,
																				 
																									 LABPatientMedian = 0,
																									 LABClaimMedian = 0,
																									 
																									 ActiveLicenseRevocationState = '',
																									 ActiveLicenseRevocationDate = '',
																									 ActiveLicenseExclusionState = '',
																									 ActiveLicenseExclusionDate = '',
																									 ActiveOIGExclusionDate = '',
																									 ActiveOPMExclusionDate = '',
																									 ActiveStateSanctionExclusionDate = '',
																									 ActiveOIGSanctionExclusionDate = '',
																									 ActiveOPMSanctionExclusionDate = '',
																									 LicenseRevocationReinstatedState = '',
																									 LicenseRevocationReinstatedDate = '',																									 
																									 StateExclusionReinstatedState = '',
																									 StateExclusionReinstatedDate = '',
																									 OIGExclusionReinstatedDate = '',
																									 OPMExclusionReinstatedDate = '',
																									 ExpiredDEANumber = '',
																									 ExpiredDEADate = '',
																								   ExpiredLicenseNumber = '',
																									 ExpiredLicenseState = '',
																									 ExpiredLicenseNumberDate = '',
																									 BankruptcyFiledDate = '',
																									 ConvictionDate = '',
																									 DeceasedPatientCount = '',
																									 PatientCount = '',
																									 PatientDOD = '',
																									 NPIDeactivatedDate = '',
																									 ProviderPatientAddress = '',
																									 LargePatientCount = '',
																									 LargePatientAddress = '',
																									 InactiveLicenseState = '',
																									 NoOfPatientsDrivingLongDistance = '',
																									 AveDistance = '',
																									 
																									 PractisePrimaryrange = '',
																									 PractisePredirectional = '',
																									 PractisePrimaryname = '',
																									 PractiseAddresssuffix = '',
																									 PractisePostdirectional = '',
																									 PractiseSecondaryrange = '',
																									 PractiseCityname = '',
																									 PractiseState = '',
																									 PractiseZip5 = '',
																									 
																									 
																									 SharedAddressSwitch = '',																									 
																									 DMESwitch = '',
																									 LABSwitch = '',
																									 SingleAddressSwitch = '',
																									 RecentNPISwitch = '',
																									 StudentNPISwitch = '',
																									 DNDSwitch = '',
																									 VacantSwitch = '',
																									 MailDropSwitch = '',
																									 POBoxSwitch = '',
																									 PrisonSwitch = '',
																									 ResidentialSwitch = '',
																									 ActiveStateExclusionSwitch = '',
																									 ActiveOIGExclusionSwitch = '',
																									 ActiveOPMExclusionSwitch = '',
																									 ActiveLicenseRevocationSwitch = '',
																									 PastStateExclusionSwitch = '',
																									 PastOIGExclusionSwitch = '',
																									 PastOPMExclusionSwitch = '',
																									 PastLicenseRevocationSwitch = '',
																									 LicenseExpiredSwitch = '',
																									 DEAExpiredSwitch = '',
																									 DeceasedSwitch = '',
																									 BankruptcySwitch = '',
																									 CriminalHistorySwitch = '',
																									 DeceasedPatientsSwitch = '',
																									 LargePatientGroupSwitch = '',
																									 LicenseInactiveSwitch = '',
																									 NPIDeactivatedSwitch = '',
																									 LongPatientDrivingDistanceSwitch = '',
																									 HighPaidDollarsPerPatientSwitch = '',
																									 HighPaidDollarsPerClaimSwitch = '',
																									 HighNumberOfPatientsSwitch = '',
																									 HighNumberOfClaimsSwitch = '',
																									 HighPaidDollarsSwitch = '',
																									 InNetworkCurrentExclusionSwitch = '',
																									 InNetworkCurrentRevocationSwitch = '',
																									 InNetworkPastExclusionSwitch = '',
																									 InNetworkPastRevocationSwitch = '',																									 
																									 InNetworkhasBankruptcySwitch = '',																									 
																									 InNetworkhasCriminalHistorySwitch = '',																									 
																									 OutNetworkCurrentExclusionSwitch = '',
																									 OutNetworkCurrentRevocationSwitch = '',
																									 OutNetworkPastExclusionSwitch = '',
																									 OutNetworkPastRevocationSwitch = '',																									 
																									 OutNetworkhasBankruptcySwitch = '',																									 
																									 OutNetworkhasCriminalHistorySwitch = '',																									 
																									 RelativeAssocCriminalSwitch = '',
																									 RelativeAssocBankruptcySwitch = '',
																									 SharedAddressScore = 0,																									 
																									 DMEScore = 0,
																									 LABScore = 0,
																									 SingleAddressScore = 0,
																									 RecentNPIScore = 0,
																									 StudentNPIScore = 0,
																									 DNDScore = 0,
																									 VacantScore = 0,
																									 MailDropScore = 0,
																									 POBoxScore = 0,
																									 PrisonScore = 0,
																									 ResidentialScore = 0,
																									 ActiveStateExclusionScore = 0,
																									 ActiveOIGExclusionScore = 0,
																									 ActiveOPMExclusionScore = 0,
																									 ActiveLicenseRevocationScore = 0,
																									 PastStateExclusionScore = 0,
																									 PastOIGExclusionScore = 0,
																									 PastOPMExclusionScore = 0,
																									 PastLicenseRevocationScore = 0,
																									 ExpiredLicenseScore = 0,
																									 DEAExpiredScore = 0,
																									 DeceasedScore = 0,
																									 BankruptcyScore = 0,
																									 CriminalHistoryScore = 0,
																									 DeceasedPatientsScore = 0,
																									 LargePatientGroupScore = 0,
																									 LicenseInactiveScore = 0,
																									 NPIDeactivatedScore = 0,
																									 LongPatientDrivingDistanceScore = 0,
																									 HighPaidDollarsPerPatientScore = 0,
																									 HighPaidDollarsPerClaimScore = 0,
																									 HighNumberOfPatientsScore = 0,
																									 HighNumberOfClaimsScore = 0,
																									 HighPaidDollarsScore = 0,
																									 InNetworkCurrentExclusionScore = 0,
																									 InNetworkCurrentRevocationScore = 0,
																									 InNetworkPastExclusionScore = 0,
																									 InNetworkPastRevocationScore = 0,																									 
																									 InNetworkhasBankruptcyScore = 0,																									 
																									 InNetworkhasCriminalHistoryScore = 0,																									 
																									 OutNetworkCurrentExclusionScore = 0,
																									 OutNetworkCurrentRevocationScore = 0,
																									 OutNetworkPastExclusionScore = 0,
																									 OutNetworkPastRevocationScore = 0,																									 
																									 OutNetworkhasBankruptcyScore = 0,																									 
																									 OutNetworkhasCriminalHistoryScore = 0,																									 
																									 RelativeAssocCriminalScore = 0,
																									 RelativeAssocBankruptcyScore = 0,
																									 appendPrefix = '\'\''
																									 ) := FUNCTIONMACRO
	
    IMPORT ComputeSuspectProviderAddressScore.ScoringAlgorithms as ScoringAlgorithms;

    // Make sure the scoringThreshold value is 0-100
    // boundedScoringThreshold := MAX(MIN(suspectAddressThreshold, 100), 0);

    LOCAL ReasonCode_t := ScoringAlgorithms.ReasonCode_t;

    LOCAL ReasonLayout := RECORD
        ReasonCode_t    reason;
				STRING          description;
				STRING					value;
    END;

    LOCAL ScoreLayout := RECORD
        RECORDOF(Infile);
				UNSIGNED1             #EXPAND(appendPrefix + 'SharedAddressScore');
				UNSIGNED1             #EXPAND(appendPrefix + 'DMEScore');
				UNSIGNED1             #EXPAND(appendPrefix + 'LabScore');
				UNSIGNED1             #EXPAND(appendPrefix + 'SingleAddressScore');				
				UNSIGNED1             #EXPAND(appendPrefix + 'RecentNPIScore');				
				UNSIGNED1             #EXPAND(appendPrefix + 'StudentNPIScore');				
				UNSIGNED1             #EXPAND(appendPrefix + 'DNDScore');				
				UNSIGNED1             #EXPAND(appendPrefix + 'VacantScore');								
				UNSIGNED1             #EXPAND(appendPrefix + 'MailDropScore');								
				UNSIGNED1             #EXPAND(appendPrefix + 'POBoxScore');								
				UNSIGNED1             #EXPAND(appendPrefix + 'PrisonScore');								
				UNSIGNED1             #EXPAND(appendPrefix + 'ResidentialScore');								

        UNSIGNED1 						#EXPAND(appendPrefix + 'CurrentExclusionScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'CurrentLicenseRevocationScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'PastExclusionScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'PastRevocationScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'LicenseExpiredScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'DEAExpiredScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'DeceasedScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'BankruptcyScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'CriminalHistoryScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'DeceasedPatientsScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'LargePatientGroupScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'LicenseInactiveScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'NPIDeactivatedScore');
				
				UNSIGNED1 						#EXPAND(appendPrefix + 'LongPatientDrivingDistanceScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'HighPaidDollarsPerPatientScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'HighPaidDollarsPerClaimScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'HighNumberOfPatientsScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'HighNumberOfClaimsScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'HighPaidDollarsScore');

        UNSIGNED1 						#EXPAND(appendPrefix + 'InNetworkAssocCurrentExclusionScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'InNetworkAssocCurrentRevocationScore');
        UNSIGNED1 						#EXPAND(appendPrefix + 'InNetworkAssocPastExclusionScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'InNetworkAssocPastRevocationScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'InNetworkAssocBankruptcyScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'InNetworkAssocCriminalHistoryScore');

        UNSIGNED1 						#EXPAND(appendPrefix + 'OutNetworkAssocCurrentExclusionScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'OutNetworkAssocCurrentRevocationScore');
        UNSIGNED1 						#EXPAND(appendPrefix + 'OutNetworkAssocPastExclusionScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'OutNetworkAssocPastRevocationScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'OutNetworkAssocBankruptcyScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'OutNetworkAssocCriminalHistoryScore');
				
				UNSIGNED1 						#EXPAND(appendPrefix + 'RelativeAssocCriminalScore');
				UNSIGNED1 						#EXPAND(appendPrefix + 'RelativeAssocBankruptcyScore');
				
				UNSIGNED4             #EXPAND(appendPrefix + 'AddressScore');
        UNSIGNED4             #EXPAND(appendPrefix + 'ProfessionalScore');

				UNSIGNED4             #EXPAND(appendPrefix + 'MedianAddressScore');
				UNSIGNED4             #EXPAND(appendPrefix + 'MedianProfessionalScore');
				UNSIGNED4             #EXPAND(appendPrefix + 'MaxProfScoreAtAddressScore');

				UNSIGNED4             #EXPAND(appendPrefix + 'SuspectProviderAtLocationCount');
				UNSIGNED4             #EXPAND(appendPrefix + 'IncrementPaidAmountCount');
				
				UNSIGNED4             #EXPAND(appendPrefix + 'FinalAddressScore');
				UNSIGNED4             #EXPAND(appendPrefix + 'FinalProfessionalScore');
				
        DATASET(ReasonLayout) #EXPAND(appendPrefix + 'reasons');
    END;

    LOCAL ScoreLayout ScoreXForm(RECORDOF(Infile) L) := TRANSFORM

				evalSharedAddress									:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalSharedAddress 						(L.SharedAddressIndicator,SharedAddressSwitch,SharedAddressScore,L.NoOfProviderAtAddress,L.NoOfPatientAtAddress);				
				evalDMEOutlier										:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalDMEOutlier								(L.DMEIndicator, DMESwitch, DMEScore, L.DMEOutlierRank, L.HighPaidAmountPerPatient, L.HighPaidAmountPerClaim, L.DMEPatientMedian, L.DMEClaimMedian);				
				evalLABOutlier										:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalLABOutlier								(L.LABIndicator, LABSwitch, LABScore, L.LABOutlierRank, L.HighPaidAmountPerPatient, L.HighPaidAmountPerClaim, L.LABPatientMedian, L.LABClaimMedian);
				isSingleAddress := L.PrimaryName <> '' and L.PrimaryRange = L.PractisePrimaryrange and L.PreDirectional = L.PractisePredirectional and L.PrimaryName = L.PractisePrimaryname and L.AddressSuffix = L.PractiseAddresssuffix and L.PostDirectional = L.PractisePostdirectional and L.SecondaryRange = L.PractiseSecondaryrange and L.Zip5 = L.PractiseZip5;
				
				evalSingleAddress 								:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalSingleAddress							(L.SingleAddressIndicator, SingleAddressSwitch, SingleAddressScore, L.NoOfProviderAtAddress, isSingleAddress);				
				evalRecentNPI 										:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalRecentNPI									(L.TotalNPICount, L.RecentNPICount, RecentNPISwitch, RecentNPIScore);	
        evalStudentNPI 										:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalStudentNPI								(L.TotalNPICount, L.StudentNPICount, StudentNPISwitch, StudentNPIScore);	
				evalDND 													:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalDND												(L.DNDIndicator, L.TotalChargeAmount, L.TotalClaimCount, DNDSwitch, DNDScore);
				evalVacancy 											:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalVacancy										(L.VacantAddressActivityIndicator, VacantSwitch, VacantScore);
				evalMailDrop 											:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalMailDrop									(L.MailDropIndicator, L.TotalClaimCount, L.TotalPaidAmount, MailDropSwitch, MailDropScore);
				evalPOBox 												:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalPOBox											(L.AddressType, L.UsageType, L.TotalClaimCount, L.TotalPaidAmount,POBoxSwitch, POBoxScore);
				evalPrison 												:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalPrison										(L.PrisonIndicator, PrisonSwitch, PrisonScore, L.TotalClaimCount, L.TotalPaidAmount);
				evalresidential 									:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalResidential								(L.ResidentialAddressIndicator, L.TotalClaimCount, L.TotalPaidAmount, ResidentialSwitch, ResidentialScore);


	        // Score each element
				evalActiveStateExclusion 					:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalActiveStateExclusion 			(L.ActiveStateExclusion, ActiveStateExclusionSwitch, ActiveStateExclusionScore, L.ActiveLicenseExclusionState, L.ActiveLicenseExclusionDate);				
				evalActiveOIGExclusion 						:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalActiveOIGExclusion 				(L.ActiveOIGExclusion, ActiveOIGExclusionSwitch, ActiveOIGExclusionScore, L.ActiveOIGExclusionDate);				
				evalActiveOPMExclusion 						:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalActiveOPMExclusion 				(L.ActiveOPMExclusion, ActiveOPMExclusionSwitch, ActiveOPMExclusionScore, L.ActiveOPMExclusionDate);				
				evalActiveSanctionRevocation 			:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalActiveSanctionRevocation	(L.ActiveLicenseRevocation, ActiveLicenseRevocationSwitch, ActiveLicenseRevocationScore, L.ActiveLicenseRevocationState, L.ActiveLicenseRevocationDate);				

				evalPastStateExclusion 						:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalPastStateExclusion				(L.PastStateExclusion, PastStateExclusionSwitch, PastStateExclusionScore, L.StateExclusionReinstatedState, L.StateExclusionReinstatedDate);				
				evalPastOIGExclusion 							:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalPastOIGExclusion					(L.PastOIGExclusion, PastOIGExclusionSwitch, PastOIGExclusionScore, L.OIGExclusionReinstatedDate);				
				evalPastOPMExclusion 							:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalPastOPMExclusion					(L.PastOPMExclusion, PastOPMExclusionSwitch, PastOPMExclusionScore, L.OPMExclusionReinstatedDate);				
				/* Fix this line */
				evalReinstatedSanctionRevocation 	:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalPastLicenseRevocation			(L.PastLicenseRevocation, PastLicenseRevocationSwitch, PastLicenseRevocationScore, L.LicenseRevocationReinstatedState, L.LicenseRevocationReinstatedDate);				
				evalLicenseExpired 								:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalLicenseExpired 						(L.LicenseExpiredFlag, LicenseExpiredSwitch, ExpiredLicenseScore, L.ExpiredLicenseNumberDate, L.ExpiredLicenseNumber, L.ExpiredLicenseState, L.TotalLNPIDChargeAmount);		
				evalDeaExpired 										:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalDEAExpired								(L.DEAExpiredFlag, DEAExpiredSwitch, DEAExpiredScore, L.ExpiredDEANumber, L.ExpiredDEADate, L.TotalLNPIDChargeAmount);												

				evalDeceased 											:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalDeceased									(L.DeceasedFlag, L.DateofDeath, DeceasedSwitch, DeceasedScore , L.TotalLNPIDChargeAmount, L.LNPID);												
				evalBankruptcy 										:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalBankruptcy								(L.BankruptcyFlag, BankruptcySwitch, BankruptcyScore, L.BankruptcyFiledDate, L.LNPID);	
				evalCriminalHistory								:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalCriminalHistory						(L.CriminalHistoryFlag, CriminalHistorySwitch, CriminalHistoryScore, L.ConvictionDate, L.LNPID);
				evalDeceasedPatients							:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalDeceasedPatients					(L.DeceasedPatientsFlag, DeceasedPatientsSwitch, DeceasedPatientsScore, L.DeceasedPatientCount, L.PatientCount, L.PatientDOD , L.TotalChargeAmount);		
				evalLargePatientGroups						:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalLargePatientGroups				(L.LargePatientGroupFlag, LargePatientGroupSwitch, LargePatientGroupScore, L.LargePatientCount, L.LargePatientAddress);	
				evalLicenseInactive 							:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalLicenseInactive						(L.LicenseInactiveFlag, LicenseInactiveSwitch, LicenseInactiveScore, L.InactiveLicenseState, L.TotalLNPIDChargeAmount);		
				evalNPIDeactivated	 							:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalNPIDeactivated						(L.NPIDeactivatedFlag, NPIDeactivatedSwitch, NPIDeactivatedScore, L.NPIDeactivatedDate, L.TotalLNPIDChargeAmount);			

				evalLongPatientDrivingDistance		:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalLongPatientDrivingDistance(L.LongPatientDrivingDistanceIndicator, (INTEGER)L.LongPatientDrivingDistanceOutlierRank, LongPatientDrivingDistanceSwitch, LongPatientDrivingDistanceScore, L.NoOfPatientsDrivingLongDistance, L.PatientCount, L.AveDistance);						
				evalHighPaidDollarsPerPatient			:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalHighPaidDollarsPerPatient	(L.HighPaidDollarsPerPatientIndicator, (INTEGER)L.HighPaidDollarsPerPatientOutlierRank, HighPaidDollarsPerPatientSwitch, HighPaidDollarsPerPatientScore, L.HighPaidAmountPerPatient, L.HighPaidAmountPerPatientMedian);							
				evalHighPaidDollarsPerClaim				:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalHighPaidDollarsPerClaim		(L.HighPaidDollarsPerClaimIndicator, (INTEGER)L.HighPaidDollarsPerClaimOutlierRank, HighPaidDollarsPerClaimSwitch, HighPaidDollarsPerClaimScore, L.HighPaidAmountPerClaim, L.HighPaidAmountPerClaimMedian);											
				evalHighNumberOfPatients					:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalHighNumberOfPatients			(L.HighNumberOfPatientsIndicator, (INTEGER)L.HighNumberOfPatientsOutlierRank, HighNumberOfPatientsSwitch, HighNumberOfPatientsScore, L.PatientCount,L.PatientMedian);											
				evalHighNumberOfClaims						:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalHighNumberOfClaims				(L.HighNumberOfClaimsIndicator, (INTEGER)L.HighNumberOfClaimsOutlierRank, HighNumberOfClaimsSwitch, HighNumberOfClaimsScore, L.TotalClaimCount,L.ClaimMedian);															
				evalHighPaidDollars								:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalHighPaidDollars						(L.HighPaidDollarsIndicator, (INTEGER)L.HighPaidDollarsOutlierRank, HighPaidDollarsSwitch, HighPaidDollarsScore, L.TotalChargeAmount, L.TotalPaidAmount, L.HighPaidAmountMedian);															
				
				evalInNetworkCurrentExclusion			:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalInNetworkActiveExclusion	(L.InNetworkCurrentExclusionFlag, InNetworkCurrentExclusionSwitch, InNetworkCurrentExclusionScore);			
				evalInNetworkCurrentRevocation		:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalInNetworkActiveRevocation	(L.InNetworkCurrentRevocationFlag, InNetworkCurrentRevocationSwitch, InNetworkCurrentRevocationScore);			
				evalInNetworkPastExclusion				:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalInNetworkPastExclusion		(L.InNetworkPastExclusionFlag, InNetworkPastExclusionSwitch, InNetworkPastExclusionScore);			
				evalInNetworkPastRevocation				:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalInNetworkPastRevocation		(L.InNetworkPastRevocationFlag, InNetworkPastRevocationSwitch, InNetworkPastRevocationScore);			
				evalInNetworkCriminal							:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalInNetworkBankruptcy				(L.InNetworkhasBankruptcy, InNetworkhasBankruptcySwitch, InNetworkhasBankruptcyScore);			
				evalInNetworkBankruptcy						:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalInNetworkCriminal					(L.InNetworkhasCriminalHistory, InNetworkhasCriminalHistorySwitch, InNetworkhasCriminalHistoryScore);			
				evalOutNetworkCurrentExclusion		:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalOutNetworkActiveExclusion	(L.OutNetworkCurrentExclusionFlag, OutNetworkCurrentExclusionSwitch, OutNetworkCurrentExclusionScore);			
				evalOutNetworkCurrentRevocation		:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalOutNetworkActiveRevocation(L.OutNetworkCurrentRevocationFlag, OutNetworkCurrentRevocationSwitch, OutNetworkCurrentRevocationScore);			
				evalOutNetworkPastExclusion				:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalOutNetworkPastExclusion		(L.OutNetworkPastExclusionFlag, OutNetworkPastExclusionSwitch, OutNetworkPastExclusionScore);			
				evalOutNetworkPastRevocation			:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalOutNetworkPastRevocation	(L.OutNetworkPastRevocationFlag, OutNetworkPastRevocationSwitch, OutNetworkPastRevocationScore);			
				evalOutNetworkCriminal						:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalOutNetworkCriminal			  (L.OutNetworkhasCriminalHistory, OutNetworkhasCriminalHistorySwitch, OutNetworkhasCriminalHistoryScore);			
				evalOutNetworkBankruptcy					:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalOutNetworkBankruptcy			(L.OutNetworkhasBankruptcy, OutNetworkhasBankruptcySwitch, OutNetworkhasBankruptcyScore);			


				evalRelativeBankruptcy						:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalRelativeBankruptcy				(L.RelativeBankruptcyFlag, RelativeAssocBankruptcySwitch, RelativeAssocBankruptcyScore, L.LNPID);		
				evalAssocBankruptcy								:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalAssocBankruptcy						(L.AssociateBankruptcyFlag, RelativeAssocBankruptcySwitch, RelativeAssocBankruptcyScore, L.LNPID);						
				evalRelativeCriminal							:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalRelativeCriminal					(L.RelativeCriminalFlag, RelativeAssocCriminalSwitch, RelativeAssocCriminalScore, L.LNPID);			
				evalAssocCriminal									:= ComputeSuspectProviderAddressScore.ScoringAlgorithms.EvalAssocCriminal							(L.AssociateCriminalFlag, RelativeAssocCriminalSwitch, RelativeAssocCriminalScore, L.LNPID);			

				
        // Collect the reason codes, if any
        reasonDS := DATASET
            (
                [
								{evalSharedAddress.reason,'',evalSharedAddress.Value},			
								{evalDMEOutlier.reason,'',evalDMEOutlier.Value},							
								{evalLABOutlier.reason,'',evalLABOutlier.Value},							
								{evalSingleAddress.reason,'',evalSingleAddress.Value},			 			
								{evalRecentNPI.reason,'',evalRecentNPI.Value},			 				
								{evalStudentNPI.reason,'',evalStudentNPI.Value},			 				
								{evalDND.reason,'',evalDND.Value},			 				
								{evalVacancy.reason,'',evalVacancy.Value},			 				
								{evalMailDrop.reason,'',evalMailDrop.Value},							
								{evalPOBox.reason,'',evalPOBox.Value},			 				
								{evalPrison.reason,'',evalPrison.Value},			 				
								{evalresidential.reason,'',evalresidential.Value},			 			
								{evalActiveStateExclusion.reason,'',evalActiveStateExclusion.Value},			 		
								{evalActiveOIGExclusion.reason,'',evalActiveOIGExclusion.Value},			 			
								{evalActiveOPMExclusion.reason,'',evalActiveOPMExclusion.Value},			 			
								{evalActiveSanctionRevocation.reason,'',evalActiveSanctionRevocation.Value},			 		
								{evalPastStateExclusion.reason,'',evalPastStateExclusion.Value},			 			
								{evalPastOIGExclusion.reason,'',evalPastOIGExclusion.Value},			 			
								{evalPastOPMExclusion.reason,'',evalPastOPMExclusion.Value},			 			
								{evalReinstatedSanctionRevocation.reason,'',evalReinstatedSanctionRevocation.Value},			 	
								{evalLicenseExpired.reason,'',evalLicenseExpired.Value},			 			
								{evalDeaExpired.reason,'',evalDeaExpired.Value},			 				
								{evalDeceased.reason,'',evalDeceased.Value},			 				
								{evalBankruptcy.reason,'',evalBankruptcy.Value},			 				
								{evalCriminalHistory.reason,'',evalCriminalHistory.Value},						
								{evalDeceasedPatients.reason,'',evalDeceasedPatients.Value},						
								{evalLargePatientGroups.reason,'',evalLargePatientGroups.Value},						
								{evalLicenseInactive.reason,'',evalLicenseInactive.Value},			 			
								{evalNPIDeactivated.reason,'',evalNPIDeactivated.Value},				 		
								{evalLongPatientDrivingDistance.reason,'',evalLongPatientDrivingDistance.Value},					
								{evalHighPaidDollarsPerPatient.reason,'',evalHighPaidDollarsPerPatient.Value},					
								{evalHighPaidDollarsPerClaim.reason,'',evalHighPaidDollarsPerClaim.Value},					
								{evalHighNumberOfPatients.reason,'',evalHighNumberOfPatients.Value},					
								{evalHighNumberOfClaims.reason,'',evalHighNumberOfClaims.Value},						
								{evalHighPaidDollars.reason,'',evalHighPaidDollars.Value},						
								{evalInNetworkCurrentExclusion.reason,'',evalInNetworkCurrentExclusion.Value},					
								{evalInNetworkCurrentRevocation.reason,'',evalInNetworkCurrentRevocation.Value},					
								{evalInNetworkPastExclusion.reason,'',evalInNetworkPastExclusion.Value},					
								{evalInNetworkPastRevocation.reason,'',evalInNetworkPastRevocation.Value},					
								{evalInNetworkCriminal.reason,'',evalInNetworkCriminal.Value},						
								{evalInNetworkBankruptcy.reason,'',evalInNetworkBankruptcy.Value},						
								{evalOutNetworkCurrentExclusion.reason,'',evalOutNetworkCurrentExclusion.Value},					
								{evalOutNetworkCurrentRevocation.reason,'',evalOutNetworkCurrentRevocation.Value},					
								{evalOutNetworkPastExclusion.reason,'',evalOutNetworkPastExclusion.Value},					
								{evalOutNetworkPastRevocation.reason,'',evalOutNetworkPastRevocation.Value},					
								{evalOutNetworkCriminal.reason,'',evalOutNetworkCriminal.Value},						
								{evalOutNetworkBankruptcy.reason,'',evalOutNetworkBankruptcy.Value},					
								{evalRelativeCriminal.reason,'',evalRelativeCriminal.Value},					
								{evalRelativeBankruptcy.reason,'',evalRelativeBankruptcy.Value},
								{evalAssocCriminal.reason,'',evalAssocCriminal.Value},					
								{evalAssocBankruptcy.reason,'',evalAssocBankruptcy.Value}					
								],
                {ReasonLayout}
            );

				
        // Assign individual scores
				SELF.#EXPAND(appendPrefix + 'SharedAddressScore') 											:= evalSharedAddress.score;
				SELF.#EXPAND(appendPrefix + 'DMEScore')																	:= evalDMEOutlier.score;
				SELF.#EXPAND(appendPrefix + 'LabScore')																	:= evalLABOutlier.score;
				SELF.#EXPAND(appendPrefix + 'SingleAddressScore')												:= evalSingleAddress.score;				
				SELF.#EXPAND(appendPrefix + 'RecentNPIScore')														:= evalRecentNPI.score;				
				SELF.#EXPAND(appendPrefix + 'StudentNPIScore')													:= evalStudentNPI.score;				
				SELF.#EXPAND(appendPrefix + 'DNDScore')																	:= evalDND.score;				
				SELF.#EXPAND(appendPrefix + 'VacantScore')															:= evalVacancy.score;								
				SELF.#EXPAND(appendPrefix + 'MailDropScore')														:= evalMailDrop.score;								
				SELF.#EXPAND(appendPrefix + 'POBoxScore')																:= evalPOBox.score;								
				SELF.#EXPAND(appendPrefix + 'PrisonScore')															:= evalPrison.score;								
				SELF.#EXPAND(appendPrefix + 'ResidentialScore')													:= evalresidential.score;								
				
        SELF.#EXPAND(appendPrefix + 'CurrentExclusionScore') 										:= map(evalActiveStateExclusion.score > 0 => evalActiveStateExclusion.score, 
																																											 evalActiveOIGExclusion.score > 0 => evalActiveOIGExclusion.score, 
																																											 evalActiveOPMExclusion.score);
				SELF.#EXPAND(appendPrefix + 'CurrentLicenseRevocationScore')						:= evalActiveSanctionRevocation.score;
        SELF.#EXPAND(appendPrefix + 'PastExclusionScore') 											:= map(evalPastStateExclusion.score > 0 => evalPastStateExclusion.score, 
																																											 evalPastOIGExclusion.score > 0 => evalPastOIGExclusion.score,
																																											 evalPastOPMExclusion.score);
				SELF.#EXPAND(appendPrefix + 'PastRevocationScore')											:= evalReinstatedSanctionRevocation.score;
				SELF.#EXPAND(appendPrefix + 'LicenseExpiredScore')											:= evalLicenseExpired.score;        
				SELF.#EXPAND(appendPrefix + 'DEAExpiredScore')													:= evalDeaExpired.score;        
				SELF.#EXPAND(appendPrefix + 'DeceasedScore')														:= evalDeceased.score;        
				SELF.#EXPAND(appendPrefix + 'BankruptcyScore')													:= evalBankruptcy.score;        
				SELF.#EXPAND(appendPrefix + 'CriminalHistoryScore')											:= evalCriminalHistory.score;        
				SELF.#EXPAND(appendPrefix + 'DeceasedPatientsScore')										:= evalDeceasedPatients.score;        
				SELF.#EXPAND(appendPrefix + 'LargePatientGroupScore')										:= evalLargePatientGroups.score;        
				SELF.#EXPAND(appendPrefix + 'LicenseInactiveScore')											:= evalLicenseInactive.score;        
				SELF.#EXPAND(appendPrefix + 'NPIDeactivatedScore')											:= evalNPIDeactivated.score;        

			  SELF.#EXPAND(appendPrefix + 'LongPatientDrivingDistanceScore')					:= evalLongPatientDrivingDistance.score;
				SELF.#EXPAND(appendPrefix + 'HighPaidDollarsPerPatientScore')						:= evalHighPaidDollarsPerPatient.score;
				SELF.#EXPAND(appendPrefix + 'HighPaidDollarsPerClaimScore')							:= evalHighPaidDollarsPerClaim.score;
				SELF.#EXPAND(appendPrefix + 'HighNumberOfPatientsScore')								:= evalHighNumberOfPatients.score;
				SELF.#EXPAND(appendPrefix + 'HighNumberOfClaimsScore')									:= evalHighNumberOfClaims.score;
				SELF.#EXPAND(appendPrefix + 'HighPaidDollarsScore')											:= evalHighPaidDollars.score;

	      SELF.#EXPAND(appendPrefix + 'InNetworkAssocCurrentExclusionScore')			:=	evalInNetworkCurrentExclusion.score;    
				SELF.#EXPAND(appendPrefix + 'InNetworkAssocCurrentRevocationScore')			:=	evalInNetworkCurrentRevocation.score;
        SELF.#EXPAND(appendPrefix + 'InNetworkAssocPastExclusionScore')					:=	evalInNetworkPastExclusion.score;
				SELF.#EXPAND(appendPrefix + 'InNetworkAssocPastRevocationScore')				:=	evalInNetworkPastRevocation.score;
				SELF.#EXPAND(appendPrefix + 'InNetworkAssocBankruptcyScore')						:=	evalInNetworkCriminal.score;
				SELF.#EXPAND(appendPrefix + 'InNetworkAssocCriminalHistoryScore')				:=	evalInNetworkBankruptcy.score;
        SELF.#EXPAND(appendPrefix + 'OutNetworkAssocCurrentExclusionScore')			:=	evalOutNetworkCurrentExclusion.score;
				SELF.#EXPAND(appendPrefix + 'OutNetworkAssocCurrentRevocationScore')		:=	evalOutNetworkCurrentRevocation.score;
        SELF.#EXPAND(appendPrefix + 'OutNetworkAssocPastExclusionScore')				:=	evalOutNetworkPastExclusion.score;
				SELF.#EXPAND(appendPrefix + 'OutNetworkAssocPastRevocationScore')				:=	evalOutNetworkPastRevocation.score;
				SELF.#EXPAND(appendPrefix + 'OutNetworkAssocBankruptcyScore')						:=	evalOutNetworkCriminal.score;
				SELF.#EXPAND(appendPrefix + 'OutNetworkAssocCriminalHistoryScore')			:=	evalOutNetworkBankruptcy.score;
				SELF.#EXPAND(appendPrefix + 'RelativeAssocCriminalScore')								:=	IF(evalRelativeCriminal.score > 0, evalRelativeCriminal.score, evalAssocCriminal.score);
				SELF.#EXPAND(appendPrefix + 'RelativeAssocBankruptcyScore')							:=	IF(evalRelativeBankruptcy.score > 0, evalRelativeBankruptcy.score, evalAssocBankruptcy.score);


				SELF.#EXPAND(appendPrefix + 'AddressScore') 												:= SELF.#EXPAND(appendPrefix + 'SharedAddressScore') 
																																						+  SELF.#EXPAND(appendPrefix + 'DMEScore')					
																																						+  SELF.#EXPAND(appendPrefix + 'LabScore')					
																																						+  SELF.#EXPAND(appendPrefix + 'SingleAddressScore')					
																																						+  SELF.#EXPAND(appendPrefix + 'RecentNPIScore')					
																																						+  SELF.#EXPAND(appendPrefix + 'StudentNPIScore')					
																																						+  SELF.#EXPAND(appendPrefix + 'DNDScore')					
																																						+  SELF.#EXPAND(appendPrefix + 'VacantScore')					
																																						+  SELF.#EXPAND(appendPrefix + 'MailDropScore')					
																																						+  SELF.#EXPAND(appendPrefix + 'POBoxScore')					
																																						+  SELF.#EXPAND(appendPrefix + 'PrisonScore')					
																																						+  SELF.#EXPAND(appendPrefix + 'ResidentialScore');																																											

				SELF.#EXPAND(appendPrefix + 'ProfessionalScore') 										:= SELF.#EXPAND(appendPrefix + 'CurrentExclusionScore') 
																																						+  SELF.#EXPAND(appendPrefix + 'CurrentLicenseRevocationScore')
																																						+  SELF.#EXPAND(appendPrefix + 'PastExclusionScore')
																																						+  SELF.#EXPAND(appendPrefix + 'PastRevocationScore')
																																						+  SELF.#EXPAND(appendPrefix + 'LicenseExpiredScore')
																																						+  SELF.#EXPAND(appendPrefix + 'DEAExpiredScore')
																																						+  SELF.#EXPAND(appendPrefix + 'DeceasedScore')
																																						+  SELF.#EXPAND(appendPrefix + 'BankruptcyScore')																												
																																						+  SELF.#EXPAND(appendPrefix + 'CriminalHistoryScore')																												
																																						+  SELF.#EXPAND(appendPrefix + 'DeceasedPatientsScore')
																																						+  SELF.#EXPAND(appendPrefix + 'LargePatientGroupScore')
																																						+  SELF.#EXPAND(appendPrefix + 'LicenseInactiveScore')
																																						+  SELF.#EXPAND(appendPrefix + 'NPIDeactivatedScore')
																																						+  SELF.#EXPAND(appendPrefix + 'LongPatientDrivingDistanceScore')
																																						+  SELF.#EXPAND(appendPrefix + 'HighPaidDollarsPerPatientScore')
																																						+  SELF.#EXPAND(appendPrefix + 'HighPaidDollarsPerClaimScore')
																																						+  SELF.#EXPAND(appendPrefix + 'HighNumberOfPatientsScore')
																																						+  SELF.#EXPAND(appendPrefix + 'HighNumberOfClaimsScore')
																																						+  SELF.#EXPAND(appendPrefix + 'HighPaidDollarsScore')
																																						+  SELF.#EXPAND(appendPrefix + 'InNetworkAssocCurrentExclusionScore') 
																																						+	 SELF.#EXPAND(appendPrefix + 'InNetworkAssocCurrentRevocationScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'InNetworkAssocPastExclusionScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'InNetworkAssocPastRevocationScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'InNetworkAssocBankruptcyScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'InNetworkAssocCriminalHistoryScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocCurrentExclusionScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocCurrentExclusionScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocPastExclusionScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocPastRevocationScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocBankruptcyScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocCriminalHistoryScore')
																																						+	 SELF.#EXPAND(appendPrefix + 'RelativeAssocCriminalScore')
																																						+  SELF.#EXPAND(appendPrefix + 'RelativeAssocBankruptcyScore');
																												
				SELF.#EXPAND(appendPrefix + 'MedianAddressScore')										:=	0;
				SELF.#EXPAND(appendPrefix + 'MedianProfessionalScore')							:=	0;
				SELF.#EXPAND(appendPrefix + 'MaxProfScoreAtAddressScore')						:=	0;
				SELF.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') 			:= 	0;
				SELF.#EXPAND(appendPrefix + 'IncrementPaidAmountCount') 						:= 	0;
				
				SELF.#EXPAND(appendPrefix + 'FinalAddressScore') 										:= 	0;
				SELF.#EXPAND(appendPrefix + 'FinalProfessionalScore') 							:= 	0;
			
        SELF.#EXPAND(appendPrefix + 'reasons') := join(reasonDS(reason != ''),ComputeSuspectProviderAddressScore.ScoringAlgorithms.reasonDescriptions,left.reason = right.reasonCode,transform(ReasonLayout, self.description := right.description, SELF.Value := left.Value; self := left;));

        SELF := L;
    END;

    ScoredFile := PROJECT(Infile, ScoreXForm(LEFT), LOCAL);

		rec := RECORD
			INTEGER4 Id;
			INTEGER2 Value;
		END;
		
		ds_addr := PROJECT (ScoredFile(#EXPAND(appendPrefix + 'AddressScore') > 0), TRANSFORM(rec, SELF.Id := COUNTER;
				SELF.Value := LEFT.#EXPAND(appendPrefix + 'AddressScore'); 
				));

		ds_prof := PROJECT (ScoredFile(#EXPAND(appendPrefix + 'ProfessionalScore') > 0), TRANSFORM(rec, SELF.Id := COUNTER;
				SELF.Value := LEFT.#EXPAND(appendPrefix + 'ProfessionalScore'); 
				));
		
		ML.ToField(ds_addr, ds1);
		ML.ToField(ds_prof, ds2);
		
		medians1 := ML.FieldAggregates(ds1).Medians;
		medians2 := ML.FieldAggregates(ds2).Medians;
		
		AveAddressScore			 := medians1(number = 1)[1].median;
		AveProfessionalScore := medians2(number = 1)[1].median;;

		addr_rec := RECORD
			STRING10 PrimaryRange;
			STRING2 PreDirectional;
			STRING28 PrimaryName;
			STRING4 AddressSuffix;
			STRING2 PostDirectional;
			STRING8 SecondaryRange;
			STRING25 City;
			STRING2 State;
			STRING5 Zip5;
			STRING50 ProviderKey;
		END;

		Addr_Tab := TABLE (ScoredFile((INTEGER)LNPID > 0 and AddressExclusionFlag <> 'Y' and TotalPaidAmount > 0.00 and #EXPAND(appendPrefix + 'ProfessionalScore') > 0), {PrimaryRange, PreDirectional, PrimaryName, AddressSuffix, PostDirectional, SecondaryRange, City, State, Zip5, 
				HighProfScore := MAX (GROUP, #EXPAND(appendPrefix + 'ProfessionalScore')),
				SuspectProviderAtLocationCount := COUNT (GROUP, ScoredFile.#EXPAND(appendPrefix + 'ProfessionalScore') > AveProfessionalScore);
				IncrementPaidAmountCount := ROUND((INTEGER)AddressPaidAmount / 50000);
				},PrimaryRange, PreDirectional, PrimaryName, AddressSuffix, PostDirectional, SecondaryRange, City, State, Zip5, MERGE);
		
		AppendMaxProfScore := JOIN (ScoredFile, Addr_Tab, LEFT.PrimaryRange = RIGHT.PrimaryRange AND 
																											LEFT.PreDirectional = RIGHT.PreDirectional AND
																											LEFT.PrimaryName = RIGHT.PrimaryName AND
																											LEFT.AddressSuffix = RIGHT.AddressSuffix AND
																											LEFT.PostDirectional = RIGHT.PostDirectional AND
																											LEFT.SecondaryRange = RIGHT.SecondaryRange AND
																											LEFT.City = RIGHT.City AND
																											LEFT.State = RIGHT.State AND
																											LEFT.Zip5 = RIGHT.Zip5, TRANSFORM(ScoreLayout, 
																											SELF.#EXPAND(appendPrefix + 'MaxProfScoreAtAddressScore') := RIGHT.HighProfScore; 
																											SELF.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') := RIGHT.SuspectProviderAtLocationCount;
																											SELF.#EXPAND(appendPrefix + 'IncrementPaidAmountCount') := RIGHT.IncrementPaidAmountCount;
																											SELF := LEFT;), LEFT OUTER, HASH);
			
		FinalScoredFile := PROJECT (AppendMaxProfScore, TRANSFORM(ScoreLayout,
				SELF.#EXPAND(appendPrefix + 'MedianAddressScore')										:=	AveAddressScore;
				SELF.#EXPAND(appendPrefix + 'MedianProfessionalScore')							:=	AveProfessionalScore;
				LocationExtraScore 																									:=  IF ((INTEGER) LEFT.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') > 1, (LEFT.#EXPAND(appendPrefix + 'IncrementPaidAmountCount') * 5),0);
				// LocationExtraScore 																									:=  IF ((INTEGER)LEFT.#EXPAND(appendPrefix + 'AddressScore') > AveAddressScore, (LEFT.#EXPAND(appendPrefix + 'IncrementPaidAmountCount') * 5),0);
				FinalAddressScore																										:=	IF ((INTEGER) LEFT.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') > 1, LEFT.#EXPAND(appendPrefix + 'AddressScore') + LEFT.#EXPAND(appendPrefix + 'MaxProfScoreAtAddressScore') + 
																																																															(LEFT.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') * 10) + 
																																																															// (LEFT.#EXPAND(appendPrefix + 'IncrementPaidAmountCount') * 5), 
																																																															LocationExtraScore, 
																																																															LEFT.#EXPAND(appendPrefix + 'AddressScore') + LEFT.#EXPAND(appendPrefix + 'ProfessionalScore'));
				SELF.#EXPAND(appendPrefix + 'FinalAddressScore') 										:= FinalAddressScore; //IF (LEFT.#EXPAND(appendPrefix + 'AddressScore') > AveAddressScore, FinalAddressScore, 0);
				SELF.#EXPAND(appendPrefix + 'FinalProfessionalScore') 							:= LEFT.#EXPAND(appendPrefix + 'ProfessionalScore');
				SELF := LEFT;
				));
		
    RETURN FinalScoredFile;
		// RETURN Addr_Tab;
ENDMACRO;