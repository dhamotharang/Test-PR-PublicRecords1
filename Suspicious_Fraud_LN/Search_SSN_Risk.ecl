IMPORT AutoKey, Death_Master, Doxie, Doxie_Files, Drivers, Header, Header_Quick, /*Inquiry_AccLogs,*/ MDR, Risk_Indicators, RiskWise, 
Suspicious_Fraud_LN, UT,AutoStandardI,DeathV2_Services, Relationship, STD;

EXPORT Suspicious_Fraud_LN.layouts.Layout_Batch_Plus Search_SSN_Risk (DATASET(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus) Input,
																																			DATASET(Suspicious_Fraud_LN.layouts.Layout_SSN_Inquiries) Inquiries,
																																			UNSIGNED1 DPPAPurpose,
																																			UNSIGNED1 GLBPurpose,
																																			STRING50 DataRestrictionMask) := FUNCTION
  unsigned4 todays_date := STD.Date.Today ();

	// SSN Indexed Keys Used
	FullHeaderSSNKey := Doxie.Key_Header_SSN;
	FastHeaderSSNKey := AutoKey.Key_SSN(Header_Quick.Str_AutoKeyName);
	FullHeaderKey := Doxie.Key_Header;
	FastHeaderKey := Header_Quick.Key_DID;
	DeathMasterKey := Death_Master.Key_SSN_SSA(isFCRA := FALSE);
	MinorsKey := Doxie_Files.Key_Minors_Hash;
	RiskTableKey := Risk_Indicators.Key_SSN_Table_V4_2;
	
	headerBuild := CHOOSEN(Doxie.Key_Max_Dt_Last_Seen, 1);
	headerBuildDate := ((STRING)headerBuild[1].Max_Date_Last_Seen)[1..6];
	deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
	
	sixMonths := Risk_Indicators.iid_constants.sixmonths;
	threeMonths := ROUND(sixMonths / 2);
	twoMonths := ROUND(sixMonths / 3);
	
  mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
    EXPORT unsigned1 glb := GLBPurpose;
    EXPORT unsigned1 dppa := DPPAPurpose;	
    EXPORT string DataRestrictionMask := ^.DataRestrictionMask;
  END;
  glb_ok := mod_access.isValidGLB();
  dppa_ok := mod_access.isValidDPPA();
	
	// Temporary Header Layout - Used for Calculating Header Based Risk Codes
	TempHeader := RECORD
		UNSIGNED8 Seq := 0;
		UNSIGNED8 InputDID := 0; // The DID we got based on input
		UNSIGNED8 DID := 0; // The DID we got from the header
		STRING9 SSN := ''; // Input SSN
		STRING10 Prim_Range := ''; // Address from the header
		STRING28 Prim_Name := '';
		STRING5 Zip5 := '';
		STRING3 Source := ''; // Source code on header
		STRING8 DateOfBirth := ''; // Date of Birth on Header
		STRING8 TodaysDate := ''; // Either system date for realtime, or ArchiveDate for historical mode
		STRING8 Date_First_Seen := ''; // Date record first seen on header
		STRING8 Date_Last_Seen := ''; // Date record last seen on header
		STRING6 Date_First_Age := ''; // Age of the header record calculated by first seen date
		STRING6 Date_Last_Age := ''; // Age of the header record calculated by last seen date
		STRING8 SSN_First_Seen := ''; // Across all header records, date SSN was first seen
		STRING8 SSN_Last_Seen := ''; // Across all header records, date SSN was last seen
		STRING6 SSN_First_Seen_Age := ''; // Age of the SSN calculated by SSN_First_Seen
		STRING6 SSN_Last_Seen_Age := ''; // Age of the SSN calculated by SSN_Last_Seen
		STRING8 Identity_First_Seen := ''; // Across all header records, date that SSN/DID combo was first seen
		STRING8 Identity_Last_Seen := ''; // Across all header records, date that SSN/DID combo was last seen
		STRING6 Identity_Age := ''; // Age of the SSN/DID combo calculated by Identity_First_Seen
		STRING8 Address_First_Seen := ''; // Across all header records, date that SSN/Address combo was first seen
		STRING8 Address_Last_Seen := ''; // Across all header records, date that SSN/Address combo was last seen
		STRING6 Address_Age := ''; // Age of the SSN/Address combo calculated by Address_First_Seen
		UNSIGNED2 UniqueDIDCount := 0; // Number of unique DID's associated with SSN on header
		UNSIGNED2 UniqueDIDCount2Months := 0; // Number of unique DID's associated with SSN on header with last seen dates <= 2 Months
		UNSIGNED2 UniqueRecentDIDCount := 0; // Number of unique DID's first associated with SSN on header within last 6 months
		BOOLEAN isRelative := FALSE; // Does the discovered DID by SSN exist on the relatives/associates key for the input DID
		UNSIGNED2 UniqueNonRelativeDIDCount := 0; // Number of unique non-relative DID's associated with SSN on header
		UNSIGNED2 UniqueIdentityCount := 0; // Number of unique DID's associated with SSN on header that have 2 or more different header sources
		UNSIGNED2 UniqueNonRelativeIdentityCount := 0; // Same as UniqueIdentityCount excluding relative DID's
		UNSIGNED2 UniqueNonRelativeIdentityCount2Months := 0; // Same as UniqueIdentityCount excluding relative DID's with last seen dates <= 2 Months
		UNSIGNED2 UniqueRecentAddressCount := 0; // Number of addresses associated with SSN first seen within the last 3 months
		UNSIGNED2 UniqueAddressCount := 0; // Number of addresses associated with SSN
		UNSIGNED2 SourceCount := 0; // Number of unique header sources confirming SSN/DID combination
		UNSIGNED2 CreditBureauSourceCount := 0; // Number of unique credit bureau sources confirming SSN/DID combination
		UNSIGNED4 ArchiveDate := 0;
		BOOLEAN Came_From_FastHeader := FALSE; // Indicates header record came from the fast header and not the full header
	END;
	
	// Get a list of DID's associated with the input SSN's so that we can search the full header
	HeaderSSNMac (TransformName, KeyName) := MACRO
	TempHeader TransformName(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, KeyName ri, BOOLEAN fastHeader) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.InputDID := le.Clean_Input.DID;
		SELF.DID := ri.DID;
		SELF.SSN := le.Clean_Input.SSN;
		SELF.UniqueDIDCount := 1; // Will be rolled up later on
		SELF.UniqueNonRelativeDIDCount := 1; // Will be rolled up later on
		
		SELF.ArchiveDate := le.Clean_Input.ArchiveDate;
		
		SELF.Came_From_FastHeader := fastHeader;
		
		SELF := [];
	END;
	ENDMACRO;
	HeaderSSNMac (GetHeaderSSN, FullHeaderSSNKey);
	HeaderSSNMac (GetFastHeaderSSN, FastHeaderSSNKey);
	
	fullHeaderSSN := JOIN(Input, FullHeaderSSNKey, (UNSIGNED)LEFT.Clean_Input.SSN <> 0 AND 
																									KEYED(LEFT.Clean_Input.SSN[1] = RIGHT.s1 AND
																												LEFT.Clean_Input.SSN[2] = RIGHT.s2 AND
																												LEFT.Clean_Input.SSN[3] = RIGHT.s3 AND
																												LEFT.Clean_Input.SSN[4] = RIGHT.s4 AND
																												LEFT.Clean_Input.SSN[5] = RIGHT.s5 AND
																												LEFT.Clean_Input.SSN[6] = RIGHT.s6 AND
																												LEFT.Clean_Input.SSN[7] = RIGHT.s7 AND
																												LEFT.Clean_Input.SSN[8] = RIGHT.s8 AND
																												LEFT.Clean_Input.SSN[9] = RIGHT.s9),
																		GetHeaderSSN(LEFT, RIGHT, FALSE), KEEP(500), ATMOST(RiskWise.max_atmost));
	fastHeaderSSN := JOIN(Input, FastHeaderSSNKey, (UNSIGNED)LEFT.Clean_Input.SSN <> 0 AND 
																									KEYED(LEFT.Clean_Input.SSN[1] = RIGHT.s1 AND
																												LEFT.Clean_Input.SSN[2] = RIGHT.s2 AND
																												LEFT.Clean_Input.SSN[3] = RIGHT.s3 AND
																												LEFT.Clean_Input.SSN[4] = RIGHT.s4 AND
																												LEFT.Clean_Input.SSN[5] = RIGHT.s5 AND
																												LEFT.Clean_Input.SSN[6] = RIGHT.s6 AND
																												LEFT.Clean_Input.SSN[7] = RIGHT.s7 AND
																												LEFT.Clean_Input.SSN[8] = RIGHT.s8 AND
																												LEFT.Clean_Input.SSN[9] = RIGHT.s9),
																		GetFastHeaderSSN(LEFT, RIGHT, TRUE), KEEP(500), ATMOST(RiskWise.max_atmost));
																		
	uniqueHeaderSSN := DEDUP(SORT((fullHeaderSSN + fastHeaderSSN), Seq, SSN, DID), Seq, SSN, DID);
	
	
	// Translate the QH and WH Equifax Fast Header sources to EQ
	translateSrc (STRING3 src) := IF(src IN [MDR.SourceTools.src_Equifax_Quick, MDR.SourceTools.src_Equifax_Weekly], MDR.SourceTools.src_Equifax, src);
	

	headerRecs := JOIN(uniqueHeaderSSN, FullHeaderKey, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.s_DID) AND (LEFT.SSN = RIGHT.SSN OR (UNSIGNED)RIGHT.SSN = 0) AND
																												translateSrc(RIGHT.src) NOT IN Risk_Indicators.iid_constants.masked_header_sources(DataRestrictionMask, isFCRA := FALSE) AND
																												(Header.isPreGLB(RIGHT) OR Risk_Indicators.iid_constants.glb_ok(mod_access.glb, isFCRA := FALSE)) AND
																												(~MDR.Source_is_DPPA(translateSrc(RIGHT.src)) OR (Risk_Indicators.iid_constants.dppa_ok(mod_access.dppa, isFCRA := FALSE) AND Drivers.state_dppa_ok(Header.TranslateSource(translateSrc(RIGHT.src)), mod_access.dppa, translateSrc(RIGHT.src)))) AND
																												~Risk_Indicators.iid_constants.filtered_source(translateSrc(RIGHT.src), RIGHT.st) AND
																												((RIGHT.dt_first_seen < LEFT.ArchiveDate AND RIGHT.dt_first_seen <> 0) 
																														OR
																												(RIGHT.dt_vendor_first_reported < LEFT.ArchiveDate AND RIGHT.dt_first_seen = 0)),
																												transform(right), ATMOST(ut.Limits.Header_Per_DID));																								
	Header.MAC_GlbClean_Header(headerRecs, headerRecsCleaned, , , mod_access);
	
	// Get the header records for those DID's which match on SSN
	HeaderDIDMac (TransformName, KeyName) := MACRO
	TempHeader TransformName(TempHeader le, KeyName ri, BOOLEAN fastHeader) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.InputDID := le.InputDID;
		SELF.DID := le.DID;
		SELF.SSN := le.SSN;
		SELF.Came_From_FastHeader := fastHeader;
		
		SELF.Prim_Range := ri.Prim_Range;
		SELF.Prim_Name := ri.Prim_Name;
		SELF.Zip5 := ri.Zip;
		SELF.Source := translateSrc(ri.src);
		SELF.DateOfBirth := (STRING)ri.dob;
		dt_lastTemp := MAP(ri.dt_last_seen <> 0 																																					=> ri.dt_last_seen,
										ri.dt_vendor_last_reported <> 0 AND ri.src != MDR.SourceTools.src_TU_CreditHeader AND ~fastHeader	=> ri.dt_vendor_last_reported, // Don't trust vendor dates from TransUnion credit header or any FAST Header source
										ri.dt_first_seen <> 0 																																						=> ri.dt_first_seen,
										ri.src != MDR.SourceTools.src_TU_CreditHeader AND ~fastHeader 																		=> ri.dt_vendor_first_reported, // Don't trust vendor dates from TransUnion credit header or any FAST Header source
																																																												 0);
		dt_last := IF(dt_lastTemp >= le.ArchiveDate, le.ArchiveDate, dt_lastTemp);
		
		dt_first := MAP(ri.src IN [MDR.SourceTools.src_Equifax_Quick, MDR.SourceTools.src_Equifax_Weekly]	=> ri.dt_first_seen, // If Quick or Weekly header then use that first seen
										ri.dt_first_seen <> 0																															=> ri.dt_first_seen,
										dt_last <= ri.dt_vendor_first_reported																						=> dt_last, // make sure the dt_first is <= dt_last
										ri.src != MDR.SourceTools.src_TU_CreditHeader																			=> ri.dt_vendor_first_reported, // Don't trust vendor dates from TransUnion Credit Header
																																																				 0);
		// If the Archive Date was before the last header build date, use the Archive Date as todays date
		todaysDate := IF(headerBuildDate >= (STRING)le.ArchiveDate, (STRING)le.ArchiveDate, headerBuildDate);
		SELF.TodaysDate := todaysDate;
		dateFirstAge := IF(dt_first = 0, '-1', (STRING)ut.DaysApart((STRING)dt_first, todaysDate));
		dateLastAge := IF(dt_last = 0, '-1', (STRING)ut.DaysApart((STRING)dt_last, todaysDate));
		SELF.Date_First_Seen := (STRING8)dt_first;
		SELF.Date_Last_Seen := (STRING8)dt_last;
		SELF.Date_First_Age := IF((UNSIGNED)todaysDate < dt_first OR dt_first = 0, '-1', dateFirstAge);
		SELF.Date_Last_Age := IF((UNSIGNED)todaysDate < dt_last OR dt_last = 0, '-1', dateLastAge);
		SELF.SSN_First_Seen := (STRING8)dt_first;
		SELF.SSN_Last_Seen := (STRING8)dt_last;
		SELF.SSN_First_Seen_Age := '0'; // Calculated later
		SELF.SSN_Last_Seen_Age := '0'; // Calculated later
		SELF.Identity_First_Seen := (STRING8)dt_first;
		SELF.Identity_Last_Seen := (STRING8)dt_last;
		SELF.Identity_Age := '0'; // Calculated later
		SELF.Address_First_Seen := (STRING8)dt_first;
		SELF.Address_Last_Seen := (STRING8)dt_last;
		SELF.Address_Age := '0'; // Calculated later
		SELF.UniqueDIDCount := 1; // Will be rolled up later on
		SELF.UniqueDIDCount2Months := IF((UNSIGNED)dateLastAge <= twoMonths AND dateLastAge <> '-1', 1, 0);
		SELF.UniqueIdentityCount := 1; // Will be rolled up later on
		SELF.UniqueRecentDIDCount := IF((UNSIGNED)dateFirstAge <= sixMonths AND dateFirstAge <> '-1', 1, 0);
		SELF.UniqueNonRelativeDIDCount := 1; // Will be rolled up later on
		SELF.UniqueAddressCount := 1; // Will be rolled up later on
		SELF.SourceCount := 1; // Will be rolled up later on
		// Count if the source is one of the 3 credit bureaus
		SELF.CreditBureauSourceCount := IF(translateSrc(ri.src) IN [MDR.SourceTools.src_Equifax, MDR.SourceTools.src_Experian_Credit_Header, MDR.SourceTools.src_TU_CreditHeader], 1, 0); // Will be rolled up later on
		
		SELF.ArchiveDate := le.ArchiveDate;
		SELF := le;
	END;
	ENDMACRO;
	HeaderDIDMac (GetHeaderDID, headerRecsCleaned);
	HeaderDIDMac (GetFastHeaderDID, FastHeaderKey);
	
	// Make sure the SSN matches what's on the header, or that the header record doesn't have SSN populated.
	fullHeaderDID := JOIN(uniqueHeaderSSN, headerRecsCleaned, LEFT.DID <> 0 AND LEFT.DID = RIGHT.s_DID AND (LEFT.SSN = RIGHT.SSN OR (UNSIGNED)RIGHT.SSN = 0) AND
																												/*Source conditions satisfied by headerRecsCleaned*/
																												((RIGHT.dt_first_seen < LEFT.ArchiveDate AND RIGHT.dt_first_seen <> 0) 
																														OR
																												(RIGHT.dt_vendor_first_reported < LEFT.ArchiveDate AND RIGHT.dt_first_seen = 0)),
																		GetHeaderDID(LEFT, RIGHT, FALSE), LIMIT(ut.Limits.Header_Per_DID, SKIP));
																		
	fastHeaderDID := JOIN(uniqueHeaderSSN, FastHeaderKey, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.DID) AND (LEFT.SSN = RIGHT.SSN OR (UNSIGNED)RIGHT.SSN = 0) AND
																												translateSrc(RIGHT.src) NOT IN Risk_Indicators.iid_constants.masked_header_sources(DataRestrictionMask, isFCRA := FALSE) AND
																												(Header.isPreGLB(RIGHT) OR Risk_Indicators.iid_constants.glb_ok(mod_access.glb, isFCRA := FALSE)) AND
																												(~MDR.Source_is_DPPA(translateSrc(RIGHT.src)) OR (Risk_Indicators.iid_constants.dppa_ok(mod_access.dppa, isFCRA := FALSE) AND Drivers.state_dppa_ok(Header.TranslateSource(translateSrc(RIGHT.src)), mod_access.dppa, translateSrc(RIGHT.src)))) AND
																												~Risk_Indicators.iid_constants.filtered_source(translateSrc(RIGHT.src), RIGHT.st) AND
																												((RIGHT.dt_first_seen < LEFT.ArchiveDate AND RIGHT.dt_first_seen <> 0) 
																														OR
																												(RIGHT.dt_vendor_first_reported < LEFT.ArchiveDate AND RIGHT.dt_first_seen = 0)),
																		GetFastHeaderDID(LEFT, RIGHT, TRUE), ATMOST(ut.Limits.Header_Per_DID));
																		
	headerDID := SORT(fullHeaderDID + fastHeaderDID, Seq, SSN, DID, -Date_Last_Seen, -Date_First_Seen, Prim_Range, Prim_Name, Zip5, Source, ArchiveDate);
	
	// Calculate the Dates First and Last Seen as well as the DateOfBirth for the DID/SSN Combo (Identity)
	TempHeader getIdentityDates(TempHeader le, TempHeader ri) := TRANSFORM
		SELF.Identity_First_Seen := MAP((UNSIGNED)le.Identity_First_Seen = 0	=> ri.Identity_First_Seen,
																		(UNSIGNED)ri.Identity_First_Seen = 0	=> le.Identity_First_Seen,
																																						 (STRING8)MIN((UNSIGNED)le.Identity_First_Seen, (UNSIGNED)ri.Identity_First_Seen));
		SELF.Identity_Last_Seen := (STRING8)MAX((UNSIGNED)le.Identity_Last_Seen, (UNSIGNED)ri.Identity_Last_Seen);
		validLeftDOB := Doxie.DOBTools((UNSIGNED)le.DateOfBirth).IsValidDOB;
		validRightDOB := Doxie.DOBTools((UNSIGNED)ri.DateOfBirth).IsValidDOB;
		SELF.DateOfBirth := MAP(~validLeftDOB AND validRightDOB	=> ri.DateOfBirth,
														~validRightDOB AND validLeftDOB	=> le.DateOfBirth,
														validLeftDOB AND validRightDOB	=> (STRING8)MIN((UNSIGNED)le.DateOfBirth, (UNSIGNED)ri.DateOfBirth),
																																							 '0' // If it's not a valid DateOfBirth, set it to 0 - we don't know DOB.
														);
		SELF := le;
	END;
	identityDates := ROLLUP(headerDID, LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID AND LEFT.SSN = RIGHT.SSN, getIdentityDates(LEFT, RIGHT));
	
	TempHeader getIdentityAge(TempHeader le, TempHeader ri) := TRANSFORM
		recordAge := ut.DaysApart(ri.Identity_First_Seen, le.TodaysDate);
		SELF.Identity_First_Seen := ri.Identity_First_Seen;
		SELF.Identity_Last_Seen := ri.Identity_Last_Seen;
		SELF.DateOfBirth := ri.DateOfBirth;
		SELF.Identity_Age := IF(le.TodaysDate < ri.Identity_First_Seen OR (UNSIGNED)ri.Identity_First_Seen = 0, '0', (STRING)recordAge); // Age in days
		SELF.UniqueRecentDIDCount := IF(recordAge <= sixMonths, 1, 0);
		SELF := le;
	END;
	headerIdentityDID := JOIN(headerDID, identityDates, LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID AND LEFT.SSN = RIGHT.SSN, 
																							getIdentityAge(LEFT, RIGHT), LEFT OUTER, ATMOST(ut.Limits.Header_Per_DID));
	
	// Calculate the unique source counts for the DID/SSN Combo
	uniqueSourceDID := DEDUP(SORT(headerDID, Seq, DID, SSN, Source), Seq, DID, SSN, Source);
	TempHeader getSourceCounts(TempHeader le, TempHeader ri) := TRANSFORM
		SELF.SourceCount := le.SourceCount + ri.SourceCount;
		SELF.CreditBureauSourceCount := le.CreditBureauSourceCount + ri.CreditBureauSourceCount;
		SELF := le;
	END;
	sourceCounts := ROLLUP(uniqueSourceDID, LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID AND LEFT.SSN = RIGHT.SSN, getSourceCounts(LEFT, RIGHT));
	
	headerSourceCountsDID := JOIN(headerIdentityDID, sourceCounts, LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID AND LEFT.SSN = RIGHT.SSN, 
																							TRANSFORM(TempHeader, SELF.SourceCount := RIGHT.SourceCount; 
																																		SELF.CreditBureauSourceCount := RIGHT.CreditBureauSourceCount; 
																																		SELF := LEFT), LEFT OUTER, ATMOST(ut.Limits.Header_Per_DID));
	
	// Calculate the unique did counts for the SSN and figure out if a DID is a relatives DID
	uniqueDIDs := DEDUP(SORT(headerDID, Seq, DID, SSN), Seq, DID, SSN);

	uRelatDids := PROJECT(uniqueDIDs, 
		TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));

	rellyids := Relationship.proc_GetRelationship(uRelatDids,TopNCount:=500,
			RelativeFlag :=TRUE,AssociateFlag:=TRUE,
			doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result; 
	

	headerRelativeDID := JOIN(uniqueDIDs, rellyids, LEFT.InputDID <> 0 AND LEFT.InputDID = RIGHT.did1 AND LEFT.DID = RIGHT.did2, // The DID on the header matches the relatives DID
																							TRANSFORM(TempHeader, SELF.isRelative := IF(LEFT.DID = RIGHT.did2, TRUE, FALSE);
																																		SELF.UniqueNonRelativeDIDCount := IF(LEFT.DID = RIGHT.did2, 0, 1);
																																		SELF.UniqueNonRelativeIdentityCount := IF(LEFT.DID = RIGHT.did2, 0, 1);
																																		SELF.UniqueNonRelativeIdentityCount2Months := IF(LEFT.DID = RIGHT.did2 AND LEFT.UniqueDIDCount2Months = 1, 0, 1); // If LEFT.UniqueDIDCount2Months = 1 then this DID was last seen within past 2 months
																																		SELF := LEFT), LEFT OUTER);
	TempHeader getDIDCounts(TempHeader le, TempHeader ri) := TRANSFORM
		SELF.UniqueDIDCount := le.UniqueDIDCount + ri.UniqueDIDCount;
		SELF.UniqueDIDCount2Months := le.UniqueDIDCount2Months + ri.UniqueDIDCount2Months;
		SELF.UniqueRecentDIDCount := le.UniqueRecentDIDCount + ri.UniqueRecentDIDCount;
		SELF.UniqueNonRelativeDIDCount := le.UniqueNonRelativeDIDCount + IF(ri.isRelative = FALSE, 1, 0);
		nonRelativeIdentityCount := le.UniqueNonRelativeIdentityCount + IF(ri.isRelative = FALSE, 1, 0);
		nonRelativeIdentityCount2Months := le.UniqueNonRelativeIdentityCount2Months + IF(ri.isRelative = FALSE, 1, 0);
		SELF.UniqueNonRelativeIdentityCount := MIN(nonRelativeIdentityCount, 1);
		SELF.UniqueNonRelativeIdentityCount2Months := MIN(nonRelativeIdentityCount2Months, 1);
		SELF := le;
	END;
	didCounts := ROLLUP(headerRelativeDID, LEFT.Seq = RIGHT.Seq AND LEFT.SSN = RIGHT.SSN, getDIDCounts(LEFT, RIGHT));
	
	headerDIDCounts := JOIN(headerSourceCountsDID, didCounts, LEFT.Seq = RIGHT.Seq AND LEFT.SSN = RIGHT.SSN,
																							TRANSFORM(TempHeader, SELF.UniqueDIDCount := RIGHT.UniqueDIDCount;
																																		SELF.UniqueDIDCount2Months := RIGHT.UniqueDIDCount2Months;
																																		SELF.UniqueRecentDIDCount := IF((UNSIGNED)LEFT.Identity_Age <= sixMonths, RIGHT.UniqueRecentDIDCount, 0);
																																		SELF.UniqueNonRelativeDIDCount := RIGHT.UniqueNonRelativeDIDCount;
																																		SELF.UniqueNonRelativeIdentityCount := RIGHT.UniqueNonRelativeIdentityCount;
																																		SELF.UniqueNonRelativeIdentityCount2Months := IF(RIGHT.UniqueDIDCount2Months = 1, RIGHT.UniqueNonRelativeIdentityCount2Months, 0);
																																		SELF := LEFT), LEFT OUTER, KEEP(500), ATMOST(RiskWise.max_atmost));
	
	// Calculate the Dates First and Last Seen for the DID/Address Combo
	addressSorted := SORT(headerDID, Seq, InputDID, DID, Prim_Range, Prim_Name, Zip5, -Date_Last_Seen, -Date_First_Seen);

	TempHeader getAddressDates(TempHeader le, TempHeader ri) := TRANSFORM
		// Make sure we have month populated...
		leftFixed := IF((UNSIGNED)le.Address_First_Seen[5..6] BETWEEN 1 AND 12, le.Address_First_Seen, '0');
		rightFixed := IF((UNSIGNED)ri.Address_First_Seen[5..6] BETWEEN 1 AND 12, ri.Address_First_Seen, '0');
		
		SELF.Address_First_Seen := MAP((UNSIGNED)leftFixed = 0	=> rightFixed,
																	 (UNSIGNED)rightFixed = 0	=> leftFixed,
																															 (STRING8)MIN((UNSIGNED)leftFixed, (UNSIGNED)rightFixed));
		SELF.Address_Last_Seen := (STRING8)MAX((UNSIGNED)leftFixed, (UNSIGNED)rightFixed);
		SELF := le;
	END;
	AddressDates := ROLLUP(addressSorted, LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID AND LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND LEFT.Zip5 = RIGHT.Zip5, getAddressDates(LEFT, RIGHT));
	
	TempHeader getAddressAge(TempHeader le, TempHeader ri) := TRANSFORM
		recordAge := ut.DaysApart(ri.Address_First_Seen, le.TodaysDate);
		SELF.Address_First_Seen := ri.Address_First_Seen;
		SELF.Address_Last_Seen := ri.Address_Last_Seen;
		SELF.Address_Age := IF(le.TodaysDate < ri.Address_First_Seen OR (UNSIGNED)ri.Address_First_Seen = 0, '-1', (STRING)recordAge); // Age in days
		SELF := le;
	END;
	headerAddressDID := JOIN(headerDIDCounts, AddressDates, LEFT.Seq = RIGHT.Seq AND LEFT.DID = RIGHT.DID AND LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND LEFT.Zip5 = RIGHT.Zip5, 
																							getAddressAge(LEFT, RIGHT), LEFT OUTER, ATMOST(ut.Limits.Header_Per_DID));
	
	// Count unique addresses per input SSN
	addressDeduped := DEDUP(SORT(headerAddressDID, Seq, Prim_Range, Prim_Name, Zip5, Address_Age), Seq, Prim_Range, Prim_Name, Zip5);
	
	TempHeader getAddressRecent(TempHeader le) := TRANSFORM
		SELF.UniqueRecentAddressCount := IF(le.Address_Age <> '-1' AND (UNSIGNED)le.Address_Age <= threeMonths, 1, 0);
		
		SELF := le;
	END;
	addressRecent := PROJECT(addressDeduped, getAddressRecent(LEFT));
	
	TempHeader countAddresses(TempHeader le, TempHeader ri) := TRANSFORM
		SELF.UniqueAddressCount := le.UniqueAddressCount + ri.UniqueAddressCount;
		SELF.UniqueRecentAddressCount := le.UniqueRecentAddressCount + ri.UniqueRecentAddressCount;
		SELF := le;
	END;
	uniqueAddressCount := ROLLUP(addressRecent, LEFT.Seq = RIGHT.Seq, countAddresses(LEFT, RIGHT));
	
	headerAddressCount := JOIN(headerAddressDID, uniqueAddressCount, LEFT.Seq = RIGHT.Seq,
																							TRANSFORM(TempHeader, SELF.UniqueAddressCount := RIGHT.UniqueAddressCount;
																																		SELF.UniqueRecentAddressCount := IF((UNSIGNED)LEFT.Address_Age <= threeMonths, RIGHT.UniqueRecentAddressCount, 0);
																																		SELF := LEFT), LEFT OUTER, ATMOST(ut.Limits.Header_Per_DID));

	// Calculate the Dates First and Last Seen for the SSN
	TempHeader getSSNDates(TempHeader le, TempHeader ri) := TRANSFORM
		SELF.SSN_First_Seen := MAP((UNSIGNED)le.SSN_First_Seen = 0	=> ri.SSN_First_Seen,
															 (UNSIGNED)ri.SSN_First_Seen = 0	=> le.SSN_First_Seen,
																																	(STRING8)MIN((UNSIGNED)le.SSN_First_Seen, (UNSIGNED)ri.SSN_First_Seen));
		SELF.SSN_Last_Seen := (STRING8)MAX((UNSIGNED)le.SSN_Last_Seen, (UNSIGNED)ri.SSN_Last_Seen);
		SELF := le;
	END;
	SSNDates := ROLLUP(headerDID, LEFT.Seq = RIGHT.Seq AND LEFT.SSN = RIGHT.SSN, getSSNDates(LEFT, RIGHT));
	
	TempHeader getSSNAge(TempHeader le, TempHeader ri) := TRANSFORM
		recordLastAge := ut.DaysApart(ri.SSN_Last_Seen, le.TodaysDate);
		recordFirstAge := ut.DaysApart(ri.SSN_FirsT_Seen, le.TodaysDate);
		SELF.SSN_First_Seen := ri.SSN_First_Seen;
		SELF.SSN_Last_Seen := ri.SSN_Last_Seen;
		SELF.SSN_First_Seen_Age := IF(le.TodaysDate < ri.SSN_First_Seen OR (UNSIGNED)ri.SSN_First_Seen = 0, '0', (STRING)recordFirstAge);
		SELF.SSN_Last_Seen_Age := IF(le.TodaysDate < ri.SSN_Last_Seen OR (UNSIGNED)ri.SSN_Last_Seen = 0, '0', (STRING)recordLastAge); // Age in days - if the last seen date is newer than the header build date (Fast header records), set the age to 0
		SELF := le;
	END;
	headerSSN := JOIN(headerAddressCount, SSNDates, LEFT.Seq = RIGHT.Seq AND LEFT.SSN = RIGHT.SSN, 
																							getSSNAge(LEFT, RIGHT), LEFT OUTER, ATMOST(ut.Limits.Header_Per_DID));
	
	// Count identities that have 2 or more unique sources on the header, these are "established" identities
	establishedIdentities := DEDUP(SORT((headerSSN (sourceCount > 1)), Seq, SSN, DID), Seq, SSN, DID);
	TempHeader getIdentityCount(TempHeader le, TempHeader ri) := TRANSFORM
		SELF.UniqueIdentityCount := le.UniqueIdentityCount + ri.UniqueIdentityCount;
		SELF.UniqueNonRelativeIdentityCount := le.UniqueNonRelativeIdentityCount + IF(ri.isRelative = FALSE, 1, 0);
		SELF.UniqueNonRelativeIdentityCount2Months := le.UniqueNonRelativeIdentityCount2Months + IF(ri.isRelative = FALSE AND ri.UniqueDIDCount2Months = 1, 1, 0);
		SELF := le;
	END;
	countedIdentities := ROLLUP(establishedIdentities, LEFT.Seq = RIGHT.Seq AND LEFT.SSN = RIGHT.SSN, getIdentityCount(LEFT, RIGHT));
	
	headerCountedIdentities := JOIN(headerSSN, countedIdentities, LEFT.Seq = RIGHT.Seq AND LEFT.SSN = RIGHT.SSN,
																							TRANSFORM(TempHeader, SELF.UniqueIdentityCount := RIGHT.UniqueIdentityCount;
																																		SELF.UniqueNonRelativeIdentityCount := RIGHT.UniqueNonRelativeIdentityCount;
																																		SELF.UniqueNonRelativeIdentityCount2Months := RIGHT.UniqueNonRelativeIdentityCount2Months;
																																		SELF := LEFT), LEFT OUTER, ATMOST(ut.Limits.Header_Per_DID));
	
	// We now have all of the header calculations completed - roll them up into 1 record to use for determining Risk Codes, no longer care about individual record dates
	sortedSummary := SORT(headerCountedIdentities, Seq, SSN, -SourceCount, -CreditBureauSourceCount, -Address_Last_Seen, -Address_First_Seen, -Date_Last_Seen, -Date_First_Seen, DID);
	TempHeader rollHeader(TempHeader le, TempHeader ri) := TRANSFORM
		keepLeft := IF(le.SourceCount >= ri.SourceCount AND le.CreditBureauSourceCount >= ri.CreditBureauSourceCount, TRUE, FALSE);
		SELF.DID := IF(keepLeft, le.DID, ri.DID);
		SELF.Date_First_Seen := MAP((INTEGER)le.Date_First_Seen = 0	=> ri.Date_First_Seen,
															 (INTEGER)ri.Date_First_Seen = 0	=> le.Date_First_Seen,
																																	(STRING8)MIN((UNSIGNED)le.Date_First_Seen, (UNSIGNED)ri.Date_First_Seen));
		SELF.Date_Last_Seen := (STRING8)MAX((UNSIGNED)le.Date_Last_Seen, (UNSIGNED)ri.Date_Last_Seen);
		SELF.Came_From_FastHeader := le.Came_From_FastHeader OR ri.Came_From_FastHeader;
		
		SELF := le;
	END;
	headerSummaryTemp := ROLLUP(sortedSummary, LEFT.Seq = RIGHT.Seq AND LEFT.SSN = RIGHT.SSN, rollHeader(LEFT, RIGHT));

	headerSummary := PROJECT(headerSummaryTemp, TRANSFORM(TempHeader, SELF.Date_First_Age := IF((UNSIGNED)LEFT.Date_First_Seen <> 0, (STRING)UT.DaysApart(LEFT.Date_First_Seen, LEFT.TodaysDate), '-1');
																																		SELF.Date_Last_Age := IF((UNSIGNED)LEFT.Date_Last_Seen <> 0, (STRING)UT.DaysApart(LEFT.Date_Last_Seen, LEFT.TodaysDate), '-1');
																																		SELF := LEFT));
	
	// Get the information necessary to determine if we have a possibly randomized SSN
	TempRandSSN := RECORD
		UNSIGNED8 Seq := 0;
		STRING9 SSN := ''; // Input SSN
		BOOLEAN PossiblyRandomSSN := FALSE;
		STRING8 SSNFirstIssued := '';
		UNSIGNED4 SSNFirstIssuedAge := 0;
		STRING8 DateFirstSeen := '';
	END;
	
	TempRandSSN getRiskTable(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, RiskTableKey ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.SSN := le.Clean_Input.SSN;
		
		// Code for determining Randomized Social adapted from iid_getSSNFlags
		header_version := MAP(DataRestrictionMask[Risk_Indicators.iid_constants.posEquifaxRestriction] = Risk_Indicators.iid_constants.sFalse and
													DataRestrictionMask[Risk_Indicators.iid_constants.posTransUnionRestriction] = Risk_Indicators.iid_constants.sFalse and
													DataRestrictionMask[Risk_Indicators.iid_constants.posExperianRestriction] = Risk_Indicators.iid_constants.sFalse				=> ri.combo,
													DataRestrictionMask[Risk_Indicators.iid_constants.posExperianRestriction] = Risk_Indicators.iid_constants.sFalse				=> ri.en,
													DataRestrictionMask[Risk_Indicators.iid_constants.posTransUnionRestriction] = Risk_Indicators.iid_constants.sFalse			=> ri.tn,
																																																																										 ri.eq);  // default to the EQ version		
												
		pre_history := ((STRING)header_version.header_first_seen)[1..6] < ((STRING)le.Clean_Input.ArchiveDate)[1..6];
		vssn := Risk_Indicators.Validate_SSN(le.Clean_Input.SSN, le.Clean_Input.DateOfBirth);
		socsvalflag_temp := MAP(TRIM(le.Clean_Input.ssn) = ''																						=> '3',
															vssn.invalid																													=> '2',
															(ri.ssn <> '' and pre_history and ~ri.isValidFormat) or 
																vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid or 
																vssn.invalid_666s or vssn.pocketbook_ssn														=> '1',
																																																			 '0');
		socsRCISflag_temp := IF(Risk_Indicators.searchLegacySSN(le.Clean_Input.SSN, le.Clean_Input.DID, isFCRA := FALSE), '1', '0');
		/* The following accounts for randomized socials:
					ssnLowIssue - If possibly randomized, set low issue to the first date of randomization - June 25th, 2011
					ssnHighIssue - If possibly randomized, set to the current date (Or archive date if running in archive mode)
		*/
		firstSeen := IF(TRIM((STRING)ri.official_first_seen) IN ['201106', '0', ''], '20110625', TRIM((STRING)ri.official_first_seen));
		randomizedSocial := Risk_Indicators.rcSet.isCodeRS(le.Clean_Input.SSN, socsvalflag_temp, firstSeen, socsRCISflag_temp);
		
		invalid := (UNSIGNED)(firstSeen[1..6]) > le.Clean_Input.ArchiveDate OR le.Clean_Input.SSN = '';
		SELF.PossiblyRandomSSN := IF(invalid, FALSE, randomizedSocial);
		SELF.SSNFirstIssued := IF(invalid, '-1', firstSeen);
		todaysDate := IF(le.Clean_Input.ArchiveDate = 999999, (string) todays_date, ((STRING)le.Clean_Input.ArchiveDate)[1..6] + '01');
		ssnIssueAge := IF((UNSIGNED)firstSeen = 0, 0, UT.DaysApart(firstSeen, todaysDate));
		SELF.SSNFirstIssuedAge := IF(invalid, 999999, ssnIssueAge);
		SELF.DateFirstSeen := IF(invalid, '-1', firstSeen); // If seen before our archive date, blank this record
	END;
	// Need to specifically use LEFT OUTER here to catch the randomized SSN's that aren't on our issuance key
	randomizedSSN := JOIN(Input, RiskTableKey, LEFT.Clean_Input.SSN NOT IN ['0', ''] AND KEYED(LEFT.Clean_Input.SSN = RIGHT.SSN), 
																			getRiskTable(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(KEYED(LEFT.Clean_Input.SSN = RIGHT.SSN), 500));
	
	// Get all of the information necessary to determine if we have a deceased SSN
	TempDeadSSN := RECORD
		UNSIGNED8 Seq := 0;
		STRING9 SSN := ''; // Input SSN
		BOOLEAN DeadPerson := FALSE; // Doc, this one's dead.
		STRING8 FileDate := ''; // Date person filed as dead
	END;
	
	TempDeadSSN getDeadPeople(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, DeathMasterKey ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.SSN := le.Clean_Input.SSN;
		todaysDate := IF(le.Clean_Input.ArchiveDate = 999999, todays_date, (INTEGER)(le.Clean_Input.ArchiveDate + '01'));
		SELF.DeadPerson := (INTEGER)ri.filedate > 0 AND (integer)ri.filedate <= todaysDate; // If we have a filedate, we have a dead person.  But only consider them dead if the filedate is older than the archivedate
		SELF.FileDate := ri.filedate;
	END;
	
	deadSSNsTemp := JOIN(Input, DeathMasterKey, LEFT.Clean_Input.SSN NOT IN ['0', ''] AND KEYED(LEFT.Clean_Input.SSN = RIGHT.SSN)
																			and not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, Risk_Indicators.iid_constants.glb_ok(mod_access.glb, isFCRA := FALSE), deathparams),
																			getDeadPeople(LEFT, RIGHT), KEEP(500), ATMOST(RiskWise.max_atmost));
	// Keep the earliest dead SSN date
	deadSSNs := ROLLUP(SORT(deadSSNsTemp, Seq, SSN, FileDate), LEFT.Seq = RIGHT.Seq AND LEFT.SSN = RIGHT.SSN, TRANSFORM(TempDeadSSN, SELF.FileDate := MAP((UNSIGNED)LEFT.FileDate = 0	=> RIGHT.FileDate,
																																																																												(UNSIGNED)RIGHT.FileDate = 0	=> LEFT.FileDate,
																																																																												(STRING)MIN((UNSIGNED)LEFT.FileDate, (UNSIGNED)RIGHT.FileDate));
																																																																	 SELF := LEFT));
	
	// Get all of the information necessary to determine if we are dealing with a minors SSN
	// First: Gather all header information based on SSN, this includes all DID's associated with that SSN.  Figure out Identity Date First Seen and Identity DateOfBirth.
	// Second: Calculate the age based on Identity DateOfBirth - if < 18 as of ArchiveDate, it's a minor.
	TempMinorSSN := RECORD
		UNSIGNED8 Seq := 0;
		STRING9 SSN := ''; // Input SSN
		BOOLEAN IsAMinor := FALSE;
		STRING3 Age := '';
		STRING8 DateOfBirth := '';
		STRING8 TodaysDate := '';
		STRING8 DateFirstSeen := '';
		UNSIGNED2 SourceCount := 0;
	END;
	
	TempMinorSSN getMinors(TempHeader le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.SSN := le.SSN;
		TodaysDate := IF(le.ArchiveDate = 999999, todays_date, (UNSIGNED)IF(LENGTH(TRIM((STRING)le.ArchiveDate)) = 6, ((STRING)le.ArchiveDate + '01'), (STRING)le.ArchiveDate));
		SELF.TodaysDate := (STRING)TodaysDate;
		age := IF((UNSIGNED)le.DateOfBirth = 0, 999, ut.Age((UNSIGNED)le.DateOfBirth, TodaysDate)); // If we don't know DOB, set the age to unknown
		SELF.Age := (STRING)age;
		SELF.IsAMinor := IF(age < 18, TRUE, FALSE); // If the Identity was < 18 at the time of ArchiveDate (Either today or historical), it's a minor
		SELF.DateOfBirth := le.DateOfBirth; // The date of birth for this Identity (SSN/DID combo)
		SELF.DateFirstSeen := le.Identity_First_Seen; // The first seen date for the DID/SSN combo on the header and quick header
		SELF.SourceCount := le.SourceCount;
	END;
	
	// If the input DID matches the SSN DID - keep that Date Of Birth info.  If it doesn't match, keep the DID with the most sources
	uniqueHeaderIdentityDID := DEDUP(SORT(headerSourceCountsDID, Seq, SSN, -(InputDID = DID), -sourceCount, -creditBureauSourceCount, DID), Seq, SSN);
	
	minors := PROJECT(uniqueHeaderIdentityDID, getMinors(LEFT)) (IsAMinor = TRUE);
	
	// Get all inquiries record information
	TempInquirySSN := RECORD
		UNSIGNED8 Seq := 0;
		STRING9 SSN := '';
		// LNRS Counts are all inquiries across LexisNexisRiskSolutions products included in set_valid_suspiciousfraud_functions
		UNSIGNED2 InquiryCountLNRSHour := 0;
		UNSIGNED2 InquiryCountLNRSDay := 0;
		UNSIGNED2 InquiryCountLNRSWeek := 0;
		UNSIGNED2 InquiryCountLNRSMonth := 0;
		UNSIGNED2 InquiryCountLNRSYear := 0;
		UNSIGNED3 InquiryCountLNRS := 0;
		STRING8 DateFirstSeenLNRS := '';
		// LNRSnSF Counts are all inquiries in LNRS excluding Suspicious Fraud Function (nSF = No Suspicious Fraud)
		UNSIGNED2 InquiryCountLNRSnSFHour := 0;
		UNSIGNED2 InquiryCountLNRSnSFDay := 0;
		UNSIGNED2 InquiryCountLNRSnSFWeek := 0;
		UNSIGNED2 InquiryCountLNRSnSFMonth := 0;
		UNSIGNED2 InquiryCountLNRSnSFYear := 0;
		UNSIGNED3 InquiryCountLNRSnSF := 0;
		STRING8 DateFirstSeenLNRSnSF := '';
		// SF Counts are all inquiries to the Suspicious Fraud Function
		UNSIGNED2 InquiryCountSFHour := 0;
		UNSIGNED2 InquiryCountSFDay := 0;
		UNSIGNED2 InquiryCountSFWeek := 0;
		UNSIGNED2 InquiryCountSFMonth := 0;
		UNSIGNED2 InquiryCountSFYear := 0;
		UNSIGNED3 InquiryCountSF := 0;
		STRING8 DateFirstSeenSF := '';
	END;
	TempInquirySSN getInquiries(Suspicious_Fraud_LN.layouts.Layout_SSN_Inquiries le) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.SSN := le.SSN;
		
		isSF := le.SuspiciousFraudFunction = TRUE;
		lastHour := le.ageinhours <= 1; // Inquiry within the last hour
		lastDay := le.ageindays <= 1; // Inquiry within the last day
		lastWeek := le.ageinweeks <= 1; // Inquiry within the last week
		lastMonth := le.ageinmonths <= 1; // Inquiry within the last month
		lastYear := le.ageinyears <= 1; // Inquiry within the last year
		
		// LNRS Counts are all inquiries across LexisNexisRiskSolutions products included in set_valid_suspiciousfraud_functions
		SELF.InquiryCountLNRSHour := IF(lastHour, 1, 0);
		SELF.InquiryCountLNRSDay := IF(lastDay, 1, 0);
		SELF.InquiryCountLNRSWeek := IF(lastWeek, 1, 0);
		SELF.InquiryCountLNRSMonth := IF(lastMonth, 1, 0);
		SELF.InquiryCountLNRSYear := IF(lastYear, 1, 0);
		SELF.InquiryCountLNRS := 1;
		SELF.DateFirstSeenLNRS := le.logdate;
		// LNRSnSF Counts are all inquiries in LNRS excluding Suspicious Fraud Function (nSF = No Suspicious Fraud)
		SELF.InquiryCountLNRSnSFHour := IF(~isSF AND lastHour, 1, 0);
		SELF.InquiryCountLNRSnSFDay := IF(~isSF AND lastDay, 1, 0);
		SELF.InquiryCountLNRSnSFWeek := IF(~isSF AND lastWeek, 1, 0);
		SELF.InquiryCountLNRSnSFMonth := IF(~isSF AND lastMonth, 1, 0);
		SELF.InquiryCountLNRSnSFYear := IF(~isSF AND lastYear, 1, 0);
		SELF.InquiryCountLNRSnSF := IF(~isSF, 1, 0);
		SELF.DateFirstSeenLNRSnSF := IF(~isSF, le.logdate, '');
		// SF Counts are all inquiries to the Suspicious Fraud Function
		SELF.InquiryCountSFHour := IF(isSF AND lastHour, 1, 0);
		SELF.InquiryCountSFDay := IF(isSF AND lastDay, 1, 0);
		SELF.InquiryCountSFWeek := IF(isSF AND lastWeek, 1, 0);
		SELF.InquiryCountSFMonth := IF(isSF AND lastMonth, 1, 0);
		SELF.InquiryCountSFYear := IF(isSF AND lastYear, 1, 0);
		SELF.InquiryCountSF := IF(isSF, 1, 0);
		SELF.DateFirstSeenSF := IF(isSF, le.logdate, '');
	END;
	inquiryBucketed := PROJECT(Inquiries, getInquiries(LEFT));
	
	TempInquirySSN countInquiries(TempInquirySSN le, TempInquirySSN ri) := TRANSFORM
		SELF.Seq := le.Seq;
		SELF.SSN := le.SSN;
		
		SELF.InquiryCountLNRSHour := le.InquiryCountLNRSHour + ri.InquiryCountLNRSHour;
		SELF.InquiryCountLNRSDay := le.InquiryCountLNRSDay + ri.InquiryCountLNRSDay;
		SELF.InquiryCountLNRSWeek := le.InquiryCountLNRSWeek + ri.InquiryCountLNRSWeek;
		SELF.InquiryCountLNRSMonth := le.InquiryCountLNRSMonth + ri.InquiryCountLNRSMonth;
		SELF.InquiryCountLNRSYear := le.InquiryCountLNRSYear + ri.InquiryCountLNRSYear;
		SELF.InquiryCountLNRS := le.InquiryCountLNRS + ri.InquiryCountLNRS;
		SELF.DateFirstSeenLNRS := MAP((UNSIGNED)le.DateFirstSeenLNRS = 0	=> ri.DateFirstSeenLNRS,
																	(UNSIGNED)ri.DateFirstSeenLNRS = 0	=> le.DateFirstSeenLNRS,
																																				(STRING8)MIN((UNSIGNED)le.DateFirstSeenLNRS, (UNSIGNED)ri.DateFirstSeenLNRS));
		
		SELF.InquiryCountLNRSnSFHour := le.InquiryCountLNRSnSFHour + ri.InquiryCountLNRSnSFHour;
		SELF.InquiryCountLNRSnSFDay := le.InquiryCountLNRSnSFDay + ri.InquiryCountLNRSnSFDay;
		SELF.InquiryCountLNRSnSFWeek := le.InquiryCountLNRSnSFWeek + ri.InquiryCountLNRSnSFWeek;
		SELF.InquiryCountLNRSnSFMonth := le.InquiryCountLNRSnSFMonth + ri.InquiryCountLNRSnSFMonth;
		SELF.InquiryCountLNRSnSFYear := le.InquiryCountLNRSnSFYear + ri.InquiryCountLNRSnSFYear;
		SELF.InquiryCountLNRSnSF := le.InquiryCountLNRSnSF + ri.InquiryCountLNRSnSF;
		SELF.DateFirstSeenLNRSnSF := MAP((UNSIGNED)le.DateFirstSeenLNRSnSF = 0	=> ri.DateFirstSeenLNRSnSF,
																		 (UNSIGNED)ri.DateFirstSeenLNRSnSF = 0	=> le.DateFirstSeenLNRSnSF,
																																							(STRING8)MIN((UNSIGNED)le.DateFirstSeenLNRSnSF, (UNSIGNED)ri.DateFirstSeenLNRSnSF));
		
		SELF.InquiryCountSFHour := le.InquiryCountSFHour + ri.InquiryCountSFHour;
		SELF.InquiryCountSFDay := le.InquiryCountSFDay + ri.InquiryCountSFDay;
		SELF.InquiryCountSFWeek := le.InquiryCountSFWeek + ri.InquiryCountSFWeek;
		SELF.InquiryCountSFMonth := le.InquiryCountSFMonth + ri.InquiryCountSFMonth;
		SELF.InquiryCountSFYear := le.InquiryCountSFYear + ri.InquiryCountSFYear;
		SELF.InquiryCountSF := le.InquiryCountSF + ri.InquiryCountSF;
		SELF.DateFirstSeenSF := MAP((UNSIGNED)le.DateFirstSeenSF = 0	=> ri.DateFirstSeenSF,
																(UNSIGNED)ri.DateFirstSeenSF = 0	=> le.DateFirstSeenSF,
																																		(STRING8)MIN((UNSIGNED)le.DateFirstSeenSF, (UNSIGNED)ri.DateFirstSeenSF));
	END;
	inquiriesCounted := ROLLUP(SORT(inquiryBucketed, Seq, SSN), LEFT.Seq = RIGHT.Seq, countInquiries(LEFT, RIGHT));
	
	// We have all of the raw data, now generate the Risk Codes!	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getHeaderRiskCodes(TempHeader le) := TRANSFORM
		RiskCodesTemp														:= IF(le.UniqueDIDCount2Months >= 3, Suspicious_Fraud_LN.Common.genRiskCode('S01')) +
																							IF(le.UniqueDIDCount >= 2 AND le.UniqueRecentDIDCount > 0, Suspicious_Fraud_LN.Common.genRiskCode('S02')) +
																							IF(le.UniqueIdentityCount >= 5, Suspicious_Fraud_LN.Common.genRiskCode('S03')) +
																							IF(le.UniqueNonRelativeIdentityCount2Months >= 4, Suspicious_Fraud_LN.Common.genRiskCode('S04')) +
																							IF((INTEGER)le.SSN_Last_Seen_Age > 365, Suspicious_Fraud_LN.Common.genRiskCode('S10')) +
																							IF(le.UniqueRecentAddressCount >= 3, Suspicious_Fraud_LN.Common.genRiskCode('S13'));
		RiskCodes																:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		SSNHit 																	:= ut.Exists2(RiskCodes);
		SELF.Suspicious_SSN.Data_Source					:= IF(SSNHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_SSN.DateFirstSeenInFile	:= IF(SSNHit = FALSE OR (INTEGER)le.SSN_First_Seen IN [-1, 0], '', le.SSN_First_Seen); // Date the SSN was first seen in header records
		SELF.RiskCode_SSN												:= RiskCodes;
		
		SELF.Seq																:= le.Seq;
		SELF.Clean_Input.SSN										:= le.SSN;
		
		SELF 																		:= le;
		SELF 																		:= [];
	END;
	headerRiskCodes := PROJECT(headerSummary, getHeaderRiskCodes(LEFT)) (ut.Exists2(RiskCode_SSN));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getRandomizedSSNRiskCodes(TempRandSSN le) := TRANSFORM
		RiskCodesTemp														:= IF(le.SSNFirstIssued NOT IN ['-1', '0', ''] AND 
																										le.SSNFirstIssuedAge <= Risk_Indicators.iid_constants.threeyears, Suspicious_Fraud_LN.Common.genRiskCode('S11'));
		RiskCodes																:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		SSNHit 																	:= ut.Exists2(RiskCodes);
		SELF.Suspicious_SSN.Data_Source					:= IF(SSNHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_SSN.DateFirstSeenInFile	:= IF(SSNHit = FALSE OR (INTEGER)le.DateFirstSeen IN [-1, 0], '', le.DateFirstSeen); // Date the SSN was first seen in Risk Table/Header Records
		SELF.RiskCode_SSN												:= RiskCodes;
		
		SELF.Seq																:= le.Seq;
		SELF.Clean_Input.SSN										:= le.SSN;
		
		SELF 																		:= le;
		SELF 																		:= [];
	END;
	randomizedSSNRiskCodes := PROJECT(randomizedSSN, getRandomizedSSNRiskCodes(LEFT)) (ut.Exists2(RiskCode_SSN));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getDeadSSNRiskCodes(TempDeadSSN le) := TRANSFORM
		RiskCodesTemp														:= IF(le.DeadPerson, Suspicious_Fraud_LN.Common.genRiskCode('S05'));
		RiskCodes																:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		SSNHit 																	:= ut.Exists2(RiskCodes);
		SELF.Suspicious_SSN.Data_Source					:= IF(SSNHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_SSN.DateFirstSeenInFile	:= IF(SSNHit = FALSE OR (INTEGER)le.FileDate IN [-1, 0], '', le.FileDate); // Date the SSN was first seen on Death Master Record
		SELF.RiskCode_SSN												:= RiskCodes;
		
		SELF.Seq																:= le.Seq;
		SELF.Clean_Input.SSN										:= le.SSN;
		
		SELF 																		:= le;
		SELF 																		:= [];
	END;
	deadSSNRiskCodes := PROJECT(deadSSNs, getDeadSSNRiskCodes(LEFT)) (ut.Exists2(RiskCode_SSN));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getMinorSSNRiskCodes(TempMinorSSN le) := TRANSFORM
		RiskCodesTemp														:= IF(le.IsAMinor, Suspicious_Fraud_LN.Common.genRiskCode('S12'));
		RiskCodes																:= RiskCodesTemp (TRIM(SuspiciousRiskCode) <> '');
		SSNHit 																	:= ut.Exists2(RiskCodes);
		SELF.Suspicious_SSN.Data_Source					:= IF(SSNHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_SSN.DateFirstSeenInFile	:= IF(SSNHit = FALSE OR (INTEGER)le.DateFirstSeen IN [-1, 0], '', le.DateFirstSeen); // Date the SSN/Minor DID was first seen on header
		SELF.RiskCode_SSN												:= RiskCodes;
		
		SELF.Seq																:= le.Seq;
		SELF.Clean_Input.SSN										:= le.SSN;
		
		SELF 																		:= le;
		SELF 																		:= [];
	END;
	minorSSNRiskCodes := PROJECT(minors, getMinorSSNRiskCodes(LEFT)) (ut.Exists2(RiskCode_SSN));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus getInquirySSNRiskCodes(TempInquirySSN le) := TRANSFORM
		RiskCodesLNRSnSFTemp										:= IF(le.InquiryCountLNRSnSFYear >= 30, Suspicious_Fraud_LN.Common.genRiskCode('S06')) + 
																							 IF(le.InquiryCountLNRSnSFMonth >= 5, Suspicious_Fraud_LN.Common.genRiskCode('S07')) +
																							 IF(le.InquiryCountLNRSnSFWeek >= 3, Suspicious_Fraud_LN.Common.genRiskCode('S08')) +
																							 IF(le.InquiryCountLNRSnSFDay >= 1, Suspicious_Fraud_LN.Common.genRiskCode('S09'));
		RiskCodesLNRSnSF												:= RiskCodesLNRSnSFTemp (TRIM(SuspiciousRiskCode) <> '');
		RiskCodesSFTemp													:= IF(le.InquiryCountSFYear >= 7, Suspicious_Fraud_LN.Common.genRiskCode('S14')) +
																							 IF(le.InquiryCountSFMonth >= 5, Suspicious_Fraud_LN.Common.genRiskCode('S15')) +
																							 IF(le.InquiryCountSFWeek >= 3, Suspicious_Fraud_LN.Common.genRiskCode('S16')) +
																							 IF(le.InquiryCountSFDay >= 1, Suspicious_Fraud_LN.Common.genRiskCode('S17')) +
																							 IF(le.InquiryCountSFHour >= 1, Suspicious_Fraud_LN.Common.genRiskCode('S18'));
		RiskCodesSF															:= RiskCodesSFTemp (TRIM(SuspiciousRiskCode) <> '');
		RiskCodes																:= RiskCodesLNRSnSF + RiskCodesSF;
		LNRSnSFHit															:= ut.Exists2(RiskCodesLNRSnSF);
		SFHit																		:= ut.Exists2(RiskCodesSF);
		SSNHit 																	:= LNRSnSFHit OR SFHit;
		SELF.Suspicious_SSN.Data_Source					:= IF(SSNHit = TRUE, Suspicious_Fraud_LN.Constants.DefaultDataSource, ''); // Internal, Customer, or Third Party
		SELF.Suspicious_SSN.DateFirstSeenInFile	:= MAP(LNRSnSFHit = TRUE	=> le.DateFirstSeenLNRSnSF,
																									 SFHit = TRUE				=> le.DateFirstSeenSF,
																																				 '');
		// These counts are related to the Suspicious Fraud File ONLY
		SELF.Suspicious_SSN.InquiryCountHour		:= le.InquiryCountSFHour;
		SELF.Suspicious_SSN.InquiryCountDay			:= le.InquiryCountSFDay;
		SELF.Suspicious_SSN.InquiryCountWeek		:= le.InquiryCountSFWeek;
		SELF.Suspicious_SSN.InquiryCountMonth		:= le.InquiryCountSFMonth;
		SELF.Suspicious_SSN.InquiryCountYear		:= le.InquiryCountSFYear;
		SELF.Suspicious_SSN.InquiryCount				:= le.InquiryCountSF;
		SELF.RiskCode_SSN												:= RiskCodes;
		
		SELF.Seq																:= le.Seq;
		SELF.Clean_Input.SSN										:= le.SSN;
		
		SELF 																		:= le;
		SELF 																		:= [];
	END;
	inquirySSNRiskCodes := PROJECT(inquiriesCounted, getInquirySSNRiskCodes(LEFT)) (ut.Exists2(RiskCode_SSN));
	
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus combineSSNRiskCodes(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le, Suspicious_Fraud_LN.layouts.Layout_Batch_Plus ri) := TRANSFORM
		SELF.Suspicious_SSN.Data_Source := IF(le.Suspicious_SSN.Data_Source <> '', le.Suspicious_SSN.Data_Source, ri.Suspicious_SSN.Data_Source);
		SELF.Suspicious_SSN.DateFirstSeenInFile := MAP((UNSIGNED)le.Suspicious_SSN.DateFirstSeenInFile = 0	=> ri.Suspicious_SSN.DateFirstSeenInFile,
																									 (UNSIGNED)ri.Suspicious_SSN.DateFirstSeenInFile = 0	=> le.Suspicious_SSN.DateFirstSeenInFile,
																																																					(STRING8)MIN((UNSIGNED)le.Suspicious_SSN.DateFirstSeenInFile, (UNSIGNED)ri.Suspicious_SSN.DateFirstSeenInFile));
		SELF.Suspicious_SSN.InquiryCountHour := le.Suspicious_SSN.InquiryCountHour + ri.Suspicious_SSN.InquiryCountHour;
		SELF.Suspicious_SSN.InquiryCountDay := le.Suspicious_SSN.InquiryCountDay + ri.Suspicious_SSN.InquiryCountDay;
		SELF.Suspicious_SSN.InquiryCountWeek := le.Suspicious_SSN.InquiryCountWeek + ri.Suspicious_SSN.InquiryCountWeek;
		SELF.Suspicious_SSN.InquiryCountMonth := le.Suspicious_SSN.InquiryCountMonth + ri.Suspicious_SSN.InquiryCountMonth;
		SELF.Suspicious_SSN.InquiryCountYear := le.Suspicious_SSN.InquiryCountYear + ri.Suspicious_SSN.InquiryCountYear;
		SELF.Suspicious_SSN.InquiryCount := le.Suspicious_SSN.InquiryCount + ri.Suspicious_SSN.InquiryCount;
		SELF.RiskCode_SSN := le.RiskCode_SSN + ri.RiskCode_SSN;
		
		SELF := le;
	END;
	
	SSNRiskCodesCombined := SORT(headerRiskCodes + randomizedSSNRiskCodes + deadSSNRiskCodes + minorSSNRiskCodes + inquirySSNRiskCodes, Seq);

	SSNRiskCodesTemp := ROLLUP(SSNRiskCodesCombined, LEFT.Seq = RIGHT.Seq, combineSSNRiskCodes(LEFT, RIGHT));
	
	// Now that we have all of the Risk Codes, sort them, and create the comma delimited list
	// NOTE: DUE TO A BUG IN THE 702 PLATFORM THIS NEEDS TO STAY AS 2 SEPARATE PROJECTS.  THIS IS FIXED IN OSS.
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanSSNRiskCodes1(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := DEDUP(SORT(le.RiskCode_SSN, SuspiciousRiskCode), SuspiciousRiskCode);
		SELF.RiskCode_SSN := sortedCodes;
		SELF := le;
	END;
	Suspicious_Fraud_LN.layouts.Layout_Batch_Plus cleanSSNRiskCodes2(Suspicious_Fraud_LN.layouts.Layout_Batch_Plus le) := TRANSFORM
		sortedCodes := le.RiskCode_SSN;
		SELF.Suspicious_SSN.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(sortedCodes, SuspiciousRiskCode, ',');
		SELF.Suspicious_SSN.DateFirstSeenInFile := Suspicious_Fraud_LN.Common.padDate(le.Suspicious_SSN.DateFirstSeenInFile);
		SELF := le;
	END;
	SSNRiskCodes1 := PROJECT(SSNRiskCodesTemp, cleanSSNRiskCodes1(LEFT));
	SSNRiskCodes := PROJECT(NOFOLD(SSNRiskCodes1), cleanSSNRiskCodes2(LEFT)) (LENGTH(TRIM(Clean_Input.SSN)) = 9); // Only keep codes for Full SSN's
		
	/*
	/* *****************************************
	 *            DEBUGGING SECTION            *
	 *******************************************/
	// OUTPUT(uniqueHeaderSSN, NAMED('uniqueHeaderSSN'));
	// OUTPUT(headerDID, NAMED('headerDID'));
	// OUTPUT(headerIdentityDID, NAMED('headerIdentityDID'));
	// OUTPUT(headerSourceCountsDID, NAMED('headerSourceCountsDID'));
	// OUTPUT(headerRelativeDID, NAMED('headerRelativeDID'));
	// OUTPUT(headerDIDCounts, NAMED('headerDIDCounts'));
	// OUTPUT(headerAddressDID, NAMED('headerAddressDID'));
	// OUTPUT(addressDeduped, NAMED('addressSSNDeduped'));
	// OUTPUT(addressRecent, NAMED('addressSSNRecent'));
	// OUTPUT(uniqueAddressCount, NAMED('uniqueAddressSSNCount'));
	// OUTPUT(headerAddressCount, NAMED('headerAddressSSNCount'));
	// OUTPUT(headerSSN, NAMED('headerSSN'));
	// OUTPUT(headerCountedIdentities, NAMED('headerCountedIdentities'));
	// OUTPUT(headerSummary, NAMED('headerSSNSummary'));
	// OUTPUT(randomizedSSN, NAMED('randomizedSSN'));
	// OUTPUT(deadSSNs, NAMED('deadSSNs'));
	// OUTPUT(minors, NAMED('minors'));
	// OUTPUT(inquiryBucketed, NAMED('inquirySSNBucketed'));
	// OUTPUT(inquiriesCounted, NAMED('inquiriesSSNCounted'));
	// OUTPUT(headerRiskCodes, NAMED('headerSSNRiskCodes'));
	// OUTPUT(randomizedSSNRiskCodes, NAMED('randomizedSSNRiskCodes'));
	// OUTPUT(deadSSNRiskCodes, NAMED('deadSSNRiskCodes'));
	// OUTPUT(minorSSNRiskCodes, NAMED('minorSSNRiskCodes'));
	// OUTPUT(inquirySSNRiskCodes, NAMED('inquirySSNRiskCodes'));
	// OUTPUT(SSNRiskCodesCombined, NAMED('SSNRiskCodesCombined'));
	// OUTPUT(SSNRiskCodesTemp, NAMED('SSNRiskCodesTemp'));
	// OUTPUT(SSNRiskCodes, NAMED('SSNRiskCodes'));
	/* ******** END DEBUGGING SECTION **********/
	RETURN (SSNRiskCodes);
END;