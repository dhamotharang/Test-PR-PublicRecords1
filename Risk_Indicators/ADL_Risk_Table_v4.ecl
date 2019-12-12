// added transunion 'TN'
// added college address in college history flag

IMPORT fcra, header, gong, ut, doxie_build, header_quick, ADVO, mdr;

todays_date := (string) risk_indicators.iid_constants.todaydate;

EXPORT ADL_Risk_Table_v4(BOOLEAN isFCRA) := FUNCTION

hf1 := if(isFCRA,doxie_build.file_FCRA_header_building,doxie_build.file_header_building)(did!=0 AND ~iid_constants.filtered_source(src, st));
h_quick := PROJECT( header_quick.file_header_quick(did!=0 AND ~iid_constants.filtered_source(src, st)), TRANSFORM(Header.Layout_Header, self.src := IF(left.src in ['QH', 'WH'], MDR.sourceTools.src_Equifax, left.src), SELF := LEFT));
headerprod_building := UNGROUP(hf1 + h_quick);

hf := PROJECT(headerprod_building(dt_last_seen<>0),TRANSFORM(Header.Layout_Header, SELF := LEFT));

base_hf_uncorrected := IF(isFCRA, hf(~fcra.Restricted_Header_Src(src, vendor_id[1]) AND
																			((src='BA' AND FCRA.bankrupt_is_ok(todays_date,(string)dt_first_seen)) OR
																				(src='L2' AND FCRA.lien_is_ok(todays_date,(string)dt_first_seen)) OR src NOT IN ['BA','L2'])),
																	hf);
/* ****************************************************
 *                  Apply Corrections                 *
 ****************************************************** */
base_hf_corrected := Risk_Indicators.Header_Corrections_Function(base_hf_uncorrected);

base_hf_before_suppress := IF(isFCRA, base_hf_corrected, base_hf_uncorrected);

base_hf := fn_suppress_ccpa(base_hf_before_suppress, TRUE, 'RiskTable', 'src', 'global_sid', TRUE); // CCPA-795: OptOut Prefilter Data Layer

/* ****************************************************
 * Corrections have been applied - Continue as normal *
 ****************************************************** */
// filter out the other 2 credit header sources for the respective version of the base file we build
equifax_base := base_hf(src NOT IN [mdr.sourceTools.src_Experian_Credit_Header, mdr.sourceTools.src_TU_CreditHeader]);
experian_base := base_hf(src NOT IN [mdr.sourceTools.src_Equifax, mdr.sourceTools.src_TU_CreditHeader]);
transunion_base := base_hf(src NOT IN [mdr.sourceTools.src_Equifax, mdr.sourceTools.src_Experian_Credit_Header]);

// none of the credit bureaus filtered
all_bureaus := adl_risk_table(base_hf);

equifax_recs := adl_risk_table(equifax_base);
experian_recs := adl_risk_table(experian_base);
transunion_recs := adl_risk_table(transunion_base);

common_adl_risk := RECORD
	RECORDOF(all_bureaus) - did;  // don't need a redundant DID field
END;


layout_adl_risk_v4 := RECORD
	UNSIGNED did;
	STRING15 adl_category := '';
	BOOLEAN college_address_in_history := FALSE;
	UNSIGNED1 phone_ct;
	UNSIGNED1 phone_ct_c6;
	common_adl_risk combo;  // combination of both bureaus, no bureau data restricted
	common_adl_risk eq;  		// equifax table
	common_adl_risk en;			// experian table
	common_adl_risk tn;			// transunion table
	//CCPA-768
	UNSIGNED4	global_sid := 0;
	UNSIGNED8 record_sid := 0;
END;

j := JOIN(all_bureaus, equifax_recs, LEFT.did=RIGHT.did, 
				TRANSFORM(layout_adl_risk_v4,
									SELF.did := LEFT.did,
									SELF.combo := LEFT,
									SELF.eq := RIGHT,
									SELF := []), LEFT OUTER, LOCAL);

j2 := JOIN(j, experian_recs, LEFT.did=RIGHT.did,
				TRANSFORM(layout_adl_risk_v4,
									SELF.en := RIGHT,
									SELF := LEFT), LEFT OUTER, LOCAL);

j3 := JOIN(j2, transunion_recs, LEFT.did=RIGHT.did,
				TRANSFORM(layout_adl_risk_v4,
									SELF.tn := RIGHT,
									SELF := LEFT), LEFT OUTER, LOCAL);

// now append the phones per DID 
sysdate := todays_date[1..6] + '01';
gh1 := Gong.File_Gong_History_full(did<>0 AND (current_RECORD_flag='Y' OR ut.DaysApart(sysdate, deletion_date[1..6]+'31') < 365) );
// gh1 := dataset([], RECORDof(Gong.File_Gong_History_full) );  // for testing the rest of this stuff if you don't care about the phone counts
gh := DISTRIBUTE(gh1, HASH(did));

phone_slim := RECORD
	gh.did;
	phone := gh.phone10;
	dt_first_seen := MIN(GROUP,IF((UNSIGNED)gh.dt_first_seen=0,999999,(UNSIGNED)gh.dt_first_seen));
	dt_last_seen := MAX(GROUP,(UNSIGNED)gh.dt_last_seen);
END;
d_phone := TABLE(gh((INTEGER)phone10<>0), phone_slim, did, phone10, LOCAL);

phone_stats := RECORD
	did := d_phone.did;
	phone_ct := COUNT(GROUP);
	phone_ct_c6 := COUNT(GROUP, ut.DaysApart(sysdate, ((string)d_phone.dt_first_seen)[1..6]+'31') < 183);
END;
phone_counts := TABLE(d_phone, phone_stats, did, LOCAL);

														 
// append the phone counts
with_phone_counts := JOIN(j3, phone_counts, LEFT.did=RIGHT.did, 
				TRANSFORM(layout_adl_risk_v4, 
					SELF.phone_ct := RIGHT.phone_ct,
					SELF.phone_ct_c6 := RIGHT.phone_ct_c6;
					SELF := LEFT), 
				LEFT OUTER, LOCAL);
			
advo_college_base := advo.Files().Base.built(active_flag = 'Y' AND college_indicator='Y');

crec_temp := RECORD
	UNSIGNED did;
	BOOLEAN college_address_in_history;
END;

// Must be exact match on all parts -- including sec range being blank.
with_advo_college_raw  := JOIN(base_hf, advo_college_base, 
					(LEFT.zip = RIGHT.zip) AND
					(LEFT.prim_range = RIGHT.prim_range) AND
					(LEFT.prim_name = RIGHT.prim_name) AND
					(LEFT.suffix = RIGHT.addr_suffix) AND
					(LEFT.predir = RIGHT.predir) AND
					(LEFT.postdir = RIGHT.postdir) AND
					(LEFT.sec_range = RIGHT.sec_range),
					TRANSFORM(crec_temp,
											SELF.college_address_in_history := RIGHT.college_indicator='Y',
											// SELF.advo_raw := right;
											SELF := LEFT), LEFT OUTER, LOOKUP);

advo_college_flag := DEDUP(SORT(DISTRIBUTE(with_advo_college_raw, HASH(did)), 
																did, -college_address_in_history, LOCAL ),
													did, LOCAL);

layout_adl_risk_v4 addCollegeFlag(layout_adl_risk_v4 le, advo_college_flag ri) := TRANSFORM
	SELF.college_address_in_history := ri.college_address_in_history;
	SELF := le;
END;

with_college_history_flag := JOIN(DISTRIBUTE(with_phone_counts, HASH(did)),	
																	advo_college_flag, // should still be distributed from the local dedup above
																	LEFT.did=RIGHT.did,
																	addCollegeFlag(LEFT,RIGHT), LEFT OUTER, KEEP(1), LOCAL);

// GET ADL CATEGORY


ADL_Category := Header.fn_ADLSegmentation(header.file_headers, isFCRA).core_check;		

layout_adl_risk_v4 addCategory(layout_adl_risk_v4 le, adl_category ri) := TRANSFORM
	SELF.adl_category := ri.ind;
	SELF := le;
END;

persist_name := IF (IsFCRA, 'persist::adl_risk_v4_filtered', 'persist::adl_risk_v4'); 
	
full_adl_risk_wCat := JOIN(DISTRIBUTE(with_college_history_flag, HASH(did)), 
													 DISTRIBUTE(adl_category(did<>0), HASH(did)), 
													 LEFT.did=RIGHT.did, 
													 addCategory(left,right), LEFT OUTER, KEEP(1), LOCAL) : PERSIST (persist_name);									

addGlobalSID := mdr.macGetGlobalSID(full_adl_risk_wCat,'RiskTable_Virtual','','global_sid'); //DF-26530: Populate Global_SID Field
	
RETURN addGlobalSID;

END;
