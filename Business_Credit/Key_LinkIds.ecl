IMPORT _Control, Business_Credit, BIPV2, MDR, Doxie, STD;

EXPORT Key_LinkIds(	STRING pVersion	=	(STRING8)Std.Date.Today(),
										Constants().buildType	pBuildType	=	Constants().buildType.Daily) := MODULE

	SHARED	dLinked				:=	Business_Credit.Files().LinkIDs;

	SHARED	rLinkedBase	:=	RECORD	
		STRING		Version;
		STRING		Original_Version;
		STRING2		Record_Type;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING50	Original_Contract_Account_Number;
		STRING3		Account_Type_Reported;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		UNSIGNED6	did;
		UNSIGNED1	did_score;
		BIPV2.IDlayouts.l_xlink_ids;	//	Added for BIP project
    UNSIGNED4 global_sid;
    UNSIGNED8 record_sid  :=  0;
		STRING2		source;
	END;

	SHARED	dLinkedBase			:=	PROJECT(dLinked(active),
																TRANSFORM(rLinkedBase,
																	SELF.Original_Version	:=	IF(	LEFT.original_process_date<>'',
																																LEFT.original_process_date,
																																LEFT.process_date);
																	SELF.Version					:=	LEFT.process_date;
																	SELF.global_sid				:=  0;
																	SELF									:=	LEFT
																)
															);
															
	SHARED  addGlobalSID :=  MDR.macGetGlobalSid(dLinkedBase,'SBFECV','','global_sid');
	
	SHARED	dLinkedBaseDist	:=	DEDUP(SORT(DISTRIBUTE(addGlobalSID,
																HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,did,DotID,EmpID,POWID,ProxID,SELEID,OrgID,UltID)),
																			Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,did,DotID,EmpID,POWID,ProxID,SELEID,OrgID,UltID,Original_Version,Version,LOCAL),
																			Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,did,DotID,EmpID,POWID,ProxID,SELEID,OrgID,UltID,LOCAL);

  // DEFINE THE INDEX
	SHARED	superfile_name	:=	Business_Credit.keynames().LinkIds.QA;	
		// If this is a daily build then only create a key with today's records
	SHARED	Base						:=	IF(	pBuildType	= Constants().buildType.Daily,
																	dLinkedBaseDist(Version=pVersion),
																	dLinkedBaseDist);
	
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
								INTEGER JoinLimit = 10000,
								UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
								):=FUNCTION

	use_sbfe := mod_access.DataPermissionMask[12] NOT IN ['0', ''];
	
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
								INTEGER JoinLimit = 10000 
								):=FUNCTION

		inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, mod_access, Level, ScoreThreshold, JoinLimit);		
		RETURN PROJECT(f2, RECORDOF(Key));																						

	END;

END;
