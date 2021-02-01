IMPORT BIPV2, Address, Business_Risk, Business_Risk_BIP, DID_Add, MDR, Risk_Indicators, SALT28, UT, ADVO, Doxie, STD;

EXPORT getBusinessHeader(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

	link_search_level := Options.LinkSearchLevel;

	// --------------- Business Header Build Date ----------------
	BHBuildDate := Risk_Indicators.get_Build_date('bip_build_version');

	// --------------- Business Shell Versioning logic ----------------
	calculateValueFor := Business_Risk_BIP.mod_BusinessShellVersionLogic(Options);

	// --------------- LexisNexis Business Header Searched By Ult ID ----------------

	// If running BIID2.0, search at input search level, since we don't use any UltID based attributes.
	// For other transactions, we search at UltID level to accurately calculate UltID-based attributes.
	LSL := IF(~Options.IsBIID20, Business_Risk_BIP.Constants.LinkSearch.UltID, link_search_level);

	BusinessHeaderUltRaw1 := BIPV2.Key_BH_Linking_Ids.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(LSL),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							linkingOptions,
																							Business_Risk_BIP.Constants.Limit_BusHeader,
																							FALSE, /* dnbFullRemove */
																							TRUE, /* bypassContactSuppression */
																							Options.KeepLargeBusinesses,
																							mod_access := mod_access);

		// clean up the business header before doing anything else
  Business_Risk_BIP.Common.mac_slim_header(BusinessHeaderUltRaw1, BusinessHeaderUltRaw);

	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BusinessHeaderUltRaw, Shell, BusinessHeaderUltSeq);


	// Figure out if the kFetch was successful
	kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(BusinessHeaderUltSeq);



	// Filter out records after our history date and sources that aren't allowed - pass in AllowedSources to possibly turn on DNB DMI data
	BusinessHeaderUlt := GROUP(Business_Risk_BIP.Common.FilterRecords(BusinessHeaderUltSeq, dt_first_seen, dt_vendor_first_reported, Source, AllowedSourcesSet), Seq);

	// --------------- LexisNexis Business Header ----------------
	// This Business Header will be a subset of the Ult ID version we got above.  Rather than doing two huge joins to the Business Header, do some fancy filtering
	// to make it look like this was a separate join.  Cuts down on both memory usage as well as latency.
	linkIDGroups := PROJECT(Shell, TRANSFORM({UNSIGNED6 Seq, UNSIGNED6 UltID, UNSIGNED6 OrgID, UNSIGNED6 SeleID, UNSIGNED6 ProxID, UNSIGNED6 PowID},
																					SELF.Seq := LEFT.Seq;
																					SELF.UltID := LEFT.BIP_IDs.UltID.LinkID;
																					SELF.OrgID := IF(link_search_level IN Business_Risk_BIP.Constants.UltIDSet, 0, LEFT.BIP_IDs.OrgID.LinkID);
																					SELF.SeleID := IF(link_search_level IN Business_Risk_BIP.Constants.UltOrgIDSet, 0, LEFT.BIP_IDs.SeleID.LinkID);
																					SELF.ProxID := IF(link_search_level IN Business_Risk_BIP.Constants.UltOrgSeleIDSet, 0, LEFT.BIP_IDs.ProxID.LinkID);
																					SELF.PowID := IF(link_search_level IN Business_Risk_BIP.Constants.UltOrgSeleProxIDSet, 0, LEFT.BIP_IDs.PowID.LinkID)));

	BusinessHeader := GROUP(JOIN(linkIDGroups, BusinessHeaderUlt, LEFT.Seq = RIGHT.Seq AND
																										(LEFT.UltID = RIGHT.UltID) AND // Should always match on UltID
																										(LEFT.OrgID = RIGHT.OrgID OR LEFT.OrgID = 0) AND // Not searching on only UltID - Match OrgID too
																										(LEFT.SeleID = RIGHT.SeleID OR LEFT.SeleID = 0) AND // Not searching on only UltID/OrgID - Match on SeleID too
																										(LEFT.ProxID = RIGHT.ProxID OR LEFT.ProxID = 0) AND // Not searching on only UltID/OrgID/SeleID - Match on ProxID too
																										(LEFT.PowID = RIGHT.PowID OR LEFT.PowID = 0), // Not searching on only UltID/OrgID/SeleID/ProxID - Match on PowID too
																TRANSFORM(RIGHT), LIMIT(Business_Risk_BIP.Constants.Limit_BusHeader)), Seq); // Unable to use ATMOST here due to the BIP ID = 0 checks above, but due to kftech we should never be near this limit anyways

	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	BusinessHeaderSourceStats := TABLE(BusinessHeader,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID),
			 Source,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_vendor_last_reported, HistoryDate),
			 UNSIGNED3 HistoryDate := HistoryDate,
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Source, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID)
			 );

	BusinessHeaderUniqueContactDIDs_all := TABLE(BusinessHeader,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID),
			 UNSIGNED6 ContactDID := (UNSIGNED)Contact_DID,
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 UNSIGNED3 HistoryDate := HistoryDate,
			 BOOLEAN IsCurrent := ut.DaysApart(Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate)+'01',
																				 Business_Risk_BIP.Common.todaysDate(BHBuildDate, HistoryDate)) <= ut.DaysInNYears(2),
			 BOOLEAN IsSOS := COUNT(GROUP, source in MDR.sourceTools.set_CorpV2) >= 1
			 },
			 Seq, Contact_DID, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID)
			  ) (ContactDID > 0);

	BusinessHeaderUniqueContactDIDs := DEDUP(SORT(BusinessHeaderUniqueContactDIDs_all, seq, ContactDID), seq, KEEP(100));

	BusinessHeaderTotalUniqueContactDIDs := TABLE(BusinessHeaderUniqueContactDIDs,
			{Seq,
			 UNSIGNED4 UniqueDIDCount := COUNT(GROUP, ContactDID > 0),
			 UNSIGNED4 CurrentUniqueDIDCount := COUNT(GROUP, ContactDID > 0 AND IsCurrent),
			 UNSIGNED4 CurrentUniqueSOSDIDCount := COUNT(GROUP, ContactDID > 0 AND IsCurrent AND IsSOS)
			}, Seq);

	Doxie.Mac_Best_Records(BusinessHeaderUniqueContactDIDs, ContactDID, getBestContactInfo, mod_access.isValidDppa(), mod_access.isValidGlb(), FALSE/* UseNonBlankKey */, mod_access.DataRestrictionMask, (BOOLEAN)(Options.MarketingMode = 1));

	// Now that we have all of the Unique DID's and their best information transform them into a DATASET that we can then pass around as needed
	tempContactsLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutContacts) ContactDIDs;
	END;
	tempContactsLayout getContactInfo(BusinessHeaderUniqueContactDIDs le, getBestContactInfo ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.ContactDIDs := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(Business_Risk_BIP.Layouts.LayoutContacts,
																												ContactAddress := Risk_Indicators.MOD_AddressClean.street_address('', ri.Prim_Range, ri.Predir, ri.Prim_Name, ri.Suffix, ri.Postdir, ri.Unit_Desig, ri.Sec_Range);
																		ContactCleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(ContactAddress, ri.City_Name, ri.St, ri.Zip);
																		cleanedContactAddress := Address.CleanFields(ContactCleanAddr);
																		SELF.Seq := le.Seq;
																		SELF.DID := le.ContactDID;
																		SELF.RecordCount := le.RecordCount;
																		SELF.HistoryDate := le.HistoryDate;//le.Clean_Input.HistoryDate;
																		SELF.IsCurrent := le.IsCurrent;
																		SELF.Title := ri.Title;
																		SELF.FName := ri.FName;
																		SELF.MName := ri.MName;
																		SELF.LName := ri.LName;
																		SELF.Name_Suffix := ri.Name_Suffix;
																		SELF.SSN := ri.SSN;
																		SELF.SSN_Unmasked := ri.SSN_Unmasked;
																		SELF.DOB := ri.DOB;
																		SELF.Phone := ri.Phone;
																		SELF.Prim_Range := cleanedContactAddress.Prim_Range;
																		SELF.Predir := cleanedContactAddress.Predir;
																		SELF.Prim_Name := cleanedContactAddress.Prim_Name;
																		SELF.Suffix := cleanedContactAddress.Addr_Suffix;
																		SELF.Postdir := cleanedContactAddress.Postdir;
																		SELF.Unit_Desig := cleanedContactAddress.Unit_Desig;
																		SELF.Sec_Range := cleanedContactAddress.Sec_Range;
																		SELF.City_Name := cleanedContactAddress.V_City_Name;
																		SELF.St := cleanedContactAddress.St;
																		SELF.Zip := cleanedContactAddress.Zip;
																		SELF.Zip4 := cleanedContactAddress.Zip4;
																		SELF.Lat := cleanedContactAddress.Geo_Lat;
																		SELF.Long := cleanedContactAddress.Geo_Long;
																		SELF.Addr_Type := cleanedContactAddress.Rec_Type;
																		SELF.Addr_Status := cleanedContactAddress.Err_Stat;
																		SELF.County := ContactCleanAddr[143..145];  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips;
																		SELF.Geo_Block := cleanedContactAddress.Geo_Blk;
																		SELF.Geo_Link := TRIM(cleanedContactAddress.St) + TRIM(ContactCleanAddr[143..145]) + TRIM(cleanedContactAddress.Geo_Blk);
																		SELF.Addr_Dt_Last_Seen := ri.Addr_Dt_Last_Seen;
																		SELF.DOD := ri.DOD;
																		SELF.Prpty_Deed_ID := ri.Prpty_Deed_ID;
																		SELF.Vehicle_Vehnum := ri.Vehicle_Vehnum;
																		SELF.Bkrupt_CrtCode_CaseNo := ri.Bkrupt_CrtCode_CaseNo;
																		SELF.DL_Number := ri.DL_Number;
																		SELF.Age := ri.Age;
																		SELF.Valid_SSN := ri.Valid_SSN;
																		SELF := []));
							SELF := [];
	END;
	BusinessHeaderUniqueContactsTemp := JOIN(BusinessHeaderUniqueContactDIDs, getBestContactInfo, LEFT.ContactDID = RIGHT.DID,
					getContactInfo(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));
	BusinessHeaderUniqueContacts := ROLLUP(SORT(BusinessHeaderUniqueContactsTemp, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(tempContactsLayout, SELF.ContactDIDs := LEFT.ContactDIDs + RIGHT.ContactDIDs; SELF := LEFT));

	withContactDIDs := GROUP(JOIN(Shell, BusinessHeaderUniqueContacts, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																					//		SELF.ContactDIDs := RIGHT.ContactDIDs;
																							SELF.ContactDIDs := TOPN(RIGHT.ContactDIDs, 1000, DID);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW), Seq);


  	STRING calcBNAT(BOOLEAN FEINMatched, BOOLEAN FEINPopulated, BOOLEAN NameMatched, BOOLEAN AddressMatched, BOOLEAN StateMatched) :=
										MAP(FEINMatched = TRUE AND		NameMatched = FALSE AND	AddressMatched = FALSE																=> '1', // Input FEIN returns a different Name and Address
												FEINMatched = FALSE AND		NameMatched = FALSE AND	AddressMatched = TRUE																	=> '2', // Input Address returns a different Name and FEIN
												FEINMatched = FALSE AND		NameMatched = TRUE AND	AddressMatched = FALSE AND StateMatched = TRUE				=> '3', // Input Business name exists in the state, but with a different Address and FEIN
												FEINMatched = TRUE AND		NameMatched = FALSE AND	AddressMatched = TRUE																	=> '4', // Input FEIN matches Address, but the Name is different
												FEINMatched = TRUE AND		NameMatched = TRUE AND	AddressMatched = FALSE																=> '5', // Input FEIN matches Business name, but the Address is different
												FEINPopulated = TRUE AND  FEINMatched = FALSE AND	NameMatched = TRUE AND	AddressMatched = TRUE					=> '6', // Input Business name matches Address, but the FEIN doesn't match
												FEINPopulated = FALSE AND NameMatched = TRUE AND	AddressMatched = TRUE																	=> '7', // Input Name matches Address, But the FEIN was not found or missing
												FEINMatched = TRUE AND		NameMatched = TRUE AND	AddressMatched = TRUE																	=> '8', // Input Business name, Address and FEIN Verified
																																																																	 '0');
	tempAddrPhoneHistLayout := RECORD
		STRING10 Company_Phone;
		STRING10 Prim_Range;
		STRING28 Prim_Name;
		STRING8 Sec_Range;
		STRING5 Zip;
		STRING2 St;
		STRING25 P_City_Name;
		STRING10 Geo_Lat;
		STRING11 Geo_Long;
		STRING8 DateFirstSeen;
		STRING8 DateLastSeen;
	END;

	tempVerificationLayout := RECORD
		Business_Risk_BIP.Layouts.Shell;
		BOOLEAN FEINMatched;
		BOOLEAN FEINPopulated;
		BOOLEAN NameMatched;
		BOOLEAN AddressMatched;
		BOOLEAN StateMatched;
		BOOLEAN PhoneMatched;
		BOOLEAN PhonePopulated;
		DATASET(tempAddrPhoneHistLayout) Address_Phone_History;
		DATASET({BOOLEAN InputAddress, STRING8 DateFirstSeen, STRING8 DateLastSeen}) Address_History;
	END;

	tempContactsScoresLayout := RECORD
		UNSIGNED4 Seq;
		Business_Risk_BIP.Layouts.LayoutContacts;
		boolean 	 RepAddressMatchedFile;
		boolean   RepAddressNotPopulatedFile;
		boolean   RepPhonePopulatedFile;
		boolean   RepPhoneMatchedFile;
		boolean   RepSSNFeinPopulatedFile;
		boolean   RepSSNPopulatedFile;
		boolean   RepSSNMatchedFile;
		boolean   RepSSNMatchedFeinFile;


		boolean 	 Rep2AddressMatchedFile;
		boolean   Rep2AddressNotPopulatedFile;
		boolean   Rep2PhonePopulatedFile;
		boolean   Rep2PhoneMatchedFile;
		boolean   Rep2SSNFeinPopulatedFile;
		boolean   Rep2SSNPopulatedFile;
		boolean   Rep2SSNMatchedFile;
		boolean   Rep2SSNMatchedFeinFile;

		boolean 	 Rep3AddressMatchedFile;
		boolean   Rep3AddressNotPopulatedFile;
		boolean   Rep3PhonePopulatedFile;
		boolean   Rep3PhoneMatchedFile;
		boolean   Rep3SSNFeinPopulatedFile;
		boolean   Rep3SSNPopulatedFile;
		boolean   Rep3SSNMatchedFile;
		Boolean   Rep3SSNMatchedFeinFile;

		boolean 	Rep4AddressMatchedFile;
		boolean   Rep4AddressNotPopulatedFile;
		boolean   Rep4PhonePopulatedFile;
		boolean   Rep4PhoneMatchedFile;
		boolean   Rep4SSNFeinPopulatedFile;
		boolean   Rep4SSNPopulatedFile;
		boolean   Rep4SSNMatchedFile;
		boolean   Rep4SSNMatchedFeinFile;

		boolean 	 Rep5AddressMatchedFile;
		boolean   Rep5AddressNotPopulatedFile;
		boolean   Rep5PhonePopulatedFile;
		boolean   Rep5PhoneMatchedFile;
		boolean   Rep5SSNFeinPopulatedFile;
		boolean   Rep5SSNPopulatedFile;
		boolean   Rep5SSNMatchedFile;
		Boolean   Rep5SSNMatchedFeinFile;

END;


	// Figure out which sources match Company Name, Company Address, Company Phone, Company FEIN
	tempVerificationLayout verifyElements(Business_Risk_BIP.Layouts.Shell le, BusinessHeader ri, INTEGER1 MaxFEINVer) := TRANSFORM
		NamePopulated				:= TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(ri.Company_Name) <> '';
		// In an effort to "short-circuit" all of the fuzzy matching, we will require that the first letter match - if it doesn't match it bypasses the slow fuzzy matching which speeds up our query
		NameMatchScore			:= IF(NamePopulated AND le.Clean_Input.CompanyName[1] = ri.Company_Name[1], Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.Company_Name), Risk_Indicators.iid_constants.default_empty_score);
		NameMatched					:= Risk_Indicators.iid_constants.g(NameMatchScore);

		DBANamePopulated 		:= TRIM(le.Clean_Input.CompanyName) <> '';
		DBANameMatched			:= DBANamePopulated AND le.Clean_Input.CompanyName[1] = ri.DBA_Name[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.DBA_Name));
		// Check to see if the Authorized Rep Name is part of the Company Name
		BusNameAuthRepFirst	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep_FirstName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep_FirstName));
		BusNameAuthRepPreferredFirst	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep_PreferredFirstName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep_PreferredFirstName));
		BusNameAuthRepLast	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep_LastName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep_LastName));
		BusNameAuthRepFull	:= Business_Risk_BIP.Common.SetBoolean((BusNameAuthRepFirst = '1' AND BusNameAuthRepLast = '1') OR (BusNameAuthRepPreferredFirst = '1' AND BusNameAuthRepLast = '1'));
		RepAR2BFNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep_FirstName <> '' AND STD.Str.Find(ri.fname, le.Clean_Input.Rep_FirstName, 1) > 0);
		RepAR2BLNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep_LastName <> '' AND STD.Str.Find(ri.lname, le.Clean_Input.Rep_LastName, 1) > 0);
		RepAR2BPreferredNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep_PreferredFirstName <> '' AND STD.Str.Find(ri.fname, le.Clean_Input.Rep_PreferredFirstName, 1) > 0);
		RepAR2BFullFile	:= Business_Risk_BIP.Common.SetBoolean((RepAR2BFNameFile = '1' AND RepAR2BLNameFile = '1') OR (RepAR2BPreferredNameFile = '1' AND RepAR2BLNameFile = '1'));

		BusNameAuthRep2First	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep2_FirstName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep2_FirstName));
		BusNameAuthRep2PreferredFirst	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep2_PreferredFirstName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep2_PreferredFirstName));
		BusNameAuthRep2Last	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep2_LastName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep2_LastName));
		BusNameAuthRep2Full	:= Business_Risk_BIP.Common.SetBoolean((BusNameAuthRep2First = '1' AND BusNameAuthRep2Last = '1') OR (BusNameAuthRep2PreferredFirst = '1' AND BusNameAuthRep2Last = '1'));
		Rep2AR2BFNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep2_FirstName <> '' AND STD.Str.Find(ri.fname, le.Clean_Input.Rep2_FirstName, 1) > 0);
		Rep2AR2BLNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep2_LastName <> '' AND STD.Str.Find(ri.lname, le.Clean_Input.Rep2_LastName, 1) > 0);
		Rep2AR2BPreferredNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep2_PreferredFirstName <> '' AND STD.Str.Find(ri.fname, le.Clean_Input.Rep2_PreferredFirstName, 1) > 0);
		Rep2AR2BFullFile	:= Business_Risk_BIP.Common.SetBoolean((Rep2AR2BFNameFile = '1' AND Rep2AR2BLNameFile = '1') OR (Rep2AR2BPreferredNameFile = '1' AND Rep2AR2BLNameFile = '1'));

		BusNameAuthRep3First	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep3_FirstName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep3_FirstName));
		BusNameAuthRep3PreferredFirst	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep3_PreferredFirstName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep3_PreferredFirstName));
		BusNameAuthRep3Last	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep3_LastName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep3_LastName));
		BusNameAuthRep3Full	:= Business_Risk_BIP.Common.SetBoolean((BusNameAuthRep3First = '1' AND BusNameAuthRep3Last = '1') OR (BusNameAuthRep3PreferredFirst = '1' AND BusNameAuthRep3Last = '1'));
		Rep3AR2BFNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep3_FirstName <> '' AND STD.Str.Find(ri.fname, le.Clean_Input.Rep3_FirstName, 1) > 0);
		Rep3AR2BLNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep3_LastName <> '' AND STD.Str.Find(ri.lname, le.Clean_Input.Rep3_LastName, 1) > 0);
		Rep3AR2BPreferredNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep3_PreferredFirstName <> '' AND STD.Str.Find(ri.fname, le.Clean_Input.Rep3_PreferredFirstName, 1) > 0);
		Rep3AR2BFullFile	:= Business_Risk_BIP.Common.SetBoolean((Rep3AR2BFNameFile = '1' AND Rep3AR2BLNameFile = '1') OR (Rep3AR2BPreferredNameFile = '1' AND Rep3AR2BLNameFile = '1'));

		BusNameAuthRep4First	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep4_FirstName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep4_FirstName));
		BusNameAuthRep4PreferredFirst	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep4_PreferredFirstName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep4_PreferredFirstName));
		BusNameAuthRep4Last	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep4_LastName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep4_LastName));
		BusNameAuthRep4Full	:= Business_Risk_BIP.Common.SetBoolean((BusNameAuthRep4First = '1' AND BusNameAuthRep4Last = '1') OR (BusNameAuthRep4PreferredFirst = '1' AND BusNameAuthRep4Last = '1'));
		Rep4AR2BFNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep4_FirstName <> '' AND STD.Str.Find(ri.fname, le.Clean_Input.Rep4_FirstName, 1) > 0);
		Rep4AR2BLNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep4_LastName <> '' AND STD.Str.Find(ri.lname, le.Clean_Input.Rep4_LastName, 1) > 0);
		Rep4AR2BPreferredNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep4_PreferredFirstName <> '' AND STD.Str.Find(ri.fname, le.Clean_Input.Rep4_PreferredFirstName, 1) > 0);
		Rep4AR2BFullFile	:= Business_Risk_BIP.Common.SetBoolean((Rep4AR2BFNameFile = '1' AND Rep4AR2BLNameFile = '1') OR (Rep4AR2BPreferredNameFile = '1' AND Rep4AR2BLNameFile = '1'));

		BusNameAuthRep5First	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep5_FirstName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep5_FirstName));
		BusNameAuthRep5PreferredFirst	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep5_PreferredFirstName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep5_PreferredFirstName));
		BusNameAuthRep5Last	:= Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep5_LastName <> '' AND calculateValueFor._BusNameAuthRepMatch(ri.Company_Name, le.Clean_Input.Rep5_LastName));
		BusNameAuthRep5Full	:= Business_Risk_BIP.Common.SetBoolean((BusNameAuthRep5First = '1' AND BusNameAuthRep5Last = '1') OR (BusNameAuthRep5PreferredFirst = '1' AND BusNameAuthRep5Last = '1'));
		Rep5AR2BFNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep5_FirstName <> '' AND STD.Str.Find(ri.fname, le.Clean_Input.Rep5_FirstName, 1) > 0);
		Rep5AR2BLNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep5_LastName <> '' AND STD.Str.Find(ri.lname, le.Clean_Input.Rep5_LastName, 1) > 0);
		Rep5AR2BPreferredNameFile       := Business_Risk_BIP.Common.SetBoolean(le.Clean_Input.Rep5_PreferredFirstName <> '' AND STD.Str.Find(ri.fname, le.Clean_Input.Rep5_PreferredFirstName, 1) > 0);
		Rep5AR2BFullFile	:= Business_Risk_BIP.Common.SetBoolean((Rep5AR2BFNameFile = '1' AND Rep5AR2BLNameFile = '1') OR (Rep5AR2BPreferredNameFile = '1' AND Rep5AR2BLNameFile = '1'));


		AddressPopulated		:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';
		NoScoreValue				:= 255; // This is what the various score functions return if blank is passed in
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Zip), NoScoreValue);
		StateMatched				:= STD.Str.ToUpperCase(le.Clean_Input.State) = STD.Str.ToUpperCase(ri.st);
		CityStateScore			:= IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND StateMatched,
															Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.st, ''), NoScoreValue);
		CityStateZipMatched	:= AddressPopulated AND Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore);

		AddressScore := MAP(NOT AddressPopulated => NoScoreValue,
												AddressPopulated AND ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue => NoScoreValue,
																																		Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																																		ri.prim_range, ri.prim_name, ri.sec_range,
																																		ZIPScore, CityStateScore));
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(AddressScore);
		//
		BestAddressPopulated := TRIM(le.Best_Info.BestPrimName) <> '' AND TRIM(le.Best_Info.BestCompanyZip) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';
		BestZIPScore						:= IF(le.Best_Info.BestCompanyZip <> '' AND ri.Zip <> '' AND le.Best_Info.BestCompanyZip[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Best_Info.BestCompanyZip, ri.Zip), NoScoreValue);
		BestStateMatched				:= STD.Str.ToUpperCase(le.Best_Info.BestCompanyState) = STD.Str.ToUpperCase(ri.st);
		BestCityStateScore			:= IF(le.Best_Info.BestCompanyCity <> '' AND le.Best_Info.BestCompanyState <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND BestStateMatched,
															Risk_Indicators.AddrScore.CityState_Score(le.Best_Info.BestCompanyCity, le.Best_Info.BestCompanyState, ri.p_city_name, ri.st, ''), NoScoreValue);
		BestCityStateZipMatched	:= BestAddressPopulated AND Risk_Indicators.iid_constants.ga(BestZIPScore) AND Risk_Indicators.iid_constants.ga(BestCityStateScore);

		BestAddressScore := MAP(NOT BestAddressPopulated => NoScoreValue,
												BestAddressPopulated AND BestZIPScore = NoScoreValue AND BestCityStateScore = NoScoreValue => NoScoreValue,
																																		Risk_Indicators.AddrScore.AddressScore(le.Best_Info.BestPrimRange, le.Best_Info.BestPrimName, le.Best_Info.BestSecRange,
																																		ri.prim_range, ri.prim_name, ri.sec_range,
																																		BestZIPScore, BestCityStateScore));
		BestAddressMatched			:= BestAddressPopulated AND Risk_Indicators.iid_constants.ga(BestAddressScore);

		SELF.Verification.AddrMiskey := MAP(NOT AddressPopulated								  => '-1',
																				AddressMatched AND AddressScore < 100 => '1',
																																								 '0');
		SELF.Verification.AddrZipVerification := MAP(le.Clean_Input.Zip5 = '' 									 => '-1',
																									Risk_Indicators.iid_constants.ga(ZIPScore) => '1',
																																																'0');
		RepInputPhonePopulated := TRIM(le.Clean_Input.Rep_Phone10) <> '';
		RepInputPhoneMatched := RepInputPhonePopulated AND (le.Clean_Input.Rep_Phone10[1] = ri.contact_phone[1] OR le.Clean_Input.Rep_Phone10[4] = ri.contact_phone[4] OR le.Clean_Input.Rep_Phone10[4] = ri.contact_phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep_Phone10, ri.contact_phone));

		Rep2InputPhonePopulated := TRIM(le.Clean_Input.Rep2_Phone10) <> '';
		Rep2InputPhoneMatched := Rep2InputPhonePopulated AND (le.Clean_Input.Rep2_Phone10[1] = ri.contact_phone[1] OR le.Clean_Input.Rep2_Phone10[4] = ri.contact_phone[4] OR le.Clean_Input.Rep2_Phone10[4] = ri.contact_phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep2_Phone10, ri.contact_phone));

		Rep3InputPhonePopulated := TRIM(le.Clean_Input.Rep3_Phone10) <> '';
		Rep3InputPhoneMatched := Rep3InputPhonePopulated AND (le.Clean_Input.Rep3_Phone10[1] = ri.contact_phone[1] OR le.Clean_Input.Rep3_Phone10[4] = ri.contact_phone[4] OR le.Clean_Input.Rep3_Phone10[4] = ri.contact_phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep3_Phone10, ri.contact_phone));

		Rep4InputPhonePopulated := TRIM(le.Clean_Input.Rep4_Phone10) <> '';
		Rep4InputPhoneMatched := Rep4InputPhonePopulated AND (le.Clean_Input.Rep4_Phone10[1] = ri.contact_phone[1] OR le.Clean_Input.Rep4_Phone10[4] = ri.contact_phone[4] OR le.Clean_Input.Rep4_Phone10[4] = ri.contact_phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep4_Phone10, ri.contact_phone));

		Rep5InputPhonePopulated := TRIM(le.Clean_Input.Rep5_Phone10) <> '';
		Rep5InputPhoneMatched := Rep5InputPhonePopulated AND (le.Clean_Input.Rep5_Phone10[1] = ri.contact_phone[1] OR le.Clean_Input.Rep5_Phone10[4] = ri.contact_phone[4] OR le.Clean_Input.Rep5_Phone10[4] = ri.contact_phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep5_Phone10, ri.contact_phone));

		RepInputSSNPopulated := (INTEGER)le.Clean_Input.rep_ssn > 0;
		RepSSNLength								:= LENGTH(TRIM(le.Clean_Input.Rep_SSN));
		RepInputSSNMatched := MAP(NOT RepInputSSNPopulated																																				=> FALSE,
															RepInputSSNPopulated AND le.Clean_Input.Rep_SSN[1] = ri.contact_ssn[IF(RepSSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep_SSN, ri.contact_ssn, RepSSNLength=4)),
																																																																 FALSE);

		Rep2InputSSNPopulated := (INTEGER)le.Clean_Input.Rep2_SSN > 0;
		Rep2SSNLength								:= LENGTH(TRIM(le.Clean_Input.Rep2_SSN));
		Rep2InputSSNMatched := MAP(NOT Rep2InputSSNPopulated																																				=> FALSE,
															Rep2InputSSNPopulated AND le.Clean_Input.Rep2_SSN[1] = ri.contact_ssn[IF(Rep2SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep2_SSN, ri.contact_ssn, Rep2SSNLength=4)),
																																																																 FALSE);

		Rep3InputSSNPopulated := (INTEGER)le.Clean_Input.Rep3_SSN > 0;
		Rep3SSNLength								:= LENGTH(TRIM(le.Clean_Input.Rep3_SSN));
		Rep3InputSSNMatched := MAP(NOT Rep3InputSSNPopulated																																				=> FALSE,
															Rep3InputSSNPopulated AND le.Clean_Input.Rep3_SSN[1] = ri.contact_ssn[IF(Rep3SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep3_SSN, ri.contact_ssn, Rep3SSNLength=4)),
																																																																 FALSE);
		Rep4InputSSNPopulated := (INTEGER)le.Clean_Input.Rep4_SSN > 0;
		Rep4SSNLength								:= LENGTH(TRIM(le.Clean_Input.Rep4_SSN));
		Rep4InputSSNMatched := MAP(NOT Rep4InputSSNPopulated																																				=> FALSE,
															Rep4InputSSNPopulated AND le.Clean_Input.Rep4_SSN[1] = ri.contact_ssn[IF(Rep4SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep4_SSN, ri.contact_ssn, Rep4SSNLength=4)),
																																																																 FALSE);

		Rep5InputSSNPopulated := (INTEGER)le.Clean_Input.Rep5_SSN > 0;
		Rep5SSNLength								:= LENGTH(TRIM(le.Clean_Input.Rep5_SSN));
		Rep5InputSSNMatched := MAP(NOT Rep5InputSSNPopulated																																				=> FALSE,
															Rep5InputSSNPopulated AND le.Clean_Input.Rep5_SSN[1] = ri.contact_ssn[IF(Rep5SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep5_SSN, ri.contact_ssn, Rep5SSNLength=4)),
																																																																 FALSE);


		RepInputNamePopulated := TRIM(le.Clean_Input.Rep_FirstName) <> '' OR TRIM(le.Clean_Input.Rep_LastName) <> ''; // Populated if first or last are sent in
		RepInputLexIDPopulated := le.Clean_Input.Rep_LexID > 0;
		RepLexIDMatched := RepInputLexIDPopulated AND le.Clean_Input.Rep_LexID = ri.contact_did;

    Rep2InputNamePopulated := TRIM(le.Clean_Input.Rep2_FirstName) <> '' OR TRIM(le.Clean_Input.Rep2_LastName) <> '';
		Rep2InputLexIDPopulated := le.Clean_Input.Rep2_LexID > 0;
		Rep2LexIDMatched := Rep2InputLexIDPopulated AND le.Clean_Input.Rep2_LexID = ri.contact_did;

		Rep3InputNamePopulated := TRIM(le.Clean_Input.Rep3_FirstName) <> '' OR TRIM(le.Clean_Input.Rep3_LastName) <> '';
		Rep3InputLexIDPopulated := le.Clean_Input.Rep3_LexID > 0;
		Rep3LexIDMatched := Rep3InputLexIDPopulated AND le.Clean_Input.Rep3_LexID = ri.contact_did;

		Rep4InputNamePopulated := TRIM(le.Clean_Input.Rep4_FirstName) <> '' OR TRIM(le.Clean_Input.Rep4_LastName) <> '';
		Rep4InputLexIDPopulated := le.Clean_Input.Rep4_LexID > 0;
		Rep4LexIDMatched := Rep4InputLexIDPopulated AND le.Clean_Input.Rep4_LexID = ri.contact_did;

		Rep5InputNamePopulated := TRIM(le.Clean_Input.Rep5_FirstName) <> '' OR TRIM(le.Clean_Input.Rep5_LastName) <> '';
    Rep5InputLexIDPopulated := le.Clean_Input.Rep5_LexID > 0;
		Rep5LexIDMatched := Rep5InputLexIDPopulated AND le.Clean_Input.Rep5_LexID = ri.contact_did;

		SELF.Business_To_Executive_Link.BusExecLinkAuthRepLexIDOnFile := MAP(NOT RepInputLexIDPopulated AND NOT RepInputNamePopulated => '-1',
                                              NOT RepInputLexIDPopulated AND  RepInputNamePopulated                               => '0',
																							RepInputLexIDPopulated AND NOT RepLexIDMatched				                              => '1',
																							RepInputLexIDPopulated AND  RepLexIDMatched 					                              => '2',
                                                                                                                                     '0');

		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2LexIDOnFile := MAP(NOT Rep2InputLexIDPopulated AND NOT Rep2InputNamePopulated => '-1',
                                              NOT Rep2InputLexIDPopulated AND  Rep2InputNamePopulated                                => '0',
																							Rep2InputLexIDPopulated AND NOT Rep2LexIDMatched				                               => '1',
																							Rep2InputLexIDPopulated AND  Rep2LexIDMatched 					                               => '2',
                                                                                                                                        '0');

		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3LexIDOnFile := MAP(NOT Rep3InputLexIDPopulated AND NOT Rep3InputNamePopulated => '-1',
                                              NOT Rep3InputLexIDPopulated AND  Rep3InputNamePopulated                                => '0',
																							Rep3InputLexIDPopulated AND NOT Rep3LexIDMatched				                               => '1',
																							Rep3InputLexIDPopulated AND  Rep3LexIDMatched 					                               => '2',
                                                                                                                                        '0');

		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4LexIDOnFile := MAP(NOT Rep4InputLexIDPopulated AND NOT Rep4InputNamePopulated => '-1',
                                              NOT Rep4InputLexIDPopulated AND  Rep4InputNamePopulated                                => '0',
																							Rep4InputLexIDPopulated AND NOT Rep4LexIDMatched				                               => '1',
																							Rep4InputLexIDPopulated AND  Rep4LexIDMatched 					                               => '2',
                                                                                                                                        '0');

		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5LexIDOnFile := MAP(NOT Rep5InputLexIDPopulated AND NOT Rep5InputNamePopulated => '-1',
                                              NOT Rep5InputLexIDPopulated AND  Rep5InputNamePopulated                                => '0',
																							Rep5InputLexIDPopulated AND NOT Rep5LexIDMatched				                               => '1',
																							Rep5InputLexIDPopulated AND  Rep5LexIDMatched 					                               => '2',
                                                                                                                                        '0');

		SELF.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile	:= Map(RepInputNamePopulated = FALSE														=> '-1',
																							RepInputNamePopulated = TRUE AND TRIM(ri.fname) = '' AND TRIM(ri.lname) = ''				=> '0',
																							RepInputNamePopulated = TRUE AND RepAR2BFNameFile = '1' AND RepAR2BLNameFile = '0'	=> '1',
																							RepInputNamePopulated = TRUE AND RepAR2BLNameFile = '1' AND RepAR2BFNameFile = '0'	=> '2',
																							RepInputNamePopulated = TRUE AND RepAR2BFullFile = '1'															=> '3',
																																																																		 '0');

		SELF.Business_To_Executive_Link.AR2BRep1PhoneBusHeader := MAP(NOT RepInputPhonePopulated 			=> '-1',
																							RepInputPhonePopulated AND RepInputPhoneMatched 		=> '1',
																							RepInputPhonePopulated AND NOT RepInputPhoneMatched => '0',
																																																		 '0');
		SELF.Business_To_Executive_Link.AR2BRep2PhoneBusHeader := MAP(NOT Rep2InputPhonePopulated 			=> '-1',
																							Rep2InputPhonePopulated AND Rep2InputPhoneMatched 		=> '1',
																							Rep2InputPhonePopulated AND NOT Rep2InputPhoneMatched => '0',
																																																			 '0');

		SELF.Business_To_Executive_Link.AR2BRep3PhoneBusHeader := MAP(NOT Rep3InputPhonePopulated 			=> '-1',
																							Rep3InputPhonePopulated AND Rep3InputPhoneMatched 		=> '1',
																							Rep3InputPhonePopulated AND NOT Rep3InputPhoneMatched => '0',
																																																			 '0');

		SELF.Business_To_Executive_Link.AR2BRep4PhoneBusHeader := MAP(NOT Rep4InputPhonePopulated 			=> '-1',
																							Rep4InputPhonePopulated AND Rep4InputPhoneMatched 		=> '1',
																							Rep4InputPhonePopulated AND NOT Rep4InputPhoneMatched => '0',
																																																			 '0');

		SELF.Business_To_Executive_Link.AR2BRep5PhoneBusHeader := MAP(NOT Rep5InputPhonePopulated 			=> '-1',
																							Rep5InputPhonePopulated AND Rep5InputPhoneMatched 		=> '1',
																							Rep5InputPhonePopulated AND NOT Rep5InputPhoneMatched => '0',
																																																		   '0');



		SELF.Business_To_Executive_Link.AR2BRep1SSNBusHeader := MAP(NOT RepInputSSNPopulated 					=> '-1',
																							RepInputSSNPopulated AND RepInputSSNMatched 				=> '1',
																							RepInputSSNPopulated AND NOT RepInputSSNMatched 		=> '0',
																																																		 '0');

		SELF.Business_To_Executive_Link.AR2BRep2SSNBusHeader := MAP(NOT Rep2InputSSNPopulated 					=> '-1',
																							Rep2InputSSNPopulated AND Rep2InputSSNMatched 				=> '1',
																							Rep2InputSSNPopulated AND NOT Rep2InputSSNMatched 		=> '0',
																																																		   '0');

		SELF.Business_To_Executive_Link.AR2BRep3SSNBusHeader := MAP(NOT Rep3InputSSNPopulated 					=> '-1',
																							Rep3InputSSNPopulated AND Rep3InputSSNMatched 				=> '1',
																							Rep3InputSSNPopulated AND NOT Rep3InputSSNMatched 		=> '0',
																																																		   '0');
		SELF.Business_To_Executive_Link.AR2BRep4SSNBusHeader := MAP(NOT Rep4InputSSNPopulated 					=> '-1',
																							Rep4InputSSNPopulated AND Rep4InputSSNMatched 				=> '1',
																							Rep4InputSSNPopulated AND NOT Rep4InputSSNMatched 		=> '0',
																																																		   '0');

		SELF.Business_To_Executive_Link.AR2BRep5SSNBusHeader := MAP(NOT Rep5InputSSNPopulated 					=> '-1',
																							Rep5InputSSNPopulated AND Rep5InputSSNMatched 				=> '1',
																							Rep5InputSSNPopulated AND NOT Rep5InputSSNMatched 		=> '0',
																																																		   '0');



		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile	:= Map(Rep2InputNamePopulated = FALSE															=> '-1',
																							Rep2InputNamePopulated = TRUE AND TRIM(ri.fname) = '' AND TRIM(ri.lname) = ''					=> '0',
																							Rep2InputNamePopulated = TRUE AND Rep2AR2BFNameFile = '1' AND Rep2AR2BLNameFile = '0'	=> '1',
																							Rep2InputNamePopulated = TRUE AND Rep2AR2BLNameFile = '1' AND Rep2AR2BFNameFile = '0'	=> '2',
																							Rep2InputNamePopulated = TRUE AND Rep2AR2BFullFile = '1'															=> '3',
																																																																			 '0');
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3NameOnFile	:= Map(Rep3InputNamePopulated = FALSE															=> '-1',
																							Rep3InputNamePopulated = TRUE AND TRIM(ri.fname) = '' AND TRIM(ri.lname) = ''					=> '0',
																							Rep3InputNamePopulated = TRUE AND Rep3AR2BFNameFile = '1' AND Rep3AR2BLNameFile = '0'	=> '1',
																							Rep3InputNamePopulated = TRUE AND Rep3AR2BLNameFile = '1' AND Rep3AR2BFNameFile = '0'	=> '2',
																							Rep3InputNamePopulated = TRUE AND Rep3AR2BFullFile = '1'															=> '3',
																																																																			 '0');


		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4NameOnFile	:= Map(Rep4InputNamePopulated = FALSE															=> '-1',
																							Rep4InputNamePopulated = TRUE AND TRIM(ri.fname) = '' AND TRIM(ri.lname) = ''					=> '0',
																							Rep4InputNamePopulated = TRUE AND Rep4AR2BFNameFile = '1' AND Rep4AR2BLNameFile = '0'	=> '1',
																							Rep4InputNamePopulated = TRUE AND Rep4AR2BLNameFile = '1' AND Rep4AR2BFNameFile = '0'	=> '2',
																							Rep4InputNamePopulated = TRUE AND Rep4AR2BFullFile = '1'															=> '3',
																																																																			 '0');
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5NameOnFile	:= Map(Rep5InputNamePopulated = FALSE															=> '-1',
																							Rep5InputNamePopulated = TRUE AND TRIM(ri.fname) = '' AND TRIM(ri.lname) = ''					=> '0',
																							Rep5InputNamePopulated = TRUE AND Rep5AR2BFNameFile = '1' AND Rep5AR2BLNameFile = '0'	=> '1',
																							Rep5InputNamePopulated = TRUE AND Rep5AR2BLNameFile = '1' AND Rep5AR2BFNameFile = '0'	=> '2',
																							Rep5InputNamePopulated = TRUE AND Rep5AR2BFullFile = '1'															=> '3',
																																																																			 '0');



		APPENDEDCONTACTSCORES := PROJECT(le.ContactDIDs, TRANSFORM(tempContactsScoresLayout,

						// Check Authorized Rep best data
		SELF.RecordCount := left.RecordCount;
		self.DID := left.DID;
		RepZIPScoreFile					:= IF(le.Clean_Input.Rep_Zip5 <> '' AND LEFT.Zip <> '' AND le.Clean_Input.Rep_Zip5[1] = LEFT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep_Zip5, LEFT.Zip), NoScoreValue);
		RepCityStateScoreFile		:= IF(le.Clean_Input.Rep_City <> '' AND le.Clean_Input.Rep_State <> '' AND LEFT.city_name <> '' AND LEFT.st <> '' AND le.Clean_Input.Rep_State[1] = LEFT.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep_City, le.Clean_Input.Rep_State, LEFT.city_name, LEFT.st, ''), NoScoreValue);
		SELF.RepAddressMatchedFile		:= Risk_Indicators.iid_constants.ga(IF(RepZIPScoreFile = NoScoreValue AND RepCityStateScoreFile = NoScoreValue,
																						NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep_Prim_Range, le.Clean_Input.Rep_Prim_Name, le.Clean_Input.Rep_Sec_Range,
																						LEFT.prim_range, LEFT.prim_name, LEFT.sec_range,
																						RepZIPScoreFile, RepCityStateScoreFile)));
		SELF.RepAddressNotPopulatedFile := TRIM(LEFT.Prim_Name) = '' OR TRIM(LEFT.City_Name) = '' OR TRIM(LEFT.St) = '' OR TRIM(LEFT.Zip) = '' OR
													 TRIM(le.Clean_Input.Rep_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep_City) = '' OR TRIM(le.Clean_Input.Rep_State) = '' OR TRIM(le.Clean_Input.Rep_Zip5) = '';
    RepPhonePopulatedFile			:= TRIM(le.Clean_Input.Rep_Phone10) <> '' AND TRIM(LEFT.Phone) <> '';
    SELF.RepPhonePopulatedFile			:= RepPhonePopulatedFile;
		SELF.RepPhoneMatchedFile				:= RepPhonePopulatedFile AND (le.Clean_Input.Rep_Phone10[1] = LEFT.Phone[1] OR le.Clean_Input.Rep_Phone10[4] = LEFT.Phone[4] OR le.Clean_Input.Rep_Phone10[4] = LEFT.Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep_Phone10, LEFT.Phone));

		//rep2
		Rep2ZIPScoreFile					:= IF(le.Clean_Input.Rep2_Zip5 <> '' AND LEFT.Zip <> '' AND le.Clean_Input.Rep2_Zip5[1] = LEFT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep2_Zip5, LEFT.Zip), NoScoreValue);
		Rep2CityStateScoreFile		:= IF(le.Clean_Input.Rep2_City <> '' AND le.Clean_Input.Rep2_State <> '' AND LEFT.city_name <> '' AND LEFT.st <> '' AND le.Clean_Input.Rep2_State[1] = LEFT.st[1],
																	Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep2_City, le.Clean_Input.Rep2_State, LEFT.city_name, LEFT.st, ''), NoScoreValue);
		SELF.Rep2AddressMatchedFile		:= Risk_Indicators.iid_constants.ga(IF(Rep2ZIPScoreFile = NoScoreValue AND Rep2CityStateScoreFile = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep2_Prim_Range, le.Clean_Input.Rep2_Prim_Name, le.Clean_Input.Rep2_Sec_Range,
																						LEFT.prim_range, LEFT.prim_name, LEFT.sec_range,
																						Rep2ZIPScoreFile, Rep2CityStateScoreFile)));
		SELF.Rep2AddressNotPopulatedFile := TRIM(LEFT.Prim_Name) = '' OR TRIM(LEFT.City_Name) = '' OR TRIM(LEFT.St) = '' OR TRIM(LEFT.Zip) = '' OR
													 TRIM(le.Clean_Input.Rep2_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep2_City) = '' OR TRIM(le.Clean_Input.Rep2_State) = '' OR TRIM(le.Clean_Input.Rep2_Zip5) = '';
    Rep2PhonePopulatedFile			:= TRIM(le.Clean_Input.Rep2_Phone10) <> '' AND TRIM(LEFT.Phone) <> '';
    SELF.Rep2PhonePopulatedFile			:= Rep2PhonePopulatedFile;
		SELF.Rep2PhoneMatchedFile				:= Rep2PhonePopulatedFile AND (le.Clean_Input.Rep2_Phone10[1] = LEFT.Phone[1] OR le.Clean_Input.Rep2_Phone10[4] = LEFT.Phone[4] OR le.Clean_Input.Rep2_Phone10[4] = LEFT.Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep2_Phone10, LEFT.Phone));
		//rep 3
		Rep3ZIPScoreFile					:= IF(le.Clean_Input.Rep3_Zip5 <> '' AND LEFT.Zip <> '' AND le.Clean_Input.Rep3_Zip5[1] = LEFT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep3_Zip5, LEFT.Zip), NoScoreValue);
	  Rep3CityStateScoreFile		:= IF(le.Clean_Input.Rep3_City <> '' AND le.Clean_Input.Rep3_State <> '' AND LEFT.City_Name <> '' AND LEFT.st <> '' AND le.Clean_Input.Rep3_State[1] = LEFT.st[1],
																	Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep3_City, le.Clean_Input.Rep3_State, LEFT.City_name, LEFT.st, ''), NoScoreValue);
		SELF.Rep3AddressMatchedFile		:= Risk_Indicators.iid_constants.ga(IF(Rep3ZIPScoreFile = NoScoreValue AND Rep3CityStateScoreFile = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep3_Prim_Range, le.Clean_Input.Rep3_Prim_Name, le.Clean_Input.Rep3_Sec_Range,
																						LEFT.prim_range, LEFT.prim_name, LEFT.sec_range,
																						Rep3ZIPScoreFile, Rep3CityStateScoreFile)));
		SELF.Rep3AddressNotPopulatedFile := TRIM(LEFT.Prim_Name) = '' OR TRIM(LEFT.City_Name) = '' OR TRIM(LEFT.St) = '' OR TRIM(LEFT.Zip) = '' OR
													 TRIM(le.Clean_Input.Rep3_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep3_City) = '' OR TRIM(le.Clean_Input.Rep3_State) = '' OR TRIM(le.Clean_Input.Rep3_Zip5) = '';

    Rep3PhonePopulatedFile			:= TRIM(le.Clean_Input.Rep3_Phone10) <> '' AND TRIM(LEFT.Phone) <> '';
    SELF.Rep3PhonePopulatedFile			:= Rep3PhonePopulatedFile;
		SELF.Rep3PhoneMatchedFile				:= Rep3PhonePopulatedFile AND (le.Clean_Input.Rep3_Phone10[1] = LEFT.Phone[1] OR le.Clean_Input.Rep3_Phone10[4] = LEFT.Phone[4] OR le.Clean_Input.Rep3_Phone10[4] = LEFT.Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep3_Phone10, LEFT.Phone));
		//rep4
		Rep4ZIPScoreFile					:= IF(le.Clean_Input.Rep4_Zip5 <> '' AND LEFT.Zip <> '' AND le.Clean_Input.Rep4_Zip5[1] = LEFT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep4_Zip5, LEFT.Zip), NoScoreValue);
		Rep4CityStateScoreFile		:= IF(le.Clean_Input.Rep4_City <> '' AND le.Clean_Input.Rep4_State <> '' AND LEFT.city_name <> '' AND LEFT.st <> '' AND le.Clean_Input.Rep4_State[1] = LEFT.st[1],
																	Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep4_City, le.Clean_Input.Rep4_State, LEFT.city_name, LEFT.st, ''), NoScoreValue);
		SELF.Rep4AddressMatchedFile		:= Risk_Indicators.iid_constants.ga(IF(Rep4ZIPScoreFile = NoScoreValue AND Rep4CityStateScoreFile = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep4_Prim_Range, le.Clean_Input.Rep4_Prim_Name, le.Clean_Input.Rep4_Sec_Range,
																						LEFT.prim_range, LEFT.prim_name, LEFT.sec_range,
																						Rep4ZIPScoreFile, Rep4CityStateScoreFile)));
		SELF.Rep4AddressNotPopulatedFile := TRIM(LEFT.Prim_Name) = '' OR TRIM(LEFT.City_Name) = '' OR TRIM(LEFT.St) = '' OR TRIM(LEFT.Zip) = '' OR
													 TRIM(le.Clean_Input.Rep4_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep4_City) = '' OR TRIM(le.Clean_Input.Rep4_State) = '' OR TRIM(le.Clean_Input.Rep4_Zip5) = '';
    Rep4PhonePopulatedFile			:= TRIM(le.Clean_Input.Rep4_Phone10) <> '' AND TRIM(LEFT.Phone) <> '';
    SELF.Rep4PhonePopulatedFile			:= Rep4PhonePopulatedFile;
		SELF.Rep4PhoneMatchedFile				:= Rep4PhonePopulatedFile AND (le.Clean_Input.Rep4_Phone10[1] = LEFT.Phone[1] OR le.Clean_Input.Rep4_Phone10[4] = LEFT.Phone[4] OR le.Clean_Input.Rep4_Phone10[4] = LEFT.Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep4_Phone10, LEFT.Phone));
		//rep 5
		Rep5ZIPScoreFile					:= IF(le.Clean_Input.Rep5_Zip5 <> '' AND LEFT.Zip <> '' AND le.Clean_Input.Rep5_Zip5[1] = LEFT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep5_Zip5, LEFT.Zip), NoScoreValue);
	  Rep5CityStateScoreFile		:= IF(le.Clean_Input.Rep5_City <> '' AND le.Clean_Input.Rep5_State <> '' AND LEFT.City_Name <> '' AND LEFT.st <> '' AND le.Clean_Input.Rep5_State[1] = LEFT.st[1],
																	Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep5_City, le.Clean_Input.Rep5_State, LEFT.City_name, LEFT.st, ''), NoScoreValue);
		SELF.Rep5AddressMatchedFile		:= Risk_Indicators.iid_constants.ga(IF(Rep5ZIPScoreFile = NoScoreValue AND Rep5CityStateScoreFile = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep5_Prim_Range, le.Clean_Input.Rep5_Prim_Name, le.Clean_Input.Rep5_Sec_Range,
																						LEFT.prim_range, LEFT.prim_name, LEFT.sec_range,
																						Rep5ZIPScoreFile, Rep5CityStateScoreFile)));
		SELF.Rep5AddressNotPopulatedFile := TRIM(LEFT.Prim_Name) = '' OR TRIM(LEFT.City_Name) = '' OR TRIM(LEFT.St) = '' OR TRIM(LEFT.Zip) = '' OR
													 TRIM(le.Clean_Input.Rep5_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep5_City) = '' OR TRIM(le.Clean_Input.Rep5_State) = '' OR TRIM(le.Clean_Input.Rep5_Zip5) = '';

    Rep5PhonePopulatedFile			:= TRIM(le.Clean_Input.Rep5_Phone10) <> '' AND TRIM(LEFT.Phone) <> '';
    SELF.Rep5PhonePopulatedFile			:= Rep5PhonePopulatedFile;
		SELF.Rep5PhoneMatchedFile				:= Rep5PhonePopulatedFile AND (le.Clean_Input.Rep5_Phone10[1] = LEFT.Phone[1] OR le.Clean_Input.Rep5_Phone10[4] = LEFT.Phone[4] OR le.Clean_Input.Rep5_Phone10[4] = LEFT.Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Rep5_Phone10, LEFT.Phone));


		SELF.RepSSNPopulatedFile					:= (INTEGER)le.Clean_Input.rep_ssn > 0 and (INTEGER)left.ssn > 0;
		SELF.Rep2SSNPopulatedFile					:= (INTEGER)le.Clean_Input.rep2_ssn > 0 and (INTEGER)left.ssn > 0;
		SELF.Rep3SSNPopulatedFile					:= (INTEGER)le.Clean_Input.rep3_ssn > 0 and (INTEGER)left.ssn > 0;
		SELF.Rep4SSNPopulatedFile					:= (INTEGER)le.Clean_Input.rep4_ssn > 0 and (INTEGER)left.ssn > 0;
		SELF.Rep5SSNPopulatedFile					:= (INTEGER)le.Clean_Input.rep5_ssn > 0 and (INTEGER)left.ssn > 0;

		SELF.RepSSNFeinPopulatedFile			:= (INTEGER)left.ssn > 0 and (INTEGER)ri.Company_FEIN > 0;
		SELF.Rep2SSNFeinPopulatedFile			:= (INTEGER)left.ssn > 0 and (INTEGER)ri.Company_FEIN > 0;
		SELF.Rep3SSNFeinPopulatedFile			:= (INTEGER)left.ssn > 0 and (INTEGER)ri.Company_FEIN > 0;
	  SELF.Rep4SSNFeinPopulatedFile			:= (INTEGER)left.ssn > 0 and (INTEGER)ri.Company_FEIN > 0;
		SELF.Rep5SSNFeinPopulatedFile			:= (INTEGER)left.ssn > 0 and (INTEGER)ri.Company_FEIN > 0;

		// Require that the first digit match in order to "short-circuit" the fuzzy match logic. In order to do this properly see if only 4 SSN digits were entered and adjust accordingly.
		SELF.RepSSNMatchedFile				:= MAP(le.Clean_Input.Rep_SSN = ''																			=> FALSE,
																				le.Clean_Input.Rep_SSN[1] = LEFT.ssn[IF(RepSSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep_SSN, LEFT.ssn, RepSSNLength=4)),
																																																						FALSE);
		SELF.Rep2SSNMatchedFile			:= MAP(le.Clean_Input.Rep2_SSN = ''																			=> FALSE,
																				le.Clean_Input.Rep2_SSN[1] = LEFT.ssn[IF(Rep2SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep2_SSN, LEFT.ssn, Rep2SSNLength=4)),
																																																						FALSE);
		SELF.Rep3SSNMatchedFile			:= MAP(le.Clean_Input.Rep3_SSN = ''																			=> FALSE,
																				le.Clean_Input.Rep3_SSN[1] = LEFT.ssn[IF(Rep3SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep3_SSN, LEFT.ssn, Rep3SSNLength=4)),
																																																						FALSE);

		SELF.Rep4SSNMatchedFile			:= MAP(le.Clean_Input.Rep4_SSN = ''																			=> FALSE,
																				le.Clean_Input.Rep4_SSN[1] = LEFT.ssn[IF(Rep4SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep4_SSN, LEFT.ssn, Rep4SSNLength=4)),
																																																						FALSE);
		SELF.Rep5SSNMatchedFile			:= MAP(le.Clean_Input.Rep5_SSN = ''																			=> FALSE,
																				le.Clean_Input.Rep5_SSN[1] = LEFT.ssn[IF(Rep5SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep5_SSN, LEFT.ssn, Rep5SSNLength=4)),
																																																						FALSE);

		SELF.RepSSNMatchedFeinFile		:= MAP(le.Clean_Input.Rep_SSN = ''																			=> FALSE,
																				le.Clean_Input.Rep_SSN[1] = ri.Company_FEIN[IF(RepSSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep_SSN, ri.Company_FEIN, RepSSNLength=4)),
																																																						FALSE);
		SELF.Rep2SSNMatchedFeinFile		:= MAP(le.Clean_Input.Rep2_SSN = ''																			=> FALSE,
																				le.Clean_Input.Rep2_SSN[1] = ri.Company_FEIN[IF(Rep2SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep2_SSN, ri.Company_FEIN, Rep2SSNLength=4)),
																																																						FALSE);
		SELF.Rep3SSNMatchedFeinFile		:= MAP(le.Clean_Input.Rep3_SSN = ''																			=> FALSE,
																				le.Clean_Input.Rep3_SSN[1] = ri.Company_FEIN[IF(Rep3SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep3_SSN, ri.Company_FEIN, Rep3SSNLength=4)),
																																																						FALSE);
		SELF.Rep4SSNMatchedFeinFile		:= MAP(le.Clean_Input.Rep4_SSN = ''																			=> FALSE,
																				le.Clean_Input.Rep4_SSN[1] = ri.Company_FEIN[IF(Rep4SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep4_SSN, ri.Company_FEIN, Rep4SSNLength=4)),
																																																						FALSE);
		SELF.Rep5SSNMatchedFeinFile		:= MAP(le.Clean_Input.Rep5_SSN = ''																			=> FALSE,
																				le.Clean_Input.Rep5_SSN[1] = ri.Company_FEIN[IF(Rep5SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep5_SSN, ri.Company_FEIN, Rep5SSNLength=4)),
																																																						FALSE);


		SELF := LEFT;

		SELF := [];
		));


		// Check Authorized Rep versus on file data

		RepZIPScore					:= IF(le.Clean_Input.Rep_Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Rep_Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep_Zip5, ri.Zip), NoScoreValue);
		RepCityStateScore		:= IF(le.Clean_Input.Rep_City <> '' AND le.Clean_Input.Rep_State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND le.Clean_Input.Rep_State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep_City, le.Clean_Input.Rep_State, ri.p_city_name, ri.st, ''), NoScoreValue);
		RepCityStateZipMatched := Risk_Indicators.iid_constants.ga(RepZIPScore) AND Risk_Indicators.iid_constants.ga(RepCityStateScore);
		RepAddressMatched		:= Risk_Indicators.iid_constants.ga(IF(RepZIPScore = NoScoreValue AND RepCityStateScore = NoScoreValue, NoScoreValue,
																					Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep_Prim_Range, le.Clean_Input.Rep_Prim_Name, le.Clean_Input.Rep_Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						RepZIPScore, RepCityStateScore)));
		RepInputAddressNotPopulated := TRIM(le.Clean_Input.Rep_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep_City) = '' OR TRIM(le.Clean_Input.Rep_State) = '' OR TRIM(le.Clean_Input.Rep_Zip5) = '';
		RepAddressNotPopulated := TRIM(ri.Prim_Name) = '' OR TRIM(ri.P_City_Name) = '' OR TRIM(ri.St) = '' OR TRIM(ri.Zip) = '' OR RepInputAddressNotPopulated;
		//rep2
    Rep2ZIPScore					:= IF(le.Clean_Input.Rep2_Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Rep2_Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep2_Zip5, ri.Zip), NoScoreValue);
		Rep2CityStateScore		:= IF(le.Clean_Input.Rep2_City <> '' AND le.Clean_Input.Rep2_State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND le.Clean_Input.Rep2_State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep2_City, le.Clean_Input.Rep2_State, ri.p_city_name, ri.st, ''), NoScoreValue);
		Rep2CityStateZipMatched := Risk_Indicators.iid_constants.ga(Rep2ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep2CityStateScore);
		Rep2AddressMatched		:= Risk_Indicators.iid_constants.ga(IF(Rep2ZIPScore = NoScoreValue AND Rep2CityStateScore = NoScoreValue, NoScoreValue,
																					Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep2_Prim_Range, le.Clean_Input.Rep2_Prim_Name, le.Clean_Input.Rep2_Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						Rep2ZIPScore, Rep2CityStateScore)));
		Rep2InputAddressNotPopulated := TRIM(le.Clean_Input.Rep2_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep2_City) = '' OR TRIM(le.Clean_Input.Rep2_State) = '' OR TRIM(le.Clean_Input.Rep2_Zip5) = '';
		Rep2AddressNotPopulated := TRIM(ri.Prim_Name) = '' OR TRIM(ri.p_city_name) = '' OR TRIM(ri.St) = '' OR TRIM(ri.Zip) = '' OR Rep2InputAddressNotPopulated;

	  //rep 3
		Rep3ZIPScore					:= IF(le.Clean_Input.Rep3_Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Rep3_Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep3_Zip5, ri.Zip), NoScoreValue);
		Rep3CityStateScore		:= IF(le.Clean_Input.Rep3_City <> '' AND le.Clean_Input.Rep3_State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND le.Clean_Input.Rep3_State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep3_City, le.Clean_Input.Rep3_State, ri.p_city_name, ri.st, ''), NoScoreValue);
		Rep3CityStateZipMatched := Risk_Indicators.iid_constants.ga(Rep3ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep3CityStateScore);
		Rep3AddressMatched		:= Risk_Indicators.iid_constants.ga(IF(Rep3ZIPScore = NoScoreValue AND Rep3CityStateScore = NoScoreValue, NoScoreValue,
																					Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep3_Prim_Range, le.Clean_Input.Rep3_Prim_Name, le.Clean_Input.Rep3_Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						Rep3ZIPScore, Rep3CityStateScore)));
		Rep3InputAddressNotPopulated := TRIM(le.Clean_Input.Rep3_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep3_City) = '' OR TRIM(le.Clean_Input.Rep3_State) = '' OR TRIM(le.Clean_Input.Rep3_Zip5) = '';
		Rep3AddressNotPopulated := TRIM(ri.Prim_Name) = '' OR TRIM(ri.p_city_name) = '' OR TRIM(ri.St) = '' OR TRIM(ri.Zip) = '' OR Rep3InputAddressNotPopulated;

		//rep 4
    Rep4ZIPScore					:= IF(le.Clean_Input.Rep4_Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Rep4_Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep4_Zip5, ri.Zip), NoScoreValue);
		Rep4CityStateScore		:= IF(le.Clean_Input.Rep4_City <> '' AND le.Clean_Input.Rep4_State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND le.Clean_Input.Rep4_State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep4_City, le.Clean_Input.Rep4_State, ri.p_city_name, ri.st, ''), NoScoreValue);
		Rep4CityStateZipMatched := Risk_Indicators.iid_constants.ga(Rep4ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep4CityStateScore);
		Rep4AddressMatched		:= Risk_Indicators.iid_constants.ga(IF(Rep4ZIPScore = NoScoreValue AND Rep4CityStateScore = NoScoreValue, NoScoreValue,
																					Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep4_Prim_Range, le.Clean_Input.Rep4_Prim_Name, le.Clean_Input.Rep4_Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						Rep4ZIPScore, Rep4CityStateScore)));
		Rep4InputAddressNotPopulated := TRIM(le.Clean_Input.Rep4_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep4_City) = '' OR TRIM(le.Clean_Input.Rep4_State) = '' OR TRIM(le.Clean_Input.Rep4_Zip5) = '';
		Rep4AddressNotPopulated := TRIM(ri.Prim_Name) = '' OR TRIM(ri.p_city_name) = '' OR TRIM(ri.St) = '' OR TRIM(ri.Zip) = '' OR Rep4InputAddressNotPopulated;

	  //rep 5
		Rep5ZIPScore					:= IF(le.Clean_Input.Rep5_Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Rep5_Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Rep5_Zip5, ri.Zip), NoScoreValue);
		Rep5CityStateScore		:= IF(le.Clean_Input.Rep5_City <> '' AND le.Clean_Input.Rep5_State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND le.Clean_Input.Rep5_State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.Rep5_City, le.Clean_Input.Rep5_State, ri.p_city_name, ri.st, ''), NoScoreValue);
		Rep5CityStateZipMatched := Risk_Indicators.iid_constants.ga(Rep5ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep5CityStateScore);
		Rep5AddressMatched		:= Risk_Indicators.iid_constants.ga(IF(Rep5ZIPScore = NoScoreValue AND Rep5CityStateScore = NoScoreValue, NoScoreValue,
																					Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Rep5_Prim_Range, le.Clean_Input.Rep5_Prim_Name, le.Clean_Input.Rep5_Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						Rep5ZIPScore, Rep5CityStateScore)));
		Rep5InputAddressNotPopulated := TRIM(le.Clean_Input.Rep5_Prim_Name) = '' OR TRIM(le.Clean_Input.Rep5_City) = '' OR TRIM(le.Clean_Input.Rep5_State) = '' OR TRIM(le.Clean_Input.Rep5_Zip5) = '';
		Rep5AddressNotPopulated := TRIM(ri.Prim_Name) = '' OR TRIM(ri.p_city_name) = '' OR TRIM(ri.St) = '' OR TRIM(ri.Zip) = '' OR Rep5InputAddressNotPopulated;

		PhonePopulated			:= (INTEGER)le.Clean_Input.Phone10 > 0 AND (INTEGER)ri.Company_Phone > 0;
		PhoneScore 					:= IF(PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.Company_Phone[1] OR le.Clean_Input.Phone10[4] = ri.Company_Phone[4] OR le.Clean_Input.Phone10[4] = ri.Company_Phone[1]), Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.Company_Phone), NoScoreValue);
		PhoneMatched				:= Risk_Indicators.iid_constants.gn(PhoneScore);


		RepPhoneMatched			:= RepInputPhonePopulated AND (le.Clean_Input.Rep_Phone10[1] = ri.Company_Phone[1] OR le.Clean_Input.Rep_Phone10[4] = ri.Company_Phone[4] OR le.Clean_Input.Rep_Phone10[4] = ri.Company_Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(ri.Company_Phone, le.Clean_Input.Rep_Phone10));
		Rep2PhoneMatched			:= Rep2InputPhonePopulated AND (le.Clean_Input.Rep2_Phone10[1] = ri.Company_Phone[1] OR le.Clean_Input.Rep2_Phone10[4] = ri.Company_Phone[4] OR le.Clean_Input.Rep2_Phone10[4] = ri.Company_Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(ri.Company_Phone, le.Clean_Input.Rep2_Phone10));
		Rep3PhoneMatched			:= Rep3InputPhonePopulated AND (le.Clean_Input.Rep3_Phone10[1] = ri.Company_Phone[1] OR le.Clean_Input.Rep3_Phone10[4] = ri.Company_Phone[4] OR le.Clean_Input.Rep3_Phone10[4] = ri.Company_Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(ri.Company_Phone, le.Clean_Input.Rep3_Phone10));
    Rep4PhoneMatched			:= Rep4InputPhonePopulated AND (le.Clean_Input.Rep4_Phone10[1] = ri.Company_Phone[1] OR le.Clean_Input.Rep4_Phone10[4] = ri.Company_Phone[4] OR le.Clean_Input.Rep4_Phone10[4] = ri.Company_Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(ri.Company_Phone, le.Clean_Input.Rep4_Phone10));
		Rep5PhoneMatched			:= Rep5InputPhonePopulated AND (le.Clean_Input.Rep5_Phone10[1] = ri.Company_Phone[1] OR le.Clean_Input.Rep5_Phone10[4] = ri.Company_Phone[4] OR le.Clean_Input.Rep5_Phone10[4] = ri.Company_Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(ri.Company_Phone, le.Clean_Input.Rep5_Phone10));

		FEINPopulated				:= (INTEGER)le.Clean_Input.FEIN > 0 AND (INTEGER)ri.Company_FEIN > 0;
		FEINLength := LENGTH(TRIM(le.Clean_Input.FEIN));
		RepFEINLength := LENGTH(TRIM(le.Clean_Input.Rep_SSN));
		Rep2FEINLength := LENGTH(TRIM(le.Clean_Input.Rep2_SSN));
		Rep3FEINLength := LENGTH(TRIM(le.Clean_Input.Rep3_SSN));
		Rep4FEINLength := LENGTH(TRIM(le.Clean_Input.Rep4_SSN));
		Rep5FEINLength := LENGTH(TRIM(le.Clean_Input.Rep5_SSN));

		FEINScore := IF(le.Clean_Input.FEIN = '' OR le.Clean_Input.FEIN[1] <> ri.Company_FEIN[IF(FEINLength = 4, 6, 1)], NoScoreValue, DID_Add.SSN_Match_Score(le.Clean_Input.FEIN, ri.Company_FEIN, FEINLength=4));
		FEINMatched					:= Risk_Indicators.iid_constants.gn(FEINScore);

		SELF.Verification.FEINInputMiskey := MAP((INTEGER)le.Clean_Input.FEIN = 0 => '-1',
																							FEINMatched AND FEINScore < 100 => '1',
																																								 '0');

		FEINMatchedRepSSN		:= MAP(le.Clean_Input.Rep_SSN = ''																							=> FALSE,
															le.Clean_Input.Rep_SSN[1] = ri.Company_FEIN[IF(RepFEINLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep_SSN, ri.Company_FEIN, RepFEINLength=4)),
																																																					FALSE);
		FEINMatchedRep2SSN	:= MAP(le.Clean_Input.Rep2_SSN = ''																							=> FALSE,
															le.Clean_Input.Rep2_SSN[1] = ri.Company_FEIN[IF(Rep2FEINLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep2_SSN, ri.Company_FEIN, Rep2FEINLength=4)),
																																																					FALSE);
		FEINMatchedRep3SSN	:= MAP(le.Clean_Input.Rep3_SSN = ''																							=> FALSE,
															le.Clean_Input.Rep3_SSN[1] = ri.Company_FEIN[IF(Rep3FEINLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep3_SSN, ri.Company_FEIN, Rep3FEINLength=4)),
																																																					FALSE);
		FEINMatchedRep4SSN	:= MAP(le.Clean_Input.Rep4_SSN = ''																							=> FALSE,
															le.Clean_Input.Rep4_SSN[1] = ri.Company_FEIN[IF(Rep4FEINLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep4_SSN, ri.Company_FEIN, Rep4FEINLength=4)),
																																																					FALSE);
		FEINMatchedRep5SSN	:= MAP(le.Clean_Input.Rep5_SSN = ''																							=> FALSE,
															le.Clean_Input.Rep5_SSN[1] = ri.Company_FEIN[IF(Rep5FEINLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.Rep5_SSN, ri.Company_FEIN, Rep5FEINLength=4)),
																																																					FALSE);


		SELF.Verification.NameMatch := Business_Risk_BIP.Common.SetBoolean(NameMatched);

		SELF.Verification.VerNameMiskey := MAP(NOT NamePopulated => '-1',
																					 NameMatched AND NameMatchScore < 99 => '1',
																																									'0');


		SELF.Verification.VerInputNameAlternative := MAP(TRIM(le.Clean_Input.CompanyName) = '' => '-1', // Company name not input
																										 NamePopulated AND NameMatched 				 => '0',  // Input company name matches file
																										 NamePopulated AND NOT NameMatched 		 => '1',  // input compant name mismatches file
																																															'0'); // No alternate name found

		SELF.Verification.VerInputNameDBA := MAP(NOT DBANamePopulated => '-1',
																						 DBANamePopulated AND DBANameMatched => '1',
																																										'0');

		AddressMatchLevel := MAP(AddressPopulated = FALSE															=> '-1', // Address Not Input
														TRIM(ri.Prim_Name) = '' OR (INTEGER)ri.zip <= 0				=> '0', // Address Not Found
														CityStateZipMatched = TRUE AND AddressMatched = FALSE	=> '1', // City/State/Zip Match
														AddressMatched = TRUE																	=> '2', // Street/City/State/Zip Match
																																										 '0'); // Not verified
		SELF.Verification.AddrVerification := AddressMatchLevel;
		SELF.Verification.PhoneMatch := Business_Risk_BIP.Common.SetBoolean(PhoneMatched);
		SELF.Verification.PhoneInputMiskey := MAP((INTEGER)le.Clean_Input.Phone10 = 0 => '-1',
																							 PhoneMatched AND PhoneScore < 100  => '1',
																																										 '0');
		VerificationBusInputPhoneAddrLevel := MAP(PhonePopulated = FALSE																									=> '-2', // Phone Not Input - this will be blanked out later, just need a low integer so MAX works in the rollup
																	(INTEGER)ri.Company_Phone = 0 OR NamePopulated = FALSE OR AddressPopulated = FALSE	=> '-1', // No phone records found, checking (INTEGER)RIGHT.Phone = 0 catches if the join resulted in no hits
																	AddressMatched = TRUE AND NameMatched = FALSE AND PhoneMatched = FALSE							=> '0', // Business and Phone not verified at Address
																	AddressMatched = TRUE AND NameMatched = TRUE AND PhoneMatched = FALSE								=> '1', // Phone not verified at Address
																	AddressMatched = TRUE AND NameMatched = TRUE AND PhoneMatched = TRUE								=> '2', // Business and Phone verified at Address
																																																												 '-1'); // No phone records found
		SELF.Verification.VerificationBusInputPhoneAddr := VerificationBusInputPhoneAddrLevel; // This calculation will also happen in Business_Risk_BIP.getGong, take the max of both in Business_Shell_Function

		PhoneNameMatchLevel := MAP((INTEGER)le.Clean_Input.Phone10 = 0                                                                                 => '-1', //Phone not input
                                  Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND
                                  (TRIM(le.Clean_Input.CompanyName) = '' OR TRIM(le.Clean_Input.Prim_Name) = '' OR TRIM(le.Clean_Input.Zip5) = '') => '-1', //In version 3.0 and up, need name and address input to calculate
																	NOT PhonePopulated AND (INTEGER)le.Clean_Input.Phone10 > 0                                                       => '0' ,	//Phone not found on business header
																	PhoneMatched = TRUE AND NameMatched = FALSE AND AddressMatched = FALSE                                           => '1',
																	PhoneMatched = TRUE AND NameMatched = TRUE AND AddressMatched = FALSE                                            => '2',
																	PhoneMatched = TRUE AND NameMatched = FALSE AND AddressMatched = TRUE                                            => '3',
																	PhoneMatched = TRUE AND NameMatched = TRUE AND AddressMatched = TRUE                                             => '4',
                                                                                                                                                      '0');

		SELF.Verification.PhoneNameMismatch := PhoneNameMatchLevel; //Also in Business_Risk_BIP.getEDA we will reassign values in Business_Shell_Function

		FEINMatchLevel := MAP((INTEGER)le.Clean_Input.FEIN <= 0	OR FEINPopulated = FALSE													=> '-1', // FEIN Not Input
													FEINMatched = TRUE AND NameMatched = FALSE AND AddressMatched = FALSE								=> '1', // FEIN linked to a different company name AND address
													FEINMatched = TRUE AND (NameMatched = FALSE OR AddressMatched = FALSE)							=> '2', // FEIN linked to a different company name OR address
													FEINMatched = TRUE AND NameMatched AND AddressMatched																=> (STRING)MaxFEINVer, // FEIN verified
																																																								 '-1'); // Not verified
		SELF.Verification.FEINVerification := FEINMatchLevel;

		SELF.Verification.BNAT := calcBNAT(FEINMatched, FEINPopulated, NameMatched, AddressMatched, StateMatched);

		// The BNAP's where PhoneMatched = TRUE will also be calculated using Phones Plus data in Business_Risk_BIP.getOtherSources and using Gong in Business_Risk_BIP.getEDA to help boost verification
		SELF.Verification.BNAP := Business_Risk_BIP.Common.calcBNAP_wide(PhoneMatched, PhonePopulated, NameMatched, AddressMatched, StateMatched);
		// For BNAP2/BNAT2 we want to rollup the various match elements across all header records to catch situations where FEIN verified on one record, but wasn't populated on the header record that Address verified.
		SELF.FEINMatched := FEINMatched;
		SELF.FEINPopulated := FEINPopulated;
		SELF.NameMatched := NameMatched;
		SELF.AddressMatched := AddressMatched;
		SELF.StateMatched := StateMatched;
		SELF.PhoneMatched := PhoneMatched;
		SELF.PhonePopulated := PhonePopulated;
		SELF.Address_History := DATASET([{AddressMatched,
																			Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_first_Seen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6],
																			Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6]}],
																	 {BOOLEAN InputAddress, STRING8 DateFirstSeen, STRING8 DateLastSeen});
		SELF.Address_Phone_History := DATASET([{ri.Company_Phone,
																					 ri.prim_range,
																					 ri.prim_name,
																					 ri.sec_range,
																					 ri.Zip,
																					 ri.st,
																					 ri.p_city_name,
																					 ri.geo_lat,
																					 ri.geo_long,
																					 Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_first_Seen, Business_Risk_BIP.Constants.NinesDate, le.Clean_Input.HistoryDate)[1..6],
																					 Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6]}],
																	  {STRING10 Company_Phone, STRING10 Prim_Range, STRING28 Prim_Name, STRING8 Sec_Range, STRING5 Zip, STRING2 St, STRING25 P_City_Name, STRING10 Geo_Lat, STRING11 Geo_Long, STRING8 DateFirstSeen, STRING8 DateLastSeen});
		SELF.NameSources := IF(NameMatched, DATASET([{ri.Source,
																					Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_first_Seen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6],
																					Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_vendor_first_reported, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6],
																					Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6],
																					Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_vendor_last_reported, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6],
																					1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		DateFirstSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_first_Seen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateVendorFirstSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_vendor_first_reported, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateLastSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateVendorLastSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_vendor_last_reported, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		SELF.AddressVerSources := IF((INTEGER)AddressMatchLevel >= 2, DATASET([{ri.Source, // Only keep sources that fully verified
																																DateFirstSeen,
																																DateVendorFirstSeen,
																																DateLastSeen,
																																DateVendorLastSeen,
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.AddressSources := IF((INTEGER)AddressMatchLevel > 0, DATASET([{ri.Source, // Keep all sources that matched on some part of the address
																																DateFirstSeen,
																																DateVendorFirstSeen,
																																DateLastSeen,
																																DateVendorLastSeen,
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));

		SELF.BestAddressSources := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND BestAddressMatched,
																															DATASET([{ri.Source,
																																DateFirstSeen,
																																DateVendorFirstSeen,
																																DateLastSeen,
																																DateVendorLastSeen,
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.PhoneSources := IF(PhoneMatched, DATASET([{ri.Source,
																																DateFirstSeen,
																															  DateVendorFirstSeen,
																																DateLastSeen,
																																DateVendorLastSeen,
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.FEINSources := IF(FEINMatched, DATASET([{ri.Source,
																																DateFirstSeen,
																																DateVendorFirstSeen,
																																DateLastSeen,
																																DateVendorLastSeen,
																																1}], Business_Risk_BIP.Layouts.LayoutSources), DATASET([], Business_Risk_BIP.Layouts.LayoutSources));

		SELF.BestAddrPhones := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND BestAddressMatched AND (INTEGER)ri.Company_Phone > 0,
																															DATASET([{ri.Company_Phone}], Business_Risk_BIP.Layouts.LayoutBestAddrPhones), DATASET([], Business_Risk_BIP.Layouts.LayoutBestAddrPhones));

		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst := IF(TRIM(le.Clean_Input.Rep_FirstName) = '', '-1', BusNameAuthRepFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstFile := IF(TRIM(le.Clean_Input.Rep_FirstName) = '', '-1', BusNameAuthRepPreferredFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast := IF(TRIM(le.Clean_Input.Rep_LastName) = '', '-1', BusNameAuthRepLast);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFull := IF(TRIM(le.Clean_Input.Rep_FirstName) = '' OR TRIM(le.Clean_Input.Rep_LastName) = '', '-1', BusNameAuthRepFull);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone := IF(TRIM(le.Clean_Input.Rep_Phone10) = '', '-1', Business_Risk_BIP.Common.SetBoolean(RepPhoneMatched));
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr := IF(RepInputAddressNotPopulated, '-1', Business_Risk_BIP.Common.SetBoolean(RepAddressMatched));
		//rep 2
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First := IF(TRIM(le.Clean_Input.Rep2_FirstName) = '', '-1', BusNameAuthRep2First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstFile := IF(TRIM(le.Clean_Input.Rep2_FirstName) = '', '-1', BusNameAuthRep2PreferredFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last := IF(TRIM(le.Clean_Input.Rep2_LastName) = '', '-1', BusNameAuthRep2Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full := IF(TRIM(le.Clean_Input.Rep2_FirstName) = '' OR TRIM(le.Clean_Input.Rep2_LastName) = '', '-1', BusNameAuthRep2Full);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone := IF(TRIM(le.Clean_Input.Rep2_Phone10) = '', '-1', Business_Risk_BIP.Common.SetBoolean(Rep2PhoneMatched));
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr := IF(Rep2InputAddressNotPopulated, '-1', Business_Risk_BIP.Common.SetBoolean(Rep2AddressMatched));
    //rep3
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3First := IF(TRIM(le.Clean_Input.Rep3_FirstName) = '', '-1', BusNameAuthRep3First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstFile := IF(TRIM(le.Clean_Input.Rep3_FirstName) = '', '-1', BusNameAuthRep3PreferredFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Last := IF(TRIM(le.Clean_Input.Rep3_LastName) = '', '-1', BusNameAuthRep3Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Full := IF(TRIM(le.Clean_Input.Rep3_FirstName) = '' OR TRIM(le.Clean_Input.Rep3_LastName) = '', '-1', BusNameAuthRep3Full);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneBusPhone := IF(TRIM(le.Clean_Input.Rep3_Phone10) = '', '-1', Business_Risk_BIP.Common.SetBoolean(Rep3PhoneMatched));
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddr := IF(Rep3InputAddressNotPopulated, '-1', Business_Risk_BIP.Common.SetBoolean(Rep3AddressMatched));
    //rep 4
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4First := IF(TRIM(le.Clean_Input.Rep4_FirstName) = '', '-1', BusNameAuthRep4First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstFile := IF(TRIM(le.Clean_Input.Rep4_FirstName) = '', '-1', BusNameAuthRep4PreferredFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Last := IF(TRIM(le.Clean_Input.Rep4_LastName) = '', '-1', BusNameAuthRep4Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Full := IF(TRIM(le.Clean_Input.Rep4_FirstName) = '' OR TRIM(le.Clean_Input.Rep4_LastName) = '', '-1', BusNameAuthRep4Full);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneBusPhone := IF(TRIM(le.Clean_Input.Rep4_Phone10) = '', '-1', Business_Risk_BIP.Common.SetBoolean(Rep4PhoneMatched));
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddr := IF(Rep4InputAddressNotPopulated, '-1', Business_Risk_BIP.Common.SetBoolean(Rep4AddressMatched));
		//rep 5
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5First := IF(TRIM(le.Clean_Input.Rep5_FirstName) = '', '-1', BusNameAuthRep5First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstFile := IF(TRIM(le.Clean_Input.Rep5_FirstName) = '', '-1', BusNameAuthRep5PreferredFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Last := IF(TRIM(le.Clean_Input.Rep5_LastName) = '', '-1', BusNameAuthRep5Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Full := IF(TRIM(le.Clean_Input.Rep5_FirstName) = '' OR TRIM(le.Clean_Input.Rep5_LastName) = '', '-1', BusNameAuthRep5Full);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneBusPhone := IF(TRIM(le.Clean_Input.Rep5_Phone10) = '', '-1', Business_Risk_BIP.Common.SetBoolean(Rep5PhoneMatched));
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddr := IF(Rep5InputAddressNotPopulated, '-1', Business_Risk_BIP.Common.SetBoolean(Rep5AddressMatched));

		//contacts id child dataset
		self.Business_To_Executive_Link.BusExecLinkAuthRepAddrOnFile :=   MAP(RepInputAddressNotPopulated = TRUE 																	=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and ri.contact_did = 0 														=> '1',
																							COUNT(appendedContactScores (RepAddressMatchedFile = TRUE)) = 0  and ri.contact_did <> 0 				=> '2',
																							COUNT(appendedContactScores (RepAddressMatchedFile = TRUE)) > 0 and ri.contact_did <> 0 				=> '3',
																																																																								 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep2AddrOnFile := MAP(Rep2InputAddressNotPopulated = TRUE																	=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and ri.contact_did = 0 														=> '1',
																							COUNT(appendedContactScores (Rep2AddressMatchedFile = TRUE)) = 0  and ri.contact_did <> 0 			=> '2',
																							COUNT(appendedContactScores (Rep2AddressMatchedFile = TRUE)) > 0 	and ri.contact_did <> 0				=> '3',
																																																																								 '0');

		self.Business_To_Executive_Link.BusExecLinkAuthRep3AddrOnFile := MAP(Rep3InputAddressNotPopulated = TRUE																	=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (Rep3AddressMatchedFile = TRUE)) = 0  and ri.contact_did <> 0 			=> '2',
																							COUNT(appendedContactScores (Rep3AddressMatchedFile = TRUE)) > 0 	and ri.contact_did <> 0				=> '3',
																							                                                                                                   '0');

		self.Business_To_Executive_Link.BusExecLinkAuthRep4AddrOnFile := MAP(Rep4InputAddressNotPopulated = TRUE																	=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and ri.contact_did = 0 														=> '1',
																							COUNT(appendedContactScores (Rep4AddressMatchedFile = TRUE)) = 0  and ri.contact_did <> 0 			=> '2',
																							COUNT(appendedContactScores (Rep4AddressMatchedFile = TRUE)) > 0 	and ri.contact_did <> 0				=> '3',
																																																																								 '0');

		self.Business_To_Executive_Link.BusExecLinkAuthRep5AddrOnFile := MAP(Rep5InputAddressNotPopulated = TRUE																	=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (Rep5AddressMatchedFile = TRUE)) = 0  and ri.contact_did <> 0 			=> '2',
																							COUNT(appendedContactScores (Rep5AddressMatchedFile = TRUE)) > 0 	and ri.contact_did <> 0				=> '3',
																																																																								 '0');

		self.Business_To_Executive_Link.BusExecLinkAuthRepPhoneOnFile :=  MAP(RepInputPhonePopulated = FALSE																			=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (RepPhoneMatchedFile = TRUE)) = 0  and ri.contact_did <> 0 					=> '2',
																							COUNT(appendedContactScores (RepPhoneMatchedFile = TRUE)) > 0 and ri.contact_did <> 0						=> '3',
																																																																								 '0');

		self.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneOnFile :=  MAP(Rep2InputPhonePopulated = FALSE																		=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (Rep2PhoneMatchedFile = TRUE)) = 0 	and ri.contact_did <> 0					=> '2',
																							COUNT(appendedContactScores (Rep2PhoneMatchedFile = TRUE)) > 0 	and ri.contact_did <> 0					=> '3',
																																																																								 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneOnFile :=  MAP(Rep3InputPhonePopulated = FALSE																		=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (Rep3PhoneMatchedFile = TRUE)) = 0  and ri.contact_did <> 0 				=> '2',
																							COUNT(appendedContactScores (Rep3PhoneMatchedFile = TRUE)) > 0 	and ri.contact_did <> 0					=> '3',
																																																																								 '0');
			self.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneOnFile :=  MAP(Rep4InputPhonePopulated = FALSE																	=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (Rep4PhoneMatchedFile = TRUE)) = 0 	and ri.contact_did <> 0					=> '2',
																							COUNT(appendedContactScores (Rep4PhoneMatchedFile = TRUE)) > 0 	and ri.contact_did <> 0					=> '3',
																																																																								 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneOnFile :=  MAP(Rep5InputPhonePopulated = FALSE																		=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (Rep5PhoneMatchedFile = TRUE)) = 0  and ri.contact_did <> 0 				=> '2',
																							COUNT(appendedContactScores (Rep5PhoneMatchedFile = TRUE)) > 0 	and ri.contact_did <> 0					=> '3',
																																																																								 '0');

		self.Business_To_Executive_Link.BusExecLinkAuthRepSSNOnFile :=  MAP(RepInputSSNPopulated = FALSE																					=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (RepSSNMatchedFile = TRUE)) = 0 	and ri.contact_did <> 0						=> '2',
																							COUNT(appendedContactScores (RepSSNMatchedFile = TRUE)) > 0 	and ri.contact_did <> 0						=> '3',
																																																																								 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep2SSNOnFile := MAP(Rep2InputSSNPopulated = FALSE																					=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (Rep2SSNMatchedFile = TRUE)) = 0 and ri.contact_did <> 0 						=> '2',
																							COUNT(appendedContactScores (Rep2SSNMatchedFile = TRUE)) > 0  and ri.contact_did <> 0						=> '3',
																																																																								 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep3SSNOnFile :=  MAP(Rep3InputSSNPopulated = FALSE																				=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (Rep3SSNMatchedFile = TRUE)) = 0 and ri.contact_did <> 0 						=> '2',
																							COUNT(appendedContactScores (Rep3SSNMatchedFile = TRUE)) > 0 and ri.contact_did <> 0 						=> '3',
																																																																								 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep4SSNOnFile := MAP(Rep4InputSSNPopulated = FALSE																					=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (Rep4SSNMatchedFile = TRUE)) = 0 and ri.contact_did <> 0 						=> '2',
																							COUNT(appendedContactScores (Rep4SSNMatchedFile = TRUE)) > 0  and ri.contact_did <> 0						=> '3',
																																																																								 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep5SSNOnFile :=  MAP(Rep5InputSSNPopulated = FALSE																				=> '-1',
																							COUNT(appendedContactScores) = 0 and ri.contact_did = 0 																				=> '0',
																							TRIM(ri.fname) <> '' AND TRIM(ri.lname) <> ''	and   ri.contact_did = 0 													=> '1',
																							COUNT(appendedContactScores (Rep5SSNMatchedFile = TRUE)) = 0 and ri.contact_did <> 0 						=> '2',
																							COUNT(appendedContactScores (Rep5SSNMatchedFile = TRUE)) > 0 and ri.contact_did <> 0 						=> '3',
																																																																								 '0');

		self.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN := MAP(RepInputSSNPopulated = FALSE						=> '-1',
																							COUNT(appendedContactScores (RepSSNMatchedFeinFile = TRUE)) = 0		=> '0',
																							COUNT(appendedContactScores (RepSSNMatchedFeinFile = TRUE)) > 0		=> '1',
																																																									 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN := MAP(Rep2InputSSNPopulated = FALSE					=> '-1',
																							COUNT(appendedContactScores (Rep2SSNMatchedFeinFile = TRUE)) = 0  => '0',
																							COUNT(appendedContactScores (Rep2SSNMatchedFeinFile = TRUE)) > 0	=> '1',
																																																									 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep3SSNBusFein := MAP(Rep3InputSSNPopulated = FALSE					=> '-1',
																							COUNT(appendedContactScores (Rep3SSNMatchedFeinFile = TRUE)) = 0  => '0',
																							COUNT(appendedContactScores (Rep3SSNMatchedFeinFile = TRUE)) > 0	=> '1',
																																																									 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep4SSNBusFEIN := MAP(Rep4InputSSNPopulated = FALSE					=> '-1',
																							COUNT(appendedContactScores (Rep4SSNMatchedFeinFile = TRUE)) = 0  => '0',
																							COUNT(appendedContactScores (Rep4SSNMatchedFeinFile = TRUE)) > 0	=> '1',
																																																									 '0');
		self.Business_To_Executive_Link.BusExecLinkAuthRep5SSNBusFein := MAP(Rep5InputSSNPopulated = FALSE					=> '-1',
																							COUNT(appendedContactScores (Rep5SSNMatchedFeinFile = TRUE)) = 0  => '0',
																							COUNT(appendedContactScores (Rep5SSNMatchedFeinFile = TRUE)) > 0	=> '1',
																																																									 '0');
		SELF.Organizational_Structure.OrgParentCompany := MAP(ri.org_proxid <> 0 AND ri.org_proxid <> ri.proxid  => '0',
																													ri.org_proxid = 0 		OR ri.org_proxid = ri.proxid => '1', // org_proxid = 0 means we have a single location company, so it has no parent
																																																								'-1');

		SELF := le;
	END;
	// Set the MaxFEINVer to a '4' indicating that we had full verification at the input BIP ID level (Defaulted to SeleID)
	BusinessHeaderVerification := JOIN(withContactDIDs, BusinessHeader, LEFT.Seq = RIGHT.Seq,
																			verifyElements(LEFT, RIGHT, 4),
																			LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader));

	// Set the MaxFEINVer to a '3' indicating that we had full verification at the Ult BIP ID level, and not necessarily at the input BIP ID level
	BusinessHeaderUltVerification := JOIN(GROUP(Shell, Seq), BusinessHeaderUlt, LEFT.Seq = RIGHT.Seq,
																			verifyElements(LEFT, RIGHT, 3),
																			LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader));

	tempVerificationLayout rollBusinessHeaderVerification(tempVerificationLayout le, tempVerificationLayout ri) := TRANSFORM
		SELF.Verification.VerNameMiskey := IF((le.Verification.VerNameMiskey = '0' AND le.Verification.NameMatch = '1')OR (ri.Verification.VerNameMiskey = '0' AND ri.Verification.NameMatch = '1'), '0',
																					(STRING)MAX((INTEGER)le.Verification.VerNameMiskey, (INTEGER)ri.Verification.VerNameMiskey));
		SELF.Verification.NameMatch := (STRING)MAX((INTEGER)le.Verification.NameMatch, (INTEGER)ri.Verification.NameMatch);
		SELF.Verification.VerInputNameAlternative := (STRING)MIN((INTEGER)le.Verification.VerInputNameAlternative, (INTEGER)ri.Verification.VerInputNameAlternative);
		SELF.Verification.VerInputNameDBA := (STRING)MAX((INTEGER)le.Verification.VerInputNameDBA, (INTEGER)ri.Verification.VerInputNameDBA);
		SELF.Verification.AddrVerification := (STRING)MAX((INTEGER)le.Verification.AddrVerification, (INTEGER)ri.Verification.AddrVerification);
		SELF.Verification.AddrMiskey := IF((le.Verification.AddrMiskey = '0' AND le.AddressMatched) OR (ri.Verification.AddrMiskey = '0' AND ri.AddressMatched), '0',
																						(STRING)MAX((INTEGER)le.Verification.AddrMiskey, (INTEGER)ri.Verification.AddrMiskey));
		SELF.Verification.AddrZipVerification := (STRING)MAX((INTEGER)le.Verification.AddrZipVerification, (INTEGER)ri.Verification.AddrZipVerification);
		SELF.Verification.PhoneMatch := (STRING)MAX((INTEGER)le.Verification.PhoneMatch, (INTEGER)ri.Verification.PhoneMatch);
		SELF.Verification.PhoneInputMiskey :=IF((le.PhoneMatched AND le.Verification.PhoneInputMiskey = '0') OR (ri.PhoneMatched AND ri.Verification.PhoneInputMiskey = '0'), '0',
																						(STRING)MAX((INTEGER)le.Verification.PhoneInputMiskey, (INTEGER)ri.Verification.PhoneInputMiskey));
		SELF.Verification.VerificationBusInputPhoneAddr := (STRING)MAX((INTEGER)le.Verification.VerificationBusInputPhoneAddr, (INTEGER)ri.Verification.VerificationBusInputPhoneAddr);
		SELF.Verification.PhoneNameMismatch := (STRING)MAX((INTEGER)le.Verification.PhoneNameMismatch, (INTEGER)ri.Verification.PhoneNameMismatch);
		SELF.Verification.FEINVerification := (STRING)MAX((INTEGER)le.Verification.FEINVerification, (INTEGER)ri.Verification.FEINVerification);
		SELF.Verification.FEINInputMiskey := IF((le.FEINMatched AND le.Verification.FEINInputMiskey = '0') OR (ri.FEINMatched AND ri.Verification.FEINInputMiskey = '0'), '0',
																						(STRING)MAX((INTEGER)le.Verification.FEINInputMiskey, (INTEGER)ri.Verification.FEINInputMiskey));
		SELF.Address_Phone_History := le.Address_Phone_History + ri.Address_Phone_History;
		SELF.Address_History := le.Address_History + ri.Address_History;

		// Only keep a 7 if there are no 6's found, if a 6 is found keep the 6 over the 7 - this is because it's likely that not every record on the header has FEIN populated
		MaxBNAT := MAX((INTEGER)le.Verification.BNAT, (INTEGER)ri.Verification.BNAT);
		SELF.Verification.BNAT := MAP(MaxBNAT <= 6 OR MaxBNAT > 7																=> (STRING)MaxBNAT, // Both left and right are less than 7 or we fully verified, keep the max
																	le.Verification.BNAT = '6' OR ri.Verification.BNAT = '6'	=> '6', // We have a 7 that we are dealing with, check if the left or right are a 6, if so keep the 6
																																								(STRING)MaxBNAT);
		// Only keep a 7 if there are no 6's found, if a 6 is found keep the 6 over the 7 - this is because it's likely that not every record on the header has phone populated
		MaxBNAP := MAX((INTEGER)le.Verification.BNAP, (INTEGER)ri.Verification.BNAP);
		SELF.Verification.BNAP := MAP(MaxBNAP <= 6 OR MaxBNAP > 7																=> (STRING)MaxBNAP, // Both left and right are less than 7 or we fully verified, keep the max
																	le.Verification.BNAP = '6' OR ri.Verification.BNAP = '6'	=> '6', // We have a 7 that we are dealing with, check if the left or right are a 6, if so keep the 6
																																								(STRING)MaxBNAP);
		SELF.FEINMatched := le.FEINMatched OR ri.FEINMatched;
		SELF.FEINPopulated := le.FEINPopulated OR ri.FEINPopulated;
		SELF.NameMatched := le.NameMatched OR ri.NameMatched;
		SELF.AddressMatched := le.AddressMatched OR ri.AddressMatched;
		SELF.StateMatched := le.StateMatched OR ri.StateMatched;
		SELF.PhoneMatched := le.PhoneMatched OR ri.PhoneMatched;
		SELF.PhonePopulated := le.PhonePopulated OR ri.PhonePopulated;

		SELF.NameSources := le.NameSources + ri.NameSources;
		SELF.AddressSources := le.AddressSources + ri.AddressSources;
		SELF.AddressVerSources := le.AddressVerSources + ri.AddressVerSources;
		SELF.BestAddressSources := le.BestAddressSources + ri.BestAddressSources;
		SELF.PhoneSources := le.PhoneSources + ri.PhoneSources;
		SELF.FEINSources := le.FEINSources + ri.FEINSources;
		SELF.BestAddrPhones := le.BestAddrPhones + ri.BestAddrPhones;

    SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstFile);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFull := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFull, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFull);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile);
		SELF.Business_To_Executive_Link.AR2BRep1PhoneBusHeader := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.AR2BRep1PhoneBusHeader, (INTEGER)ri.Business_To_Executive_Link.AR2BRep1PhoneBusHeader);
		SELF.Business_To_Executive_Link.AR2BRep2PhoneBusHeader := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.AR2BRep2PhoneBusHeader, (INTEGER)ri.Business_To_Executive_Link.AR2BRep2PhoneBusHeader);
		SELF.Business_To_Executive_Link.AR2BRep3PhoneBusHeader := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.AR2BRep3PhoneBusHeader, (INTEGER)ri.Business_To_Executive_Link.AR2BRep3PhoneBusHeader);
		SELF.Business_To_Executive_Link.AR2BRep4PhoneBusHeader := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.AR2BRep4PhoneBusHeader, (INTEGER)ri.Business_To_Executive_Link.AR2BRep4PhoneBusHeader);
		SELF.Business_To_Executive_Link.AR2BRep5PhoneBusHeader := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.AR2BRep5PhoneBusHeader, (INTEGER)ri.Business_To_Executive_Link.AR2BRep5PhoneBusHeader);
		SELF.Business_To_Executive_Link.AR2BRep1SSNBusHeader := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.AR2BRep1SSNBusHeader, (INTEGER)ri.Business_To_Executive_Link.AR2BRep1SSNBusHeader);
		SELF.Business_To_Executive_Link.AR2BRep2SSNBusHeader := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.AR2BRep2SSNBusHeader, (INTEGER)ri.Business_To_Executive_Link.AR2BRep2SSNBusHeader);
		SELF.Business_To_Executive_Link.AR2BRep3SSNBusHeader := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.AR2BRep3SSNBusHeader, (INTEGER)ri.Business_To_Executive_Link.AR2BRep3SSNBusHeader);
		SELF.Business_To_Executive_Link.AR2BRep4SSNBusHeader := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.AR2BRep4SSNBusHeader, (INTEGER)ri.Business_To_Executive_Link.AR2BRep4SSNBusHeader);
		SELF.Business_To_Executive_Link.AR2BRep5SSNBusHeader := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.AR2BRep5SSNBusHeader, (INTEGER)ri.Business_To_Executive_Link.AR2BRep5SSNBusHeader);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepLexIDOnFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRepLexIDOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRepLexIDOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepAddrOnFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRepAddrOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRepAddrOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepPhoneOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRepPhoneOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRepPhoneOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepSSNOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRepSSNOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRepSSNOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN);

		//rep2
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstFile);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2LexIDOnFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep2LexIDOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep2LexIDOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2AddrOnFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep2AddrOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep2AddrOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2SSNOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep2SSNOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep2SSNOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN);
		//rep3
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstFile);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3First := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3First, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Last := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Last, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Full := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Full, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Full);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneBusPhone := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneBusPhone, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneBusPhone);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddr := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddr, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddr);
    SELF.Business_To_Executive_Link.BusExecLinkAuthRep3LexIDOnFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep3LexIDOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep3LexIDOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3NameOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep3NameOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep3NameOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3AddrOnFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep3AddrOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep3AddrOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3SSNOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep3SSNOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep3SSNOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep3SSNBusFein  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep3SSNBusFein, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep3SSNBusFein);
		//rep4
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstFile);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4First := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4First, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Last := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Last, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Full := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Full, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Full);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneBusPhone := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneBusPhone, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneBusPhone);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddr := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddr, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddr);
    SELF.Business_To_Executive_Link.BusExecLinkAuthRep4LexIDOnFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep4LexIDOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep4LexIDOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4NameOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep4NameOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep4NameOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4AddrOnFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep4AddrOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep4AddrOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4SSNOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep4SSNOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep4SSNOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep4SSNBusFEIN  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep4SSNBusFEIN, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep4SSNBusFEIN);
		//rep5
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstFile);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5First := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5First, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5First);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Last := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Last, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Last);
		SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Full := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Full, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Full);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneBusPhone := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneBusPhone, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneBusPhone);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddr := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddr, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddr);
    SELF.Business_To_Executive_Link.BusExecLinkAuthRep5LexIDOnFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep5LexIDOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep5LexIDOnFile);
    SELF.Business_To_Executive_Link.BusExecLinkAuthRep5NameOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep5NameOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep5NameOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5AddrOnFile := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep5AddrOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep5AddrOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5SSNOnFile  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep5SSNOnFile, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep5SSNOnFile);
		SELF.Business_To_Executive_Link.BusExecLinkAuthRep5SSNBusFein  := (STRING)MAX((INTEGER)le.Business_To_Executive_Link.BusExecLinkAuthRep5SSNBusFein, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkAuthRep5SSNBusFein);
		SELF.Organizational_Structure.OrgParentCompany := (STRING)MAX((INTEGER)le.Organizational_Structure.OrgParentCompany, (INTEGER)ri.Organizational_Structure.OrgParentCompany);
		SELF := le;
	END;
	BusinessHeaderVerificationRolled := ROLLUP(SORT(BusinessHeaderVerification, Seq), LEFT.Seq = RIGHT.Seq, rollBusinessHeaderVerification(LEFT, RIGHT));

	BusinessHeaderUltVerificationRolled := ROLLUP(SORT(BusinessHeaderUltVerification, Seq), LEFT.Seq = RIGHT.Seq, rollBusinessHeaderVerification(LEFT, RIGHT));

	BusinessHeaderAllAddresses := PROJECT(BusinessHeader, TRANSFORM({RECORDOF(LEFT), INTEGER BusinessAddrCount},
																															SELF.BusinessAddrCount := MAP(TRIM(LEFT.Prim_Name) = '' OR (INTEGER)LEFT.Zip <= 0																		=> -1, // Address Not on Header Record
																																			(INTEGER)ut.DaysApart(Business_Risk_BIP.Common.checkInvalidDate((STRING)LEFT.dt_last_seen, Business_Risk_BIP.Constants.MissingDate, LEFT.HistoryDate), Business_Risk_BIP.Common.todaysDate(BHBuildDate, LEFT.HistoryDate)) <= Business_Risk_BIP.Constants.OneYear	=> 1, // Address for this record is current
																																																																																												 0); // Address for this record is not current
																															SELF := LEFT));

	// Keep the unique addresses, specifically keep the record that says the address is currently reporting (if one exists)
	BusinessHeaderUniqueAddresses := DEDUP(SORT(BusinessHeaderAllAddresses, Seq, Prim_Range, Prim_Name, Sec_Range, Zip, -BusinessAddrCount),
																																					Seq, Prim_Range, Prim_Name, Sec_Range, Zip);

	countedUniqueAddresses := TABLE(BusinessHeaderUniqueAddresses,
						{Seq,
						 INTEGER BusinessAddrCount := IF(MAX(GROUP, BusinessAddrCount) = -1, // If no header records had address on file, return -1
																											-1,
																											COUNT(GROUP, BusinessAddrCount = 1)), // Otherwise return the number of addresses currently reporting
						 UNSIGNED1 HeaderHit := 1
						},
						Seq);

	// Rollup the dates first/last seen into child datasets by Seq
	tempLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
	END;
	BusinessHeaderStatsTemp := PROJECT(BusinessHeaderSourceStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source,
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen),
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources)));
	BusinessHeaderStatsRolled := ROLLUP(BusinessHeaderStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources));

	withBusinessHeader := JOIN(withContactDIDs, BusinessHeaderStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := RIGHT.Sources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	withBusinessHeaderVerification := JOIN(withBusinessHeader, BusinessHeaderVerificationRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							BestBusinessAddress := TOPN(RIGHT.Address_Phone_History((INTEGER)Zip > 0), 1, -DateLastSeen, DateFirstSeen, Zip)[1];
																							SELF.PhoneAddressDistances.BestBusinessPhone := TOPN(RIGHT.Address_Phone_History((INTEGER)Company_Phone > 0), 1, -DateLastSeen, DateFirstSeen, Company_Phone)[1].Company_Phone;
																							SELF.PhoneAddressDistances.BestBusinessPrimRange := BestBusinessAddress.Prim_Range;
																							SELF.PhoneAddressDistances.BestBusinessPrimName := BestBusinessAddress.Prim_Name;
																							SELF.PhoneAddressDistances.BestBusinessSecRange := BestBusinessAddress.Sec_Range;
																							SELF.PhoneAddressDistances.BestBusinessZip := BestBusinessAddress.Zip;
																							SELF.PhoneAddressDistances.BestBusinessSt := BestBusinessAddress.St;
																							SELF.PhoneAddressDistances.BestBusinessCity := BestBusinessAddress.P_City_Name;
																							SELF.PhoneAddressDistances.BestBusinessLat := BestBusinessAddress.Geo_Lat;
																							SELF.PhoneAddressDistances.BestBusinessLong := BestBusinessAddress.Geo_Long;

																							rolled_Address_History := ROLLUP(SORT(RIGHT.Address_History, -InputAddress, -DateLastSeen, DateFirstSeen), LEFT.InputAddress = RIGHT.InputAddress,
																																								TRANSFORM(RECORDOF(LEFT), SELF.InputAddress := LEFT.InputAddress;
																																																					dfSeenLeft := IF((INTEGER)LEFT.DateFirstSeen <= 0, 99999999, (INTEGER)LEFT.DateFirstSeen);
																																																					dfSeenRight := IF((INTEGER)RIGHT.DateFirstSeen <= 0, 99999999, (INTEGER)RIGHT.DateFirstSeen);
																																																					dfSeenMin := MIN(dfSeenLeft, dfSeenRight);
																																																					SELF.DateFirstSeen := IF(dfSeenMin = 99999999, '0', (STRING)dfSeenMin);
																																																					SELF.DateLastSeen := (STRING)MAX((INTEGER)LEFT.DateLastSeen, (INTEGER)RIGHT.DateLastSeen);
																																																					SELF := LEFT));
																							SELF.Verification.InputAddrNotMostRecent := MAP(COUNT(rolled_Address_History (InputAddress = TRUE)) = 0																								=> '-1', // Input Address Not Found in Address History
																																															TOPN(rolled_Address_History, 1, -DateLastSeen, -InputAddress, -DateFirstSeen)[1].InputAddress = TRUE	=> '0', // Input Address IS the most recent in Address History
																																															TOPN(rolled_Address_History, 1, -DateLastSeen, -InputAddress, -DateFirstSeen)[1].InputAddress = FALSE	=> '1', // Input Address IS NOT the most recent in Address History
																																																																																																			 '-1');
																							SELF.Verification.NameMatch := RIGHT.Verification.NameMatch;
																							SELF.Verification.VerNameMiskey := RIGHT.Verification.VerNameMiskey;
																							SELF.Verification.VerInputNameAlternative := RIGHT.Verification.VerInputNameAlternative;
																							SELF.Verification.VerInputNameDBA := RIGHT.Verification.VerInputNameDBA;
																							SELF.Verification.AddrVerification := RIGHT.Verification.AddrVerification;
																							SELF.Verification.AddrMiskey := RIGHT.Verification.AddrMiskey;
																							SELF.Verification.AddrZipVerification := RIGHT.Verification.AddrZipVerification;
																							SELF.Verification.PhoneMatch := RIGHT.Verification.PhoneMatch;
																							SELF.Verification.PhoneInputMiskey := RIGHT.Verification.PhoneInputMiskey;
																							SELF.Verification.VerificationBusInputPhoneAddr := RIGHT.Verification.VerificationBusInputPhoneAddr;
																							SELF.Verification.PhoneNameMismatch := RIGHT.Verification.PhoneNameMismatch;
																							SELF.Verification.FEINVerification := RIGHT.Verification.FEINVerification;
																							SELF.Verification.FEINInputMiskey := RIGHT.Verification.FEINInputMiskey;
																							SELF.Verification.BNAT := RIGHT.Verification.BNAT; // Requires all elements verify within the same header record
																							SELF.Verification.BNAP := RIGHT.Verification.BNAP; // Requires all elements verify within the same header record
																							SELF.Verification.BNAT2 := calcBNAT(RIGHT.FEINMatched, RIGHT.FEINPopulated, RIGHT.NameMatched, RIGHT.AddressMatched, RIGHT.StateMatched); // Uses the combination of all header records to verify elements
																							SELF.Verification.BNAP2 := Business_Risk_BIP.Common.calcBNAP_wide(RIGHT.PhoneMatched, RIGHT.PhonePopulated, RIGHT.NameMatched, RIGHT.AddressMatched, RIGHT.StateMatched); // Uses the combination of all header records to verify elements
																							SELF.NameSources := RIGHT.NameSources;
																							SELF.AddressVerSources := RIGHT.AddressVerSources;
																							SELF.BestAddressSources := RIGHT.BestAddressSources;
																							SELF.AddressSources := RIGHT.AddressSources;
																							SELF.PhoneSources := RIGHT.PhoneSources;
																							SELF.FEINSources := RIGHT.FEINSources;
																							SELF.BestAddrPhones := RIGHT.BestAddrPhones;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstFile := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRepPrefFirstFile;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFull := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFull;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile;
																							SELF.Business_To_Executive_Link.AR2BRep1PhoneBusHeader := RIGHT.Business_To_Executive_Link.AR2BRep1PhoneBusHeader;
																							SELF.Business_To_Executive_Link.AR2BRep2PhoneBusHeader := RIGHT.Business_To_Executive_Link.AR2BRep2PhoneBusHeader;
																							SELF.Business_To_Executive_Link.AR2BRep3PhoneBusHeader := RIGHT.Business_To_Executive_Link.AR2BRep3PhoneBusHeader;
																							SELF.Business_To_Executive_Link.AR2BRep4PhoneBusHeader := RIGHT.Business_To_Executive_Link.AR2BRep4PhoneBusHeader;
																							SELF.Business_To_Executive_Link.AR2BRep5PhoneBusHeader := RIGHT.Business_To_Executive_Link.AR2BRep5PhoneBusHeader;
																							SELF.Business_To_Executive_Link.AR2BRep1SSNBusHeader := RIGHT.Business_To_Executive_Link.AR2BRep1SSNBusHeader;
																							SELF.Business_To_Executive_Link.AR2BRep2SSNBusHeader := RIGHT.Business_To_Executive_Link.AR2BRep2SSNBusHeader;
																							SELF.Business_To_Executive_Link.AR2BRep3SSNBusHeader := RIGHT.Business_To_Executive_Link.AR2BRep3SSNBusHeader;
																							SELF.Business_To_Executive_Link.AR2BRep4SSNBusHeader := RIGHT.Business_To_Executive_Link.AR2BRep4SSNBusHeader;
																							SELF.Business_To_Executive_Link.AR2BRep5SSNBusHeader := RIGHT.Business_To_Executive_Link.AR2BRep5SSNBusHeader;

																							SELF.Business_To_Executive_Link.BusExecLinkAuthRepLexIDOnFile := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepLexIDOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRepAddrOnFile := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepAddrOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRepPhoneOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepPhoneOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRepSSNOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepSSNOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN;
																							//rep2
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep2LexIDOnFile := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2LexIDOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstFile := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2PrefFirstFile;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Full;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep2AddrOnFile := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2AddrOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep2SSNOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2SSNOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN;
																							//rep3
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstFile := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3PrefFirstFile;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3First := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3First;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Last := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Last;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Full := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3Full;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneBusPhone := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneBusPhone;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddr := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3AddrBusAddr;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep3NameOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3NameOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep3LexIDOnFile := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3LexIDOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep3AddrOnFile := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3AddrOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3PhoneOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep3SSNOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3SSNOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep3SSNBusFein := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep3SSNBusFein;

																							//rep4
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstFile := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4PrefFirstFile;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4First := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4First;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Last := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Last;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Full := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep4Full;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneBusPhone := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneBusPhone;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddr := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4AddrBusAddr;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep4NameOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4NameOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep4LexIDOnFile := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4LexIDOnFile;
                                              SELF.Business_To_Executive_Link.BusExecLinkAuthRep4AddrOnFile := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4AddrOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4PhoneOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep4SSNOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4SSNOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep4SSNBusFEIN := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep4SSNBusFEIN;
																							//rep5
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstFile := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5PrefFirstFile;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5First := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5First;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Last := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Last;
																							SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Full := RIGHT.Business_To_Executive_Link.BusExecLinkBusNameAuthRep5Full;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneBusPhone := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneBusPhone;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddr := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5AddrBusAddr;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep5NameOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5NameOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep5LexIDOnFile := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5LexIDOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep5AddrOnFile := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5AddrOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5PhoneOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep5SSNOnFile  := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5SSNOnFile;
																							SELF.Business_To_Executive_Link.BusExecLinkAuthRep5SSNBusFein := RIGHT.Business_To_Executive_Link.BusExecLinkAuthRep5SSNBusFein;
																							SELF.Organizational_Structure.OrgParentCompany := RIGHT.Organizational_Structure.OrgParentCompany;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	withBusinessHeaderUltVerification := JOIN(withBusinessHeaderVerification, BusinessHeaderUltVerificationRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							// Take the Max between the input BIP ID FEIN Verification and the Ult BIP ID FEIN Verification
																							SELF.Verification.FEINVerification := (STRING)MAX((INTEGER)LEFT.Verification.FEINVerification, (INTEGER)RIGHT.Verification.FEINVerification);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);

	withBusinessHeaderUniqueAddresses := JOIN(withBusinessHeaderUltVerification, countedUniqueAddresses, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Business_Characteristics.BusinessAddrCount := IF(RIGHT.HeaderHit = 1, (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BusinessAddrCount, -1, 999), '-1');
																							SELF.Data_Build_Dates.BusinessHeaderBuildDate := BHBuildDate;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);

	withAssociateCounts := JOIN(withBusinessHeaderUniqueAddresses, BusinessHeaderTotalUniqueContactDIDs, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Associates.AssociateCount := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.UniqueDIDCount, -1, 100);
																							SELF.Associates.AssociateCurrentCount := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.CurrentUniqueDIDCount, -1, 100);
																							SELF.Associates.AssociateCurrentSOSCount := (STRING)Business_Risk_BIP.Common.capNum(RIGHT.CurrentUniqueSOSDIDCount, -1, 100);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW, PARALLEL);

	// get Residential or business Advo Ind
	BusInputAddr :=			project(Shell, transform({recordof(BusinessHeaderUniqueAddresses), boolean inputAddr},
																															self.Seq := left.Seq,
																															SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
																															self.Company_Name := left.Clean_Input.CompanyName,
																															self.zip := left.Clean_Input.Zip5,
																															self.prim_range := left.Clean_Input.Prim_Range,
																															self.prim_name := left.Clean_Input.Prim_Name,
																															SELF.Addr_Suffix := LEFT.Clean_Input.Addr_Suffix,
																															SELF.Predir := LEFT.Clean_Input.Predir,
																															SELF.Postdir := LEFT.Clean_Input.Postdir,
																															self.sec_range := left.Clean_Input.Sec_Range,
																															self.st := left.Clean_Input.State,
																															self.p_city_name := left.Clean_Input.City,
																															self.inputAddr := true,
																															self := left,
																															self := []));
	AllbusnAddress := project(BusinessHeaderUniqueAddresses,transform({recordof(BusinessHeaderUniqueAddresses), boolean inputAddr},
																														self.inputAddr := false,
																														self := left))
																														+ BusInputAddr;

	withAdvo := join(AllbusnAddress, Advo.Key_Addr1_history,
// Prim_Range, Prim_Name, Sec_Range, Zip
					left.zip != '' and
					left.prim_range != '' and
					keyed(left.zip = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					keyed(left.sec_range = right.sec_range)  and
					((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)) and
					// ADVO not allowed in marketing mode
					Options.MarketingMode = 0,
					transform({recordof(left), string2 Residential_or_Business_Ind, STRING2 Address_Vacancy_Ind, integer AdvoDtfirstseen},
											self.Residential_or_Business_Ind   := right.Residential_or_Business_Ind ,
											SELF.Address_Vacancy_Ind := RIGHT.Address_Vacancy_Indicator,
											self.AdvoDtfirstseen   := (integer)right.date_first_seen,
											self.inputAddr := left.inputAddr,
											self := left,
											self := []), left outer,atmost(50));
withADVODDInput := dedup(sort(withAdvo (InputAddr = TRUE), seq, zip,prim_range,	prim_name, addr_suffix, predir, postdir, sec_range, inputAddr, -AdvoDtfirstseen),
															seq, zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range	);
withAdvoDD :=    dedup(sort(withAdvo (InputAddr = FALSE), seq, zip,prim_range,	prim_name, addr_suffix, predir, postdir, sec_range, inputAddr, -AdvoDtfirstseen),
															seq, zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range	);

AdvoResidential := project(withADVODDInput,  transform({recordof(withADVODDInput), STRING2 InputAddrType, STRING2 BusinessBestAddrType, STRING2 InputAddrVacancy},
																		self.InputAddrType := left.Residential_or_Business_Ind,
																		SELF.InputAddrVacancy := LEFT.Address_Vacancy_Ind,
																	  self := left,
																		SELF := [])) +
									 project(withAdvoDD,  transform({recordof(withAdvoDD), STRING2 InputAddrType, STRING2 BusinessBestAddrType, STRING2 InputAddrVacancy},
																		self.BusinessBestAddrType := left.Residential_or_Business_Ind,
																		self := left,
																		SELF := []));

RollAdvoResidential := rollup(SORT(AdvoResidential, Seq), LEFT.Seq = RIGHT.Seq,
																		transform(RECORDOF(LEFT),
																		self.InputAddrType := if(left.InputAddrType = '', right.InputAddrType, left.InputAddrType),
																		self.InputAddrVacancy := if(left.InputAddrVacancy = '', right.InputAddrVacancy, left.InputAddrVacancy),
																		self.BusinessBestAddrType := if(left.BusinessBestAddrType = '', right.BusinessBestAddrType, left.BusinessBestAddrType),
																	  self := left));


	// Gather the full BIP Link ID Tree
	tempIDTree := RECORD
		UNSIGNED4 Seq; // Shell Seq so this works with batch
		UNSIGNED3 HistoryDate; // Input history date
		UNSIGNED4 DateFirstSeen; // Dt_First_Seen on the Header
		STRING2 Source; // Header record source
		DATASET({STRING2 Source}) Sources; // Header record source
		SALT28.UIDType Selected_PowID; // BIP Link ID we found from the Link ID Append
		SALT28.UIDType Selected_ProxID;
		SALT28.UIDType Selected_SeleID;
		SALT28.UIDType Selected_OrgID;
		SALT28.UIDType Selected_UltID;
		SALT28.UIDType Header_PowID; // BIP Link ID we found on the Business Header tied to the UltID we found from the Link ID Append
		SALT28.UIDType Header_ProxID;
		SALT28.UIDType Header_SeleID;
		SALT28.UIDType Header_OrgID;
		SALT28.UIDType Header_UltID;
		DATASET({SALT28.UIDType PowID})		PowIDs; //  BIP Link ID we found on the Business Header
		DATASET({SALT28.UIDType ProxID})	ProxIDs;
		DATASET({SALT28.UIDType SeleID})	SeleIDs;
		DATASET({SALT28.UIDType SeleID})	SeleIDsAddrMatch;
		DATASET({SALT28.UIDType OrgID})		OrgIDs;
		DATASET({SALT28.UIDType UltID})		UltIDs;
	END;

	// Since we are attempting to gather the full tree and not just what matched on all of our link ID levels join to the UltID Business Header results
	businessHeaderSource := SORT(JOIN(Shell, BusinessHeaderUlt, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(tempIDTree, SELF.Seq := LEFT.Seq;
																												SELF.HistoryDate := LEFT.Clean_Input.HistoryDate;
																												//Date first seen is only used for filtering so fill it with whichever field is populated here.
																												SELF.DateFirstSeen := IF((UNSIGNED)RIGHT.dt_first_seen > 0, (UNSIGNED)RIGHT.dt_first_seen, (UNSIGNED)RIGHT.dt_vendor_first_reported);
																												SELF.Source := RIGHT.Source;
																												SELF.Sources := DATASET([{RIGHT.Source}], {STRING2 Source});
																												SELF.Selected_PowID := LEFT.BIP_IDs.PowID.LinkID;
																												SELF.Selected_ProxID := LEFT.BIP_IDs.ProxID.LinkID;
																												SELF.Selected_SeleID := LEFT.BIP_IDs.SeleID.LinkID;
																												SELF.Selected_OrgID := LEFT.BIP_IDs.OrgID.LinkID;
																												SELF.Selected_UltID := LEFT.BIP_IDs.UltID.LinkID;
																												SELF.Header_PowID := RIGHT.PowID;
																												SELF.Header_ProxID := RIGHT.ProxID;
																												SELF.Header_SeleID := RIGHT.SeleID;
																												SELF.Header_OrgID := RIGHT.OrgID;
																												SELF.Header_UltID := RIGHT.UltID;
																												SELF.PowIDs := DATASET([{RIGHT.PowID}], {SALT28.UIDType PowID});
																												SELF.ProxIDs := DATASET([{RIGHT.ProxID}], {SALT28.UIDType ProxID});
																												SELF.SeleIDs := DATASET([{RIGHT.SeleID}], {SALT28.UIDType SeleID});
																												NoScoreValue				:= 255;
																												AddressPopulated		:= TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND TRIM(RIGHT.prim_name) <> '' AND TRIM(RIGHT.Zip) <> '';
																												ZIPScore						:= IF(LEFT.Clean_Input.Zip5 <> '' AND RIGHT.Zip <> '' AND LEFT.Clean_Input.Zip5[1] = RIGHT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Zip5, RIGHT.Zip), NoScoreValue);
																												StateMatched				:= STD.Str.ToUpperCase(LEFT.Clean_Input.State) = STD.Str.ToUpperCase(RIGHT.st);
																												CityStateScore			:= IF(LEFT.Clean_Input.City <> '' AND LEFT.Clean_Input.State <> '' AND RIGHT.p_city_name <> '' AND RIGHT.st <> '' AND LEFT.Clean_Input.State[1] = RIGHT.st[1], Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.City, LEFT.Clean_Input.State, RIGHT.p_city_name, RIGHT.st, ''), NoScoreValue);
																												CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
																												AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue,
																																															Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Prim_Range, LEFT.Clean_Input.Prim_Name, LEFT.Clean_Input.Sec_Range,
																																																RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range,
																																																ZIPScore, CityStateScore)));
																												SELF.SeleIDsAddrMatch := IF(AddressMatched, DATASET([{RIGHT.SeleID}], {SALT28.UIDType SeleID}),
																																																		DATASET([], {SALT28.UIDType SeleID}));
																												SELF.OrgIDs := DATASET([{RIGHT.OrgID}], {SALT28.UIDType OrgID});
																												SELF.UltIDs := DATASET([{RIGHT.UltID}], {SALT28.UIDType UltID})
																												),
																							ATMOST(Business_Risk_BIP.Constants.Limit_BusHeader)), Seq);

	tempIDTree rollIDTree(tempIDTree le, tempIDTree ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.HistoryDate := le.HistoryDate;
		SELF.DateFirstSeen := MIN((UNSIGNED)Business_Risk_BIP.Common.checkInvalidDate((STRING)le.DateFirstSeen, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate), (UNSIGNED)Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.DateFirstSeen, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate));
		SELF.Source := le.Source;
		SELF.Sources := le.Sources + ri.Sources;
		SELF.Selected_PowID := le.Selected_PowID;
		SELF.Selected_ProxID := le.Selected_ProxID;
		SELF.Selected_SeleID := le.Selected_SeleID;
		SELF.Selected_OrgID := le.Selected_OrgID;
		SELF.Selected_UltID := le.Selected_UltID;
		SELF.Header_PowID := le.Header_PowID;
		SELF.Header_ProxID := le.Header_ProxID;
		SELF.Header_SeleID := le.Header_SeleID;
		SELF.Header_OrgID := le.Header_OrgID;
		SELF.Header_UltID := le.Header_UltID;
		SELF.PowIDs := le.PowIDs + ri.PowIDs;
		SELF.ProxIDs := le.ProxIDs + ri.ProxIDs;
		SELF.SeleIDs := le.SeleIDs + ri.SeleIDs;
		SELF.SeleIDsAddrMatch := le.SeleIDsAddrMatch + ri.SeleIDsAddrMatch;
		SELF.OrgIDs := le.OrgIDs + ri.OrgIDs;
		SELF.UltIDs := le.UltIDs + ri.UltIDs;
	END;

	tempIDTree cleanTree(tempIDTree le) := TRANSFORM
		SELF.Sources := DEDUP(SORT(le.Sources, Source), Source);
		SELF.PowIDs := DEDUP(SORT(le.PowIDs, PowID), PowID);
		SELF.ProxIDs := DEDUP(SORT(le.ProxIDs, ProxID), ProxID);
		SELF.SeleIDs := DEDUP(SORT(le.SeleIDs, SeleID), SeleID);
		SELF.SeleIDsAddrMatch := DEDUP(SORT(le.SeleIDsAddrMatch, SeleID), SeleID);
		SELF.OrgIDs := DEDUP(SORT(le.OrgIDs, OrgID), OrgID);
		SELF.UltIDs := DEDUP(SORT(le.UltIDs, UltID), UltID);
		SELF := le;
	END;

	UltIDTreeFull := ROLLUP(businessHeaderSource (Selected_UltID = Header_UltID), LEFT.Seq = RIGHT.Seq, rollIDTree(LEFT, RIGHT));
	UltIDTree := PROJECT(UltIDTreeFull, cleanTree(LEFT));

	OrgIDTreeFull := ROLLUP(businessHeaderSource (Selected_UltID = Header_UltID AND Selected_OrgID = Header_OrgID), LEFT.Seq = RIGHT.Seq, rollIDTree(LEFT, RIGHT));
	OrgIDTree := PROJECT(OrgIDTreeFull, cleanTree(LEFT));

	SeleIDTreeFull := ROLLUP(businessHeaderSource (Selected_UltID = Header_UltID AND Selected_OrgID = Header_OrgID AND Selected_SeleID = Header_SeleID), LEFT.Seq = RIGHT.Seq, rollIDTree(LEFT, RIGHT));
	SeleIDTree := PROJECT(SeleIDTreeFull, cleanTree(LEFT));

	ProxIDTreeFull := ROLLUP(businessHeaderSource (Selected_UltID = Header_UltID AND Selected_OrgID = Header_OrgID AND Selected_SeleID = Header_SeleID AND Selected_ProxID = Header_ProxID), LEFT.Seq = RIGHT.Seq, rollIDTree(LEFT, RIGHT));
	ProxIDTree := PROJECT(ProxIDTreeFull, cleanTree(LEFT));

	withUltIDTreeCounts := JOIN(withAssociateCounts, UltIDTree, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Organizational_Structure.UltIDOrgIDTreeCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(RIGHT.OrgIDs), -1, 99999);
																							SELF.Organizational_Structure.OrgLegalEntityCount := (STRING)Business_Risk_BIP.Common.capNum(MAX(calculateValueFor._OrgLegalEntityCount(COUNT(RIGHT.SeleIDs)), 0), -1, 99999); // Subtract 1 from the COUNT to not count the SeleID we picked as the primary Sele
																							SELF.Organizational_Structure.OrgAddrLegalEntityCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(RIGHT.SeleIDsAddrMatch), -1, 99999);
																							SELF.Organizational_Structure.UltIDProxIDTreeCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(RIGHT.ProxIDs), -1, 99999);
																							SELF.Organizational_Structure.UltIDPowIDTreeCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(RIGHT.PowIDs), -1, 99999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	withOrgIDTreeCounts := JOIN(withUltIDTreeCounts, OrgIDTree, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Organizational_Structure.OrgRelatedCount := (STRING)Business_Risk_BIP.Common.capNum(MAX(calculateValueFor._OrgRelatedCount(COUNT(RIGHT.SeleIDs)), 0), -1, 99999); // Subtract 1 from the COUNT to not count the SeleID we picked as the primary Sele
																							SELF.Organizational_Structure.OrgIDProxIDTreeCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(RIGHT.ProxIDs), -1, 99999);
																							SELF.Organizational_Structure.OrgIDPowIDTreeCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(RIGHT.PowIDs), -1, 99999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	withSeleIDTreeCounts := JOIN(withOrgIDTreeCounts, SeleIDTree, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Organizational_Structure.OrgLocationCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(RIGHT.ProxIDs), -1, 99999);
																							SELF.Organizational_Structure.SeleIDPowIDTreeCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(RIGHT.PowIDs), -1, 99999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	withProxIDTreeCounts := JOIN(withSeleIDTreeCounts, ProxIDTree, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Organizational_Structure.ProxIDPowIDTreeCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(RIGHT.PowIDs), -1, 99999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	withAddrResInd := join(withProxIDTreeCounts, if(mod_access.DataRestrictionMask[Risk_indicators.iid_constants.posADVORestriction] = '1', dataset([],recordof(RollAdvoResidential)),
																									RollAdvoResidential),
																								LEFT.Seq = RIGHT.Seq,
																							TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Input_Characteristics.InputAddrType := right.InputAddrType,
																							SELF.Business_Characteristics.BusinessBestAddrType := right.BusinessBestAddrType,
																							SELF.Verification.InputAddrVacancy := RIGHT.InputAddrVacancy,
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
		//get BIP ID Match info before filtering by date
	BusinessHeaderIDStatus := JOIN(linkIDGroups, BusinessHeaderUltSeq, LEFT.Seq = RIGHT. Seq AND
																										(LEFT.UltID = RIGHT.UltID) AND // Should always match on UltID
																										(LEFT.OrgID = RIGHT.OrgID OR LEFT.OrgID = 0) AND // Not searching on only UltID - Match OrgID too
																										(LEFT.SeleID = RIGHT.SeleID OR LEFT.SeleID = 0) AND // Not searching on only UltID/OrgID - Match on SeleID too
																										(LEFT.ProxID = RIGHT.ProxID OR LEFT.ProxID = 0) AND // Not searching on only UltID/OrgID/SeleID - Match on ProxID too
																										(LEFT.PowID = RIGHT.PowID OR LEFT.PowID = 0), // Not searching on only UltID/OrgID/SeleID/ProxID - Match on PowID too
																				TRANSFORM({UNSIGNED6 seq, STRING20 InputIDMatchCategory, STRING10 InputIDMatchStatus},
																										SELF.seq := RIGHT.seq;
																										GoldStatus := RIGHT.sele_gold = 'G';

																										RawInputIDMatchStatus := MAP(link_search_level = Business_Risk_BIP.Constants.LinkSearch.Default => RIGHT.sele_seg,
																																								 link_search_level = Business_Risk_BIP.Constants.LinkSearch.PowID 	=> RIGHT.pow_seg,
																																								 link_search_level = Business_Risk_BIP.Constants.LinkSearch.ProxID 	=> RIGHT.prox_seg,
																																								 link_search_level = Business_Risk_BIP.Constants.LinkSearch.SeleID 	=> RIGHT.sele_seg,
																																								 link_search_level = Business_Risk_BIP.Constants.LinkSearch.OrgID 	=> RIGHT.org_seg,
																																								 link_search_level = Business_Risk_BIP.Constants.LinkSearch.UltID 	=> RIGHT.ult_seg,
																																																																														 '0');

																										SELF.InputIDMatchCategory := MAP(
																																								 RawInputIDMatchStatus = '3' 		 => Business_Risk_BIP.Constants.Category_TriCore, 				// 7 TRI CORE
																																								 RawInputIDMatchStatus = '2'		 => Business_Risk_BIP.Constants.Category_DualCore, 				// 6 DUAL CORE
																																								 RawInputIDMatchStatus = 'T'		 => Business_Risk_BIP.Constants.Category_TrustedSource,   // 5 TRUSTED SOURCE
																																								 RawInputIDMatchStatus = '1'		 => Business_Risk_BIP.Constants.Category_SingleSource,    // 3 SINGLE SOURCE
																																								 RawInputIDMatchStatus = 'E'		 => Business_Risk_BIP.Constants.Category_TrustedSingle,   // 4 SINGLE TRUSTED
																																								 RawInputIDMatchStatus = 'I'		 => Business_Risk_BIP.Constants.Category_Inactive, 				// 2 INACTIVE
																																								 RawInputIDMatchStatus = 'D'		 => Business_Risk_BIP.Constants.Category_Defunct,  				// 1 DEFUNCT
																																																										Business_Risk_BIP.Constants.Category_None); 					// 0 NONE

																										SELF.InputIDMatchStatus := calculateValueFor._InputIDMatchStatusBHeader(RawInputIDMatchStatus, GoldStatus);

																									), LEFT OUTER, LIMIT(Business_Risk_BIP.Constants.Limit_BusHeader), KEEP(1));

  withIDMatchStatus := JOIN(withAddrResInd, BusinessHeaderIDStatus, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Verification.InputIDMatchCategory := RIGHT.InputIDMatchCategory,
																							SELF.Verification.InputIDMatchStatus := RIGHT.InputIDMatchStatus,
                                              SELF.Firmographic.FirmNonProfitFlag := IF( EXISTS(LEFT.Sources(Source = Business_Risk_BIP.Constants.Src_IRS_Non_Profit)), '1', '0' ),
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

  tbl_whetherPubliclyTraded :=
    TABLE(
      BusinessHeader,
      {seq, FirmPublicFlag := IF( company_ticker != '', '1', '0' ) },
      Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(link_search_level, SeleID)
    );

  withFirmPublicFlag :=
    JOIN(
      withIDMatchStatus, tbl_whetherPubliclyTraded,
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM(Business_Risk_BIP.Layouts.Shell,
        SELF.Firmographic.FirmPublicFlag := RIGHT.FirmPublicFlag,
        SELF := LEFT
      ),
      LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW
    );

	withErrorCodes := JOIN(withFirmPublicFlag, kFetchErrorCodes, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeBusinessHeader := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(BusinessHeaderUltRaw, 100), NAMED('Sample_BusinessHeaderUltRaw'));
	// OUTPUT(CHOOSEN(BusinessHeaderUltSeq, 100), NAMED('Sample_BusinessHeaderUltSeq'));
	// OUTPUT(CHOOSEN(BusinessHeaderUlt, 100), NAMED('Sample_BusinessHeaderUlt'));
	// OUTPUT(CHOOSEN(linkIDGroups, 100), NAMED('Sample_linkIDGroups'));
	// OUTPUT(COUNT(BusinessHeader), NAMED('Total_BusinessHeader'));
	// OUTPUT(CHOOSEN(BusinessHeader, 100), NAMED('Sample_BusinessHeader'));
  // OUTPUT(CHOOSEN(Shell, 100), NAMED('Input_Shell'));
	// OUTPUT(CHOOSEN(BusinessHeaderSourceStats, 100), NAMED('Sample_BusinessHeaderSourceStats'));
	// OUTPUT(CHOOSEN(BusinessHeaderUniqueContactDIDs, 1000), NAMED('Sample_BusinessHeaderUniqueContactDIDs'));
	// OUTPUT(CHOOSEN(getBestContactInfo, 1000), NAMED('Sample_getBestContactInfo'));
	// OUTPUT(CHOOSEN(BusinessHeaderUniqueContacts, 1000), NAMED('Sample_BusinessHeaderUniqueContacts'));
	// OUTPUT(CHOOSEN(BusinessHeaderVerification, 100), NAMED('Sample_BusinessHeaderVerification'));
	// OUTPUT(CHOOSEN(BusinessHeaderVerificationRolled, 100), NAMED('Sample_BusinessHeaderVerificationRolled'));
	// OUTPUT(CHOOSEN(BusinessHeaderAllAddresses, 500), NAMED('Sample_BusinessHeaderAllAddresses'));
	// OUTPUT(CHOOSEN(BusinessHeaderUniqueAddresses, 500), NAMED('Sample_BusinessHeaderUniqueAddresses'));
	// OUTPUT(CHOOSEN(countedUniqueAddresses, 500), NAMED('Sample_countedUniqueAddresses'));
	// OUTPUT(CHOOSEN(withBusinessHeader, 100), NAMED('Sample_withBusinessHeader'));
	// OUTPUT(CHOOSEN(withBusinessHeaderVerification, 500), NAMED('Sample_withBusinessHeaderVerification'));
	// OUTPUT(CHOOSEN(withBusinessHeaderUniqueAddresses, 500), NAMED('Sample_withBusinessHeaderUniqueAddresses'));
	// OUTPUT(CHOOSEN(BusInputAddr, 500), NAMED('Sample_BusInputAddr'));
	// OUTPUT(CHOOSEN(withAdvo, 100), NAMED('Sample_withAdvo'));
	// OUTPUT(CHOOSEN(withADVODDInput, 500), NAMED('Sample_withADVODDInput'));
	// OUTPUT(CHOOSEN(withADVODD, 500), NAMED('Sample_withADVODD'));
	// OUTPUT(CHOOSEN(RollAdvoResidential, 100), NAMED('Sample_RollAdvoResidential'));
	// OUTPUT(CHOOSEN(BusinessHeaderIDStatus, 100), NAMED('Sample_BusinessHeaderIDStatus'));
	// OUTPUT(CHOOSEN(withIDMatchStatus, 100), NAMED('Sample_withIDMatchStatus'));
	// OUTPUT(CHOOSEN(withErrorCodes, 100), NAMED('Sample_withErrorCodes'));

	RETURN UNGROUP(withErrorCodes);
END;
