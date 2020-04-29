IMPORT _Control, BIPV2_Best_SBFE, BIPV2_Best,	BIPV2, Business_Credit, MDR, doxie, STD;

EXPORT Key_Linkids(	STRING pVersion) := MODULE

	//	If this is a Daily Build we want to create an empty key.  
	SHARED	dSBFEBestBase	:= BIPV2_Best.fn_Prep_Base_for_Key(pVersion, PRTE2_BIPV2_SBFE.Files.Base);
														
														
	SHARED dSBFEBestKey := PROJECT(dSBFEBestBase, TRANSFORM(BIPV2_Best.layouts.key, SELF:=LEFT, SELF:=[]));  //DF-25791: Populate Global_SID Field
		
	SHARED  addGlobalSID :=  MDR.macGetGlobalSid(dSBFEBestKey,'SBFECV','','global_sid');	
	
	// prte::key::sbfe::qa::bipv2_best::linkids
	// DEFINE THE INDEX
	SHARED	superfile_name	:=	'~prte::key::sbfe::'+ doxie.Version_SuperKey +  '::bipv2_best::linkids';	
		// If this is a daily build then only create a key with today's records
	SHARED	Base						:=	addGlobalSID;
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	EXPORT Key := k;
	
	// DEFINE THE INDEX ACCESS
	// NOTE! SBFE (Business_Credit) data is restricted! Do not fetch records unless you have
	// obtained approval from product management.
	// Jira# DF-26179,  Added mod_access and Mac_check_access to kfetch functions for CCPA suppressions.
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
	
	BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, JoinLimit, JoinType);  //DF-26180 - Remove code calling mac_check_access b/c this key does not have lexid

	RETURN out(use_sbfe);																					

	END;
	
	// Depricated version of the above kFetch2
	EXPORT kFetch(DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs,
								STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																																		 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																																		//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
								UNSIGNED2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
								STRING DataPermissionMask = '',										//Default will fail the fetch. Pos 12 must be set to '1'
								INTEGER JoinLimit = 10000 
								):=FUNCTION

		inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, DataPermissionMask, JoinLimit);		
		RETURN PROJECT(f2, RECORDOF(Key));																						

	END;
END;