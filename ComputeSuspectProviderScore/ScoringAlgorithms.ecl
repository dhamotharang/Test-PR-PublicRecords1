IMPORT Std;

EXPORT ScoringAlgorithms := MODULE

    // Once-per-run calculation of the current date, used for date seen scoring
    SHARED today := Std.Date.Today() : INDEPENDENT;
    
    // Once-per-run calculation of a recent vacation year.  Records are flagged
    // if they have a vacation begin date that is greater than or equal to
    // this value.
    SHARED recentVacationYearStr := (STRING)(Std.Date.Year(today) - 1) : INDEPENDENT;

    // Maximum scores for each attribute we're checking.  The actual score
    // returned by a scoring routine will be between zero and these values.
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
		
		SHARED MAX_IN_HAS_EXCLUSION									:=	10;
		SHARED MAX_IN_HAS_REVOCATION								:=	10;
		SHARED MAX_IN_HAD_EXCLUSION									:=	10;
		SHARED MAX_IN_HAD_REVOCATION								:=	10;
		SHARED MAX_IN_HAS_BANKRUPTCY								:=	10;
		SHARED MAX_IN_HAS_CRIMINAL									:=	10;
		
		SHARED MAX_OUT_HAS_EXCLUSION								:=	10;
		SHARED MAX_OUT_HAS_REVOCATION								:=	10;
		SHARED MAX_OUT_HAD_EXCLUSION								:=	10;
		SHARED MAX_OUT_HAD_REVOCATION								:=	10;
		SHARED MAX_OUT_HAS_BANKRUPTCY								:=	10;
		SHARED MAX_OUT_HAS_CRIMINAL									:=	10;

		SHARED MAX_REL_ASSOC_BANKRUPTCY							:=	10;
		SHARED MAX_REL_ASSOC_CRIMINAL								:=	10;

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

		EXPORT MAX_PROFESSIONAL_ASSOC_SCORE := 
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

												+ MAX_IN_HAS_EXCLUSION
												+ MAX_IN_HAS_REVOCATION
												+ MAX_IN_HAD_EXCLUSION
												+ MAX_IN_HAD_REVOCATION
												+ MAX_IN_HAS_BANKRUPTCY
												+ MAX_IN_HAS_CRIMINAL
													
												+ MAX_OUT_HAS_EXCLUSION
												+ MAX_OUT_HAS_REVOCATION
												+ MAX_OUT_HAD_EXCLUSION
												+ MAX_OUT_HAD_REVOCATION
												+ MAX_OUT_HAS_BANKRUPTCY
												+ MAX_OUT_HAS_CRIMINAL

												+ MAX_REL_ASSOC_BANKRUPTCY
												+ MAX_REL_ASSOC_CRIMINAL
												;


    // Flag addresses that haven't been reported within this many months (inclusives)

    SHARED LAST_DATE_SEEN_DELTA_THRESHOLD_IN_MONTHS := 12;

    // Flag addresses that are newer than this many months (inclusive)
    SHARED FIRST_DATE_SEEN_DELTA_THRESHOLD_IN_MONTHS := 2;

    EXPORT ReasonCode_t := STRING4;

    // Defined reason codes and their descriptions.  Note that the attribute
    // names are similar, with only '_DESC' appended to the descriptions.
    SHARED REASON_SHARED_ADDRESS 									:= 'A001';
    SHARED REASON_SHARED_ADDRESS_DESC 						:= 'Provider address match with patients';
		SHARED REASON_SINGLE_ADDRESS 									:= 'A002';
    SHARED REASON_SINGLE_ADDRESS_DESC 						:= 'Single Address';
		SHARED REASON_DND 														:= 'A003';
    SHARED REASON_DND_DESC 												:= 'Do Not Deliver';
		SHARED REASON_VACANCY 												:= 'A004';
    SHARED REASON_VACANCY_DESC 										:= 'Vacant';
		SHARED REASON_DROP 														:= 'A005';
    SHARED REASON_DROP_DESC 											:= 'Mail Drop';
    SHARED REASON_DROP_Y 													:= 'A006';
    SHARED REASON_POBOX_DESC 											:= 'PO Box';
		SHARED REASON_PRISON 													:= 'A007';
    SHARED REASON_PRISON_DESC 										:= 'Prison';
		SHARED REASON_RESIDENTIAL 										:= 'A008';
    SHARED REASON_RESIDENTIAL_DESC 								:= 'Residential Address';
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
    SHARED REASON_REINSTATED_STATE_EXCLUSION_DESC := 'State Exclusion (Past 5 years)';
    SHARED REASON_REINSTATED_OIG_EXCLUSION				:= 'B005';
    SHARED REASON_REINSTATED_OIG_EXCLUSION_DESC 	:= 'OIG Exclusion (Past 5 years)';
    SHARED REASON_REINSTATED_OPM_EXCLUSION				:= 'B006';
    SHARED REASON_REINSTATED_OPM_EXCLUSION_DESC 	:= 'OPM Exclusion (Past 5 years)';


    SHARED REASON_ACTIVE_REVOCATION								:= 'C001';
    SHARED REASON_ACTIVE_REVOCATION_DESC 					:= 'Currently Revoked Medical License';
    SHARED REASON_REINSTATED_REVOCATION						:= 'C002';
    SHARED REASON_REINSTATED_REVOCATION_DESC 			:= 'Revoked Medical License (Past 5 years)';
		SHARED REASON_LICENSE_EXPIRED 								:= 'C003';
    SHARED REASON_LICENSE_EXPIRED_DESC						:= 'Expired Medical License';
    SHARED REASON_LICENSE_INACTIVE 								:= 'C004';
    SHARED REASON_LICENSE_INACTIVE_DESC						:= 'Inactive Medical License';
    SHARED REASON_DEA_EXPIRED_DESC 								:= 'Expired DEA License';
    SHARED REASON_DECEASED_PATIENTS								:= 'C005';


    SHARED REASON_NPI_DEACTIVATED 								:= 'D001';
    SHARED REASON_NPI_DEACTIVATED_DESC	 					:= 'Deactivated NPI';

    SHARED REASON_DECEASED 												:= 'E001';
    SHARED REASON_DECEASED_DESC 									:= 'Deceased Provider';
    SHARED REASON_DEA_EXPIRED 										:= 'E002';
    SHARED REASON_DECEASED_PATIENTS_DESC 					:= 'Treating deceased patients';


    SHARED REASON_HIGH_PAID_DOLLARS										:= 'F001';
    SHARED REASON_HIGH_PAID_DOLLARS_DESC 							:= 'High Paid Dollars';
    SHARED REASON_HIGH_PAID_DOLLARS_PER_PATIENT 			:= 'F002';
    SHARED REASON_HIGH_PAID_DOLLARS_PER_PATIENT_DESC 	:= 'High Paid Per Patient';
    SHARED REASON_HIGH_PAID_DOLLARS_PER_CLAIM 				:= 'F003';
    SHARED REASON_HIGH_PAID_DOLLARS_PER_CLAIM_DESC 		:= 'High Paid Per Claim';
    SHARED REASON_HIGH_NO_OF_CLAIMS 									:= 'F004';
    SHARED REASON_HIGH_NO_OF_CLAIMS_DESC 							:= 'High Claim Volume';
    SHARED REASON_DME_OUTLIER													:= 'F005';
    SHARED REASON_DME_OUTLIER_DESC 										:= 'High Paid DME';
		SHARED REASON_LAB_OUTLIER													:= 'F006';
    SHARED REASON_LAB_OUTLIER_DESC 										:= 'High Paid LAB';

    SHARED REASON_HIGH_NO_OF_PATIENT 									:= 'G001';
    SHARED REASON_HIGH_NO_OF_PATIENT_DESC 						:= 'High Patient Volume';
    SHARED REASON_LARGE_PATIENT_GROUP									:= 'G002';
    SHARED REASON_LARGE_PATIENT_GROUP_DESC						:= 'Treating patient groups living at the same address';

    SHARED REASON_LONG_PATIENT_DRIVING_DISTANCE 			:= 'H005';
    SHARED REASON_LONG_PATIENT_DRIVING_DISTANCE_DESC 	:= 'Flagged Distance';

    SHARED REASON_IN_HAS_EXCLUSION										:= 'I001';
    SHARED REASON_IN_HAS_EXCLUSION_DESC	 							:= 'Provider within payers network has active exclusion';
    SHARED REASON_IN_HAS_REVOCATION										:= 'I002';
    SHARED REASON_IN_HAS_REVOCATION_DESC							:= 'Provider within payers network has active revocation';
    SHARED REASON_IN_HAD_EXCLUSION										:= 'I003';
    SHARED REASON_IN_HAD_EXCLUSION_DESC	 							:= 'Provider within payers network had active exclusion';
    SHARED REASON_IN_HAD_REVOCATION										:= 'I004';
    SHARED REASON_IN_HAD_REVOCATION_DESC							:= 'Provider within payers network had active revocation';
    SHARED REASON_IN_HAS_CRIMINAL											:= 'I005';
    SHARED REASON_IN_HAS_CRIMINAL_DESC	 							:= 'Provider within payers network has convictions';
    SHARED REASON_IN_HAS_BANKRUPTCY										:= 'I006';
    SHARED REASON_IN_HAS_BANKRUPTCY_DESC							:= 'Provider within payers network has filed bankruptcy in past 5 years';

    SHARED REASON_OUT_HAS_EXCLUSION										:= 'O001';
    SHARED REASON_OUT_HAS_EXCLUSION_DESC	 						:= 'Provider outside payers network has active exclusion';
    SHARED REASON_OUT_HAS_REVOCATION									:= 'O002';
    SHARED REASON_OUT_HAS_REVOCATION_DESC							:= 'Provider outside payers network has active revocation';
    SHARED REASON_OUT_HAD_EXCLUSION										:= 'O003';
    SHARED REASON_OUT_HAD_EXCLUSION_DESC	 						:= 'Provider outside payers network had active exclusion';
    SHARED REASON_OUT_HAD_REVOCATION									:= 'O004';
    SHARED REASON_OUT_HAD_REVOCATION_DESC							:= 'Provider outside payers network had active revocation';
    SHARED REASON_OUT_HAS_CRIMINAL										:= 'O005';
    SHARED REASON_OUT_HAS_CRIMINAL_DESC	 							:= 'Provider outside payers network has convictions';
    SHARED REASON_OUT_HAS_BANKRUPTCY									:= 'O006';
    SHARED REASON_OUT_HAS_BANKRUPTCY_DESC							:= 'Provider outside payers network has filed bankruptcy in past 5 years';

    SHARED REASON_REL_ASSOC_CRIMINAL									:= 'R001';
    SHARED REASON_REL_ASSOC_CRIMINAL_DESC	 						:= 'Related to a convicted felon';
    SHARED REASON_REL_ASSOC_BANKRUPTCY								:= 'R002';
    SHARED REASON_REL_ASSOC_BANKRUPTCY_DESC						:= 'Related to a person with Bankruptcy claim';




    SHARED REASON_BANKRUPTCY_FOUND 										:= 'B001';
    SHARED REASON_BANKRUPTCY_FOUND_DESC 							:= 'Bankruptcy Claim';
    SHARED REASON_CRIMINAL_HISTORY_FOUND 							:= 'C001';
    SHARED REASON_CRIMINAL_HISTORY_FOUND_DESC 				:= 'Felony Conviction';
		

		// Layout of dataset containing reason codes and their descriptions.
    EXPORT ReasonDescriptionLayout := RECORD
        ReasonCode_t    reasonCode;
        STRING          description;
    END;

    // Simple dataset containing all reason codes and their descriptions.
    EXPORT reasonDescriptions := DATASET
        (
            [
						
                {REASON_SHARED_ADDRESS, REASON_SHARED_ADDRESS_DESC},
                {REASON_SINGLE_ADDRESS, REASON_SINGLE_ADDRESS_DESC},
                {REASON_DND, REASON_DND_DESC},
                {REASON_VACANCY, REASON_VACANCY_DESC},
                {REASON_DROP_C, REASON_DROP_DESC_C},
								{REASON_DROP_Y, REASON_DROP_DESC_Y},
                {REASON_POBOX, REASON_POBOX_DESC},
                {REASON_PRISON, REASON_PRISON_DESC},
                {REASON_RESIDENTIAL, REASON_RESIDENTIAL_DESC},
                {REASON_DME_OUTLIER, REASON_DME_OUTLIER_DESC},
                {REASON_LAB_OUTLIER, REASON_LAB_OUTLIER_DESC},
                {REASON_RECENT_NPI, REASON_RECENT_NPI_DESC},
                {REASON_STUDENT_NPI, REASON_STUDENT_NPI_DESC},
                {REASON_ACTIVE_EXCLUSION, REASON_ACTIVE_EXCLUSION_DESC},
                {REASON_ACTIVE_REVOCATION, REASON_ACTIVE_REVOCATION_DESC},
                {REASON_REINSTATED_EXCLUSION, REASON_REINSTATED_EXCLUSION_DESC},
                {REASON_REINSTATED_REVOCATION, REASON_REINSTATED_REVOCATION_DESC},
                {REASON_LICENSE_EXPIRED, REASON_LICENSE_EXPIRED_DESC},
                {REASON_LICENSE_INACTIVE, REASON_LICENSE_INACTIVE_DESC},
                {REASON_LARGE_PATIENT_GROUP, REASON_LARGE_PATIENT_GROUP_DESC},
                {REASON_DECEASED, REASON_DECEASED_DESC},
                {REASON_DEA_EXPIRED, REASON_DEA_EXPIRED_DESC},
                {REASON_DECEASED_PATIENTS, REASON_DECEASED_PATIENTS_DESC},
                {REASON_BANKRUPTCY_FOUND, REASON_BANKRUPTCY_FOUND_DESC},
                {REASON_CRIMINAL_HISTORY_FOUND, REASON_CRIMINAL_HISTORY_FOUND_DESC},
                {REASON_NPI_DEACTIVATED, REASON_NPI_DEACTIVATED_DESC},
								{REASON_IN_HAS_EXCLUSION, REASON_IN_HAS_EXCLUSION_DESC},
								{REASON_IN_HAS_REVOCATION, REASON_IN_HAS_REVOCATION_DESC},
								{REASON_IN_HAD_EXCLUSION, REASON_IN_HAD_EXCLUSION_DESC},
								{REASON_IN_HAD_REVOCATION, REASON_IN_HAD_REVOCATION_DESC},
								{REASON_IN_HAS_CRIMINAL, REASON_IN_HAS_CRIMINAL_DESC},																
								{REASON_IN_HAS_BANKRUPTCY, REASON_IN_HAS_BANKRUPTCY_DESC},
								{REASON_OUT_HAS_EXCLUSION, REASON_OUT_HAS_EXCLUSION_DESC},
								{REASON_OUT_HAS_REVOCATION, REASON_OUT_HAS_REVOCATION_DESC},
								{REASON_OUT_HAD_EXCLUSION, REASON_OUT_HAD_EXCLUSION_DESC},
								{REASON_OUT_HAD_REVOCATION, REASON_OUT_HAD_REVOCATION_DESC},
								{REASON_OUT_HAS_CRIMINAL, REASON_OUT_HAS_CRIMINAL_DESC},																
								{REASON_OUT_HAS_BANKRUPTCY, REASON_OUT_HAS_BANKRUPTCY_DESC},
								{REASON_REL_ASSOC_CRIMINAL, REASON_REL_ASSOC_CRIMINAL_DESC},																
								{REASON_REL_ASSOC_BANKRUPTCY, REASON_REL_ASSOC_BANKRUPTCY_DESC}
            ],
            ReasonDescriptionLayout
        );

    //--------------------------------------------------------------------------

    // ROW values in this format are returned by all scoring routines.  Done
    // this way in order to both a score and a reason code.  A score of zero
    // and an empty string as a reason code essentially means "we don't have a
    // problem with this."
    EXPORT ScoreRec := RECORD
        UNSIGNED1           score;
        ReasonCode_t        reason;
    END;

    // Useful utility functions for creating ROW values for scoring
    SHARED ScoreRec MakeScore(UNSIGNED1 theScore = 0, ReasonCode_t theReason = '') := ROW({theScore, theReason}, ScoreRec);
    SHARED ScoreRec ZeroScore := MakeScore();

    //--------------------------------------------------------------------------
    EXPORT EvalActiveStateExclusion (STRING1 ActiveStateExclusion) := FUNCTION

        r := MAP
            (
                ActiveStateExclusion = 'Y' => MakeScore (MAX_ACTIVE_STATE_EXCLUSION, REASON_ACTIVE_STATE_EXCLUSION),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalActiveOIGExclusion (STRING1 ActiveOIGExclusion) := FUNCTION

        r := MAP
            (
                ActiveOIGExclusion = 'Y' => MakeScore (MAX_ACTIVE_OIG_EXCLUSION, REASON_ACTIVE_OIG_EXCLUSION),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalActiveOPMExclusion (STRING1 ActiveOPMExclusion) := FUNCTION

        r := MAP
            (
                ActiveOPMExclusion = 'Y' => MakeScore (MAX_ACTIVE_OPM_EXCLUSION, REASON_ACTIVE_OPM_EXCLUSION),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalActiveSanctionRevocation (STRING1 ActiveLicenseRevocation) := FUNCTION

        r := MAP
            (
                ActiveLicenseRevocation = 'Y' => MakeScore (MAX_ACTIVE_REVOCATION, REASON_ACTIVE_REVOCATION),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalReinstatedSanctionExclusion (STRING1 ReinstatedStateExclusion, STRING1 ReinstatedOIGExclusion, STRING1 ReinstatedOPMExclusion) := FUNCTION

        r := MAP
            (
                ReinstatedStateExclusion = 'Y' OR   ReinstatedOIGExclusion = 'Y' OR   ReinstatedOPMExclusion = 'Y' => MakeScore (MAX_REINSTATED_EXCLUSION, REASON_REINSTATED_EXCLUSION),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalReinstatedSanctionRevocation (STRING1 ReinstatedLicenseRevocation) := FUNCTION

        r := MAP
            (
                ReinstatedLicenseRevocation = 'Y' => MakeScore (MAX_REINSTATED_REVOCATION, REASON_REINSTATED_REVOCATION),
								ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalLicenseExpired (STRING1 LicenseExpiredFlag) := FUNCTION
        r := IF
            (
                LicenseExpiredFlag = 'Y',
                MakeScore(MAX_LICENSE_EXPIRED, REASON_LICENSE_EXPIRED),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalDEAExpired (STRING1 DEAExpiredFlag) := FUNCTION
        r := IF
            (
                DEAExpiredFlag = 'Y',
                MakeScore(MAX_DEA_EXPIRED, REASON_DEA_EXPIRED),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalDeceased (STRING1 DeceasedFlag, INTEGER4 DateofDeath) := FUNCTION		
        r := IF
            (
                DeceasedFlag = 'Y' OR DateofDeath > 0,
                MakeScore(MAX_DECEASED, REASON_DECEASED),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalBankruptcy (STRING1 BankruptcyFlag) := FUNCTION
        r := IF
            (
                BankruptcyFlag = 'Y',
                MakeScore(MAX_BANKRUPTCY, REASON_BANKRUPTCY_FOUND),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalCriminalHistory (STRING1 CriminalHistoryFlag) := FUNCTION
        r := IF
            (
                CriminalHistoryFlag = 'Y',
                MakeScore(MAX_CRIMINAL_HISTORY, REASON_CRIMINAL_HISTORY_FOUND),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalDeceasedPatients (STRING1 DeceasedPatientsFlag) := FUNCTION
        r := IF
            (
                DeceasedPatientsFlag = 'Y',
                MakeScore(MAX_DECEASED_PATIENTS, REASON_DECEASED_PATIENTS),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalLargePatientGroups (STRING1 LargePatientGroupFlag) := FUNCTION
        r := IF
            (
                LargePatientGroupFlag = 'Y',
                MakeScore(MAX_LARGE_PATIENT_GROUPS, REASON_LARGE_PATIENT_GROUP),
                ZeroScore
            );

        RETURN r;
    END;

    EXPORT EvalLicenseInactive (STRING1 LicenseInactiveFlag) := FUNCTION
        r := IF
            (
                LicenseInactiveFlag = 'Y',
                MakeScore(MAX_LICENSE_INACTIVE, REASON_LICENSE_INACTIVE),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalNPIDeactivated (STRING8 NPIDeactivatedFlag) := FUNCTION
        r := IF
            (
                NPIDeactivatedFlag = 'Y' OR NPIDeactivatedFlag = 'I',
                MakeScore(MAX_NPI_DEACTIVATED, REASON_NPI_DEACTIVATED),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalInNetworkActiveExclusion (STRING1 InNetworkhasExclusionFlag) := FUNCTION
        r := IF
            (
                InNetworkhasExclusionFlag = 'Y',
                MakeScore(MAX_IN_HAS_EXCLUSION, REASON_IN_HAS_EXCLUSION),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalInNetworkActiveRevocation (STRING1 InNetworkhasRevocationFlag) := FUNCTION
        r := IF
            (
                InNetworkhasRevocationFlag = 'Y',
                MakeScore(MAX_IN_HAS_REVOCATION, REASON_IN_HAS_REVOCATION),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalInNetworkhadExclusion (STRING1 InNetworkhadExclusionFlag) := FUNCTION
        r := IF
            (
                InNetworkhadExclusionFlag = 'Y',
                MakeScore(MAX_IN_HAD_EXCLUSION, REASON_IN_HAD_EXCLUSION),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalInNetworkhadRevocation (STRING1 InNetworkhadRevocationFlag) := FUNCTION
        r := IF
            (
                InNetworkhadRevocationFlag = 'Y',
                MakeScore(MAX_IN_HAD_REVOCATION, REASON_IN_HAD_REVOCATION),
                ZeroScore
            );

        RETURN r;
    END;


		EXPORT EvalInNetworkBankruptcy (STRING1 InNetworkhasBankruptcy) := FUNCTION
        r := IF
            (
                InNetworkhasBankruptcy = 'Y',
                MakeScore(MAX_IN_HAS_BANKRUPTCY, REASON_IN_HAS_BANKRUPTCY),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalInNetworkCriminal (STRING1 InNetworkhasCriminalHistory) := FUNCTION
        r := IF
            (
                InNetworkhasCriminalHistory = 'Y',
                MakeScore(MAX_IN_HAS_CRIMINAL, REASON_IN_HAS_CRIMINAL),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalOutNetworkActiveExclusion (STRING1 OutNetworkhasExclusionFlag) := FUNCTION
        r := IF
            (
                OutNetworkhasExclusionFlag = 'Y',
                MakeScore(MAX_OUT_HAS_EXCLUSION, REASON_OUT_HAS_EXCLUSION),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalOutNetworkActiveRevocation (STRING1 OutNetworkhasRevocationFlag) := FUNCTION
        r := IF
            (
                OutNetworkhasRevocationFlag = 'Y',
                MakeScore(MAX_OUT_HAS_REVOCATION, REASON_OUT_HAS_REVOCATION),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalOutNetworkhadExclusion (STRING1 OutNetworkhadExclusionFlag) := FUNCTION
        r := IF
            (
                OutNetworkhadExclusionFlag = 'Y',
                MakeScore(MAX_OUT_HAD_EXCLUSION, REASON_OUT_HAD_EXCLUSION),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalOutNetworkhadRevocation (STRING1 OutNetworkhadRevocationFlag) := FUNCTION
        r := IF
            (
                OutNetworkhadRevocationFlag = 'Y',
                MakeScore(MAX_OUT_HAD_REVOCATION, REASON_OUT_HAD_REVOCATION),
                ZeroScore
            );

        RETURN r;
    END;


		EXPORT EvalOutNetworkBankruptcy (STRING1 OutNetworkhasBankruptcy) := FUNCTION
        r := IF
            (
                OutNetworkhasBankruptcy = 'Y',
                MakeScore(MAX_OUT_HAS_BANKRUPTCY, REASON_OUT_HAS_BANKRUPTCY),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalOutNetworkCriminal (STRING1 OutNetworkhasCriminalHistory) := FUNCTION
        r := IF
            (
                OutNetworkhasCriminalHistory = 'Y',
                MakeScore(MAX_OUT_HAS_CRIMINAL, REASON_OUT_HAS_CRIMINAL),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalRelativeAssocCriminal (STRING1 RelativeAssocCriminalFlag) := FUNCTION
        r := IF
            (
                RelativeAssocCriminalFlag = 'Y',
                MakeScore(MAX_REL_ASSOC_CRIMINAL, REASON_REL_ASSOC_CRIMINAL),
                ZeroScore
            );

        RETURN r;
    END;

		EXPORT EvalRelativeAssocBankruptcy (STRING1 RelativeAssocBankruptcyFlag) := FUNCTION
        r := IF
            (
                RelativeAssocBankruptcyFlag = 'Y',
                MakeScore(MAX_REL_ASSOC_BANKRUPTCY, REASON_REL_ASSOC_BANKRUPTCY),
                ZeroScore
            );

        RETURN r;
    END;
END;
