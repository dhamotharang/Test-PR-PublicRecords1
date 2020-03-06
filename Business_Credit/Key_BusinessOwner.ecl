IMPORT	Business_Credit,	lib_date,	STD;
EXPORT	Key_BusinessOwner(STRING pVersion	=	(STRING8)Std.Date.Today(),
													Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	dBusinessOwner	:=	Business_Credit.Files().BusinessOwner(active);
	
	rBusinessOwnerKey	:=	RECORD
		STRING		Version;
		STRING		Original_Version;
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
		STRING250	Business_Name;
		STRING250	Web_Address;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_To_Business_Indicator;
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership_If_Owner_Principal;
		//DF-26180 Add CCPA fields to thor_data400::key::sbfe::qa::businessowner
		UNSIGNED6	did;
		UNSIGNED4	global_sid;
		UNSIGNED8   record_sid;

	END;

	rBusinessOwnerKey	tBusinessOwnerKey(dBusinessOwner	pInput)	:=	TRANSFORM
		SELF.Version													:=	pInput.process_date;
		SELF.Original_Version									:=	IF(	pInput.original_process_date<>'',
																									pInput.original_process_date,
																									pInput.process_date);
		SELF.dt_first_seen										:=	(UNSIGNED4)pInput.Cycle_End_Date;
		SELF.dt_last_seen											:=	(UNSIGNED4)pInput.Cycle_End_Date;
		SELF.dt_vendor_first_reported					:=	(UNSIGNED4)pInput.process_date;
		SELF.dt_vendor_last_reported					:=	(UNSIGNED4)pInput.process_date;
		SELF.dt_datawarehouse_first_reported	:=	(UNSIGNED4)pInput.Extracted_Date;
		SELF.dt_datawarehouse_last_reported		:=	(UNSIGNED4)pInput.Extracted_Date;
		SELF																	:=	pInput;
	END;
	
	dBusinessOwnerKey			:=	PROJECT(dBusinessOwner,tBusinessOwnerKey(LEFT));
	
	dBusinessOwnerKeyDist	:=	SORT(	DISTRIBUTE(dBusinessOwnerKey,
																	HASH(	Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported,
																				Business_Name, Web_Address, 
																				Guarantor_Owner_Indicator, Relationship_To_Business_Indicator,
																				Percent_Of_Liability, Percent_Of_Ownership_If_Owner_Principal)),
																				//	SORT
																				Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported,
																				Business_Name, Web_Address, 
																				Guarantor_Owner_Indicator, Relationship_To_Business_Indicator,
																				Percent_Of_Liability, Percent_Of_Ownership_If_Owner_Principal, dt_first_seen, LOCAL);
	
	rBusinessOwnerKey	tFillDates(rBusinessOwnerKey	L,	rBusinessOwnerKey	R)	:=	TRANSFORM
		SELF.Version													:=	lib_date.EarliestDateString(L.Version,	R.Version);
		SELF.Original_Version									:=	lib_date.EarliestDateString(L.Original_Version,	R.Original_Version);
		SELF.dt_first_seen										:=	lib_date.EarliestDate(L.dt_first_seen,	R.dt_first_seen);
		SELF.dt_last_seen											:=	lib_date.LatestDate(L.dt_last_seen,	R.dt_last_seen);
		SELF.dt_vendor_first_reported					:=	lib_date.EarliestDate(L.dt_vendor_first_reported,	R.dt_vendor_first_reported);
		SELF.dt_vendor_last_reported					:=	lib_date.LatestDate(L.dt_vendor_last_reported,	R.dt_vendor_last_reported);
		SELF.dt_datawarehouse_first_reported	:=	lib_date.EarliestDate(L.dt_datawarehouse_first_reported,	R.dt_datawarehouse_first_reported);
		SELF.dt_datawarehouse_last_reported		:=	lib_date.LatestDate(L.dt_datawarehouse_last_reported,	R.dt_datawarehouse_last_reported);
		SELF																	:=	L;
	END;
	
	dBusinessOwnerWithDates	:=	ROLLUP(
																		dBusinessOwnerKeyDist,
																			LEFT.Sbfe_Contributor_Number									=	RIGHT.Sbfe_Contributor_Number									AND
																			LEFT.Contract_Account_Number									=	RIGHT.Contract_Account_Number									AND
																			LEFT.Account_Type_Reported										=	RIGHT.Account_Type_Reported										AND
																			LEFT.Business_Name														=	RIGHT.Business_Name														AND
																			LEFT.Web_Address															=	RIGHT.Web_Address															AND
																			LEFT.Guarantor_Owner_Indicator								=	RIGHT.Guarantor_Owner_Indicator								AND
																			LEFT.Relationship_To_Business_Indicator				=	RIGHT.Relationship_To_Business_Indicator			AND
																			LEFT.Percent_Of_Liability											=	RIGHT.Percent_Of_Liability										AND
																			LEFT.Percent_Of_Ownership_If_Owner_Principal	=	RIGHT.Percent_Of_Ownership_If_Owner_Principal,
																		tFillDates(LEFT,RIGHT),
																		LOCAL
																	);
		// If this is a daily build then only create a key with today's records
	dKeyResult	:=	IF(	pBuildType	= Constants().buildType.Daily,
											dBusinessOwnerWithDates(Version=pVersion),
											dBusinessOwnerWithDates);
	RETURN	INDEX(dKeyResult,{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported},{dKeyResult},Business_Credit.keynames().BusinessOwner.QA);
END;