﻿IMPORT _Control, BIPV2_Best_SBFE, BIPV2_Best,	BIPV2, Business_Credit, CCPA, doxie, STD;
EXPORT Key_LinkIds(	STRING pVersion	=	(STRING8)Std.Date.Today(),
										Constants().buildType	pBuildType	=	Constants().buildType.Daily) := MODULE

	//	If this is a Daily Build we want to create an empty key.  
	SHARED	dSBFEBestBase	:=	IF(pBuildType	=	Constants().buildType.Daily,
															DATASET([],BIPV2_Best.Layouts.base),
															BIPV2_Best.fn_Prep_Base_for_Key(pVersion,BIPV2_Best_SBFE.Files(pVersion).base.built)
														);
														
	SHARED dSBFEBestKey := PROJECT(dSBFEBestBase, TRANSFORM(BIPV2_Best.layouts.key, SELF:=LEFT, SELF:=[]));  //DF-25791: Populate Global_SID Field
		
	SHARED  addGlobalSID :=  CCPA.macGetGlobalSID(dSBFEBestKey,'SBFECV','','global_sid');	
	
	// DEFINE THE INDEX
	SHARED	superfile_name	:=	BIPV2_Best_SBFE.Keynames().LinkIds.QA;	
		// If this is a daily build then only create a key with today's records
	SHARED	Base						:=	addGlobalSID;
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	EXPORT Key := k;
	
	// DEFINE THE INDEX ACCESS
	// NOTE! SBFE (Business_Credit) data is restricted! Do not fetch records unless you have
	// obtained approval from product management.
	// Jira# DF-26179,  Added mod_access and Mac_check_access to kfetch functions for CCPA suppressions.
	EXPORT kFetch2(DATASET(BIPV2.IDlayouts.l_xlink_ids2) inputs,
								Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
								STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																																		 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																																		//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
								UNSIGNED2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
								STRING DataPermissionMask = '',										//Default will fail the fetch. Pos 12 must be set to '1'
								INTEGER JoinLimit = 10000,
								UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
								):=FUNCTION

	use_sbfe := DataPermissionMask[12] NOT IN ['0', ''];
	
	BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, fetched, Level, JoinLimit, JoinType);
	
	Business_Credit.MAC_check_access(fetched, out, mod_access);					// Jira# DF-26179, Function created for CCPA suppressions at key fetches.
	
	RETURN out(use_sbfe);																					

	END;
	
	// Depricated version of the above kFetch2
	EXPORT kFetch(DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs,
								Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
								STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																																		 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																																		//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
								UNSIGNED2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
								STRING DataPermissionMask = '',										//Default will fail the fetch. Pos 12 must be set to '1'
								INTEGER JoinLimit = 10000 
								):=FUNCTION

		inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, mod_access, Level, ScoreThreshold, DataPermissionMask, JoinLimit);		
		RETURN PROJECT(f2, RECORDOF(Key));																						

	END;
END;