IMPORT death_master, MDR;

EXPORT Constants := MODULE

	DMConstants := death_master.Constants('');
	EXPORT Autokey := MODULE
		EXPORT KEY_NAME 		:= DMConstants.autokey_keyname_ssa;
		EXPORT KEY_DATASET 	:= Death_Master.file_searchautokey_ssa;
		EXPORT KEY_TYPESTR 	:= DMConstants.autokey_typeStr;
		EXPORT SKIP_SET			:= DMConstants.autokey_skip_set;
		EXPORT WORK_HARD 		:= DMConstants.workHard;
	END;

	// BatchServices.Constants.Death.DEFAULT_DID_SCORE_THRESHOLD
	EXPORT DEFAULT_DID_SCORE_THRESHOLD	:= 100;
	// BatchServices.Constants.DEATH_SERVICE_JOIN_LIMIT
	EXPORT DEATH_SERVICE_JOIN_LIMIT := 1000;

	EXPORT src_Death_NonMarketing_Sources := [MDR.sourceTools.src_Enclarity,
																																											MDR.sourceTools.src_Death_CA,
																																											MDR.sourceTools.src_Death_MI,
																																											MDR.sourceTools.src_Death_Restricted,
																																											MDR.sourceTools.src_TU_CreditHeader,
																																											MDR.sourceTools.src_Experian_Credit_Header];

	  EXPORT DeathMasterPurpose := MODULE
    export Integer NoValue := -1;
    export Integer NoPermissibleUse := 0;
    export Integer LegitimateFraudPrevention := 1;
    export Integer LegitimateBusinessPurpose := 2;
  END;

  EXPORT SearchIndicators := MODULE
    EXPORT UNSIGNED1 DEATH_ID := 0;
    EXPORT UNSIGNED1 DID := 1;
    EXPORT UNSIGNED1 DEEP_DIVE := 2;
    EXPORT UNSIGNED1 OTHERS := 4;
  END;

END;
