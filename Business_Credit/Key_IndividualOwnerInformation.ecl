IMPORT	Business_Credit,	BIPV2,	Address,	doxie,	lib_date,	STD;
EXPORT	Key_IndividualOwnerInformation(	STRING pVersion	=	(STRING8)Std.Date.Today(),
																				Constants().buildType	pBuildType	=	Constants().buildType.Daily)	:=	FUNCTION

	dLinked	:=	Business_Credit.Files().LinkIDs(record_type=Constants().IS);

	rIOInformation	:=	RECORD	
		STRING		Version;
		STRING		Original_Version;
		STRING2		record_type;
		BIPV2.IDlayouts.l_xlink_ids;	//	Added for BIP project
		UNSIGNED6	did;
		UNSIGNED1	did_score;
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
		STRING3		Percent_Of_Ownership;
		STRING50	Original_fname;
		STRING50	Original_mname;
		STRING50	Original_lname;
		STRING5		Original_suffix;
		STRING100	E_Mail_Address;
		STRING5		Clean_title;
		STRING20	Clean_fname;
		STRING20	Clean_mname;
		STRING20	Clean_lname;
		STRING5		Clean_suffix;
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
		STRING2		source;
		//DF-26180 Add CCPA fields to thor_data400::key::sbfe::qa::individualownerinformation
		UNSIGNED4	global_sid;
		UNSIGNED8   record_sid;
	END;
	
	dIOInformation			:=	PROJECT(dLinked,TRANSFORM(rIOInformation,
																	SELF.Version													:=	LEFT.process_date;
																	SELF.Original_Version									:=	IF(	LEFT.original_process_date<>'',
																																								LEFT.original_process_date,
																																								LEFT.process_date);
																	SELF.dt_first_seen										:=	(UNSIGNED4)LEFT.Cycle_End_Date;
																	SELF.dt_last_seen											:=	(UNSIGNED4)LEFT.Cycle_End_Date;
																	SELF.dt_vendor_first_reported					:=	(UNSIGNED4)LEFT.process_date;
																	SELF.dt_vendor_last_reported					:=	(UNSIGNED4)LEFT.process_date;
																	SELF.dt_datawarehouse_first_reported	:=	(UNSIGNED4)LEFT.Extracted_Date;
																	SELF.dt_datawarehouse_last_reported		:=	(UNSIGNED4)LEFT.Extracted_Date;
																	SELF																	:=	LEFT));

	dIOInformationDist	:=	SORT(DISTRIBUTE(dIOInformation,
																	HASH(	record_type, Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported, Account_Holder_Business_Name, Clean_Account_Holder_Business_Name, 
																				Business_Name, Clean_Business_Name, Company_Website, 
																				Guarantor_Owner_Indicator, Relationship_To_Business_Indicator, Percent_Of_Liability, Percent_Of_Ownership;
																				Original_fname, Original_mname, Original_lname, Original_suffix, E_Mail_Address, 
																				Clean_title, Clean_fname, Clean_mname, Clean_lname, Clean_suffix, Original_Address_Line_1, Original_Address_Line_2, Original_City, 
																				Original_State, Original_Zip_Code_or_CA_Postal_Code, Original_Postal_Code, Original_Country_Code, 
																				Primary_Address_Indicator, Address_Classification, prim_range, predir, prim_name,
																				addr_suffix, postdir, unit_desig, sec_range, p_city_name, v_city_name, st, zip, zip4, cart, cr_sort_sz, lot, 
																				lot_order, dbpc, chk_digit, rec_type, fips_state, fips_county, geo_lat, geo_long, msa, geo_blk, geo_match, 
																				err_stat, Original_Area_Code, Original_Phone_Number, Phone_Extension, Primary_Phone_Indicator, 
																				Published_Unlisted_Indicator, Phone_Type, Phone_Number, Federal_TaxID_SSN, Federal_TaxID_SSN_Identifier)),
																				//	SORT
																				record_type, Sbfe_Contributor_Number, Contract_Account_Number, Account_Type_Reported, Account_Holder_Business_Name, Clean_Account_Holder_Business_Name, 
																				Business_Name, Clean_Business_Name, Company_Website, 
																				Guarantor_Owner_Indicator, Relationship_To_Business_Indicator, Percent_Of_Liability, Percent_Of_Ownership;
																				Original_fname, Original_mname, Original_lname, Original_suffix, E_Mail_Address, 
																				Clean_title, Clean_fname, Clean_mname, Clean_lname, Clean_suffix, Original_Address_Line_1, Original_Address_Line_2, Original_City, 
																				Original_State, Original_Zip_Code_or_CA_Postal_Code, Original_Postal_Code, Original_Country_Code, 
																				Primary_Address_Indicator, Address_Classification, prim_range, predir, prim_name,
																				addr_suffix, postdir, unit_desig, sec_range, p_city_name, v_city_name, st, zip, zip4, cart, cr_sort_sz, lot, 
																				lot_order, dbpc, chk_digit, rec_type, fips_state, fips_county, geo_lat, geo_long, msa, geo_blk, geo_match, 
																				err_stat, Original_Area_Code, Original_Phone_Number, Phone_Extension, Primary_Phone_Indicator, 
																				Published_Unlisted_Indicator, Phone_Type, Phone_Number, Federal_TaxID_SSN, Federal_TaxID_SSN_Identifier,
																				-UltID, -OrgID, -SeleID, -ProxID, -PowID, -EmpID, -DotID, LOCAL);
	
	rIOInformation	tFillDates(rIOInformation	L,	rIOInformation	R)	:=	TRANSFORM
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
	
	dIOInformationWithDates	:=	ROLLUP(
														dIOInformationDist,
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
															LEFT.Percent_Of_Ownership									=	RIGHT.Percent_Of_Ownership								AND
															LEFT.Original_fname												=	RIGHT.Original_fname											AND
															LEFT.Original_mname												=	RIGHT.Original_mname											AND
															LEFT.Original_lname												=	RIGHT.Original_lname											AND
															LEFT.Original_suffix											=	RIGHT.Original_suffix											AND
															LEFT.E_Mail_Address												=	RIGHT.E_Mail_Address											AND
															LEFT.Clean_title													=	RIGHT.Clean_title													AND
															LEFT.Clean_fname													=	RIGHT.Clean_fname													AND
															LEFT.Clean_mname													=	RIGHT.Clean_mname													AND
															LEFT.Clean_lname													=	RIGHT.Clean_lname													AND
															LEFT.Clean_suffix													=	RIGHT.Clean_suffix												AND
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

		// If this is a daily build then only create a key with today's records
	dKeyResult			:=	IF(	pBuildType	= Constants().buildType.Daily,
													dIOInformationWithDates(did > 0 AND Version=pVersion),
													dIOInformationWithDates(did > 0));

	RETURN	INDEX(dKeyResult,{did},{dKeyResult},Business_Credit.keynames().IOInformation.QA);
END;