IMPORT	Business_Credit,	BIPV2,	Address,	doxie,	lib_date,	STD;
EXPORT	Key_BusinessOwnerInformation(	STRING pVersion	=	(STRING8)Std.Date.Today(),
																			Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	MODULE

	SHARED	dLinked	:=	Business_Credit.Files().LinkIDs(record_type=Constants().BS);

	SHARED	rBOInformation	:=	RECORD	
		STRING		Version;
		STRING		Original_Version;
		STRING2		record_type;
		BIPV2.IDlayouts.l_xlink_ids;	//	Added for BIP project
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
		STRING250	Account_Holder_Business_Name;
		STRING250	Clean_Account_Holder_Business_Name;
		STRING250	DBA;
		STRING250	Clean_DBA;
		STRING250	Business_Name;
		STRING250	Clean_Business_Name;
		STRING250	Company_Website;
		STRING3		Guarantor_Owner_Indicator;
		STRING3		Relationship_To_Business_Indicator;
		STRING3		Percent_Of_Liability;
		STRING3		Percent_Of_Ownership_If_Owner_Principal;
		STRING100	Original_Address_Line_1;
		STRING100	Original_Address_Line_2;
		STRING50	Original_City;
		STRING2		Original_State;
		STRING6		Original_Zip_Code_or_CA_Postal_Code;
		STRING4		Original_Postal_Code;
		STRING2		Original_Country_Code;
		STRING1		Primary_Address_Indicator;
		STRING3		Address_Classification;
		Address.Layout_Clean182_fips;
		UNSIGNED8	rawaid				:=	0;
		STRING3		Original_Area_Code;
		STRING7		Original_Phone_Number;
		STRING10	Phone_Extension;
		STRING1		Primary_Phone_Indicator;
		STRING3		Published_Unlisted_Indicator;
		STRING3		Phone_Type;
		STRING10	Phone_Number;
		STRING9		Federal_TaxID_SSN;
		STRING3		Federal_TaxID_SSN_Identifier;
    UNSIGNED4 global_sid  :=  0;
    UNSIGNED8 record_sid  :=  0;
		STRING2		source;
	END;
	
	SHARED	dBOInformation			:=	PROJECT(dLinked,TRANSFORM(rBOInformation,
																	SELF.Version																	:=	LEFT.process_date;
																	SELF.Original_Version													:=	IF(	LEFT.original_process_date<>'',
																																												LEFT.original_process_date,
																																												LEFT.process_date);
																	SELF.dt_first_seen														:=	(UNSIGNED4)LEFT.Cycle_End_Date;
																	SELF.dt_last_seen															:=	(UNSIGNED4)LEFT.Cycle_End_Date;
																	SELF.dt_vendor_first_reported									:=	(UNSIGNED4)LEFT.process_date;
																	SELF.dt_vendor_last_reported									:=	(UNSIGNED4)LEFT.process_date;
																	SELF.dt_datawarehouse_first_reported					:=	(UNSIGNED4)LEFT.Extracted_Date;
																	SELF.dt_datawarehouse_last_reported						:=	(UNSIGNED4)LEFT.Extracted_Date;
																	SELF.Percent_Of_Ownership_If_Owner_Principal	:=	LEFT.Percent_Of_Ownership;
																	SELF																					:=	LEFT));
	SHARED	dBOInformationDist	:=	SORT(DISTRIBUTE(dBOInformation,
																	HASH(	record_type, Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported, Account_Holder_Business_Name, Clean_Account_Holder_Business_Name, 
																				Business_Name, Clean_Business_Name, Company_Website, Guarantor_Owner_Indicator,
																				Relationship_To_Business_Indicator, Percent_Of_Liability, Percent_Of_Ownership_If_Owner_Principal,
																				Original_Address_Line_1, Original_Address_Line_2, Original_City, 
																				Original_State, Original_Zip_Code_or_CA_Postal_Code, Original_Postal_Code, Original_Country_Code, 
																				Primary_Address_Indicator, Address_Classification, prim_range, predir, prim_name,
																				addr_suffix, postdir, unit_desig, sec_range, p_city_name, v_city_name, st, zip, zip4, cart, cr_sort_sz, lot, 
																				lot_order, dbpc, chk_digit, rec_type, fips_state, fips_county, geo_lat, geo_long, msa, geo_blk, geo_match, 
																				err_stat, Original_Area_Code, Original_Phone_Number, Phone_Extension, Primary_Phone_Indicator, 
																				Published_Unlisted_Indicator, Phone_Type, Phone_Number, Federal_TaxID_SSN, Federal_TaxID_SSN_Identifier)),
																				//	SORT
																				record_type, Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported, Account_Holder_Business_Name, Clean_Account_Holder_Business_Name, 
																				Business_Name, Clean_Business_Name, Company_Website, Guarantor_Owner_Indicator,
																				Relationship_To_Business_Indicator, Percent_Of_Liability, Percent_Of_Ownership_If_Owner_Principal,
																				Original_Address_Line_1, Original_Address_Line_2, Original_City, 
																				Original_State, Original_Zip_Code_or_CA_Postal_Code, Original_Postal_Code, Original_Country_Code, 
																				Primary_Address_Indicator, Address_Classification, prim_range, predir, prim_name,
																				addr_suffix, postdir, unit_desig, sec_range, p_city_name, v_city_name, st, zip, zip4, cart, cr_sort_sz, lot, 
																				lot_order, dbpc, chk_digit, rec_type, fips_state, fips_county, geo_lat, geo_long, msa, geo_blk, geo_match, 
																				err_stat, Original_Area_Code, Original_Phone_Number, Phone_Extension, Primary_Phone_Indicator, 
																				Published_Unlisted_Indicator, Phone_Type, Phone_Number, Federal_TaxID_SSN, Federal_TaxID_SSN_Identifier,
																				-UltID, -OrgID, -SeleID, -ProxID, -PowID, -EmpID, -DotID, LOCAL);
	
	SHARED	rBOInformation	tFillDates(rBOInformation	L,	rBOInformation	R)	:=	TRANSFORM
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
	
	SHARED	dBOInformationWithDates	:=	ROLLUP(
														dBOInformationDist,
															LEFT.record_type													=	RIGHT.record_type													AND
															LEFT.Sbfe_Contributor_Number							=	RIGHT.Sbfe_Contributor_Number							AND
															LEFT.Contract_Account_Number							=	RIGHT.Contract_Account_Number							AND
															LEFT.Account_Type_Reported								=	RIGHT.Account_Type_Reported								AND
															LEFT.Account_Holder_Business_Name					=	RIGHT.Account_Holder_Business_Name				AND
															LEFT.Clean_Account_Holder_Business_Name		=	RIGHT.Clean_Account_Holder_Business_Name	AND
															LEFT.Business_Name												=	RIGHT.Business_Name												AND
															LEFT.Clean_Business_Name									=	RIGHT.Clean_Business_Name									AND
															LEFT.Company_Website											=	RIGHT.Company_Website											AND
															LEFT.Guarantor_Owner_Indicator						=	RIGHT.Guarantor_Owner_Indicator						AND
															LEFT.Relationship_To_Business_Indicator		=	RIGHT.Relationship_To_Business_Indicator	AND
															LEFT.Percent_Of_Liability									=	RIGHT.Percent_Of_Liability								AND
															LEFT.Percent_Of_Ownership_If_Owner_Principal	=	RIGHT.Percent_Of_Ownership_If_Owner_Principal	AND
															LEFT.Original_Address_Line_1							=	RIGHT.Original_Address_Line_1							AND
															LEFT.Original_Address_Line_2							=	RIGHT.Original_Address_Line_2							AND
															LEFT.Original_City												=	RIGHT.Original_City												AND
															LEFT.Original_State												=	RIGHT.Original_State											AND
															LEFT.Original_Zip_Code_or_CA_Postal_Code	=	RIGHT.Original_Zip_Code_or_CA_Postal_Code	AND
															LEFT.Original_Postal_Code									=	RIGHT.Original_Postal_Code								AND
															LEFT.Original_Country_Code								=	RIGHT.Original_Country_Code								AND
															LEFT.Primary_Address_Indicator						=	RIGHT.Primary_Address_Indicator						AND
															LEFT.Address_Classification								=	RIGHT.Address_Classification							AND
															LEFT.prim_range														=	RIGHT.prim_range													AND
															LEFT.predir																=	RIGHT.predir															AND
															LEFT.prim_name														=	RIGHT.prim_name														AND
															LEFT.addr_suffix													=	RIGHT.addr_suffix													AND
															LEFT.postdir															=	RIGHT.postdir															AND
															LEFT.unit_desig														=	RIGHT.unit_desig													AND
															LEFT.sec_range														=	RIGHT.sec_range														AND
															LEFT.p_city_name													=	RIGHT.p_city_name													AND
															LEFT.v_city_name													=	RIGHT.v_city_name													AND
															LEFT.st																		=	RIGHT.st																	AND
															LEFT.zip																	=	RIGHT.zip																	AND
															LEFT.zip4																	=	RIGHT.zip4																AND
															LEFT.cart																	=	RIGHT.cart																AND
															LEFT.cr_sort_sz														=	RIGHT.cr_sort_sz													AND
															LEFT.lot																	=	RIGHT.lot																	AND
															LEFT.lot_order														=	RIGHT.lot_order														AND
															LEFT.dbpc																	=	RIGHT.dbpc																AND
															LEFT.chk_digit														=	RIGHT.chk_digit														AND
															LEFT.rec_type															=	RIGHT.rec_type														AND
															LEFT.fips_state														=	RIGHT.fips_state													AND
															LEFT.fips_county													=	RIGHT.fips_county													AND
															LEFT.geo_lat															=	RIGHT.geo_lat															AND
															LEFT.geo_long															=	RIGHT.geo_long														AND
															LEFT.msa																	=	RIGHT.msa																	AND
															LEFT.geo_blk															=	RIGHT.geo_blk															AND
															LEFT.geo_match														=	RIGHT.geo_match														AND
															LEFT.err_stat															=	RIGHT.err_stat														AND
															LEFT.Original_Area_Code										=	RIGHT.Original_Area_Code									AND
															LEFT.Original_Phone_Number								=	RIGHT.Original_Phone_Number								AND
															LEFT.Phone_Extension											=	RIGHT.Phone_Extension											AND
															LEFT.Primary_Phone_Indicator							=	RIGHT.Primary_Phone_Indicator							AND
															LEFT.Published_Unlisted_Indicator					=	RIGHT.Published_Unlisted_Indicator				AND
															LEFT.Phone_Type														=	RIGHT.Phone_Type													AND
															LEFT.Phone_Number													=	RIGHT.Phone_Number												AND
															LEFT.Federal_TaxID_SSN										=	RIGHT.Federal_TaxID_SSN										AND
															LEFT.Federal_TaxID_SSN_Identifier					=	RIGHT.Federal_TaxID_SSN_Identifier,
														tFillDates(LEFT,RIGHT),
														LOCAL
													);

  // DEFINE THE INDEX
	SHARED	superfile_name	:=	Business_Credit.keynames().BOInformation.QA;	
		// If this is a daily build then only create a key with today's records
	SHARED	Base			:=	IF(	pBuildType	= Constants().buildType.Daily,
														dBOInformationWithDates(Version=pVersion),
														dBOInformationWithDates);
	
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
								UNSIGNED2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
								STRING DataPermissionMask = '',										//Default will fail the fetch. Pos 12 must be set to '1'
								INTEGER JoinLimit = 10000 
								):=FUNCTION

		inputs_for2 := PROJECT(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, DataPermissionMask, JoinLimit);		
		RETURN PROJECT(f2, RECORDOF(Key));																						

	END;

END;
