IMPORT	Business_Credit, Address, BIPV2, ut;
EXPORT	File_LinkIds_Base(STRING pVersion	=	ut.GetDate,
													Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	dLinked				:=	Business_Credit.Files().LinkIDs;

	rLinkedBase	:=	RECORD	
		STRING		Version;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
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
		STRING2		source;
	END;

	dLinkedBase			:=	PROJECT(dLinked(active),TRANSFORM(rLinkedBase,SELF.Version:=LEFT.process_date;SELF:=LEFT));
	dLinkedBaseDist	:=	DEDUP(SORT(DISTRIBUTE(dLinkedBase,
												HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,did,DotID,EmpID,POWID,ProxID,SELEID,OrgID,UltID)),
															Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,did,DotID,EmpID,POWID,ProxID,SELEID,OrgID,UltID,Version,LOCAL),
															Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,did,DotID,EmpID,POWID,ProxID,SELEID,OrgID,UltID,LOCAL);

		// If this is a daily build then only create a key with today's records
	dKeyResult		:=	IF(	pBuildType	= Constants().buildType.Daily,
												dLinkedBaseDist(Version=pVersion),
												dLinkedBaseDist);

	RETURN	dKeyResult;
END;
