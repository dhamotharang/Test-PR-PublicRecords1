import ML;
EXPORT macComputeSuspectProviderAddressScoreV3 (Infile, 
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
																									 SharedAddressPatientCount = 0, // Added for RAMPS-466
																									 DMEIndicator = '',
																									 DMEOutlierRank = '',
																									 LABIndicator = '',
																									 LABOutlierRank = '',
																									 SingleAddressIndicator = '',
																									 SingleAddressProviderCount = 0, //Added for RAMPS-431
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
																									 NoOfProviderAtAddress = 0,
																									 NoOfPatientAtAddress = 0,
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
 																									 CurrentStateExclusionImpactAmount = 0,
																									 CurrentOIGExclusionImpactAmount = 0,
																									 CurrentOPMExclusionImpactAmount = 0,
																									 PastStateExclusionImpactAmount = 0,
																									 PastOIGExclusionImpactAmount = 0,
																									 PastOPMExclusionImpactAmount = 0,
																									 CurrentRevoedMedicalLicenseImpactAmount = 0,
																									 PastRevokedMedicalLicenseImpactAmount = 0,
																									 ExpiredMedicalLicenseImpactAmount = 0,
																									 DeactivatedNPIImpactedAmount = 0,
																									 DeceasedPatientImpactAmount = 0,
																									 DeceasedProviderImpactAmount = 0,
																									 BankruptcyClaimImpactAmount = 0,
																									 FelonyConvictionImpactAmount = 0,
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
																									 ProviderImpactAmount=0,
																									 AddressImpactAmount=0,
																									 ImpactScoreRange = 0,
																									 PercentileRange = 0,
																									 appendPrefix = '\'\''
																									 ) := FUNCTIONMACRO
	
    IMPORT ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3 as ScoringAlgorithmsV3;

    // Make sure the scoringThreshold value is 0-100
    // boundedScoringThreshold := MAX(MIN(suspectAddressThreshold, 100), 0);

    LOCAL ReasonCode_t := ScoringAlgorithmsV3.ReasonCode_t;

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

				evalSharedAddress									:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalSharedAddress 						(L.SharedAddressIndicator,SharedAddressSwitch,SharedAddressScore,L.NoOfProviderAtAddress,L.NoOfPatientAtAddress);				
				evalDMEOutlier										:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalDMEOutlier								(L.DMEIndicator, DMESwitch, DMEScore, L.DMEOutlierRank, L.HighPaidAmountPerPatient, L.HighPaidAmountPerClaim, L.DMEPatientMedian, L.DMEClaimMedian, PercentileRange);				
				evalLABOutlier										:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalLABOutlier								(L.LABIndicator, LABSwitch, LABScore, L.LABOutlierRank, L.HighPaidAmountPerPatient, L.HighPaidAmountPerClaim, L.LABPatientMedian, L.LABClaimMedian, PercentileRange);
				isSingleAddress := L.PrimaryName <> '' and L.PrimaryRange = L.PractisePrimaryrange and L.PreDirectional = L.PractisePredirectional and L.PrimaryName = L.PractisePrimaryname and L.AddressSuffix = L.PractiseAddresssuffix and L.PostDirectional = L.PractisePostdirectional and L.SecondaryRange = L.PractiseSecondaryrange and L.Zip5 = L.PractiseZip5;
				
				evalSingleAddress 								:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalSingleAddress							(L.SingleAddressIndicator, SingleAddressSwitch, SingleAddressScore, L.SingleAddressProviderCount, isSingleAddress);				
				evalRecentNPI 										:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalRecentNPI									(L.TotalNPICount, L.RecentNPICount, RecentNPISwitch, RecentNPIScore);	
        evalStudentNPI 										:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalStudentNPI								(L.TotalNPICount, L.StudentNPICount, StudentNPISwitch, StudentNPIScore);	
				evalDND 													:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalDND												(L.DNDIndicator, L.TotalChargeAmount, L.TotalClaimCount, DNDSwitch, DNDScore);
				evalVacancy 											:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalVacancy										(L.VacantAddressActivityIndicator, VacantSwitch, VacantScore);
				evalMailDrop 											:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalMailDrop									(L.MailDropIndicator, L.TotalClaimCount, L.TotalPaidAmount, MailDropSwitch, MailDropScore);
				evalPOBox 												:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalPOBox											(L.AddressType, L.UsageType, L.TotalClaimCount, L.TotalPaidAmount,POBoxSwitch, POBoxScore);
				evalPrison 												:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalPrison										(L.PrisonIndicator, PrisonSwitch, PrisonScore, L.TotalClaimCount, L.TotalPaidAmount);
				evalresidential 									:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalResidential								(L.ResidentialAddressIndicator, L.TotalClaimCount, L.TotalPaidAmount, ResidentialSwitch, ResidentialScore);


	        // Score each element
				evalActiveStateExclusion 					:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalActiveStateExclusion 			(L.ActiveStateExclusion, ActiveStateExclusionSwitch, ActiveStateExclusionScore, L.ActiveLicenseExclusionState, L.ActiveLicenseExclusionDate, L.CurrentStateExclusionImpactAmount);				
				evalActiveOIGExclusion 						:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalActiveOIGExclusion 				(L.ActiveOIGExclusion, ActiveOIGExclusionSwitch, ActiveOIGExclusionScore, L.ActiveOIGExclusionDate, L.CurrentOIGExclusionImpactAmount);				
				evalActiveOPMExclusion 						:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalActiveOPMExclusion 				(L.ActiveOPMExclusion, ActiveOPMExclusionSwitch, ActiveOPMExclusionScore, L.ActiveOPMExclusionDate, L.CurrentOPMExclusionImpactAmount);				
				evalActiveSanctionRevocation 			:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalActiveSanctionRevocation	(L.ActiveLicenseRevocation, ActiveLicenseRevocationSwitch, ActiveLicenseRevocationScore, L.ActiveLicenseRevocationState, L.ActiveLicenseRevocationDate, L.CurrentRevoedMedicalLicenseImpactAmount);				

				evalPastStateExclusion 						:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalPastStateExclusion				(L.PastStateExclusion, PastStateExclusionSwitch, PastStateExclusionScore, L.StateExclusionReinstatedState, L.ActiveLicenseExclusionDate, L.StateExclusionReinstatedDate, L.PastStateExclusionImpactAmount);				
				evalPastOIGExclusion 							:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalPastOIGExclusion					(L.PastOIGExclusion, PastOIGExclusionSwitch, PastOIGExclusionScore, L.ActiveOIGExclusionDate, L.OIGExclusionReinstatedDate, L.PastOIGExclusionImpactAmount);				
				evalPastOPMExclusion 							:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalPastOPMExclusion					(L.PastOPMExclusion, PastOPMExclusionSwitch, PastOPMExclusionScore, L.ActiveOPMExclusionDate, L.OPMExclusionReinstatedDate, L.PastOPMExclusionImpactAmount);				
				/* Fix this line */
				evalReinstatedSanctionRevocation 	:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalPastLicenseRevocation			(L.PastLicenseRevocation, PastLicenseRevocationSwitch, PastLicenseRevocationScore, L.LicenseRevocationReinstatedState, L.LicenseRevocationReinstatedDate, L.PastRevokedMedicalLicenseImpactAmount, L.ActiveLicenseRevocationDate);				
				evalLicenseExpired 								:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalLicenseExpired 						(L.LicenseExpiredFlag, LicenseExpiredSwitch, ExpiredLicenseScore, L.ExpiredLicenseNumberDate, L.ExpiredLicenseNumber, L.ExpiredLicenseState, L.TotalLNPIDChargeAmount, L.ExpiredMedicalLicenseImpactAmount);		
				evalDeaExpired 										:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalDEAExpired								(L.DEAExpiredFlag, DEAExpiredSwitch, DEAExpiredScore, L.ExpiredDEANumber, L.ExpiredDEADate, L.TotalLNPIDChargeAmount);												

				evalDeceased 											:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalDeceased									(L.DeceasedFlag, L.DateofDeath, DeceasedSwitch, DeceasedScore , L.TotalLNPIDChargeAmount, L.LNPID, L.DeceasedProviderImpactAmount);												
				evalBankruptcy 										:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalBankruptcy								(L.BankruptcyFlag, BankruptcySwitch, BankruptcyScore, L.BankruptcyFiledDate, L.LNPID, L.BankruptcyClaimImpactAmount);	
				evalCriminalHistory								:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalCriminalHistory						(L.CriminalHistoryFlag, CriminalHistorySwitch, CriminalHistoryScore, L.ConvictionDate, L.LNPID, L.FelonyConvictionImpactAmount);
				evalDeceasedPatients							:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalDeceasedPatients					(L.DeceasedPatientsFlag, DeceasedPatientsSwitch, DeceasedPatientsScore, L.DeceasedPatientCount, L.PatientCount, L.PatientDOD , L.TotalChargeAmount, L.DeceasedPatientImpactAmount);		
				evalLargePatientGroups						:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalLargePatientGroups				(L.LargePatientGroupFlag, LargePatientGroupSwitch, LargePatientGroupScore, L.LargePatientCount, L.LargePatientAddress);	
				evalLicenseInactive 							:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalLicenseInactive						(L.LicenseInactiveFlag, LicenseInactiveSwitch, LicenseInactiveScore, L.InactiveLicenseState, L.TotalLNPIDChargeAmount);		
				evalNPIDeactivated	 							:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalNPIDeactivated						(L.NPIDeactivatedFlag, NPIDeactivatedSwitch, NPIDeactivatedScore, L.NPIDeactivatedDate, L.TotalLNPIDChargeAmount, L.DeactivatedNPIImpactedAmount);			

				evalLongPatientDrivingDistance		:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalLongPatientDrivingDistance(L.LongPatientDrivingDistanceIndicator, (INTEGER)L.LongPatientDrivingDistanceOutlierRank, LongPatientDrivingDistanceSwitch, LongPatientDrivingDistanceScore, L.NoOfPatientsDrivingLongDistance, L.PatientCount, L.AveDistance);						
				evalHighPaidDollarsPerPatient			:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalHighPaidDollarsPerPatient	(L.HighPaidDollarsPerPatientIndicator, (INTEGER)L.HighPaidDollarsPerPatientOutlierRank, HighPaidDollarsPerPatientSwitch, HighPaidDollarsPerPatientScore, L.HighPaidAmountPerPatient, L.HighPaidAmountPerPatientMedian, PercentileRange);							
				evalHighPaidDollarsPerClaim				:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalHighPaidDollarsPerClaim		(L.HighPaidDollarsPerClaimIndicator, (INTEGER)L.HighPaidDollarsPerClaimOutlierRank, HighPaidDollarsPerClaimSwitch, HighPaidDollarsPerClaimScore, L.HighPaidAmountPerClaim, L.HighPaidAmountPerClaimMedian, PercentileRange);											
				evalHighNumberOfPatients					:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalHighNumberOfPatients			(L.HighNumberOfPatientsIndicator, (INTEGER)L.HighNumberOfPatientsOutlierRank, HighNumberOfPatientsSwitch, HighNumberOfPatientsScore, L.PatientCount,L.PatientMedian, PercentileRange);											
				evalHighNumberOfClaims						:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalHighNumberOfClaims				(L.HighNumberOfClaimsIndicator, (INTEGER)L.HighNumberOfClaimsOutlierRank, HighNumberOfClaimsSwitch, HighNumberOfClaimsScore, L.TotalClaimCount,L.ClaimMedian, PercentileRange);															
				evalHighPaidDollars								:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalHighPaidDollars						(L.HighPaidDollarsIndicator, (INTEGER)L.HighPaidDollarsOutlierRank, HighPaidDollarsSwitch, HighPaidDollarsScore, L.TotalChargeAmount, L.TotalPaidAmount, L.HighPaidAmountMedian, PercentileRange);															
				
				evalInNetworkCurrentExclusion			:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalInNetworkActiveExclusion	(L.InNetworkCurrentExclusionFlag, InNetworkCurrentExclusionSwitch, InNetworkCurrentExclusionScore);			
				evalInNetworkCurrentRevocation		:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalInNetworkActiveRevocation	(L.InNetworkCurrentRevocationFlag, InNetworkCurrentRevocationSwitch, InNetworkCurrentRevocationScore);			
				evalInNetworkPastExclusion				:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalInNetworkPastExclusion		(L.InNetworkPastExclusionFlag, InNetworkPastExclusionSwitch, InNetworkPastExclusionScore);			
				evalInNetworkPastRevocation				:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalInNetworkPastRevocation		(L.InNetworkPastRevocationFlag, InNetworkPastRevocationSwitch, InNetworkPastRevocationScore);			
				evalInNetworkCriminal							:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalInNetworkBankruptcy				(L.InNetworkhasBankruptcy, InNetworkhasBankruptcySwitch, InNetworkhasBankruptcyScore);			
				evalInNetworkBankruptcy						:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalInNetworkCriminal					(L.InNetworkhasCriminalHistory, InNetworkhasCriminalHistorySwitch, InNetworkhasCriminalHistoryScore);			
				evalOutNetworkCurrentExclusion		:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalOutNetworkActiveExclusion	(L.OutNetworkCurrentExclusionFlag, OutNetworkCurrentExclusionSwitch, OutNetworkCurrentExclusionScore);			
				evalOutNetworkCurrentRevocation		:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalOutNetworkActiveRevocation(L.OutNetworkCurrentRevocationFlag, OutNetworkCurrentRevocationSwitch, OutNetworkCurrentRevocationScore);			
				evalOutNetworkPastExclusion				:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalOutNetworkPastExclusion		(L.OutNetworkPastExclusionFlag, OutNetworkPastExclusionSwitch, OutNetworkPastExclusionScore);			
				evalOutNetworkPastRevocation			:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalOutNetworkPastRevocation	(L.OutNetworkPastRevocationFlag, OutNetworkPastRevocationSwitch, OutNetworkPastRevocationScore);			
				evalOutNetworkCriminal						:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalOutNetworkCriminal			  (L.OutNetworkhasCriminalHistory, OutNetworkhasCriminalHistorySwitch, OutNetworkhasCriminalHistoryScore);			
				evalOutNetworkBankruptcy					:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalOutNetworkBankruptcy			(L.OutNetworkhasBankruptcy, OutNetworkhasBankruptcySwitch, OutNetworkhasBankruptcyScore);			


				evalRelativeBankruptcy						:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalRelativeBankruptcy				(L.RelativeBankruptcyFlag, RelativeAssocBankruptcySwitch, RelativeAssocBankruptcyScore, L.LNPID);		
				evalAssocBankruptcy								:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalAssocBankruptcy						(L.AssociateBankruptcyFlag, RelativeAssocBankruptcySwitch, RelativeAssocBankruptcyScore, L.LNPID);						
				evalRelativeCriminal							:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalRelativeCriminal					(L.RelativeCriminalFlag, RelativeAssocCriminalSwitch, RelativeAssocCriminalScore, L.LNPID);			
				evalAssocCriminal									:= ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.EvalAssocCriminal							(L.AssociateCriminalFlag, RelativeAssocCriminalSwitch, RelativeAssocCriminalScore, L.LNPID);			

				
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
				ImpactScore																			 										:= 	25 * L.ImpactScoreRange;
				ProfessionalScore																										:= SELF.#EXPAND(appendPrefix + 'PastExclusionScore')
																																						+  SELF.#EXPAND(appendPrefix + 'PastRevocationScore')
																																						+  SELF.#EXPAND(appendPrefix + 'DEAExpiredScore')
																																						+  SELF.#EXPAND(appendPrefix + 'LargePatientGroupScore')
																																						+  SELF.#EXPAND(appendPrefix + 'LicenseInactiveScore')
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
																																						+  SELF.#EXPAND(appendPrefix + 'RelativeAssocBankruptcyScore')
																																						+  ImpactScore;
	
				SELF.#EXPAND(appendPrefix + 'ProfessionalScore') 										:= ProfessionalScore;
				// SELF.#EXPAND(appendPrefix + 'ProfessionalScore') 										:= SELF.#EXPAND(appendPrefix + 'CurrentExclusionScore') 
																																						// +  SELF.#EXPAND(appendPrefix + 'CurrentLicenseRevocationScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'PastExclusionScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'PastRevocationScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'LicenseExpiredScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'DEAExpiredScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'DeceasedScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'BankruptcyScore')																												
																																						// +  SELF.#EXPAND(appendPrefix + 'CriminalHistoryScore')																												
																																						// +  SELF.#EXPAND(appendPrefix + 'DeceasedPatientsScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'LargePatientGroupScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'LicenseInactiveScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'NPIDeactivatedScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'LongPatientDrivingDistanceScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'HighPaidDollarsPerPatientScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'HighPaidDollarsPerClaimScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'HighNumberOfPatientsScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'HighNumberOfClaimsScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'HighPaidDollarsScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'InNetworkAssocCurrentExclusionScore') 
																																						// +	 SELF.#EXPAND(appendPrefix + 'InNetworkAssocCurrentRevocationScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'InNetworkAssocPastExclusionScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'InNetworkAssocPastRevocationScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'InNetworkAssocBankruptcyScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'InNetworkAssocCriminalHistoryScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocCurrentExclusionScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocCurrentExclusionScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocPastExclusionScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocPastRevocationScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocBankruptcyScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'OutNetworkAssocCriminalHistoryScore')
																																						// +	 SELF.#EXPAND(appendPrefix + 'RelativeAssocCriminalScore')
																																						// +  SELF.#EXPAND(appendPrefix + 'RelativeAssocBankruptcyScore')
																																						// +  ImpactScore;

				SELF.#EXPAND(appendPrefix + 'MedianAddressScore')										:=	0;
				SELF.#EXPAND(appendPrefix + 'MedianProfessionalScore')							:=	0;
				SELF.#EXPAND(appendPrefix + 'MaxProfScoreAtAddressScore')						:=	0;
				SELF.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') 			:= 	0;
				SELF.#EXPAND(appendPrefix + 'IncrementPaidAmountCount') 						:= 	0;
				
				SELF.#EXPAND(appendPrefix + 'FinalAddressScore') 										:= 	0;
				SELF.#EXPAND(appendPrefix + 'FinalProfessionalScore') 							:= 	0;
			
        SELF.#EXPAND(appendPrefix + 'reasons') := join(reasonDS(reason != ''),ComputeSuspectProviderAddressScore.ScoringAlgorithmsV3.reasonDescriptions,left.reason = right.reasonCode,transform(ReasonLayout, self.description := right.description, SELF.Value := left.Value; self := left;));

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

		// Addr_Tab := TABLE (ScoredFile((INTEGER)LNPID > 0 and AddressExclusionFlag <> 'Y' and TotalPaidAmount > 0.00 and #EXPAND(appendPrefix + 'ProfessionalScore') > 0), {PrimaryRange, PreDirectional, PrimaryName, AddressSuffix, PostDirectional, SecondaryRange, City, State, Zip5, 
				// HighProfScore := MAX (GROUP, #EXPAND(appendPrefix + 'ProfessionalScore')),
				// SuspectProviderAtLocationCount := COUNT (GROUP, ScoredFile.#EXPAND(appendPrefix + 'ProfessionalScore') > AveProfessionalScore);
				// IncrementPaidAmountCount := ROUND((INTEGER)AddressPaidAmount / 50000);
				// },PrimaryRange, PreDirectional, PrimaryName, AddressSuffix, PostDirectional, SecondaryRange, City, State, Zip5, MERGE);

		Addr_Tab := TABLE (ScoredFile((INTEGER)LNPID > 0 and AddressExclusionFlag <> 'Y' and ProviderImpactAmount > 0.00 and #EXPAND(appendPrefix + 'ProfessionalScore') > 0), {PrimaryRange, PreDirectional, PrimaryName, AddressSuffix, PostDirectional, SecondaryRange, City, State, Zip5, 
				HighProfScore := SUM (GROUP, #EXPAND(appendPrefix + 'ProfessionalScore')),
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
																											// SELF.#EXPAND(appendPrefix + 'MaxProfScoreAtAddressScore') := RIGHT.HighProfScore; 
																											SELF.#EXPAND(appendPrefix + 'MaxProfScoreAtAddressScore') := MAP (LEFT.AddressImpactAmount = 0 => 0,
																												  LEFT.AddressImpactAmount > 0 		  AND LEFT.AddressImpactAmount <= 500 	=> 25,
																													LEFT.AddressImpactAmount > 500 		AND LEFT.AddressImpactAmount <= 1000 	=> 50, 
																													LEFT.AddressImpactAmount > 1000	 	AND LEFT.AddressImpactAmount <= 5000 	=> 75, 										  
																													LEFT.AddressImpactAmount > 5000 	AND LEFT.AddressImpactAmount <= 10000 	=> 100, 
																													LEFT.AddressImpactAmount > 10000 	AND LEFT.AddressImpactAmount <= 25000	=> 125, 										  										  
																													LEFT.AddressImpactAmount > 25000 	AND LEFT.AddressImpactAmount <= 50000 	=> 150, 
																													LEFT.AddressImpactAmount > 50000 	AND LEFT.AddressImpactAmount <= 100000 	=> 175, 
																													LEFT.AddressImpactAmount > 100000	AND LEFT.AddressImpactAmount <= 500000 	=> 200, 
																													LEFT.AddressImpactAmount > 500000 AND LEFT.AddressImpactAmount <= 1000000 => 225, 250);
																													
																											SELF.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') := RIGHT.SuspectProviderAtLocationCount;
																											SELF.#EXPAND(appendPrefix + 'IncrementPaidAmountCount') := RIGHT.IncrementPaidAmountCount;
																											SELF := LEFT;), LEFT OUTER, HASH);
			
		FinalScoredFile := PROJECT (AppendMaxProfScore, TRANSFORM(ScoreLayout,
				SELF.#EXPAND(appendPrefix + 'MedianAddressScore')										:=	AveAddressScore;
				SELF.#EXPAND(appendPrefix + 'MedianProfessionalScore')							:=	AveProfessionalScore;
				LocationExtraScore 																									:=  0; //IF ((INTEGER) LEFT.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') > 1, (LEFT.#EXPAND(appendPrefix + 'IncrementPaidAmountCount') * 5),0);
				// LocationExtraScore 																									:=  IF ((INTEGER)LEFT.#EXPAND(appendPrefix + 'AddressScore') > AveAddressScore, (LEFT.#EXPAND(appendPrefix + 'IncrementPaidAmountCount') * 5),0);
				ExcludeProviderWithHighScore																						:= IF (LEFT.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') > 0, LEFT.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') - 1, LEFT.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount'));
			  FinalAddressScore		:= LEFT.#EXPAND(appendPrefix + 'AddressScore') + LEFT.#EXPAND(appendPrefix + 'MaxProfScoreAtAddressScore');					
/*
				FinalAddressScore		:=	
				  MAP
					(
					  (INTEGER) LEFT.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') > 1 
			      => LEFT.#EXPAND(appendPrefix + 'AddressScore') + LEFT.#EXPAND(appendPrefix + 'MaxProfScoreAtAddressScore'),
																					// ExcludeProviderWithHighScore * 10,
			      // => LEFT.#EXPAND(appendPrefix + 'AddressScore') + LEFT.#EXPAND(appendPrefix + 'MaxProfScoreAtAddressScore') + 
																					// ExcludeProviderWithHighScore * 10,
						   // (LEFT.#EXPAND(appendPrefix + 'SuspectProviderAtLocationCount') * 10),
 						   // (LEFT.#EXPAND(appendPrefix + 'IncrementPaidAmountCount') * 5), 
  					   // LocationExtraScore, 
						LEFT.#EXPAND(appendPrefix + 'AddressScore') + LEFT.#EXPAND(appendPrefix + 'ProfessionalScore')
					);
	*/				
				SELF.#EXPAND(appendPrefix + 'FinalAddressScore') 										:= FinalAddressScore; //IF (LEFT.#EXPAND(appendPrefix + 'AddressScore') > AveAddressScore, FinalAddressScore, 0);
				SELF.#EXPAND(appendPrefix + 'FinalProfessionalScore') 							:= LEFT.#EXPAND(appendPrefix + 'ProfessionalScore');
				SELF := LEFT;
				));
		
    RETURN FinalScoredFile;
		// RETURN Addr_Tab;
ENDMACRO;