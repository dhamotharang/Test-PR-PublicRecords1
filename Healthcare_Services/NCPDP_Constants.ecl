Import NCPDP;
EXPORT NCPDP_Constants := Module

   EXPORT defaultPenalty  								:= 10;
   EXPORT MAX_RECS_ON_JOIN  							:= 400; /* when a fein key search or zip code autokey search is done, the fids can exponentially increase the 
																										number of pids returned.  Limiting the number of records returned at the first level 
																										reduces (hopefully eliminates) the possibility of a "memory limit exceeded" error. */
	 EXPORT TYPE_STR												:= 'AK'; 		// Auto Key
	 EXPORT ContLegalMail_AutoKey_Name		  := NCPDP.Constants().ak_qa_keyname_ContLegalMail;
	 EXPORT ContLegalMail_AUTOKEY_SKIP_SET	:= NCPDP.Constants().ak_skipSet_ContLegalMail + ['F'];//Skip the FEIN search as we are doing that manually.
	 EXPORT ContLegalPhys_AutoKey_Name      := NCPDP.Constants().ak_qa_keyname_ContLegalPhys;
	 EXPORT ContLegalPhys_AUTOKEY_SKIP_SET	:= NCPDP.Constants().ak_skipSet_ContLegalPhys + ['F'];//Skip the FEIN search as we are doing that manually.
	 EXPORT DBAMail_AutoKey_Name     				:= NCPDP.Constants().ak_qa_keyname_DBAMail;
	 EXPORT DBAMail_AUTOKEY_SKIP_SET				:= NCPDP.Constants().ak_skipSet_DBAMail + ['F'];//Skip the FEIN search as we are doing that manually.
	 EXPORT DBAPhys_AutoKey_Name       			:= NCPDP.Constants().ak_qa_keyname_DBAPhys;
	 EXPORT DBAPhys_AUTOKEY_SKIP_SET				:= NCPDP.Constants().ak_skipSet_DBAPhys + ['F'];//Skip the FEIN search as we are doing that manually.
	 EXPORT BOOLEAN WORK_HARD       				:= TRUE;    // deep dive 
	 EXPORT BOOLEAN NO_FAIL         				:= TRUE;    // 
	 EXPORT BOOLEAN USE_ALL_LOOKUPS 				:= TRUE;    // takes into account the "lookup bit" (????)
End;