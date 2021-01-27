﻿import Insurance;
EXPORT Layout_Link := RECORD
	UNSIGNED8		SOURCE_RID;
	STRING9			SRC;
	Insurance.Layout_Key_Policy;
	// STRING5    	AMBEST;
	// STRING20   	POLICY_NUMBER;
	// STRING2    	INSURANCE_TYPE;
	STRING20	 	CLAIM_NUMBER := '';
	UNSIGNED4		DT_EFFECTIVE_FIRST;
	UNSIGNED4		DT_EFFECTIVE_LAST;
	UNSIGNED6 	LOCID; //Location ID
	/*----CCPA Fields------*/
	UNSIGNED4 	GLOBAL_SID;
	UNSIGNED8		RECORD_SID;
END;
