IMPORT death_master;

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
	
END;