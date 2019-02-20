// THIS REPORT IS XML ONLY - NOT BATCH  
// Several assumptions are made to simplify the code that requires this function to only be called for XML transactions.

IMPORT AddrBest, Address, AutoStandardI, Codes, DeathV2_Services, DidVille, 
       Drivers, Doxie, Email_Data, Gong, Header, Header_Quick, IESP, MDR, 
			 PersonReports, Risk_Indicators, RiskWise, SmartRollup, Targus, UT, Utilfile, 
			 VerificationOfOccupancy, Relationship, std;

EXPORT getReportPAR (DATASET(VerificationOfOccupancy.Layouts.Layout_VOOShell) ShellResults,
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
	// *   Gather Phone Metadata - Use Progressive Phones Logic and   *
	// *   transform into PersonReports.SmartLinxReport               *
	// ****************************************************************
	phoneRawMetadata := IF(isXML, CHOOSEN(VerificationOfOccupancy.functions.getPhonesPlusMetadata(best_rec), iesp.Constants.BR.MaxPhonesPlus),
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

		bestSubjectData := join(ShellResults, outfile,
													LEFT.DID <> 0 AND LEFT.DID = RIGHT.DID, 
															transform_name(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));

	// ****************************************************************
	// *   Gather Current Address Metadata - determine Best/Current   *
	// *   Address via AddrBest.Records().best_records.               *
	// ****************************************************************	

	row_ShellRes := ShellResults[1];
	
	DidVille.Layout_BestInfo_BatchIn xfm_build_bestaddr_record := 
		TRANSFORM
			SELF.acctno         := (STRING)row_ShellRes.seq;
			SELF.ssn            := row_ShellRes.ssn;
			SELF.name_first     := row_ShellRes.fname;
			SELF.name_middle    := row_ShellRes.mname;
			SELF.name_last      := row_ShellRes.lname;
			SELF.name_suffix    := row_ShellRes.suffix;
			SELF.dob            := row_ShellRes.dob;
			SELF.phoneno        := row_ShellRes.phone10;   
			SELF.prim_range     := row_ShellRes.prim_range;
			SELF.predir         := row_ShellRes.predir;
			SELF.prim_name      := row_ShellRes.prim_name;
			SELF.suffix         := row_ShellRes.addr_suffix;
			SELF.postdir        := row_ShellRes.postdir;
			SELF.unit_desig     := row_ShellRes.unit_desig;
			SELF.sec_range      := row_ShellRes.sec_range;
			SELF.p_city_name    := row_ShellRes.p_city_name;
			SELF.st             := row_ShellRes.st;
			SELF.z5             := row_ShellRes.z5;
			SELF.version_number := '';	
		END;

	bestaddr_in_slim := DATASET( [xfm_build_bestaddr_record] );
	bestaddr_in := PROJECT( bestaddr_in_slim, TRANSFORM( AddrBest.Layout_BestAddr.Batch_in, SELF.did := row_ShellRes.did, SELF := LEFT, SELF := [] ) );

	input_mod_bestaddr := AddrBest.Iparams.DefaultParams; 
	bestaddr_rec := AddrBest.Records(bestaddr_in,input_mod_bestaddr).best_records;
	
	// Project results into VerificationOfOccupancy.Layouts.Subject_Addresses to get
	// address metadata.
	bestaddr_as_Subject_Addresses := 
		PROJECT(
			bestaddr_rec,
			TRANSFORM( VerificationOfOccupancy.Layouts.Subject_Addresses,
				SELF.prim_range              := LEFT.prim_range,
				SELF.predir                  := LEFT.predir,
				SELF.prim_name               := LEFT.prim_name,
				SELF.addr_suffix             := LEFT.suffix,
				SELF.postdir                 := LEFT.postdir,
				SELF.unit_desig              := LEFT.unit_desig,
				SELF.sec_range               := LEFT.sec_range,
				SELF.city_name               := LEFT.p_city_name,
				SELF.county                  := LEFT.fips_county,
				SELF.st                      := LEFT.st,
				SELF.z5                      := LEFT.z5,
				SELF.lat                     := '',
				SELF.long                    := '',
				SELF.DistanceFromTarget      := -1,
				SELF.Date                    := '',
				SELF.AddressStatus           := 'CURRENT', // Contains TARGET, CURRENT, OTHER
				SELF.DwellingType            := '',
				SELF.AddrCleanerStatus       := '',
				SELF.HRIAddress              := [], // HRI Address (SIC Codes/Descriptions)
				SELF.ADVOResidentialBusiness := '',
				SELF.ADVOType                := '',
				SELF.ADVOMixedUse            := '',
				SELF.ADVOVacant              := FALSE,
				SELF.ADVOSeasonal            := FALSE,
				SELF.InvalidAddress          := FALSE,
				SELF.CorrectionalFacility    := FALSE,
				SELF := []
			)
		);
	
	CTBestAddressMetadata := VerificationOfOccupancy.functions.getAddressMetadata(bestaddr_as_Subject_Addresses, '', '', isXML);
	
	// ****************************************************************
	// *   Gather Address Metadata - Use The Target (Input) and VOO   *
	// *   Current addresses to gather Metadata.                      *
	// ****************************************************************	
	SubjAddresses       := ShellResults[1].SubjectAddresses;
	CTAddressesMetadata := VerificationOfOccupancy.functions.getAddressMetadata(SubjAddresses, row_ShellRes.Lat, row_ShellRes.Long, isXML);

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
	//                                                                *
	// *     Gather Supporting Records - Other Associated Addresses   *
	//                                                                *
	// ****************************************************************
// Go determine the properties the input subject owns - if running with 'AsOf' date, need properties owned at that date as well
	todaysDate2			:= (integer)((STRING)Std.Date.Today())[1..6];
	historyDate			:= (integer)shellResults[1].historyDate; 
	archiveMode			:= ((string)historydate)[1..4] < ((string)todaysdate2)[1..4];  //if running "AsOf" a prior year, set indicator
	
// Go get associated addresses for the input subject.
	otherAssocAddrs	:= VerificationOfOccupancy.getAssociatedAddresses(ShellResults, isFCRA);

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
												KEYED(LEFT.DID = RIGHT.l_DID) AND
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
		SELF.age := if(ri.dob = 0, 0, risk_indicators.years_apart((unsigned)le.HistoryDate, (unsigned)ri.dob));
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
			RelativeFlag :=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result; 
	
	RelativesLayout getSubjectRelatives(ShellResults le, rellyids ri) := TRANSFORM
		SELF.SubjectDID := le.DID;
		SELF.RelativesDID := ri.did2;
		SELF.RelationshipToSubject := Header.Relative_Titles.FN_Get_Str_Title(ri.Title); // Get the string title
	END;
	subjectRelativesTemp := JOIN(ShellResults, rellyids, isXML AND LEFT.DID <> 0 AND LEFT.DID = RIGHT.did1, 
															getSubjectRelatives(LEFT, RIGHT));
	subjectRelatives := SORT(UNGROUP(PROJECT((ShellResults (DID <> 0)), TRANSFORM(RelativesLayout, SELF.SubjectDID := LEFT.DID; SELF.RelativesDID := LEFT.DID; SELF.RelationshipToSubject := 'Subject')) + // Add the subject to the list of relatives so we can figure out below which DID's associated with the address are Subject/Relatives
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
	
	VerificationOfOccupancy.Layouts.Layout_PARBatchOutReport appendReport(VerificationOfOccupancy.Layouts.Layout_VOOBatchOut le) := TRANSFORM
		// Generate the various sections of the Report
		// Comes from the "SmartLinx logic" Phone/SSN sections, the "Gather Best Metadata" section, and the "Use The Target (Input) and VOO Current addresses to gather Metadata" section above
		CurrentSummary := PROJECT((CTBestAddressMetadata (AddressStatus IN ['CT', 'CURRENT'])), TRANSFORM(iesp.premiseassociation.t_PARAddressTarget, 
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
		
		Summary := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(iesp.premiseassociation.t_PARSummary, 
													SELF.UniqueID := (STRING)ShellResults[1].DID;
													fullName := IF(bestSubjectData[1].Title <> '', bestSubjectData[1].Title + ' ', '') +
																			IF(bestSubjectData[1].FName <> '', bestSubjectData[1].FName + ' ', '') +
																			IF(bestSubjectData[1].MName <> '', bestSubjectData[1].MName + ' ', '') +
																			IF(bestSubjectData[1].LName <> '', bestSubjectData[1].LName + ' ', '') +
																			IF(bestSubjectData[1].Suffix <> '', bestSubjectData[1].Suffix + ' ', '');
													SELF.Name := DATASET([{TRIM(fullName), bestSubjectData[1].FName, bestSubjectData[1].MName, bestSubjectData[1].LName, bestSubjectData[1].Suffix, bestSubjectData[1].Title}], iesp.share.t_Name)[1];
													SELF.CurrentAddress := CurrentSummary;
													SELF.SSN := ssnRawMetadata[1]; // SmartLinx Logic
													SELF.Phones := CHOOSEN(phoneRawMetadata, iesp.Constants.VOO.MaxSummaryPhones);
													SELF.DOB := DATASET([{(INTEGER)(bestSubjectData[1].DOB[1..4]), (INTEGER)(bestSubjectData[1].DOB[5..6]), (INTEGER)(bestSubjectData[1].DOB[7..8])}], iesp.share.t_Date)[1];
													SELF.Age := (STRING)bestSubjectData[1].Age;
													SELF.Emails := CHOOSEN(Emails, iesp.Constants.VOO.MaxSummaryEmails);
													SELF := []))[1];
		
		// Comes from the "Use The Target (Input) and VOO Current addresses to gather Metadata" section above
		// This section is for the Target address only, so pull the records that match on Target (CT/Target)
		TargetSummary := PROJECT((CTAddressesMetadata (AddressStatus IN ['CT', 'TARGET'])), TRANSFORM(iesp.premiseassociation.t_PARAddressTarget, 
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
		Sources := PROJECT(CHOOSEN(sourcesMetadata, iesp.Constants.VOO.MaxSupport), TRANSFORM(iesp.premiseassociation.t_PARConfirmingSource, 
													SELF.Source := LEFT.SourceType;
													SELF.From := DATASET([{(INTEGER)(LEFT.DateFirstSeen[1..4]), (INTEGER)(LEFT.DateFirstSeen[5..6]), (INTEGER)(LEFT.DateFirstSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.To := DATASET([{(INTEGER)(LEFT.DateLastSeen[1..4]), (INTEGER)(LEFT.DateLastSeen[5..6]), (INTEGER)(LEFT.DateLastSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.Count := LEFT.SourceCount;
													SELF := []));

		// Filter off the Current Address (from Summary) from Other Associated Addresses.
		otherAssocAddrs_filt := 
			otherAssocAddrs(
				NOT( 
					address_prim_range = CurrentSummary.Address.StreetNumber AND 
					address_prim_name  = CurrentSummary.Address.StreetName AND
					address_zip        = CurrentSummary.Address.Zip5
				)
			);
		
		// For archiveMode, also filter off address records by history date.
		otherAssocAddrsAsOf_filt := otherAssocAddrs_filt(historyDate > address_date_first_seen);
		
		OtherAssociatedAddresses :=
			PROJECT(
				SORT( otherAssocAddrs_filt, seq, did, -address_date_first_seen, -address_date_last_seen ),
				TRANSFORM( iesp.premiseassociation.t_PAROtherAssociatedAddress, 
					SELF.Address   := VerificationOfOccupancy.functions.createAddressRow(LEFT);
					SELF.DateRange := VerificationOfOccupancy.functions.createDateRangeRow(LEFT);
					SELF.Status    := IF( LEFT.address_date_last_seen >= todaysdate2, 'CURRENT', 'PRIOR' ); // probably naive
				)
			);
		
		OtherAssociatedAddressesAsOf :=
			PROJECT(
				SORT( otherAssocAddrsAsOf_filt, seq, did, -address_date_first_seen, -address_date_last_seen ),
				TRANSFORM( iesp.premiseassociation.t_PAROtherAssociatedAddress, 
					SELF.Address   := VerificationOfOccupancy.functions.createAddressRow(LEFT);
					SELF.DateRange := VerificationOfOccupancy.functions.createDateRangeRow(LEFT);
					SELF.Status    := IF( LEFT.address_date_last_seen >= historyDate, 'CURRENT', 'PRIOR' ); // probably naive
				)
			);		
		
		// Comes from the "Phone and Utility Records" section above
		TargetRecords := PROJECT(SORT(combinedAddr, -DateFirstSeen, -DateLastSeen, ReportedFName, ReportedMName, ReportedLName, ServiceType), TRANSFORM(iesp.premiseassociation.t_PARTargetRecord,
													SELF.ServiceType := LEFT.ServiceType;
													fullName := IF(LEFT.ReportedFName <> '', LEFT.ReportedFName + ' ', '') +
																			IF(LEFT.ReportedMName <> '', LEFT.ReportedMName + ' ', '') +
																			IF(LEFT.ReportedLName <> '', LEFT.ReportedLName + ' ', '');
													SELF.Name := DATASET([{TRIM(fullName), LEFT.ReportedFName, LEFT.ReportedMName, LEFT.ReportedLName, /*Suffix=*/'', /*Prefix=*/''}], iesp.share.t_Name)[1];
													SELF.From := DATASET([{(INTEGER)(LEFT.DateFirstSeen[1..4]), (INTEGER)(LEFT.DateFirstSeen[5..6]), (INTEGER)(LEFT.DateFirstSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.To := DATASET([{(INTEGER)(LEFT.DateLastSeen[1..4]), (INTEGER)(LEFT.DateLastSeen[5..6]), (INTEGER)(LEFT.DateLastSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.UniqueID := (string)LEFT.LexID;
													SELF := []));
		
		SubjectRecords := PROJECT(SORT(combinedSubject, -DateFirstSeen, -DateLastSeen, ReportedPrim_Range, ReportedPrim_Name), TRANSFORM(iesp.premiseassociation.t_PARSubjectRecord, 
													SELF.ServiceType := LEFT.ServiceType;
													SELF.Address := DATASET([{LEFT.ReportedPrim_Range, LEFT.ReportedPredir, LEFT.ReportedPrim_Name, LEFT.ReportedAddr_Suffix, 
																										LEFT.ReportedPostdir, LEFT.ReportedUnit_Desig, LEFT.ReportedSec_Range, 
																										LEFT.ReportedStreetAddress, /*StreetAddress2=*/'', LEFT.ReportedCity, LEFT.ReportedState, LEFT.ReportedZIP5, 
																										LEFT.ReportedZIP4, /*County=*/'', /*PostalCode=*/'', /*StateCityZip=*/''}], iesp.share.t_Address)[1];
													SELF.From := DATASET([{(INTEGER)(LEFT.DateFirstSeen[1..4]), (INTEGER)(LEFT.DateFirstSeen[5..6]), (INTEGER)(LEFT.DateFirstSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.To := DATASET([{(INTEGER)(LEFT.DateLastSeen[1..4]), (INTEGER)(LEFT.DateLastSeen[5..6]), (INTEGER)(LEFT.DateLastSeen[7..8])}], iesp.share.t_Date)[1];
													SELF := []));
		
		PhoneAndUtility := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(iesp.premiseassociation.t_PARPhoneAndUtility, 
													SELF.TargetRecords := CHOOSEN(TargetRecords, iesp.Constants.VOO.MaxSupport);
													SELF.SubjectRecords := CHOOSEN(SubjectRecords, iesp.Constants.VOO.MaxSupport);
													SELF := []))[1];
		
		// Comes from the "Identities Associated with Input (Target) Property" section above
		AssociatedIdentities := PROJECT(SORT(supportingMetadata, -DateFirstSeen, -DateLastSeen, LexID), TRANSFORM(iesp.premiseassociation.t_PARIdentity, 
													SELF.UniqueID := (STRING)LEFT.LexID;
													fullName := IF(LEFT.FName <> '', LEFT.FName + ' ', '') +
																			IF(LEFT.LName <> '', LEFT.LName + ' ', '');
													SELF.Name := DATASET([{TRIM(fullName), LEFT.FName, /*Middle=*/'', LEFT.LName, /*Suffix=*/'', /*Prefix=*/''}], iesp.share.t_Name)[1];
													SELF.From := DATASET([{(INTEGER)(LEFT.DateFirstSeen[1..4]), (INTEGER)(LEFT.DateFirstSeen[5..6]), (INTEGER)(LEFT.DateFirstSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.To := DATASET([{(INTEGER)(LEFT.DateLastSeen[1..4]), (INTEGER)(LEFT.DateLastSeen[5..6]), (INTEGER)(LEFT.DateLastSeen[7..8])}], iesp.share.t_Date)[1];
													SELF.Association := LEFT.AssociationToSubject;
													SELF := []));
		
		// Combine it all together
		Report := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(iesp.premiseassociation.t_PremiseAssociationReport, 
													SELF.Summary                 := Summary;
													SELF.TargetSummary           := TargetSummary;
													SELF.Sources                 := CHOOSEN(Sources, iesp.Constants.VOO.MaxSupport);
													SELF.AssociatedAddresses     := CHOOSEN(OtherAssociatedAddresses, iesp.Constants.VOO.MaxSupport); // DATASET([],iesp.premiseassociation.t_PAROtherAssociatedAddress);
													SELF.AssociatedAddressesAsOf := IF( archiveMode, CHOOSEN(OtherAssociatedAddressesAsOf, iesp.Constants.VOO.MaxSupport), DATASET([],iesp.premiseassociation.t_PAROtherAssociatedAddress) ); // DATASET([],iesp.premiseassociation.t_PAROtherAssociatedAddress);
													SELF.PhoneAndUtility         := PhoneAndUtility;
													SELF.AssociatedIdentities    := CHOOSEN(AssociatedIdentities, iesp.Constants.VOO.MaxSupport);
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
	// OUTPUT(bestaddr_rec, NAMED('bestaddr_rec'));
	// OUTPUT( bestaddr_as_Subject_Addresses, NAMED('as_Subj_Addrs') );
	// OUTPUT( CTBestAddressMetadata, NAMED('CTBestAddressMetadata') );
	// OUTPUT(reportHeader, NAMED('reportHeader'));
	// OUTPUT(reportQHeader, NAMED('reportQHeader'));
	// OUTPUT(combinedReportHeader, NAMED('combinedReportHeader'));
	// OUTPUT(rolledReportHeader, NAMED('rolledReportHeader'));
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
	// OUTPUT( otherAssocAddrs, NAMED('otherAssocAddrs') );
	// ****************************************************************
	// *     END DEBUGGING SECTION -- COMMENT OUT FOR PRODUCTION      *
	// ****************************************************************	

	RETURN withReport;
END;