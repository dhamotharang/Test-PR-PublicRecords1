IMPORT	Business_Credit_Scoring, Business_Credit, Business_Header, BusinessCredit_Services, 
				Risk_Indicators, BIPV2,	STD, iesp, Codes;

EXPORT Key_ScoringIndex(	STRING	pVersion	=	(STRING8)Std.Date.Today(),
													BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	SHARED	dKeyResult			:=	Business_Credit_Scoring.Files().ScoringIndex;

	SHARED	superfile_name	:=	Business_Credit_Scoring.keynames(pUseOtherEnvironment:=pUseProd).ScoringIndex.QA;
  SHARED  dKeyResultCCA   :=  PROJECT(dKeyResult,
                                TRANSFORM(
                                  {
                                    //  This allows source to be the last field in the layout for consistency
                                    RECORDOF(LEFT) AND NOT [source],
                                    UNSIGNED4 global_sid  :=  0;
                                    UNSIGNED8 record_sid  :=  0;
                                    STRING2		source      :=  Business_Credit_Scoring.Constants().source;
                                  },
                                  SELF  :=  LEFT;
                                  SELF  :=  [];
                                )                                
                              );
	SHARED	Base						:=	dKeyResultCCA;
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	EXPORT Key := k;
	
	// DEFINE THE INDEX ACCESS
	// NOTE! SBFE (Business_Credit) data is restricted! Do not fetch records unless you have
	// obtained approval from product management.
	EXPORT kFetch2(DATASET(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
								STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																																		 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																																		//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
								UNSIGNED2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
								STRING DataPermissionMask = '',										//Default will fail the fetch. Pos 12 must be set to '1'
								INTEGER JoinLimit = 10000,
								UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
								):=FUNCTION

	use_sbfe := DataPermissionMask[12] NOT IN ['0', ''];
	
	BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, JoinLimit, JoinType);
	
	RETURN out(use_sbfe);																					

	END;
	
	// Depricated version of the above kFetch2
	EXPORT kFetch(DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
								STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																																		 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																																		//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
								UNSIGNED2 ScoreThreshold	=	0,										 //Applied at lowest leve of ID
								STRING DataPermissionMask	=	'',										//Default will fail the fetch. Pos 12 must be set to '1'
								INTEGER JoinLimit = 10000 
								):=FUNCTION

		inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, DataPermissionMask, JoinLimit);		
		RETURN PROJECT(f2, RECORDOF(Key));																						

	END;

END;
