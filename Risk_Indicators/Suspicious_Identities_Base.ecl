IMPORT ut, doxie_build, header_quick, header, mdr, STD;

today := risk_indicators.iid_constants.todaydate DIV 100;
isFCRA := false;  // currently only need to build this for non-fcra for fraud

hf1 := doxie_build.file_header_building(did!=0 AND ~iid_constants.filtered_source(src, st));
h_quick := PROJECT( header_quick.file_header_quick(did!=0 AND ~iid_constants.filtered_source(src, st)), TRANSFORM(Header.Layout_Header, self.src := IF(left.src in ['QH', 'WH'], MDR.sourceTools.src_Equifax, left.src), SELF := LEFT));
headerprod_building := UNGROUP(hf1 + h_quick);

base_hf_before_suppress := DISTRIBUTE(PROJECT(headerprod_building(dt_last_seen<>0),TRANSFORM(Header.Layout_Header, SELF := LEFT)), HASH(did));

base_hf := fn_suppress_ccpa(base_hf_before_suppress, TRUE, 'RiskTable', 'src', 'global_sid', TRUE); // CCPA-795: OptOut Prefilter Data Layer

did_slim := RECORD
	base_hf.did;
	total_records := count(group);
	bureau_records := count(group, base_hf.src in Risk_Indicators.iid_constants.bureau_sources);
	dt_first_seen := MIN(GROUP,IF(base_hf.dt_first_seen=0,999999,base_hf.dt_first_seen));
	dt_last_seen := MAX(GROUP,base_hf.dt_last_seen);
END;

header_stats := TABLE(base_hf, did_slim, did, LOCAL);

// Rule 1: you're suspicious if you've only been seen at the bureau or first seen within the last year or no update in the past year
suspicious_header := header_stats(
																(dt_first_seen<>999999 and dt_first_seen >= (today-100)	)		or							// IdentityRiskLevel = 3, first seen within the last year or
																(bureau_records=total_records) or 																					// IdentityRiskLevel = 4,  only shows up on Bureau records or
																(bureau_records>0 and total_records>0 and dt_last_seen < (today-100))		// IdentityRiskLevel 5 and 6, last updated over a year ago
															 );

// Rule 2: you're suspicious if you have a SSN that is invalid, has multiple Identities or is issued prior to DOB
did_ssn_dob := table(base_hf(trim(ssn)<>''), {did, ssn, dob}, did, ssn, dob, local);
ssntable := risk_indicators.SSN_Table_v4_2(isFCRA);

temprec := record
	recordof(did_ssn_dob);
	unsigned recentcount;
	boolean isvalidformat;
	unsigned official_last_seen;
end;
// use the SSNs to search the ssn_table to find out if it's valid SSN or has multiple Identities or ssn issued prior to DOB
suspicious_ssns := join(
	distribute(did_ssn_dob, hash(ssn)),
	distribute(ssntable, hash(ssn)), 
	left.ssn=right.ssn	and
	(	// only keep records that are suspicious
		right.combo.recentcount >= 3 or 
		right.isvalidformat=false or 
		( (unsigned)((string8)left.dob)[1..4] >  (unsigned)((string8)right.official_last_seen)[1..4] and right.official_last_seen<>0)
	),
		transform(temprec,	
														self.recentcount := right.combo.recentcount;
														self.isvalidformat := right.isvalidformat;
														self.official_last_seen := right.official_last_seen;
	self := left), local);

dids_with_suspicious_ssns := dedup(sort(distribute(suspicious_ssns, hash(did)), did, ssn, local), did, local);

// atmost 1 record per DID in suspicious_header and 1 per DID in dids_with_suspicious_ssns
layout_suspicious_id := RECORD
	risk_indicators.Boca_Shell_Fraud.layout_identities_output - historydate;
	//CCPA-768
	UNSIGNED4	global_sid := 0;
	UNSIGNED8 record_sid := 0;
END;

suspicious_identities := join(suspicious_header,dids_with_suspicious_ssns, left.did=right.did,
	transform(
		layout_suspicious_id, 
		// don't need the date on the key, we'll be able to see the date in the logical file name
		// risk_indicators.Boca_Shell_Fraud.layout_identities_output, 
		// self.historydate := today;
		self.did := if(left.did=0, right.did, left.did);
		self.bureau_only := left.did<>0 and left.bureau_records=left.total_records;
		firstseen31 := ((string)left.dt_first_seen)[1..6]+'31';
		self.bureau_only_last_1month := left.did<>0 and left.bureau_records=left.total_records and 
			iid_constants.checkdays(iid_constants.full_history_date(today),firstseen31,30, today);
		self.bureau_only_last_6months := left.did<>0 and left.bureau_records=left.total_records and 
			iid_constants.checkdays(iid_constants.full_history_date(today),firstseen31,iid_constants.sixmonths, today);
		self.suspicious_ssn := right.did<>0;
		self.ssn := if(right.did<>0, right.ssn, '');
		), full outer, local);
		
		// ), full outer, local) : persist('persist::suspicious_identities');
// output(suspicious_ssns,,'~dvstemp::out::suspicious_ssns_testing');

	addGlobalSID := mdr.macGetGlobalSID(suspicious_identities,'RiskTable_Virtual','','global_sid'); //DF-26530: Populate Global_SID Field

EXPORT Suspicious_Identities_Base := addGlobalSID;
