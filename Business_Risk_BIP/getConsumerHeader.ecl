IMPORT Address, AutoKey, Business_Risk, Data_Services, Business_Risk_BIP, DID_Add, Doxie, dx_Gong, dx_header,
       MDR, Phones, Phonesplus_v2, Risk_Indicators, Suppress, UT, Relationship, STD;

EXPORT getConsumerHeader(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);
	drm := Options.DataRestrictionMask;
	shell_version := Options.BusShellVersion;

	Shell_with_BIPIDs := Shell(BIP_IDs.PowID.LinkID <> 0 OR BIP_IDs.ProxID.LinkID <> 0 OR BIP_IDs.SeleID.LinkID <> 0 OR BIP_IDs.OrgID.LinkID <> 0 OR BIP_IDs.UltID.LinkID <> 0);

	ShellSearchLayout := RECORD
		UNSIGNED4 Seq;
		UNSIGNED3 HistoryDate;
		STRING1 RecordType;
		STRING120 CompanyName;
		STRING9 FEINSSN;
		STRING10 Phone10;
		STRING10 Prim_Range;
		STRING2 PreDir;
		STRING28 Prim_Name;
		STRING2 PostDir;
		STRING8 Sec_Range;
		STRING5 Zip5;
		STRING4 Zip4 := '';
		UNSIGNED8 fdid := 0; // Fake DID - used to search the full phones plus payload
	END;

	BusinessSearchRecords := PROJECT(IF(shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v22, Shell, Shell_with_BIPIDs), TRANSFORM(ShellSearchLayout,
		SELF.Seq := LEFT.Seq;
		SELF.RecordType := 'B';
		SELF.FEINSSN := LEFT.Clean_Input.FEIN;
		SELF := LEFT.Clean_Input,
		SELF := []));

	Rep1SearchRecords	:= PROJECT(Shell_with_BIPIDs, TRANSFORM(ShellSearchLayout,
		SELF.Seq := LEFT.Seq;
		SELF.HistoryDate := LEFT.Clean_Input.HistoryDate;
		SELF.RecordType := '1';
		SELF.CompanyName := '';
		SELF.FEINSSN := LEFT.Clean_Input.Rep_SSN;
		SELF.Phone10 := LEFT.Clean_Input.Rep_Phone10;
		SELF.Prim_Range := LEFT.Clean_Input.Rep_Prim_Range;
		SELF.PreDir := LEFT.Clean_Input.Rep_PreDir;
		SELF.Prim_Name := LEFT.Clean_Input.Rep_Prim_Name;
		SELF.PostDir := LEFT.Clean_Input.Rep_PostDir;
		SELF.Sec_Range := LEFT.Clean_Input.Rep_Sec_Range;
		SELF.Zip5 := LEFT.Clean_Input.Rep_Zip5;
		SELF.Zip4 := LEFT.Clean_Input.Rep_Zip4,
		SELF := []));

	Rep2SearchRecords	:= PROJECT(Shell_with_BIPIDs, TRANSFORM(ShellSearchLayout,
		SELF.Seq := LEFT.Seq;
		SELF.HistoryDate := LEFT.Clean_Input.HistoryDate;
		SELF.RecordType := '2';
		SELF.CompanyName := '';
		SELF.FEINSSN := LEFT.Clean_Input.Rep2_SSN;
		SELF.Phone10 := LEFT.Clean_Input.Rep2_Phone10;
		SELF.Prim_Range := LEFT.Clean_Input.Rep2_Prim_Range;
		SELF.PreDir := LEFT.Clean_Input.Rep2_PreDir;
		SELF.Prim_Name := LEFT.Clean_Input.Rep2_Prim_Name;
		SELF.PostDir := LEFT.Clean_Input.Rep2_PostDir;
		SELF.Sec_Range := LEFT.Clean_Input.Rep2_Sec_Range;
		SELF.Zip5 := LEFT.Clean_Input.Rep2_Zip5;
		SELF.Zip4 := LEFT.Clean_Input.Rep2_Zip4,
		SELF := []));

	Rep3SearchRecords	:= PROJECT(Shell_with_BIPIDs, TRANSFORM(ShellSearchLayout,
		SELF.Seq := LEFT.Seq;
		SELF.HistoryDate := LEFT.Clean_Input.HistoryDate;
		SELF.RecordType := '3';
		SELF.CompanyName := '';
		SELF.FEINSSN := LEFT.Clean_Input.Rep3_SSN;
		SELF.Phone10 := LEFT.Clean_Input.Rep3_Phone10;
		SELF.Prim_Range := LEFT.Clean_Input.Rep3_Prim_Range;
		SELF.PreDir := LEFT.Clean_Input.Rep3_PreDir;
		SELF.Prim_Name := LEFT.Clean_Input.Rep3_Prim_Name;
		SELF.PostDir := LEFT.Clean_Input.Rep3_PostDir;
		SELF.Sec_Range := LEFT.Clean_Input.Rep3_Sec_Range;
		SELF.Zip5 := LEFT.Clean_Input.Rep3_Zip5;
		SELF.Zip4 := LEFT.Clean_Input.Rep3_Zip4,
		SELF := []));


	Rep4SearchRecords	:= PROJECT(Shell_with_BIPIDs, TRANSFORM(ShellSearchLayout,
		SELF.Seq := LEFT.Seq;
		SELF.HistoryDate := LEFT.Clean_Input.HistoryDate;
		SELF.RecordType := '4';
		SELF.CompanyName := '';
		SELF.FEINSSN := LEFT.Clean_Input.Rep4_SSN;
		SELF.Phone10 := LEFT.Clean_Input.Rep4_Phone10;
		SELF.Prim_Range := LEFT.Clean_Input.Rep4_Prim_Range;
		SELF.PreDir := LEFT.Clean_Input.Rep4_PreDir;
		SELF.Prim_Name := LEFT.Clean_Input.Rep4_Prim_Name;
		SELF.PostDir := LEFT.Clean_Input.Rep4_PostDir;
		SELF.Sec_Range := LEFT.Clean_Input.Rep4_Sec_Range;
		SELF.Zip5 := LEFT.Clean_Input.Rep4_Zip5;
		SELF.Zip4 := LEFT.Clean_Input.Rep4_Zip4,
		SELF := []));

	Rep5SearchRecords	:= PROJECT(Shell_with_BIPIDs, TRANSFORM(ShellSearchLayout,
		SELF.Seq := LEFT.Seq;
		SELF.HistoryDate := LEFT.Clean_Input.HistoryDate;
		SELF.RecordType := '5';
		SELF.CompanyName := '';
		SELF.FEINSSN := LEFT.Clean_Input.Rep5_SSN;
		SELF.Phone10 := LEFT.Clean_Input.Rep5_Phone10;
		SELF.Prim_Range := LEFT.Clean_Input.Rep5_Prim_Range;
		SELF.PreDir := LEFT.Clean_Input.Rep5_PreDir;
		SELF.Prim_Name := LEFT.Clean_Input.Rep5_Prim_Name;
		SELF.PostDir := LEFT.Clean_Input.Rep5_PostDir;
		SELF.Sec_Range := LEFT.Clean_Input.Rep5_Sec_Range;
		SELF.Zip5 := LEFT.Clean_Input.Rep5_Zip5;
		SELF.Zip4 := LEFT.Clean_Input.Rep5_Zip4,
		SELF := []));

	ShellSearchRecords := BusinessSearchRecords + Rep1SearchRecords + Rep2SearchRecords + Rep3SearchRecords + Rep4SearchRecords + Rep5SearchRecords ;

	seqContactInfo := NORMALIZE(Shell_with_BIPIDs, LEFT.ContactDIDs, TRANSFORM(Business_Risk_BIP.Layouts.LayoutContacts, SELF := RIGHT));

	// --------------- Consumer Header Build Date ----------------
	CHBuildDate := Risk_Indicators.get_Build_date('header_build_version');

	// ---------------- Consumer Header - By Address ------------------
	tempConsumerHeaderAddrAttributes := RECORD
		UNSIGNED4 Seq;
		UNSIGNED3 HistoryDate;
		UNSIGNED3 Dt_First_Seen;
    UNSIGNED3 Dt_Last_Seen;
		STRING   CompanyName;
		INTEGER1 BusAddrConsumerFirstName;
		INTEGER1 BusAddrConsumerLastName;
		INTEGER1 BusAddrConsumerFullName;
		INTEGER1 BusAddrLinkPersonName;
    STRING VerifiedConsumerName;
    STRING VerifiedConsumerAddress1;
    STRING VerifiedConsumerCity;
    STRING VerifiedConsumerState;
    STRING  VerifiedConsumerZip;
		INTEGER1 AR2BRep1AddrAssociateCHeader;
		INTEGER1 AR2BRep2AddrAssociateCHeader;
		INTEGER1 AR2BRep3AddrAssociateCHeader;
		INTEGER1 AR2BRep4AddrAssociateCHeader;
		INTEGER1 AR2BRep5AddrAssociateCHeader;
    UNSIGNED4 Global_sid;
    UNSIGNED8 Record_sid;
		DATASET({UNSIGNED6 LexID}) LexIDs;
		DATASET({UNSIGNED4 Seq, BOOLEAN Rep1AddrMatched, BOOLEAN Rep2AddrMatched, BOOLEAN Rep3AddrMatched, BOOLEAN Rep4AddrMatched, BOOLEAN Rep5AddrMatched, STRING20 FName, STRING20 LName}) RepNames;
	END;

  key_header_address := dx_header.key_header_address();
	tempConsumerHeaderAddrAttributes getConsumerHeaderAddrAttributes(ShellSearchLayout le, key_header_address ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.HistoryDate := le.HistoryDate;
		SELF.Dt_First_Seen := ri.Dt_First_Seen;
		SELF.CompanyName := le.CompanyName;

		// ----- Check which input address we matched on so we can use record in the correct attributes ----- //
		BusinessAddrMatch := le.RecordType = 'B';
		Rep1AddrMatch := le.RecordType = '1';
		Rep2AddrMatch := le.RecordType = '2';
		Rep3AddrMatch := le.RecordType = '3';
		Rep4AddrMatch := le.RecordType = '4';
		Rep5AddrMatch := le.RecordType = '5';

		// ----------------------- Compare results to business input ---------------------------------------- //

		// Make sure the first and last name are at least 2 characters long so that we aren't comparing blank or 1 character names to the company name
		fNameHit_old := BusinessAddrMatch AND LENGTH(TRIM(ri.fname)) >= 2 AND STD.Str.Find(le.CompanyName, STD.Str.ToUpperCase(TRIM(ri.fname, LEFT, RIGHT)), 1) > 0;
		lNameHit_old := BusinessAddrMatch AND LENGTH(TRIM(ri.lname)) >= 2 AND STD.Str.Find(le.CompanyName, STD.Str.ToUpperCase(TRIM(ri.lname, LEFT, RIGHT)), 1) > 0;

		fNameHit_new := BusinessAddrMatch AND Business_Risk_BIP.Common.fn_isFoundInCompanyName( le.CompanyName, ri.fname );
		lNameHit_new := BusinessAddrMatch AND Business_Risk_BIP.Common.fn_isFoundInCompanyName( le.CompanyName, ri.lname );

		fNameHit := IF( shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v22, fNameHit_new, fNameHit_old );
		lNameHit := IF( shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v22, lNameHit_new, lNameHit_old );

		DIDhit := BusinessAddrMatch AND ri.did <> 0;

		SELF.BusAddrConsumerFirstName := MAP(TRIM(ri.fname) = '' OR TRIM(le.CompanyName) = ''	OR NOT BusinessAddrMatch 												=> 0,  // No hit
																				 fNameHit	AND BusinessAddrMatch																						 												=> 1, // Address linked to a person with the same first name as part of entered CompanyName
																																																																						 0); // Name/Address was not linked
		SELF.BusAddrConsumerLastName := MAP(TRIM(ri.lname) = '' OR TRIM(le.CompanyName) = ''	OR NOT BusinessAddrMatch											  => 0,  // No hit
																				lNameHit	AND BusinessAddrMatch																																		=> 1,  // Address linked to a person with the same last name as part of entered CompanyName
																																																																						 0); // Name/Address was not linked

		SELF.BusAddrConsumerFullName := MAP(TRIM(ri.fname) = '' OR TRIM(ri.lname) = '' OR TRIM(le.CompanyName) = ''	OR NOT BusinessAddrMatch	=> 0,  // No hit
																				fNameHit AND lNameHit	AND BusinessAddrMatch																												=> 1,  // Address linked to a person with the same first and last name as part of entered CompanyName
																																																																						 0); // Name/Address was not linked

    SELF.VerifiedConsumerName := IF((fNameHit OR lNameHit)	AND BusinessAddrMatch AND DIDhit, TRIM(ri.fname)+' '+TRIM(ri.lname), '');
    SELF.VerifiedConsumerAddress1 := IF(BusinessAddrMatch, Address.Addr1FromComponents(ri.prim_range, ri.predir, ri.prim_name, ri.suffix, ri.postdir, ri.unit_desig, ri.sec_range), '');
    SELF.VerifiedConsumerCity := IF(BusinessAddrMatch, ri.city_name, '');
    SELF.VerifiedConsumerState := IF(BusinessAddrMatch, ri.st, '');
    SELF.VerifiedConsumerZip := IF(BusinessAddrMatch, ri.zip, '');

		SELF.BusAddrLinkPersonName := MAP((TRIM(le.Prim_Name) = '' AND TRIM(le.Prim_Range) = '' AND
																			 TRIM(LE.Zip5) = '')    OR TRIM(le.CompanyName) = ''	OR NOT BusinessAddrMatch 																							 => 0,  // No business name or address
																			NOT DIDHit	AND BusinessAddrMatch																						 																								 => 0,  // No hit
																			 NOT fNameHit AND NOT lNameHit AND BusinessAddrMatch														 																						 => 1,
																			 fNameHit AND lNameHit AND BusinessAddrMatch	 														 																									 => 2, // Address linked to a person with the same first and last name as part of entered CompanyName
																			 (fnameHit OR lNameHit) AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v22 AND BusinessAddrMatch => 2, // In v2.2 and above, a first OR last name match constitutes a match
																																																																																			0);
		SELF.LexIDs := IF((INTEGER)ut.DaysApart(Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.dt_last_seen, Business_Risk_BIP.Constants.MissingDate, le.HistoryDate),
																						Business_Risk_BIP.Common.todaysDate(CHBuildDate, le.HistoryDate)) <= Business_Risk_BIP.Constants.TwoYear AND ri.DID > 0 AND BusinessAddrMatch,
												DATASET([{ri.DID}], {UNSIGNED6 LexID}),
												DATASET([], {UNSIGNED6 LexID}));

	// ----- Collect Names Associated with Rep Addresses to compare to associates for business header ----- //
		SELF.RepNames := IF(Rep1AddrMatch OR Rep2AddrMatch OR Rep3AddrMatch OR Rep4AddrMatch OR Rep5AddrMatch,
												DATASET([{le.Seq, Rep1AddrMatch, Rep2AddrMatch, Rep3AddrMatch, Rep4AddrMatch, Rep5AddrMatch, ri.fname, ri.lname}],
															{UNSIGNED4 Seq, BOOLEAN Rep1AddrMatched, BOOLEAN Rep2AddrMatched, BOOLEAN Rep3AddrMatched, BOOLEAN Rep4AddrMatched, BOOLEAN Rep5AddrMatched, STRING20 FName, STRING20 LName}),
												DATASET([], {UNSIGNED4 Seq, BOOLEAN Rep1AddrMatched, BOOLEAN Rep2AddrMatched, BOOLEAN Rep3AddrMatched,  BOOLEAN Rep4AddrMatched, BOOLEAN Rep5AddrMatched, STRING20 FName, STRING20 LName}));
    SELF.global_sid := ri.global_sid;
    SELF.record_sid := ri.record_sid;
		SELF := []
	END;


	ConsumerHeaderAddrRaw_all := JOIN(ShellSearchRecords, key_header_address,
																		(TRIM(LEFT.Prim_Name) <> '' AND TRIM(LEFT.Zip5) <> '' AND
																		KEYED(LEFT.Prim_Name = RIGHT.prim_name AND LEFT.Zip5 = RIGHT.zip AND LEFT.Prim_Range = RIGHT.prim_range) AND
																		LEFT.PreDir = RIGHT.predir AND LEFT.PostDir = RIGHT.postdir AND
																		UT.NNEQ(LEFT.Sec_Range, RIGHT.sec_range)) AND
																	// check permissions
																		doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, right.src, right.dt_first_seen) and
																		RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources(drm, FALSE /*isFCRA*/) AND
																		(MDR.Source_is_DPPA(RIGHT.src) = FALSE OR
																			(mod_access.isValidDppa() AND mod_access.isValidDppaState(dx_header.functions.TranslateSource(RIGHT.src), RIGHT.src))) AND
																		Risk_Indicators.iid_constants.filtered_source(RIGHT.src, RIGHT.st) = FALSE,
																	getConsumerHeaderAddrAttributes(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	ConsumerHeaderAddrRaw:= Suppress.MAC_SuppressSource(ConsumerHeaderAddrRaw_all, mod_access, LexIDs[1].LexID); // There’s no more than one LexId here //
	// Filter out records after our history date
	ConsumerHeaderAddr := Business_Risk_BIP.Common.FilterRecords(ConsumerHeaderAddrRaw, Dt_First_Seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, '', AllowedSourcesSet);

	// Determine the maximum level of verification
	ConsumerHeaderAddrStats := ROLLUP(SORT(ConsumerHeaderAddr, Seq, -dt_last_seen, dt_first_seen, RECORD), LEFT.Seq = RIGHT.Seq, TRANSFORM(tempConsumerHeaderAddrAttributes,
																							SELF.BusAddrConsumerFirstName	:= MAX(LEFT.BusAddrConsumerFirstName, RIGHT.BusAddrConsumerFirstName);
																							SELF.BusAddrConsumerLastName	:= MAX(LEFT.BusAddrConsumerLastName, RIGHT.BusAddrConsumerLastName);
																							SELF.BusAddrConsumerFullName	:= MAX(LEFT.BusAddrConsumerFullName, RIGHT.BusAddrConsumerFullName);
																							SELF.BusAddrLinkPersonName	:= MAX(LEFT.BusAddrLinkPersonName, RIGHT.BusAddrLinkPersonName);
																							SELF.VerifiedConsumerName := IF(LEFT.VerifiedConsumerName <> '', LEFT.VerifiedConsumerName, RIGHT.VerifiedConsumerName);
                                              LeftAddrPopulated := LEFT.VerifiedConsumerAddress1 <> '' AND LEFT.VerifiedConsumerZip <> '';
                                              SELF.VerifiedConsumerAddress1 := IF(LeftAddrPopulated, LEFT.VerifiedConsumerAddress1, RIGHT.VerifiedConsumerAddress1);
                                              SELF.VerifiedConsumerCity := IF(LeftAddrPopulated, LEFT.VerifiedConsumerCity, RIGHT.VerifiedConsumerCity);
                                              SELF.VerifiedConsumerState := IF(LeftAddrPopulated, LEFT.VerifiedConsumerState, RIGHT.VerifiedConsumerState);
                                              SELF.VerifiedConsumerZip := IF(LeftAddrPopulated, LEFT.VerifiedConsumerZip, RIGHT.VerifiedConsumerZip);
                                              SELF.LexIDs := LEFT.LexIDs + RIGHT.LexIDs;
																							SELF.RepNames := LEFT.RepNames + RIGHT.RepNames;
																							SELF := LEFT));

	withConsumerHeaderAddr := JOIN(Shell, ConsumerHeaderAddrStats, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Verification.BusAddrConsumerFirstName := (STRING)RIGHT.BusAddrConsumerFirstName;
																							SELF.Verification.BusAddrConsumerLastName := (STRING)RIGHT.BusAddrConsumerLastName;
																							SELF.Verification.BusAddrConsumerFullName := (STRING)RIGHT.BusAddrConsumerFullName;
																							// If running business shell version 2.2 or above, make sure we're setting BusAddrPersonNameOverlap to -1 if input address or company name isn't populated.
																							BusAddrPersonNameOverlap_v22 := IF(TRIM(LEFT.Clean_Input.Zip5) = '' OR TRIM(LEFT.Clean_Input.Prim_Name) = '' OR TRIM(LEFT.Clean_Input.CompanyName) = '', -1, RIGHT.BusAddrLinkPersonName);
																							SELF.Business_To_Person_Link.BusAddrPersonNameOverlap := IF(shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v22, (STRING)BusAddrPersonNameOverlap_v22, (STRING)RIGHT.BusAddrLinkPersonName);
																							SELF.Verification.VerifiedConsumerName := RIGHT.VerifiedConsumerName;
                                              SELF.Verification.VerifiedConsumerAddress1 := RIGHT.VerifiedConsumerAddress1;
                                              SELF.Verification.VerifiedConsumerCity := RIGHT.VerifiedConsumerCity;
                                              SELF.Verification.VerifiedConsumerState := RIGHT.VerifiedConsumerState;
                                              SELF.Verification.VerifiedConsumerZip := RIGHT.VerifiedConsumerZip;
                                              uniqueLexIDs := DEDUP(SORT(RIGHT.LexIDs, LexID), LexID);
																							SELF.Input_Characteristics.InputAddrConsumerCount := (STRING)Business_Risk_BIP.Common.capNum(COUNT(uniqueLexIDs), -1, 99999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	ConsumerHeaderRepAddr :=  NORMALIZE(ConsumerHeaderAddr, LEFT.RepNames,
																	TRANSFORM({UNSIGNED4 Seq, BOOLEAN Rep1AddrMatched, BOOLEAN Rep2AddrMatched, BOOLEAN Rep3AddrMatched, BOOLEAN Rep4AddrMatched, BOOLEAN Rep5AddrMatched, STRING20 FName, STRING20 LName},
																							SELF := RIGHT));

	ConsumerHeaderRepAddrMatches := JOIN(seqContactInfo, ConsumerHeaderRepAddr, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(tempConsumerHeaderAddrAttributes,
																							SELF.Seq := LEFT.Seq,
																							FirstNameMatched := TRIM(LEFT.FName) <> '' AND TRIM(RIGHT.FName) <> '' AND STD.Str.Find(RIGHT.fname, LEFT.FName, 1) > 0;
																							LastNameMatched := TRIM(LEFT.LName) <> '' AND TRIM(RIGHT.LName) <> '' AND STD.Str.Find(RIGHT.lname, LEFT.LName, 1) > 0;
																							FullNameMatched	:= (FirstNameMatched AND LastNameMatched);
																							SELF.AR2BRep1AddrAssociateCHeader := IF(RIGHT.Rep1AddrMatched AND FullNameMatched, 1, 0);
																							SELF.AR2BRep2AddrAssociateCHeader := IF(RIGHT.Rep2AddrMatched AND FullNameMatched, 1, 0);
																							SELF.AR2BRep3AddrAssociateCHeader := IF(RIGHT.Rep3AddrMatched AND FullNameMatched, 1, 0);
																							SELF.AR2BRep4AddrAssociateCHeader := IF(RIGHT.Rep4AddrMatched AND FullNameMatched, 1, 0);
																							SELF.AR2BRep5AddrAssociateCHeader := IF(RIGHT.Rep5AddrMatched AND FullNameMatched, 1, 0);
																							SELF := []),
																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	RollConsumerHeaderRepAddrMatches := ROLLUP(SORT(ConsumerHeaderRepAddrMatches, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(tempConsumerHeaderAddrAttributes,
																							SELF.Seq := LEFT.Seq,
																							SELF.AR2BRep1AddrAssociateCHeader := MAX(LEFT.AR2BRep1AddrAssociateCHeader, RIGHT.AR2BRep1AddrAssociateCHeader);
																							SELF.AR2BRep2AddrAssociateCHeader := MAX(LEFT.AR2BRep2AddrAssociateCHeader, RIGHT.AR2BRep2AddrAssociateCHeader);
																							SELF.AR2BRep3AddrAssociateCHeader := MAX(LEFT.AR2BRep3AddrAssociateCHeader, RIGHT.AR2BRep3AddrAssociateCHeader);
																							SELF.AR2BRep4AddrAssociateCHeader := MAX(LEFT.AR2BRep4AddrAssociateCHeader, RIGHT.AR2BRep4AddrAssociateCHeader);
																							SELF.AR2BRep5AddrAssociateCHeader := MAX(LEFT.AR2BRep5AddrAssociateCHeader, RIGHT.AR2BRep5AddrAssociateCHeader);
																							SELF := []));

	WithConsumerHeaderRepAddrMatches := JOIN(withConsumerHeaderAddr, RollConsumerHeaderRepAddrMatches, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							Rep1AddrPopulated := TRIM(LEFT.Clean_Input.Rep_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep_Zip5) <> '';
																							SELF.Business_To_Executive_Link.AR2BRep1AddrAssociateCHeader := IF(Rep1AddrPopulated, (STRING)RIGHT.AR2BRep1AddrAssociateCHeader, '-1');
																							Rep2AddrPopulated := TRIM(LEFT.Clean_Input.Rep2_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep2_Zip5) <> '';
																							SELF.Business_To_Executive_Link.AR2BRep2AddrAssociateCHeader := IF(Rep2AddrPopulated, (STRING)RIGHT.AR2BRep2AddrAssociateCHeader, '-1');
																							Rep3AddrPopulated := TRIM(LEFT.Clean_Input.Rep3_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep3_Zip5) <> '';
																							SELF.Business_To_Executive_Link.AR2BRep3AddrAssociateCHeader := IF(Rep3AddrPopulated, (STRING)RIGHT.AR2BRep3AddrAssociateCHeader, '-1');
																							Rep4AddrPopulated := TRIM(LEFT.Clean_Input.Rep4_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep4_Zip5) <> '';
																							SELF.Business_To_Executive_Link.AR2BRep4AddrAssociateCHeader := IF(Rep4AddrPopulated, (STRING)RIGHT.AR2BRep4AddrAssociateCHeader, '-1');
																							Rep5AddrPopulated := TRIM(LEFT.Clean_Input.Rep5_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep5_Zip5) <> '';
																							SELF.Business_To_Executive_Link.AR2BRep5AddrAssociateCHeader := IF(Rep5AddrPopulated, (STRING)RIGHT.AR2BRep5AddrAssociateCHeader, '-1');

																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);


	// ---------------- Consumer Header - By SSN (Pretending that FEIN is SSN) ------------------	//
	INTEGER1 calcBNAS(BOOLEAN AddressMatched, BOOLEAN NameSimilar) :=
			MAP(AddressMatched = TRUE AND NameSimilar = FALSE	=> 1, // FEIN Matches consumer SSN with a matching Address, but Name NOT similar to Company Name
					AddressMatched = FALSE AND NameSimilar = TRUE	=> 2, // FEIN Matches consumer SSN with a Name Similar to to Company Name, but Address does NOT match
					AddressMatched = TRUE AND NameSimilar = TRUE	=> 3, // FEIN Matches consumer SSN with a Name Similar to to Company Name and matches Address
																													 0); // Nothing Verified

	tempHeaderRec := RECORD
		// Input values
		UNSIGNED4	Seq;
		UNSIGNED3	HistoryDate;
		STRING1 RecordType;
		STRING120	CompanyName;
		STRING10	Phone10;
		STRING9		FEIN;
		STRING10	Prim_Range;
		STRING2		PreDir;
		STRING28	Prim_Name;
		STRING4		Addr_Suffix;
		STRING2		PostDir;
		STRING10	Unit_Desig;
		STRING8		Sec_Range;
		STRING25	City;
		STRING2		State;
		STRING5		Zip5;
		STRING4 	Zip4;
		STRING9 	Rep1_SSN;
		STRING9 	Rep2_SSN;
		STRING9 	Rep3_SSN;
		STRING9 	Rep4_SSN;
		STRING9 	Rep5_SSN;

		// Track FEIN Matches separately from Rep Matches
		BOOLEAN		FEINMatched;
		BOOLEAN		Rep1SSNMatched;
		BOOLEAN		Rep2SSNMatched;
		BOOLEAN		Rep3SSNMatched;
		BOOLEAN		Rep4SSNMatched;
		BOOLEAN		Rep5SSNMatched;

		// Header Values
		UNSIGNED6 DID;
		UNSIGNED6 HHID;
		STRING8 dt_first_seen;
    STRING8 dt_last_seen;
		STRING20 fname;
		STRING20 lname;
		INTEGER2 BusFEINPersonOverlap;
		INTEGER2 BusFEINPersonAddrOverlap;
		INTEGER1 BusFEINPersonPhoneOverlap;
		INTEGER1 FEINPersonNameMatchLevel;
		INTEGER1 FEINPersonAddrMatchLevel;
		INTEGER1 BNASRaw;
		INTEGER1 AddressMatched;
		INTEGER1 NameSimilar;
    STRING VerifiedConsumerAddress1;
    STRING VerifiedConsumerCity;
    STRING VerifiedConsumerState;
    STRING  VerifiedConsumerZip;
    STRING VerifiedConsumerFEIN;
    STRING VerifiedConsumerPhone;
    UNSIGNED4 global_sid;
    UNSIGNED8 record_sid;
	END;

	key_header_ssn := dx_header.key_ssn();
	tempHeaderRec getDIDs(ShellSearchLayout le, key_header_ssn ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.RecordType := le.RecordType;
		SELF.DID := ri.DID;
		SELF.FEINMatched := le.RecordType = 'B' AND ri.DID > 0;
		SELF.Rep1SSNMatched := le.RecordType = '1' AND ri.DID > 0;
		SELF.Rep2SSNMatched := le.RecordType = '2' AND ri.DID > 0;
		SELF.Rep3SSNMatched := le.RecordType = '3' AND ri.DID > 0;
		SELF.Rep4SSNMatched := le.RecordType = '4' AND ri.DID > 0;
		SELF.Rep5SSNMatched := le.RecordType = '5' AND ri.DID > 0;

		SELF.FEIN := IF(le.RecordType = 'B', le.FEINSSN, '');
		SELF.Rep1_SSN := IF(le.RecordType = '1', le.FEINSSN, '');
		SELF.Rep2_SSN := IF(le.RecordType = '2', le.FEINSSN, '');
		SELF.Rep3_SSN := IF(le.RecordType = '3', le.FEINSSN, '');
		SELF.Rep4_SSN := IF(le.RecordType = '4', le.FEINSSN, '');
		SELF.Rep5_SSN := IF(le.RecordType = '5', le.FEINSSN, '');

		// Grab the cleaned input fields for everything else
		SELF := le;
		SELF := [];
	END;

	// Grab all DID's associated with that SSN (FEIN)
	FEINSSN_DIDs := JOIN(ShellSearchRecords, key_header_ssn, //Input Business FEIN Matches Header SSN
																	(INTEGER)LEFT.FEINSSN > 0 AND LENGTH(TRIM(LEFT.FEINSSN)) = 9 AND
																	KEYED(LEFT.FEINSSN[1] = RIGHT.S1 AND
																				LEFT.FEINSSN[2] = RIGHT.S2 AND
																				LEFT.FEINSSN[3] = RIGHT.S3 AND
																				LEFT.FEINSSN[4] = RIGHT.S4 AND
																				LEFT.FEINSSN[5] = RIGHT.S5 AND
																				LEFT.FEINSSN[6] = RIGHT.S6 AND
																				LEFT.FEINSSN[7] = RIGHT.S7 AND
																				LEFT.FEINSSN[8] = RIGHT.S8 AND
																				LEFT.FEINSSN[9] = RIGHT.S9),
																	getDIDs(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	// Keep the unique DID's per sequence
	// Include -RecordType in the SORT so business records are on top in order to preserve input business data to compare against header.
	// Then we manually preserve the Rep inputs needed later for comparisons (Input Rep SSN and Input Rep Phone)
	uniqueDIDs := ROLLUP(SORT(FEINSSN_DIDs, Seq, DID, -RecordType), LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID,
																	TRANSFORM(tempHeaderRec,
																						  SELF.Seq := LEFT.Seq,
																							SELF.FEINMatched := LEFT.FEINMatched OR RIGHT.FEINMatched,
																							SELF.FEIN := MAP(LEFT.FEINMatched 			 => LEFT.FEIN,
																																RIGHT.FEINMatched 		 => RIGHT.FEIN,
																																													''),
																							SELF.Rep1_SSN := MAP(LEFT.Rep1SSNMatched => LEFT.Rep1_SSN,
																																RIGHT.Rep1SSNMatched 	 => RIGHT.Rep1_SSN,
																																													''),
																							SELF.Rep2_SSN := MAP(LEFT.Rep2SSNMatched => LEFT.Rep2_SSN,
																																RIGHT.Rep2SSNMatched 	 => RIGHT.Rep2_SSN,
																																													''),
																							SELF.Rep3_SSN := MAP(LEFT.Rep3SSNMatched => LEFT.Rep3_SSN,
																																RIGHT.Rep3SSNMatched 	 => RIGHT.Rep3_SSN,
																																													''),
																							SELF.Rep4_SSN := MAP(LEFT.Rep4SSNMatched => LEFT.Rep4_SSN,
																																RIGHT.Rep4SSNMatched 	 => RIGHT.Rep4_SSN,
																																													''),
																							SELF.Rep5_SSN := MAP(LEFT.Rep5SSNMatched => LEFT.Rep5_SSN,
																																RIGHT.Rep5SSNMatched 	 => RIGHT.Rep5_SSN,
																																													''),

																							SELF.Rep1SSNMatched := LEFT.Rep1SSNMatched OR RIGHT.Rep1SSNMatched,
																							SELF.Rep2SSNMatched := LEFT.Rep2SSNMatched OR RIGHT.Rep2SSNMatched,
																							SELF.Rep3SSNMatched := LEFT.Rep3SSNMatched OR RIGHT.Rep3SSNMatched,
																							SELF.Rep4SSNMatched := LEFT.Rep4SSNMatched OR RIGHT.Rep4SSNMatched,
																							SELF.Rep5SSNMatched := LEFT.Rep5SSNMatched OR RIGHT.Rep5SSNMatched,

																							SELF := LEFT));


	// Determine if the Address or Phone number from the consumer header matches the input Business Address or Phone, but only when the SSN matches the input SSN (Handled in join)
	tempHeaderRec getConsumerHeaderDID(tempHeaderRec le, dx_header.layout_key_header ri) := TRANSFORM
		SELF.dt_first_seen  := IF(ri.dt_first_seen > 0, (STRING)ri.dt_first_seen, (STRING)ri.dt_vendor_first_reported);
		IsBusinessRecord 	  := le.FEINMatched;
		FEINMatched 			  := (INTEGER)le.FEIN > 0 AND le.FEIN = ri.SSN AND IsBusinessRecord;
		SELF.FEINMatched 	  := FEINMatched;
		Rep1SSNMatched 		  := (INTEGER)le.Rep1_SSN > 0 AND le.Rep1_SSN = ri.SSN AND le.Rep1SSNMatched;
		SELF.Rep1SSNMatched := Rep1SSNMatched;
		Rep2SSNMatched 			:= (INTEGER)le.Rep2_SSN > 0 AND le.Rep2_SSN = ri.SSN AND le.Rep2SSNMatched;
		SELF.Rep2SSNMatched := Rep2SSNMatched;
		Rep3SSNMatched 			:= (INTEGER)le.Rep3_SSN > 0 AND le.Rep3_SSN = ri.SSN AND le.Rep3SSNMatched;
		SELF.Rep3SSNMatched := Rep3SSNMatched;
		Rep4SSNMatched 			:= (INTEGER)le.Rep4_SSN > 0 AND le.Rep4_SSN = ri.SSN AND le.Rep4SSNMatched;
		SELF.Rep4SSNMatched := Rep4SSNMatched;
		Rep5SSNMatched 			:= (INTEGER)le.Rep5_SSN > 0 AND le.Rep5_SSN = ri.SSN AND le.Rep5SSNMatched;
		SELF.Rep5SSNMatched := Rep5SSNMatched;


		fNameHit_old := FEINMatched AND LENGTH(TRIM(ri.fname)) >= 2 AND STD.Str.Find(le.CompanyName, STD.Str.ToUpperCase(TRIM(ri.fname, LEFT, RIGHT)), 1) > 0;
		lNameHit_old := FEINMatched AND LENGTH(TRIM(ri.lname)) >= 2 AND STD.Str.Find(le.CompanyName, STD.Str.ToUpperCase(TRIM(ri.lname, LEFT, RIGHT)), 1) > 0;

		fNameHit_new := FEINMatched AND Business_Risk_BIP.Common.fn_isFoundInCompanyName( le.CompanyName, ri.fname );
		lNameHit_new := FEINMatched AND Business_Risk_BIP.Common.fn_isFoundInCompanyName( le.CompanyName, ri.lname );

		fNameHit := IF( shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v22, fNameHit_new, fNameHit_old );
		lNameHit := IF( shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v22, lNameHit_new, lNameHit_old );

		NameSimilar 				:= fNameHit OR lNameHit;
		NamePopulated 			:= TRIM(le.CompanyName) <> '';
		AddressPopulated		:= TRIM(le.Prim_Name) <> '' AND TRIM(le.Zip5) <> '';
		ZIPScore						:= IF(FEINMatched, Risk_Indicators.AddrScore.ZIP_Score(le.Zip5, ri.Zip), 255);
		CityStateScore			:= IF(FEINMatched, Risk_Indicators.AddrScore.CityState_Score(le.City, le.State, ri.city_name, ri.st, ''), 255);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated AND FEINMatched;
		AddressMatched			:= Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(le.Prim_Range, le.Prim_Name, le.Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)) AND AddressPopulated AND FEINMatched;
		AddressNear 				:= IF(le.zip5 = '' OR ri.zip = '' , FALSE, Ut.calcGeoDistance(le.zip5 + le.zip4, ri.zip + ri.zip4) <= 15);
		PhonePopulated			:= TRIM(le.Phone10) <> '';
		PhoneMatched				:= Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Phone10, ri.Phone)) AND PhonePopulated AND FEINMatched;

		SELF.BusFEINPersonOverlap := MAP((INTEGER)LE.FEIN = 0 OR NOT IsBusinessRecord																			 		=> 0,
																				(INTEGER)ri.did = 0 OR NOT FEINMatched 																				 		=> 0,
																				(INTEGER)ri.did <> 0 AND FEINMatched 	 																				 		=> 1,
																																																														 -1);

		SELF.BusFEINPersonAddrOverlap := MAP(FEINMatched AND NOT AddressPopulated 							 													 		=> -1,
																				(INTEGER)LE.FEIN = 0	OR NOT IsBusinessRecord	     														 		=> -2, // -2s will be set to 0, but need something smaller than -1 since -1 should take precedence in MAX() in Rollup.
																				(INTEGER)ri.did = 0 OR NOT FEINMatched AND AddressPopulated 								   		=> -2,
																				(INTEGER)ri.did <> 0  AND NOT AddressMatched AND FEINMatched AND AddressPopulated => 1,
																				(INTEGER)ri.did <> 0  AND AddressMatched AND FEINMatched AND AddressPopulated  		=> 2,
																																																														 -1);

		SELF.BusFEINPersonPhoneOverlap := MAP(FEINMatched AND NOT PhonePopulated 								 													 		=> -1,
																				(INTEGER)LE.FEIN = 0 OR NOT IsBusinessRecord 					 												 		=> -2,
																				(INTEGER)ri.did = 0 OR NOT FEINMatched AND PhonePopulated											 		=> -2,
																				(INTEGER)ri.did <> 0  AND NOT PhoneMatched AND FEINMatched AND PhonePopulated  		=> 1,
																				(INTEGER)ri.did <> 0  AND PhoneMatched AND FEINMatched AND PhonePopulated  		 		=> 2,
																																																														 -1);

		SELF.FEINPersonNameMatchLevel := IF((INTEGER)ri.did <> 0 AND NameSimilar AND FEINMatched, 1, 0);

		SELF.FEINPersonAddrMatchLevel := IF((INTEGER)ri.did <> 0 AND AddressNear AND FEINMatched, 1, 0);

    SELF.VerifiedConsumerAddress1 := IF(FEINMatched AND AddressMatched, Address.Addr1FromComponents(ri.prim_range, ri.predir, ri.prim_name, ri.suffix, ri.postdir, ri.unit_desig, ri.sec_range), '');
    SELF.VerifiedConsumerCity := IF(FEINMatched AND AddressMatched, ri.city_name, '');
    SELF.VerifiedConsumerState := IF(FEINMatched AND AddressMatched, ri.st, '');
    SELF.VerifiedConsumerZip := IF(FEINMatched AND AddressMatched, ri.zip, '');
    SELF.VerifiedConsumerFEIN := IF(FEINMatched, ri.SSN, '');
    SELF.VerifiedConsumerPhone := IF(FEINMatched AND PhoneMatched, ri.Phone, '');


		SELF.HHID := ri.HHID;
		SELF.fname := ri.fname;
		SELF.lname := ri.lname;
		SELF.BNASRaw := calcBNAS(AddressMatched, NameSimilar);
		SELF.AddressMatched := IF(AddressMatched, 1, 0); // Need to convert to integers so that the TABLE can grab the MAX of these, similar to a rollup with an OR statement
		SELF.NameSimilar := IF(NameSimilar, 1, 0);
		SELF.global_sid := ri.global_sid;
		SELF.record_sid := ri.record_sid;

		SELF := le;
		SELF := [];
	END;
	ConsumerHeaderDIDRaw_all := JOIN(uniqueDIDs, dx_header.Key_Header(), LEFT.DID > 0 AND KEYED(LEFT.DID = RIGHT.S_DID) AND
																			(((INTEGER)LEFT.FEIN > 0 AND LEFT.FEIN = RIGHT.SSN) OR
																			((INTEGER)LEFT.Rep1_SSN > 0 AND LEFT.Rep1_SSN = RIGHT.SSN) OR
																			((INTEGER)LEFT.Rep2_SSN > 0 AND LEFT.Rep2_SSN = RIGHT.SSN) OR
																			((INTEGER)LEFT.Rep3_SSN > 0 AND LEFT.Rep3_SSN = RIGHT.SSN) OR
																			((INTEGER)LEFT.Rep4_SSN > 0 AND LEFT.Rep4_SSN = RIGHT.SSN) OR
																			((INTEGER)LEFT.Rep5_SSN > 0 AND LEFT.Rep5_SSN = RIGHT.SSN)) AND // Only keep header records that match our input Rep SSN/Busienss FEIN
																			// check permissions
																			doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, right.src, right.dt_first_seen) and
																			RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources(drm, FALSE /*isFCRA*/) AND
																			(MDR.Source_is_DPPA(RIGHT.src) = FALSE OR
																				(mod_access.isValidDppa() AND mod_access.isValidDppaState(dx_header.functions.TranslateSource(RIGHT.src), RIGHT.src))) AND
																			Risk_Indicators.iid_constants.filtered_source(RIGHT.src, RIGHT.st) = FALSE,
																	getConsumerHeaderDID(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	ConsumerHeaderDIDRaw:= Suppress.MAC_SuppressSource(ConsumerHeaderDIDRaw_all, mod_access);

	// Filter out records after our history date
	ConsumerHeaderDID := Business_Risk_BIP.Common.FilterRecords(ConsumerHeaderDIDRaw, Dt_First_Seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, '', AllowedSourcesSet);

	// Determine if any records matched per Seq/DID
  ConsumerHeaderDIDStats := ROLLUP(SORT(ConsumerHeaderDID, seq, DID, RECORD), LEFT.seq = RIGHT.seq AND LEFT.DID = RIGHT.DID,
  																	TRANSFORM(RECORDOF(LEFT),
																							SELF.Seq := LEFT.Seq,
																							SELF.DID := LEFT.DID,
																							SELF.BusFEINPersonOverlap := MAX(LEFT.BusFEINPersonOverlap , RIGHT.BusFEINPersonOverlap);
																							SELF.BusFEINPersonAddrOverlap := MAX(LEFT.BusFEINPersonAddrOverlap , RIGHT.BusFEINPersonAddrOverlap);
																							SELF.BusFEINPersonPhoneOverlap := MAX(LEFT.BusFEINPersonPhoneOverlap , RIGHT.BusFEINPersonPhoneOverlap);
																							SELF.FEINPersonNameMatchLevel := MAX(LEFT.FEINPersonNameMatchLevel , RIGHT.FEINPersonNameMatchLevel);
																							SELF.FEINPersonAddrMatchLevel := MAX(LEFT.FEINPersonAddrMatchLevel , RIGHT.FEINPersonAddrMatchLevel);
																							SELF.BNASRaw := MAX(LEFT.BNASRaw , RIGHT.BNASRaw);
																							SELF.AddressMatched := MAX(LEFT.AddressMatched , RIGHT.AddressMatched);
																							SELF.NameSimilar := MAX(LEFT.NameSimilar , RIGHT.NameSimilar);
                                              LeftAddrPopulated := LEFT.VerifiedConsumerAddress1 <> '' AND LEFT.VerifiedConsumerZip <> '';
																							SELF.VerifiedConsumerAddress1 := IF(LeftAddrPopulated, LEFT.VerifiedConsumerAddress1, RIGHT.VerifiedConsumerCity);
																							SELF.VerifiedConsumerCity := IF(LeftAddrPopulated, LEFT.VerifiedConsumerCity, RIGHT.VerifiedConsumerCity);
																							SELF.VerifiedConsumerState := IF(LeftAddrPopulated, LEFT.VerifiedConsumerState, RIGHT.VerifiedConsumerState);
																							SELF.VerifiedConsumerZip := IF(LeftAddrPopulated, LEFT.VerifiedConsumerZip, RIGHT.VerifiedConsumerZip);
                                              SELF.VerifiedConsumerFEIN := IF(LEFT.VerifiedConsumerFEIN <> '', LEFT.VerifiedConsumerFEIN, RIGHT.VerifiedConsumerFEIN);
                                              SELF.VerifiedConsumerPhone := IF(LEFT.VerifiedConsumerPhone <> '', LEFT.VerifiedConsumerPhone, RIGHT.VerifiedConsumerPhone);
																							SELF := LEFT));

	// Determine counts by Seq
	ConsumerHeaderDIDCounts := ROLLUP(SORT(ConsumerHeaderDIDStats, Seq, RECORD), LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(RECORDOF(LEFT),
																							SELF.BusFEINPersonOverlap := MAX(LEFT.BusFEINPersonOverlap, RIGHT.BusFEINPersonOverlap);
																							SELF.BusFEINPersonAddrOverlap := MAX(LEFT.BusFEINPersonAddrOverlap, RIGHT.BusFEINPersonAddrOverlap);
																							SELF.BusFEINPersonPhoneOverlap := MAX(LEFT.BusFEINPersonPhoneOverlap, RIGHT.BusFEINPersonPhoneOverlap);
																							SELF.FEINPersonNameMatchLevel := MAX(LEFT.FEINPersonNameMatchLevel, RIGHT.FEINPersonNameMatchLevel);
																							SELF.FEINPersonAddrMatchLevel := MAX(LEFT.FEINPersonAddrMatchLevel, RIGHT.FEINPersonAddrMatchLevel);
																							SELF.BNASRaw := MAX(LEFT.BNASRaw, RIGHT.BNASRaw);
																							SELF.AddressMatched := MAX(LEFT.AddressMatched, RIGHT.AddressMatched);
																							SELF.NameSimilar := MAX(LEFT.NameSimilar, RIGHT.NameSimilar);
                                              LeftAddrPopulated := LEFT.VerifiedConsumerAddress1 <> '' AND LEFT.VerifiedConsumerZip <> '';
																							SELF.VerifiedConsumerAddress1 := IF(LeftAddrPopulated, LEFT.VerifiedConsumerAddress1, RIGHT.VerifiedConsumerCity);
																							SELF.VerifiedConsumerCity := IF(LeftAddrPopulated, LEFT.VerifiedConsumerCity, RIGHT.VerifiedConsumerCity);
																							SELF.VerifiedConsumerState := IF(LeftAddrPopulated, LEFT.VerifiedConsumerState, RIGHT.VerifiedConsumerState);
																							SELF.VerifiedConsumerZip := IF(LeftAddrPopulated, LEFT.VerifiedConsumerZip, RIGHT.VerifiedConsumerZip);
                                              SELF.VerifiedConsumerFEIN := IF(LEFT.VerifiedConsumerFEIN <> '', LEFT.VerifiedConsumerFEIN, RIGHT.VerifiedConsumerFEIN);
                                              SELF.VerifiedConsumerPhone := IF(LEFT.VerifiedConsumerPhone <> '', LEFT.VerifiedConsumerPhone, RIGHT.VerifiedConsumerPhone);
																							SELF := LEFT));

	// Join it back to the primary attributes
	withConsumerHeaderDID := JOIN(WithConsumerHeaderRepAddrMatches, ConsumerHeaderDIDCounts, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							//For business shell v22 and higher, only set BusFEINPersonOverlap to -1 if input FEIN not populated.
																							BusFEINPersonOverlap_v22 := IF((INTEGER)LEFT.Clean_Input.FEIN=0, -1, MAX(RIGHT.BusFEINPersonOverlap, 0));
																							SELF.Business_To_Person_Link.BusFEINPersonOverlap := IF(shell_version <= Business_Risk_BIP.Constants.BusShellVersion_v21, (STRING)RIGHT.BusFEINPersonOverlap, (STRING)BusFEINPersonOverlap_v22);
																							//For business shell v22 and higher, only BusFEINPersonAddrOverlap to -1 if input FEIN or Address not populated.
																							BusFEINPersonAddrOverlap_v22 := IF((INTEGER)LEFT.Clean_Input.FEIN=0 OR TRIM(LEFT.Clean_Input.Zip5)='' OR TRIM(LEFT.Clean_Input.Prim_Name)='', -1, MAX(RIGHT.BusFEINPersonAddrOverlap, 0));
																							SELF.Business_To_Person_Link.BusFEINPersonAddrOverlap := MAP(shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v22 => (STRING)BusFEINPersonAddrOverlap_v22,
																																																					 RIGHT.BusFEINPersonAddrOverlap = -2 																			  => '0',
																																																																																												 (STRING)RIGHT.BusFEINPersonAddrOverlap);
																							//For business shell v22 and higher, only BusFEINPersonPhoneOverlap to -1 if input FEIN or Phone not populated.
																							BusFEINPersonPhoneOverlap_v22 := IF((INTEGER)LEFT.Clean_Input.FEIN=0 OR TRIM(LEFT.Clean_Input.Phone10)='', -1, MAX(RIGHT.BusFEINPersonPhoneOverlap, 0));
																							SELF.Business_To_Person_Link.BusFEINPersonPhoneOverlap := MAP(shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v22 => (STRING)BusFEINPersonPhoneOverlap_v22,
																																																						RIGHT.BusFEINPersonPhoneOverlap = -2 																			 => '0',
																																																																																												  (STRING)RIGHT.BusFEINPersonPhoneOverlap);

																							SELF.Verification.FEINPersonNameMatch := IF((INTEGER)LEFT.Clean_Input.FEIN = 0, '-1', (STRING)RIGHT.FEINPersonNameMatchLevel);
																							SELF.Verification.FEINPersonAddrMatch := IF((INTEGER)LEFT.Clean_Input.FEIN = 0, '-1', (STRING)RIGHT.FEINPersonAddrMatchLevel);
																							SELF.Verification.BNAS := (STRING)RIGHT.BNASRaw;
																							SELF.Verification.BNAS2 := (STRING)calcBNAS((BOOLEAN)RIGHT.AddressMatched, (BOOLEAN)RIGHT.NameSimilar);
                                              //If we verified an address earlier on the address search, use that. Otherwise, use the address from the FEIN search.
                                              LeftAddrPopulated := LEFT.Verification.VerifiedConsumerAddress1 <> '' AND LEFT.Verification.VerifiedConsumerZip <> '';
																							SELF.Verification.VerifiedConsumerAddress1 := IF(LeftAddrPopulated, LEFT.Verification.VerifiedConsumerAddress1, RIGHT.VerifiedConsumerCity);
																							SELF.Verification.VerifiedConsumerCity := IF(LeftAddrPopulated, LEFT.Verification.VerifiedConsumerCity, RIGHT.VerifiedConsumerCity);
																							SELF.Verification.VerifiedConsumerState := IF(LeftAddrPopulated, LEFT.Verification.VerifiedConsumerState, RIGHT.VerifiedConsumerState);
																							SELF.Verification.VerifiedConsumerZip := IF(LeftAddrPopulated, LEFT.Verification.VerifiedConsumerZip, RIGHT.VerifiedConsumerZip);
                                              SELF.Verification.VerifiedConsumerFEIN := RIGHT.VerifiedConsumerFEIN;
                                              SELF.Verification.VerifiedConsumerPhone := RIGHT.VerifiedConsumerPhone;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);



	// Figured out if the input FEIN is linked to a deceased SSN - this plays a roll in calculation of BVI (Appropriated from Business_Risk.InstantID_Function)
	Business_Risk_BIP.Layouts.Shell checkForDeceased(withConsumerHeaderDID le, Risk_Indicators.Key_SSN_Table_v4_2 ri) := TRANSFORM
		dateCorrectionNeeded := Suppress.dateCorrect.DO(ri.SSN).Needed;
		// Determine which header data in the table is permitted based on the data restriction mask
		headerVersion := MAP(drm[Risk_Indicators.iid_constants.posExperianRestriction] = Risk_Indicators.iid_constants.sFalse AND
												 drm[Risk_Indicators.iid_constants.posEquifaxRestriction] = Risk_Indicators.iid_constants.sFalse AND
												 drm[Risk_Indicators.iid_constants.posTransUnionRestriction] = Risk_Indicators.iid_constants.sFalse		=> ri.Combo, // No data restricted credit sources
												 drm[Risk_Indicators.iid_constants.posExperianRestriction] = Risk_Indicators.iid_constants.sFalse			=> ri.EN, // Experian not restricted
												 drm[Risk_Indicators.iid_constants.posTransUnionRestriction] = Risk_Indicators.iid_constants.sFalse		=> ri.TN, // TransUnion not restricted
																																																																												 ri.EQ); // Default to Equifax version

		// EQ section are SSA death records only (Previously known as Death v2)
		// EN and TN bureau records add additional data in their respective sections, use the appropriate data restriction
		creditBureauDeceasedRecordsAllowed := drm[Risk_Indicators.iid_constants.posBureauDeceasedRestriction] = Risk_Indicators.iid_constants.sFalse;
		isDeceasedFlag := IF(creditBureauDeceasedRecordsAllowed, headerVersion.isDeceased, ri.EQ.isDeceased);
		dateFirstDeceased := IF(creditBureauDeceasedRecordsAllowed, headerVersion.DT_First_Deceased, ri.EQ.DT_First_Deceased);

		SELF.DeceasedFEIN_As_SSN := IF((isDeceasedFlag AND (le.Clean_Input.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate OR (INTEGER)(((STRING)dateFirstDeceased)[1..6]) < le.Clean_Input.HistoryDate)) AND NOT dateCorrectionNeeded, 'Y', 'N');
		// Keep everything calculated up to this point
		SELF := le;
	END;

	withDeceasedFlag := JOIN(withConsumerHeaderDID, Risk_Indicators.Key_SSN_Table_v4_2,
																	(INTEGER)LEFT.Clean_Input.FEIN > 0 AND KEYED(LEFT.Clean_Input.FEIN = RIGHT.SSN),
																	checkForDeceased(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// -------- Use Contacts from business header, relatives, and househould members to check for FEIN/SSN matches to increase FEIN verification  ------ //

		ConsumerHeaderDIDSlim := DEDUP(SORT(ConsumerHeaderDID(FEINMatched), Seq, DID), Seq, DID);

		HeaderRelatives :=  Relationship.proc_GetRelationshipNeutral(PROJECT(ConsumerHeaderDIDSlim, TRANSFORM(Relationship.layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID)),
																	TopNCount:=100,
																	RelativeFlag :=TRUE,AssociateFlag:=TRUE,
																	doAtmost:=TRUE,MaxCount:=Business_Risk_BIP.Constants.Limit_Default).result;
		SeqHeaderRelatives := JOIN(ConsumerHeaderDIDSlim, HeaderRelatives, LEFT.DID = RIGHT.DID1,
																	TRANSFORM(Business_Risk_BIP.Layouts.LayoutContacts,
																							SELF.Seq := LEFT.Seq,
																							SELF.DID := RIGHT.DID2,
																							SELF := []),
																	ATMOST(100));

		Doxie.Mac_Best_Records(SeqHeaderRelatives, DID, BestHeaderRelativesInfo, mod_access.isValidDppa(), mod_access.isValidGlb(), FALSE/* UseNonBlankKey */, drm, (BOOLEAN)(Options.MarketingMode = 1));

		SeqRelativeInfo := JOIN(SeqHeaderRelatives, BestHeaderRelativesInfo, LEFT.DID = RIGHT.DID,
																	TRANSFORM(Business_Risk_BIP.Layouts.LayoutContacts,
																							SELF.Seq := LEFT.Seq,
																							SELF.DID := LEFT.DID,
																							SELF.FName := RIGHT.FName,
																							SELF.LName := RIGHT.LName,
																							SELF := []),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

		HeaderHHID := JOIN(ConsumerHeaderDIDSlim, dx_header.key_hhID_did(), KEYED(LEFT.HHID = RIGHT.HHID_Relat) AND LEFT.DID <> RIGHT.DID,
																	TRANSFORM(Business_Risk_BIP.Layouts.LayoutContacts,
																							SELF.Seq := LEFT.Seq,
																							SELF.DID := RIGHT.DID,
																							SELF := []),
																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));

		Doxie.Mac_Best_Records(HeaderHHID, DID, BestHeaderHHIDInfo, mod_access.isValidDppa(), mod_access.isValidGlb(), FALSE/* UseNonBlankKey */, drm, (BOOLEAN)(Options.MarketingMode = 1));

		SeqHouseholdInfo := JOIN(HeaderHHID, BestHeaderHHIDInfo, LEFT.DID = RIGHT.DID,
																	TRANSFORM(Business_Risk_BIP.Layouts.LayoutContacts,
																							SELF.Seq := LEFT.Seq,
																							SELF.DID := LEFT.DID,
																							SELF.FName := RIGHT.FName,
																							SELF.LName := RIGHT.LName,
																							SELF := []),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

		seqRelativeHHInfo := PROJECT(SeqRelativeInfo, TRANSFORM({STRING1 Relationship, Business_Risk_BIP.Layouts.LayoutContacts}, SELF.Relationship := 'R', SELF := LEFT)) +
												 PROJECT(SeqHouseholdInfo, TRANSFORM({STRING1 Relationship, Business_Risk_BIP.Layouts.LayoutContacts}, SELF.Relationship := 'H', SELF := LEFT));


		TempAssociateVerificationLayout := RECORD
			UNSIGNED4 Seq;
			STRING2 FEINAssociateSSNMatch;
			STRING2 FEINRelativeSSNMatch;
			STRING2 FEINHouseholdSSNMatch;
			STRING2 AR2BRep1SSNAssociateCHeader;
			STRING2 AR2BRep2SSNAssociateCHeader;
			STRING2 AR2BRep3SSNAssociateCHeader;
			STRING2 AR2BRep4SSNAssociateCHeader;
			STRING2 AR2BRep5SSNAssociateCHeader;
			STRING2 AR2BRep1PhoneAssociateCHeader;
			STRING2 AR2BRep2PhoneAssociateCHeader;
			STRING2 AR2BRep3PhoneAssociateCHeader;
			STRING2 AR2BRep4PhoneAssociateCHeader;
			STRING2 AR2BRep5PhoneAssociateCHeader;
		END;

		AssociateVerification := JOIN(SeqContactInfo, seqRelativeHHInfo, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(TempAssociateVerificationLayout,
																							SELF.Seq := LEFT.Seq,
																							FNameMatched := Business_Risk_BIP.Common.SetBoolean(LEFT.FName <> '' AND RIGHT.fname <> '' AND STD.Str.Find(RIGHT.fname, LEFT.FName, 1) > 0);
																							LNameMatched := Business_Risk_BIP.Common.SetBoolean(LEFT.LName <> '' AND RIGHT.lname <> '' AND STD.Str.Find(RIGHT.lname, LEFT.LName, 1) > 0);
																							FullNamePopulated := TRIM(LEFT.FName) <> '' OR TRIM(LEFT.LName) <> ''; // Populated if first or last are sent in
																							FullNameMatched := FNameMatched = '1' AND LNameMatched = '1';
																							SELF.FEINRelativeSSNMatch  := MAP(RIGHT.Relationship = 'R' AND FullNamePopulated AND FullNameMatched => '2',
																																							  FullNamePopulated 										 														 => '1',
																																																																										  '0');

																							SELF.FEINHouseholdSSNMatch := MAP(RIGHT.Relationship = 'H' AND FullNamePopulated AND FullNameMatched => '2',
																																								FullNamePopulated 																								 => '1',
																																																																										  '0');
																							SELF := []),
																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));

		RollAssociateVerification := ROLLUP(SORT(AssociateVerification, Seq), LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(TempAssociateVerificationLayout,
																							SELF.Seq := LEFT.Seq,
																							SELF.FEINRelativeSSNMatch := (STRING)MAX((INTEGER)LEFT.FEINRelativeSSNMatch, (INTEGER)RIGHT.FEINRelativeSSNMatch);
																							SELF.FEINHouseholdSSNMatch := (STRING)MAX((INTEGER)LEFT.FEINHouseholdSSNMatch, (INTEGER)RIGHT.FEINHouseholdSSNMatch);
																							SELF := []));
		WithAssociateVerification := JOIN(withDeceasedFlag, RollAssociateVerification, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell;
																							SELF.Verification.FEINRelativeSSNMatch := MAP((INTEGER)LEFT.Clean_Input.FEIN <= 0 																				  		 					 	=> '-1',
																																														LEFT.Business_To_Person_Link.BusFEINPersonOverlap = '0' AND RIGHT.FEINRelativeSSNMatch = '1'  => '0', // If no FEIN as SSN hits, set to 0.
																																																																																														 RIGHT.FEINRelativeSSNMatch);
																							SELF.Verification.FEINHouseholdSSNMatch := MAP((INTEGER)LEFT.Clean_Input.FEIN <= 0 																							 						=> '-1',
																																														LEFT.Business_To_Person_Link.BusFEINPersonOverlap = '0' AND RIGHT.FEINHouseholdSSNMatch = '1' => '0', // If no FEIN as SSN hits, set to 0.
																																																																																														 RIGHT.FEINHouseholdSSNMatch);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

		ContactVerification := JOIN(SeqContactInfo, ConsumerHeaderDID, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(TempAssociateVerificationLayout,
																							SELF.Seq := LEFT.Seq,
																							FNameMatched := Business_Risk_BIP.Common.SetBoolean(LEFT.FName <> '' AND RIGHT.fname <> '' AND STD.Str.Find(RIGHT.fname, LEFT.FName, 1) > 0);
																							LNameMatched := Business_Risk_BIP.Common.SetBoolean(LEFT.LName <> '' AND RIGHT.lname <> '' AND STD.Str.Find(RIGHT.lname, LEFT.LName, 1) > 0);
																							FullNamePopulated := TRIM(LEFT.FName) <> '' OR TRIM(LEFT.LName) <> ''; // Populated if first or last are sent in
																							FullNameMatched := FNameMatched = '1' AND LNameMatched = '1';

																							SELF.FEINAssociateSSNMatch := MAP(FullNamePopulated AND FullNameMatched AND RIGHT.FEINMatched => '2',
																																								FullNamePopulated AND RIGHT.FEINMatched											=> '1',
																																																																							'0');

																							SELF.AR2BRep1SSNAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.Rep1SSNMatched, '1', '0');
																							SELF.AR2BRep2SSNAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.Rep2SSNMatched, '1', '0');
																							SELF.AR2BRep3SSNAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.Rep3SSNMatched, '1', '0');
																							SELF.AR2BRep4SSNAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.Rep4SSNMatched, '1', '0');
																							SELF.AR2BRep5SSNAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.Rep5SSNMatched, '1', '0');
																							SELF := []),
																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));


		RollContactVerification := ROLLUP(SORT(ContactVerification, Seq), LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(TempAssociateVerificationLayout,
																							SELF.Seq := LEFT.Seq,
																							SELF.FEINAssociateSSNMatch := (STRING)MAX((INTEGER)LEFT.FEINAssociateSSNMatch, (INTEGER)RIGHT.FEINAssociateSSNMatch);
																							SELF.AR2BRep1SSNAssociateCHeader := (STRING)MAX((INTEGER)LEFT.AR2BRep1SSNAssociateCHeader, (INTEGER)RIGHT.AR2BRep1SSNAssociateCHeader);
																							SELF.AR2BRep2SSNAssociateCHeader := (STRING)MAX((INTEGER)LEFT.AR2BRep2SSNAssociateCHeader, (INTEGER)RIGHT.AR2BRep2SSNAssociateCHeader);
																							SELF.AR2BRep3SSNAssociateCHeader := (STRING)MAX((INTEGER)LEFT.AR2BRep3SSNAssociateCHeader, (INTEGER)RIGHT.AR2BRep3SSNAssociateCHeader);
																							SELF.AR2BRep4SSNAssociateCHeader := (STRING)MAX((INTEGER)LEFT.AR2BRep4SSNAssociateCHeader, (INTEGER)RIGHT.AR2BRep4SSNAssociateCHeader);
																							SELF.AR2BRep5SSNAssociateCHeader := (STRING)MAX((INTEGER)LEFT.AR2BRep5SSNAssociateCHeader, (INTEGER)RIGHT.AR2BRep5SSNAssociateCHeader);
																							SELF := []));

		WithContactVerification := JOIN(WithAssociateVerification, RollContactVerification, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Verification.FEINAssociateSSNMatch := IF((INTEGER)LEFT.Clean_Input.FEIN <= 0, '-1', RIGHT.FEINAssociateSSNMatch),
																							SELF.Business_To_Executive_Link.AR2BRep1SSNAssociateCHeader := IF((INTEGER)LEFT.Clean_Input.Rep_SSN <= 0, '-1', RIGHT.AR2BRep1SSNAssociateCHeader);
																							SELF.Business_To_Executive_Link.AR2BRep2SSNAssociateCHeader := IF((INTEGER)LEFT.Clean_Input.Rep2_SSN <= 0, '-1', RIGHT.AR2BRep2SSNAssociateCHeader);
																							SELF.Business_To_Executive_Link.AR2BRep3SSNAssociateCHeader := IF((INTEGER)LEFT.Clean_Input.Rep3_SSN <= 0, '-1', RIGHT.AR2BRep3SSNAssociateCHeader);
																							SELF.Business_To_Executive_Link.AR2BRep4SSNAssociateCHeader := IF((INTEGER)LEFT.Clean_Input.Rep4_SSN <= 0, '-1', RIGHT.AR2BRep4SSNAssociateCHeader);
																							SELF.Business_To_Executive_Link.AR2BRep5SSNAssociateCHeader := IF((INTEGER)LEFT.Clean_Input.Rep5_SSN <= 0, '-1', RIGHT.AR2BRep5SSNAssociateCHeader);

																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

// ----- Seach Gong and Phones Plus for Input Representative phones ----- //

	PhoneNameMismatchLayout := RECORD
		UNSIGNED4 Seq;
		STRING2 PhoneNameMismatch;
	END;

	PhoneAutoKey := AutoKey.Key_Phone(Data_Services.Data_Location.Prefix('phonesPlus') + 'thor_data400::key::phonesplusv2_');

	ShellSearchLayout getFDID(ShellSearchRecords le, PhoneAutoKey ri) := TRANSFORM
		SELF.fdid := ri.did;
		SELF := le;
	END;
	getPhoneFDID := JOIN(ShellSearchRecords, PhoneAutoKey, (INTEGER)LEFT.Phone10 > 0 AND KEYED(RIGHT.p7 = LEFT.Phone10[4..10]) AND KEYED(RIGHT.p3 = LEFT.Phone10[1..3]),
																		getFDID(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	phonesPlusRaw := JOIN(getPhoneFDID, Phonesplus_v2.key_phonesplus_fdid, LEFT.FDID <> 0 AND KEYED(LEFT.FDID = RIGHT.FDID) AND (INTEGER)RIGHT.CellPhone > 0,
																	TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, STRING1 RecordType},
																							SELF.Seq := LEFT.Seq;
																							SELF.HistoryDate := LEFT.HistoryDate;
																							SELF.RecordType := LEFT.RecordType;
																							SELF := RIGHT),
																	ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	phonesPlusRaw_filter_srcall := phonesPlusRaw(Phones.Functions.IsPhoneRestricted(origstate,
																																									mod_access.glb,
																																									mod_access.dppa,
																																									mod_access.industry_class,
																																									,
																																									datefirstseen,
																																									dt_nonglb_last_seen,
																																									rules,
																																									src_all,
																																									drm
																																								) = FALSE);
	// Filter out records after our history date
	phonesPlus := Business_Risk_BIP.Common.FilterRecords(phonesPlusRaw_filter_srcall, datefirstseen, datevendorfirstreported, '', AllowedSourcesSet);

	phonesPlusBusiness := phonesPlus(RecordType = 'B');
	phonesPlusRep := phonesPlus(RecordType IN ['1','2','3','4','5']);

	PhoneNameMismatchLayout getPPBusinessVerification(Shell le, phonesPlus ri) := TRANSFORM
		SELF.Seq := le.Seq;
		// In an effort to "short circuit" the fuzzy matching require that the first character match before doing the fuzzy comparison - this helps with latency
		NamePopulated				:= TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(ri.Company) <> '';
		NameMatched					:= NamePopulated AND le.Clean_Input.CompanyName[1] = ri.Company[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.Company));

		NoScoreValue				:= 255;
		AddressPopulated		:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip5) <> '';
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND ri.Zip5 <> '' AND le.Clean_Input.Zip5[1] = ri.Zip5[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Zip5), NoScoreValue);
		CityStateScore			:= IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.State <> '' AND le.Clean_Input.State[1] = ri.State[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.State, ''), NoScoreValue);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));

		PhonePopulated			:= TRIM(le.Clean_Input.Phone10) <> '' AND TRIM(ri.CellPhone) <> '';
		PhoneMatched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.CellPhone[1] OR le.Clean_Input.Phone10[4] = ri.CellPhone[4] OR le.Clean_Input.Phone10[4] = ri.CellPhone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.CellPhone));

		PhoneNameMatchLevel := MAP((INTEGER)le.Clean_Input.Phone10 = 0 																				                                         => '-1', //Phone not input
                                  shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND
                                  (TRIM(le.Clean_Input.CompanyName) = '' OR TRIM(le.Clean_Input.Prim_Name) = '' OR TRIM(le.Clean_Input.Zip5) = '') => '-1', //In version 3.0 and up, need name and address input to calculate
																	NOT PhonePopulated AND (INTEGER)le.Clean_Input.Phone10 > 0 							                                         => '0',	//Phone not found on gong records
																	PhoneMatched = TRUE AND NameMatched = FALSE AND AddressMatched = FALSE                                           => '1',
																	PhoneMatched = TRUE AND NameMatched = TRUE AND AddressMatched = FALSE                                            => '2',
																	PhoneMatched = TRUE AND NameMatched = FALSE AND AddressMatched = TRUE	                                           => '3',
																	PhoneMatched = TRUE AND NameMatched = TRUE AND AddressMatched = TRUE 		                                         => '4',
                                                                                                                                                      '0');

		SELF.PhoneNameMismatch := PhoneNameMatchLevel; // This calculation will also happen in Business_Risk_BIP.getBusinessHeader, take the max of both in Business_Shell_Function, then we will reassign values
	END;

	phonePlusBusinessVerification := JOIN(Shell, phonesPlusBusiness,	LEFT.Seq = RIGHT.Seq,
													getPPBusinessVerification(LEFT, RIGHT), LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));


	phonesPlusVerification := JOIN(SeqContactInfo, PhonesPlusRep, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(TempAssociateVerificationLayout,
																							SELF.Seq := LEFT.Seq,
																							FNameMatched := Business_Risk_BIP.Common.SetBoolean(LEFT.FName <> '' AND RIGHT.fname <> '' AND STD.Str.Find(RIGHT.fname, LEFT.FName, 1) > 0);
																							LNameMatched := Business_Risk_BIP.Common.SetBoolean(LEFT.LName <> '' AND RIGHT.lname <> '' AND STD.Str.Find(RIGHT.lname, LEFT.LName, 1) > 0);
																							FullNamePopulated := TRIM(LEFT.FName) <> '' OR TRIM(LEFT.LName) <> ''; // Populated if first or last are sent in
																							FullNameMatched := FNameMatched = '1' AND LNameMatched = '1';
																							SELF.AR2BRep1PhoneAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.RecordType='1', '1', '0');
																							SELF.AR2BRep2PhoneAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.RecordType='2', '1', '0');
																							SELF.AR2BRep3PhoneAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.RecordType='3', '1', '0');
																							SELF.AR2BRep4PhoneAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.RecordType='4', '1', '0');
																							SELF.AR2BRep5PhoneAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.RecordType='5', '1', '0');
																							SELF := []),
																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	gongRaw := JOIN(ShellSearchRecords, dx_Gong.key_history_phone(), (INTEGER)LEFT.Phone10 > 0 AND KEYED(LEFT.Phone10[1..3] = RIGHT.p3 AND LEFT.Phone10[4..10] = RIGHT.p7) AND
																	// See comments for Business_Risk_BIP.Common.FilterRecords for full explanation - the <= and < checks are valid and should be different below for realtime vs historical modes
																	((LEFT.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(((STRING)RIGHT.dt_first_seen)[1..6]) <= LEFT.HistoryDate) OR (INTEGER)(((STRING)RIGHT.dt_first_seen)[1..6]) < LEFT.HistoryDate)
																	AND (INTEGER)RIGHT.dt_first_seen > 0,
																	TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate, STRING1 RecordType},
																							SELF.Seq := LEFT.Seq;
																							SELF.HistoryDate := LEFT.HistoryDate;
																							SELF.RecordType := LEFT.RecordType;
																							SELF := RIGHT),
																	ATMOST(Business_Risk_BIP.Constants.Limit_Default));

		gongRawBusiness := gongRaw(RecordType = 'B');
	gongRawRep := gongRaw(RecordType IN ['1','2','3','4','5']);

	PhoneNameMismatchLayout getGongBusinessVerification(Shell le, GongRaw ri) := TRANSFORM
		SELF.Seq := le.Seq;
		NamePopulated				:= TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(ri.Listed_Name) <> '';
		NameMatched					:= NamePopulated AND le.Clean_Input.CompanyName[1] = ri.Listed_Name[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.Listed_Name));

		NoScoreValue				:= 255;
		AddressPopulated		:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Z5) <> '';
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND ri.Z5 <> '' AND le.Clean_Input.Zip5[1] = ri.Z5[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Z5), NoScoreValue);
		CityStateScore			:= IF(ZIPScore <> NoScoreValue AND le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.st <> '' AND le.Clean_Input.State[1] = ri.st[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.st, ''), NoScoreValue);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));

		PhonePopulated			:= TRIM(le.Clean_Input.Phone10) <> '' AND TRIM(ri.Phone10) <> '';
		PhoneMatched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.Phone10[1] OR le.Clean_Input.Phone10[4] = ri.Phone10[4] OR le.Clean_Input.Phone10[4] = ri.Phone10[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.Phone10));

		PhoneNameMatchLevel := MAP((INTEGER)le.Clean_Input.Phone10 = 0 																			                                         => '-1', //Phone not input
                                shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND
                                (TRIM(le.Clean_Input.CompanyName) = '' OR TRIM(le.Clean_Input.Prim_Name) = '' OR TRIM(le.Clean_Input.Zip5) = '') => '-1', //In version 3.0 and up, need name and address input to calculate
																NOT PhonePopulated AND (INTEGER)le.Clean_Input.Phone10 > 0 							                                         => '0',	//Phone not found on gong records
																PhoneMatched = TRUE AND NameMatched = FALSE AND AddressMatched = FALSE                                           => '1',
																PhoneMatched = TRUE AND NameMatched = TRUE AND AddressMatched = FALSE                                            => '2',
																PhoneMatched = TRUE AND NameMatched = FALSE AND AddressMatched = TRUE	                                           => '3',
																PhoneMatched = TRUE AND NameMatched = TRUE AND AddressMatched = TRUE 		                                         => '4',
																																																				                                          	'0');

		SELF.PhoneNameMismatch := PhoneNameMatchLevel; // This calculation will also happen in Business_Risk_BIP.getBusinessHeader, take the max of both in Business_Shell_Function, then we will reassign values
	END;

	gongRawBusinessVerification := JOIN(Shell, gongRawBusiness, LEFT.Seq = RIGHT.Seq,
																	getGongBusinessVerification(LEFT, RIGHT), LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	RollPhoneBusinessVerification := ROLLUP(SORT(gongRawBusinessVerification + phonePlusBusinessVerification, Seq), LEFT.Seq = RIGHT.Seq,
																		TRANSFORM(RECORDOF(LEFT),
																		SELF.Seq := LEFT.Seq,
																		SELF.PhoneNameMismatch := (STRING)MAX((INTEGER)LEFT.PhoneNameMismatch, (INTEGER)RIGHT.PhoneNameMismatch)));


	withPhoneBusinessVerification := JOIN(WithContactVerification, RollPhoneBusinessVerification, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																						SELF.Verification.PhoneNameMismatch := RIGHT.PhoneNameMismatch,
																						SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);


	gongRawVerification := JOIN(SeqContactInfo, gongRawRep, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(TempAssociateVerificationLayout,
																							SELF.Seq := LEFT.Seq,
																							FNameMatched := Business_Risk_BIP.Common.SetBoolean(LEFT.FName <> '' AND RIGHT.name_first <> '' AND STD.Str.Find(RIGHT.name_first, LEFT.FName, 1) > 0);
																							LNameMatched := Business_Risk_BIP.Common.SetBoolean(LEFT.LName <> '' AND RIGHT.name_last <> '' AND STD.Str.Find(RIGHT.name_last, LEFT.LName, 1) > 0);
																							FullNamePopulated := TRIM(LEFT.FName) <> '' OR TRIM(LEFT.LName) <> ''; // Populated if first or last are sent in
																							FullNameMatched := FNameMatched = '1' AND LNameMatched = '1';
																							SELF.AR2BRep1PhoneAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.RecordType='1', '1', '0');
																							SELF.AR2BRep2PhoneAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.RecordType='2', '1', '0');
																							SELF.AR2BRep3PhoneAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.RecordType='3', '1', '0');
																							SELF.AR2BRep4PhoneAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.RecordType='4', '1', '0');
																							SELF.AR2BRep5PhoneAssociateCHeader := IF(FullNamePopulated AND FullNameMatched AND RIGHT.RecordType='5', '1', '0');
																							SELF := []),
																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	RepPhoneVerificationRecords := phonesPlusVerification + gongRawVerification;

	RepPhoneVerificationRolled := ROLLUP(SORT(RepPhoneVerificationRecords, Seq), LEFT.Seq=RIGHT.Seq,
																	TRANSFORM(TempAssociateVerificationLayout,
																							SELF.Seq := LEFT.Seq;
																							SELF.AR2BRep1PhoneAssociateCHeader := (STRING)MAX((INTEGER)LEFT.AR2BRep1PhoneAssociateCHeader, (INTEGER)RIGHT.AR2BRep1PhoneAssociateCHeader);
																							SELF.AR2BRep2PhoneAssociateCHeader := (STRING)MAX((INTEGER)LEFT.AR2BRep2PhoneAssociateCHeader, (INTEGER)RIGHT.AR2BRep2PhoneAssociateCHeader);
																							SELF.AR2BRep3PhoneAssociateCHeader := (STRING)MAX((INTEGER)LEFT.AR2BRep3PhoneAssociateCHeader, (INTEGER)RIGHT.AR2BRep3PhoneAssociateCHeader);
																							SELF.AR2BRep4PhoneAssociateCHeader := (STRING)MAX((INTEGER)LEFT.AR2BRep4PhoneAssociateCHeader, (INTEGER)RIGHT.AR2BRep4PhoneAssociateCHeader);
																							SELF.AR2BRep5PhoneAssociateCHeader := (STRING)MAX((INTEGER)LEFT.AR2BRep5PhoneAssociateCHeader, (INTEGER)RIGHT.AR2BRep5PhoneAssociateCHeader);
																							SELF := []));

  WithRepPhoneVerification := JOIN(withPhoneBusinessVerification, RepPhoneVerificationRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Business_To_Executive_Link.AR2BRep1PhoneAssociateCHeader := IF((INTEGER)LEFT.Clean_Input.Rep_Phone10 <= 0, '-1', RIGHT.AR2BRep1PhoneAssociateCHeader);
																							SELF.Business_To_Executive_Link.AR2BRep2PhoneAssociateCHeader := IF((INTEGER)LEFT.Clean_Input.Rep2_Phone10 <= 0, '-1', RIGHT.AR2BRep2PhoneAssociateCHeader);
																							SELF.Business_To_Executive_Link.AR2BRep3PhoneAssociateCHeader := IF((INTEGER)LEFT.Clean_Input.Rep3_Phone10 <= 0, '-1', RIGHT.AR2BRep3PhoneAssociateCHeader);
																							SELF.Business_To_Executive_Link.AR2BRep4PhoneAssociateCHeader := IF((INTEGER)LEFT.Clean_Input.Rep4_Phone10 <= 0, '-1', RIGHT.AR2BRep4PhoneAssociateCHeader);
																							SELF.Business_To_Executive_Link.AR2BRep5PhoneAssociateCHeader := IF((INTEGER)LEFT.Clean_Input.Rep5_Phone10 <= 0, '-1', RIGHT.AR2BRep5PhoneAssociateCHeader);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

// ------------- Search Consumer Header by DIDs from Business Header Contacts and check if elements match input Rep data ------------- //
	tempConsumerContactVerLayout := RECORD
		UNSIGNED4 Seq;
		STRING2 AR2BRep1NameBusHeaderLexID;
		STRING2 AR2BRep1AddrBusHeaderLexID;
		STRING2 AR2BRep1PhoneBusHeaderLexID;
		STRING2 AR2BRep1SSNBusHeaderLexID;
		STRING2 AR2BRep2NameBusHeaderLexID;
		STRING2 AR2BRep2AddrBusHeaderLexID;
		STRING2 AR2BRep2PhoneBusHeaderLexID;
		STRING2 AR2BRep2SSNBusHeaderLexID;
		STRING2 AR2BRep3NameBusHeaderLexID;
		STRING2 AR2BRep3AddrBusHeaderLexID;
		STRING2 AR2BRep3PhoneBusHeaderLexID;
		STRING2 AR2BRep3SSNBusHeaderLexID;
		STRING2 AR2BRep4NameBusHeaderLexID;
		STRING2 AR2BRep4AddrBusHeaderLexID;
		STRING2 AR2BRep4PhoneBusHeaderLexID;
		STRING2 AR2BRep4SSNBusHeaderLexID;
		STRING2 AR2BRep5NameBusHeaderLexID;
		STRING2 AR2BRep5AddrBusHeaderLexID;
		STRING2 AR2BRep5PhoneBusHeaderLexID;
		STRING2 AR2BRep5SSNBusHeaderLexID;
	END;

	ConsumerShellContactInfoRaw_all := JOIN(seqContactInfo, dx_header.key_header(), LEFT.DID > 0 AND KEYED(LEFT.DID = RIGHT.S_DID) AND
																	// check permissions
																	doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, right.src, right.dt_first_seen) and
																	RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources(drm, FALSE /*isFCRA*/) AND
																	(MDR.Source_is_DPPA(RIGHT.src) = FALSE OR
																		(mod_access.isValidDppa() AND mod_access.isValidDppaState(dx_header.functions.TranslateSource(RIGHT.src), RIGHT.src))) AND
																	Risk_Indicators.iid_constants.filtered_source(RIGHT.src, RIGHT.st) = FALSE,
																	TRANSFORM({UNSIGNED4 Seq, UNSIGNED3 HistoryDate, RECORDOF(RIGHT)}, SELF.Seq := LEFT.Seq, SELF.HistoryDate := LEFT.HistoryDate, SELF := RIGHT),
																	ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	ConsumerShellContactInfoRaw:= Suppress.MAC_SuppressSource(ConsumerShellContactInfoRaw_all, mod_access);

	ConsumerShellContactInfo := Business_Risk_BIP.Common.FilterRecords(ConsumerShellContactInfoRaw, Dt_First_Seen, dt_vendor_first_reported, '', AllowedSourcesSet);

	ConsumerShellContactVerification := JOIN(WithRepPhoneVerification, ConsumerShellContactInfo, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(tempConsumerContactVerLayout,
																							SELF.Seq := LEFT.Seq,
																							// Verify with Rep1 elements
																							RepInputNamePopulated 	  := TRIM(LEFT.Clean_Input.Rep_FirstName) <> '' OR TRIM(LEFT.Clean_Input.Rep_LastName) <> ''; // Populated if first or last are sent in
																							RepAR2BFNameFile 				  := Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep_FirstName <> '' AND STD.Str.Find(RIGHT.fname, LEFT.Clean_Input.Rep_FirstName, 1) > 0);
																							RepAR2BLNameFile 				  := Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep_LastName <> '' AND STD.Str.Find(RIGHT.lname, LEFT.Clean_Input.Rep_LastName, 1) > 0);
																							RepAR2BPreferredNameFile  := Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep_PreferredFirstName <> '' AND STD.Str.Find(RIGHT.fname, LEFT.Clean_Input.Rep_PreferredFirstName, 1) > 0);
																							RepAR2BFullFile					  := Business_Risk_BIP.Common.SetBoolean((RepAR2BFNameFile = '1' AND RepAR2BLNameFile = '1') OR (RepAR2BPreferredNameFile = '1' AND RepAR2BLNameFile = '1'));

																							RepInputAddrPopulated 	  := TRIM(LEFT.Clean_Input.Rep_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep_Zip5) <> '';
																							NoScoreValue						  := 255; // This is what the various score functions return if blank is passed in
																							RepZIPScore							  := IF(LEFT.Clean_Input.Rep_Zip5 <> '' AND RIGHT.Zip <> '' AND LEFT.Clean_Input.Rep_Zip5[1] = RIGHT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Rep_Zip5, RIGHT.Zip), NoScoreValue);
																							RepStateMatched					  := STD.Str.ToUpperCase(LEFT.Clean_Input.Rep_State) = STD.Str.ToUpperCase(RIGHT.st);
																							RepCityStateScore				  := IF(LEFT.Clean_Input.Rep_City <> '' AND LEFT.Clean_Input.Rep_State <> '' AND RIGHT.city_name <> '' AND RIGHT.st <> '' AND RepStateMatched,
																																			  	 Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.Rep_City, LEFT.Clean_Input.Rep_State, RIGHT.city_name, RIGHT.st, ''), NoScoreValue);
																							RepCityStateZipMatched	  := RepInputAddrPopulated AND Risk_Indicators.iid_constants.ga(RepZIPScore) AND Risk_Indicators.iid_constants.ga(RepCityStateScore);
																							RepInputAddrMatched			  := RepInputAddrPopulated AND Risk_Indicators.iid_constants.ga(IF(RepZIPScore = NoScoreValue AND RepCityStateScore = NoScoreValue, NoScoreValue,
																																				   Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Rep_Prim_Range, LEFT.Clean_Input.Rep_Prim_Name, LEFT.Clean_Input.Rep_Sec_Range,
																																					 RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range,
																																					 RepZIPScore, RepCityStateScore)));

																							RepInputSSNPopulated 		  := (INTEGER)LEFT.Clean_Input.rep_ssn > 0;
																							RepSSNLength 						  := LENGTH(TRIM(LEFT.Clean_Input.Rep_SSN));
																							RepInputSSNMatched 			  := MAP(NOT RepInputSSNPopulated																																		  => FALSE,
																																							 RepInputSSNPopulated AND LEFT.Clean_Input.Rep_SSN[1] = RIGHT.SSN[IF(RepSSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(LEFT.Clean_Input.Rep_SSN, RIGHT.SSN, RepSSNLength=4)),
																																								 																																															 FALSE);
																							RepInputPhonePopulated 	  := TRIM(LEFT.Clean_Input.Rep_Phone10) <> '';
																							RepInputPhoneMatched 		  := RepInputPhonePopulated AND (LEFT.Clean_Input.Rep_Phone10[1] = RIGHT.phone[1] OR LEFT.Clean_Input.Rep_Phone10[4] = RIGHT.phone[4] OR LEFT.Clean_Input.Rep_Phone10[4] = RIGHT.phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Rep_Phone10, RIGHT.phone));

																							SELF.AR2BRep1NameBusHeaderLexID  := MAP(NOT RepInputNamePopulated 											=> '-1',
																																										  RepInputNamePopulated AND RepAR2BFullFile = '1' => '1',
																																																																		 		 '0');
																							SELF.AR2BRep1AddrBusHeaderLexID  := MAP(NOT RepInputAddrPopulated 											=> '-1',
																																										  RepInputAddrPopulated AND RepInputAddrMatched 	=> '1',
																																																																				 '0');
																							SELF.AR2BRep1PhoneBusHeaderLexID := MAP(NOT RepInputPhonePopulated 											=> '-1',
																																											RepInputPhonePopulated AND RepInputPhoneMatched => '1',
																																																																				'0');
																							SELF.AR2BRep1SSNBusHeaderLexID 	 := MAP(NOT RepInputSSNPopulated 												=> '-1',
																																										  RepInputSSNPopulated AND RepInputSSNMatched 		=> '1',
																																																																				 '0');

																							// Verify with Representative 2 elements
																							Rep2InputNamePopulated 		:= TRIM(LEFT.Clean_Input.Rep2_FirstName) <> '' OR TRIM(LEFT.Clean_Input.Rep2_LastName) <> ''; // Populated if first or last are sent in
																							Rep2AR2BFNameFile 				:= Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep2_FirstName <> '' AND STD.Str.Find(RIGHT.fname, LEFT.Clean_Input.Rep2_FirstName, 1) > 0);
																							Rep2AR2BLNameFile 				:= Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep2_LastName <> '' AND STD.Str.Find(RIGHT.lname, LEFT.Clean_Input.Rep2_LastName, 1) > 0);
																							Rep2AR2BPreferredNameFile := Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep2_PreferredFirstName <> '' AND STD.Str.Find(RIGHT.fname, LEFT.Clean_Input.Rep2_PreferredFirstName, 1) > 0);
																							Rep2AR2BFullFile					:= Business_Risk_BIP.Common.SetBoolean((Rep2AR2BFNameFile = '1' AND Rep2AR2BLNameFile = '1') OR (Rep2AR2BPreferredNameFile = '1' AND Rep2AR2BLNameFile = '1'));

																							Rep2InputAddrPopulated 		:= TRIM(LEFT.Clean_Input.Rep2_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep2_Zip5) <> '';
																							Rep2ZIPScore							:= IF(LEFT.Clean_Input.Rep2_Zip5 <> '' AND RIGHT.Zip <> '' AND LEFT.Clean_Input.Rep2_Zip5[1] = RIGHT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Rep2_Zip5, RIGHT.Zip), NoScoreValue);
																							Rep2StateMatched					:= STD.Str.ToUpperCase(LEFT.Clean_Input.Rep2_State) = STD.Str.ToUpperCase(RIGHT.st);
																							Rep2CityStateScore				:= IF(LEFT.Clean_Input.Rep2_City <> '' AND LEFT.Clean_Input.Rep2_State <> '' AND RIGHT.city_name <> '' AND RIGHT.st <> '' AND Rep2StateMatched,
																																					 Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.Rep2_City, LEFT.Clean_Input.Rep2_State, RIGHT.city_name, RIGHT.st, ''), NoScoreValue);
																							Rep2CityStateZipMatched		:= Rep2InputAddrPopulated AND Risk_Indicators.iid_constants.ga(Rep2ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep2CityStateScore);
																							Rep2InputAddrMatched			:= Rep2InputAddrPopulated AND Risk_Indicators.iid_constants.ga(IF(Rep2ZIPScore = NoScoreValue AND Rep2CityStateScore = NoScoreValue, NoScoreValue,
																																					 Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Rep2_Prim_Range, LEFT.Clean_Input.Rep2_Prim_Name, LEFT.Clean_Input.Rep2_Sec_Range,
																																					 RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range,
																																					 Rep2ZIPScore, Rep2CityStateScore)));

																							Rep2InputSSNPopulated 		:= (INTEGER)LEFT.Clean_Input.Rep2_SSN > 0;
																							Rep2SSNLength 						:= LENGTH(TRIM(LEFT.Clean_Input.Rep2_SSN));
																							Rep2InputSSNMatched 			:= MAP(NOT Rep2InputSSNPopulated																																	  => FALSE,
																																					 Rep2InputSSNPopulated AND LEFT.Clean_Input.Rep2_SSN[1] = RIGHT.SSN[IF(Rep2SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(LEFT.Clean_Input.Rep2_SSN, RIGHT.SSN, Rep2SSNLength=4)),
																																																																																							 FALSE);

																							Rep2InputPhonePopulated := TRIM(LEFT.Clean_Input.Rep2_Phone10) <> '';
																							Rep2InputPhoneMatched := Rep2InputPhonePopulated AND (LEFT.Clean_Input.Rep2_Phone10[1] = RIGHT.phone[1] OR LEFT.Clean_Input.Rep2_Phone10[4] = RIGHT.phone[4] OR LEFT.Clean_Input.Rep2_Phone10[4] = RIGHT.phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Rep2_Phone10, RIGHT.phone));

																							SELF.AR2BRep2NameBusHeaderLexID  := MAP(NOT Rep2InputNamePopulated 											 	=> '-1',
																																										  Rep2InputNamePopulated AND Rep2AR2BFullFile = '1' => '1',
																																																																					 '0');
																							SELF.AR2BRep2AddrBusHeaderLexID  := MAP(NOT Rep2InputAddrPopulated 										 		=> '-1',
																																										  Rep2InputAddrPopulated AND Rep2InputAddrMatched 	=> '1',
																																																																					 '0');
																							SELF.AR2BRep2PhoneBusHeaderLexID := MAP(NOT Rep2InputPhonePopulated 											=> '-1',
																																											Rep2InputPhonePopulated AND Rep2InputPhoneMatched => '1',
																																																																					 '0');
																							SELF.AR2BRep2SSNBusHeaderLexID 	 := MAP(NOT Rep2InputSSNPopulated 												=> '-1',
																																										  Rep2InputSSNPopulated AND Rep2InputSSNMatched 		=> '1',
																																																																					 '0');
																							// Verify with Representative 3 elements
																							Rep3InputNamePopulated 		:= TRIM(LEFT.Clean_Input.Rep3_FirstName) <> '' OR TRIM(LEFT.Clean_Input.Rep3_LastName) <> ''; // Populated if first or last are sent in
																							Rep3AR2BFNameFile 				:= Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep3_FirstName <> '' AND STD.Str.Find(RIGHT.fname, LEFT.Clean_Input.Rep3_FirstName, 1) > 0);
																							Rep3AR2BLNameFile 				:= Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep3_LastName <> '' AND STD.Str.Find(RIGHT.lname, LEFT.Clean_Input.Rep3_LastName, 1) > 0);
																							Rep3AR2BPreferredNameFile := Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep3_PreferredFirstName <> '' AND STD.Str.Find(RIGHT.fname, LEFT.Clean_Input.Rep3_PreferredFirstName, 1) > 0);
																							Rep3AR2BFullFile					:= Business_Risk_BIP.Common.SetBoolean((Rep3AR2BFNameFile = '1' AND Rep3AR2BLNameFile = '1') OR (Rep3AR2BPreferredNameFile = '1' AND Rep3AR2BLNameFile = '1'));

																							Rep3InputAddrPopulated 		:= TRIM(LEFT.Clean_Input.Rep3_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep3_Zip5) <> '';
																							Rep3ZIPScore							:= IF(LEFT.Clean_Input.Rep3_Zip5 <> '' AND RIGHT.Zip <> '' AND LEFT.Clean_Input.Rep3_Zip5[1] = RIGHT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Rep3_Zip5, RIGHT.Zip), NoScoreValue);
																							Rep3StateMatched					:= STD.Str.ToUpperCase(LEFT.Clean_Input.Rep3_State) = STD.Str.ToUpperCase(RIGHT.st);
																							Rep3CityStateScore				:= IF(LEFT.Clean_Input.Rep3_City <> '' AND LEFT.Clean_Input.Rep3_State <> '' AND RIGHT.city_name <> '' AND RIGHT.st <> '' AND Rep3StateMatched,
																																					 Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.Rep3_City, LEFT.Clean_Input.Rep3_State, RIGHT.city_name, RIGHT.st, ''), NoScoreValue);
																							Rep3CityStateZipMatched		:= Rep3InputAddrPopulated AND Risk_Indicators.iid_constants.ga(Rep3ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep3CityStateScore);
																							Rep3InputAddrMatched			:= Rep3InputAddrPopulated AND Risk_Indicators.iid_constants.ga(IF(Rep3ZIPScore = NoScoreValue AND Rep3CityStateScore = NoScoreValue, NoScoreValue,
																																					 Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Rep3_Prim_Range, LEFT.Clean_Input.Rep3_Prim_Name, LEFT.Clean_Input.Rep3_Sec_Range,
																																					 RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range,
																																					 Rep3ZIPScore, Rep3CityStateScore)));

																							Rep3InputSSNPopulated 		:= (INTEGER)LEFT.Clean_Input.Rep3_SSN > 0;
																							Rep3SSNLength 						:= LENGTH(TRIM(LEFT.Clean_Input.Rep3_SSN));
																							Rep3InputSSNMatched 			:= MAP(NOT Rep3InputSSNPopulated																																		  	=> FALSE,
																																							 Rep3InputSSNPopulated AND LEFT.Clean_Input.Rep3_SSN[1] = RIGHT.SSN[IF(Rep3SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(LEFT.Clean_Input.Rep3_SSN, RIGHT.SSN, Rep3SSNLength=4)),
																																																																																									 FALSE);

																							Rep3InputPhonePopulated 	:= TRIM(LEFT.Clean_Input.Rep3_Phone10) <> '';
																							Rep3InputPhoneMatched 		:= Rep3InputPhonePopulated AND (LEFT.Clean_Input.Rep3_Phone10[1] = RIGHT.phone[1] OR LEFT.Clean_Input.Rep3_Phone10[4] = RIGHT.phone[4] OR LEFT.Clean_Input.Rep3_Phone10[4] = RIGHT.phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Rep3_Phone10, RIGHT.phone));

																							SELF.AR2BRep3NameBusHeaderLexID  := MAP(NOT Rep3InputNamePopulated 											  => '-1',
																																										  Rep3InputNamePopulated AND Rep3AR2BFullFile = '1' => '1',
																																																																					 '0');
																							SELF.AR2BRep3AddrBusHeaderLexID  := MAP(NOT Rep3InputAddrPopulated 											 	=> '-1',
																																										  Rep3InputAddrPopulated AND Rep3InputAddrMatched 	=> '1',
																																																																					 '0');
																							SELF.AR2BRep3PhoneBusHeaderLexID := MAP(NOT Rep3InputPhonePopulated 											=> '-1',
																																											Rep3InputPhonePopulated AND Rep3InputPhoneMatched => '1',
																																																																				   '0');
																							SELF.AR2BRep3SSNBusHeaderLexID	 := MAP(NOT Rep3InputSSNPopulated 												=> '-1',
																																											Rep3InputSSNPopulated AND Rep3InputSSNMatched 		=> '1',
																																																																					 '0');

																							// Verify with Representative 4 elements
																							Rep4InputNamePopulated 		:= TRIM(LEFT.Clean_Input.Rep4_FirstName) <> '' OR TRIM(LEFT.Clean_Input.Rep4_LastName) <> ''; // Populated if first or last are sent in
																							Rep4AR2BFNameFile 				:= Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep4_FirstName <> '' AND STD.Str.Find(RIGHT.fname, LEFT.Clean_Input.Rep4_FirstName, 1) > 0);
																							Rep4AR2BLNameFile 				:= Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep4_LastName <> '' AND STD.Str.Find(RIGHT.lname, LEFT.Clean_Input.Rep4_LastName, 1) > 0);
																							Rep4AR2BPreferredNameFile := Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep4_PreferredFirstName <> '' AND STD.Str.Find(RIGHT.fname, LEFT.Clean_Input.Rep4_PreferredFirstName, 1) > 0);
																							Rep4AR2BFullFile					:= Business_Risk_BIP.Common.SetBoolean((Rep4AR2BFNameFile = '1' AND Rep4AR2BLNameFile = '1') OR (Rep4AR2BPreferredNameFile = '1' AND Rep4AR2BLNameFile = '1'));

																							Rep4InputAddrPopulated 		:= TRIM(LEFT.Clean_Input.Rep4_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep4_Zip5) <> '';
																							Rep4ZIPScore							:= IF(LEFT.Clean_Input.Rep4_Zip5 <> '' AND RIGHT.Zip <> '' AND LEFT.Clean_Input.Rep4_Zip5[1] = RIGHT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Rep4_Zip5, RIGHT.Zip), NoScoreValue);
																							Rep4StateMatched					:= STD.Str.ToUpperCase(LEFT.Clean_Input.Rep4_State) = STD.Str.ToUpperCase(RIGHT.st);
																							Rep4CityStateScore				:= IF(LEFT.Clean_Input.Rep4_City <> '' AND LEFT.Clean_Input.Rep4_State <> '' AND RIGHT.city_name <> '' AND RIGHT.st <> '' AND Rep4StateMatched,
																																					 Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.Rep4_City, LEFT.Clean_Input.Rep4_State, RIGHT.city_name, RIGHT.st, ''), NoScoreValue);
																							Rep4CityStateZipMatched		:= Rep4InputAddrPopulated AND Risk_Indicators.iid_constants.ga(Rep4ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep4CityStateScore);
																							Rep4InputAddrMatched			:= Rep4InputAddrPopulated AND Risk_Indicators.iid_constants.ga(IF(Rep4ZIPScore = NoScoreValue AND Rep4CityStateScore = NoScoreValue, NoScoreValue,
																																					 Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Rep4_Prim_Range, LEFT.Clean_Input.Rep4_Prim_Name, LEFT.Clean_Input.Rep4_Sec_Range,
																																					 RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range,
																																					 Rep4ZIPScore, Rep4CityStateScore)));

																							Rep4InputSSNPopulated 		:= (INTEGER)LEFT.Clean_Input.Rep4_SSN > 0;
																							Rep4SSNLength 						:= LENGTH(TRIM(LEFT.Clean_Input.Rep4_SSN));
																							Rep4InputSSNMatched 			:= MAP(NOT Rep4InputSSNPopulated																																	  => FALSE,
																																					 Rep4InputSSNPopulated AND LEFT.Clean_Input.Rep4_SSN[1] = RIGHT.SSN[IF(Rep4SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(LEFT.Clean_Input.Rep4_SSN, RIGHT.SSN, Rep4SSNLength=4)),
																																																																																							 FALSE);

																							Rep4InputPhonePopulated := TRIM(LEFT.Clean_Input.Rep4_Phone10) <> '';
																							Rep4InputPhoneMatched := Rep4InputPhonePopulated AND (LEFT.Clean_Input.Rep4_Phone10[1] = RIGHT.phone[1] OR LEFT.Clean_Input.Rep4_Phone10[4] = RIGHT.phone[4] OR LEFT.Clean_Input.Rep4_Phone10[4] = RIGHT.phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Rep4_Phone10, RIGHT.phone));

																							SELF.AR2BRep4NameBusHeaderLexID  := MAP(NOT Rep4InputNamePopulated 											 	=> '-1',
																																										  Rep4InputNamePopulated AND Rep4AR2BFullFile = '1' => '1',
																																																																					 '0');
																							SELF.AR2BRep4AddrBusHeaderLexID  := MAP(NOT Rep4InputAddrPopulated 										 		=> '-1',
																																										  Rep4InputAddrPopulated AND Rep4InputAddrMatched 	=> '1',
																																																																					 '0');
																							SELF.AR2BRep4PhoneBusHeaderLexID := MAP(NOT Rep4InputPhonePopulated 											=> '-1',
																																											Rep4InputPhonePopulated AND Rep4InputPhoneMatched => '1',
																																																																					 '0');
																							SELF.AR2BRep4SSNBusHeaderLexID 	 := MAP(NOT Rep4InputSSNPopulated 												=> '-1',
																																										  Rep4InputSSNPopulated AND Rep4InputSSNMatched 		=> '1',
																																																																					 '0');
																							// Verify with Representative 5 elements
																							Rep5InputNamePopulated 		:= TRIM(LEFT.Clean_Input.Rep5_FirstName) <> '' OR TRIM(LEFT.Clean_Input.Rep5_LastName) <> ''; // Populated if first or last are sent in
																							Rep5AR2BFNameFile 				:= Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep5_FirstName <> '' AND STD.Str.Find(RIGHT.fname, LEFT.Clean_Input.Rep5_FirstName, 1) > 0);
																							Rep5AR2BLNameFile 				:= Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep5_LastName <> '' AND STD.Str.Find(RIGHT.lname, LEFT.Clean_Input.Rep5_LastName, 1) > 0);
																							Rep5AR2BPreferredNameFile := Business_Risk_BIP.Common.SetBoolean(LEFT.Clean_Input.Rep5_PreferredFirstName <> '' AND STD.Str.Find(RIGHT.fname, LEFT.Clean_Input.Rep5_PreferredFirstName, 1) > 0);
																							Rep5AR2BFullFile					:= Business_Risk_BIP.Common.SetBoolean((Rep5AR2BFNameFile = '1' AND Rep5AR2BLNameFile = '1') OR (Rep5AR2BPreferredNameFile = '1' AND Rep5AR2BLNameFile = '1'));

																							Rep5InputAddrPopulated 		:= TRIM(LEFT.Clean_Input.Rep5_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep5_Zip5) <> '';
																							Rep5ZIPScore							:= IF(LEFT.Clean_Input.Rep5_Zip5 <> '' AND RIGHT.Zip <> '' AND LEFT.Clean_Input.Rep5_Zip5[1] = RIGHT.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Rep5_Zip5, RIGHT.Zip), NoScoreValue);
																							Rep5StateMatched					:= STD.Str.ToUpperCase(LEFT.Clean_Input.Rep5_State) = STD.Str.ToUpperCase(RIGHT.st);
																							Rep5CityStateScore				:= IF(LEFT.Clean_Input.Rep5_City <> '' AND LEFT.Clean_Input.Rep5_State <> '' AND RIGHT.city_name <> '' AND RIGHT.st <> '' AND Rep5StateMatched,
																																					 Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.Rep5_City, LEFT.Clean_Input.Rep5_State, RIGHT.city_name, RIGHT.st, ''), NoScoreValue);
																							Rep5CityStateZipMatched		:= Rep5InputAddrPopulated AND Risk_Indicators.iid_constants.ga(Rep5ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep5CityStateScore);
																							Rep5InputAddrMatched			:= Rep5InputAddrPopulated AND Risk_Indicators.iid_constants.ga(IF(Rep5ZIPScore = NoScoreValue AND Rep5CityStateScore = NoScoreValue, NoScoreValue,
																																					 Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Rep5_Prim_Range, LEFT.Clean_Input.Rep5_Prim_Name, LEFT.Clean_Input.Rep5_Sec_Range,
																																					 RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range,
																																					 Rep5ZIPScore, Rep5CityStateScore)));

																							Rep5InputSSNPopulated 		:= (INTEGER)LEFT.Clean_Input.Rep5_SSN > 0;
																							Rep5SSNLength 						:= LENGTH(TRIM(LEFT.Clean_Input.Rep5_SSN));
																							Rep5InputSSNMatched 			:= MAP(NOT Rep5InputSSNPopulated																																		  	=> FALSE,
																																							 Rep5InputSSNPopulated AND LEFT.Clean_Input.Rep5_SSN[1] = RIGHT.SSN[IF(Rep5SSNLength = 4, 6, 1)]	=> Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(LEFT.Clean_Input.Rep5_SSN, RIGHT.SSN, Rep5SSNLength=4)),
																																																																																									 FALSE);

																							Rep5InputPhonePopulated 	:= TRIM(LEFT.Clean_Input.Rep5_Phone10) <> '';
																							Rep5InputPhoneMatched 		:= Rep5InputPhonePopulated AND (LEFT.Clean_Input.Rep5_Phone10[1] = RIGHT.phone[1] OR LEFT.Clean_Input.Rep5_Phone10[4] = RIGHT.phone[4] OR LEFT.Clean_Input.Rep5_Phone10[4] = RIGHT.phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Rep5_Phone10, RIGHT.phone));

																							SELF.AR2BRep5NameBusHeaderLexID  := MAP(NOT Rep5InputNamePopulated 											  => '-1',
																																										  Rep5InputNamePopulated AND Rep5AR2BFullFile = '1' => '1',
																																																																					 '0');
																							SELF.AR2BRep5AddrBusHeaderLexID  := MAP(NOT Rep5InputAddrPopulated 											 	=> '-1',
																																										  Rep5InputAddrPopulated AND Rep5InputAddrMatched 	=> '1',
																																																																					 '0');
																							SELF.AR2BRep5PhoneBusHeaderLexID := MAP(NOT Rep5InputPhonePopulated 											=> '-1',
																																											Rep5InputPhonePopulated AND Rep5InputPhoneMatched => '1',
																																																																				   '0');
																							SELF.AR2BRep5SSNBusHeaderLexID	 := MAP(NOT Rep5InputSSNPopulated 												=> '-1',
																																											Rep5InputSSNPopulated AND Rep5InputSSNMatched 		=> '1',
																																																																					 '0')),


																	LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));

		ConsumerShellContactVerificationRolled := ROLLUP(SORT(ConsumerShellContactVerification, Seq), LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(tempConsumerContactVerLayout,
																							SELF.Seq := LEFT.Seq,
																							SELF.AR2BRep1NameBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep1NameBusHeaderLexID, (INTEGER)RIGHT.AR2BRep1NameBusHeaderLexID);
																							SELF.AR2BRep1AddrBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep1AddrBusHeaderLexID, (INTEGER)RIGHT.AR2BRep1AddrBusHeaderLexID);
																							SELF.AR2BRep1PhoneBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep1PhoneBusHeaderLexID, (INTEGER)RIGHT.AR2BRep1PhoneBusHeaderLexID);
																							SELF.AR2BRep1SSNBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep1SSNBusHeaderLexID, (INTEGER)RIGHT.AR2BRep1SSNBusHeaderLexID);
																							SELF.AR2BRep2NameBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep2NameBusHeaderLexID, (INTEGER)RIGHT.AR2BRep2NameBusHeaderLexID);
																							SELF.AR2BRep2AddrBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep2AddrBusHeaderLexID, (INTEGER)RIGHT.AR2BRep2AddrBusHeaderLexID);
																							SELF.AR2BRep2PhoneBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep2PhoneBusHeaderLexID, (INTEGER)RIGHT.AR2BRep2PhoneBusHeaderLexID);
																							SELF.AR2BRep2SSNBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep2SSNBusHeaderLexID, (INTEGER)RIGHT.AR2BRep2SSNBusHeaderLexID);
																							SELF.AR2BRep3NameBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep3NameBusHeaderLexID, (INTEGER)RIGHT.AR2BRep3NameBusHeaderLexID);
																							SELF.AR2BRep3AddrBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep3AddrBusHeaderLexID, (INTEGER)RIGHT.AR2BRep3AddrBusHeaderLexID);
																							SELF.AR2BRep3PhoneBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep3PhoneBusHeaderLexID, (INTEGER)RIGHT.AR2BRep3PhoneBusHeaderLexID);
																							SELF.AR2BRep3SSNBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep3SSNBusHeaderLexID, (INTEGER)RIGHT.AR2BRep3SSNBusHeaderLexID);
																							SELF.AR2BRep4NameBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep4NameBusHeaderLexID, (INTEGER)RIGHT.AR2BRep4NameBusHeaderLexID);
																							SELF.AR2BRep4AddrBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep4AddrBusHeaderLexID, (INTEGER)RIGHT.AR2BRep4AddrBusHeaderLexID);
																							SELF.AR2BRep4PhoneBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep4PhoneBusHeaderLexID, (INTEGER)RIGHT.AR2BRep4PhoneBusHeaderLexID);
																							SELF.AR2BRep4SSNBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep4SSNBusHeaderLexID, (INTEGER)RIGHT.AR2BRep4SSNBusHeaderLexID);
																							SELF.AR2BRep5NameBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep5NameBusHeaderLexID, (INTEGER)RIGHT.AR2BRep5NameBusHeaderLexID);
																							SELF.AR2BRep5AddrBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep5AddrBusHeaderLexID, (INTEGER)RIGHT.AR2BRep5AddrBusHeaderLexID);
																							SELF.AR2BRep5PhoneBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep5PhoneBusHeaderLexID, (INTEGER)RIGHT.AR2BRep5PhoneBusHeaderLexID);
																							SELF.AR2BRep5SSNBusHeaderLexID := (STRING)MAX((INTEGER)LEFT.AR2BRep5SSNBusHeaderLexID, (INTEGER)RIGHT.AR2BRep5SSNBusHeaderLexID)));
		withConsumerShellContactVerification := JOIN(WithRepPhoneVerification, ConsumerShellContactVerificationRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Seq := LEFT.Seq,
																							SELF.Business_To_Executive_Link.AR2BRep1NameBusHeaderLexID := RIGHT.AR2BRep1NameBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep1AddrBusHeaderLexID := RIGHT.AR2BRep1AddrBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep1PhoneBusHeaderLexID := RIGHT.AR2BRep1PhoneBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep1SSNBusHeaderLexID := RIGHT.AR2BRep1SSNBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep2NameBusHeaderLexID := RIGHT.AR2BRep2NameBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep2AddrBusHeaderLexID := RIGHT.AR2BRep2AddrBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep2PhoneBusHeaderLexID := RIGHT.AR2BRep2PhoneBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep2SSNBusHeaderLexID := RIGHT.AR2BRep2SSNBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep3NameBusHeaderLexID := RIGHT.AR2BRep3NameBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep3AddrBusHeaderLexID := RIGHT.AR2BRep3AddrBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep3PhoneBusHeaderLexID := RIGHT.AR2BRep3PhoneBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep3SSNBusHeaderLexID := RIGHT.AR2BRep3SSNBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep4NameBusHeaderLexID := RIGHT.AR2BRep4NameBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep4AddrBusHeaderLexID := RIGHT.AR2BRep4AddrBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep4PhoneBusHeaderLexID := RIGHT.AR2BRep4PhoneBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep4SSNBusHeaderLexID := RIGHT.AR2BRep4SSNBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep5NameBusHeaderLexID := RIGHT.AR2BRep5NameBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep5AddrBusHeaderLexID := RIGHT.AR2BRep5AddrBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep5PhoneBusHeaderLexID := RIGHT.AR2BRep5PhoneBusHeaderLexID,
																							SELF.Business_To_Executive_Link.AR2BRep5SSNBusHeaderLexID := RIGHT.AR2BRep5SSNBusHeaderLexID,
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);


	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(ShellSearchRecords, 100), NAMED('Sample_ShellSearchRecords'));
	// OUTPUT(CHOOSEN(ConsumerHeaderAddrRaw, 100), NAMED('Sample_ConsumerHeaderAddrRaw'));
	// OUTPUT(CHOOSEN(ConsumerHeaderAddr, 100), NAMED('Sample_ConsumerHeaderAddr'));
	// OUTPUT(CHOOSEN(ConsumerHeaderAddrStats, 100), NAMED('Sample_ConsumerHeaderAddrStats'));
	// OUTPUT(CHOOSEN(withConsumerHeaderAddr, 100), NAMED('Sample_withConsumerHeaderAddr'));
	// OUTPUT(CHOOSEN(FEINSSN_DIDs, 100), NAMED('Sample_FEINSSN_DIDs'));
	// OUTPUT(CHOOSEN(uniqueDIDs, 100), NAMED('Sample_uniqueDIDs'));
	// OUTPUT(CHOOSEN(ConsumerHeaderDIDRaw, 100), NAMED('Sample_ConsumerHeaderDIDRaw'));
	// OUTPUT(CHOOSEN(ConsumerHeaderDID, 100), NAMED('Sample_ConsumerHeaderDID'));
	// OUTPUT(CHOOSEN(ConsumerHeaderDIDStats, 100), NAMED('Sample_ConsumerHeaderDIDStats'));
	// OUTPUT(CHOOSEN(ConsumerHeaderDIDCounts, 100), NAMED('Sample_ConsumerHeaderDIDCounts'));
	// OUTPUT(CHOOSEN(withConsumerHeaderDID, 100), NAMED('Sample_withConsumerHeaderDID'));
	// OUTPUT(CHOOSEN(withDeceasedFlag, 100), NAMED('Sample_withDeceasedFlag'));
	// OUTPUT(CHOOSEN(HeaderRelatives, 100), NAMED('Sample_HeaderRelatives'));
	// OUTPUT(CHOOSEN(seqRelativeHHInfo, 100), NAMED('Sample_seqRelativeHHInfo'));
	// OUTPUT(CHOOSEN(AssociateVerification, 100), NAMED('Sample_AssociateVerificati0on'));
	// OUTPUT(CHOOSEN(RollAssociateVerification, 100), NAMED('Sample_RollAssociateVerification'));
	// OUTPUT(CHOOSEN(ContactVerification, 100), NAMED('Sample_ContactVerification'));
	// OUTPUT(CHOOSEN(RollContactVerification, 100), NAMED('Sample_RollContactVerification'));
	// OUTPUT(CHOOSEN(ConsumerShellContactInfo, 100), NAMED('Sample_ConsumerShellContactInfo'));
	// OUTPUT(CHOOSEN(ConsumerShellContactVerification, 100), NAMED('Sample_ConsumerShellContactVerification'));
  // OUTPUT(CHOOSEN(ConsumerShellContactVerificationRolled, 100), NAMED('Sample_ConsumerShellContactVerificationRolled'));
	RETURN IF(shell_version <= Business_Risk_BIP.Constants.BusShellVersion_v21, withDeceasedFlag, withConsumerShellContactVerification);
END;
