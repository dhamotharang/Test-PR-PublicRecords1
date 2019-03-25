import _Control, risk_indicators, doxie, header, mdr, did_add, ut, drivers, FCRA, header_quick, riskwise, NID, address;
onThor := _Control.Environment.OnThor;

export iid_getHeader(grouped DATASET(risk_indicators.Layout_output) inrec, unsigned1 dppa, unsigned1 glb, 
							boolean isFCRA=false, boolean ln_branded, 
							string10 ExactMatchLevel=iid_constants.default_ExactMatchLevel,
							string50 DataRestriction=iid_constants.default_DataRestriction,
							string10 CustomDataFilter='', unsigned1 BSversion,
							dataset(layouts.Layout_DOB_Match_Options) DOBMatchOptions=dataset([], layouts.layout_dob_match_options),
							unsigned2 EverOccupant_PastMonths=0,
							unsigned4 EverOccupant_StartDate = iid_constants.default_history_date,
							unsigned3 LastSeenThreshold = iid_constants.oneyear,
							unsigned8 BSOptions=0
	) := function
	

ExactFirstNameRequired := ExactMatchLevel[iid_constants.posExactFirstNameMatch]=iid_constants.sTrue;
ExactLastNameRequired := ExactMatchLevel[iid_constants.posExactLastNameMatch]=iid_constants.sTrue;
ExactSSNRequired := ExactMatchLevel[iid_constants.posExactSSNMatch]=iid_constants.sTrue;
ExactAddrRequired := ExactMatchLevel[iid_constants.posExactAddrMatch]=iid_constants.sTrue;
ExactPhoneRequired := ExactMatchLevel[iid_constants.posExactPhoneMatch]=iid_constants.sTrue;
ExactDOBRequired := ExactMatchLevel[iid_constants.posExactDOBMatch]=iid_constants.sTrue;
ExactFirstNameRequiredAllowNickname := ExactMatchLevel[iid_constants.posExactFirstNameMatchNicknameAllowed]=iid_constants.sTrue;
ExactAddrZip5andPrimRange := ExactMatchLevel[iid_constants.posExactAddrZip5andPrimRange]=iid_constants.sTrue;


// "FuzzyCCYYMMDD","FuzzyCCYYMM","RadiusCCYY","ExactCCYYMMDD","ExactCCYYMM"
DOBMatchOption := stringlib.stringtouppercase(DOBMatchOptions[1].DOBMatch);
DOBMatchYearRadius := if(DOBMatchOptions[1].DOBMatchYearRadius>3, 3, DOBMatchOptions[1].DOBMatchYearRadius);	// cap at 3 years

glb_ok := Risk_Indicators.iid_constants.glb_ok(glb, isFCRA);
dppa_ok := Risk_Indicators.iid_constants.dppa_ok(dppa, isFCRA);

EnableEmergingID := (BSOptions & risk_indicators.iid_constants.BSOptions.EnableEmergingID) > 0;
FilterLiens := (BSOptions & risk_indicators.iid_constants.BSOptions.FilterLiens) > 0;
RemoveQuickHeader := (BSOptions & risk_indicators.iid_constants.BSOptions.RemoveQuickHeader) > 0;

// only use this variable in realtime mode to simulate the header build date rather than todays date
dk := choosen(if(isFCRA, doxie.Key_FCRA_max_dt_last_seen, doxie.key_max_dt_last_seen), 1);
max_last_seen := (string) dk[1].max_date_last_seen;
hdrBuildDate01 := max_last_seen[1..6]+'01';
header_build_date := (unsigned)(max_last_seen[1..6]);


Layout_Header_Data := RECORD
	Risk_Indicators.iid_constants.layout_outx;
	string1 valid_dob := '';	// on the header key but not in layout_outx, so we need to keep it
	Risk_Indicators.Layouts.Layout_Addr_Flags Addr_Flags;
	boolean came_from_fastheader;
END;

Layout_working := RECORD
	Layout_Header_Data;
	string20 oldFname;
	string20 newFname;
	string20 oldMname;
	string20 newMname;
	string20 oldLname;
	string20 newLname;
	string5 oldNameSuffix;
	string5 newNameSuffix;
	string10 oldPrimRange;
	string10 newPrimRange;
	string2 oldPredir;
	string2 newPredir;
	string28 oldPrimName;
	string28 newPrimName;
	string4 oldSuffix;
	string4 newSuffix;
	string2 oldPostdir;
	string2 newPostdir;
	string10 oldUnitDesig;
	string10 newUnitDesig;
	string8 oldSecRange;
	string8 newSecRange;
	string25 oldCityName;
	string25 newCityName;
	string2 oldSt;
	string2 newSt;
	string5 oldZip;
	string5 newZip;
	string4 oldZip4;
	string4 newZip4;
	string9 oldSSN;
	string9 newSSN;
	string8 oldDOB;
	string8 newDOB;
	string1 oldDwellType;	
	string1 newDwellType;
	string1 oldValid;
	string1 newValid;
	string1 oldPrisonAddr;
	string1 newPrisonAddr;
	string1 oldHighRisk;
	string1 newHighRisk;
	string1 oldCorpMil;
	string1 newCorpMil;
	string1 oldDoNotDeliver;
	string1 newDoNotDeliver;
	string1 oldDeliveryStatus;
	string1 newDeliveryStatus;
	string1 oldAddressType;
	string1 newAddressType;
	string1 oldDropIndicator;
	string1 newDropIndicator;
	boolean isCorrected;
END;

g_inrec := group(sort(inrec, seq, did), seq, did);

// get correction records
layout_headerOverridePlusSeq := RECORD
	UNSIGNED4 seq;
	fcra.Layout_Override_Header;
END;

layout_headerOverridePlusSeq get_header_corr(g_inrec le, fcra.Key_Override_Header_DID ri) := TRANSFORM
	self.seq := le.seq;
	self := ri;
END; 

header_corr_roxie := if(isFCRA, JOIN(g_inrec, fcra.Key_Override_Header_DID,	// quick header is included
																left.did<>0 and keyed (Left.did = Right.did) and
																// if the customdata filter=PM or EB, make sure the source is on their allowed sources list
																(right.head.src in iid_constants.setPhillipMorrisAllowedHeaderSources or customDataFilter<>iid_constants.PhillipMorrisFilter) and
																(right.head.src in iid_constants.setExperianBatchAllowedHeaderSources or customDataFilter<>iid_constants.ExperianFCRA_Batch) and
																((right.head.src='BA' and FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate),(string)right.head.dt_first_seen)) OR
																	(right.head.src='L2' and FCRA.lien_is_ok(iid_constants.myGetDate(left.historydate),(string)right.head.dt_first_seen)) OR right.head.src not in ['BA','L2']) and
																	trim((string)right.did) + trim((string)right.head.rid) not in left.header_correct_record_id	// old way - exclude corrected records from prior to 11/13/2012
																	and trim( (string)right.head.persistent_record_id ) not in left.header_correct_record_id,  // new way - using persistent_record_id		
																get_header_corr(LEFT, RIGHT),																
																atmost(ut.limits.HEADER_PER_DID)),
													group(dataset([], layout_headerOverridePlusSeq),seq));

header_corr_thor := if(isFCRA,group( JOIN(distribute(g_inrec(did<>0), hash64(did)),
															 distribute(pull(fcra.Key_Override_Header_DID), hash64(did)),	// quick header is included
																(Left.did = Right.did) and
																// if the customdata filter=PM or EB, make sure the source is on their allowed sources list
																(right.head.src in iid_constants.setPhillipMorrisAllowedHeaderSources or customDataFilter<>iid_constants.PhillipMorrisFilter) and
																(right.head.src in iid_constants.setExperianBatchAllowedHeaderSources or customDataFilter<>iid_constants.ExperianFCRA_Batch) and
																((right.head.src='BA' and FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate),(string)right.head.dt_first_seen)) OR
																	(right.head.src='L2' and FCRA.lien_is_ok(iid_constants.myGetDate(left.historydate),(string)right.head.dt_first_seen)) OR right.head.src not in ['BA','L2']) and
																	trim((string)right.did) + trim((string)right.head.rid) not in left.header_correct_record_id	// old way - exclude corrected records from prior to 11/13/2012
																	and trim( (string)right.head.persistent_record_id ) not in left.header_correct_record_id,  // new way - using persistent_record_id		
																transform(layout_headerOverridePlusSeq, self.seq:=left.seq, self := right),
																atmost(left.did=right.did,ut.limits.HEADER_PER_DID),LOCAL),seq),
													group(dataset([], layout_headerOverridePlusSeq),seq));													

#IF(onThor)
	header_corr := header_corr_thor;
#ELSE
	header_corr := header_corr_roxie;
#END
																		
// get full header	
header_key := if(isFCRA, doxie.key_fcra_header, doxie.key_header);

Layout_Header_Data get_j_pre(g_inrec le, header_key ri) := TRANSFORM
	self.seq := le.seq; 
	self.h := ri; 
	self.valid_dob := ri.valid_dob, 
	self.hhid_summary.hhid := if(isFCRA, 0, ri.hhid);
	self := le;
	self := []
END;

j_pre_roxie := join (g_inrec, header_key, 
													 LEFT.did<>0 AND keyed(LEFT.did = RIGHT.s_did) AND
														// if the customdata filter=PM or EB, make sure the source is on their allowed sources list
														(right.src in iid_constants.setPhillipMorrisAllowedHeaderSources or customDataFilter<>iid_constants.PhillipMorrisFilter) and
														(right.src in iid_constants.setExperianBatchAllowedHeaderSources or customDataFilter<>iid_constants.ExperianFCRA_Batch) and
													 right.src not in iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
													 ( (RIGHT.dt_first_seen < left.historydate and right.dt_first_seen <> 0) 
															or
															(right.dt_first_seen=0 and right.dt_vendor_first_reported < left.historydate) ) and // check date, only check vendor date if first seen date = 0
													 (
													 (bsversion>=50 or ~mdr.Source_is_Utility(RIGHT.src)) AND // rm Utility from NAS.  for shell 5.0, allow utility records into join for everything but NAS fields
													 (header.IsPreGLB_LIB(right.dt_nonglb_last_seen, 
																								right.dt_first_seen, 
																								right.src, 
																								DataRestriction) OR glb_ok) AND
													 (~mdr.Source_is_DPPA(RIGHT.src) OR
											(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))
											 or isFCRA) AND  // FCRA sees all sources
														~Risk_Indicators.iid_constants.filtered_source(right.src, right.st, bsversion) and
													 // we won't use experian dl's/vehicles (requires LN branding) -- in shell 5.0 and higher we can use them now
													 (ln_branded OR bsversion>=50 or ~(dppa_ok AND (RIGHT.src in mdr.sourcetools.set_Experian_dl or RIGHT.src in mdr.sourcetools.set_Experian_vehicles))) and
													 (~isFCRA or ~FCRA.Restricted_Header_Src(right.src, right.vendor_id[1]))) and
													 (not isFCRA
														OR (right.src='BA' and FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
														OR (right.src='L2' and FCRA.lien_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen) and filterLiens=false)
														OR right.src not in ['BA','L2']) AND
														trim((string)right.did) + trim((string)right.rid) not in left.header_correct_record_id	// old way - exclude corrected records from prior to 11/13/2012
														and trim( (string)right.persistent_record_id ) not in left.header_correct_record_id,  // new way - using persistent_record_id	
													 get_j_pre(LEFT, RIGHT), 
													 LEFT OUTER, atmost(ut.limits.HEADER_PER_DID));

j_pre_thor := join (distribute(g_inrec(did<>0), hash64(did)), 
										distribute(pull(header_key(s_did<>0)), hash64(s_did)), 
													 (LEFT.did = RIGHT.s_did) AND
														// if the customdata filter=PM or EB, make sure the source is on their allowed sources list
														(right.src in iid_constants.setPhillipMorrisAllowedHeaderSources or customDataFilter<>iid_constants.PhillipMorrisFilter) and
														(right.src in iid_constants.setExperianBatchAllowedHeaderSources or customDataFilter<>iid_constants.ExperianFCRA_Batch) and
													 right.src not in iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
													 ( (RIGHT.dt_first_seen < left.historydate and right.dt_first_seen <> 0) 
															or
															(right.dt_first_seen=0 and right.dt_vendor_first_reported < left.historydate) ) and // check date, only check vendor date if first seen date = 0
													 (
													 (bsversion>=50 or ~mdr.Source_is_Utility(RIGHT.src)) AND // rm Utility from NAS.  for shell 5.0, allow utility records into join for everything but NAS fields
													 (header.IsPreGLB_LIB(right.dt_nonglb_last_seen, 
																								right.dt_first_seen, 
																								right.src, 
																								DataRestriction) OR glb_ok) AND
													 (~mdr.Source_is_DPPA(RIGHT.src) OR
											(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))
											 or isFCRA) AND  // FCRA sees all sources
														~Risk_Indicators.iid_constants.filtered_source(right.src, right.st, bsversion) and
													 // we won't use experian dl's/vehicles (requires LN branding) -- in shell 5.0 and higher we can use them now
													 (ln_branded OR bsversion>=50 or ~(dppa_ok AND (RIGHT.src in mdr.sourcetools.set_Experian_dl or RIGHT.src in mdr.sourcetools.set_Experian_vehicles))) and
													 (~isFCRA or ~FCRA.Restricted_Header_Src(right.src, right.vendor_id[1]))) and
													 (not isFCRA
														OR (right.src='BA' and FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
														OR (right.src='L2' and FCRA.lien_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen) and filterLiens=false)
														OR right.src not in ['BA','L2']) AND
														trim((string)right.did) + trim((string)right.rid) not in left.header_correct_record_id	// old way - exclude corrected records from prior to 11/13/2012
														and trim( (string)right.persistent_record_id ) not in left.header_correct_record_id,  // new way - using persistent_record_id	
													 get_j_pre(LEFT, RIGHT), 
													 LEFT OUTER, atmost(left.did=right.s_did, ut.limits.HEADER_PER_DID), LOCAL);

j_pre_thor_nodid := project(g_inrec(did=0), transform(Layout_Header_Data, self := left, self := []));

#IF(onThor)
	j_pre := j_pre_thor+j_pre_thor_nodid;
#ELSE
	j_pre := j_pre_roxie;
#END

// get quick header
header_quick_key := if(isFCRA, header_quick.key_did_fcra, header_quick.key_DID);

Layout_Header_Data get_j_quickpre(g_inrec le, header_quick_key ri) := TRANSFORM
	self.seq := le.seq, 
	self.came_from_fastheader := true, 
	self.h := ri, 
	self := le, 
	self := [] 
END;

j_quickpre_roxie := join (g_inrec, header_quick_key,
																LEFT.did<>0 AND keyed(LEFT.did = RIGHT.did) AND
														// if the customdata filter=PM or EB, make sure the source is on their allowed sources list
														(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) in iid_constants.setPhillipMorrisAllowedHeaderSources or customDataFilter<>iid_constants.PhillipMorrisFilter) and
														(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) in iid_constants.setExperianBatchAllowedHeaderSources or customDataFilter<>iid_constants.ExperianFCRA_Batch) and
													 IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) not in iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
													 ( (RIGHT.dt_first_seen < left.historydate and right.dt_first_seen <> 0) 
															or
															(right.dt_first_seen=0 and right.dt_vendor_first_reported < left.historydate) ) and // check date, only check vendor date if first seen date = 0
													 (
													 (bsversion>=50 or ~mdr.Source_is_Utility(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src))) AND // rm Utility from NAS.  for shell 5.0, allow utility records into join for everything but NAS fields
													 (header.IsPreGLB_LIB(right.dt_nonglb_last_seen, 
																								right.dt_first_seen, 
																								right.src,
																								DataRestriction) OR glb_ok) AND
													 (~mdr.Source_is_DPPA(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src)) OR
											(dppa_ok AND drivers.state_dppa_ok(header.translateSource(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src)),dppa,IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src)))
											 or isFCRA) AND  // FCRA sees all sources
														~Risk_Indicators.iid_constants.filtered_source(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src), right.st, bsversion) and
													 // we won't use experian dl's/vehicles (requires LN branding) -- in shell 5.0 and higher we can use them now
													 (ln_branded OR bsversion>=50 or ~(dppa_ok AND (IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) in mdr.sourcetools.set_Experian_dl or IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) in mdr.sourcetools.set_Experian_vehicles))) and
													 (~isFCRA or ~FCRA.Restricted_Header_Src(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src), right.vendor_id[1]))) and
													 (not isFCRA
														OR (right.src='BA' and FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
														OR (right.src='L2' and FCRA.lien_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen) and filterLiens=false)
														OR right.src not in ['BA','L2']) AND
														trim((string)right.did) + trim((string)right.rid) not in left.header_correct_record_id	// old way - exclude corrected records from prior to 11/13/2012
														and trim( (string)right.persistent_record_id ) not in left.header_correct_record_id,  // new way - using persistent_record_id	
													 get_j_quickpre(LEFT,RIGHT), 
													 atmost(ut.limits.HEADER_PER_DID));

j_quickpre_thor := join (distribute(g_inrec(did<>0), hash64(did)), 
												 distribute(pull(header_quick_key(did<>0)), hash64(did)),
														(LEFT.did = RIGHT.did) AND
														// if the customdata filter=PM or EB, make sure the source is on their allowed sources list
														(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) in iid_constants.setPhillipMorrisAllowedHeaderSources or customDataFilter<>iid_constants.PhillipMorrisFilter) and
														(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) in iid_constants.setExperianBatchAllowedHeaderSources or customDataFilter<>iid_constants.ExperianFCRA_Batch) and
													 IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) not in iid_constants.masked_header_sources(DataRestriction, isFCRA) AND
													 ( (RIGHT.dt_first_seen < left.historydate and right.dt_first_seen <> 0) 
															or
															(right.dt_first_seen=0 and right.dt_vendor_first_reported < left.historydate) ) and // check date, only check vendor date if first seen date = 0
													 (
													 (bsversion>=50 or ~mdr.Source_is_Utility(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src))) AND // rm Utility from NAS.  for shell 5.0, allow utility records into join for everything but NAS fields
													 (header.IsPreGLB_LIB(right.dt_nonglb_last_seen, 
																								right.dt_first_seen, 
																								right.src,
																								DataRestriction) OR glb_ok) AND
													 (~mdr.Source_is_DPPA(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src)) OR
											(dppa_ok AND drivers.state_dppa_ok(header.translateSource(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src)),dppa,IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src)))
											 or isFCRA) AND  // FCRA sees all sources
														~Risk_Indicators.iid_constants.filtered_source(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src), right.st, bsversion) and
													 // we won't use experian dl's/vehicles (requires LN branding) -- in shell 5.0 and higher we can use them now
													 (ln_branded OR bsversion>=50 or ~(dppa_ok AND (IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) in mdr.sourcetools.set_Experian_dl or IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) in mdr.sourcetools.set_Experian_vehicles))) and
													 (~isFCRA or ~FCRA.Restricted_Header_Src(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src), right.vendor_id[1]))) and
													 (not isFCRA
														OR (right.src='BA' and FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen))
														OR (right.src='L2' and FCRA.lien_is_ok(iid_constants.myGetDate(left.historydate),(string)right.dt_first_seen) and filterLiens=false)
														OR right.src not in ['BA','L2']) AND
														trim((string)right.did) + trim((string)right.rid) not in left.header_correct_record_id	// old way - exclude corrected records from prior to 11/13/2012
														and trim( (string)right.persistent_record_id ) not in left.header_correct_record_id,  // new way - using persistent_record_id	
													 get_j_quickpre(LEFT,RIGHT), 
													 atmost(LEFT.did = RIGHT.did, ut.limits.HEADER_PER_DID), LOCAL);
													 
#IF(onThor)
	j_quickpre := j_quickpre_thor;
#ELSE
	j_quickpre := j_quickpre_roxie;
#END

header_recs_combined := if(RemoveQuickHeader, j_pre, j_pre + j_quickpre);  // adding new option to be able to toggle off quick header in archive mode			   
real_header_all_roxie := group( sort( ungroup(header_recs_combined), seq ,did), seq, did);	 
real_header_all_thor := group( sort( distribute( ungroup(header_recs_combined), hash64(seq)), seq ,did, LOCAL), seq, did, LOCAL);
real_header_all := if(onThor, real_header_all_thor, real_header_all_roxie);

real_header := if(DataRestriction[iid_constants.posEquifaxRestriction]=iid_constants.sTrue, real_header_all (h.src NOT IN [MDR.sourceTools.src_Equifax, MDR.sourcetools.src_Equifax_Quick, MDR.sourcetools.src_Equifax_Weekly]), real_header_all);



// now that we have header and quick header together, join them to corrections and see which fields changed so that we can correct all records
Layout_working combineHeaderCorrections(real_header le, header_corr ri) := transform
	ssnToUse := IF(le.h.valid_ssn<>'M', le.h.ssn, '');	// if manufactured, then blank out
	
	self.h.fname := if(trim(ri.head.fname)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Fname]='1', ri.head.fname, le.h.fname);
	self.h.mname := if(trim(ri.head.mname)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Mname]='1', ri.head.mname, le.h.mname);
	self.h.lname := if(trim(ri.head.lname)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Lname]='1', ri.head.lname, le.h.lname);
	self.h.name_suffix := if(trim(ri.head.name_suffix)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.NameSuffix]='1', ri.head.name_suffix, le.h.name_suffix);
	self.h.prim_range := if(trim(ri.head.prim_range)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.PrimRange]='1', ri.head.prim_range, le.h.prim_range);
	self.h.predir := if(trim(ri.head.predir)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Predir]='1', ri.head.predir, le.h.predir);
	self.h.prim_name := if(trim(ri.head.prim_name)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.PrimName]='1', ri.head.prim_name, le.h.prim_name);
	self.h.suffix := if(trim(ri.head.suffix)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Suffix]='1', ri.head.suffix, le.h.suffix);
	self.h.postdir := if(trim(ri.head.postdir)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Postdir]='1', ri.head.postdir, le.h.postdir);
	self.h.unit_desig := if(trim(ri.head.unit_desig)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.UnitDesig]='1', ri.head.unit_desig, le.h.unit_desig);
	self.h.sec_range := if(trim(ri.head.sec_range)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.SecRange]='1', ri.head.sec_range, le.h.sec_range);
	self.h.city_name := if(trim(ri.head.city_name)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.CityName]='1', ri.head.city_name, le.h.city_name);
	self.h.st := if(trim(ri.head.st)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.St]='1', ri.head.st, le.h.st);
	self.h.zip := if(trim(ri.head.zip)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Zip]='1', ri.head.zip, le.h.zip);
	self.h.zip4 := if(trim(ri.head.zip4)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Zip4]='1', ri.head.zip4, le.h.zip4);
	self.h.ssn := if(trim(ri.head.ssn)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.SSN]='1', ri.head.ssn, ssnToUse);
	self.h.dob := if(ri.head.dob<>0  or ri.blankout[Risk_Indicators.iid_constants.suppress.DOB]='1', ri.head.dob, le.h.dob);

	
	// check to see what was changed to what and if changed, then populate the fields for the next project
	fnameCorrected := trim(ri.head.fname)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Fname]='1';	// correction field will only be populated if a correction was done
	self.oldFname := if(fnameCorrected, le.h.fname, '');			// only populate the old if there is a new
	self.newFname := if(fnameCorrected, ri.head.fname, '');	// only populate the old if there is a new
	
	mnameCorrected := trim(ri.head.mname)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Mname]='1';	// correction field will only be populated if a correction was done
	self.oldmname := if(mnameCorrected, le.h.mname, '');			// only populate the old if there is a new
	self.newmname := if(mnameCorrected, ri.head.mname, '');	// only populate the old if there is a new
	
	lnameCorrected := trim(ri.head.lname)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Lname]='1';	// correction field will only be populated if a correction was done
	self.oldLname := if(lnameCorrected, le.lname, '');			// only populate the old if there is a new
	self.newLname := if(lnameCorrected, ri.head.lname, '');	// only populate the old if there is a new
	
	nameSuffixCorrected := trim(ri.head.name_suffix)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.NameSuffix]='1';	// correction field will only be populated if a correction was done
	self.oldNameSuffix := if(nameSuffixCorrected, le.h.name_suffix, '');			// only populate the old if there is a new
	self.newNameSuffix := if(nameSuffixCorrected, ri.head.name_suffix, '');	// only populate the old if there is a new
	
	// check to see if any part of the address was corrected, if so, then populate all fields in the address so we can compare later to see what the original address was
	addrCorrected := 	trim(ri.head.prim_range)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.PrimRange]='1' or 
										trim(ri.head.predir)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.Predir]='1' or 
										trim(ri.head.prim_name)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.PrimName]='1' or
										trim(ri.head.suffix)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.Suffix]='1' or 
										trim(ri.head.postdir)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.Postdir]='1' or 
										trim(ri.head.unit_desig)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.UnitDesig]='1' or
										trim(ri.head.sec_range)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.SecRange]='1';
	
	primRangeCorrected := addrCorrected;	// correction field will only be populated if a correction was done
	self.oldPrimRange := if(primRangeCorrected, le.h.prim_range, '');			// only populate the old if there is a new
	self.newPrimRange := map(AddrCorrected and ri.head.prim_range<>'' => ri.head.prim_range,
													 AddrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.PrimRange]='1' => '',
													 AddrCorrected => le.h.prim_range,	// if another addr field was corrected, then keep the original
													 '');
	
	predirCorrected := addrCorrected;	// correction field will only be populated if a correction was done
	self.oldPredir := if(predirCorrected, le.h.predir, '');			// only populate the old if there is a new
	self.newPredir := map(addrCorrected and ri.head.predir<>'' => ri.head.predir,
												addrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.predir]='1' => '',
												addrCorrected => le.h.predir,	// if another addr field was corrected, then keep the original
												'');
	
	primNameCorrected := addrCorrected;	// correction field will only be populated if a correction was done
	self.oldPrimName := if(primNameCorrected, le.h.prim_name, '');			// only populate the old if there is a new
	self.newPrimName := map(addrCorrected and ri.head.prim_name<>'' => ri.head.prim_name,
													 addrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.PrimName]='1' => '',
													 addrCorrected => le.h.prim_name,	// if another addr field was corrected, then keep the original
													 '');
	
	suffixCorrected := addrCorrected;	// correction field will only be populated if a correction was done
	self.oldSuffix := if(suffixCorrected, le.h.suffix, '');			// only populate the old if there is a new
	self.newSuffix := map(addrCorrected and ri.head.suffix<>'' => ri.head.suffix,
													 addrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.suffix]='1' => '',
													 addrCorrected => le.h.suffix,	// if another addr field was corrected, then keep the original
													 '');

	postdirCorrected := addrCorrected;	// correction field will only be populated if a correction was done
	self.oldPostDir := if(postDirCorrected, le.h.postdir, '');			// only populate the old if there is a new
	self.newPostDir := map(addrCorrected and ri.head.postdir<>'' => ri.head.postdir,
													 addrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.postdir]='1' => '',
													 addrCorrected => le.h.postdir,	// if another addr field was corrected, then keep the original
													 '');
	
	unitDesigCorrected := addrCorrected;	// correction field will only be populated if a correction was done
	self.oldUnitDesig := if(unitDesigCorrected, le.h.unit_desig, '');			// only populate the old if there is a new
	self.newUnitDesig := map(addrCorrected and ri.head.unit_desig<>'' => ri.head.unit_desig,
													 addrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.unitdesig]='1' => '',
													 addrCorrected => le.h.unit_desig,	// if another addr field was corrected, then keep the original
													 '');
	
	secRangeCorrected := addrCorrected;	// correction field will only be populated if a correction was done
	self.oldSecRange := if(secRangeCorrected, le.h.sec_range, '');			// only populate the old if there is a new
	self.newSecRange := map(addrCorrected and ri.head.sec_range<>'' => ri.head.sec_range,
													 addrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.secrange]='1' => '',
													 addrCorrected => le.h.sec_range,	// if another addr field was corrected, then keep the original
													 '');
	
	cityNameCorrected := addrCorrected and trim(ri.head.city_name)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.CityName]='1';	// correction field will only be populated if a correction was done
	self.oldCityname := if(cityNameCorrected, le.h.city_name, '');			// only populate the old if there is a new
	self.newCityName := if(cityNameCorrected, ri.head.city_name, '');	// only populate the old if there is a new
	
	stCorrected := addrCorrected and trim(ri.head.st)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.St]='1';	// correction field will only be populated if a correction was done
	self.oldSt := if(stCorrected, le.h.st, '');			// only populate the old if there is a new
	self.newSt := if(stCorrected, ri.head.st, '');	// only populate the old if there is a new
	
	zipCorrected := addrCorrected and trim(ri.head.zip)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Zip]='1';	// correction field will only be populated if a correction was done
	self.oldZip := if(zipCorrected, le.h.zip, '');			// only populate the old if there is a new
	self.newZip := if(zipCorrected, ri.head.zip, '');	// only populate the old if there is a new
	
	zip4Corrected := addrCorrected and trim(ri.head.zip4)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.Zip4]='1';	// correction field will only be populated if a correction was done
	self.oldZip4 := if(zip4Corrected, le.h.zip4, '');			// only populate the old if there is a new
	self.newZip4 := if(zip4Corrected, ri.head.zip4, '');	// only populate the old if there is a new
	
	ssnCorrected := trim(ri.head.ssn)<>''  or ri.blankout[Risk_Indicators.iid_constants.suppress.SSN]='1';	// correction field will only be populated if a correction was done
	self.oldSSN := if(ssnCorrected, ssnToUse, '');			// only populate the old if there is a new
	self.newSSN := if(ssnCorrected, ri.head.ssn, '');	// only populate the old if there is a new
	
	dobCorrected := ri.head.dob<>0  or ri.blankout[Risk_Indicators.iid_constants.suppress.DOB]='1';	// correction field will only be populated if a correction was done
	self.oldDOB := if(dobCorrected, (string)le.h.dob, '');			// only populate the old if there is a new
	self.newDOB := if(dobCorrected, (string)ri.head.dob, '');	// only populate the old if there is a new

	// set the flags - only if there is a correction, so that if it is populated, we know that it should be overwritten later
	self.addr_flags.dwelltype := if(trim(ri.addr_flags.dwelltype)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.DwellType]='1', ri.addr_flags.dwelltype, '');
	self.addr_flags.valid := if(trim(ri.addr_flags.valid)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.Valid]='1', ri.addr_flags.valid, '');
																																																											
	self.addr_flags.corpMil := if(trim(ri.addr_flags.corpMil)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.CorpMil]='1', ri.addr_flags.corpMil, '');								
	
	self.addr_flags.prisonAddr := if(trim(ri.addr_flags.prisonAddr)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.PrisonAddr]='1', ri.addr_flags.prisonAddr, '');
	self.addr_flags.highRisk := if(trim(ri.addr_flags.highRisk)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.HighRisk]='1', ri.addr_flags.highRisk, '');
	
	self.addr_flags.doNotDeliver := if(trim(ri.addr_flags.doNotDeliver)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.DoNotDeliver]='1', ri.addr_flags.doNotDeliver, '');
	self.addr_flags.deliveryStatus := if(trim(ri.addr_flags.deliveryStatus)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.DeliveryStatus]='1', ri.addr_flags.deliveryStatus, '');
	self.addr_flags.addressType := if(trim(ri.addr_flags.addressType)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.AddressType]='1', ri.addr_flags.addressType, '');
	self.addr_flags.dropIndicator := if(trim(ri.addr_flags.dropIndicator)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.DropIndicator]='1', ri.addr_flags.dropIndicator, '');
	
	
	dwellTypeCorrected := trim(ri.addr_flags.dwelltype)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.DwellType]='1';	// correction field will only be populated if a correction was done
	// dont need to keep an old here, just need the new
	self.oldDwellType := '';				
	self.newDwellType := if(dwellTypeCorrected, ri.addr_flags.dwelltype, '');	// only populate the new if there is a new
	
	validCorrected := trim(ri.addr_flags.valid)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.Valid]='1';	// correction field will only be populated if a correction was done
	self.oldValid := '';
	self.newValid := if(validCorrected, ri.addr_flags.valid, '');			// only populate the old if there is a new
	
	prisonAddrCorrected := trim(ri.addr_flags.prisonAddr)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.PrisonAddr]='1';	// correction field will only be populated if a correction was done
	self.oldPrisonAddr := '';
	self.newPrisonAddr := if(prisonAddrCorrected, ri.addr_flags.prisonAddr, '');			// only populate the old if there is a new
	
	highRiskCorrected := trim(ri.addr_flags.highRisk)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.HighRisk]='1';	// correction field will only be populated if a correction was done
	self.oldHighRisk := '';
	self.newHighRisk := if(highRiskCorrected, ri.addr_flags.highRisk, '');			// only populate the old if there is a new
	
	corpMilCorrected := trim(ri.addr_flags.corpMil)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.CorpMil]='1';	// correction field will only be populated if a correction was done
	self.oldCorpMil := '';
	self.newCorpMil := if(corpMilCorrected, ri.addr_flags.corpMil, '');			// only populate the old if there is a new
	
	doNotDeliverCorrected := trim(ri.addr_flags.doNotDeliver)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.DoNotDeliver]='1';	// correction field will only be populated if a correction was done
	self.oldDoNotDeliver := '';
	self.newDoNotDeliver := if(doNotDeliverCorrected, ri.addr_flags.doNotDeliver, '');			// only populate the old if there is a new
	
	deliveryStatusCorrected := trim(ri.addr_flags.deliveryStatus)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.DeliveryStatus]='1';	// correction field will only be populated if a correction was done
	self.oldDeliveryStatus := '';
	self.newDeliveryStatus := if(deliveryStatusCorrected, ri.addr_flags.deliveryStatus, '');			// only populate the old if there is a new
	
	addressTypeCorrected := trim(ri.addr_flags.addressType)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.AddressType]='1';	// correction field will only be populated if a correction was done
	self.oldAddressType := '';
	self.newAddressType := if(addressTypeCorrected, ri.addr_flags.addressType, '');			// only populate the old if there is a new
	
	dropIndicatorCorrected := trim(ri.addr_flags.dropIndicator)<>'' or ri.blankout[Risk_Indicators.iid_constants.suppress.DropIndicator]='1';	// correction field will only be populated if a correction was done
	self.oldDropIndicator := '';
	self.newDropIndicator := if(dropIndicatorCorrected, ri.addr_flags.dropIndicator, '');			// only populate the old if there is a new
	
	self.isCorrected := (string)ri.head.rid not in ['','0'] or ri.head.persistent_record_id<>0;
	
	self := le;
end;
corrPlusHeader := join(	real_header, header_corr,
												right.head.did<>0 and 
												left.seq=right.seq and
												(left.h.rid=right.head.rid or left.h.persistent_record_id=right.head.persistent_record_id),
												combineHeaderCorrections(left, right), LEFT OUTER, many lookup);
												
												
					
//------------------------------- additional code to correct future stuff
// need to get a dataset of corrected corrPlusHEader and a dataset of not corrected corrPlusHEader, join them together true all, check each of the correctable fields to see if they are corrected
// and that the original matches the original in the non-corrected dataset.  if they match, the use the corrected field, if not, the use the original					
corrOnly := corrPlusHeader(isCorrected);
unCorrOnly := corrPlusHeader(~isCorrected);												


Layout_working correctFutureData(unCorrOnly le, corrOnly ri) := transform
	self.h.fname := if((trim(ri.oldFname)<>'' or trim(ri.newFname)<>'') and ri.oldFname=le.h.fname, ri.newFname, le.h.fname);
	self.h.mname := if((trim(ri.oldMname)<>'' or trim(ri.newMname)<>'') and ri.oldMname=le.h.mname, ri.newMname, le.h.mname);
	self.h.lname := if((trim(ri.oldLname)<>'' or trim(ri.newLname)<>'') and ri.oldLname=le.h.lname, ri.newLname, le.h.lname);
	self.h.name_suffix := if((trim(ri.oldNameSuffix)<>'' or trim(ri.newNameSuffix)<>'') and ri.oldNameSuffix=le.h.name_suffix, ri.newNameSuffix, le.h.name_suffix);
	
	// need to check same address here and not individual parts before changing them
	origAddr := if(ri.oldPrimName<>'' or ri.oldPrimRange<>'', 
																	address.Addr1FromComponents(ri.oldPrimRange,ri.oldPreDir,ri.oldPrimName,ri.oldSuffix,ri.oldPostDir,ri.oldUnitDesig,ri.oldSecRange),// use old because it has been corrected
																	address.Addr1FromComponents(ri.h.prim_range,ri.h.predir,ri.h.prim_name,ri.h.suffix,ri.h.postdir,ri.h.unit_desig,ri.h.sec_range));	// use original because there is no old address because is has not been corrected
	sameAddr := address.Addr1FromComponents(le.h.prim_range,le.h.predir,le.h.prim_name,le.h.suffix,le.h.postdir,le.h.unit_desig,le.h.sec_range) = origAddr;
	self.h.prim_range := if((trim(ri.oldPrimRange)<>'' or trim(ri.newPrimRange)<>'') and sameAddr, ri.newPrimRange, le.h.prim_range);
	self.h.predir := if((trim(ri.oldPreDir)<>'' or trim(ri.newPreDir)<>'') and sameAddr, ri.newPreDir, le.h.predir);
	self.h.prim_name := if((trim(ri.oldPrimName)<>'' or trim(ri.newPrimName)<>'') and sameAddr, ri.newPrimName, le.h.prim_name);
	self.h.suffix := if((trim(ri.oldSuffix)<>'' or trim(ri.newSuffix)<>'') and sameAddr, ri.newSuffix, le.h.suffix);
	self.h.postdir := if((trim(ri.oldPostDir)<>'' or trim(ri.newPostDir)<>'') and sameAddr, ri.newPostDir, le.h.postdir);
	self.h.unit_desig := if((trim(ri.oldUnitDesig)<>'' or trim(ri.newUnitDesig)<>'') and sameAddr, ri.newUnitDesig, le.h.unit_desig);
	self.h.sec_range := if((trim(ri.oldSecRange)<>'' or trim(ri.newSecRange)<>'') and sameAddr, ri.newSecRange, le.h.sec_range);
	self.h.city_name := if((trim(ri.oldCityName)<>'' or trim(ri.newCityName)<>'') and sameAddr, ri.newCityName, le.h.city_name);
	self.h.st := if((trim(ri.oldSt)<>'' or trim(ri.newSt)<>'') and sameAddr, ri.newSt, le.h.st);
	self.h.zip := if((trim(ri.oldZip)<>'' or trim(ri.newZip)<>'') and sameAddr, ri.newZip, le.h.Zip);
	self.h.zip4 := if((trim(ri.oldZip4)<>'' or trim(ri.newZip4)<>'') and sameAddr, ri.newZip4, le.Zip4);
		
	self.h.ssn := if((trim(ri.oldSSN)<>'' or trim(ri.newDOB)<>'') and ri.oldSSN=le.ssn, ri.newSSN, le.h.ssn);
	self.h.dob := if((trim(ri.oldDOB)<>'' or trim(ri.newDOB)<>'') and ri.oldDOB=(string)le.h.dob, (unsigned)ri.newDOB, le.h.dob);
	
	self.addr_flags.dwellType := if((trim(ri.oldDwellType)<>'' or trim(ri.newDwellType)<>'') and sameAddr, ri.newDwellType, le.addr_flags.dwellType);
	self.addr_flags.valid := if((trim(ri.oldValid)<>'' or trim(ri.newValid)<>'') and sameAddr, ri.newValid, le.addr_flags.Valid);
	self.addr_flags.prisonAddr := if((trim(ri.oldPrisonAddr)<>'' or trim(ri.newPrisonAddr)<>'') and sameAddr, ri.newPrisonAddr, le.addr_flags.prisonAddr);
	self.addr_flags.highRisk := if((trim(ri.oldHighRisk)<>'' or trim(ri.newHighRisk)<>'') and sameAddr, ri.newHighRisk, le.addr_flags.highRisk);
	self.addr_flags.corpMil := if((trim(ri.oldCorpMil)<>'' or trim(ri.newCorpMil)<>'') and sameAddr, ri.newCorpMil, le.addr_flags.corpMil);
	self.addr_flags.doNotDeliver := if((trim(ri.oldDoNotDeliver)<>'' or trim(ri.newDoNotDeliver)<>'') and sameAddr, ri.newDoNotDeliver, le.addr_flags.doNotDeliver);
	self.addr_flags.deliveryStatus := if((trim(ri.oldDeliveryStatus)<>'' or trim(ri.newDeliveryStatus)<>'') and sameAddr, ri.newDeliveryStatus, le.addr_flags.DeliveryStatus);
	self.addr_flags.addressType := if((trim(ri.oldAddressType)<>'' or trim(ri.newAddressType)<>'') and sameAddr, ri.newAddressType, le.addr_flags.AddressType);
	self.addr_flags.dropIndicator := if((trim(ri.oldDropIndicator)<>'' or trim(ri.newDropIndicator)<>'') and sameAddr, ri.newDropIndicator, le.addr_flags.DropIndicator);
	
	// keep the old/new fields for below rollup
	self.oldFname := if(sameAddr and (trim(ri.oldFname)<>'' or trim(ri.newFname)<>''), ri.oldFname, '');
	self.newFname := if(sameAddr and (trim(ri.oldFname)<>'' or trim(ri.newFname)<>''), ri.newFname, '');
	self.oldMname := if(sameAddr and (trim(ri.oldMname)<>'' or trim(ri.newMname)<>''), ri.oldMname, '');
	self.newMname := if(sameAddr and (trim(ri.oldMname)<>'' or trim(ri.newMname)<>''), ri.newMname, '');
	self.oldLname := if(sameAddr and (trim(ri.oldLname)<>'' or trim(ri.newLname)<>''), ri.oldLname, '');
	self.newLname := if(sameAddr and (trim(ri.oldLname)<>'' or trim(ri.newLname)<>''), ri.newLname, '');
	self.oldNameSuffix := if(sameAddr and (trim(ri.oldNameSuffix)<>'' or trim(ri.newNameSuffix)<>''), ri.oldNameSuffix, '');
	self.newNameSuffix := if(sameAddr and (trim(ri.oldNameSuffix)<>'' or trim(ri.newNameSuffix)<>''), ri.newNameSuffix, '');
	self.oldPrimRange := if(sameAddr and (trim(ri.oldPrimRange)<>'' or trim(ri.newPrimRange)<>''), ri.oldPrimRange, '');
	self.newPrimRange := if(sameAddr and (trim(ri.oldPrimRange)<>'' or trim(ri.newPrimRange)<>''), ri.newPrimRange, '');
	self.oldPredir := if(sameAddr and (trim(ri.oldPredir)<>'' or trim(ri.newPredir)<>''), ri.oldPredir, '');
	self.newPredir := if(sameAddr and (trim(ri.oldPredir)<>'' or trim(ri.newPredir)<>''), ri.newPredir, '');
	self.oldPrimName := if(sameAddr and (trim(ri.oldPrimName)<>'' or trim(ri.newPrimName)<>''), ri.oldPrimName, '');
	self.newPrimName := if(sameAddr and (trim(ri.oldPrimName)<>'' or trim(ri.newPrimName)<>''), ri.newPrimName, '');
	self.oldSuffix := if(sameAddr and (trim(ri.oldSuffix)<>'' or trim(ri.newSuffix)<>''), ri.oldSuffix, '');
	self.newSuffix := if(sameAddr and (trim(ri.oldSuffix)<>'' or trim(ri.newSuffix)<>''), ri.newSuffix, '');
	self.oldPostdir := if(sameAddr and (trim(ri.oldPostdir)<>'' or trim(ri.newPostdir)<>''), ri.oldPostdir, '');
	self.newPostdir := if(sameAddr and (trim(ri.oldPostdir)<>'' or trim(ri.newPostdir)<>''), ri.newPostdir, '');
	self.oldUnitDesig := if(sameAddr and (trim(ri.oldUnitDesig)<>'' or trim(ri.newUnitDesig)<>''), ri.oldUnitDesig, '');
	self.newUnitDesig := if(sameAddr and (trim(ri.oldUnitDesig)<>'' or trim(ri.newUnitDesig)<>''), ri.newUnitDesig, '');
	self.oldSecRange := if(sameAddr and (trim(ri.oldSecRange)<>'' or trim(ri.newSecRange)<>''), ri.oldSecRange, '');
	self.newSecRange := if(sameAddr and (trim(ri.oldSecRange)<>'' or trim(ri.newSecRange)<>''), ri.newSecRange, '');
	self.oldCityName := if(sameAddr and (trim(ri.oldCityName)<>'' or trim(ri.newCityName)<>''), ri.oldCityName, '');
	self.newCityName := if(sameAddr and (trim(ri.oldCityName)<>'' or trim(ri.newCityName)<>''), ri.newCityName, '');
	self.oldSt := if(sameAddr and (trim(ri.oldSt)<>'' or trim(ri.newSt)<>''), ri.oldSt, '');
	self.newSt := if(sameAddr and (trim(ri.oldSt)<>'' or trim(ri.newSt)<>''), ri.newSt, '');
	self.oldZip := if(sameAddr and (trim(ri.oldZip)<>'' or trim(ri.newZip)<>''), ri.oldZip, '');
	self.newZip := if(sameAddr and (trim(ri.oldZip)<>'' or trim(ri.newZip)<>''), ri.newZip, '');
	self.oldZip4 := if(sameAddr and (trim(ri.oldZip4)<>'' or trim(ri.newZip4)<>''), ri.oldZip4, '');
	self.newZip4 := if(sameAddr and (trim(ri.oldZip4)<>'' or trim(ri.newZip4)<>''), ri.newZip4, '');
	self.oldSSN := if(sameAddr and (trim(ri.oldSSN)<>'' or trim(ri.newSSN)<>''), ri.oldSSN, '');
	self.newSSN := if(sameAddr and (trim(ri.oldSSN)<>'' or trim(ri.newSSN)<>''), ri.newSSN, '');
	self.oldDOB := if(sameAddr and (trim(ri.oldDOB)<>'' or trim(ri.newDOB)<>''), ri.oldDOB, '');
	self.newDOB := if(sameAddr and (trim(ri.oldDOB)<>'' or trim(ri.newDOB)<>''), ri.newDOB, '');
	self.oldDwellType := if(sameAddr and (trim(ri.oldDwellType)<>'' or trim(ri.newDwellType)<>''), ri.oldDwellType, '');
	self.newDwellType := if(sameAddr and (trim(ri.oldDwellType)<>'' or trim(ri.newDwellType)<>''), ri.newDwellType, '');
	self.oldValid := if(sameAddr and (trim(ri.oldValid)<>'' or trim(ri.newValid)<>''), ri.oldValid, '');
	self.newValid := if(sameAddr and (trim(ri.oldValid)<>'' or trim(ri.newValid)<>''), ri.newValid, '');
	self.oldPrisonAddr := if(sameAddr and (trim(ri.oldPrisonAddr)<>'' or trim(ri.newPrisonAddr)<>''), ri.oldPrisonAddr, '');
	self.newPrisonAddr := if(sameAddr and (trim(ri.oldPrisonAddr)<>'' or trim(ri.newPrisonAddr)<>''), ri.newPrisonAddr, '');
	self.oldHighRisk := if(sameAddr and (trim(ri.oldHighRisk)<>'' or trim(ri.newHighRisk)<>''), ri.oldHighRisk, '');
	self.newHighRisk := if(sameAddr and (trim(ri.oldHighRisk)<>'' or trim(ri.newHighRisk)<>''), ri.newHighRisk, '');
	self.oldCorpMil := if(sameAddr and (trim(ri.oldCorpMil)<>'' or trim(ri.newCorpMil)<>''), ri.oldCorpMil, '');
	self.newCorpMil := if(sameAddr and (trim(ri.oldCorpMil)<>'' or trim(ri.newCorpMil)<>''), ri.newCorpMil, '');
	self.oldDoNotDeliver := if(sameAddr and (trim(ri.oldDoNotDeliver)<>'' or trim(ri.newDoNotDeliver)<>''), ri.oldDoNotDeliver, '');
	self.newDoNotDeliver := if(sameAddr and (trim(ri.oldDoNotDeliver)<>'' or trim(ri.newDoNotDeliver)<>''), ri.newDoNotDeliver, '');
	self.oldDeliveryStatus := if(sameAddr and (trim(ri.oldDeliveryStatus)<>'' or trim(ri.newDeliveryStatus)<>''), ri.oldDeliveryStatus, '');
	self.newDeliveryStatus := if(sameAddr and (trim(ri.oldDeliveryStatus)<>'' or trim(ri.newDeliveryStatus)<>''), ri.newDeliveryStatus, '');
	self.oldAddressType := if(sameAddr and (trim(ri.oldAddressType)<>'' or trim(ri.newAddressType)<>''), ri.oldAddressType, '');
	self.newAddressType := if(sameAddr and (trim(ri.oldAddressType)<>'' or trim(ri.newAddressType)<>''), ri.newAddressType, '');
	self.oldDropIndicator := if(sameAddr and (trim(ri.oldDropIndicator)<>'' or trim(ri.newDropIndicator)<>''), ri.oldDropIndicator, '');
	self.newDropIndicator := if(sameAddr and (trim(ri.oldDropIndicator)<>'' or trim(ri.newDropIndicator)<>''), ri.newDropIndicator, '');
	
	self.isCorrected := le.isCorrected or ri.isCorrected;
	
	self := le;	// keep the remaining left fields
end;
finalCorr := join(unCorrOnly, CorrOnly, 
									left.seq=right.seq and left.h.did=right.h.did and 
									((trim(right.oldFname)<>'' or trim(right.newFname)<>'') and right.oldFname=left.h.fname OR	
									(trim(right.oldMname)<>'' or trim(right.newMname)<>'') and right.oldMname=left.h.mname  OR
									(trim(right.oldLname)<>'' or trim(right.newLname)<>'') and right.oldLname=left.h.lname OR
									(trim(right.oldNameSuffix)<>'' or trim(right.newNameSuffix)<>'') and right.oldNameSuffix=left.h.name_suffix  OR
									(trim(right.oldSSN)<>'' or trim(right.newSSN)<>'') and right.oldSSN=left.h.ssn OR
									(trim(right.oldDOB)<>'' or trim(right.newDOB)<>'') and right.oldDOB=(string)left.h.dob OR
									// same address and an address field is different
									address.Addr1FromComponents(right.oldPrimRange,right.oldPredir,right.oldPrimName,right.oldSuffix,right.oldPostDir,right.oldUnitDesig,right.oldSecRange) = 
									address.Addr1FromComponents(left.h.Prim_Range,left.h.PreDir,left.h.Prim_Name,left.h.Suffix,left.h.PostDir,left.h.Unit_Desig,left.h.Sec_Range) OR
									// same address and a flag is different
										(if(trim(right.oldPrimName)<>'' or trim(right.oldPrimRange)<>'', 
																	address.Addr1FromComponents(right.oldPrimRange,right.oldPreDir,right.oldPrimName,right.oldSuffix,right.oldPostDir,right.oldUnitDesig,right.oldSecRange),// use old because it has been corrected
																	address.Addr1FromComponents(right.h.prim_range,right.h.predir,right.h.prim_name,right.h.suffix,right.h.postdir,right.h.unit_desig,right.h.sec_range))=	// use original because there is no old address because is has not been corrected
																	address.Addr1FromComponents(left.h.prim_range,left.h.predir,left.h.prim_name,left.h.suffix,left.h.postdir,left.h.unit_desig,left.h.sec_range) AND
									(trim(right.oldDwellType)<>'' or trim(right.newDwellType)<>'') and right.oldDwellType=left.addr_flags.dwelltype OR
									(trim(right.oldValid)<>'' or trim(right.newValid)<>'')  and right.oldValid=left.addr_flags.valid OR
									(trim(right.oldPrisonAddr)<>'' or trim(right.newPrisonAddr)<>'')  and right.oldPrisonAddr=left.addr_flags.PrisonAddr OR
									(trim(right.oldHighRisk)<>'' or trim(right.newHighRisk)<>'')  and right.oldHighRisk=left.addr_flags.HighRisk OR
									(trim(right.oldCorpMil)<>'' or trim(right.newCorpMil)<>'')  and right.oldCorpMil=left.addr_flags.CorpMil OR
									(trim(right.oldDoNotDeliver)<>'' or trim(right.newDoNotDeliver)<>'')  and right.oldDoNotDeliver=left.addr_flags.DoNotDeliver OR
									(trim(right.oldDeliveryStatus)<>'' or trim(right.newDeliveryStatus)<>'')  and right.oldDeliveryStatus=left.addr_flags.DeliveryStatus OR
									(trim(right.oldAddressType)<>'' or trim(right.newAddressType)<>'')  and right.oldAddressType=left.addr_flags.AddressType OR
									(trim(right.oldDropIndicator)<>'' or trim(right.newDropIndicator)<>'')  and right.oldDropIndicator=left.addr_flags.DropIndicator)), 
									correctFutureData(left, right), all, left outer);
									
									
// doing the above join results in too many records per rid (potentially), we need to rollup by rid and figure out which field to keep from the multiple choices
layout_working getCorrectCorrections(finalCorr le, finalCorr ri) := transform
	
	self.h.fname := map(trim(le.h.fname)=trim(ri.h.fname) => le.h.fname,	// same on both, keep left
										(trim(le.oldFname)<>'' or trim(le.newFname)<>'') and trim(le.newFname)=trim(le.h.fname) => le.h.fname,	// correction on this rid and left matches new, so keep left
										(trim(le.oldFname)<>'' or trim(le.newFname)<>'') => ri.h.fname, // correction on this rid and left doesnt match new, so keep right
										(trim(ri.oldFname)<>'' or trim(ri.newFname)<>'') => ri.h.fname,	// correction on this rid and right had the correction, so keep right?
										le.h.fname);	// default to keep left
	self.h.mname := map(trim(le.h.mname)=trim(ri.h.mname) => le.h.mname,	// same on both, keep left
										(trim(le.oldmname)<>'' or trim(le.newmname)<>'') and trim(le.newmname)=trim(le.h.mname) => le.h.mname,	// correction on this rid and left matches new, so keep left
										(trim(le.oldmname)<>'' or trim(le.newmname)<>'') => ri.h.mname, // correction on this rid and left doesnt match new, so keep right
										(trim(ri.oldMname)<>'' or trim(ri.newMname)<>'') => ri.h.mname,	// correction on this rid and right had the correction, so keep right?
										le.h.mname);	// default to keep left
	self.h.lname := map(trim(le.h.lname)=trim(ri.h.lname) => le.h.lname,	// same on both, keep left
										(trim(le.oldlname)<>'' or trim(le.newlname)<>'') and trim(le.newlname)=trim(le.h.lname) => le.h.lname,	// correction on this rid and left matches new, so keep left
										(trim(le.oldlname)<>'' or trim(le.newlname)<>'') => ri.h.lname, // correction on this rid and left doesnt match new, so keep right
										(trim(ri.oldLname)<>'' or trim(ri.newLName)<>'') => ri.h.lname,	// correction on this rid and right had the correction, so keep right?
										le.h.lname);	// default to keep left
	self.h.name_suffix := map(trim(le.h.name_suffix)=trim(ri.h.name_suffix) => le.h.name_suffix,	// same on both, keep left
													(trim(le.oldNameSuffix)<>'' or trim(le.newNameSuffix)<>'') and trim(le.newNameSuffix)=trim(le.h.name_suffix) => le.h.name_suffix,	// correction on this rid and left matches new, so keep left
													(trim(le.oldNameSuffix)<>'' or trim(le.newNameSuffix)<>'') => ri.h.name_suffix, // correction on this rid and left doesnt match new, so keep right
													(trim(ri.oldNameSuffix)<>'' or trim(ri.newNameSuffix)<>'') => ri.h.name_suffix,	// correction on this rid and right had the correction, so keep right?
													le.h.name_suffix);	// default to keep left
	
	
	self.h.prim_range := map(	trim(le.h.prim_range)=trim(ri.h.prim_range) => le.h.prim_range,	// same on both, keep left
													(trim(le.oldPrimRange)<>'' or trim(le.newPrimRange)<>'') and trim(le.newPrimRange)=trim(le.h.prim_range) => le.h.prim_range,	// correction on this rid and left matches new, so keep left
													(trim(le.oldPrimRange)<>'' or trim(le.newPrimRange)<>'') => ri.h.prim_range, // correction on this rid and left doesnt match new, so keep right
													(trim(ri.oldPrimRange)<>'' or trim(ri.newPrimRange)<>'') => ri.h.prim_range,	// correction on this rid and right had the correction, so keep right?
													le.h.prim_range);	// default to keep left
	self.h.predir := map(	trim(le.h.predir)=trim(ri.h.predir) => le.h.predir,	// same on both, keep left
											(trim(le.oldpredir)<>'' or trim(le.newpredir)<>'') and trim(le.newpredir)=trim(le.h.predir) => le.h.predir,	// correction on this rid and left matches new, so keep left
											(trim(le.oldpredir)<>'' or trim(le.newpredir)<>'') => ri.h.predir, // correction on this rid and left doesnt match new, so keep right
											(trim(ri.oldPredir)<>'' or trim(ri.newPredir)<>'') => ri.h.predir,	// correction on this rid and right had the correction, so keep right?
											le.h.predir);	// default to keep left
	self.h.prim_name := map(trim(le.h.prim_name)=trim(ri.h.prim_name) => le.h.prim_name,	// same on both, keep left
												(trim(le.oldPrimName)<>'' or trim(le.newPrimName)<>'') and trim(le.newPrimName)=trim(le.h.prim_name) => le.h.prim_name,	// correction on this rid and left matches new, so keep left
												(trim(le.oldPrimName)<>'' or trim(le.newPrimName)<>'') => ri.h.prim_name, // correction on this rid and left doesnt match new, so keep right
												(trim(ri.oldPrimName)<>'' or trim(ri.newPrimName)<>'') => ri.h.prim_name,	// correction on this rid and right had the correction, so keep right?
												le.h.prim_name);	// default to keep left
	self.h.suffix := map(	trim(le.h.suffix)=trim(ri.h.suffix) => le.h.suffix,	// same on both, keep left
											(trim(le.oldsuffix)<>'' or trim(le.newsuffix)<>'') and trim(le.newsuffix)=trim(le.h.suffix) => le.h.suffix,	// correction on this rid and left matches new, so keep left
											(trim(le.oldsuffix)<>'' or trim(le.newsuffix)<>'') => ri.h.suffix, // correction on this rid and left doesnt match new, so keep right
											(trim(ri.oldSuffix)<>'' or trim(ri.newSuffix)<>'') => ri.h.suffix,	// correction on this rid and right had the correction, so keep right?
											le.h.suffix);	// default to keep left
	self.h.postdir := map(trim(le.h.postdir)=trim(ri.h.postdir) => le.h.postdir,	// same on both, keep left
											(trim(le.oldpostdir)<>'' or trim(le.newpostdir)<>'') and trim(le.newpostdir)=trim(le.h.postdir) => le.h.postdir,	// correction on this rid and left matches new, so keep left
											(trim(le.oldpostdir)<>'' or trim(le.newpostdir)<>'') => ri.h.postdir, // correction on this rid and left doesnt match new, so keep right
											(trim(ri.oldPostdir)<>'' or trim(ri.newPostdir)<>'') => ri.h.postdir,	// correction on this rid and right had the correction, so keep right?
											le.h.postdir);	// default to keep left
	self.h.unit_desig := map(	trim(le.h.unit_desig)=trim(ri.h.unit_desig) => le.h.unit_desig,	// same on both, keep left
													(trim(le.oldUnitDesig)<>'' or trim(le.newUnitDesig)<>'') and trim(le.newUnitDesig)=trim(le.h.unit_desig) => le.h.unit_desig,	// correction on this rid and left matches new, so keep left
													(trim(le.oldUnitDesig)<>'' or trim(le.newUnitDesig)<>'') => ri.h.unit_desig, // correction on this rid and left doesnt match new, so keep right
													(trim(ri.oldUnitDesig)<>'' or trim(ri.newUnitDesig)<>'') => ri.h.unit_desig,	// correction on this rid and right had the correction, so keep right?
													le.h.unit_desig);	// default to keep left
	self.h.sec_range := map(trim(le.h.sec_range)=trim(ri.h.sec_range) => le.h.sec_range,	// same on both, keep left
												(trim(le.oldSecRange)<>'' or trim(le.newSecRange)<>'') and trim(le.newSecRange)=trim(le.h.sec_range) => le.h.sec_range,	// correction on this rid and left matches new, so keep left
												(trim(le.oldSecRange)<>'' or trim(le.newSecRange)<>'') => ri.h.sec_range, // correction on this rid and left doesnt match new, so keep right
												(trim(ri.oldSecRange)<>'' or trim(ri.newSecRange)<>'') => ri.h.sec_range,	// correction on this rid and right had the correction, so keep right?
												le.h.sec_range);	// default to keep left
	self.h.city_name := map(trim(le.h.city_name)=trim(ri.h.city_name) => le.h.city_name,	// same on both, keep left
												(trim(le.oldCityName)<>'' or trim(le.newCityName)<>'') and trim(le.newCityName)=trim(le.h.city_name) => le.h.city_name,	// correction on this rid and left matches new, so keep left
												(trim(le.oldCityName)<>'' or trim(le.newCityName)<>'') => ri.h.city_name, // correction on this rid and left doesnt match new, so keep right
												(trim(ri.oldCityName)<>'' or trim(ri.newCityName)<>'') => ri.h.city_name,	// correction on this rid and right had the correction, so keep right?
												le.h.city_name);	// default to keep left
	self.h.st := map(	trim(le.h.st)=trim(ri.h.st) => le.h.st,	// same on both, keep left
									(trim(le.oldst)<>'' or trim(le.newst)<>'') and trim(le.newst)=trim(le.h.st) => le.h.st,	// correction on this rid and left matches new, so keep left
									(trim(le.oldst)<>'' or trim(le.newst)<>'') => ri.h.st, // correction on this rid and left doesnt match new, so keep right
									(trim(ri.oldSt)<>'' or trim(ri.newSt)<>'') => ri.h.st,	// correction on this rid and right had the correction, so keep right?
									le.h.st);	// default to keep left
	self.h.zip := map(trim(le.h.zip)=trim(ri.h.zip) => le.h.zip,	// same on both, keep left
									(trim(le.oldzip)<>'' or trim(le.newzip)<>'') and trim(le.newzip)=trim(le.h.zip) => le.h.zip,	// correction on this rid and left matches new, so keep left
									(trim(le.oldzip)<>'' or trim(le.newzip)<>'') => ri.h.zip, // correction on this rid and left doesnt match new, so keep right
									(trim(ri.oldZip)<>'' or trim(ri.newZip)<>'') => ri.h.zip,	// correction on this rid and right had the correction, so keep right?
									le.h.zip);	// default to keep left
	self.h.zip4 := map(	trim(le.h.zip4)=trim(ri.h.zip4) => le.h.zip4,	// same on both, keep left
										(trim(le.oldzip4)<>'' or trim(le.newzip4)<>'') and trim(le.newzip4)=trim(le.h.zip4) => le.h.zip4,	// correction on this rid and left matches new, so keep left
										(trim(le.oldzip4)<>'' or trim(le.newzip4)<>'') => ri.h.zip4, // correction on this rid and left doesnt match new, so keep right
										(trim(ri.oldZip4)<>'' or trim(ri.newZip4)<>'') => ri.h.zip4,	// correction on this rid and right had the correction, so keep right?
										le.h.zip4);	// default to keep left
	
	self.h.ssn := map(trim(le.h.ssn)=trim(ri.h.ssn) => le.h.ssn,	// same on both, keep left
									(trim(le.oldssn)<>'' or trim(le.newssn)<>'') and trim(le.newssn)=trim(le.h.ssn) => le.h.ssn,	// correction on this rid and left matches new, so keep left
									(trim(le.oldssn)<>'' or trim(le.newssn)<>'') => ri.h.ssn, // correction on this rid and left doesnt match new, so keep right
									(trim(ri.oldSSN)<>'' or trim(ri.newSSN)<>'') => ri.h.ssn,	// correction on this rid and right had the correction, so keep right?
									le.h.ssn);	// default to keep left
	self.h.dob := map((le.h.dob)=(ri.h.dob) => le.h.dob,	// same on both, keep left
									(trim(le.olddob)<>'' or trim(le.newdob)<>'') and trim(le.newdob)=(string)le.h.dob => le.h.dob,	// correction on this rid and left matches new, so keep left
									(trim(le.olddob)<>'' or trim(le.newdob)<>'') => ri.h.dob, // correction on this rid and left doesnt match new, so keep right
									(trim(ri.oldDOB)<>'' or trim(ri.newDOB)<>'') => ri.h.dob,	// correction on this rid and right had the correction, so keep right?
									le.h.dob);	// default to keep left
									
	self.addr_flags.dwellType := map(	(le.addr_flags.dwellType)=(ri.addr_flags.dwellType) => le.addr_flags.dwellType,	// same on both, keep left
																		(trim(le.oldDwellType)<>'' or trim(le.newDwellType)<>'') and trim(le.newDwellType)=(string)le.addr_flags.dwellType => le.addr_flags.dwellType,	// correction on this rid and left matches new, so keep left
																		(trim(le.oldDwellType)<>'' or trim(le.newDwellType)<>'') => ri.addr_flags.dwellType, // correction on this rid and left doesnt match new, so keep right
																		(trim(ri.oldDwellType)<>'' or trim(ri.newDwellType)<>'') => ri.addr_flags.dwellType,	// correction on this rid and right had the correction, so keep right?
																		le.addr_flags.dwellType);	// default to keep left
	self.addr_flags.valid := map(	(le.addr_flags.valid)=(ri.addr_flags.valid) => le.addr_flags.valid,	// same on both, keep left
																(trim(le.oldvalid)<>'' or trim(le.newvalid)<>'') and trim(le.newvalid)=(string)le.addr_flags.valid => le.addr_flags.valid,	// correction on this rid and left matches new, so keep left
																(trim(le.oldvalid)<>'' or trim(le.newvalid)<>'') => ri.addr_flags.valid, // correction on this rid and left doesnt match new, so keep right
																(trim(ri.oldValid)<>'' or trim(ri.newValid)<>'') => ri.addr_flags.valid,	// correction on this rid and right had the correction, so keep right?
																le.addr_flags.valid);	// default to keep left;
	self.addr_flags.prisonAddr := map((le.addr_flags.prisonAddr)=(ri.addr_flags.prisonAddr) => le.addr_flags.prisonAddr,	// same on both, keep left
																		(trim(le.oldprisonAddr)<>'' or trim(le.newprisonAddr)<>'') and trim(le.newprisonAddr)=(string)le.addr_flags.prisonAddr => le.addr_flags.prisonAddr,	// correction on this rid and left matches new, so keep left
																		(trim(le.oldprisonAddr)<>'' or trim(le.newprisonAddr)<>'') => ri.addr_flags.prisonAddr, // correction on this rid and left doesnt match new, so keep right
																		(trim(ri.oldPrisonAddr)<>'' or trim(ri.newPrisonAddr)<>'') => ri.addr_flags.prisonAddr,	// correction on this rid and right had the correction, so keep right?
																		le.addr_flags.prisonAddr);	// default to keep left;
	self.addr_flags.highRisk := map((le.addr_flags.highRisk)=(ri.addr_flags.highRisk) => le.addr_flags.highRisk,	// same on both, keep left
																	(trim(le.oldhighRisk)<>'' or trim(le.newhighRisk)<>'') and trim(le.newhighRisk)=(string)le.addr_flags.highRisk => le.addr_flags.highRisk,	// correction on this rid and left matches new, so keep left
																	(trim(le.oldhighRisk)<>'' or trim(le.newhighRisk)<>'') => ri.addr_flags.highRisk, // correction on this rid and left doesnt match new, so keep right
																	(trim(ri.oldHighRisk)<>'' or trim(ri.newHighRisk)<>'') => ri.addr_flags.highRisk,	// correction on this rid and right had the correction, so keep right?
																	le.addr_flags.highRisk);	// default to keep left;
	self.addr_flags.corpMil := map(	(le.addr_flags.corpMil)=(ri.addr_flags.corpMil) => le.addr_flags.corpMil,	// same on both, keep left
																	(trim(le.oldcorpMil)<>'' or trim(le.newcorpMil)<>'') and trim(le.newcorpMil)=(string)le.addr_flags.corpMil => le.addr_flags.corpMil,	// correction on this rid and left matches new, so keep left
																	(trim(le.oldcorpMil)<>'' or trim(le.newcorpMil)<>'') => ri.addr_flags.corpMil, // correction on this rid and left doesnt match new, so keep right
																	(trim(ri.oldCorpMil)<>'' or trim(ri.newCorpMil)<>'') => ri.addr_flags.corpMil,	// correction on this rid and right had the correction, so keep right?
																	le.addr_flags.corpMil);	// default to keep left
	self.addr_flags.doNotDeliver := map((le.addr_flags.doNotDeliver)=(ri.addr_flags.doNotDeliver) => le.addr_flags.doNotDeliver,	// same on both, keep left
																			(trim(le.olddoNotDeliver)<>'' or trim(le.newdoNotDeliver)<>'') and trim(le.newdoNotDeliver)=(string)le.addr_flags.doNotDeliver => le.addr_flags.doNotDeliver,	// correction on this rid and left matches new, so keep left
																			(trim(le.olddoNotDeliver)<>'' or trim(le.newdoNotDeliver)<>'') => ri.addr_flags.doNotDeliver, // correction on this rid and left doesnt match new, so keep right
																			(trim(ri.oldDoNotDeliver)<>'' or trim(ri.newDoNotDeliver)<>'') => ri.addr_flags.doNotDeliver,	// correction on this rid and right had the correction, so keep right?																			
																			le.addr_flags.doNotDeliver);	// default to keep left
	self.addr_flags.deliveryStatus := map((le.addr_flags.deliveryStatus)=(ri.addr_flags.deliveryStatus) => le.addr_flags.deliveryStatus,	// same on both, keep left
																				(trim(le.olddeliveryStatus)<>'' or trim(le.newdeliveryStatus)<>'') and trim(le.newdeliveryStatus)=(string)le.addr_flags.deliveryStatus => le.addr_flags.deliveryStatus,	// correction on this rid and left matches new, so keep left
																				(trim(le.olddeliveryStatus)<>'' or trim(le.newdeliveryStatus)<>'') => ri.addr_flags.deliveryStatus, // correction on this rid and left doesnt match new, so keep right
																				(trim(ri.oldDeliveryStatus)<>'' or trim(ri.newDeliveryStatus)<>'') => ri.addr_flags.deliveryStatus,	// correction on this rid and right had the correction, so keep right?
																				le.addr_flags.deliveryStatus);	// default to keep left
	self.addr_flags.addressType := map(	(le.addr_flags.addressType)=(ri.addr_flags.addressType) => le.addr_flags.addressType,	// same on both, keep left
																			(trim(le.oldaddressType)<>'' or trim(le.newaddressType)<>'') and trim(le.newaddressType)=(string)le.addr_flags.addressType => le.addr_flags.addressType,	// correction on this rid and left matches new, so keep left
																			(trim(le.oldaddressType)<>'' or trim(le.newaddressType)<>'') => ri.addr_flags.addressType, // correction on this rid and left doesnt match new, so keep right
																			(trim(ri.oldAddressType)<>'' or trim(ri.newAddressType)<>'') => ri.addr_flags.addressType,	// correction on this rid and right had the correction, so keep right?
																			le.addr_flags.addressType);	// default to keep left
	self.addr_flags.dropIndicator := map(	(le.addr_flags.dropIndicator)=(ri.addr_flags.dropIndicator) => le.addr_flags.dropIndicator,	// same on both, keep left
																				(trim(le.olddropIndicator)<>'' or trim(le.newdropIndicator)<>'') and trim(le.newdropIndicator)=(string)le.addr_flags.dropIndicator => le.addr_flags.dropIndicator,	// correction on this rid and left matches new, so keep left
																				(trim(le.olddropIndicator)<>'' or trim(le.newdropIndicator)<>'') => ri.addr_flags.dropIndicator, // correction on this rid and left doesnt match new, so keep right
																				(trim(ri.oldDropIndicator)<>'' or trim(ri.newDropIndicator)<>'') => ri.addr_flags.dropIndicator,	// correction on this rid and right had the correction, so keep right?
																				le.addr_flags.dropIndicator);	// default to keep left
	
	self := le;	// keep the remaining left fields
end;
 
finalCorr2 := rollup (sort(finalCorr(isCorrected),	seq, h.persistent_record_id,-h.Fname,-h.Mname,-h.Lname,-h.Name_Suffix,-h.Prim_Range,-h.Predir,-h.Prim_Name,-h.Suffix,-h.Postdir,-h.Unit_Desig,-h.Sec_Range,-h.City_Name,
																			-h.St,-h.Zip,-h.Zip4,-h.SSN,-h.DOB,
																			-addr_flags.DwellType,-addr_flags.Valid,-addr_flags.PrisonAddr,-addr_flags.HighRisk,-addr_flags.CorpMil,-addr_flags.DoNotDeliver,
																			-addr_flags.DeliveryStatus,-addr_flags.AddressType,-addr_flags.DropIndicator,came_from_fastheader, h.RID), left.h.persistent_record_id=right.h.persistent_record_id and left.seq=right.seq, getCorrectCorrections(left,right));

// need to add back the corrOnly records
header_recs := PROJECT(real_header, TRANSFORM(layout_working, self := left, self := [])) + finalCorr2 + corrOnly;

// done correcting, now do the existing transform
iid_constants.layout_outx getHeader(Layout_working le) := TRANSFORM	
	self.header_summary.header_build_date := header_build_date;

	myGetDate := iid_constants.myGetDate(le.historydate);	// full history date
	EverOccupantStartDateTemp := (unsigned3)((string)EverOccupant_StartDate)[1..6];
	ever_start_date   := iid_constants.MyGetDate( EverOccupantStartDateTemp )[1..6];
	ever_start_months := ut.Date_YYYYMM_i2(ever_start_date);
	ever_past_months  := if(EverOccupant_PastMonths > 0, EverOccupant_PastMonths, ut.Date_YYYYMM_i2(ever_start_date));
	CURRENT_OCCUPANT_MONTHS := 4; // from today, how many months back we'll consider someone a 'current' resident

	SELF.header_footprint := 1;
	
	ssn2use_original := IF ( ~mdr.Source_is_DPPA(le.h.src) or dppa IN [1,4,6] or isFCRA, 
					IF(le.h.valid_ssn<>'M',le.h.ssn, ''), '');
	
	// keep original logic for bsversion prior to 50
	// for 50 and higher, make sure the valid_ssn field is ok - Emerging Identities allows a broader set of valid_ssn's

	ssn2use := if(bsversion < 50 or EnableEmergingID or 
								le.h.valid_ssn in Risk_Indicators.iid_constants.set_valid_ssn_codes, ssn2use_original, ''); 
								// (EnableEmergingID and le.h.valid_ssn in Risk_Indicators.iid_constants.EI_set_valid_ssn_codes), ssn2use_original, '');
					
	dt_last1 := MAP(le.h.dt_last_seen<>0 => le.h.dt_last_seen, 
							le.h.dt_vendor_last_reported<>0 and 
							le.h.src != mdr.sourcetools.src_American_Students_List and 
							le.h.src != mdr.sourcetools.src_TUCS_Ptrack and 
							le.h.src != mdr.sourcetools.src_TU_CreditHeader and 
								~le.came_from_fastheader => le.h.dt_vendor_last_reported,  // don't trust vendor dates from Transunion credit header or any FAST Header source
							le.h.dt_first_seen<>0 => le.h.dt_first_seen,
							le.h.src != mdr.sourcetools.src_American_Students_List and 
							le.h.src != mdr.sourcetools.src_TUCS_Ptrack AND
							le.h.src != mdr.sourcetools.src_TU_CreditHeader AND	
							~(le.h.src = mdr.sourcetools.src_Targus_White_pages and le.h.dt_vendor_first_reported = 200602) AND
							 ~le.came_from_fastheader => le.h.dt_vendor_first_reported, // don't trust vendor dates from Transunion credit header or any FAST Header source
							0);
										
	unsigned3 dt_last := if(dt_last1 >= le.historydate, le.historydate, dt_last1);  // in a history mode, set all dates greater than history date equal to history date			
	
	dt_first := MAP(le.h.src = mdr.sourcetools.src_Equifax_Quick or le.h.src = mdr.sourcetools.src_Equifax_Weekly => le.h.dt_first_seen,	// if quick or weekly header then use that first seen
									le.h.dt_first_seen<>0 => le.h.dt_first_seen,
									dt_last <= le.h.dt_vendor_first_reported => dt_last, // make sure the dt_first is <= dt_last
									le.h.src != mdr.sourcetools.src_American_Students_List and 									
									le.h.src != mdr.sourcetools.src_TU_CreditHeader AND
									le.h.src != mdr.sourcetools.src_TUCS_Ptrack  and
									~(le.h.src = mdr.sourcetools.src_Targus_White_pages and le.h.dt_vendor_first_reported = 200602) => le.h.dt_vendor_first_reported, // don't trust vendor dates from Transunion credit header
									0);  
	
	SELF.h := PROJECT(le.h, TRANSFORM(header.Layout_Header, 
								self.dt_last_seen := dt_last, // watchdog.bestaddrfunc uses the .h information, cap the date last in there as well
								SELF := LEFT));		
	
	isrecent := iid_constants.myDaysApart(le.historydate,((STRING6)dt_last + '31'), LastSeenThreshold);
	
	firstmatch_score := Risk_Indicators.FnameScore(le.fname,le.h.fname);
	n1 := NID.PreferredFirstNew(le.fname);
	n2 := NID.PreferredFirstNew(le.h.fname);
	firstmatch1 := iid_constants.g(firstmatch_score) and if(ExactFirstNameRequired, le.fname=le.h.fname, true) and
							  if(ExactFirstNameRequiredAllowNickname, le.fname=le.h.fname or n1=n2, true);
	lastmatch_score := Risk_Indicators.LnameScore(le.lname, le.h.lname);
	lastmatch1 := iid_constants.g(lastmatch_score) and if(ExactLastNameRequired, le.lname=le.h.lname, true);
	
	zip_score1 := Risk_Indicators.AddrScore.zip_score(le.in_zipcode, le.h.zip);
	cityst_score1 := Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, le.h.city_name, le.h.st, le.cityzipflag);
	// addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																						// le.h.prim_range, le.h.prim_name, le.h.sec_range,
																						// zip_score1, cityst_score1);
	addrmatch_score1 := IF(ExactAddrZip5andPrimRange,
												IF(zip_score1=100
													 and Risk_Indicators.AddrScore.primRange_score(le.prim_range, le.h.prim_range)=100,
													 100, 11),
												Risk_Indicators.AddrScore.AddressScore( le.prim_range, le.prim_name, le.sec_range, 
																																le.h.prim_range, le.h.prim_name, le.h.sec_range,
																																zip_score1, cityst_score1));
																						
	addrmatch1 := iid_constants.ga(addrmatch_score1) and if(ExactAddrRequired, le.prim_range=le.h.prim_range and le.prim_name=le.h.prim_name  and 
							(le.in_zipcode=le.h.zip or le.z5=le.h.zip or 
								(le.in_city=le.h.city_name and le.in_state=le.h.st) or (le.p_city_name=le.h.city_name and le.st=le.h.st)) and
							ut.nneq(le.sec_range,le.h.sec_range), true);
							
	hphonematchscore := Risk_Indicators.PhoneScore(le.phone10, le.h.phone);
	hphonematch1 := iid_constants.gn(hphonematchscore) and if(ExactPhoneRequired, le.phone10=le.h.phone, true);
	wphonematchscore := Risk_Indicators.PhoneScore(le.wphone10, le.h.phone);
	wphonematch1 := iid_constants.gn(wphonematchscore) and if(ExactPhoneRequired, le.wphone10=le.h.phone, true);
	socsmatchscore := did_add.ssn_match_score(le.ssn, ssn2use, LENGTH(TRIM(le.ssn))=4);
	socsmatch1 := iid_constants.gn(socsmatchscore) and if(ExactSSNRequired, le.ssn=ssn2use, true);
	cmpymatch := false;
	
	// continue to ignore utility records in the NAS verification.  UtilityRecord can only be set to true in shell versions 50 and higher
	utilityRecord := bsversion>=50 and mdr.Source_is_Utility(le.h.src);
	firstmatch := if(utilityRecord, false, firstmatch1);
	lastmatch := if(utilityRecord, false, lastmatch1);
	addrmatch := if(utilityRecord, false, addrmatch1);
	hphonematch := if(utilityRecord, false, hphonematch1);
	wphonematch := if(utilityRecord, false, wphonematch1);
	socsmatch := if(utilityRecord, false, socsmatch1);			

//KWH - CIV - score just the address (default zip/city/state to 100) to allow for partial input

	CIVaddrmatchscore1 := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																						le.h.prim_range, le.h.prim_name, le.h.sec_range,
																						100, 100);

	CIVaddrmatchscore2 := Risk_Indicators.AddrScore.AddressScore('', '1', '', '', '2', '',
																						100, 100, StringLib.StringToUpperCase(trim(le.in_streetAddress)), Risk_Indicators.MOD_AddressClean.street_address('', le.h.prim_range, le.h.predir, le.h.prim_name, le.h.suffix, le.h.postdir, le.h.unit_desig, le.h.sec_range));

	CIVaddrmatchscore3 := Risk_Indicators.AddrScore.AddressScore('', '1', '', '', '2', '',
																						100, 100, StringLib.StringToUpperCase(trim(le.in_streetAddress)), Risk_Indicators.MOD_AddressClean.street_address('', le.h.prim_range, le.h.predir, le.h.prim_name, le.h.suffix, le.h.postdir, '', ''));
	
	CIVaddrmatchcap1 := iid_constants.tscore(CIVaddrmatchscore1);
	CIVaddrmatchcap2 := iid_constants.tscore(CIVaddrmatchscore2);
	CIVaddrmatchcap3 := iid_constants.tscore(CIVaddrmatchscore3);
	
	CIVaddrmatch := iid_constants.ga(max(CIVaddrmatchcap1, CIVaddrmatchcap2, CIVaddrmatchcap3)) and if(ExactAddrRequired, le.prim_range=le.h.prim_range and le.prim_name=le.h.prim_name  and 
									ut.nneq(le.sec_range,le.h.sec_range), true);
	
	isCurrentOccupant := addrmatch and dt_last >= iid_constants.MonthRollback((string)le.historydate,CURRENT_OCCUPANT_MONTHS);
	isEverOccupant    := addrmatch and ever_start_months - ever_past_months <= ut.Date_YYYYMM_i2(((string)dt_last)[1..6])
											 and ever_start_months >= ut.Date_YYYYMM_i2(((string)dt_first)[1..6]);

	currOccFlag := iid_constants.SetFlag( iid_constants.IIDFlag.CurrentOccupant, isCurrentOccupant );
	everOccFlag := iid_constants.SetFlag( iid_constants.IIDFlag.EverOccupant, isEverOccupant );
	self.iid_flags := currOccFlag + everOccFlag;	
	
	indobpop := length(trim(le.dob))=8;
  le_head_dob := (string) le.h.dob;
	founddobpop := trim(le_head_dob[1..8])<>'0';
	
	// new dob scoring based on input options
	dobmatch_score_fuzzy6 := iid_constants.dobmatch_score_fuzzy6(indobpop, founddobpop, le.dob, (string8)le.h.dob);	// score with dobmatchoption set to FuzzyCCYYMM
	dobmatch_score_radius := iid_constants.dobmatch_score_radius(indobpop, founddobpop, le.dob, (string8)le.h.dob, DOBMatchYearRadius);	// score with dobmatchoption set to RadiusCCYY
	dobmatch_score_exact8 := iid_constants.dobmatch_score_exact8(indobpop, founddobpop, le.dob, (string8)le.h.dob);	// score with dobmatchoption set to ExactCCYYMMDD
	dobmatch_score_exact6 := iid_constants.dobmatch_score_exact6(indobpop, founddobpop, le.dob, (string8)le.h.dob);	// score with dobmatchoption set to ExactCCYYMM

	dobmatch_score1 := IF(indobpop and founddobpop,did_add.ssn_match_score(le.dob[1..8],le_head_dob[1..8]),255);	// per GB, if input dob is less than 8 bytes, don't let it pass
	yyyymm_match := le.dob[1..6]=le_head_dob[1..6];
	dobmatch_score := map(
	  indobpop and le_head_dob in risk_indicators.iid_constants.invalid_dobs => 1,
		DOBMatchOption = 'FUZZYCCYYMM' => dobmatch_score_fuzzy6,
		DOBMatchOption = 'RADIUSCCYY' => dobmatch_score_radius,
		DOBMatchOption = 'EXACTCCYYMMDD' => dobmatch_score_exact8,
		DOBMatchOption = 'EXACTCCYYMM' => dobmatch_score_exact6,
		 '00' = le.dob[5..6]  or '00' = le_head_dob[5..6] => 255, // consider a blank month from input or file to be bad
		 '00' = le.dob[7..8] and '00' = le_head_dob[7..8] => if(yyyymm_match, 95, 12 ), // with both days blank, require an exact match on YYYYMM (override values per TS)
		('00' = le.dob[7..8]  or '00' = le_head_dob[7..8]) and dobmatch_score1=70 => if(yyyymm_match, 96, 94 ),
		dobmatch_score1
	);
	
	dobmatch := iid_constants.g(dobmatch_score) and if(ExactDOBRequired, le.dob[1..8]=le_head_dob[1..8], true);
	
	
	trueDID_original := le.h.did<>0;
	    
  // if the consumer has a statement on file, security alert, legal hold, we need to set the noScore trigger so all attributes and scores get suppressed.
  // for id_theft_flag, don't set the truedid=false because we'll return a real score for that person, just return the alert code of 100G
	self.truedid := if(
  (le.ConsumerFlags.consumer_statement_flag  and bsversion < 50) or  
  le.ConsumerFlags.security_alert or  
  le.ConsumerFlags.legal_hold_alert or  
  (le.ConsumerFlags.id_theft_flag and bsversion < 50) ,
    false, trueDID_original);
    
    
	// FYI, if we add any new sources to this list or modify this mapping, let Jesse Shaw know about it so that he can update KEL attribute IdentityReport.graph
	converted_src := map(
				 utilityRecord => 'U',  // new for shell 5.0.  UtilityRecord will only be set to true in shell versions 50 and higher
				 le.h.src in mdr.sourcetools.set_Experian_dl => 'D',
				 le.h.src in mdr.sourcetools.set_Experian_vehicles => 'V',
	       le.h.src[2] in ['D','V','W'] AND ~(le.h.src IN ['MW','UW'])		=> le.h.src[2],
				 le.h.src IN ['TU','LT']	=> 'TU',
				 le.h.src in ['FC','FS','UC','US','GC','GS','PC','PS','MS','AS'] => 'C',  // Criminal
				 le.h.src IN ['MI','MA'] => 'XX', // won't count these
				 le.h.src IN ['FA', 'FP', 'FB', 'LP', 'LA'] => 'P',	//property source
				 le.h.src IN ['EM','E1','E2','E3','E4'] => 'EM', 
				 le.h.src IN ['QH','WH'] => 'EQ',	// set quickheader to EQ
				 le.h.src = 'AY' => 'SL',	// treat alloy as american student (95059)
				 le.h.src IN MDR.sourceTools.set_Death => 'DE',	// set all the new death sources to DE
				 le.h.src);
				 
	self.src := converted_src;
	
	self.dt_last_seen := dt_last;
	header_dt_first31 := ((string) le.h.dt_first_seen)[1..6]+'31';  // without any vendor dates in the mix
	fsDate31 := dt_first[1..6]+'31';
	lsDate31 := ((string) dt_last)[1..6]+'31';
		
	// adding adl stuff here for BocaShell version 2
	self.ssn_from_did := if(le.historydate=iid_constants.default_history_date and bsversion<41, le.ssn_from_did, le.h.ssn);
	self.ssns_per_adl := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.ssns_per_adl, if(trim(ssn2use) <> '', 1, 0));
	self.ssns_per_adl_created_6months := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.ssns_per_adl_created_6months, 
																					if(trim(ssn2use) <> '' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.sixmonths, le.historydate), 1, 0));
																					
	self.ssns_per_adl_seen_18months := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.ssns_per_adl_seen_18months, 
																					if(trim(ssn2use) <> '' and iid_constants.checkdays(myGetDate,lsDate31,iid_constants.eighteenmonths, le.historydate), 1, 0));
	
	self.dobs_per_adl := if((integer)le.h.dob>0 and le.valid_dob<>'M', 1, 0);
	self.dobs_per_adl_created_6months := if((integer)le.h.dob>0 and le.valid_dob<>'M' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.sixmonths, le.historydate), 1, 0);
																					
	self.addr_from_did := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addr_from_did, trim(le.h.prim_range) + trim(le.h.prim_name));
	self.addrs_per_adl := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addrs_per_adl, if(trim(self.addr_from_did)!='', 1, 0));
	self.addrs_per_adl_created_6months := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addrs_per_adl_created_6months, 
																					if(trim(self.addr_from_did) != '' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.sixmonths, le.historydate), 1, 0));
	
	// adding some boca shell 3 invalid fields
	self.invalid_ssn_from_did := if(le.historydate=Risk_Indicators.iid_constants.default_history_date and bsversion<50, le.invalid_ssn_from_did, ssn2use);
	self.invalid_ssns_per_adl := if(le.historydate=Risk_Indicators.iid_constants.default_history_date and bsversion<50, le.invalid_ssns_per_adl, if(trim(ssn2use) <> '', 1, 0));
	self.invalid_ssns_per_adl_created_6months := if(le.historydate=Risk_Indicators.iid_constants.default_history_date and bsversion<50, le.invalid_ssns_per_adl_created_6months, 
																					if(trim(ssn2use) <> '' and Risk_Indicators.iid_constants.checkdays(myGetDate,header_dt_first31,Risk_Indicators.iid_constants.sixmonths, le.historydate), 1, 0));
	
	self.invalid_addr_from_did := if(le.historydate=Risk_Indicators.iid_constants.default_history_date and bsversion<50, le.invalid_addr_from_did, trim(le.h.prim_range) + trim(le.h.prim_name) + trim(le.h.zip4));
	self.invalid_addrs_per_adl := if(le.historydate=Risk_Indicators.iid_constants.default_history_date and bsversion<50, le.invalid_addrs_per_adl, if(trim(self.invalid_addr_from_did)!='', 1, 0));
	self.invalid_addrs_per_adl_created_6months := if(le.historydate=Risk_Indicators.iid_constants.default_history_date and bsversion<50, le.invalid_addrs_per_adl_created_6months, 
																					if(trim(self.invalid_addr_from_did) != '' and Risk_Indicators.iid_constants.checkdays(myGetDate,header_dt_first31,Risk_Indicators.iid_constants.sixmonths, le.historydate), 1, 0));
	
	self.last_from_did := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.last_from_did, le.h.lname);
	self.lnames_per_adl := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.lnames_per_adl, if(trim(le.h.lname)<>'', 1, 0));
	self.lnames_per_adl30 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.lnames_per_adl30, if(trim(le.h.lname)<>'' and iid_constants.checkdays(myGetDate,header_dt_first31,30, le.historydate), 1, 0));	
	self.lnames_per_adl90 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.lnames_per_adl90, if(trim(le.h.lname)<>'' and iid_constants.checkdays(myGetDate,header_dt_first31,90, le.historydate), 1, 0));
	self.lnames_per_adl180 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.lnames_per_adl180, if(trim(le.h.lname)<>'' and iid_constants.checkdays(myGetDate,header_dt_first31,180, le.historydate), 1, 0));
	self.lnames_per_adl12 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.lnames_per_adl12, if(trim(le.h.lname)<>'' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.oneyear, le.historydate), 1, 0));
	self.lnames_per_adl24 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.lnames_per_adl24, if(trim(le.h.lname)<>'' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.twoyears, le.historydate), 1, 0));
	self.lnames_per_adl36 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.lnames_per_adl36, if(trim(le.h.lname)<>'' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.threeyears, le.historydate), 1, 0));
	self.lnames_per_adl60 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.lnames_per_adl60, if(trim(le.h.lname)<>'' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.fiveyears, le.historydate), 1, 0));
	self.newest_lname_dt_first_seen := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.newest_lname_dt_first_seen, if(trim(le.h.lname)<>'', dt_last, 0));
	
	self.addrs_last30 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addrs_last30, if(trim(self.addr_from_did) != '' and iid_constants.checkdays(myGetDate,header_dt_first31,30, le.historydate), 1, 0));
	self.addrs_last90 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addrs_last90, if(trim(self.addr_from_did) != '' and iid_constants.checkdays(myGetDate,header_dt_first31,90, le.historydate), 1, 0));
	self.addrs_last12 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addrs_last12, if(trim(self.addr_from_did) != '' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.oneyear, le.historydate), 1, 0));
	self.addrs_last24 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addrs_last24, if(trim(self.addr_from_did) != '' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.twoyears, le.historydate), 1, 0));
	self.addrs_last36 := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addrs_last36, if(trim(self.addr_from_did) != '' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.threeyears, le.historydate), 1, 0));
	self.addrs_last_5years := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addrs_last_5years, if(trim(self.addr_from_did) != '' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.fiveyears, le.historydate), 1, 0));
	self.addrs_last_10years := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addrs_last_10years, if(trim(self.addr_from_did) != '' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.tenyears, le.historydate), 1, 0));
	self.addrs_last_15years := if(le.historydate=iid_constants.default_history_date and bsversion<50, le.addrs_last_15years, if(trim(self.addr_from_did) != '' and iid_constants.checkdays(myGetDate,header_dt_first31,iid_constants.fifteenyears, le.historydate), 1, 0));
					 
	self.firstcount := IF(firstmatch,1,0);
	self.lastcount := IF(lastmatch,1,0);
	self.addrcount := IF(isrecent and addrmatch,1,0);
	self.socscount := IF(socsmatch,1,0);
	self.hphonecount := IF(hphonematch,1,0);
	self.wphonecount := IF(wphonematch,1,0);
	self.cmpycount := IF(cmpymatch,1,0);
	self.dobcount := IF(dobmatch,1,0);
	
// new shell 4.0 fields
	self.hdr_dt_first_seen := le.h.dt_first_seen;
	self.hdr_dt_last_seen := if(le.h.dt_last_seen >= le.historydate, le.historydate, le.h.dt_last_seen);  // in a history mode, set all dates greater than history date equal to history date;
	self.dobcount2 := if(le.h.src = mdr.sourcetools.src_Equifax_Quick or le.h.src = mdr.sourcetools.src_Equifax_Weekly, if(dobmatch,1,0), IF(dobmatch and le.valid_dob<>'M',1,0));  // new field to only return dob match on non-manufactured DOB records
//

	self.eqfsfirstcount := (firstmatch and self.src = 'EQ');
	self.eqfslastcount := (lastmatch and self.src = 'EQ');
	self.eqfsaddrcount := (isrecent and addrmatch and self.src = 'EQ');
	self.eqfssocscount := (socsmatch and self.src = 'EQ');

	self.tufirstcount := (firstmatch and self.src ='TU');
	self.tulastcount := (lastmatch and self.src ='TU');
	self.tuaddrcount := (isrecent and addrmatch and self.src ='TU');
	self.tusocscount := (socsmatch and self.src ='TU');

	self.dlfirstcount := (firstmatch and self.src = 'D');
	self.dllastcount := (lastmatch and self.src = 'D');
	self.dladdrcount := (isrecent and addrmatch and self.src = 'D');
	self.dlsocscount := (socsmatch and self.src = 'D');

	self.emfirstcount := (firstmatch and (self.src = 'EM' or self.src = 'VO'));
	self.emlastcount := (lastmatch and (self.src = 'EM' or self.src = 'VO'));
	self.emaddrcount := (isrecent and addrmatch and (self.src = 'EM' or self.src = 'VO'));
	self.emsocscount := (socsmatch and (self.src = 'EM' or self.src = 'VO'));

	self.bkfirstcount := (firstmatch and self.src = 'BA');
	self.bklastcount := (lastmatch and self.src = 'BA');
	self.bkaddrcount := (isrecent and addrmatch and self.src = 'BA');
	self.bksocscount := (socsmatch and self.src = 'BA');

	SELF.adl_eqfs_first_seen := IF(self.src='EQ',dt_first, 0); 
	SELF.adl_eqfs_last_seen := IF(self.src='EQ',dt_last, 0);
	
	SELF.adl_EN_first_seen := IF(self.src='EN',dt_first, 0); 
	SELF.adl_EN_last_seen := IF(self.src='EN',dt_last, 0);
	
	// add other sources like equifax for BocaShell version 2, EN for bs 3
	self.EQ_count := if(self.src='EQ', 1, 0);
	self.EN_count := if(self.src='EN', 1, 0);
	self.TU_count := if(self.src='TU', 1, 0);
	self.DL_count := if(self.src='D', 1, 0);
	self.PR_count := if(self.src='P', 1, 0);
	self.V_count := if(self.src='V', 1, 0);
	self.EM_count := if(self.src='EM' or self.src='VO', 1, 0);
	self.W_count := if(self.src='W', 1, 0);
	self.VO_count := if(self.src='VO', 1, 0);	// add counting of VO here for bs 3.0
	self.EM_only_count := if(le.h.src IN ['EM','E1','E2','E3','E4'], 1, 0);	// add counting of EM only here for bs 3.0
	
	self.adl_TU_first_seen := if(self.src='TU', dt_first, 0);
	self.adl_TU_last_seen := if(self.src='TU', dt_last, 0);
	self.adl_DL_first_seen := if(self.src='D', dt_first, 0);
	self.adl_DL_last_seen := if(self.src='D', dt_last, 0);
	self.adl_PR_first_seen := if(self.src='P', dt_first, 0);
	self.adl_PR_last_seen := if(self.src='P', dt_last, 0);
	self.adl_V_first_seen := if(self.src='V', dt_first, 0);
	self.adl_V_last_seen := if(self.src='V', dt_last, 0);
	self.adl_EM_first_seen := if(self.src='EM' or self.src='VO', dt_first, 0);
	self.adl_EM_last_seen := if(self.src='EM' or self.src='VO', dt_last, 0);
	self.adl_W_first_seen := if(self.src='W', dt_first, 0);
	self.adl_W_last_seen := if(self.src='W', dt_last, 0);
	self.adl_VO_first_seen := if(self.src='VO', dt_first, 0);	// add for bs 3.0
	self.adl_VO_last_seen := if(self.src='VO', dt_last, 0);	// add for bs 3.0
	self.adl_EM_only_first_seen := if(le.h.src IN ['EM','E1','E2','E3','E4'], dt_first, 0);	// add for bs 3.0
	self.adl_EM_only_last_seen := if(le.h.src IN ['EM','E1','E2','E3','E4'], dt_last, 0);	// add for bs 3.0
	
	
	self.dl_addrs_per_adl := IF(le.historydate=Risk_Indicators.iid_constants.default_history_date and bsversion<50, le.dl_addrs_per_adl, if(self.src='D', 1, 0));	// if realtime, use the bocashell adl result
	self.vo_addrs_per_adl := IF(le.historydate=Risk_Indicators.iid_constants.default_history_date and bsversion<50, le.vo_addrs_per_adl, if(self.src='VO', 1, 0));
	self.pl_addrs_per_adl := IF(le.historydate=Risk_Indicators.iid_constants.default_history_date and bsversion<50, le.pl_addrs_per_adl, if(self.src='PL', 1, 0));
	
	SELF.adl_other_first_seen := IF(self.src not in ['EQ','EN'],dt_first, 0);
	SELF.adl_other_last_seen := IF(self.src not in ['EQ','EN'],dt_last, 0);

	SELF.chrono_sources := if(le.h.src IN ['EM','E1','E2','E3','E4'], trim(le.h.src)+',',SELF.src+',');
	SELF.chrono_addrcount := if(SELF.src<>'',1, 0);	
	SELF.chrono_eqfsaddrcount := if(SELF.src='EQ',1,0);
	SELF.chrono_dladdrcount := if(SELF.src='D',1,0);
	SELF.chrono_emaddrcount := if(SELF.src='EM' or SELF.src='VO',1,0);

	self.chronofirst := le.h.fname;
	self.chronolast := le.h.lname;
	self.chronoprim_range := le.h.prim_range;
	self.chronopredir := le.h.predir;
	self.chronoprim_name := le.h.prim_name;
	self.chronosuffix := le.h.suffix;
	self.chronopostdir := le.h.postdir;
	self.chronounit_desig := le.h.unit_desig;
	self.chronosec_range := le.h.sec_range;
	self.chronocity := le.h.city_name;
	self.chronostate := le.h.st;
	self.chronozip := le.h.zip;
	self.chronozip4 := le.h.zip4;
	self.chronocounty := le.h.county;
	self.chronogeo_blk := le.h.geo_blk;
	self.chronodate_first := dt_first;
	self.chronodate_last := dt_last;
	self.chronoaddrscore := addrmatch_score1;
	
	// these flags will keep track of corrections made to them, if populated, that means we need to use this value
	self.chrono_addr_flags.dwelltype := le.addr_flags.dwelltype;
	self.chrono_addr_flags.valid := le.addr_flags.valid;
	self.chrono_addr_flags.prisonAddr := le.addr_flags.prisonAddr;
	self.chrono_addr_flags.highRisk := le.addr_flags.highRisk;
	self.chrono_addr_flags.corpMil := le.addr_flags.corpMil;
	self.chrono_addr_flags.doNotDeliver := le.addr_flags.doNotDeliver;
	self.chrono_addr_flags.deliveryStatus := le.addr_flags.deliveryStatus;
	self.chrono_addr_flags.addressType := le.addr_flags.addressType;
	self.chrono_addr_flags.dropIndicator := le.addr_flags.dropIndicator;
	
	// look for soc matches, preferring valid='G' in the rollup below
	self.socsscore := socsmatchscore;
	self.versocs := ssn2use;
	self.socsvalid := le.h.valid_ssn;
	
	// if input social is 4 bytes then use full social from header if last4 match
	ssnLength := length(trim(le.ssn));
	self.ssn := if(ssnLength = 4 and socsmatch, ssn2use, le.ssn);
	self.ssnLookupFlag := map(ssnLength=4 and socsmatch => 1,
														ssnLength=4 and ~socsmatch => 0,
														-1);
	
	// try recent addresses
	self.addrscore := IF(isrecent,addrmatch_score1,255);
	self.citystatescore := IF(isrecent,cityst_score1,255);
	self.zipscore := IF(isrecent,zip_score1,255);
	
	self.addrmultiple := false;
	
	self.verprim_range := IF(isrecent,le.h.prim_range,'');
	self.verpredir := IF(isrecent,le.h.predir,'');
	self.verprim_name := IF(isrecent,le.h.prim_name,'');
	self.versuffix := IF(isrecent,le.h.suffix,'');
	self.verpostdir := IF(isrecent,le.h.postdir,'');
	self.verunit_desig := IF(isrecent,le.h.unit_desig,'');
	self.versec_range := IF(isrecent,le.h.sec_range,'');
	self.vercity := IF(isrecent, le.h.city_name, '');
	self.verstate := IF(isrecent, le.h.st, '');
	self.verzip := IF(isrecent, le.h.zip+le.h.zip4, '');
	self.vercounty := IF(isrecent, le.h.county, '');
	self.vergeo_blk := IF(isrecent, le.h.geo_blk, '');
	SELF.verdate_last := IF(isrecent, dt_last, 0);
	SELF.verdate_first := IF(isrecent, dt_first, 0);
	
	self.lastscore := lastmatch_score;
	self.verlast := le.h.lname;

	self.firstscore := firstmatch_score;
	self.verfirst := le.h.fname;
	
	self.dobscore := dobmatch_score;
	self.verdob := (STRING)le.h.dob;
	
	self.hphonescore := hphonematchscore;
	self.verhphone := le.h.phone;
	
	self.wphonescore := wphonematchscore;
	self.verwphone := '';//le.h.phone; 

	SELF.sources := SELF.src+',';	
	SELF.firstnamesources := IF(SELF.firstcount=0,le.firstnamesources,SELF.src+',');
	SELF.lastnamesources := IF(SELF.lastcount=0,le.lastnamesources,SELF.src+',');
	SELF.addrsources := IF(SELF.addrcount=0,le.addrsources,SELF.src+',');
	SELF.socssources := IF(SELF.socscount=0,le.socssources,SELF.src+',');
	SELF.numsource := 1;
	
	self.em_only_sources := if(le.h.src IN ['EM','E1','E2','E3','E4'], le.h.src+',', le.em_only_sources);	// if source is lumped into EM, show the real source here
	
	self.hphonesources := IF(SELF.hphonecount=0,le.hphonesources,SELF.src+',');
	self.wphonesources := IF(SELF.wphonecount=0,le.wphonesources,SELF.src+',');
	self.dobsources := IF(SELF.dobcount=0,le.dobsources,SELF.src+',');
	self.cmpysources := IF(SELF.cmpycount=0,le.cmpysources,SELF.src+',');
	
	// new for 5.0, creating nonderog categories
	isLicense := le.h.src in [MDR.sourceTools.src_Professional_License, MDR.sourceTools.src_Federal_Explosives,MDR.sourceTools.src_Federal_Firearms, MDR.sourceTools.src_DEA, 
												MDR.sourceTools.src_AK_Perm_Fund, MDR.sourceTools.src_AK_Fishing_boats, MDR.sourceTools.src_EMerge_CCW, MDR.sourceTools.src_EMerge_Fish, MDR.sourceTools.src_EMerge_Hunt,													
												mdr.sourcetools.src_CT_DL,mdr.sourcetools.src_FL_DL,mdr.sourcetools.src_IA_DL,mdr.sourcetools.src_ID_DL,mdr.sourcetools.src_KY_DL,mdr.sourcetools.src_MA_DL,
												mdr.sourcetools.src_ME_DL,mdr.sourcetools.src_MI_DL,mdr.sourcetools.src_MN_DL,mdr.sourcetools.src_MO_DL,mdr.sourcetools.src_NM_DL,mdr.sourcetools.src_NV_DL,
												mdr.sourcetools.src_LA_DL,mdr.sourcetools.src_OH_DL,mdr.sourcetools.src_OR_DL,mdr.sourcetools.src_TN_DL,mdr.sourcetools.src_TX_DL,mdr.sourcetools.src_UT_DL,
												mdr.sourcetools.src_WI_DL,mdr.sourcetools.src_WV_DL,mdr.sourcetools.src_WY_DL,
												mdr.sourcetools.src_Certegy, 
												// including experian DLs for when they eventually decide to include experian dl and vehicle header data
												mdr.sourcetools.src_CO_Experian_DL,mdr.sourcetools.src_DE_Experian_DL,mdr.sourcetools.src_ID_Experian_DL,mdr.sourcetools.src_IL_Experian_DL,
												mdr.sourcetools.src_KY_Experian_DL,mdr.sourcetools.src_LA_Experian_DL,mdr.sourcetools.src_MD_Experian_DL,mdr.sourcetools.src_MS_Experian_DL,
												mdr.sourcetools.src_ND_Experian_DL,mdr.sourcetools.src_NH_Experian_DL,mdr.sourcetools.src_SC_Experian_DL,mdr.sourcetools.src_WV_Experian_DL							
												];
	isProperty := le.h.src in [MDR.sourceTools.src_LnPropV2_Lexis_Asrs, MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs,
												MDR.sourceTools.src_LnPropV2_Fares_Asrs, MDR.sourceTools.src_LnPropV2_Fares_Deeds, MDR.sourceTools.src_Fares_Deeds_from_Asrs];													
	isPersonalProperty := le.h.src in [MDR.sourceTools.src_EMerge_Boat, MDR.sourceTools.src_Aircrafts, MDR.sourceTools.src_Airmen, 
												MDR.sourceTools.src_US_Coastguard,MDR.sourceTools.src_AK_Watercraft,MDR.sourceTools.src_AL_Watercraft,MDR.sourceTools.src_AR_Watercraft,
												MDR.sourceTools.src_AZ_Watercraft,MDR.sourceTools.src_CO_Watercraft,MDR.sourceTools.src_CT_Watercraft,MDR.sourceTools.src_FL_Watercraft,MDR.sourceTools.src_GA_Watercraft,
												MDR.sourceTools.src_IA_Watercraft,MDR.sourceTools.src_IL_Watercraft,MDR.sourceTools.src_KS_Watercraft,MDR.sourceTools.src_KY_Watercraft,MDR.sourceTools.src_MA_Watercraft,
												MDR.sourceTools.src_MD_Watercraft,MDR.sourceTools.src_ME_Watercraft,MDR.sourceTools.src_MI_Watercraft,MDR.sourceTools.src_MN_Watercraft,MDR.sourceTools.src_MO_Watercraft,
												MDR.sourceTools.src_MS_Watercraft,MDR.sourceTools.src_MT_Watercraft,MDR.sourceTools.src_NC_Watercraft,MDR.sourceTools.src_ND_Watercraft,MDR.sourceTools.src_NE_Watercraft,
												MDR.sourceTools.src_NH_Watercraft,MDR.sourceTools.src_NV_Watercraft,MDR.sourceTools.src_NY_Watercraft,MDR.sourceTools.src_OH_Watercraft,MDR.sourceTools.src_OR_Watercraft,
												MDR.sourceTools.src_SC_Watercraft,MDR.sourceTools.src_TN_Watercraft,MDR.sourceTools.src_TX_Watercraft,MDR.sourceTools.src_UT_Watercraft,MDR.sourceTools.src_VA_Watercraft,
												MDR.sourceTools.src_WI_Watercraft,MDR.sourceTools.src_WV_Watercraft,MDR.sourceTools.src_WY_Watercraft] + MDR.sourceTools.set_Vehicles;
	isCollege := le.h.src in [MDR.sourceTools.src_American_Students_List, MDR.sourceTools.src_AlloyMedia_student_list];
	isVoter := le.h.src in [MDR.sourceTools.src_Voters_v2];
	isBureau := le.h.src in [MDR.sourceTools.src_Equifax, MDR.sourceTools.src_Equifax_Weekly, MDR.sourceTools.src_Equifax_Quick, 
												MDR.sourceTools.src_Experian_Credit_Header,MDR.sourceTools.src_TU_CreditHeader];  
	non_derog_category := map(isLicense 					=> 1, // Licenses
														isProperty 					=> 2, // Property
														isPersonalProperty	=> 3, // Personal Property
														isCollege 					=> 4, // College
														isVoter 						=> 5, // Voter
														isBureau	 					=> 6, // Credit Bureau
	0); // not one of the sources in the requirements document, exclude it from the counts
		
	// re-purpose header_summary.ver_sources to store the non_derog_category until iid_roll_header
	self.header_summary.ver_sources := (string)non_derog_category;

	// locking down non-derog sources
	derog_source := converted_src IN ['C','BA','LI','L2','FR'];
	nonderog_source_41 := (isFCRA and (le.h.src in MDR.sourceTools.set_NonDerog_FCRA_sources)) or 
										 (not isFCRA and not derog_source and trim(le.h.src)<>'');
	nonderog_source_50 := non_derog_category > 0;
	nonderog_source := if(bsversion>=50, nonderog_source_50, nonderog_source_41);	
	self.num_nonderogs := if(nonderog_source, 1, 0);	
	
	realtimeMode := le.historydate=iid_constants.default_history_date or le.historydate = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..6]);
	
	// per bug 156790, cap the history date at the hdrBuildDate
	nonderogs_mygetdate := if(myGetDate > hdrBuilddate01, hdrBuildDate01, myGetDate);

	// in realtime, check to see if date last seen is in future of build date
	non_derog_still_updating := if(realtimeMode, lsDate31 >= hdrBuildDate01, lsDate31 >= nonderogs_mygetdate);	
	
	
	// for nonderogs30 realtimeMode, hdrBuildDate will be the first of the build month and the lsDate31 will be the end of the same month if we want
	// want to count it, so only need to check if the lsDate31 is in the future of the hdrBuildDate01
	self.num_nonderogs30 := if(realtimeMode, 
									if(nonderog_source and non_derog_still_updating, 1, 0),
									if(nonderog_source and (iid_constants.checkdays(nonderogs_mygetdate,lsDate31,30, le.historydate) or non_derog_still_updating), 1, 0));
	self.num_nonderogs90 := if(realtimeMode,
									if(nonderog_source and (iid_constants.checkdays(hdrBuildDate01,lsDate31,60, le.historydate) or non_derog_still_updating), 1, 0),
									if(nonderog_source and (iid_constants.checkdays(nonderogs_mygetdate,lsDate31,90, le.historydate) or non_derog_still_updating), 1, 0));
	self.num_nonderogs180 := if(realtimeMode,
									if(nonderog_source and (iid_constants.checkdays(hdrBuildDate01,lsDate31,iid_constants.fiveMonths, le.historydate) or non_derog_still_updating), 1, 0),
									if(nonderog_source and (iid_constants.checkdays(nonderogs_mygetdate,lsDate31,180, le.historydate) or non_derog_still_updating), 1, 0));
	self.num_nonderogs12 := if(realtimeMode,
									if(nonderog_source and (iid_constants.checkdays(hdrBuildDate01,lsDate31,iid_constants.elevenMonths, le.historydate) or non_derog_still_updating), 1, 0),
									if(nonderog_source and (iid_constants.checkdays(nonderogs_mygetdate,lsDate31,iid_constants.oneyear, le.historydate) or non_derog_still_updating), 1, 0));
	self.num_nonderogs24 := if(realtimeMode,
									if(nonderog_source and (iid_constants.checkdays(hdrBuildDate01,lsDate31,iid_constants.twentythreeMonths, le.historydate) or non_derog_still_updating), 1, 0),
									if(nonderog_source and (iid_constants.checkdays(nonderogs_mygetdate,lsDate31,iid_constants.twoyears, le.historydate) or non_derog_still_updating), 1, 0));
	self.num_nonderogs36 := if(realtimeMode,
									if(nonderog_source and (iid_constants.checkdays(hdrBuildDate01,lsDate31,iid_constants.thirtyfiveMonths, le.historydate) or non_derog_still_updating), 1, 0),
									if(nonderog_source and (iid_constants.checkdays(nonderogs_mygetdate,lsDate31,iid_constants.threeyears, le.historydate) or non_derog_still_updating), 1, 0));
	self.num_nonderogs60 := if(realtimeMode,
									if(nonderog_source and (iid_constants.checkdays(hdrBuildDate01,lsDate31,iid_constants.fiftynineMonths, le.historydate) or non_derog_still_updating), 1, 0),
									if(nonderog_source and (iid_constants.checkdays(nonderogs_mygetdate,lsDate31,iid_constants.fiveyears, le.historydate) or non_derog_still_updating), 1, 0));
									
	// apply the dwelltype correction here since we have that field already
	correctedDwellType := if(trim(le.newDwellType)<>'', le.newDwellType, le.addr_type);
	self.addr_type := correctedDwellType;
	self.dwelltype := iid_constants.dwelltype(correctedDwellType);
	
	// apply the valid correction here since we have that field already
	self.addrvalflag := IF(trim(le.in_streetAddress)<>'' and trim(le.newValid)<>'',if(le.newValid in ['Y','1'],'V','N'),le.addrvalflag);	

	// KWH - CIV - set new Core Identity Verification fields
	
	self.NameStreetAddressMatch := map(le.DIDcount <> 1													=> 0,
																		 le.in_streetaddress= ''									=> 1,
																		 CIVaddrmatch															=> 2,
																		 not CIVaddrmatch													=> 3,
																																								 0);
																												 
	self.NameCityStateMatch := map(le.DIDcount <> 1																																																													=> 0,
																 le.in_city = '' or le.in_state = ''																																																			=> 1,
																 StringLib.StringToUpperCase(trim(le.in_city)) = trim(le.h.city_name) and StringLib.StringToUpperCase(trim(le.in_state)) = trim(le.h.st)	=> 2,
																 StringLib.StringToUpperCase(trim(le.in_city)) <> trim(le.h.city_name) or StringLib.StringToUpperCase(trim(le.in_state)) <> trim(le.h.st)	=> 3,
																																																																																						 0);
																																																									 
	self.NameZipMatch := map(le.DIDcount <> 1						=> 0,
													 le.in_zipcode = ''					=> 1,
													 le.in_zipcode = le.h.zip		=> 2,
													 le.in_zipcode <> le.h.zip	=> 3,
																												 0);
																												 
	self.SSN5FullNameMatch := map(le.DIDcount <> 1								=> 0,
																le.ssn[1..5] = ''								=> 1,
																le.ssn[1..5] = le.h.ssn[1..5] 
																  and firstmatch and lastmatch	=> 2,
																le.ssn[1..5] <> le.h.ssn[1..5]
																  or not firstmatch
																	or not lastmatch							=> 3,
																																	 0);
	self := le;
end;
tranHeader := project(header_recs, getHeader(LEFT));



// search ADL record history for match to prison address for bs 3.0
prison_key := if(isFCRA, risk_indicators.key_HRI_Address_To_SIC_filtered_FCRA, risk_indicators.key_HRI_Address_To_SIC);

Risk_Indicators.iid_constants.layout_outx getPrison(tranHeader le, prison_key ri) := transform
	self.isPrison := if(trim(le.chrono_addr_flags.prisonAddr)<>'', (boolean)le.chrono_addr_flags.prisonAddr, ri.sic_code='2225');
	self.prisonFSdate := if(trim(le.chrono_addr_flags.prisonAddr)='1', le.chronodate_first, if(ri.sic_code='2225', le.chronodate_first, 0));	// use the dt_first calculated date from above transform	
	self := le;
end;

prison1_roxie := join(tranHeader, prison_key,
															trim(left.chronozip)!='' and trim(left.chronoprim_name)!='' and
															keyed(left.chronozip=right.z5) and keyed(left.chronoprim_name=right.prim_name) and keyed(left.chronosuffix=right.suffix) and 
															keyed(left.chronopredir=right.predir) and keyed(left.chronopostdir=right.postdir) and keyed(left.chronoprim_range=right.prim_range) and 
															keyed(left.chronosec_range=right.sec_range) AND 
															// check date
															right.dt_first_seen < left.historydate AND
															right.sic_code='2225',
															getPrison(left,right),left outer,
															ATMOST(keyed(left.chronozip=right.z5) and keyed(left.chronoprim_name=right.prim_name) and keyed(left.chronosuffix=right.suffix) and
																	keyed(left.chronopredir=right.predir) and keyed(left.chronopostdir=right.postdir) and keyed(left.chronoprim_range=right.prim_range) and
																	keyed(left.chronosec_range=right.sec_range), RiskWise.max_atmost), keep(1));

prison1_thor_withAddr := join(distribute(tranHeader(trim(chronozip)!='' and trim(chronoprim_name)!=''), hash64(chronozip, chronoprim_name,chronosec_range)), 
										 distribute(pull(prison_key(trim(z5)!='' and trim(prim_name)!='' and (sic_code='2225'))), hash64(z5, prim_name, sec_range)),
															(left.chronozip=right.z5) and (left.chronoprim_name=right.prim_name) and (left.chronosuffix=right.suffix) and 
															(left.chronopredir=right.predir) and (left.chronopostdir=right.postdir) and (left.chronoprim_range=right.prim_range) and 
															(left.chronosec_range=right.sec_range) AND 
															// check date
															right.dt_first_seen < left.historydate,
															getPrison(left,right),left outer,
															ATMOST((left.chronozip=right.z5) and (left.chronoprim_name=right.prim_name) and (left.chronosuffix=right.suffix) and
																	(left.chronopredir=right.predir) and (left.chronopostdir=right.postdir) and (left.chronoprim_range=right.prim_range) and
																	(left.chronosec_range=right.sec_range), RiskWise.max_atmost), keep(1), LOCAL);										

prison1_thor := prison1_thor_withAddr + tranHeader(trim(chronozip)='' or trim(chronoprim_name)='');

#IF(onThor)
	prison1 := group(sort(distribute(prison1_thor, hash64(seq)), seq, did, local), seq, did);
#ELSE
	prison1 := group(sort(prison1_roxie, seq,did), seq, did);
#END

prison := if(BSversion>2, prison1, tranHeader);

//=================================================================
//================= CORRECTIONS (fcra only) =======================
//=================================================================
// resu (grouped by seq) - dids and (optional?) ssn from didville.MAC_DidAppend
// Get all relevant corrections
layout_corr := 
RECORD
	unsigned4 seq;
	fcra.layout_override_pii;
END;

layout_corr get_corr_by_did(g_inrec le, FCRA.Key_FCRA_Override_pii_DID ri)  := TRANSFORM
	SELF.seq := le.seq; 
	SELF := ri
END;

corr_by_did_roxie := JOIN (g_inrec, FCRA.Key_FCRA_Override_pii_DID,
                     (Left.did != 0) AND
                     keyed (Left.did = Right.s_did), get_corr_by_did(LEFT,RIGHT), atmost(riskwise.max_atmost));

corr_by_did_thor := group(sort(JOIN (distribute(g_inrec(did!=0), hash64(did)), 
													distribute(pull(FCRA.Key_FCRA_Override_pii_DID(s_did!=0)), hash64(s_did)),
                     (Left.did = Right.s_did), get_corr_by_did(LEFT,RIGHT), atmost(riskwise.max_atmost), LOCAL), seq, did), seq, did);

#IF(onThor)
	corr_by_did := corr_by_did_thor;
#ELSE
	corr_by_did := corr_by_did_roxie;
#END

layout_corr get_corr_by_ssn(g_inrec le, FCRA.Key_FCRA_Override_pii_SSN ri) := TRANSFORM
	SELF.did := INTFORMAT(le.did,12,0); // Set DID to LEFT record so that we will pick these up later

	SELF.seq := le.seq; 
	SELF := ri;
END;

corr_by_ssn_roxie := JOIN (g_inrec, FCRA.Key_FCRA_Override_pii_SSN,
                     (Left.ssn != '') AND
                     keyed (Left.ssn = Right.ssn) AND
                     datalib.NameMatch (Left.fname,  Left.mname,  Left.lname, 
                                        Right.fname, Right.mname, Right.lname) < 3,
                    get_corr_by_ssn(LEFT,RIGHT), atmost(riskwise.max_atmost));

corr_by_ssn_thor := group(sort(JOIN (distribute(g_inrec(ssn!=''), hash64(ssn)), 
												 distribute(pull(FCRA.Key_FCRA_Override_pii_SSN(ssn!='')), hash64(ssn)),
                     (Left.ssn = Right.ssn) AND
                     datalib.NameMatch (Left.fname,  Left.mname,  Left.lname, 
                                        Right.fname, Right.mname, Right.lname) < 3,
                    get_corr_by_ssn(LEFT,RIGHT), atmost(left.ssn=right.ssn, riskwise.max_atmost), LOCAL), seq, did), seq, did);

#IF(onThor)
	corr_by_ssn := corr_by_ssn_thor;
#ELSE
	corr_by_ssn := corr_by_ssn_roxie;
#END

all_corrections1 := DEDUP (corr_by_did + corr_by_ssn, ALL);

all_corrections := group(sort(all_corrections1, seq), seq, did);	// could have multiple DID per seq, does this need to be done?

// What we're doing here (j_pre - join with real header - already exists):
// a) transform corrections to layout_header, fake_header dataset.
// b) combine allheader wiht fake_header (ungrouping/grouping where required)

// Get correction part of the output
// first transform coorections to layout_header:
Layout_Header_seq :=
RECORD
	unsigned4 seq;
	header.Layout_Header;
END;

Layout_Header_seq TransformToHeader (layout_corr L) := TRANSFORM
  SELF.did := (unsigned6) L.did;
  SELF.rid := 0;
  SELF.src := 'CO';
  SELF.dt_first_seen := (unsigned3) (L.dt_first_seen [1..6]);
  SELF.dt_last_seen := (unsigned3) (L.dt_last_seen [1..6]);
  SELF.dob := (integer4) L.dob;
	SELF.Valid_SSN := 'G'; // G - we believe it to be correct for that person

  SELF := L;
  SELF := [];
END;
fake_header := PROJECT (all_corrections, TransformToHeader (Left));

//create "fake" header recs
iid_constants.layout_outx GetFakeHeaderRecords (Risk_Indicators.layout_output le, Layout_Header_seq ri) := TRANSFORM
	self.header_summary.header_build_date := header_build_date;

	SELF.header_footprint := 1;
	SELF.h := ri;
	
	myGetDate := iid_constants.myGetDate(le.historydate);	// full history date
	myDaysApart(string8 d1, string8 d2) := ut.DaysApart(d1,d2) <= LastSeenThreshold OR (unsigned)d2 >= (unsigned)myGetDate;

	EverOccupantStartDateTemp := (unsigned3) ((string)EverOccupant_StartDate)[1..6];
	ever_start_date   := iid_constants.MyGetDate( EverOccupantStartDateTemp )[1..6];
	ever_start_months := ut.Date_YYYYMM_i2(ever_start_date);
	ever_past_months  := if(EverOccupant_PastMonths > 0, EverOccupant_PastMonths, ut.Date_YYYYMM_i2(ever_start_date));
	CURRENT_OCCUPANT_MONTHS := 4; // from today, how many months back we'll consider someone a 'current' resident

	ssn2use := ri.ssn;

 	dt := (unsigned3) ( ((string)risk_indicators.iid_constants.todaydate)[1..6]); // by definition, corrects are current
	isrecent := true; // see above
	
	firstmatch_score := Risk_Indicators.FnameScore(le.fname,ri.fname);
	n1 := NID.PreferredFirstNew(le.fname);
	n2 := NID.PreferredFirstNew(ri.fname);
	firstmatch := iid_constants.g(firstmatch_score) and if(ExactFirstNameRequired, le.fname=ri.fname, true) and
							  if(ExactFirstNameRequiredAllowNickname, le.fname=ri.fname or n1=n2, true);
	lastmatch_score := Risk_Indicators.LnameScore(le.lname, ri.lname);
	lastmatch := iid_constants.g(lastmatch_score) and if(ExactLastNameRequired, le.lname=ri.lname, true);
	
	zip_score2 := Risk_Indicators.AddrScore.zip_score(le.in_zipcode, ri.zip);
	cityst_score2 := Risk_Indicators.AddrScore.citystate_score(le.in_city, le.in_state, ri.city_name, ri.st, le.cityzipflag);
	// addrmatch_score2 := Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, 
																						// ri.prim_range, ri.prim_name, ri.sec_range,
																						// zip_score2, cityst_score2);
	addrmatch_score2 := IF(ExactAddrZip5andPrimRange,
												IF(zip_score2=100
													 and Risk_Indicators.AddrScore.primRange_score(le.prim_range, ri.prim_range)=100,
													 100, 11),
												Risk_Indicators.AddrScore.AddressScore( le.prim_range, le.prim_name, le.sec_range, 
																																ri.prim_range, ri.prim_name, ri.sec_range,
																																zip_score2, cityst_score2));
																						
	addrmatch := iid_constants.ga(addrmatch_score2) and if(ExactAddrRequired, le.prim_range=ri.prim_range and le.prim_name=ri.prim_name  and 
																																					(le.in_zipcode=ri.zip or le.z5=ri.zip or 
																																						(le.in_city=ri.city_name and le.in_state=ri.st) or (le.p_city_name=ri.city_name and le.st=ri.st)) and
																																					ut.nneq(le.sec_range,ri.sec_range), true);

	isCurrentOccupant := addrmatch and ri.dt_last_seen >= iid_constants.MonthRollback((string)le.historydate,CURRENT_OCCUPANT_MONTHS);
	isEverOccupant    := addrmatch and ever_start_months - ever_past_months <= ut.Date_YYYYMM_i2((string6)ri.dt_last_seen)
		and ever_start_months >= ut.Date_YYYYMM_i2((string6)ri.dt_first_seen);


	currOccFlag := iid_constants.SetFlag( iid_constants.IIDFlag.CurrentOccupant, isCurrentOccupant );
	everOccFlag := iid_constants.SetFlag( iid_constants.IIDFlag.EverOccupant, isEverOccupant );
	self.iid_flags := currOccFlag + everOccFlag;




	hphonematchscore := Risk_Indicators.PhoneScore(le.phone10, ri.phone);
	hphonematch := iid_constants.gn(hphonematchscore) and if(ExactPhoneRequired, le.phone10=ri.phone, true);
	wphonematchscore := Risk_Indicators.PhoneScore(le.wphone10, ri.phone);
	wphonematch := iid_constants.gn(wphonematchscore) and if(ExactPhoneRequired, le.wphone10=ri.phone, true);
	socsmatchscore := did_add.ssn_match_score(le.ssn, ssn2use, LENGTH(TRIM(le.ssn))=4);
	socsmatch := iid_constants.gn(socsmatchscore) and if(ExactSSNRequired, le.ssn=ssn2use, true);
	cmpymatch := false;
	
	
	indobpop := length(trim(le.dob))=8;
  ri_dob := ((string) ri.dob)[1..8];
	founddobpop := trim(ri_dob)<>'0';
	
	// new dob scoring based on input options
	dobmatch_score_fuzzy6 := iid_constants.dobmatch_score_fuzzy6(indobpop, founddobpop, le.dob, (string8)ri.dob);	// score with dobmatchoption set to FuzzyCCYYMM
	dobmatch_score_radius := iid_constants.dobmatch_score_radius(indobpop, founddobpop, le.dob, (string8)ri.dob, DOBMatchYearRadius);	// score with dobmatchoption set to RadiusCCYY
	dobmatch_score_exact8 := iid_constants.dobmatch_score_exact8(indobpop, founddobpop, le.dob, (string8)ri.dob);	// score with dobmatchoption set to ExactCCYYMMDD
	dobmatch_score_exact6 := iid_constants.dobmatch_score_exact6(indobpop, founddobpop, le.dob, (string8)ri.dob);	// score with dobmatchoption set to ExactCCYYMM
	
	dobmatch_score1 := IF(indobpop and founddobpop,did_add.ssn_match_score(le.dob[1..8],ri_dob[1..8]),255);	// per GB, if input dob is less than 8 bytes, don't let it pass
	yyyymm_match := le.dob[1..6]=ri_dob[1..6];
	dobmatch_score := map(
	  indobpop and ri_dob in risk_indicators.iid_constants.invalid_dobs => 1,
		DOBMatchOption = 'FUZZYCCYYMM' => dobmatch_score_fuzzy6,
		DOBMatchOption = 'RADIUSCCYY' => dobmatch_score_radius,
		DOBMatchOption = 'EXACTCCYYMMDD' => dobmatch_score_exact8,
		DOBMatchOption = 'EXACTCCYYMM' => dobmatch_score_exact6,
		 '00' = le.dob[5..6]  or '00' = ri_dob[5..6] => 255, // consider a blank month from input or file to be bad
		 '00' = le.dob[7..8] and '00' = ri_dob[7..8] => if(yyyymm_match, 95, 12 ), // with both days blank, require an exact match on YYYYMM (override values per TS)
		('00' = le.dob[7..8]  or '00' = ri_dob[7..8]) and dobmatch_score1=70 => if(yyyymm_match, 96, 94 ),
		dobmatch_score1
	);

	dobmatch := iid_constants.g(dobmatch_score) and if(ExactDOBRequired, le.dob[1..8]=ri_dob[1..8], true);
		
  trueDID_original := ri.did<>0;
	    
  // if the consumer has a statement on file, security alert, legal hold, we need to set the noScore trigger so all attributes and scores get suppressed.
  // for id_theft_flag, don't set the truedid=false because we'll return a real score for that person, just return the alert code of 100G
	self.truedid := if(le.ConsumerFlags.consumer_statement_flag or  
  le.ConsumerFlags.security_alert or  
  le.ConsumerFlags.legal_hold_alert or  
  (le.ConsumerFlags.id_theft_flag and bsversion < 50) ,
    false, trueDID_original);
	
	// if input social is 4 bytes then use full social from header if last4 match
	ssnLength := length(trim(le.ssn));
	self.ssn := if(ssnLength = 4 and socsmatch, ssn2use, le.ssn);
	self.ssnLookupFlag := map(ssnLength=4 and socsmatch => 1,
														ssnLength=4 and ~socsmatch => 0,
														-1);
	self.src := ri.src;
				 
	self.dt_last_seen := dt;			 
	self.firstcount := IF(firstmatch,1,0);
	self.lastcount := IF(lastmatch,1,0);
	self.addrcount := IF(isrecent and addrmatch,1,0);
	self.socscount := IF(socsmatch,1,0);
	self.hphonecount := IF(hphonematch,1,0);
	self.wphonecount := IF(wphonematch,1,0);
	self.cmpycount := IF(cmpymatch,1,0);
	self.dobcount := IF(dobmatch,1,0);
	
// new shell 4.0 fields
	self.hdr_dt_first_seen := ri.dt_first_seen;
	self.hdr_dt_last_seen := if(ri.dt_last_seen >= le.historydate, le.historydate, ri.dt_last_seen);  // in a history mode, set all dates greater than history date equal to history date;
	self.dobcount2 := IF(dobmatch,1,0);  // correction record doesn't have valid_dob field, so this logic will be the same as dobcount
//

	SELF.chrono_sources := SELF.src+',';
	SELF.chrono_addrcount := 1;

	self.chronofirst := ri.fname;
	self.chronolast := ri.lname;
	self.chronoprim_range := ri.prim_range;
	self.chronopredir := ri.predir;
	self.chronoprim_name := ri.prim_name;
	self.chronosuffix := ri.suffix;
	self.chronopostdir := ri.postdir;
	self.chronounit_desig := ri.unit_desig;
	self.chronosec_range := ri.sec_range;
	self.chronocity := ri.city_name;
	self.chronostate := ri.st;
	self.chronozip := ri.zip;
	self.chronozip4 := ri.zip4;
	self.chronocounty := ri.county;
	self.chronogeo_blk := ri.geo_blk;
	self.chronodate_first := ri.dt_first_seen;
	self.chronodate_last := ri.dt_last_seen;
	self.chronoaddrscore := addrmatch_score2;
	
	// look for soc matches, preferring valid='G' in the rollup below
	self.socsscore := socsmatchscore;
	self.versocs := ri.ssn;
	self.socsvalid := ri.valid_ssn;
	
	// try recent addresses
	self.addrscore := IF(isrecent,addrmatch_score2,255);
	self.citystatescore := IF(isrecent,cityst_score2,255);
	self.zipscore := IF(isrecent,zip_score2,255);
	self.addrmultiple := false;
	
	self.verprim_range := IF(isrecent,ri.prim_range,'');
	self.verpredir := IF(isrecent,ri.predir,'');
	self.verprim_name := IF(isrecent,ri.prim_name,'');
	self.versuffix := IF(isrecent,ri.suffix,'');
	self.verpostdir := IF(isrecent,ri.postdir,'');
	self.verunit_desig := IF(isrecent,ri.unit_desig,'');
	self.versec_range := IF(isrecent,ri.sec_range,'');
	self.vercity := IF(isrecent, ri.city_name, '');
	self.verstate := IF(isrecent, ri.st, '');
	self.verzip := IF(isrecent, ri.zip+ri.zip4, '');
	self.vercounty := IF(isrecent, ri.county, '');
	self.vergeo_blk := IF(isrecent, ri.geo_blk, '');
	SELF.verdate_last := IF(isrecent, ri.dt_last_seen, 0);
	SELF.verdate_first := IF(isrecent, ri.dt_first_seen, 0);
	
	self.lastscore := lastmatch_score;
	self.verlast := ri.lname;

	self.firstscore := firstmatch_score;
	self.verfirst := ri.fname;
	
	self.dobscore := dobmatch_score;
	self.verdob := (STRING)ri.dob;
	
	self.hphonescore := hphonematchscore;
	self.verhphone := ri.phone;
	
	self.wphonescore := wphonematchscore;
	self.verwphone := '';//ri.phone;  // not sure how to handle this yet

	SELF.sources := SELF.src+',';	
	SELF.firstnamesources := IF(SELF.firstcount=0,le.firstnamesources,SELF.src+',');
	SELF.lastnamesources := IF(SELF.lastcount=0,le.lastnamesources,SELF.src+',');
	SELF.addrsources := IF(SELF.addrcount=0,le.addrsources,SELF.src+',');
	SELF.socssources := IF(SELF.socscount=0,le.socssources,SELF.src+',');
	SELF.numsource := 1;
	
	self.hphonesources := IF(SELF.hphonecount=0,le.hphonesources,SELF.src+',');
	self.wphonesources := IF(SELF.wphonecount=0,le.wphonesources,SELF.src+',');
	self.dobsources := IF(SELF.dobcount=0,le.dobsources,SELF.src+',');
	self.cmpysources := IF(SELF.cmpycount=0,le.cmpysources,SELF.src+',');
	
	self := le;
end;
j_corrections := join (g_inrec, fake_header,
                       (Left.seq = Right.seq),
                       GetFakeHeaderRecords (Left, Right), MANY LOOKUP);
//========================================

j_combined_roxie := GROUP (SORT (UNGROUP(prison + j_corrections), seq, did), seq, did);

j_combined_thor := GROUP (SORT( DISTRIBUTE(UNGROUP(prison + j_corrections), HASH64(seq, did)), seq, did, LOCAL), seq, did, LOCAL);

#IF(onThor)
	j_combined := j_combined_thor;
#ELSE
	j_combined := j_combined_roxie;
#END

j_header := IF (isFCRA, j_combined, prison);	

// output(header_recs_combined, named('header_recs_combined'), extend);
// output(header_corr, named('header_corr'));
// output(corrOnly, named('corrOnly'));
// output(unCorrOnly, named('unCorrOnly'));
// output(finalCorr, named('finalCorr'));
// output(finalCorr2, named('finalCorr2'));
// output(header_recs, named('header_recs'));	//ZZZ
	
// OUTPUT(tranHeader, NAMED('tranHeader'));
// OUTPUT(j_header, named('j_header'));
// OUTPUT(j_combined, named('j_combined'));
// OUTPUT(tranHeader, named('GHtranHeader'));	//ZZZ
// OUTPUT(j_corrections, named('GHj_corrections'));	//ZZZ
// output(bsoptions);

return j_header;

end;