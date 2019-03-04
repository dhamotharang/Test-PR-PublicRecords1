// THIS REPORT IS XML ONLY - NOT BATCH  
// Several assumptions are made to simplify the code that requires this function to only be called for XML transactions.

IMPORT Address, ADVO, AutoStandardI, Codes, DeathV2_Services, Drivers, Doxie, Email_Data, Gong, Header, Header_Quick, 
			 IESP, MDR, PersonReports, Risk_Indicators, RiskWise, SmartRollup, Targus, UT, Utilfile, 
			 VerificationOfOccupancy, census_data, Relationship, std;

EXPORT getReport (DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) ShellResults,
									DATASET(VerificationOfOccupancy.Layouts.Layout_VOOBatchOut) AttributesResults,
									STRING50 DataRestrictionMask,
									UNSIGNED1 GLBPurpose,
									UNSIGNED1 DPPAPurpose,
									BOOLEAN isUtility,
									BOOLEAN isXML = FALSE,
									BOOLEAN fares_ok = true) := FUNCTION
	
	isFCRA := FALSE;
	GLB_OK := Risk_Indicators.iid_constants.glb_ok(GLBPurpose, isFCRA);
	DPPA_OK := Risk_Indicators.iid_constants.dppa_ok(DPPAPurpose, isFCRA);
	deathparams := MODULE(DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule()))
		EXPORT STRING DataRestrictionMask := ^.DataRestrictionMask;
	END;		
	Experian_Permitted := DataRestrictionMask[Risk_Indicators.iid_constants.posExperianRestriction] <> Risk_Indicators.iid_constants.sTrue;
	TodaysDate := IF(ShellResults[1].HistoryDate = 999999, (STRING)Std.Date.Today(), ((STRING)ShellResults[1].HistoryDate)[1..6] + '01');
									
	// ****************************************************************
	// *  Set SmartLinx Param Logic (PersonReports.SmartLinxReport)   *
	// * Utilizing the default values that SmartLinx has in place.    *
	// ****************************************************************
	paramTemp := MODULE
    EXPORT UNSIGNED1 GLBPurpose := GLBPurpose;
    EXPORT UNSIGNED1 DPPAPurpose := DPPAPurpose;
    EXPORT BOOLEAN ln_branded := FALSE;
    EXPORT STRING6 ssn_mask := 'NONE';
    EXPORT UNSIGNED1 score_threshold := 10;
    EXPORT BOOLEAN legacy_verified := FALSE;
    EXPORT BOOLEAN include_BlankDOD := FALSE;
		EXPORT BOOLEAN include_deceased := TRUE;
    EXPORT BOOLEAN smart_rollup := TRUE;
		EXPORT BOOLEAN include_sources := TRUE;
		EXPORT UNSIGNED1 max_relatives := 100;
    EXPORT BOOLEAN use_bestaka_ra := FALSE;
		EXPORT BOOLEAN use_bestaka_nb := FALSE;
    EXPORT UNSIGNED1 bankruptcy_version := 2;
		EXPORT STRING1 bk_party_type := iesp.Constants.SMART.DEBTOR;
    EXPORT UNSIGNED1 crimrecords_version := 2;
    EXPORT UNSIGNED1 dea_version := 2;
    EXPORT UNSIGNED1 dl_version := 2;
    EXPORT UNSIGNED1 liensjudgments_version := 2;
		EXPORT STRING1 liens_party_type := iesp.Constants.SMART.DEBTOR;
    EXPORT UNSIGNED1 phonesplus_version := 2;
    EXPORT UNSIGNED1 proflicense_version := 2;
    EXPORT UNSIGNED1 property_version := 2;
    EXPORT UNSIGNED1 ucc_version := 2;
    EXPORT UNSIGNED1 vehicles_version := 2;
    EXPORT UNSIGNED1 voters_version := 2;
    EXPORT BOOLEAN include_nonresidents_phones := FALSE;
    EXPORT UNSIGNED1 neighbors_per_na := 2;
		EXPORT BOOLEAN sort_deeds_by_ownership := TRUE;
		EXPORT BOOLEAN AllowGraphicDescription := FALSE;
    EXPORT BOOLEAN Include_BestAddress := FALSE;
		EXPORT BOOLEAN IncludeAllCriminalRecords := FALSE;
    EXPORT BOOLEAN IncludeSexualOffenses := FALSE;
		EXPORT BOOLEAN return_AllImposterRecords := TRUE;
		EXPORT UNSIGNED1 max_imposter_akas := 50;
		EXPORT BOOLEAN include_proflicenses := TRUE;
		EXPORT BOOLEAN include_providers := TRUE;  
		EXPORT BOOLEAN include_sanctions := TRUE;
    EXPORT BOOLEAN include_criminalindicators := FALSE;
    EXPORT BOOLEAN include_relativeaddresses := TRUE;
		EXPORT UNSIGNED1 neighborhoods := 1;
    EXPORT UNSIGNED1 neighbors_per_address := 20;
		EXPORT BOOLEAN includeHRI := TRUE;
  END;
	param := MODULE (PROJECT(paramTemp, PersonReports.Input._SmartLinxReport, OPT)) END;
	
	// ****************************************************************
	// *        Gather Best Person Data - Use SmartLinx Logic         *
	// *             (PersonReports.SmartLinxReport)                  *
	// ****************************************************************
	Doxie.Layout_Best getBestRec(VerificationOfOccupancy.Layouts.Layout_VOOShell le) := TRANSFORM
		SELF.DID := le.DID;
		SELF.Phone := le.Phone10;
		SELF.SSN := le.SSN;
		SELF.SSN_Unmasked := le.SSN;
		SELF.DOB := (INTEGER)le.DOB;
		SELF.Title := le.Title;
		SELF.FName := le.FName;
		SELF.MName := le.MName;
		SELF.LName := le.LName;
		SELF.Name_Suffix := le.Suffix;
		SELF.Prim_Range := le.Prim_Range;
		SELF.PreDir := le.PreDir;
		SELF.Prim_Name := le.Prim_Name;
		SELF.Suffix := le.Addr_Suffix;
		SELF.PostDir := le.PostDir;
		SELF.Unit_Desig := le.Unit_Desig;
		SELF.Sec_Range := le.Sec_Range;
		SELF.City_Name := le.P_City_Name;
		SELF.St := le.St;
		SELF.Zip := le.Z5;
		SELF.Zip4 := le.Zip4;
		SELF.DL_number := le.DL_Number;
  	SELF.Age := IF((INTEGER)le.DOB <= 0, 0, ut.Age((INTEGER)le.DOB));
		SELF.Run_Date := IF(le.historydate = 999999, (INTEGER)Std.Date.Today(), (INTEGER)(((STRING)le.historydate) + '01'));
		
		// These are calculated in followup Joins.  Rather than calling multiple unnecessary joins found in Doxie.Best_Records (SmartLinx uses this)
		// I am choosing to pull out just the joins needed to gather these two fields.
		SELF.DOD := '';
  	SELF.Valid_SSN := '';
		
		// The remaining fields aren't utilized in the Report
		SELF := le;
		SELF := [];
	END;
	best_rec_input := PROJECT(ShellResults, getBestRec(LEFT));

	// Get the Date of Death (DOD) - This uses the same logic found in PersonReports.Person_records (SmartLinx)
	Doxie.Layout_Best GetDeathRecords(Doxie.Layout_Best le, Doxie.Key_Death_MasterV2_DID ri) := TRANSFORM
		SELF.DOD := (STRING)ri.DOD8; // Get all Dates of Death.  We will SORT/Dedup below to keep the oldest DOD
		SELF := le;
	END;
	with_DODs := JOIN(best_rec_input, Doxie.Key_Death_MasterV2_DID, isXML AND
								LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.l_DID) 
									AND NOT DeathV2_Services.Functions.Restricted(RIGHT.src, RIGHT.glb_flag, Risk_Indicators.iid_constants.GLB_OK(GLBPurpose, IsFCRA := FALSE), deathparams),
								GetDeathRecords(LEFT, RIGHT),
								LEFT OUTER, KEEP(UT.Limits.DEATH_PER_DID), ATMOST(UT.Limits.HEADER_PER_DID));
	// Keep the oldest DOD per input DID
	best_rec_DOD := DEDUP(SORT(with_DODs, DID, -DOD), DID);

  //Get best rec info to pass to SSN and phones searches
  dids := project (best_rec_DOD, doxie.layout_references);
  persMod := module (project (param, personreports.input.personal, opt)) end;
	pers := PersonReports.Person_records (dids, persMod, IsFCRA);
 	best_rec_esdl :=       pers.bestrecs_esdl[1]; 
	best_rec :=            pers.bestrecs[1];
 
	// ****************************************************************
	// *        Gather Phone Metadata - Use SmartLinx Logic           *
	// *             (PersonReports.SmartLinxReport)                  *
	// ****************************************************************
	#stored('DPPAPurpose',DPPAPurpose);	//store this here so Smartlinx picks it up
	#stored('GLBPurpose',GLBPurpose);		//store this here so Smartlinx picks it up
	#stored('IncludeHRI',true);					//store this here so Smartlinx picks it up
	phoneRawMetadata := IF(isXML, CHOOSEN(SmartRollup.FN_Smart_getPhonesPlusMetadata.byDid(best_rec, param), iesp.Constants.BR.MaxPhonesPlus),
																							 DATASET([], iesp.smartlinxReport.t_SLRBestPhone));
	
	// ****************************************************************
	// *         Gather SSN Metadata - Use SmartLinx Logic            *
	// *             (PersonReports.SmartLinxReport)                  *
	// ****************************************************************
	ssnRawMetadata := IF(param.Smart_Rollup AND best_rec.Valid_SSN = 'G' AND isXML, SmartRollup.FN_Smart_getSSNMetadata(best_rec.DID, best_rec.SSN, best_rec.Valid_SSN, paramTemp.IncludeHRI),
																																				DATASET([], iesp.share.t_SSNInfoEx));
	
	// ****************************************************************
	// *           Gather Best Metadata - Use Watchdog Logic          *
	// ****************************************************************
	doxie.mac_best_records(ShellResults,
												 did,
												 outfile,
												 dppa_ok,
												 glb_ok, 
												 ,
												 doxie.DataRestriction.fixed_DRM);	
												 
	VerificationOfOccupancy.Layouts.Watchdog_Best transform_name(ShellResults le, outfile ri) := TRANSFORM
			SELF.LexID := le.DID;
			// If we found the best, use it otherwise use what was input
			SELF.Title := IF(ri.Title <> '', ri.Title, le.Title);
			SELF.FName := IF(ri.FName <> '', ri.FName, le.FName);
			SELF.MName := IF(ri.MName <> '', ri.MName, le.MName);
			SELF.LName := IF(ri.LName <> '', ri.LName, le.LName);
			SELF.Suffix := IF(ri.Name_Suffix <> '', ri.Name_Suffix, le.Suffix);
			myDOB := IF((INTEGER)ri.DOB <> 0, (STRING)ri.DOB, le.DOB);
			SELF.DOB := myDOB;
			// Calculate the Age based on "As-Of" date, assuming the date of birth is before the as-of date
			SELF.Age := IF((INTEGER)myDOB > 0 AND (INTEGER)myDOB <= (INTEGER)TodaysDate, ut.Age((INTEGER)myDOB, (INTEGER)TodaysDate), 
																					0);
	END;
	
	bestSubjectData := JOIN(ShellResults, outfile, 
												LEFT.DID <> 0 AND LEFT.DID = RIGHT.DID,
											transform_name(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));
	
	// ****************************************************************
	// *   Gather Address Metadata - Use The Target (Input) and VOO   *
	// * Current addresses to gather Metadata.                        *
	// ****************************************************************	
	
	// Rollup the addresses we got from the VOO Shell, combine the current and target if they are the same (So that we don't hit the keys twice for no good reason)
	VerificationOfOccupancy.Layouts.Subject_Addresses rollAddresses(VerificationOfOccupancy.Layouts.Subject_Addresses le, VerificationOfOccupancy.Layouts.Subject_Addresses ri) := TRANSFORM
		SELF.AddressStatus := MAP(le.AddressStatus = 'CT' OR ri.AddressStatus = 'CT' => 'CT', // Current/Target Address Merged
															(le.AddressStatus = 'TARGET' AND ri.AddressStatus = 'CURRENT') OR
															(ri.AddressStatus = 'TARGET' AND le.AddressStatus = 'CURRENT') => 'CT', // Merge Current/Target Address to avoid searching the keys twice for the same address
																																																le.AddressStatus);
		// Keep these if populated
		SELF.DwellingType := IF(le.DwellingType = '', ri.DwellingType, le.DwellingType);
		SELF.AddrCleanerStatus := IF(le.AddrCleanerStatus = '', ri.AddrCleanerStatus, le.AddrCleanerStatus);
		SELF.County := IF(ri.AddressStatus IN ['TARGET', 'CT'], ri.County, le.County); // Keep the county for the Target address as this is the newer cleaned county
		SELF.Date := IF(le.Date = '', ri.Date, le.Date);
		SELF.Lat := IF(le.Lat = '', ri.Lat, le.Lat);
		SELF.Long := IF(le.Long = '', ri.Long, le.Long);
		SELF.DistanceFromTarget := 0;
		SELF := le;
	END;
	CTAddressesAll :=	ShellResults[1].SubjectAddresses (AddressStatus IN ['TARGET', 'CURRENT']); // Get the input and current addresses
	
	CTAddressesAllSorted := SORT(UNGROUP(CTAddressesAll), Prim_Range, Prim_Name, Predir, Addr_Suffix, Sec_Range, Z5);
	
	CTAddressesRolled := ROLLUP(CTAddressesAllSorted, LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND
																				LEFT.Predir = RIGHT.Predir AND LEFT.Addr_Suffix = RIGHT.Addr_Suffix AND
																				LEFT.Sec_Range = RIGHT.Sec_Range AND LEFT.z5 = RIGHT.z5, rollAddresses(LEFT, RIGHT));

	//We need to display county name rather than county number so go pick up name here
	CTAddresses := join(CTAddressesRolled, census_data.Key_Fips2County, 
    keyed(left.st=right.state_code) and
    keyed(left.county=right.county_fips),
    transform(VerificationOfOccupancy.Layouts.Subject_Addresses, 
      self.county := right.county_name,
      self := left,
      self := []), left outer, KEEP(1), ATMOST(500));
	
	// Get the dwelling type and address cleaner status for addresses that don't have it (Addresses that we found from the header, not from Input as the Input should have already be cleaned)
	VerificationOfOccupancy.Layouts.Subject_Addresses getDwellType(VerificationOfOccupancy.Layouts.Subject_Addresses le) := TRANSFORM
		street_addr := Address.Addr1FromComponents(le.prim_range, le.predir, le.prim_name, le.addr_suffix, le.postdir, le.unit_desig, le.sec_range);
		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(street_addr, le.city_name, le.st, le.z5);
		SELF.DwellingType := Risk_Indicators.iid_constants.override_addr_type(street_addr, Address.CleanFields(clean_a2).rec_type[1], Address.CleanFields(clean_a2).cart);
		SELF.AddrCleanerStatus := Address.CleanFields(clean_a2).err_stat;
		thisLat := Address.CleanFields(clean_a2).Geo_Lat;
		thisLong := Address.CleanFields(clean_a2).Geo_Long;
		SELF.Lat := thisLat;
		SELF.Long := thisLong;
		
		SELF.DistanceFromTarget := IF(le.AddressStatus IN ['TARGET', 'CT'], 0,
																																				UT.LL_Dist((REAL)ShellResults[1].Lat, (REAL)ShellResults[1].Long, (REAL)thisLat, (REAL)thisLong));
		
		SELF := le;
	END;
	CTDwellStatus := PROJECT(CTAddresses (DwellingType = '' OR AddrCleanerStatus = '' OR Lat = '' OR Long = ''), getDwellType(LEFT));
	
	// Combine the newly cleaned header addresses with the already cleaned addresses
	CTAddressesClean := CTDwellStatus + (CTAddresses (DwellingType <> '' AND AddrCleanerStatus <> '' AND Lat <> '' AND Long <> ''));
		
	// At this point we have unique addresses, search for the metadata!
	ADVOAddressKey := ADVO.Key_Addr1_history;
	AddressRiskKey := Risk_Indicators.Key_HRI_Address_To_SIC;
	
	// Determine if the Address Cleaner thinks the Address is invalid
	VerificationOfOccupancy.Layouts.Subject_Addresses getInvalidAddr(VerificationOfOccupancy.Layouts.Subject_Addresses le) := TRANSFORM
		SELF.InvalidAddress := le.AddrCleanerStatus[1] = 'E'; // If the address cleaner returned an error with the address, mark it as invalid
		
		SELF := le;
	END;
	CTAddressesFinal := PROJECT(CTAddressesClean, getInvalidAddr(LEFT));
	
	// Get the ADVO (Valassis) Data
	VerificationOfOccupancy.Layouts.Subject_Addresses getADVO(VerificationOfOccupancy.Layouts.Subject_Addresses le, ADVOAddressKey ri) := TRANSFORM
		SELF.ADVOResidentialBusiness := TRIM(ri.Residential_Or_Business_Ind);
		SELF.ADVOType := TRIM(ri.Record_Type_Code);
		SELF.ADVOMixedUse := TRIM(ri.Mixed_Address_Usage);
		SELF.ADVOVacant := TRIM(ri.Address_Vacancy_Indicator) = 'Y';
		SELF.ADVOSeasonal := TRIM(ri.Seasonal_Delivery_Indicator) = 'Y';
	
		SELF := le;
	END;
	CTAddressesADVOTemp := JOIN(CTAddressesFinal, ADVOAddressKey, isXML AND LEFT.Z5 <> '' AND LEFT.Prim_Name <> '' AND
																					KEYED(LEFT.z5 = RIGHT.zip AND LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND
																								LEFT.Addr_Suffix = RIGHT.Addr_Suffix AND LEFT.Predir = RIGHT.Predir AND LEFT.Postdir = RIGHT.Postdir AND
																								LEFT.Sec_Range = RIGHT.Sec_Range), 
																			getADVO(LEFT, RIGHT), LEFT OUTER, KEEP(100), ATMOST(RiskWise.max_atmost));
	
	// It's possible to get multiple ADVO Results, keep the most information we can
	VerificationOfOccupancy.Layouts.Subject_Addresses rollADVO(VerificationOfOccupancy.Layouts.Subject_Addresses le, VerificationOfOccupancy.Layouts.Subject_Addresses ri) := TRANSFORM
		SELF.ADVOResidentialBusiness := MAP(le.ADVOResidentialBusiness = 'D' OR ri.ADVOResidentialBusiness = 'D' => 'D',
																				le.ADVOResidentialBusiness = 'C' OR ri.ADVOResidentialBusiness = 'C' => 'C',
																				le.ADVOResidentialBusiness = 'B' OR ri.ADVOResidentialBusiness = 'B' => 'B',
																				le.ADVOResidentialBusiness = 'A' OR ri.ADVOResidentialBusiness = 'A' => 'A',
																																																								le.ADVOResidentialBusiness);
		SELF.ADVOType := IF(le.ADVOType = '', ri.ADVOType, le.ADVOType);
		SELF.ADVOMixedUse := IF(le.ADVOMixedUse = '', ri.ADVOMixedUse, le.ADVOMixedUse);
		SELF.ADVOVacant := le.ADVOVacant OR ri.ADVOVacant;
		SELF.ADVOSeasonal := le.ADVOSeasonal OR ri.ADVOSeasonal;
		
		SELF := le;
	END;
	CTAddressesADVOSorted := SORT(UNGROUP(CTAddressesADVOTemp), Z5, Prim_Range, Prim_Name, Addr_Suffix, Predir, Postdir, Sec_Range);
	
	CTAddressesADVO := ROLLUP(CTAddressesADVOSorted, LEFT.Z5 = RIGHT.Z5 AND LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND
																								LEFT.Addr_Suffix = RIGHT.Addr_Suffix AND LEFT.Predir = RIGHT.Predir AND LEFT.Postdir = RIGHT.Postdir AND
																								LEFT.Sec_Range = RIGHT.Sec_Range, 
																			rollADVO(LEFT, RIGHT));
	
	// Get the High Risk Indicators for the Addresses
	VerificationOfOccupancy.Layouts.Subject_Addresses getHRI(VerificationOfOccupancy.Layouts.Subject_Addresses le, AddressRiskKey ri) := TRANSFORM
		SELF.CorrectionalFacility := ri.SIC_Code = '2225';
		
		SELF.HRIAddress := IF(ri.SIC_Code <> '', DATASET([{ri.SIC_Code, Codes.Various_HRI_Files.HRI_Code(ri.SIC_Code)}], Risk_Indicators.Layout_Desc),
																						 DATASET([], Risk_Indicators.Layout_Desc));
		
		SELF := le;
	END;
	CTAddressesMetadataTemp := JOIN(CTAddressesADVO, AddressRiskKey, LEFT.Z5 <> '' AND LEFT.Prim_Name <> '' AND
																					KEYED(LEFT.Z5 = RIGHT.Z5 AND LEFT.Prim_Name = RIGHT.Prim_Name AND LEFT.Addr_Suffix = RIGHT.Suffix AND LEFT.Predir = RIGHT.Predir AND
																								LEFT.Postdir = RIGHT.Postdir AND LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Sec_Range = RIGHT.Sec_Range), 
																			getHRI(LEFT, RIGHT), LEFT OUTER, KEEP(100), ATMOST(RiskWise.max_atmost));

	// It's possible to get multiple results from the Address Risk Key, keep the most information we can
	VerificationOfOccupancy.Layouts.Subject_Addresses rollHRI(VerificationOfOccupancy.Layouts.Subject_Addresses le, VerificationOfOccupancy.Layouts.Subject_Addresses ri) := TRANSFORM
		SELF.CorrectionalFacility := le.CorrectionalFacility OR ri.CorrectionalFacility;
		
		// Keep Unique HRI's for this Address
		SELF.HRIAddress := DEDUP(SORT((le.HRIAddress + ri.HRIAddress), HRI), HRI);
		
		SELF := le;
	END;
	CTAddressesMetadataSorted := SORT(UNGROUP(CTAddressesMetadataTemp), Z5, Prim_Range, Prim_Name, Addr_Suffix, Predir, Postdir, Sec_Range);
	
	CTAddressesMetadata := ROLLUP(CTAddressesMetadataSorted, LEFT.Z5 = RIGHT.Z5 AND LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND
																								LEFT.Addr_Suffix = RIGHT.Addr_Suffix AND LEFT.Predir = RIGHT.Predir AND LEFT.Postdir = RIGHT.Postdir AND
																								LEFT.Sec_Range = RIGHT.Sec_Range, 
																			rollHRI(LEFT, RIGHT));

	// ****************************************************************
	// *  Gather Supporting Records - Confirming Source Counts/Dates  *
	// ****************************************************************
	PersonHeaderKey := Doxie.Key_Header;
	PersonQuickHeaderKey := Header_Quick.Key_DID;
	
	SourceCountsTemp := RECORD
		STRING32 SourceType := '';
		STRING8 DateFirstSeen := '';
		STRING8 DateLastSeen := '';
		INTEGER2 SourceCount := 0;
	END;
	
	HeaderReportMacro (transformName, keyName) := MACRO
		SourceCountsTemp transformName(ShellResults le, keyName ri) := TRANSFORM
			SELF.SourceType := MAP(ri.Src IN [MDR.SourceTools.src_Equifax, MDR.SourceTools.src_Equifax_Quick, MDR.SourceTools.src_Equifax_Weekly]	=> 'Consumer Reporting Agency 1', // Equifax Credit Header
														 ri.Src IN MDR.SourceTools.set_Experian_Credit_Header																														=> 'Consumer Reporting Agency 2', // Experian Credit Header
														 ri.Src IN MDR.SourceTools.set_TransUnion_Credit_Header																													=> 'Consumer Reporting Agency 3', // TransUnion Credit Header
														 ri.Src IN MDR.SourceTools.set_Professional_License																															=> 'Professional License', // Professional License Registration
														 ri.Src IN MDR.SourceTools.set_Voters_v2																																				=> 'Voter Registration', // Voter Registration
														 ri.Src IN MDR.SourceTools.set_DL																																								=> 'Driver\'s License', // Driver's License Registration
														 ri.Src IN (MDR.SourceTools.set_Vehicles + MDR.SourceTools.set_Aircrafts + MDR.SourceTools.set_WC)							=> 'Asset Registration', // Aircraft, Vehicle or Watercraft Registration
														 ri.Src IN [MDR.SourceTools.src_Fares_Deeds_from_Asrs, MDR.SourceTools.src_LnPropV2_Fares_Deeds, 
																				MDR.SourceTools.src_LnPropV2_Lexis_Deeds_Mtgs, MDR.SourceTools.src_LnPropV2_Fares_Asrs, 
																				MDR.SourceTools.src_LnPropV2_Lexis_Asrs]																														=> 'Property Record', // Deed or Tax Assessment
														 ri.Src IN (MDR.SourceTools.set_BK + MDR.SourceTools.set_Liens) 																								=> 'Court Record', // Liens, Judgments, Bankruptcies
														 ri.Src IN MDR.SourceTools.set_Targus_White_pages 																															=> 'Whitepages', // Whitepages
														 ri.Src IN MDR.SourceTools.set_Utility_sources 																																	=> 'Utility Record', // Utilities
														 ri.Src IN (MDR.SourceTools.set_EMerge_CCW + [MDR.SourceTools.src_EMerge_Hunt, MDR.SourceTools.src_EMerge_Fish])=> 'Other License', // Hunting, Fishing, Concealed Weapons
														 																																																									 'Other Source');

			withinRange := RI.DT_First_Seen <> 0 AND RI.DT_First_Seen <= LE.historydate;  // Check the history date

			// Header dates only contain YYYYMM, the [1..6] just ensures that some rogue date doesn't impact our MIN/MAX of dates in the rollup below
			SELF.DateFirstSeen 	:= ((STRING)ri.DT_First_Seen)[1..6];
			SELF.DateLastSeen 	:= ((STRING)ri.DT_Last_Seen)[1..6];
			SELF.SourceCount 		:= if(withinRange, 1, 0); // Count header recs that match the target address and are prior to "AsOf" date
		END;
	ENDMACRO;
	// Initialize the transforms
	HeaderReportMacro(getReportHeader, PersonHeaderKey);
	HeaderReportMacro(getReportQuickHeader, PersonQuickHeaderKey);
	
	reportHeader := JOIN(ShellResults, PersonHeaderKey,	
									LEFT.DID <> 0 AND
									KEYED(LEFT.DID = RIGHT.s_DID) AND
									//for confirming sources, keep only header recs that match our target address
									trim(left.z5) = trim(right.zip) and
									trim(left.prim_range) = trim(right.prim_range) and
									ut.NNEQ(trim(left.sec_range), trim(right.sec_range)) and
									trim(left.prim_name) = trim(right.prim_name) and
									trim(left.addr_suffix) = trim(right.suffix) and
									trim(left.predir) = trim(right.predir) and
									trim(left.postdir) = trim(right.postdir) and
									RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) AND
								 (RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) and // Check the history date
									GLB_Ok AND
									(~MDR.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
									(~MDR.Source_is_DPPA(RIGHT.src) OR 
										(DPPA_Ok AND Drivers.State_DPPA_Ok(Header.translateSource(RIGHT.src), DPPAPurpose, RIGHT.src))), 
									getReportHeader(LEFT, RIGHT), KEEP(200), ATMOST(RiskWise.max_atmost));

	reportQHeader := JOIN(ShellResults, PersonQuickHeaderKey,		
									LEFT.DID <> 0 AND
									KEYED(LEFT.DID = RIGHT.DID) AND
									//for confirming sources, keep only header recs that match our target address
									trim(left.z5) = trim(right.zip) and
									trim(left.prim_range) = trim(right.prim_range) and
									ut.NNEQ(trim(left.sec_range), trim(right.sec_range)) and
									trim(left.prim_name) = trim(right.prim_name) and
									trim(left.addr_suffix) = trim(right.suffix) and
									trim(left.predir) = trim(right.predir) and
									trim(left.postdir) = trim(right.postdir) and
									RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources_all(DataRestrictionMask, isFCRA) + 
									// If we have an Equifax data restriction, restrict the QH AND WH sources (This isn't caught in the masked_header_source)
									IF(DataRestrictionMask[Risk_Indicators.iid_constants.posEquifaxRestriction] = '1', [MDR.sourceTools.src_Equifax_Quick, MDR.sourceTools.src_Equifax_Weekly], []) AND
								 (RIGHT.dt_first_seen <> 0 AND RIGHT.dt_first_seen <= LEFT.historydate) and  // Check the history date
									GLB_Ok AND
									(~MDR.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
									(	~MDR.Source_is_DPPA(RIGHT.src) OR 
										(DPPA_Ok AND Drivers.State_DPPA_Ok(Header.translateSource(RIGHT.src), DPPAPurpose, RIGHT.src))), 
									getReportQuickHeader(LEFT, RIGHT), KEEP(200), ATMOST(RiskWise.max_atmost));
	
	combinedReportHeader := SORT(UNGROUP(reportHeader + reportQHeader), SourceType, -DateLastSeen, DateFirstSeen) ((INTEGER)DateFirstSeen > 0 AND (INTEGER)DateLastSeen > 0);
	
	SourceCountsTemp rollReportHeader(SourceCountsTemp le, SourceCountsTemp ri) := TRANSFORM
		SELF.SourceType := le.SourceType;
		SELF.SourceCount := le.SourceCount + ri.SourceCount;
		SELF.DateFirstSeen := MAP((INTEGER)le.DateFirstSeen <= 0 OR le.DateFirstSeen[5..6] = '00' => ri.DateFirstSeen,
															(INTEGER)ri.DateFirstSeen <= 0 OR ri.DateFirstSeen[5..6] = '00' => le.DateFirstSeen,
																															 (STRING)MIN((UNSIGNED)le.DateFirstSeen, (UNSIGNED)ri.DateFirstSeen));
		SELF.DateLastSeen := MAP(le.DateLastSeen[5..6] = '00' => ri.DateLastSeen,
														 ri.DateLastSeen[5..6] = '00' => le.DateLastSeen,
																														(STRING)MAX((INTEGER)le.DateLastSeen, (INTEGER)ri.DateLastSeen));
	END;
	rolledReportHeader := ROLLUP(combinedReportHeader, LEFT.SourceType = RIGHT.SourceType, rollReportHeader(LEFT, RIGHT));
	
	// ****************************************************************
	// *     Gather Supporting Records - Other Real-Estate Owned      *
	// *     We potentially need two sets of properties...            *
	// *     1. Properties currently owned by the subject             *
	// *     2. Properties owned by the subject at the "AsOf" date    *
	// ****************************************************************
// Go determine the properties the input subject owns - if running with 'AsOf' date, need properties owned at that date as well
	todaysDate2			:= (integer)((STRING)Std.Date.Today())[1..6];
	historyDate			:= (integer)shellResults[1].historyDate; 
	archiveMode			:= ((string)historydate)[1..4] < ((string)todaysdate2)[1..4];  //if running "AsOf" a prior year, set indicator
	
//go get owned properties for our subject using the historydate on the transaction (could be today's date or an archive date)
	propOwners	:= VerificationOfOccupancy.getPropOwnership(ShellResults, fares_ok); 

//append this info back to our main file
	VerificationOfOccupancy.Layouts.Layout_VOOShell getOwnedProps(ShellResults le, propOwners ri) := TRANSFORM
		SELF.other_prox_owned 				:= ri.property_owned;
		SELF.other_prox_sold 					:= ri.property_sold;
		SELF.other_prox_date					:= ri.property_date;
		SELF.other_prox_distance  		:= ut.LL_Dist((real)le.lat, (real)le.long, (real)ri.property_lat, (real)ri.property_long);	
		SELF.other_prox_prim_range		:= ri.property_prim_range; 	
		SELF.other_prox_predir				:= ri.property_predir;		
		SELF.other_prox_prim_name			:= ri.property_prim_name;	
		SELF.other_prox_suffix				:= ri.property_suffix;  
		SELF.other_prox_postdir				:= ri.property_postdir;		
		SELF.other_prox_sec_range			:= ri.property_sec_range;	
		SELF.other_prox_city					:= ri.property_city;	
		SELF.other_prox_st						:= ri.property_st;	
		SELF.other_prox_zip						:= ri.property_zip;	
		SELF.other_prox_lat  					:= ri.property_lat;	
		SELF.other_prox_long  				:= ri.property_long;
		SELF.other_prox_fares_ID			:= ri.property_fares_ID;
		SELF 													:= le;
	END;	

	with_Owned := join(ShellResults, propOwners, 
				left.seq = right.seq,
				getOwnedProps(left,right),left outer);

	//project todays date into the request and run properties again if the original request is running in archive mode
	currRequest := project(ShellResults, TRANSFORM(VerificationOfOccupancy.Layouts.Layout_VOOShell, 
															self.historydate := todaysdate2; 
															self := left));
	
	//if the query is running in archive mode, we need to run properties again to get currently owned properties
	propOwnersCurr 		:= if(archiveMode, VerificationOfOccupancy.getPropOwnership(currRequest, fares_ok)); 

	//append this info back to our main file
	VerificationOfOccupancy.Layouts.Layout_VOOShell getOtherAddr(ShellResults le, propOwnersCurr ri) := TRANSFORM
		SELF.other_prox_owned					:= ri.property_owned;
		SELF.other_prox_sold					:= ri.property_sold;
		SELF.other_prox_date					:= ri.property_date;
		SELF.other_prox_distance  		:= ut.LL_Dist((real)le.lat, (real)le.long, (real)ri.property_lat, (real)ri.property_long);	
		SELF.other_prox_prim_range		:= ri.property_prim_range; 	
		SELF.other_prox_predir				:= ri.property_predir;		
		SELF.other_prox_prim_name			:= ri.property_prim_name;	
		SELF.other_prox_suffix				:= ri.property_suffix;  
		SELF.other_prox_postdir				:= ri.property_postdir;		
		SELF.other_prox_sec_range			:= ri.property_sec_range;	
		SELF.other_prox_city					:= ri.property_city;	
		SELF.other_prox_st						:= ri.property_st;	
		SELF.other_prox_zip						:= ri.property_zip;	
		SELF.other_prox_lat  					:= ri.property_lat;	
		SELF.other_prox_long  				:= ri.property_long;
		SELF.other_prox_fares_ID			:= ri.property_fares_ID;
		SELF 													:= le;
	END;	

	with_OwnedCurr := join(ShellResults, propOwnersCurr, 
				left.seq = right.seq,
				getOtherAddr(left,right),left outer);

	//sort and dedup properties by unique address
	ownedAddresses := dedup(sort(with_Owned(other_prox_owned='1' and other_prox_sold<>'1'), other_prox_prim_range, other_prox_prim_name, other_prox_zip), other_prox_prim_range, other_prox_prim_name, other_prox_zip);

	//sort and dedup current properties by unique address
	ownedAddressesC := dedup(sort(with_OwnedCurr(other_prox_owned='1' and other_prox_sold<>'1'), other_prox_prim_range, other_prox_prim_name, other_prox_zip), other_prox_prim_range, other_prox_prim_name, other_prox_zip);

	ownedAddressesAsOf := if(archiveMode, ownedAddresses);
	ownedAddressesCurr := if(archiveMode, ownedAddressesC, ownedAddresses);  //
	// ****************************************************************
	// *    Gather Supporting Records - Phone and Utility Records     *
	// * 1.) One Section By Input (Target) Address                    *
	// * 2.) Second Section By Subject DID                            *
	// ****************************************************************
	GongAddressKey := Gong.Key_History_Address;
	UtilityAddressKey := UtilFile.Key_Address;
	TargusAddressKey := Targus.Key_Targus_Address;
	
	GongDIDKey := Gong.Key_History_DID;
	UtilityDIDKey := Utilfile.Key_DID;
	TargusDIDKey := Targus.Key_Targus_DID;
	
	VerificationOfOccupancy.Layouts.SupportingRecords getGongAddress(ShellResults le, GongAddressKey ri) := TRANSFORM
		SELF.ServiceType := 'Phone';
		SELF.PropertySearch := TRUE;
		SELF.DateFirstSeen := ri.DT_First_Seen[1..6];
		SELF.DateLastSeen := ri.DT_Last_Seen[1..6];
		
		SELF.ReportedFName := ri.Name_First;
		SELF.ReportedMName := ri.Name_Middle;
		SELF.ReportedLName := ri.Name_Last;
		SELF.LexID := (unsigned8)ri.did;
		SELF := [];
	END;
	gongAddr := JOIN(ShellResults, GongAddressKey, isXML AND LEFT.Prim_Name <> '' AND LEFT.Z5 <> '' AND
													KEYED(LEFT.Prim_Name = RIGHT.Prim_Name AND LEFT.St = RIGHT.St AND LEFT.Z5 = RIGHT.Z5 AND
																LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Sec_Range = RIGHT.Sec_Range) AND 
													RIGHT.Current_Flag = TRUE AND
													(INTEGER)RIGHT.Dt_First_seen > 0 AND (INTEGER)(RIGHT.Dt_First_Seen[1..6]) <= LEFT.historydate,
											getGongAddress(LEFT, RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost));
	
	VerificationOfOccupancy.Layouts.SupportingRecords getUtilityAddress(ShellResults le, UtilityAddressKey ri) := TRANSFORM
		SELF.ServiceType := 'Utility';
		SELF.PropertySearch := TRUE;
		SELF.DateFirstSeen := ri.Date_First_Seen[1..6];
		SELF.DateLastSeen := '0'; // Utility Data doesn't contain date last seen
		
		SELF.ReportedFName := ri.FName;
		SELF.ReportedMName := ri.MName;
		SELF.ReportedLName := ri.LName;
		SELF.LexID := (unsigned8)ri.did;
		
		SELF := [];
	END;
	utilityAddr := JOIN(ShellResults, UtilityAddressKey, isXML AND LEFT.Prim_Name <> '' AND LEFT.Z5 <> '' AND
													KEYED(LEFT.Prim_Name = RIGHT.Prim_Name AND LEFT.St = RIGHT.St AND LEFT.Z5 = RIGHT.Zip AND
																LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Sec_Range = RIGHT.Sec_Range) AND
													GLB_OK AND
													~isUtility AND RIGHT.util_type <> 'Z' AND RIGHT.addr_type <> 'B' AND  //don't include billing addresses
													(INTEGER)(RIGHT.Date_First_Seen[1..6]) <= LEFT.historydate AND (INTEGER)RIGHT.Date_First_Seen > 0,
											getUtilityAddress(LEFT, RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost));
	
	VerificationOfOccupancy.Layouts.SupportingRecords getTargusAddress(ShellResults le, TargusAddressKey ri) := TRANSFORM
		SELF.ServiceType := 'Phone';
		SELF.PropertySearch := TRUE;
		SELF.DateFirstSeen := ((STRING)ri.DT_First_Seen)[1..6];
		SELF.DateLastSeen := ((STRING)ri.DT_Last_Seen)[1..6];
		
		SELF.ReportedFName := ri.FName;
		SELF.ReportedMName := ri.MInit;
		SELF.ReportedLName := ri.LName;
		SELF.LexID := (unsigned8)ri.did;
		
		SELF := [];
	END;
	targusAddr := JOIN(ShellResults, TargusAddressKey, isXML AND TRIM(LEFT.prim_name) != '' AND TRIM(LEFT.z5) != '' AND
														(KEYED(RIGHT.prim_name = LEFT.prim_name) AND KEYED(RIGHT.zip = LEFT.z5) AND
														 KEYED(RIGHT.prim_range = LEFT.prim_range) AND LEFT.sec_range = RIGHT.sec_range) AND
														 RIGHT.DT_First_Seen > 0 AND (INTEGER)(((STRING)RIGHT.DT_First_Seen)[1..6]) <= LEFT.historydate,
														getTargusAddress(LEFT, RIGHT),
														ATMOST(
															(KEYED(RIGHT.prim_name = LEFT.prim_name) AND KEYED(RIGHT.zip = LEFT.z5) AND
															 KEYED(RIGHT.prim_range = LEFT.prim_range)),
															RiskWise.max_atmost
														),
														KEEP(100));
																
	VerificationOfOccupancy.Layouts.SupportingRecords rollAddr(VerificationOfOccupancy.Layouts.SupportingRecords le, VerificationOfOccupancy.Layouts.SupportingRecords ri) := TRANSFORM
		// Get the earliest date first seen and oldest date last seen for this First/Middle/Last combination
		SELF.DateFirstSeen := MAP((INTEGER)le.DateFirstSeen <= 0 OR le.DateFirstSeen[5..6] = '00' => ri.DateFirstSeen,
															(INTEGER)ri.DateFirstSeen <= 0 OR ri.DateFirstSeen[5..6] = '00' => le.DateFirstSeen,
																															 (STRING)MIN((UNSIGNED)le.DateFirstSeen, (UNSIGNED)ri.DateFirstSeen));
		SELF.DateLastSeen := MAP(le.DateLastSeen[5..6] = '00' => ri.DateLastSeen,
														 ri.DateLastSeen[5..6] = '00' => le.DateLastSeen,
																														(STRING)MAX((INTEGER)le.DateLastSeen, (INTEGER)ri.DateLastSeen));
		SELF := le;
	END;
	// Rollup by the names that get discovered for our target address
	sortedPhoneAddr := SORT(UNGROUP((gongAddr + targusAddr) (PropertySearch = TRUE)), ReportedFName, ReportedMName, ReportedLName);
	sortedUtilAddr := SORT(UNGROUP(utilityAddr (PropertySearch = TRUE)), ReportedFName, ReportedMName, ReportedLName);
	
	phoneAddr := ROLLUP(sortedPhoneAddr, LEFT.ReportedFName = RIGHT.ReportedFName AND LEFT.ReportedMName = RIGHT.ReportedMName AND LEFT.ReportedLName = RIGHT.ReportedLName, rollAddr(LEFT, RIGHT));
	utilAddr := ROLLUP(sortedUtilAddr, LEFT.ReportedFName = RIGHT.ReportedFName AND LEFT.ReportedMName = RIGHT.ReportedMName AND LEFT.ReportedLName = RIGHT.ReportedLName, rollAddr(LEFT, RIGHT));
	
	combinedAddr := phoneAddr + utilAddr;
	
	VerificationOfOccupancy.Layouts.SupportingRecords getGongDID(ShellResults le, GongDIDKey ri) := TRANSFORM
		SELF.ServiceType := 'Phone';
		SELF.SubjectSearch := TRUE;
		SELF.DateFirstSeen := ri.DT_First_Seen[1..6];
		SELF.DateLastSeen := ri.DT_Last_Seen[1..6];
		
		StreetAddr := Address.Addr1FromComponents(ri.Prim_Range, ri.Predir, ri.Prim_Name, ri.Suffix, ri.Postdir, ri.Unit_Desig, ri.Sec_Range);
		SELF.ReportedStreetAddress := StreetAddr;
		SELF.ReportedCity := ri.P_City_Name;
		SELF.ReportedState := ri.St;
		SELF.ReportedZIP := ri.Z5;
		
		SELF.ReportedPrim_Range := ri.Prim_Range;
		SELF.ReportedPredir := ri.Predir;
		SELF.ReportedPrim_Name := ri.Prim_Name;
		SELF.ReportedAddr_Suffix := ri.Suffix;
		SELF.ReportedPostdir := ri.Postdir;
		SELF.ReportedUnit_Desig := ri.Unit_Desig;
		SELF.ReportedSec_Range := ri.Sec_Range;
		SELF.ReportedZip5 := ri.Z5;
		
		SELF := [];
	END;
	gongDID := JOIN(ShellResults, GongDIDKey, isXML AND LEFT.DID <> 0 AND
												KEYED(LEFT.DID = RIGHT.l_DID) AND RIGHT.Current_Flag = TRUE AND
												(INTEGER)RIGHT.DT_First_Seen > 0 AND (INTEGER)(RIGHT.DT_First_Seen[1..6]) <= LEFT.historydate,
										getGongDID(LEFT, RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost));
	
	VerificationOfOccupancy.Layouts.SupportingRecords getUtilityDID(ShellResults le, UtilityDIDKey ri) := TRANSFORM
		SELF.ServiceType := 'Utility';
		SELF.SubjectSearch := TRUE;
		SELF.DateFirstSeen := ri.Date_First_Seen[1..6];
		SELF.DateLastSeen := '0'; // Utility Data doesn't contain Date Last Seen
		
		StreetAddr := Address.Addr1FromComponents(ri.Prim_Range, ri.Predir, ri.Prim_Name, ri.Addr_Suffix, ri.Postdir, ri.Unit_Desig, ri.Sec_Range);
		SELF.ReportedStreetAddress := StreetAddr;
		SELF.ReportedCity := ri.P_City_Name;
		SELF.ReportedState := ri.St;
		SELF.ReportedZIP := ri.Zip;
		
		SELF.ReportedPrim_Range := ri.Prim_Range;
		SELF.ReportedPredir := ri.Predir;
		SELF.ReportedPrim_Name := ri.Prim_Name;
		SELF.ReportedAddr_Suffix := ri.Addr_Suffix;
		SELF.ReportedPostdir := ri.Postdir;
		SELF.ReportedUnit_Desig := ri.Unit_Desig;
		SELF.ReportedSec_Range := ri.Sec_Range;
		SELF.ReportedZip5 := ri.Zip[1..5];
		
		SELF := [];
	END;
	utilityDID := JOIN(ShellResults, UtilityDIDKey, isXML AND LEFT.DID <> 0 AND
													KEYED(LEFT.DID = RIGHT.s_DID) AND GLB_OK AND
													~isUtility AND RIGHT.util_type <> 'Z' AND RIGHT.addr_type <> 'B' AND
													(INTEGER)(RIGHT.Date_First_Seen[1..6]) <= LEFT.historydate AND (INTEGER)RIGHT.Date_First_Seen > 0,
												getUtilityDID(LEFT, RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost));
	
	VerificationOfOccupancy.Layouts.SupportingRecords getTargusDID(ShellResults le, TargusDIDKey ri) := TRANSFORM
		SELF.ServiceType := 'Phone';
		SELF.SubjectSearch := TRUE;
		SELF.DateFirstSeen := ((STRING)ri.DT_First_Seen)[1..6];
		SELF.DateLastSeen := ((STRING)ri.DT_Last_Seen)[1..6];
		
		StreetAddr := Address.Addr1FromComponents(ri.Prim_Range, ri.Predir, ri.Prim_Name, ri.Suffix, ri.Postdir, ri.Unit_Desig, ri.Sec_Range);
		SELF.ReportedStreetAddress := StreetAddr;
		SELF.ReportedCity := ri.City_Name;
		SELF.ReportedState := ri.St;
		SELF.ReportedZIP := ri.Zip;
		
		SELF.ReportedPrim_Range := ri.Prim_Range;
		SELF.ReportedPredir := ri.Predir;
		SELF.ReportedPrim_Name := ri.Prim_Name;
		SELF.ReportedAddr_Suffix := ri.Suffix;
		SELF.ReportedPostdir := ri.Postdir;
		SELF.ReportedUnit_Desig := ri.Unit_Desig;
		SELF.ReportedSec_Range := ri.Sec_Range;
		SELF.ReportedZip5 := ri.Zip[1..5];
		
		SELF := [];
	END;
	targusDID := JOIN(ShellResults, TargusDIDKey, isXML AND LEFT.DID <> 0 AND
												KEYED(LEFT.DID = RIGHT.DID) AND
												RIGHT.DT_First_Seen > 0 AND (INTEGER)(((STRING)RIGHT.DT_First_Seen)[1..6]) <= LEFT.historydate,
											getTargusDID(LEFT, RIGHT), KEEP(100), ATMOST(RiskWise.max_atmost));
											
	VerificationOfOccupancy.Layouts.SupportingRecords rollSubject(VerificationOfOccupancy.Layouts.SupportingRecords le, VerificationOfOccupancy.Layouts.SupportingRecords ri) := TRANSFORM
		// Get the earliest date first seen and oldest date last seen for this First/Middle/Last combination
		SELF.DateFirstSeen := MAP((INTEGER)le.DateFirstSeen <= 0 OR le.DateFirstSeen[5..6] = '00' => ri.DateFirstSeen,
															(INTEGER)ri.DateFirstSeen <= 0 OR ri.DateFirstSeen[5..6] = '00'  => le.DateFirstSeen,
																															 (STRING)MIN((UNSIGNED)le.DateFirstSeen, (UNSIGNED)ri.DateFirstSeen));
		SELF.DateLastSeen := MAP(le.DateLastSeen[5..6] = '00' => ri.DateLastSeen,
														 ri.DateLastSeen[5..6] = '00' => le.DateLastSeen,
																														(STRING)MAX((INTEGER)le.DateLastSeen, (INTEGER)ri.DateLastSeen));
		SELF := le;
	END;
	// Rollup by the names that get discovered for our target address
	sortedPhoneSubject := SORT(UNGROUP((gongDID + targusDID) (SubjectSearch = TRUE)), ReportedStreetAddress, ReportedCity, ReportedZIP);
	sortedUtilSubject := SORT(UNGROUP(utilityDID (SubjectSearch = TRUE)), ReportedStreetAddress, ReportedCity, ReportedZIP);
	
	phoneSubject := ROLLUP(sortedPhoneSubject, LEFT.ReportedStreetAddress = RIGHT.ReportedStreetAddress AND LEFT.ReportedCity = RIGHT.ReportedCity AND LEFT.ReportedZIP = RIGHT.ReportedZIP, rollSubject(LEFT, RIGHT));
	utilSubject := ROLLUP(sortedUtilSubject, LEFT.ReportedStreetAddress = RIGHT.ReportedStreetAddress AND LEFT.ReportedCity = RIGHT.ReportedCity AND LEFT.ReportedZIP = RIGHT.ReportedZIP, rollSubject(LEFT, RIGHT));
	
	combinedSubject := phoneSubject + utilSubject;
	
	// ****************************************************************
	// * Gather Supporting Records - Identities Associated with Input *
	// * (Target) Property.                                           *
	// ****************************************************************
	HeaderAddressKey := Doxie.Key_Header_Address;
	
	VerificationOfOccupancy.Layouts.SupportingRecordsAddr getSupportingAddr(ShellResults le, HeaderAddressKey ri) := TRANSFORM
		SELF.FName := ri.FName;
		SELF.LName := ri.LName;
		SELF.LexID := ri.DID;
		SELF.DateFirstSeen := ((STRING)ri.DT_First_Seen)[1..6];
		SELF.DateLastSeen := ((STRING)ri.DT_Last_Seen)[1..6];
		SELF.AssociationToSubject := ''; // This will be calculated next with a join to the new relatives key
		SELF.age	 := if(ri.dob = 0, 0, risk_indicators.years_apart((unsigned)le.HistoryDate, (unsigned)ri.dob));
	END;
	
	supportingAddrTemp := JOIN(ShellResults, HeaderAddressKey, isXML AND LEFT.Prim_Name <> '' AND LEFT.Z5 <> '' AND 
																	KEYED(LEFT.Prim_Name = RIGHT.Prim_Name AND LEFT.Z5 = RIGHT.Zip AND
																				LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Sec_Range = RIGHT.Sec_Range) AND 
																			RIGHT.DT_First_Seen <> 0 AND RIGHT.DT_First_Seen <= LEFT.historydate AND RIGHT.DID <> 0 AND
																			glb_ok AND
																			(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
																			(	~mdr.Source_is_DPPA(RIGHT.src) OR 
																			(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src), DPPAPurpose ,RIGHT.src))), 
															getSupportingAddr(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(RiskWise.max_atmost));
															
	SupportingAddrSorted := SORT(UNGROUP(supportingAddrTemp), FName, LName, LexID, DateFirstSeen, -DateLastSeen);
	
	VerificationOfOccupancy.Layouts.SupportingRecordsAddr rollSupportingAddr(VerificationOfOccupancy.Layouts.SupportingRecordsAddr le, VerificationOfOccupancy.Layouts.SupportingRecordsAddr ri) := TRANSFORM
		SELF.FName := le.FName;
		SELF.LName := le.LName;
		SELF.LexID := le.LexID;
		SELF.AssociationToSubject := ''; // This will be calculated next with a join to the new relatives key
		
		// Prefer to keep valid dates
		SELF.DateFirstSeen := MAP((INTEGER)le.DateFirstSeen <= 0 OR le.DateFirstSeen[5..6] = '00' => ri.DateFirstSeen,
															(INTEGER)ri.DateFirstSeen <= 0 OR ri.DateFirstSeen[5..6] = '00' => le.DateFirstSeen,
																																(STRING)MIN((UNSIGNED)le.DateFirstSeen, (UNSIGNED)ri.DateFirstSeen));
		SELF.DateLastSeen := MAP(le.DateLastSeen[5..6] = '00' => ri.DateLastSeen,
														 ri.DateLastSeen[5..6] = '00' => le.DateLastSeen,
																											(STRING)MAX((INTEGER)le.DateLastSeen, (INTEGER)ri.DateLastSeen));
		SELF.Age 	:= MAX(le.age, ri.age); //keep whichever is populated
	END;
	supportingAddr := ROLLUP(SupportingAddrSorted, LEFT.FName = RIGHT.FName AND LEFT.LName = RIGHT.LName AND LEFT.LexID = RIGHT.LexID, rollSupportingAddr(LEFT, RIGHT));
	
	VerificationOfOccupancy.Layouts.SupportingRecordsAddr rollSupportingIdentities(VerificationOfOccupancy.Layouts.SupportingRecordsAddr le, VerificationOfOccupancy.Layouts.SupportingRecordsAddr ri) := TRANSFORM
		// Use the name of the most recently last seen record with the oldest first seen date
		SELF.FName := le.FName;
		SELF.LName := le.LName;
		
		SELF.LexID := le.LexID;
		
		// Prefer to keep valid dates
		SELF.DateFirstSeen := MAP((INTEGER)le.DateFirstSeen <= 0 OR le.DateFirstSeen[5..6] = '00' => ri.DateFirstSeen,
															(INTEGER)ri.DateFirstSeen <= 0 OR ri.DateFirstSeen[5..6] = '00' => le.DateFirstSeen,
																																(STRING)MIN((UNSIGNED)le.DateFirstSeen, (UNSIGNED)ri.DateFirstSeen));
		SELF.DateLastSeen := MAP(le.DateLastSeen[5..6] = '00' => ri.DateLastSeen,
														 ri.DateLastSeen[5..6] = '00' => le.DateLastSeen,
																														(STRING)MAX((INTEGER)le.DateLastSeen, (INTEGER)ri.DateLastSeen));
		SELF.Age := MAX(le.age, ri.age); //keep whichever is populated
		SELF := le;
	END;
	supportingIdentitiesSorted := SORT(supportingAddr, LexID, -DateLastSeen, DateFirstSeen, FName, LName);
	
	supportingIdentities := ROLLUP(supportingIdentitiesSorted, LEFT.LexID = RIGHT.LexID, rollSupportingIdentities(LEFT, RIGHT));
	
	RelativesLayout := RECORD
		UNSIGNED8 SubjectDID := 0;
		UNSIGNED8 RelativesDID := 0;
		STRING50 RelationshipToSubject := '';
	END;
	
	shellres_dedp := dedup(sort(ungroup(ShellResults(isXML and did<>0)),did), did);
	shellDids := PROJECT(shellres_dedp, 
		TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));

	rellyids := Relationship.proc_GetRelationship(shellDids,TopNCount:=100,
				RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result;   //All Relationships in new Format; limit set to 100 on key join
	
	RelativesLayout getSubjectRelatives(ShellResults le, rellyids ri) := TRANSFORM
		SELF.SubjectDID := le.DID;
		SELF.RelativesDID := ri.did2;
		SELF.RelationshipToSubject := Header.Relative_Titles.FN_Get_Str_Title(ri.Title); // Get the string title
	END;	
	
	subjectRelativesTemp := JOIN(ShellResults, rellyids, isXML AND LEFT.DID <> 0 AND LEFT.DID = RIGHT.did1, 
															getSubjectRelatives(LEFT, RIGHT));
	subjectRelatives := SORT(UNGROUP(PROJECT((ShellResults (DID <> 0)), TRANSFORM(RelativesLayout, 
		SELF.SubjectDID := LEFT.DID; SELF.RelativesDID := LEFT.DID; SELF.RelationshipToSubject := 'Subject')) + // Add the subject to the list of relatives so we can figure out below which DID's associated with the address are Subject/Relatives
											subjectRelativesTemp), SubjectDID, RelativesDID, RelationshipToSubject);
		
	VerificationOfOccupancy.Layouts.SupportingRecordsAddr getRelationshipToSubject(VerificationOfOccupancy.Layouts.SupportingRecordsAddr le, RelativesLayout ri) := TRANSFORM
		// Append the VOO Relationship to Subject
		relationship := StringLib.StringToUpperCase(ri.RelationshipToSubject);
		SELF.AssociationToSubject := MAP(relationship = 'SUBJECT'												=> 'Subject',
																		 relationship IN ['WIFE', 'HUSBAND', 'SPOUSE']	=> 'Spouse',
																		 relationship <> ''															=> 'Relative or Associate', // We hit on the relatives key, and it wasn't the Subject or Spouse
																																											 'No Association');
		
		SELF := le;
	END;
	supportingMetadataTemp := JOIN(supportingIdentities, subjectRelatives, isXML AND LEFT.LexID <> 0 AND LEFT.LexID = RIGHT.RelativesDID, 
																getRelationshipToSubject(LEFT, RIGHT), LEFT OUTER, KEEP(1)); // Not a keyed join, no need for ATMOST
	
	// Only keep the records that have a Date Last Seen within 1 year of Todays Date (As-Of Date).  Also drop minors (age 17 or younger)
	supportingMetadata := supportingMetadataTemp (UT.DaysApart(DateLastSeen[1..6] + '01', TodaysDate) <= Risk_Indicators.iid_constants.oneyear and age > 17);
	
	// ****************************************************************
	// *         Get Emails for the DID Prior to History Date         *
	// ****************************************************************
	emailKey := Email_Data.Key_DID;
	
	allowedEmailSources := [mdr.sourceTools.src_Acquiredweb,
										mdr.sourceTools.src_Entiera, 
										mdr.sourceTools.src_Impulse, 
										mdr.sourceTools.src_Wired_Assets_Email,
										mdr.sourceTools.src_MediaOne, 
										mdr.sourceTools.src_Ibehavior,
										mdr.sourceTools.src_SalesChannel,
										mdr.sourceTools.src_Datagence];
	
	iesp.verificationofoccupancy.t_VOOEmail getEmails(ShellResults le, EmailKey ri) := TRANSFORM
		SELF.Address := ri.Clean_Email;
	END;
	
	emailData := JOIN(ShellResults, emailKey, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.DID) AND
													RIGHT.Email_Src IN allowedEmailSources AND 
													(UNSIGNED)(RIGHT.Date_First_Seen[1..6]) <= (UNSIGNED)(TodaysDate[1..6]) AND (UNSIGNED)RIGHT.Date_First_Seen > 0,
											getEmails(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(RiskWise.max_atmost));
	
	// ****************************************************************
	// *             Combine The Results into One Report!             *
	// ****************************************************************
	getResidentialBusinessText(STRING1 ADVOResidentialBusiness) := CASE(ADVOResidentialBusiness,
								'A' => 'Residence',
								'B' => 'Business',
								'C' => 'Primary Residential + Business',
								'D' => 'Primary Business + Residential',
											 '');
	getTypeText(STRING1 ADVOType) := CASE(ADVOType,
								'F' => 'Firm',
								'G' => 'General Delivery',
								'H' => 'High Rise',
								'P' => 'PO Box',
								'R' => 'Rural Route',
								'S' => 'Street',
											 '');
	getMixedUseText(STRING1 ADVOMixedUse) := CASE(ADVOMixedUse,
								'A' => 'Curbline',
								'B' => 'Cluster Box Unit/NDCBU',
								'C' => 'Central',
								'D' => 'Other',
								'E' => 'Facility Box',
								'F' => 'Contract Box',
								'G' => 'Detached Box',
								'H' => 'Non Personnel Unit/NPU',
								'S' => 'Caller Service Box',
								'T' => 'Remittance Box',
								'U' => 'Contest Box',
								'V' => 'Other Box',
								'Q' => 'General Delivery',
											 '');
	getDwellingText(STRING1 DwellingType) := CASE(DwellingType,
								'U' => 'Other',
								'M' => 'Other',
								'F' => 'Commercial',
								'P' => 'Post Office Box',
								'H' => 'Multi-family',
								'S' => 'Single family',
								'G' => 'Single family', 
								'R' => 'Single family',
											 '');
	getPropertyCharacteristicText(BOOLEAN InvalidAddress, BOOLEAN CorrectionalFacility, BOOLEAN ADVOVacant, BOOLEAN ADVOSeasonal) := MAP(
								InvalidAddress				=> 'Invalid',
								CorrectionalFacility	=> 'Correctional Facility',
								ADVOVacant						=> 'Vacant',
								ADVOSeasonal					=> 'Seasonal',
																				 '');
								
	iesp.share.t_RiskIndicator getRiskIndicator(Risk_Indicators.Layout_Desc le) := TRANSFORM
		SELF.RiskCode := le.hri;
		SELF.Description := le.desc;
	END;
	
	VerificationOfOccupancy.Layouts.Layout_VOOBatchOutReport appendReport(VerificationOfOccupancy.Layouts.Layout_VOOBatchOut le) := TRANSFORM
		// Generate the various sections of the Report
		// Comes from the "SmartLinx logic" Phone/SSN sections, the "Gather Best Metadata" section, and the "Use The Target (Input) and VOO Current addresses to gather Metadata" section above
		CurrentSummary := PROJECT((CTAddressesMetadata (AddressStatus IN ['CT', 'CURRENT'])), TRANSFORM(iesp.verificationofoccupancy.t_VOOAddressTarget, 
													streetAddress1 := Address.Addr1FromComponents(LEFT.Prim_Range, LEFT.Predir, LEFT.Prim_Name, LEFT.Addr_Suffix, LEFT.Postdir, LEFT.Unit_Desig, LEFT.Sec_Range);
													SELF.Address := DATASET([{LEFT.Prim_Range, LEFT.Predir, LEFT.Prim_Name, LEFT.Addr_Suffix, 
																										LEFT.Postdir, LEFT.Unit_Desig, LEFT.Sec_Range, 
																										streetAddress1, /*StreetAddress2=*/'', LEFT.City_Name, LEFT.St, LEFT.Z5, 
																										/*Zip4=*/'', LEFT.County, /*PostalCode=*/'', /*StateCityZip=*/''}], iesp.share.t_Address)[1];
													SELF.ResidentialOrBusiness := getResidentialBusinessText(LEFT.ADVOResidentialBusiness);
													SELF._Type := getTypeText(LEFT.ADVOType);
													SELF.MixedUse := getMixedUseText(LEFT.ADVOMixedUse);
													SELF.HighRiskIndicators := CHOOSEN(PROJECT(LEFT.HRIAddress, getRiskIndicator(LEFT)), iesp.Constants.VOO.MaxSummaryHRI);
													
													// These are only populated for the Target Address in the ESP (ECL calculates them for both Target and Current in case of future change)
													SELF.PropertyType := ''; // getDwellingText(LEFT.DwellingType);
													SELF.PropertyCharacteristics := ''; // getPropertyCharacteristicText(LEFT.InvalidAddress, LEFT.CorrectionalFacility, LEFT.ADVOVacant, LEFT.ADVOSeasonal);
													
													SELF := []))[1];
		// Comes from the "Get Emails for the DID" section above
		Emails := DEDUP(SORT(emailData, Address), Address);
		
		Summary := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(iesp.verificationofoccupancy.t_VOOSummary, 
													SELF.UniqueID := (STRING)ShellResults[1].DID;
													fullName := IF(bestSubjectData[1].Title <> '', bestSubjectData[1].Title + ' ', '') +
																			IF(bestSubjectData[1].FName <> '', bestSubjectData[1].FName + ' ', '') +
																			IF(bestSubjectData[1].MName <> '', bestSubjectData[1].MName + ' ', '') +
																			IF(bestSubjectData[1].LName <> '', bestSubjectData[1].LName + ' ', '') +
																			IF(bestSubjectData[1].Suffix <> '', bestSubjectData[1].Suffix + ' ', '');
													SELF.Name := DATASET([{TRIM(fullName), bestSubjectData[1].FName, bestSubjectData[1].MName, bestSubjectData[1].LName, bestSubjectData[1].Suffix, bestSubjectData[1].Title}], iesp.share.t_Name)[1];
													SELF.CurrentAddress := CurrentSummary;
													SELF.SSN := ssnRawMetadata[1]; // SmartLinx Logic
													SELF.Phones := CHOOSEN(phoneRawMetadata, iesp.Constants.VOO.MaxSummaryPhones); // SmartLinx Logic
													SELF.DOB := DATASET([{(INTEGER)(bestSubjectData[1].DOB[1..4]), (INTEGER)(bestSubjectData[1].DOB[5..6]), (INTEGER)(bestSubjectData[1].DOB[7..8])}], iesp.share.t_Date)[1];
													SELF.Age := (STRING)bestSubjectData[1].Age;
													SELF.Emails := CHOOSEN(Emails, iesp.Constants.VOO.MaxSummaryEmails);
													SELF := []))[1];
		
		// Comes from the "Use The Target (Input) and VOO Current addresses to gather Metadata" section above
		// This section is for the Target address only, so pull the records that match on Target (CT/Target)
		TargetSummary := PROJECT((CTAddressesMetadata (AddressStatus IN ['CT', 'TARGET'])), TRANSFORM(iesp.verificationofoccupancy.t_VOOAddressTarget, 
													streetAddress1 := Address.Addr1FromComponents(LEFT.Prim_Range, LEFT.Predir, LEFT.Prim_Name, LEFT.Addr_Suffix, LEFT.Postdir, LEFT.Unit_Desig, LEFT.Sec_Range);
													SELF.Address := DATASET([{LEFT.Prim_Range, LEFT.Predir, LEFT.Prim_Name, LEFT.Addr_Suffix, 
																										LEFT.Postdir, LEFT.Unit_Desig, LEFT.Sec_Range, 
																										streetAddress1, /*StreetAddress2=*/'', LEFT.City_Name, LEFT.St, LEFT.Z5, 
																										/*Zip4=*/'', LEFT.County, /*PostalCode=*/'', /*StateCityZip=*/''}], iesp.share.t_Address)[1];
													SELF.ResidentialOrBusiness := getResidentialBusinessText(LEFT.ADVOResidentialBusiness);
													SELF._Type := getTypeText(LEFT.ADVOType);
													SELF.MixedUse := getMixedUseText(LEFT.ADVOMixedUse);
													SELF.HighRiskIndicators := CHOOSEN(PROJECT(LEFT.HRIAddress, getRiskIndicator(LEFT)), iesp.Constants.VOO.MaxSummaryHRI);
													
													// Unlike the Current Address, these are only populated for the Target Address in the ESP (ECL calculates them for both Target and Current in case of future change)
													SELF.PropertyType := getDwellingText(LEFT.DwellingType);
													SELF.PropertyCharacteristics := getPropertyCharacteristicText(LEFT.InvalidAddress, LEFT.CorrectionalFacility, LEFT.ADVOVacant, LEFT.ADVOSeasonal);
													
													SELF := []))[1];
		
		// Comes from the "Confirming Source Counts/Dates" section above
		sourcesMetadata := SORT((rolledReportHeader (SourceType <> 'Other Source')), -SourceCount, -DateLastSeen, DateFirstSeen, SourceType);
		Sources := PROJECT(CHOOSEN(sourcesMetadata, iesp.Constants.VOO.MaxSupport), TRANSFORM(iesp.verificationofoccupancy.t_VOOConfirmingSource, 
													SELF.Source := LEFT.SourceType;
													SELF.From := DATASET([{(INTEGER)(LEFT.DateFirstSeen[1..4]), (INTEGER)(LEFT.DateFirstSeen[5..6]), (INTEGER)(LEFT.DateFirstSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.To := DATASET([{(INTEGER)(LEFT.DateLastSeen[1..4]), (INTEGER)(LEFT.DateLastSeen[5..6]), (INTEGER)(LEFT.DateLastSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.Count := LEFT.SourceCount;
													SELF := []));
		
		// Comes from the "Other Real-Estate Owned" section above
		OwnedProperties := PROJECT(CHOOSEN(SORT(OwnedAddressesCurr, -other_prox_Date, other_prox_Prim_Range, other_prox_Prim_Name, other_prox_zip), iesp.Constants.VOO.MaxSupport), TRANSFORM(iesp.verificationofoccupancy.t_VOOOtherOwnedProperty, 
													streetAddress1 := Address.Addr1FromComponents(LEFT.other_prox_Prim_Range, LEFT.other_prox_Predir, LEFT.other_prox_Prim_Name, LEFT.other_prox_Suffix, LEFT.other_prox_Postdir, '', LEFT.other_prox_Sec_Range);
													SELF.Address := DATASET([{LEFT.other_prox_Prim_Range, LEFT.other_prox_Predir, LEFT.other_prox_Prim_Name, LEFT.other_prox_Suffix, 
																										LEFT.other_prox_Postdir, '', LEFT.other_prox_Sec_Range, 
																										streetAddress1, /*StreetAddress2=*/'', LEFT.other_prox_City, LEFT.other_prox_St, LEFT.other_prox_zip, 
																										/*Zip4=*/'', /*LEFT.County*/'', /*PostalCode=*/'', /*StateCityZip=*/''}], iesp.share.t_Address)[1];
													SELF.PurchaseDate := DATASET([{(INTEGER)(LEFT.other_prox_Date[1..4]), (INTEGER)(LEFT.other_prox_Date[5..6]), (INTEGER)(LEFT.other_prox_Date[7..8])}], iesp.share.t_Date)[1];
													SELF.Proximity := (STRING)LEFT.other_prox_distance;
													SELF.Status := 'Current';
													SELF := []));

		// Comes from the "Other Real-Estate Owned" section above
		OwnedPropertiesAsOf := PROJECT(CHOOSEN(SORT(OwnedAddressesAsOf, -other_prox_Date, other_prox_Prim_Range, other_prox_Prim_Name, other_prox_zip), iesp.Constants.VOO.MaxSupport), TRANSFORM(iesp.verificationofoccupancy.t_VOOOtherOwnedProperty, 
													streetAddress1 := Address.Addr1FromComponents(LEFT.other_prox_Prim_Range, LEFT.other_prox_Predir, LEFT.other_prox_Prim_Name, LEFT.other_prox_Suffix, LEFT.other_prox_Postdir, '', LEFT.other_prox_Sec_Range);
													SELF.Address := DATASET([{LEFT.other_prox_Prim_Range, LEFT.other_prox_Predir, LEFT.other_prox_Prim_Name, LEFT.other_prox_Suffix, 
																										LEFT.other_prox_Postdir, '', LEFT.other_prox_Sec_Range, 
																										streetAddress1, /*StreetAddress2=*/'', LEFT.other_prox_City, LEFT.other_prox_St, LEFT.other_prox_zip, 
																										/*Zip4=*/'', /*LEFT.County*/'', /*PostalCode=*/'', /*StateCityZip=*/''}], iesp.share.t_Address)[1];
													SELF.PurchaseDate := DATASET([{(INTEGER)(LEFT.other_prox_Date[1..4]), (INTEGER)(LEFT.other_prox_Date[5..6]), (INTEGER)(LEFT.other_prox_Date[7..8])}], iesp.share.t_Date)[1];
													SELF.Proximity := (STRING)LEFT.other_prox_distance;
													SELF.Status := 'Past';
													SELF := []));

		
		// Comes from the "Phone and Utility Records" section above
		TargetRecords := PROJECT(SORT(combinedAddr, -DateFirstSeen, -DateLastSeen, ReportedFName, ReportedMName, ReportedLName, ServiceType), TRANSFORM(iesp.verificationofoccupancy.t_VOOTargetRecord,
													SELF.ServiceType := LEFT.ServiceType;
													fullName := IF(LEFT.ReportedFName <> '', LEFT.ReportedFName + ' ', '') +
																			IF(LEFT.ReportedMName <> '', LEFT.ReportedMName + ' ', '') +
																			IF(LEFT.ReportedLName <> '', LEFT.ReportedLName + ' ', '');
													SELF.Name := DATASET([{TRIM(fullName), LEFT.ReportedFName, LEFT.ReportedMName, LEFT.ReportedLName, /*Suffix=*/'', /*Prefix=*/''}], iesp.share.t_Name)[1];
													SELF.From := DATASET([{(INTEGER)(LEFT.DateFirstSeen[1..4]), (INTEGER)(LEFT.DateFirstSeen[5..6]), (INTEGER)(LEFT.DateFirstSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.To := DATASET([{(INTEGER)(LEFT.DateLastSeen[1..4]), (INTEGER)(LEFT.DateLastSeen[5..6]), (INTEGER)(LEFT.DateLastSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.UniqueID := (string)LEFT.LexID;
													SELF := []));
		
		SubjectRecords := PROJECT(SORT(combinedSubject, -DateFirstSeen, -DateLastSeen, ReportedPrim_Range, ReportedPrim_Name), TRANSFORM(iesp.verificationofoccupancy.t_VOOSubjectRecord, 
													SELF.ServiceType := LEFT.ServiceType;
													SELF.Address := DATASET([{LEFT.ReportedPrim_Range, LEFT.ReportedPredir, LEFT.ReportedPrim_Name, LEFT.ReportedAddr_Suffix, 
																										LEFT.ReportedPostdir, LEFT.ReportedUnit_Desig, LEFT.ReportedSec_Range, 
																										LEFT.ReportedStreetAddress, /*StreetAddress2=*/'', LEFT.ReportedCity, LEFT.ReportedState, LEFT.ReportedZIP5, 
																										LEFT.ReportedZIP4, /*County=*/'', /*PostalCode=*/'', /*StateCityZip=*/''}], iesp.share.t_Address)[1];
													SELF.From := DATASET([{(INTEGER)(LEFT.DateFirstSeen[1..4]), (INTEGER)(LEFT.DateFirstSeen[5..6]), (INTEGER)(LEFT.DateFirstSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.To := DATASET([{(INTEGER)(LEFT.DateLastSeen[1..4]), (INTEGER)(LEFT.DateLastSeen[5..6]), (INTEGER)(LEFT.DateLastSeen[7..8])}], iesp.share.t_Date)[1];
													SELF := []));
		
		PhoneAndUtility := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(iesp.verificationofoccupancy.t_VOOPhoneAndUtility, 
													SELF.TargetRecords := CHOOSEN(TargetRecords, iesp.Constants.VOO.MaxSupport);
													SELF.SubjectRecords := CHOOSEN(SubjectRecords, iesp.Constants.VOO.MaxSupport);
													SELF := []))[1];
		
		// Comes from the "Identities Associated with Input (Target) Property" section above
		AssociatedIdentities := PROJECT(SORT(supportingMetadata, -DateFirstSeen, -DateLastSeen, LexID), TRANSFORM(iesp.verificationofoccupancy.t_VOOIdentity, 
													SELF.UniqueID := (STRING)LEFT.LexID;
													fullName := IF(LEFT.FName <> '', LEFT.FName + ' ', '') +
																			IF(LEFT.LName <> '', LEFT.LName + ' ', '');
													SELF.Name := DATASET([{TRIM(fullName), LEFT.FName, /*Middle=*/'', LEFT.LName, /*Suffix=*/'', /*Prefix=*/''}], iesp.share.t_Name)[1];
													SELF.From := DATASET([{(INTEGER)(LEFT.DateFirstSeen[1..4]), (INTEGER)(LEFT.DateFirstSeen[5..6]), (INTEGER)(LEFT.DateFirstSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.To := DATASET([{(INTEGER)(LEFT.DateLastSeen[1..4]), (INTEGER)(LEFT.DateLastSeen[5..6]), (INTEGER)(LEFT.DateLastSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.Association := LEFT.AssociationToSubject;
													SELF := []));
		
		// Combine it all together
		Report := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(iesp.verificationofoccupancy.t_VOOReport, 
													SELF.Summary := Summary;
													SELF.TargetSummary := TargetSummary;
													SELF.Sources := CHOOSEN(Sources, iesp.Constants.VOO.MaxSupport);
													SELF.OwnedProperties := CHOOSEN(OwnedProperties, iesp.Constants.VOO.MaxSupport);
													SELF.OwnedPropertiesAsOf := CHOOSEN(OwnedPropertiesAsOf, iesp.Constants.VOO.MaxSupport);
													SELF.PhoneAndUtility := PhoneAndUtility;
													SELF.AssociatedIdentities := CHOOSEN(AssociatedIdentities, iesp.Constants.VOO.MaxSupport);
													SELF := []))[1];
		
		// Append the Report
		SELF.Report := Report;
		
		// Keep the already calculated fields
		SELF.AcctNo := le.AcctNo;
		SELF.Seq := le.Seq;
		SELF.LexID := le.LexID;
		SELF := le;
		SELF := [];
	END;
	withReport := PROJECT(AttributesResults, appendReport(LEFT));
	
	// ****************************************************************
	// *      DEBUGGING SECTION -- COMMENT OUT FOR PRODUCTION         *
	// ****************************************************************
	// OUTPUT(ShellResults, NAMED('ShellResults'));
	// OUTPUT(AttributesResults, NAMED('AttributesResults'));
	// OUTPUT(best_rec_input, NAMED('best_rec_input'));
	// OUTPUT(with_DODs, NAMED('with_DODs'));
	// OUTPUT(best_rec_DOD, NAMED('best_rec_DOD'));
	// OUTPUT(best_rec, NAMED('best_rec'));
	// OUTPUT(phoneRawMetadata, NAMED('phoneRawMetadata'));
	// OUTPUT(ssnRawMetadata, NAMED('ssnRawMetadata'));
	// OUTPUT(bestSubjectData, NAMED('bestSubjectData'));
	// OUTPUT(CTAddressesAll, NAMED('CTAddressesAll'));
	// OUTPUT(CTAddresses, NAMED('CTAddresses'));
	// OUTPUT(CTAddressesClean, NAMED('CTAddressesClean'));
	// OUTPUT(CTAddressesFinal, NAMED('CTAddressesFinal'));
	// OUTPUT(CTAddressesADVOTemp, NAMED('CTAddressesADVOTemp'));
	// OUTPUT(CTAddressesADVO, NAMED('CTAddressesADVO'));
	// OUTPUT(CTAddressesMetadataTemp, NAMED('CTAddressesMetadataTemp'));
	// OUTPUT(CTAddressesMetadata, NAMED('CTAddressesMetadata'));
	// OUTPUT(reportHeader, NAMED('reportHeader'));
	// OUTPUT(reportQHeader, NAMED('reportQHeader'));
	// OUTPUT(combinedReportHeader, NAMED('combinedReportHeader'));
	// OUTPUT(rolledReportHeader, NAMED('rolledReportHeader'));
	// OUTPUT(OwnedAddressesVOO, NAMED('OwnedAddressesVOO'));
	// OUTPUT(ownedCurrentAddresses, NAMED('ownedCurrentAddresses'));
	// OUTPUT(property_by_did, NAMED('property_by_did'));
	// OUTPUT(property_searched, NAMED('property_searched'));
	// OUTPUT(dedupProp, NAMED('dedupProp'));
	// OUTPUT(otherFares, NAMED('otherFares'));
	// OUTPUT(property_searched2, NAMED('property_searched2'));
	// OUTPUT(sortAddress, NAMED('sortAddress'));
	// OUTPUT(rolled_OtherAddr, NAMED('rolled_OtherAddr'));
	// OUTPUT(with_Owned, NAMED('with_Owned'));
	// OUTPUT(sortByFares, NAMED('sortByFares'));
	// OUTPUT(rolled_ByFares, NAMED('rolled_ByFares'));
	// OUTPUT(sortOtherAddr, NAMED('sortOtherAddr'));
	// OUTPUT(sort_Owned, NAMED('sort_Owned'));
	// OUTPUT(ownedAddresses, NAMED('ownedAddresses'));
	// OUTPUT(ownedAddressesAsOf, NAMED('ownedAddressesAsOf'));
	// OUTPUT(OwnedAddresses, NAMED('OwnedAddresses'));
	// OUTPUT(gongAddr, NAMED('gongAddr'));
	// OUTPUT(utilityAddr, NAMED('utilityAddr'));
	// OUTPUT(targusAddr, NAMED('targusAddr'));
	// OUTPUT(phoneAddr, NAMED('phoneAddr'));
	// OUTPUT(utilAddr, NAMED('utilAddr'));
	// OUTPUT(combinedAddr, NAMED('combinedAddr'));
	// OUTPUT(gongDID, NAMED('gongDID'));
	// OUTPUT(utilityDID, NAMED('utilityDID'));
	// OUTPUT(targusDID, NAMED('targusDID'));
	// OUTPUT(phoneSubject, NAMED('phoneSubject'));
	// OUTPUT(utilSubject, NAMED('utilSubject'));
	// OUTPUT(combinedSubject, NAMED('combinedSubject'));
	// OUTPUT(supportingAddrTemp, NAMED('supportingAddrTemp'));
	// OUTPUT(supportingAddr, NAMED('supportingAddr'));
	// OUTPUT(supportingIdentitiesSorted, NAMED('supportingIdentitiesSorted'));
	// OUTPUT(supportingIdentities, NAMED('supportingIdentities'));
	// OUTPUT(subjectRelatives, NAMED('subjectRelatives'));
	// OUTPUT(supportingMetadataTemp, NAMED('supportingMetadataTemp'));
	// OUTPUT(supportingMetadata, NAMED('supportingMetadata'));
	// ****************************************************************
	// *     END DEBUGGING SECTION -- COMMENT OUT FOR PRODUCTION      *
	// ****************************************************************

	RETURN(withReport);
END;