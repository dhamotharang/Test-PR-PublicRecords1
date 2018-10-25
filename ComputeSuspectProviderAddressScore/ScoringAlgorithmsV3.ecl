IMPORT Std;

EXPORT ScoringAlgorithmsV3 := MODULE

    // Once-per-run calculation of the current date, used for date seen scoring
    SHARED today := Std.Date.Today() : INDEPENDENT;
    
    // Once-per-run calculation of a recent vacation year.  Records are flagged
    // if they have a vacation begin date that is greater than or equal to
    // this value.
    SHARED recentVacationYearStr := (STRING)(Std.Date.Year(today) - 1) : INDEPENDENT;

    // Maximum scores for each attribute we're checking.  The actual score
    // returned by a scoring routine will be between zero and these values.
    SHARED MAX_SHARED_ADDRESS_INDICATOR 				:=  15;
    SHARED MAX_DME_OUTLIER_INDICATOR	 					:=  15;
    SHARED MAX_LAB_OUTLIER_INDICATOR 						:=  15;
    SHARED MAX_SINGLE_ADDRESS_INDICATOR 				:=  15;
    SHARED MAX_RECENT_NPI_INDICATOR 						:=  10;
    SHARED MAX_STUDENT_NPI_INDICATOR 						:=  10;

    SHARED MAX_DND_INDICATOR 										:=   5;
    SHARED MAX_VACANCY_INDICATOR								:=   5;
    SHARED MAX_DROP_INDICATOR							 			:=   5;
    SHARED MAX_PO_BOX_INDICATOR 								:=   5;
    SHARED MAX_PRISON_INDICATOR 								:=   5;
    SHARED MAX_RESIDENTIAL_INDICATOR 						:=   5;

    SHARED MAX_ACTIVE_EXCLUSION									:=  25;
		SHARED MAX_ACTIVE_REVOCATION								:=  25;
    SHARED MAX_REINSTATED_EXCLUSION							:=  20;
		SHARED MAX_REINSTATED_REVOCATION						:=  20;
		SHARED MAX_LICENSE_EXPIRED									:=	20;
		SHARED MAX_DEA_EXPIRED											:=	15;
		SHARED MAX_DECEASED													:=	15;
		SHARED MAX_BANKRUPTCY												:=	15;
		SHARED MAX_CRIMINAL_HISTORY									:=	15;
		SHARED MAX_DECEASED_PATIENTS								:=	15;
		SHARED MAX_LARGE_PATIENT_GROUPS							:=	15;
		SHARED MAX_LICENSE_INACTIVE									:=	10;
		SHARED MAX_NPI_DEACTIVATED									:=	10;
		
		SHARED MAX_LONG_PATIENT_DRIVING_DISTANCE		:=	15;
		SHARED MAX_HIGH_PAID_DOLLARS_PER_PATIENT		:=	10;
		SHARED MAX_HIGH_PAID_DOLLARS_PER_CLAIM			:=	10;
		SHARED MAX_HIGH_NUMBER_OF_PATIENTS					:=	10;
		SHARED MAX_HIGH_NUMBER_OF_CLAIMS						:=	10;
		SHARED MAX_HIGH_PAID_DOLLARS								:=	10;
		
		SHARED MAX_IN_ACTIVE_EXCLUSION							:=	10;		
		SHARED MAX_IN_ACTIVE_REVOCATION							:=	10;		
		SHARED MAX_IN_HAD_ACTIVE_EXCLUSION					:=	10;		
		SHARED MAX_IN_HAD_ACTIVE_REVOCATION					:=	10;		
		SHARED MAX_IN_BANKRUPTCY										:=	10;		
		SHARED MAX_IN_CRIMINAL_HISTORY							:=	10;		
		SHARED MAX_OUT_ACTIVE_EXCLUSION							:=	10;		
		SHARED MAX_OUT_ACTIVE_REVOCATION						:=	10;		
		SHARED MAX_OUT_HAD_ACTIVE_EXCLUSION					:=	10;		
		SHARED MAX_OUT_HAD_ACTIVE_REVOCATION				:=	10;		
		SHARED MAX_OUT_BANKRUPTCY										:=	10;		
		SHARED MAX_OUT_CRIMINAL_HISTORY							:=	10;		

		SHARED MAX_REL_ASSOC_BANKRUPTCY							:=	10;		
		SHARED MAX_REL_ASSOC_CRIMINAL_HISTORY				:=	10;		
		
		
    // Sum of all possible maximum scores.  This is used to normalize the total
    // score to a range of 0-100.
		
		EXPORT MAX_PROFESSIONAL_SCORE := 
													MAX_ACTIVE_EXCLUSION
												+	MAX_ACTIVE_REVOCATION
												+	MAX_REINSTATED_EXCLUSION
												+	MAX_REINSTATED_REVOCATION
												+	MAX_LICENSE_EXPIRED
												+	MAX_DEA_EXPIRED
												+	MAX_DECEASED
												+	MAX_BANKRUPTCY
												+	MAX_CRIMINAL_HISTORY
												+	MAX_DECEASED_PATIENTS
												+	MAX_LARGE_PATIENT_GROUPS
												+	MAX_LICENSE_INACTIVE
												+ MAX_NPI_DEACTIVATED
												;
    // Flag addresses that haven't been reported within this many months (inclusives)
    SHARED LAST_DATE_SEEN_DELTA_THRESHOLD_IN_MONTHS := 12;

    // Flag addresses that are newer than this many months (inclusive)
    SHARED FIRST_DATE_SEEN_DELTA_THRESHOLD_IN_MONTHS := 2;

    EXPORT ReasonCode_t := STRING4;

    // Defined reason codes and their descriptions.  Note that the attribute
    // names are similar, with only '_DESC' appended to the descriptions.
		
		SHARED REASON_VACANCY 												:= 'A001';
    SHARED REASON_VACANCY_DESC 										:= 'Vacant';
		SHARED REASON_DND 														:= 'A002';
    SHARED REASON_DND_DESC 												:= 'Do Not Deliver';
		SHARED REASON_DROP 														:= 'A003';
    SHARED REASON_DROP_DESC 											:= 'Mail Drop';
    SHARED REASON_POBOX 													:= 'A004';
    SHARED REASON_POBOX_DESC 											:= 'PO Box';
		SHARED REASON_PRISON 													:= 'A005';
    SHARED REASON_PRISON_DESC 										:= 'Prison';
		SHARED REASON_RESIDENTIAL 										:= 'A006';
    SHARED REASON_RESIDENTIAL_DESC 								:= 'Residential Address';
		SHARED REASON_SINGLE_ADDRESS 									:= 'A007';
    SHARED REASON_SINGLE_ADDRESS_DESC 						:= 'Single Address';
    SHARED REASON_SHARED_ADDRESS 									:= 'A008';
    SHARED REASON_SHARED_ADDRESS_DESC 						:= 'Provider address match with patients';
		SHARED REASON_RECENT_NPI											:= 'A009';
    SHARED REASON_RECENT_NPI_DESC 								:= 'Recent NPI Concentration';
		SHARED REASON_STUDENT_NPI											:= 'A010';
    SHARED REASON_STUDENT_NPI_DESC 								:= 'Student NPI Concentration';

    SHARED REASON_ACTIVE_STATE_EXCLUSION 					:= 'B001';
    SHARED REASON_ACTIVE_STATE_EXCLUSION_DESC 		:= 'Current State Exclusion';
    SHARED REASON_ACTIVE_OIG_EXCLUSION 						:= 'B002';
    SHARED REASON_ACTIVE_OIG_EXCLUSION_DESC 			:= 'Current OIG Exclusion';
    SHARED REASON_ACTIVE_OPM_EXCLUSION 						:= 'B003';
    SHARED REASON_ACTIVE_OPM_EXCLUSION_DESC 			:= 'Current OPM Exclusion';
		SHARED REASON_REINSTATED_STATE_EXCLUSION			:= 'B004';
    SHARED REASON_REINSTATED_STATE_EXCLUSION_DESC := 'State Exclusion (Past 5Y)';
    SHARED REASON_REINSTATED_OIG_EXCLUSION				:= 'B005';
    SHARED REASON_REINSTATED_OIG_EXCLUSION_DESC 	:= 'OIG Exclusion (Past 5Y)';
    SHARED REASON_REINSTATED_OPM_EXCLUSION				:= 'B006';
    SHARED REASON_REINSTATED_OPM_EXCLUSION_DESC 	:= 'OPM Exclusion (Past 5Y)';


    SHARED REASON_ACTIVE_REVOCATION								:= 'C001';
    SHARED REASON_ACTIVE_REVOCATION_DESC 					:= 'Current Revoked Medical License';
    SHARED REASON_REINSTATED_REVOCATION						:= 'C002';
    SHARED REASON_REINSTATED_REVOCATION_DESC 			:= 'Revoked Medical License (Past 5Y)';
		SHARED REASON_LICENSE_EXPIRED 								:= 'C003';
    SHARED REASON_LICENSE_EXPIRED_DESC						:= 'Expired Medical License';
    SHARED REASON_LICENSE_INACTIVE 								:= 'C004';
    SHARED REASON_LICENSE_INACTIVE_DESC						:= 'Inactive Medical License';
    SHARED REASON_DEA_EXPIRED			 								:= 'C005';
    SHARED REASON_DEA_EXPIRED_DESC 								:= 'Expired DEA License';

    SHARED REASON_NPI_DEACTIVATED 								:= 'D001';
    SHARED REASON_NPI_DEACTIVATED_DESC	 					:= 'Deactivated NPI';
    SHARED REASON_DECEASED_PROVIDER								:= 'D002';
    SHARED REASON_DECEASED_PROVIDER_DESC	 				:= 'Potentially deceased Provider';

    SHARED REASON_DME_OUTLIER											:= 'E001';
    SHARED REASON_DME_OUTLIER_DESC 								:= 'High Paid DMEs';
		SHARED REASON_LAB_OUTLIER											:= 'E002';
    SHARED REASON_LAB_OUTLIER_DESC 								:= 'High Paid Labs';

    SHARED REASON_HIGH_PAID_DOLLARS										:= 'F001';
    SHARED REASON_HIGH_PAID_DOLLARS_DESC 							:= 'High Paid Dollars';
    SHARED REASON_HIGH_PAID_DOLLARS_PER_PATIENT 			:= 'F002';
    SHARED REASON_HIGH_PAID_DOLLARS_PER_PATIENT_DESC 	:= 'High Paid Dollars Per Patient';
    SHARED REASON_HIGH_PAID_DOLLARS_PER_CLAIM 				:= 'F003';
    SHARED REASON_HIGH_PAID_DOLLARS_PER_CLAIM_DESC 		:= 'High Paid Dollars Per Claim';
    SHARED REASON_HIGH_NO_OF_CLAIMS 									:= 'F004';
    SHARED REASON_HIGH_NO_OF_CLAIMS_DESC 							:= 'High Claim Volume';

    SHARED REASON_HIGH_NO_OF_PATIENT 									:= 'G001';
    SHARED REASON_HIGH_NO_OF_PATIENT_DESC 						:= 'High Patient Volume';
    SHARED REASON_DECEASED_PATIENTS										:= 'G002';
    SHARED REASON_DECEASED_PATIENTS_DESC 							:= 'Treating potentially deceased patients';
    SHARED REASON_LARGE_PATIENT_GROUP									:= 'G003';
    SHARED REASON_LARGE_PATIENT_GROUP_DESC						:= 'Treating patient groups living at the same address';

    SHARED REASON_LONG_PATIENT_DRIVING_DISTANCE 			:= 'H001';
    SHARED REASON_LONG_PATIENT_DRIVING_DISTANCE_DESC 	:= 'Flagged Distance';

    SHARED REASON_PROF_ASSOC_EXC_SANC									:= 'I001';
    SHARED REASON_PROF_ASSOC_EXC_SANC_DESC						:= 'Professional association to excluded providers (Current)';
    SHARED REASON_PROF_ASSOC_REV_SANC									:= 'I002';
    SHARED REASON_PROF_ASSOC_REV_SANC_DESC	 					:= 'Professional association to revoked license providers (Current)';
    SHARED REASON_PROF_ASSOC_PAST_EXC_SANC						:= 'I003';
    SHARED REASON_PROF_ASSOC_PAST_EXC_SANC_DESC	 			:= 'Professional association to excluded providers (Past 5Y)';
    SHARED REASON_PROF_ASSOC_PAST_REV_SANC						:= 'I004';
    SHARED REASON_PROF_ASSOC_PAST_REV_SANC_DESC	 			:= 'Professional association to revoked license providers (Past 5Y)';
    SHARED REASON_PROF_ASSOC_BANK											:= 'I005';
    SHARED REASON_PROF_ASSOC_BANK_DESC								:= 'Professional association to a person with Bankruptcy claim';
    SHARED REASON_PROF_ASSOC_FELON										:= 'I006';
    SHARED REASON_PROF_ASSOC_FELON_DESC	 							:= 'Professional connection to an individual potentially associated with a felony conviction';
    SHARED REASON_PER_ASSOC_BANK											:= 'I007';
    SHARED REASON_PER_ASSOC_BANK_DESC									:= 'Personal association to a person with Bankruptcy claim';
    SHARED REASON_PER_ASSOC_CONVICT										:= 'I008';
    SHARED REASON_PER_ASSOC_CONVICT_DESC	 						:= 'Personal connection to an individual potentially associated with a felony conviction';
    SHARED REASON_RELATED_BANKRUPTCY									:= 'I009';
    SHARED REASON_RELATED_BANKRUPTCY_DESC							:= 'Related to a person with Bankruptcy claim';
    SHARED REASON_RELATED_CONVICT											:= 'I010';
    SHARED REASON_RELATED_CONVICT_DESC								:= 'Related to an individual potentially associated with a felony conviction';

    SHARED REASON_BANKRUPTCY													:= 'J001';
    SHARED REASON_BANKRUPTCY_DESC	 										:= 'Bankruptcy Claim';
    SHARED REASON_FELON																:= 'J002';
    SHARED REASON_FELON_DESC													:= 'Potentially associated with a felony conviction';

		
		
		// Layout of dataset containing reason codes and their descriptions.
    EXPORT ReasonDescriptionLayout := RECORD
        ReasonCode_t    reasonCode;
        STRING          description;
    END;

    // Simple dataset containing all reason codes and their descriptions.
    EXPORT reasonDescriptions := DATASET
        (
            [
							{REASON_VACANCY     									,REASON_VACANCY_DESC},
							{REASON_DND 	    										,REASON_DND_DESC}, 				
							{REASON_DROP 													,REASON_DROP_DESC}, 				
							{REASON_POBOX 												,REASON_POBOX_DESC}, 				
							{REASON_PRISON 												,REASON_PRISON_DESC}, 				
							{REASON_RESIDENTIAL 									,REASON_RESIDENTIAL_DESC}, 			
							{REASON_SINGLE_ADDRESS 								,REASON_SINGLE_ADDRESS_DESC}, 			
							{REASON_SHARED_ADDRESS 								,REASON_SHARED_ADDRESS_DESC}, 			
							{REASON_RECENT_NPI										,REASON_RECENT_NPI_DESC}, 			
							{REASON_STUDENT_NPI										,REASON_STUDENT_NPI_DESC}, 			

							{REASON_ACTIVE_STATE_EXCLUSION 				,REASON_ACTIVE_STATE_EXCLUSION_DESC}, 		
							{REASON_ACTIVE_OIG_EXCLUSION 					,REASON_ACTIVE_OIG_EXCLUSION_DESC}, 		
							{REASON_ACTIVE_OPM_EXCLUSION 					,REASON_ACTIVE_OPM_EXCLUSION_DESC}, 		
							{REASON_REINSTATED_STATE_EXCLUSION 		,REASON_REINSTATED_STATE_EXCLUSION_DESC}, 	
							{REASON_REINSTATED_OIG_EXCLUSION 			,REASON_REINSTATED_OIG_EXCLUSION_DESC}, 	
							{REASON_REINSTATED_OPM_EXCLUSION  		,REASON_REINSTATED_OPM_EXCLUSION_DESC}, 	


							{REASON_ACTIVE_REVOCATION							,REASON_ACTIVE_REVOCATION_DESC}, 		
							{REASON_REINSTATED_REVOCATION					,REASON_REINSTATED_REVOCATION_DESC}, 		
							{REASON_LICENSE_EXPIRED 							,REASON_LICENSE_EXPIRED_DESC},			
							{REASON_LICENSE_INACTIVE 							,REASON_LICENSE_INACTIVE_DESC},			
							{REASON_DEA_EXPIRED										,REASON_DEA_EXPIRED_DESC}, 			

							{REASON_NPI_DEACTIVATED 							,REASON_NPI_DEACTIVATED_DESC},	 		
							{REASON_DECEASED_PROVIDER							,REASON_DECEASED_PROVIDER_DESC},	 	

							{REASON_DME_OUTLIER										,REASON_DME_OUTLIER_DESC}, 			
							{REASON_LAB_OUTLIER										,REASON_LAB_OUTLIER_DESC}, 			

							{REASON_HIGH_PAID_DOLLARS							,REASON_HIGH_PAID_DOLLARS_DESC}, 		
							{REASON_HIGH_PAID_DOLLARS_PER_PATIENT ,REASON_HIGH_PAID_DOLLARS_PER_PATIENT_DESC}, 	
							{REASON_HIGH_PAID_DOLLARS_PER_CLAIM 	,REASON_HIGH_PAID_DOLLARS_PER_CLAIM_DESC}, 	
							{REASON_HIGH_NO_OF_CLAIMS 						,REASON_HIGH_NO_OF_CLAIMS_DESC}, 		

							{REASON_HIGH_NO_OF_PATIENT 						,REASON_HIGH_NO_OF_PATIENT_DESC}, 		
							{REASON_DECEASED_PATIENTS							,REASON_DECEASED_PATIENTS_DESC}, 		
							{REASON_LARGE_PATIENT_GROUP						,REASON_LARGE_PATIENT_GROUP_DESC},		

							{REASON_LONG_PATIENT_DRIVING_DISTANCE ,REASON_LONG_PATIENT_DRIVING_DISTANCE_DESC}, 	

							{REASON_PROF_ASSOC_EXC_SANC						,REASON_PROF_ASSOC_EXC_SANC_DESC},
							{REASON_PROF_ASSOC_REV_SANC						,REASON_PROF_ASSOC_REV_SANC_DESC},
							{REASON_PROF_ASSOC_PAST_EXC_SANC			,REASON_PROF_ASSOC_PAST_EXC_SANC_DESC},
							{REASON_PROF_ASSOC_PAST_REV_SANC			,REASON_PROF_ASSOC_PAST_REV_SANC_DESC},
							{REASON_PROF_ASSOC_BANK								,REASON_PROF_ASSOC_BANK_DESC},
							{REASON_PROF_ASSOC_FELON							,REASON_PROF_ASSOC_FELON_DESC},
							{REASON_PER_ASSOC_BANK								,REASON_PER_ASSOC_BANK_DESC},
							{REASON_PER_ASSOC_CONVICT							,REASON_PER_ASSOC_CONVICT_DESC},
							{REASON_RELATED_BANKRUPTCY						,REASON_RELATED_BANKRUPTCY_DESC},
							{REASON_RELATED_CONVICT								,REASON_RELATED_CONVICT_DESC},
							{REASON_BANKRUPTCY										,REASON_BANKRUPTCY_DESC},	 	
							{REASON_FELON													,REASON_FELON_DESC}		
            ],
            ReasonDescriptionLayout
        );

    EXPORT GetReasonDescription(string reasonCode) := FUNCTION
        reasonDesc := CASE(reasonCode,
				    ''																	=>'',
						REASON_VACANCY     									=>REASON_VACANCY_DESC,
						REASON_DND 	    										=>REASON_DND_DESC, 				
						REASON_DROP 												=>REASON_DROP_DESC, 				
						REASON_POBOX 												=>REASON_POBOX_DESC, 				
						REASON_PRISON 											=>REASON_PRISON_DESC, 				
						REASON_RESIDENTIAL 									=>REASON_RESIDENTIAL_DESC, 			
						REASON_SINGLE_ADDRESS 							=>REASON_SINGLE_ADDRESS_DESC, 			
						REASON_SHARED_ADDRESS 							=>REASON_SHARED_ADDRESS_DESC, 			
						REASON_RECENT_NPI										=>REASON_RECENT_NPI_DESC, 			
						REASON_STUDENT_NPI									=>REASON_STUDENT_NPI_DESC, 			

						REASON_ACTIVE_STATE_EXCLUSION 			=>REASON_ACTIVE_STATE_EXCLUSION_DESC, 		
						REASON_ACTIVE_OIG_EXCLUSION 				=>REASON_ACTIVE_OIG_EXCLUSION_DESC, 		
						REASON_ACTIVE_OPM_EXCLUSION 				=>REASON_ACTIVE_OPM_EXCLUSION_DESC, 		
						REASON_REINSTATED_STATE_EXCLUSION 	=>REASON_REINSTATED_STATE_EXCLUSION_DESC, 	
						REASON_REINSTATED_OIG_EXCLUSION 		=>REASON_REINSTATED_OIG_EXCLUSION_DESC, 	
						REASON_REINSTATED_OPM_EXCLUSION  		=>REASON_REINSTATED_OPM_EXCLUSION_DESC, 	

					  REASON_ACTIVE_REVOCATION						=>REASON_ACTIVE_REVOCATION_DESC, 		
						REASON_REINSTATED_REVOCATION				=>REASON_REINSTATED_REVOCATION_DESC, 		
						REASON_LICENSE_EXPIRED 							=>REASON_LICENSE_EXPIRED_DESC,			
						REASON_LICENSE_INACTIVE 						=>REASON_LICENSE_INACTIVE_DESC,			
						REASON_DEA_EXPIRED									=>REASON_DEA_EXPIRED_DESC, 			

						REASON_NPI_DEACTIVATED 							=>REASON_NPI_DEACTIVATED_DESC,	 		
						REASON_DECEASED_PROVIDER						=>REASON_DECEASED_PROVIDER_DESC,	 	

						REASON_DME_OUTLIER									=>REASON_DME_OUTLIER_DESC, 			
						REASON_LAB_OUTLIER									=>REASON_LAB_OUTLIER_DESC, 			

						REASON_HIGH_PAID_DOLLARS						=>REASON_HIGH_PAID_DOLLARS_DESC, 		
						REASON_HIGH_PAID_DOLLARS_PER_PATIENT=>REASON_HIGH_PAID_DOLLARS_PER_PATIENT_DESC, 	
						REASON_HIGH_PAID_DOLLARS_PER_CLAIM 	=>REASON_HIGH_PAID_DOLLARS_PER_CLAIM_DESC, 	
						REASON_HIGH_NO_OF_CLAIMS 						=>REASON_HIGH_NO_OF_CLAIMS_DESC, 		

						REASON_HIGH_NO_OF_PATIENT 					=>REASON_HIGH_NO_OF_PATIENT_DESC, 		
						REASON_DECEASED_PATIENTS						=>REASON_DECEASED_PATIENTS_DESC, 		
						REASON_LARGE_PATIENT_GROUP					=>REASON_LARGE_PATIENT_GROUP_DESC,		

						REASON_LONG_PATIENT_DRIVING_DISTANCE=>REASON_LONG_PATIENT_DRIVING_DISTANCE_DESC, 	

						REASON_PROF_ASSOC_EXC_SANC					=>REASON_PROF_ASSOC_EXC_SANC_DESC,
						REASON_PROF_ASSOC_REV_SANC					=>REASON_PROF_ASSOC_REV_SANC_DESC,
						REASON_PROF_ASSOC_PAST_EXC_SANC			=>REASON_PROF_ASSOC_PAST_EXC_SANC_DESC,
						REASON_PROF_ASSOC_PAST_REV_SANC			=>REASON_PROF_ASSOC_PAST_REV_SANC_DESC,
						REASON_PROF_ASSOC_BANK							=>REASON_PROF_ASSOC_BANK_DESC,
						REASON_PROF_ASSOC_FELON							=>REASON_PROF_ASSOC_FELON_DESC,
						REASON_PER_ASSOC_BANK								=>REASON_PER_ASSOC_BANK_DESC,
						REASON_PER_ASSOC_CONVICT						=>REASON_PER_ASSOC_CONVICT_DESC,
						REASON_RELATED_BANKRUPTCY						=>REASON_RELATED_BANKRUPTCY_DESC,
						REASON_RELATED_CONVICT							=>REASON_RELATED_CONVICT_DESC,
						REASON_BANKRUPTCY										=>REASON_BANKRUPTCY_DESC,	 	
						REASON_FELON												=>REASON_FELON_DESC,
						''
        );
				
				RETURN reasonDesc;
    END;

    //--------------------------------------------------------------------------

    // ROW values in this format are returned by all scoring routines.  Done
    // this way in order to both a score and a reason code.  A score of zero
    // and an empty string as a reason code essentially means "we don't have a
    // problem with this."
    EXPORT ScoreRec := RECORD
        UNSIGNED1           score;
        ReasonCode_t        reason;
				STRING 							value := '';
    END;

    // Useful utility functions for creating ROW values for scoring
    SHARED ScoreRec MakeScore(UNSIGNED1 theScore = 0, ReasonCode_t theReason = '', STRING Value = '') := ROW({theScore, theReason, Value}, ScoreRec);
    SHARED ScoreRec ZeroScore := MakeScore();

    //--------------------------------------------------------------------------

    EXPORT EvalSharedAddress(STRING1 sharedAddressIndicator, STRING1 SharedAddressSwitch, UNSIGNED1 SharedAddressScore, UNSIGNED2 ProviderCount, UNSIGNED2 PatientCount) := FUNCTION
			
			STRING Value := IF(ProviderCount > 0 OR PatientCount > 0, '(Providers - ' + (STRING) ProviderCount + ', Patients - ' + (STRING) PatientCount + ')',''); 
			UNSIGNED1 Score := MAP (SharedAddressScore > 0 and SharedAddressSwitch = 'Y' =>  SharedAddressScore, 
															SharedAddressScore = 0 and SharedAddressSwitch = 'Y' =>  MAX_SHARED_ADDRESS_INDICATOR, 0);
			r := IF
            (
                sharedAddressIndicator = 'Y' and SharedAddressSwitch = 'Y',
                MakeScore(Score, REASON_SHARED_ADDRESS, Value),
                ZeroScore
            );

        RETURN r;
    END;
		
		EXPORT EvalSingleAddress(STRING1 singleAddressIndicator = '', STRING1 singleAddressSwitch = '', UNSIGNED1 singleAddressScore = 0, UNSIGNED2 NoOfProvider = 0, BOOLEAN isSingleAddress = false) := FUNCTION
				
				STRING Value := IF(NoOfProvider > 0, '(' + (STRING) NoOfProvider + ')',''); 
				UNSIGNED1 Score := MAP (singleAddressScore > 0 and singleAddressSwitch = 'Y' =>  singleAddressScore, 
																singleAddressScore = 0 and singleAddressSwitch = 'Y' =>  MAX_SINGLE_ADDRESS_INDICATOR, 0);

        r := IF
            (
                singleAddressIndicator = 'Y' and isSingleAddress and singleAddressSwitch = 'Y',
                MakeScore(Score, REASON_SINGLE_ADDRESS, Value),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalPrison(STRING1 PrisonAddressIndicator = '', STRING1 PrisonAddressSwitch = '', UNSIGNED1 PrisonAddressScore = 0, UNSIGNED8 TotalChargeAmount, UNSIGNED8 TotalClaimCount) := FUNCTION
				Value := '';
				UNSIGNED1 Score := MAP (PrisonAddressScore > 0 and PrisonAddressSwitch = 'Y' =>  PrisonAddressScore, 
																PrisonAddressScore = 0 and PrisonAddressSwitch = 'Y' =>  MAX_PRISON_INDICATOR, 0);
        r := IF
            (
                PrisonAddressIndicator = 'Y' AND PrisonAddressSwitch = 'Y' AND TotalChargeAmount > 0 AND TotalClaimCount > 0,
                MakeScore(MAX_PRISON_INDICATOR, REASON_PRISON, Value),
                ZeroScore
            );

        RETURN r;
    END;
			
    EXPORT EvalVacancy(STRING1 VacancyIndicator, STRING1 VacancySwitch = '', UNSIGNED1 VacancyScore = 0) := FUNCTION

				Value := '';
				UNSIGNED1 Score := MAP (VacancyScore > 0 and VacancySwitch = 'Y' =>  VacancyScore, 
																VacancyScore = 0 and VacancySwitch = 'Y' =>  MAX_VACANCY_INDICATOR, 0);

        r := IF
            (
                vacancyIndicator = 'Y' AND VacancySwitch = 'Y',
                MakeScore(Score, REASON_VACANCY, ''),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalDND(STRING1 dndIndicator, UNSIGNED8 TotalChargeAmount, UNSIGNED8 TotalClaimCount, STRING1 dndSwitch = '', UNSIGNED1 dndScore = 0) := FUNCTION

				Value := '';
				UNSIGNED1 Score := MAP (dndScore > 0 and dndSwitch = 'Y' =>  dndScore, 
																dndScore = 0 and dndSwitch = 'Y' =>  MAX_DND_INDICATOR, 0);


        r := IF
            (
                dndIndicator = 'Y' AND dndSwitch = 'Y' AND TotalChargeAmount > 0 AND TotalClaimCount > 0,
                MakeScore(MAX_DND_INDICATOR, REASON_DND, ''),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalMailDrop(STRING1 dropIndicator, UNSIGNED8 TotalChargeAmount, UNSIGNED8 TotalClaimCount, STRING1 dropIndicatorSwitch = '', UNSIGNED1 dropIndicatorScore = 0) := FUNCTION

				Value := '';
				UNSIGNED1 Score := MAP (dropIndicatorScore > 0 and dropIndicatorSwitch = 'Y' =>  dropIndicatorScore, 
																dropIndicatorScore = 0 and dropIndicatorSwitch = 'Y' =>  MAX_DROP_INDICATOR, 0);

        r := map
            (
                dropIndicator = 'C' AND dropIndicatorSwitch = 'Y' AND TotalChargeAmount > 0 AND TotalClaimCount > 0 =>  MakeScore(Score, REASON_DROP, ''),
                dropIndicator = 'Y' AND dropIndicatorSwitch = 'Y' AND TotalChargeAmount > 0 AND TotalClaimCount > 0 =>  MakeScore(Score, REASON_DROP, ''),								
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalResidential(STRING1 residentialIndicator, UNSIGNED8 TotalClaimCount, UNSIGNED8 TotalPaidAmount, STRING1 residentialIndicatorSwitch = '', UNSIGNED1 residentialIndicatorScore = 0) := FUNCTION

				Value := '';
				UNSIGNED1 Score := MAP (residentialIndicatorScore > 0 and residentialIndicatorSwitch = 'Y' =>  residentialIndicatorScore, 
																residentialIndicatorScore = 0 and residentialIndicatorSwitch = 'Y' =>  MAX_RESIDENTIAL_INDICATOR, 0);

				isClaimActivity := TotalClaimCount > 0 and TotalPaidAmount > 0;
				
				r := CASE
            (
                residentialIndicator,
                'A' =>  MakeScore(Score, REASON_RESIDENTIAL, ''),
                'B' =>  MakeScore(Score, REASON_RESIDENTIAL, ''),
                'C' =>  MakeScore(Score, REASON_RESIDENTIAL, ''),
                'D' =>  MakeScore(Score, REASON_RESIDENTIAL, ''),
                'E' =>  MakeScore(Score, REASON_RESIDENTIAL, ''),
                'F' =>  MakeScore(Score, REASON_RESIDENTIAL, ''),
                'G' =>  MakeScore(Score, REASON_RESIDENTIAL, ''),
                'H' =>  MakeScore(Score, REASON_RESIDENTIAL, ''),
                ZeroScore
            );
			
        RETURN if (r.score > 0 and isClaimActivity AND residentialIndicatorSwitch = 'Y',r,zeroscore);
    END;

    EXPORT EvalPOBox (STRING1 addressType, STRING1 usageType, UNSIGNED8 TotalClaimCount, UNSIGNED8 TotalPaidAmount, STRING1 POBoxSwitch = '', UNSIGNED1 POBoxScore = 0) := FUNCTION
				Value := '';
				UNSIGNED1 Score := MAP (POBoxScore > 0 and POBoxSwitch = 'Y' =>  POBoxScore, 
																POBoxScore = 0 and POBoxSwitch = 'Y' =>  MAX_PO_BOX_INDICATOR, 0);

				
				isClaimActivity := TotalClaimCount > 0 and TotalPaidAmount > 0;        

				r := MAP
            (
                addressType = '9' OR usageType = 'P' AND POBoxSwitch = 'Y' => MakeScore(Score, REASON_POBOX, ''),
								ZeroScore
            );

        RETURN if (r.score > 0 and isClaimActivity,r,zeroscore);
    END;

		EXPORT EvalRecentNPI (INTEGER8 TotalNPICount, INTEGER8 RecentNPICount, STRING1 NPISwitch,  UNSIGNED1 NPIScore) := FUNCTION
				STRING Value := IF(TotalNPICount > 0 AND RecentNPICount > 0, '(' + (STRING) RecentNPICount + '/' + (STRING) TotalNPICount + ')',''); 
				UNSIGNED1 Score := MAP (NPIScore > 0 and NPISwitch = 'Y' =>  NPIScore, 
															  NPIScore = 0 and NPISwitch = 'Y' =>  MAX_RECENT_NPI_INDICATOR, 0);
		
				recentNPIFlag := IF ((INTEGER) TotalNPICount > 0 AND (INTEGER) RecentNPICount > 0 AND (INTEGER)TotalNPICount = (INTEGER)RecentNPICount, 'Y','N');
        r := IF
            (
                recentNPIFlag = 'Y' AND NPISwitch = 'Y',
                MakeScore(Score, REASON_RECENT_NPI, Value),
                ZeroScore
            );

        RETURN r;
    END;
		
		EXPORT EvalStudentNPI (INTEGER8 TotalNPICount, INTEGER8 StudentNPICount, STRING1 NPISwitch,  UNSIGNED1 NPIScore) := FUNCTION
				STRING Value := IF(TotalNPICount > 0 AND StudentNPICount > 0, '(' + (STRING) StudentNPICount + '/' + (STRING) TotalNPICount + ')',''); 
				UNSIGNED1 Score := MAP (NPIScore > 0 and NPISwitch = 'Y' =>  NPIScore, 
															  NPIScore = 0 and NPISwitch = 'Y' =>  MAX_STUDENT_NPI_INDICATOR, 0);

				StudentNPIFlag := IF ((INTEGER) TotalNPICount > 0 AND (INTEGER) StudentNPICount > 0 AND (INTEGER)TotalNPICount = (INTEGER)StudentNPICount, 'Y','N');
        r := IF
            (
                StudentNPIFlag = 'Y' AND NPISwitch = 'Y',
                MakeScore(Score, REASON_STUDENT_NPI, Value),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalDMEOutlier (STRING1 DMEHighPaidOutlierFlag, STRING1 DMESwitch,  UNSIGNED1 DMEScore, UNSIGNED2 OutlierRank, INTEGER4 HighPaidAmountPerPatient, INTEGER4 HighPaidAmountPerClaim, INTEGER4 DMEPatientMedian, INTEGER4 DMEClaimMedian, INTEGER1 DMEPercentile) := FUNCTION

			STRING Value := IF(HighPaidAmountPerPatient > 0 OR HighPaidAmountPerClaim > 0 OR DMEPatientMedian > 0 OR DMEClaimMedian > 0, '(Paid/Patient:$' + (STRING) HighPaidAmountPerPatient + ', ' + (STRING)DMEPercentile + 'th Percentile - $' + (STRING)DMEPatientMedian + ',' + 'Paid/Claim: $' + (STRING)HighPaidAmountPerClaim + ',' + (STRING)DMEPercentile + 'th Percentile - $' + (STRING)DMEClaimMedian + ')',''); 

			UNSIGNED1 Score := MAP (DMEScore > 0 and DMESwitch = 'Y' =>  DMEScore, 
															DMEScore = 0 and DMESwitch = 'Y' =>  MAX_DME_OUTLIER_INDICATOR, 0);

        r := MAP
            (
                DMEHighPaidOutlierFlag = 'Y'  and OutlierRank between 1 and 10 AND DMESwitch = 'Y' =>  MakeScore(Score, REASON_DME_OUTLIER, Value),
								ZeroScore
            );

        RETURN r;
    END;
		
    EXPORT EvalLABOutlier (STRING1 LabHighPaidOutlierFlag, STRING1 LABSwitch,  UNSIGNED1 LABScore, UNSIGNED2 OutlierRank, INTEGER4 HighPaidAmountPerPatient, INTEGER4 HighPaidAmountPerClaim, INTEGER4 LABPatientMedian, INTEGER4 LABClaimMedian, INTEGER1 LABPercentile) := FUNCTION

			STRING Value := IF(HighPaidAmountPerPatient > 0 OR HighPaidAmountPerClaim > 0 OR LABPatientMedian > 0 OR LABClaimMedian > 0, '(Paid/Patient:$' + (STRING) HighPaidAmountPerPatient + ', ' + (STRING)LABPercentile + 'th Percentile - $' + (STRING)LABPatientMedian + ',' + 'Paid/Claim: $' + (STRING)HighPaidAmountPerClaim + ',' + (STRING)LABPercentile + 'th Percentile - $' + (STRING)LABClaimMedian + ')',''); 

			UNSIGNED1 Score := MAP (LABScore > 0 and LABSwitch = 'Y' =>  LABScore, 
															LABScore = 0 and LABSwitch = 'Y' =>  MAX_LAB_OUTLIER_INDICATOR, 0);

        r := MAP
            (
                LabHighPaidOutlierFlag = 'Y'  and OutlierRank between 1 and 10 and LABSwitch = 'Y' =>  MakeScore(Score, REASON_LAB_OUTLIER, Value),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalActiveStateExclusion (STRING1 ActiveStateExclusion, STRING1 ActiveStateExclusionSwitch,  UNSIGNED1 ActiveStateExclusionScore, STRING2 ActiveLicenseExclusionState = '', STRING8 ActiveLicenseExclusionDate = '', INTEGER8 ActiveLicenseImpactAmount) := FUNCTION

				STRING Value := IF(ActiveLicenseExclusionDate <> '', '(' + ActiveLicenseExclusionDate[5..6] + '/' + ActiveLicenseExclusionDate[7..8] + '/' + ActiveLicenseExclusionDate[3..4] + ',' + ActiveLicenseExclusionState + ',$'+ ActiveLicenseImpactAmount + ')','(00/00/00,' + ActiveLicenseExclusionState + ',Past6M-$' + ActiveLicenseImpactAmount + ')'); 
				UNSIGNED1 Score := MAP (ActiveStateExclusionScore > 0 and ActiveStateExclusionSwitch = 'Y' =>  ActiveStateExclusionScore, 
															  ActiveStateExclusionScore = 0 and ActiveStateExclusionSwitch = 'Y' =>  MAX_ACTIVE_EXCLUSION, 0);

        r := MAP
            (
                ActiveStateExclusion = 'Y' AND ActiveStateExclusionSwitch = 'Y' => MakeScore (Score, REASON_ACTIVE_STATE_EXCLUSION, Value),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalActiveOIGExclusion (STRING1 ActiveOIGExclusion, STRING1 ActiveOIGExclusionSwitch,  UNSIGNED1 ActiveOIGExclusionScore, STRING8 ActiveOIGExclusionDate = '', INTEGER8 ActiveOIGImpactAmount) := FUNCTION

				STRING Value := IF(ActiveOIGExclusionDate <> '', '(' + ActiveOIGExclusionDate[5..6] + '/' + ActiveOIGExclusionDate[7..8] + '/' + ActiveOIGExclusionDate[3..4] + ',$' + ActiveOIGImpactAmount + ')','(00/00/00, Past6M-$' + ActiveOIGImpactAmount + ')'); 
				UNSIGNED1 Score := MAP (ActiveOIGExclusionScore > 0 and ActiveOIGExclusionSwitch = 'Y' =>  ActiveOIGExclusionScore, 
															  ActiveOIGExclusionScore = 0 and ActiveOIGExclusionSwitch = 'Y' =>  MAX_ACTIVE_EXCLUSION, 0);

        r := MAP
            (
                ActiveOIGExclusion = 'Y' and ActiveOIGExclusionSwitch = 'Y' => MakeScore (Score, REASON_ACTIVE_OIG_EXCLUSION, Value),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalActiveOPMExclusion (STRING1 ActiveOPMExclusion, STRING1 ActiveOPMExclusionSwitch,  UNSIGNED1 ActiveOPMExclusionScore, STRING8 ActiveOPMExclusionDate = '', INTEGER8 ActiveOPMImpactAmount) := FUNCTION

				STRING Value := IF(ActiveOPMExclusionDate <> '', '(' + ActiveOPMExclusionDate[5..6] + '/' + ActiveOPMExclusionDate[7..8] + '/' + ActiveOPMExclusionDate[3..4] + ',$' + ActiveOPMImpactAmount + ')','(00/00/00, Past6M-$' + ActiveOPMImpactAmount + ')'); 
				UNSIGNED1 Score := MAP (ActiveOPMExclusionScore > 0 and ActiveOPMExclusionSwitch = 'Y' =>  ActiveOPMExclusionScore, 
															  ActiveOPMExclusionScore = 0 and ActiveOPMExclusionSwitch = 'Y' =>  MAX_ACTIVE_EXCLUSION, 0);

        r := MAP
            (
                ActiveOPMExclusion = 'Y' and ActiveOPMExclusionSwitch = 'Y' => MakeScore (Score, REASON_ACTIVE_OPM_EXCLUSION, Value),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalActiveSanctionRevocation (STRING1 ActiveLicenseRevocation, STRING1 ActiveLicenseRevocationSwitch,  UNSIGNED1 ActiveLicenseRevocationScore, STRING2 ActiveLicenseRevocationState = '', STRING8 ActiveLicenseRevocationDate = '', INTEGER8 ActiveLicenseImpactAmount) := FUNCTION

				STRING Value := IF(ActiveLicenseRevocationDate <> '', '(' + ActiveLicenseRevocationDate[5..6] + '/' + ActiveLicenseRevocationDate[7..8] + '/' + ActiveLicenseRevocationDate[3..4] + ',' + ActiveLicenseRevocationState + ',$' + ActiveLicenseImpactAmount + ')','(00/00/00,' + ActiveLicenseRevocationState + ',Past6M-$' +  ActiveLicenseImpactAmount); 
				UNSIGNED1 Score := MAP (ActiveLicenseRevocationScore > 0 and ActiveLicenseRevocationSwitch = 'Y' =>  ActiveLicenseRevocationScore, 
															  ActiveLicenseRevocationScore = 0 and ActiveLicenseRevocationSwitch = 'Y' =>  MAX_ACTIVE_EXCLUSION, 0);

        r := MAP
            (
                ActiveLicenseRevocation = 'Y' AND ActiveLicenseRevocationSwitch = 'Y' => MakeScore (Score, REASON_ACTIVE_REVOCATION, Value),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalPastStateExclusion (STRING1 PastStateExclusion, STRING1 PastStateExclusionSwitch,  UNSIGNED1 PastStateExclusionScore, STRING2 PastStateExclusionState = '', STRING8 PastStateExclusionDate = '', STRING8 PastStateReInstateDate = '', INTEGER8 PastStateImpactAmount) := FUNCTION

				STRING Value := IF(PastStateExclusionDate <> '' AND PastStateReInstateDate <> '', '(' + PastStateExclusionDate[5..6] + '/' + PastStateExclusionDate[7..8] + '/' + PastStateExclusionDate[3..4] + ',' + PastStateReInstateDate[5..6] + '/' + PastStateReInstateDate[7..8] + '/' + PastStateReInstateDate[3..4]  +  ',' + PastStateExclusionState +  ',$' + PastStateImpactAmount + ')','(00/00/00,' + PastStateReInstateDate[5..6] + '/' + PastStateReInstateDate[7..8] + '/' + PastStateReInstateDate[3..4]  +  ',' + PastStateExclusionState +  ',6MPRIORREINST-$' + PastStateImpactAmount +')'); 
				UNSIGNED1 Score := MAP (PastStateExclusionScore > 0 and PastStateExclusionSwitch = 'Y' =>  PastStateExclusionScore, 
															  PastStateExclusionScore = 0 and PastStateExclusionSwitch = 'Y' =>  MAX_ACTIVE_EXCLUSION, 0);

        r := MAP
            (
                PastStateExclusion = 'Y' AND PastStateExclusionSwitch = 'Y' => MakeScore (Score, REASON_REINSTATED_STATE_EXCLUSION, Value),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalPastOIGExclusion (STRING1 PastOIGExclusion, STRING1 PastOIGExclusionSwitch,  UNSIGNED1 PastOIGExclusionScore, STRING8 PastOIGExclusionDate = '', STRING8 PastOIGReInstateDate = '', INTEGER8 PastOIGImpactAmount) := FUNCTION

				STRING Value := IF(PastOIGExclusionDate <> '' AND PastOIGReInstateDate <> '', '(' + PastOIGExclusionDate[5..6] + '/' + PastOIGExclusionDate[7..8] + '/' + PastOIGExclusionDate[3..4] + ',' + PastOIGReInstateDate[5..6] + '/' + PastOIGReInstateDate[7..8] + '/' + PastOIGReInstateDate[3..4] + ',$' + PastOIGImpactAmount + ')','(' + '00/00/00, '+ PastOIGReInstateDate[5..6] + '/' + PastOIGReInstateDate[7..8] + '/' + PastOIGReInstateDate[3..4] + ',6MPRIORREINST-$' + PastOIGImpactAmount + ')'); 
				UNSIGNED1 Score := MAP (PastOIGExclusionScore > 0 and PastOIGExclusionSwitch = 'Y' =>  PastOIGExclusionScore, 
															  PastOIGExclusionScore = 0 and PastOIGExclusionSwitch = 'Y' =>  MAX_ACTIVE_EXCLUSION, 0);

        r := MAP
            (
                PastOIGExclusion = 'Y' AND PastOIGExclusionSwitch = 'Y' => MakeScore (Score, REASON_REINSTATED_OIG_EXCLUSION, Value),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalPastOPMExclusion (STRING1 PastOPMExclusion, STRING1 PastOPMExclusionSwitch,  UNSIGNED1 PastOPMExclusionScore, STRING8 PastOPMExclusionDate = '', STRING8 PastOPMReInstateDate = '', INTEGER8 PastOPMImpactAmount) := FUNCTION

				STRING Value := IF(PastOPMExclusionDate <> '' AND PastOPMReInstateDate <> '', '(' + PastOPMExclusionDate[5..6] + '/' + PastOPMExclusionDate[7..8] + '/' + PastOPMExclusionDate[3..4] + ', ' + PastOPMReInstateDate[5..6] + '/' + PastOPMReInstateDate[7..8] + '/' + PastOPMReInstateDate[3..4] + ',$' + PastOPMImpactAmount + ')','(00/00/00, ' + PastOPMReInstateDate[5..6] + '/' + PastOPMReInstateDate[7..8] + '/' + PastOPMReInstateDate[3..4] + ',6MPRIORREINST-$' + PastOPMImpactAmount + ')'); 
				UNSIGNED1 Score := MAP (PastOPMExclusionScore > 0 and PastOPMExclusionSwitch = 'Y' =>  PastOPMExclusionScore, 
															  PastOPMExclusionScore = 0 and PastOPMExclusionSwitch = 'Y' =>  MAX_ACTIVE_EXCLUSION, 0);

				r := MAP
            (
                PastOPMExclusion = 'Y' AND PastOPMExclusionSwitch = 'Y' => MakeScore (Score, REASON_REINSTATED_OPM_EXCLUSION, Value),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalPastLicenseRevocation (STRING1 PastLicenseRevocation, STRING1 PastLicenseRevocationSwitch,  UNSIGNED1 PastLicenseRevocationScore, STRING2 PastLicenseRevocationState = '', STRING8 PastLicenseRevocationDate = '', INTEGER8 PastLicenseImpactAmount, STRING8 ActiveLicenseRevocationDate = '') := FUNCTION

				STRING Value := IF(PastLicenseRevocationState <> '' AND PastLicenseRevocationDate <> '' and ActiveLicenseRevocationDate <> '' and (INTEGER) PastLicenseRevocationDate > (INTEGER) ActiveLicenseRevocationDate, '(' + ActiveLicenseRevocationDate[5..6] + '/' + ActiveLicenseRevocationDate[7..8] + '/' + ActiveLicenseRevocationDate[3..4] + ',' + PastLicenseRevocationDate[5..6] + '/' + PastLicenseRevocationDate[7..8] + '/' + PastLicenseRevocationDate[3..4] +  ',' + PastLicenseRevocationState + ' ,$' + PastLicenseImpactAmount + ')','(00/00/00,' + PastLicenseRevocationDate[5..6] + '/' + PastLicenseRevocationDate[7..8] + '/' + PastLicenseRevocationDate[3..4] +  ',' + PastLicenseRevocationState + ',6MPRIORREINST-$' + PastLicenseImpactAmount + ')'); 
				UNSIGNED1 Score := MAP (PastLicenseRevocationScore > 0 and PastLicenseRevocationSwitch = 'Y' =>  PastLicenseRevocationScore, 
															  PastLicenseRevocationScore = 0 and PastLicenseRevocationSwitch = 'Y' =>  MAX_ACTIVE_EXCLUSION, 0);

        r := MAP
            (
                PastLicenseRevocation = 'Y' AND PastLicenseRevocationSwitch = 'Y' => MakeScore (Score, REASON_REINSTATED_REVOCATION, Value),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalLicenseExpired (STRING1 LicenseExpiredFlag, STRING1 LicenseExpiredSwitch,  UNSIGNED1 ExpiredLicenseScore, UNSIGNED4 iLicenseExpiredDate = 0, STRING25 LicenseExpired = '', STRING2 LicenseExpiredState = '', UNSIGNED8 TotalChargeAmount = 0, INTEGER8 LicenseExpiredImpactAmount) := FUNCTION
				STRING8 LicenseExpiredDate := INTFORMAT(iLicenseExpiredDate,8,1);
				STRING Value := IF(LicenseExpiredDate <> '' AND LicenseExpired <> '' AND LicenseExpiredState <> '', '(' + LicenseExpiredDate[5..6] + '/' + LicenseExpiredDate[7..8] + '/' + LicenseExpiredDate[3..4] + ',' + TRIM(LicenseExpired,ALL) + ',' + LicenseExpiredState + ',$' + LicenseExpiredImpactAmount + ')','(00/00/00, ' + LicenseExpiredDate[5..6] + '/' + LicenseExpiredDate[7..8] + '/' + LicenseExpiredDate[3..4] + ',' + TRIM(LicenseExpired,ALL) + ',' + LicenseExpiredState  + ', ' + 'Past6M-$' + LicenseExpiredImpactAmount + ')'); 
				UNSIGNED1 Score := MAP (ExpiredLicenseScore > 0 and LicenseExpiredSwitch = 'Y' =>  ExpiredLicenseScore, 
															  ExpiredLicenseScore = 0 and LicenseExpiredSwitch = 'Y' =>  MAX_ACTIVE_EXCLUSION, 0);

        r := IF
            (
                LicenseExpiredFlag = 'Y' AND LicenseExpiredSwitch = 'Y' AND TotalChargeAmount > 0,
                MakeScore(Score, REASON_LICENSE_EXPIRED, Value),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalDEAExpired (STRING1 DEAExpiredFlag, STRING1 DEAExpiredSwitch,  UNSIGNED1 DEAExpiredScore, STRING10 ExpiredDEANumber = '', UNSIGNED4 iExpiredDEANumberDate = 0, UNSIGNED8 TotalChargeAmount = 0) := FUNCTION
				STRING8 ExpiredDEANumberDate := INTFORMAT (iExpiredDEANumberDate,8,1);
 				STRING Value := IF(ExpiredDEANumber <> '' AND ExpiredDEANumberDate <> '', '(' + ExpiredDEANumberDate[5..6] + '/' + ExpiredDEANumberDate[7..8] + '/' + ExpiredDEANumberDate[3..4] + ',' + TRIM(ExpiredDEANumber,ALL) + ')',''); 
				UNSIGNED1 Score := MAP (DEAExpiredScore > 0 and DEAExpiredSwitch = 'Y' =>  DEAExpiredScore, 
															  DEAExpiredScore = 0 and DEAExpiredSwitch = 'Y' =>  MAX_ACTIVE_EXCLUSION, 0);

			  r := IF
            (
                DEAExpiredFlag = 'Y' AND DEAExpiredSwitch = 'Y' AND TotalChargeAmount > 0,
                MakeScore(Score, REASON_DEA_EXPIRED, Value),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalDeceased (STRING1 DeceasedFlag, STRING8 DateofDeath, STRING1 DeceasedSwitch,  UNSIGNED1 DeceasedScore, UNSIGNED8 TotalChargeAmount = 0, UNSIGNED8 LNPID = 0, INTEGER8 DeceasedImpactAmount) := FUNCTION		
				STRING8 DOD := DateOfDeath; //INTFORMAT (DateofDeath,8,1);
 				STRING Value := IF(DOD <> '' , '(' + DOD[5..6] + '/' + DOD[7..8] + '/' + DOD[3..4] + ',$' + DeceasedImpactAmount + ')','(00/00/00, Past6M-$' + DeceasedImpactAmount+ ')'); 
				UNSIGNED1 Score := MAP (DeceasedScore > 0 and DeceasedSwitch = 'Y' and TotalChargeAmount > 0 and LNPID > 0 =>  DeceasedScore, 
															  DeceasedScore = 0 and DeceasedSwitch = 'Y' and TotalChargeAmount > 0 and LNPID > 0 =>  MAX_DECEASED, 0);

        r := IF
            (
                (DeceasedFlag = 'Y' AND (INTEGER)DateofDeath > 0) AND DeceasedSwitch = 'Y' AND TotalChargeAmount > 0 AND LNPID > 0,
                MakeScore(Score, REASON_DECEASED_PROVIDER, Value),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalBankruptcy (STRING1 BankruptcyFlag, STRING1 BankruptcySwitch,  UNSIGNED1 BankruptcyScore, STRING8 BankruptcyDate = '', UNSIGNED8 LNPID = 0, INTEGER8 BankruptcyImpactAmount) := FUNCTION

 				STRING Value := IF(BankruptcyDate <> '' , '(' + TRIM(BankruptcyDate) + ',$' + BankruptcyImpactAmount + ')',''); 
				UNSIGNED1 Score := MAP (BankruptcyScore > 0 and BankruptcySwitch = 'Y' and LNPID > 0 =>  BankruptcyScore, 
															  BankruptcyScore = 0 and BankruptcySwitch = 'Y' and LNPID > 0 =>  MAX_BANKRUPTCY, 0);
 
			 r := IF
            (
                BankruptcyFlag = 'Y' AND BankruptcySwitch = 'Y' AND LNPID > 0,
                MakeScore(Score, REASON_BANKRUPTCY, Value),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalCriminalHistory (STRING1 CriminalHistoryFlag, STRING1 CriminalHistorySwitch,  UNSIGNED1 CriminalHistoryScore, STRING8 CriminalHistoryDate = '', UNSIGNED8 LNPID = 0, INTEGER8 FelonyImpactAmount) := FUNCTION
 				STRING Value := IF(CriminalHistoryDate <> '' , '(' + TRIM(CriminalHistoryDate) + ',$' + FelonyImpactAmount + ')',''); 
				UNSIGNED1 Score := MAP (CriminalHistoryScore > 0 and CriminalHistorySwitch = 'Y' and LNPID > 0 =>  CriminalHistoryScore, 
															  CriminalHistoryScore = 0 and CriminalHistorySwitch = 'Y' and LNPID > 0 =>  MAX_CRIMINAL_HISTORY, 0);

        r := IF
            (
                CriminalHistoryFlag = 'Y' AND CriminalHistorySwitch = 'Y' AND LNPID > 0,
                MakeScore(Score, REASON_FELON, Value),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalDeceasedPatients (STRING1 DeceasedPatientsFlag, STRING1 DeceasedPatientsSwitch,  UNSIGNED1 DeceasedPatientsScore, UNSIGNED2 DeceasedPatientCount = 0, UNSIGNED2 PatientCount = 0, UNSIGNED4 PatientDOD = 0, UNSIGNED8 TotalChargeAmount = 0, INTEGER8 DeceasedPatientImpactAmount) := FUNCTION

				STRING8 DOD := INTFORMAT (PatientDOD,8,1);
 				STRING Value := IF(DOD <> '' AND DeceasedPatientCount > 0 AND PatientCount > 0, '(' + (STRING) DeceasedPatientCount + '/' + (STRING) PatientCount + ',$' + DeceasedPatientImpactAmount + ',' + DOD[5..6] + '/' + DOD[7..8] + '/' + DOD[3..4] + ')',''); 
				UNSIGNED1 Score := MAP (DeceasedPatientsScore > 0 and DeceasedPatientsSwitch = 'Y' and TotalChargeAmount > 0 =>  DeceasedPatientsScore, 
															  DeceasedPatientsScore = 0 and DeceasedPatientsSwitch = 'Y' and TotalChargeAmount > 0 =>  MAX_DECEASED, 0);


        r := IF
            (
                DeceasedPatientsFlag = 'Y' AND DeceasedPatientsSwitch = 'Y' AND TotalChargeAmount > 0,
                MakeScore(Score, REASON_DECEASED_PATIENTS, Value),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalLargePatientGroups (STRING1 LargePatientGroupFlag, STRING1 LargePatientGroupSwitch,  UNSIGNED1 LargePatientGroupScore, UNSIGNED2 LargePatientGroupCount = 0, STRING50 LargePatientGroupAddress = '') := FUNCTION

 				STRING Value := IF(LargePatientGroupCount > 0 AND LargePatientGroupAddress <> '', '(' + (STRING) LargePatientGroupCount + ', ' + TRIM(LargePatientGroupAddress) + ')',''); 
				UNSIGNED1 Score := MAP (LargePatientGroupScore > 0 and LargePatientGroupSwitch = 'Y' =>  LargePatientGroupScore, 
															  LargePatientGroupScore = 0 and LargePatientGroupSwitch = 'Y' =>  MAX_LARGE_PATIENT_GROUPS, 0);


        r := IF
            (
                LargePatientGroupFlag = 'Y' AND LargePatientGroupSwitch = 'Y',
                MakeScore(Score, REASON_LARGE_PATIENT_GROUP, Value),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalLicenseInactive (STRING1 LicenseInactiveFlag, STRING1 LicenseInactiveSwitch,  UNSIGNED1 LicenseInactiveScore, STRING2 LicenseInactiveState = '', UNSIGNED8 TotalChargeAmount = 0) := FUNCTION

 				STRING Value := IF(LicenseInactiveState <> '', '(' + LicenseInactiveState + ')',''); 
				UNSIGNED1 Score := MAP (LicenseInactiveScore > 0 and LicenseInactiveSwitch = 'Y'  and TotalChargeAmount > 0 =>  LicenseInactiveScore, 
															  LicenseInactiveScore = 0 and LicenseInactiveSwitch = 'Y'  and TotalChargeAmount > 0 =>  MAX_LICENSE_INACTIVE, 0);


        r := IF
            (
                LicenseInactiveFlag = 'Y' AND LicenseInactiveSwitch = 'Y' AND TotalChargeAmount > 0,
                MakeScore(Score, REASON_LICENSE_INACTIVE, Value),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalNPIDeactivated (STRING8 NPIDeactivatedFlag, STRING1 NPIDeactivatedSwitch,  UNSIGNED1 NPIDeactivatedScore, STRING8 NPIDeactivatedDate = '', UNSIGNED8 TotalChargeAmount = 0, INTEGER8 DeactivateNPIImpactAmount) := FUNCTION

				STRING Value := IF(NPIDeactivatedDate <> '', '(' + NPIDeactivatedDate[5..6] + '/' + NPIDeactivatedDate[7..8] + '/' + NPIDeactivatedDate[3..4] + ', $' + DeactivateNPIImpactAmount +  ')','(00/00/00, Past6M-$' + DeactivateNPIImpactAmount + ')'); 
				UNSIGNED1 Score := MAP (NPIDeactivatedScore > 0 and NPIDeactivatedSwitch = 'Y' and TotalChargeAmount > 0 =>  NPIDeactivatedScore, 
															  NPIDeactivatedScore = 0 and NPIDeactivatedSwitch = 'Y' and TotalChargeAmount > 0 =>  MAX_NPI_DEACTIVATED, 0);


        r := IF
            (
                (NPIDeactivatedFlag = 'Y' OR NPIDeactivatedFlag = 'I') AND NPIDeactivatedSwitch = 'Y' AND TotalChargeAmount > 0, 
                MakeScore(Score, REASON_NPI_DEACTIVATED, Value),
                ZeroScore
            );

        RETURN r;
    END;
		
		EXPORT EvalLongPatientDrivingDistance (STRING1 LongPatientDrivingDistanceFlag, UNSIGNED1 DistanceRank, STRING1 LongPatientSwitch,  UNSIGNED1 LongPatientScore, UNSIGNED2 PatientCount, UNSIGNED2 TotalPatientCount, UNSIGNED2 AveDistance) := FUNCTION

				STRING Value := IF(PatientCount > 0 and TotalPatientCount > 0 and AveDistance > 0, '(' + (STRING)PatientCount + '/' + (STRING) TotalPatientCount + ', ' + (STRING) AveDistance + ' miles' + ')',''); 
				UNSIGNED1 Score := MAP (LongPatientScore > 0 and LongPatientSwitch = 'Y' =>  LongPatientScore, 
															  LongPatientScore = 0 and LongPatientSwitch = 'Y' =>  MAX_LONG_PATIENT_DRIVING_DISTANCE, 0);

        r := IF
            (
                LongPatientDrivingDistanceFlag = 'Y' AND DistanceRank BETWEEN 1 AND 25 AND LongPatientSwitch = 'Y',
                MakeScore(Score, REASON_LONG_PATIENT_DRIVING_DISTANCE, Value),
                ZeroScore
            );

        RETURN r;
    END;
		
		EXPORT EvalHighPaidDollarsPerPatient (STRING1 HighPaidDollarsPerPatientFlag, UNSIGNED1 FlagRank, STRING1 HighPaidDollarsPerPatientSwitch,  UNSIGNED1 HighPaidDollarsPerPatientScore, UNSIGNED8 PaidDollars, UNSIGNED8 MedianPaid, INTEGER1 PaidPercentile) := FUNCTION

				STRING Value := IF(PaidDollars > 0, '($' + (STRING)PaidDollars + ', ' + (STRING)PaidPercentile + 'th Percentile - $' + (STRING) MedianPaid + ')',''); 
				// STRING Value := IF(PaidDollars > 0 and MedianPaid > 0 , '($' + (STRING)PaidDollars + ', Median - $' + (STRING) MedianPaid + ')',''); 
				UNSIGNED1 Score := MAP (HighPaidDollarsPerPatientScore > 0 and HighPaidDollarsPerPatientSwitch = 'Y' =>  HighPaidDollarsPerPatientScore, 
															  HighPaidDollarsPerPatientScore = 0 and HighPaidDollarsPerPatientSwitch = 'Y' =>  MAX_HIGH_PAID_DOLLARS_PER_PATIENT, 0);


        r := IF
            (
                HighPaidDollarsPerPatientFlag = 'Y' AND FlagRank BETWEEN 1 AND 25 AND HighPaidDollarsPerPatientSwitch = 'Y',
                MakeScore(Score, REASON_HIGH_PAID_DOLLARS_PER_PATIENT, Value),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalHighPaidDollarsPerClaim (STRING1 HighPaidDollarsPerClaimFlag, UNSIGNED1 FlagRank, STRING1 HighPaidDollarsPerClaimSwitch, UNSIGNED1 HighPaidDollarsPerClaimScore, UNSIGNED8 PaidDollars, UNSIGNED8 MedianPaid, INTEGER1 PaidPercentile) := FUNCTION
				STRING Value := IF(PaidDollars > 0, '($' + (STRING)PaidDollars + ', ' + (STRING)PaidPercentile + 'th Percentile - $' + (STRING) MedianPaid + ')',''); 
				// STRING Value := IF(PaidDollars > 0 and MedianPaid > 0 , '($' + (STRING)PaidDollars + ', Median - $' + (STRING) MedianPaid + ')',''); 
				UNSIGNED1 Score := MAP (HighPaidDollarsPerClaimScore > 0 and HighPaidDollarsPerClaimSwitch = 'Y' =>  HighPaidDollarsPerClaimScore, 
															  HighPaidDollarsPerClaimScore = 0 and HighPaidDollarsPerClaimSwitch = 'Y' =>  MAX_HIGH_PAID_DOLLARS_PER_CLAIM, 0);


        r := IF
            (
                HighPaidDollarsPerClaimFlag = 'Y' AND FlagRank BETWEEN 1 AND 25 AND HighPaidDollarsPerClaimSwitch = 'Y',
                MakeScore(Score, REASON_HIGH_PAID_DOLLARS_PER_CLAIM , Value),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalHighNumberOfPatients (STRING1 HighNumberOfPatientsFlag, UNSIGNED1 FlagRank, STRING1 HighPatientSwitch,  UNSIGNED1 HighPatientScore, UNSIGNED2 PatientCount, UNSIGNED2 PatientMedian, INTEGER1 PatientPercentile) := FUNCTION

				STRING Value := IF(PatientCount > 0, '(' + (STRING)PatientCount + ', ' + (STRING)PatientPercentile + 'th Percentile - ' + (STRING) PatientMedian + ')',''); 
				// STRING Value := IF(PatientCount > 0 and PatientMedian > 0, '(' + (STRING)PatientCount + ', Median - ' + (STRING) PatientMedian + ')',''); 
				UNSIGNED1 Score := MAP (HighPatientScore > 0 and HighPatientSwitch = 'Y' =>  HighPatientScore, 
															  HighPatientScore = 0 and HighPatientSwitch = 'Y' =>  MAX_HIGH_NUMBER_OF_PATIENTS, 0);

        r := IF
            (
                HighNumberOfPatientsFlag = 'Y' AND FlagRank BETWEEN 1 AND 25 AND HighPatientSwitch = 'Y',
                MakeScore(Score, REASON_HIGH_NO_OF_PATIENT, Value),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalHighNumberOfClaims (STRING1 HighNumberOfClaimsFlag, UNSIGNED1 FlagRank, STRING1 HighNumberOfClaimsSwitch,  UNSIGNED1 HighNumberOfClaimsScore, UNSIGNED2 ClaimCount, UNSIGNED2 ClaimMedian, INTEGER1 ClaimPercentile) := FUNCTION

				STRING Value := IF(ClaimCount > 0, '(' + (STRING)ClaimCount + ', ' + (STRING)ClaimPercentile + 'th Percentile - ' + (STRING) ClaimMedian + ')',''); 
				// STRING Value := IF(ClaimCount > 0 and ClaimMedian > 0, '(' + (STRING)ClaimCount + ', Median - ' + (STRING) ClaimMedian + ')',''); 
				UNSIGNED1 Score := MAP (HighNumberOfClaimsScore > 0 and HighNumberOfClaimsSwitch = 'Y' =>  HighNumberOfClaimsScore, 
															  HighNumberOfClaimsScore = 0 and HighNumberOfClaimsSwitch = 'Y' =>  MAX_HIGH_NUMBER_OF_CLAIMS, 0);

        r := IF
            (
                HighNumberOfClaimsFlag = 'Y' AND FlagRank BETWEEN 1 AND 25 AND HighNumberOfClaimsSwitch = 'Y',
                MakeScore(Score, REASON_HIGH_NO_OF_CLAIMS, Value),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalHighPaidDollars (STRING1 HighPaidDollarsFlag, UNSIGNED1 FlagRank, STRING1 HighPaidDollarsSwitch,  UNSIGNED1 HighPaidDollarsScore, UNSIGNED8 ChargeAmount, UNSIGNED8 PaidAmount, UNSIGNED2 HighPaidDollarsMedian, INTEGER1 HighPaidPercentile) := FUNCTION
				PaidPercent := ROUND((PaidAmount * 100) / ChargeAmount);
				STRING Value := IF(ChargeAmount > 0 and PaidAmount > 0, '($' + (STRING)ChargeAmount + ', $' + (STRING) PaidAmount + ',' + (STRING) PaidPercent + '%, ' + (STRING)HighPaidPercentile + 'th Percentile - $' + (STRING) HighPaidDollarsMedian + ')',''); 
				// STRING Value := IF(ChargeAmount > 0 and PaidAmount > 0 and HighPaidDollarsMedian > 0, '($' + (STRING)ChargeAmount + ', $' + (STRING) PaidAmount + ',' + (STRING) PaidPercent + '%, Median - $' + (STRING) HighPaidDollarsMedian + ')',''); 
				UNSIGNED1 Score := MAP (HighPaidDollarsScore > 0 and HighPaidDollarsSwitch = 'Y' =>  HighPaidDollarsScore, 
															  HighPaidDollarsScore = 0 and HighPaidDollarsSwitch = 'Y' =>  MAX_HIGH_PAID_DOLLARS, 0);


        r := IF
            (
                HighPaidDollarsFlag = 'Y' AND FlagRank BETWEEN 1 AND 25 AND HighPaidDollarsSwitch = 'Y',
                MakeScore(Score, REASON_HIGH_PAID_DOLLARS, Value),
                ZeroScore
            );
        RETURN r;
    END;

		EXPORT EvalInNetworkActiveExclusion (STRING1 InNetworkhasExclusionFlag, STRING1 InNetworkhasExclusionSwitch, UNSIGNED1 InNetworkhasExclusionScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (InNetworkhasExclusionScore > 0 and InNetworkhasExclusionSwitch = 'Y' =>  InNetworkhasExclusionScore, 
															  InNetworkhasExclusionScore = 0 and InNetworkhasExclusionSwitch = 'Y' =>  MAX_IN_ACTIVE_EXCLUSION, 0);

        r := IF
            (
                InNetworkhasExclusionFlag = 'Y' AND InNetworkhasExclusionSwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_EXC_SANC, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalInNetworkActiveRevocation (STRING1 InNetworkhasRevocationFlag, STRING1 InNetworkhasRevocationSwitch, UNSIGNED1 InNetworkhasRevocationScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (InNetworkhasRevocationScore > 0 and InNetworkhasRevocationSwitch = 'Y' =>  InNetworkhasRevocationScore, 
															  InNetworkhasRevocationScore = 0 and InNetworkhasRevocationSwitch = 'Y' =>  MAX_IN_ACTIVE_REVOCATION, 0);

        r := IF
            (
                InNetworkhasRevocationFlag = 'Y' AND InNetworkhasRevocationSwitch = 'Y',
                MakeScore(MAX_IN_ACTIVE_REVOCATION, REASON_PROF_ASSOC_REV_SANC, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalInNetworkPastExclusion (STRING1 InNetworkhadExclusionFlag, STRING1 InNetworkhadExclusionSwitch, UNSIGNED1 InNetworkhadExclusionScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (InNetworkhadExclusionScore > 0 and InNetworkhadExclusionSwitch = 'Y' =>  InNetworkhadExclusionScore, 
															  InNetworkhadExclusionScore = 0 and InNetworkhadExclusionSwitch = 'Y' =>  MAX_IN_HAD_ACTIVE_EXCLUSION, 0);

        r := IF
            (
                InNetworkhadExclusionFlag = 'Y' AND InNetworkhadExclusionSwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_PAST_EXC_SANC, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalInNetworkPastRevocation (STRING1 InNetworkhadRevocationFlag, STRING1 InNetworkhadRevocationSwitch, UNSIGNED1 InNetworkhadRevocationScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (InNetworkhadRevocationScore > 0 and InNetworkhadRevocationSwitch = 'Y' =>  InNetworkhadRevocationScore, 
															  InNetworkhadRevocationScore = 0 and InNetworkhadRevocationSwitch = 'Y' =>  MAX_IN_HAD_ACTIVE_REVOCATION, 0);

        r := IF
            (
                InNetworkhadRevocationFlag = 'Y' AND InNetworkhadRevocationSwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_PAST_REV_SANC, ''),
                ZeroScore
            );

        RETURN r;
    END;


		EXPORT EvalInNetworkBankruptcy (STRING1 InNetworkhasBankruptcy, STRING1 InNetworkhasBankruptcySwitch, UNSIGNED1 InNetworkhasBankruptcyScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (InNetworkhasBankruptcyScore > 0 and InNetworkhasBankruptcySwitch = 'Y' =>  InNetworkhasBankruptcyScore, 
															  InNetworkhasBankruptcyScore = 0 and InNetworkhasBankruptcySwitch = 'Y' =>  MAX_IN_BANKRUPTCY, 0);

        r := IF
            (
                InNetworkhasBankruptcy = 'Y' AND InNetworkhasBankruptcySwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_BANK, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalInNetworkCriminal (STRING1 InNetworkhasCriminalHistory, STRING1 InNetworkhasCriminalHistorySwitch, UNSIGNED1 InNetworkhasCriminalHistoryScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (InNetworkhasCriminalHistoryScore > 0 and InNetworkhasCriminalHistorySwitch = 'Y' =>  InNetworkhasCriminalHistoryScore, 
															  InNetworkhasCriminalHistoryScore = 0 and InNetworkhasCriminalHistorySwitch = 'Y' =>  MAX_IN_CRIMINAL_HISTORY, 0);


        r := IF
            (
                InNetworkhasCriminalHistory = 'Y' AND InNetworkhasCriminalHistorySwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_FELON, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalOutNetworkActiveExclusion (STRING1 OutNetworkhasExclusionFlag, STRING1 OutNetworkhasExclusionFlagSwitch, UNSIGNED1 OutNetworkhasExclusionFlagScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (OutNetworkhasExclusionFlagScore > 0 and OutNetworkhasExclusionFlagSwitch = 'Y' =>  OutNetworkhasExclusionFlagScore, 
															  OutNetworkhasExclusionFlagScore = 0 and OutNetworkhasExclusionFlagSwitch = 'Y' =>  MAX_OUT_ACTIVE_EXCLUSION, 0);


        r := IF
            (
                OutNetworkhasExclusionFlag = 'Y' AND OutNetworkhasExclusionFlagSwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_EXC_SANC, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalOutNetworkActiveRevocation (STRING1 OutNetworkhasRevocationFlag, STRING1 OutNetworkhasRevocationSwitch, UNSIGNED1 OutNetworkhasRevocationScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (OutNetworkhasRevocationScore > 0 and OutNetworkhasRevocationSwitch = 'Y' =>  OutNetworkhasRevocationScore, 
															  OutNetworkhasRevocationScore = 0 and OutNetworkhasRevocationSwitch = 'Y' =>  MAX_OUT_ACTIVE_REVOCATION, 0);

        r := IF
            (
                OutNetworkhasRevocationFlag = 'Y' AND OutNetworkhasRevocationSwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_REV_SANC, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalOutNetworkPastExclusion (STRING1 OutNetworkhadExclusionFlag, STRING1 OutNetworkhadExclusionSwitch, UNSIGNED1 OutNetworkhadExclusionScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (OutNetworkhadExclusionScore > 0 and OutNetworkhadExclusionSwitch = 'Y' =>  OutNetworkhadExclusionScore, 
															  OutNetworkhadExclusionScore = 0 and OutNetworkhadExclusionSwitch = 'Y' =>  MAX_OUT_HAD_ACTIVE_EXCLUSION, 0);

        r := IF
            (
                OutNetworkhadExclusionFlag = 'Y' AND OutNetworkhadExclusionSwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_PAST_EXC_SANC, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalOutNetworkPastRevocation (STRING1 OutNetworkhadRevocationFlag, STRING1 OutNetworkhadRevocationSwitch, UNSIGNED1 OutNetworkhadRevocationScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (OutNetworkhadRevocationScore > 0 and OutNetworkhadRevocationSwitch = 'Y' =>  OutNetworkhadRevocationScore, 
															  OutNetworkhadRevocationScore = 0 and OutNetworkhadRevocationSwitch = 'Y' =>  MAX_OUT_HAD_ACTIVE_REVOCATION, 0);

        r := IF
            (
                OutNetworkhadRevocationFlag = 'Y' AND OutNetworkhadRevocationSwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_PAST_REV_SANC,''),
                ZeroScore
            );

        RETURN r;
    END;


		EXPORT EvalOutNetworkBankruptcy (STRING1 OutNetworkhasBankruptcy, STRING1 OutNetworkhasBankruptcySwitch, UNSIGNED1 OutNetworkhasBankruptcyScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (OutNetworkhasBankruptcyScore > 0 and OutNetworkhasBankruptcySwitch = 'Y' =>  OutNetworkhasBankruptcyScore, 
															  OutNetworkhasBankruptcyScore = 0 and OutNetworkhasBankruptcySwitch = 'Y' =>  MAX_OUT_BANKRUPTCY, 0);

        r := IF
            (
                OutNetworkhasBankruptcy = 'Y' AND OutNetworkhasBankruptcySwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_BANK, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalOutNetworkCriminal (STRING1 OutNetworkhasCriminalHistory, STRING1 OutNetworkhasCriminalHistorySwitch, UNSIGNED1 OutNetworkhasCriminalHistoryScore) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (OutNetworkhasCriminalHistoryScore > 0 and OutNetworkhasCriminalHistorySwitch = 'Y' =>  OutNetworkhasCriminalHistoryScore, 
															  OutNetworkhasCriminalHistoryScore = 0 and OutNetworkhasCriminalHistorySwitch = 'Y' =>  MAX_OUT_CRIMINAL_HISTORY, 0);

        r := IF
            (
                OutNetworkhasCriminalHistory = 'Y' AND OutNetworkhasCriminalHistorySwitch = 'Y',
                MakeScore(Score, REASON_PROF_ASSOC_FELON,''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalRelativeCriminal (STRING1 RelativeAssocCriminalFlag, STRING1 RelativeAssocCriminalSwitch, UNSIGNED1 RelativeAssocCriminalScore, UNSIGNED8 LNPID = 0) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (RelativeAssocCriminalScore > 0 and RelativeAssocCriminalSwitch = 'Y' and LNPID > 0 =>  RelativeAssocCriminalScore, 
															  RelativeAssocCriminalScore = 0 and RelativeAssocCriminalSwitch = 'Y' and LNPID > 0 =>  MAX_REL_ASSOC_CRIMINAL_HISTORY, 0);

        r := IF
            (
                RelativeAssocCriminalFlag = 'Y' AND RelativeAssocCriminalSwitch = 'Y' AND LNPID > 0,
                MakeScore(Score, REASON_RELATED_CONVICT, ''),
                ZeroScore
            );

        RETURN r;
    END;


		EXPORT EvalAssocCriminal (STRING1 RelativeAssocCriminalFlag, STRING1 RelativeAssocCriminalSwitch, UNSIGNED1 RelativeAssocCriminalScore, UNSIGNED8 LNPID = 0) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (RelativeAssocCriminalScore > 0 and RelativeAssocCriminalSwitch = 'Y' and LNPID > 0 =>  RelativeAssocCriminalScore, 
															  RelativeAssocCriminalScore = 0 and RelativeAssocCriminalSwitch = 'Y' and LNPID > 0 =>  MAX_REL_ASSOC_CRIMINAL_HISTORY, 0);

        r := IF
            (
                RelativeAssocCriminalFlag = 'Y' AND RelativeAssocCriminalSwitch = 'Y' AND LNPID > 0,
                MakeScore(Score, REASON_PER_ASSOC_CONVICT, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalRelativeBankruptcy (STRING1 RelativeAssocBankruptcyFlag, STRING1 RelativeAssocCriminalSwitch, UNSIGNED1 RelativeAssocCriminalScore, UNSIGNED8 LNPID = 0) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (RelativeAssocCriminalScore > 0 and RelativeAssocCriminalSwitch = 'Y' and LNPID > 0 =>  RelativeAssocCriminalScore, 
															  RelativeAssocCriminalScore = 0 and RelativeAssocCriminalSwitch = 'Y' and LNPID > 0 =>  MAX_REL_ASSOC_BANKRUPTCY, 0);

        r := IF
            (
                RelativeAssocBankruptcyFlag = 'Y' AND RelativeAssocCriminalSwitch = 'Y' AND LNPID > 0,
                MakeScore(Score, REASON_RELATED_BANKRUPTCY, ''),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalAssocBankruptcy (STRING1 RelativeAssocBankruptcyFlag, STRING1 RelativeAssocCriminalSwitch, UNSIGNED1 RelativeAssocCriminalScore, UNSIGNED8 LNPID = 0) := FUNCTION

				STRING Value := ''; 
				UNSIGNED1 Score := MAP (RelativeAssocCriminalScore > 0 and RelativeAssocCriminalSwitch = 'Y' and LNPID > 0 =>  RelativeAssocCriminalScore, 
															  RelativeAssocCriminalScore = 0 and RelativeAssocCriminalSwitch = 'Y' and LNPID > 0 =>  MAX_REL_ASSOC_BANKRUPTCY, 0);

        r := IF
            (
                RelativeAssocBankruptcyFlag = 'Y' AND RelativeAssocCriminalSwitch = 'Y' AND LNPID > 0,
                MakeScore(Score, REASON_PER_ASSOC_BANK, ''),
                ZeroScore
            );

        RETURN r;
    END;
END;


