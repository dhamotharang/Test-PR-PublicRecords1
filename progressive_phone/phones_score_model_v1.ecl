IMPORT AutoStandardI, didville, did_add, doxie, header_slimsort, NID, Models, ut, Phonesplus_v2,
			Gong_Platinum, Experian_Phones, Risk_Indicators, RiskWise, watchdog, MDR, BatchServices,
      STD;

in_batch_rec := RECORD
	STRING20 acctno;
	INTEGER did;
	didville.Layout_Did_InBatch;
END;	

EXPORT phones_score_model_v1 (DATASET(progressive_phone.layout_progressive_phone_common) waterfallInput,
															DATASET(in_batch_rec) inputDIDs,
															INTEGER GLBPurpose = 0,
															STRING50 Data_Restriction_Mask = Risk_Indicators.iid_constants.default_DataRestriction,
															BOOLEAN isPFR = FALSE,
															INTEGER MetronetScoreThreshold = BatchServices.Constants.ProgressivePhone.DefaultMetronetScoreThreshold) := FUNCTION

	// Set the following to TRUE to return Attributes
	MODEL_DEBUG := Progressive_Phone.Common.Model_Debug;
	
	/* ***********************************************************
	 *   To help boost matchcode levels when only SSN is input   *
   * append best name information temporarily for the model.   *
	 ************************************************************* */
	didPrep := PROJECT(inputDIDs, TRANSFORM(DidVille.Layout_Did_OutBatch, SELF := LEFT; SELF := []));
	
	industryClass := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));
	didville.MAC_BestAppend(didPrep, 
													'BEST_NAME', 
													'BEST_NAME', 
													0, 
													ut.PermissionTools.glb.OK(GLBPurpose), 
													bestDIDs, 
													false, 
													Data_Restriction_Mask,
													,
													,
													,
													, 
													'',
													IndustryClass_val := industryClass);

	in_batch_rec fillData(DidVille.Layout_Did_OutBatch le) := TRANSFORM
		SELF.fname := IF(TRIM(le.best_fname) <> '', le.best_fname, STD.Str.ToUpperCase(le.fname));
		SELF.mname := IF(TRIM(le.best_mname) <> '', le.best_mname, STD.Str.ToUpperCase(le.mname));
		SELF.lname := IF(TRIM(le.best_lname) <> '', le.best_lname, STD.Str.ToUpperCase(le.lname));
		
		SELF := le;
		SELF := [];
	END;
	inputDIDsBestTemp := PROJECT(bestDIDs, fillData(LEFT));
	
	inputDidsBest := JOIN(inputDIDsBestTemp, inputDIDs, LEFT.DID = RIGHT.DID, TRANSFORM(in_batch_rec, SELF.acctno := RIGHT.acctno; SELF := LEFT), ATMOST(RiskWise.max_atmost), KEEP(1)); // Should only be 1 unique DID per input record

	// Check to see if we now match on Name, if so make sure the matchcodes indicate it
	progressive_phone.layout_progressive_phone_common updateMatchcodes(progressive_phone.layout_progressive_phone_common le, in_batch_rec ri) := TRANSFORM
		tmpMatchName := ((le.p_name_first = ri.fname AND le.p_name_first <> '') OR 
						                 NID.mod_PFirstTools.PFLeqPFR(STD.Str.ToUpperCase(le.p_name_first),ri.fname)) AND
						                 (le.p_name_last = ri.lname AND le.p_name_last <> '');
		// Check to see if the best name matches the name on the waterfall record, if so update the matchcodes
		SELF.matchcodes := IF(tmpMatchName AND STD.Str.Find(le.matchcodes, 'N', 1) = 0, 'N' + le.matchcodes, le.matchcodes);
	
		SELF := le;
	END;
	waterfallInputBest := JOIN(waterfallInput, inputDidsBest, LEFT.AcctNo = RIGHT.AcctNo AND LEFT.DID = RIGHT.DID, updateMatchcodes(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.max_atmost), KEEP(1));
	
	/* ***********************************************************
	 *              Flatten Layout - Get WF Levels               *
	 ************************************************************* */
	WFFlattenedLayout := RECORD
		progressive_phone.layout_progressive_phone_common;
		UNSIGNED1 wf_level_ind_AP := 0;
		UNSIGNED1 wf_level_ind_CL := 0;
		UNSIGNED1 wf_level_ind_CR := 0;
		UNSIGNED1 wf_level_ind_ES := 0;
		UNSIGNED1 wf_level_ind_MD := 0;
		UNSIGNED1 wf_level_ind_SE := 0;
		UNSIGNED1 wf_level_ind_SP := 0;
		UNSIGNED1 wf_level_ind_SX := 0;
		UNSIGNED1 wf_level_ind_PP := 0;
		UNSIGNED1 wf_level_ind_TH := 0;
		STRING8 matchcodes_AP := '';
		STRING8 matchcodes_CL := '';
		STRING8 matchcodes_CR := '';
		STRING8 matchcodes_ES := '';
		STRING8 matchcodes_MD := '';
		STRING8 matchcodes_SE := '';
		STRING8 matchcodes_SP := '';
		STRING8 matchcodes_SX := '';
		STRING8 matchcodes_PP := '';
		STRING8 matchcodes_TH := '';
	END;
	
	WFFlattenedLayout flatten(progressive_phone.layout_progressive_phone_common le) := TRANSFORM
		phone_type := STD.Str.ToUpperCase(le.subj_phone_type_new);
		
		SELF.wf_level_ind_AP := IF(phone_type = 'AP', 1, 0);
		SELF.wf_level_ind_CL := IF(phone_type = 'CL', 1, 0);
		SELF.wf_level_ind_CR := IF(phone_type = 'CR', 1, 0);
		SELF.wf_level_ind_ES := IF(phone_type = 'ES', 1, 0);
		SELF.wf_level_ind_MD := IF(phone_type = 'MD', 1, 0);
		SELF.wf_level_ind_SE := IF(phone_type = 'SE', 1, 0);
		SELF.wf_level_ind_SP := IF(phone_type = 'SP', 1, 0);
		SELF.wf_level_ind_SX := IF(phone_type = 'SX', 1, 0);
		SELF.wf_level_ind_PP := IF(phone_type = 'PP', 1, 0);
		SELF.wf_level_ind_TH := IF(phone_type = 'TH', 1, 0);
		SELF.matchcodes_AP := IF(phone_type = 'AP', le.matchcodes, '');
		SELF.matchcodes_CL := IF(phone_type = 'CL', le.matchcodes, '');
		SELF.matchcodes_CR := IF(phone_type = 'CR', le.matchcodes, '');
		SELF.matchcodes_ES := IF(phone_type = 'ES', le.matchcodes, '');
		SELF.matchcodes_MD := IF(phone_type = 'MD', le.matchcodes, '');
		SELF.matchcodes_SE := IF(phone_type = 'SE', le.matchcodes, '');
		SELF.matchcodes_SP := IF(phone_type = 'SP', le.matchcodes, '');
		SELF.matchcodes_SX := IF(phone_type = 'SX', le.matchcodes, '');
		SELF.matchcodes_PP := IF(phone_type = 'PP', le.matchcodes, '');
		SELF.matchcodes_TH := IF(phone_type = 'TH', le.matchcodes, '');
		
		SELF := le;
		SELF := [];
	END;
	
	flattenedInputTemp := PROJECT(waterfallInputBest, flatten(LEFT));
	
	/* ***********************************************************
	 * We need to aggregate where each phone number is found for *
	 * each account.                                             *
	 ************************************************************* */
	WFFlattenedLayout rollupCounts(WFFlattenedLayout le, WFFlattenedLayout ri) := TRANSFORM
		SELF.wf_level_ind_AP := IF(le.wf_level_ind_AP > 0, le.wf_level_ind_AP, ri.wf_level_ind_AP);
		SELF.wf_level_ind_CL := IF(le.wf_level_ind_CL > 0, le.wf_level_ind_CL, ri.wf_level_ind_CL);
		SELF.wf_level_ind_CR := IF(le.wf_level_ind_CR > 0, le.wf_level_ind_CR, ri.wf_level_ind_CR);
		SELF.wf_level_ind_ES := IF(le.wf_level_ind_ES > 0, le.wf_level_ind_ES, ri.wf_level_ind_ES);
		SELF.wf_level_ind_MD := IF(le.wf_level_ind_MD > 0, le.wf_level_ind_MD, ri.wf_level_ind_MD);
		SELF.wf_level_ind_SE := IF(le.wf_level_ind_SE > 0, le.wf_level_ind_SE, ri.wf_level_ind_SE);
		SELF.wf_level_ind_SP := IF(le.wf_level_ind_SP > 0, le.wf_level_ind_SP, ri.wf_level_ind_SP);
		SELF.wf_level_ind_SX := IF(le.wf_level_ind_SX > 0, le.wf_level_ind_SX, ri.wf_level_ind_SX);
		SELF.wf_level_ind_PP := IF(le.wf_level_ind_PP > 0, le.wf_level_ind_PP, ri.wf_level_ind_PP);
		SELF.wf_level_ind_TH := IF(le.wf_level_ind_TH > 0, le.wf_level_ind_TH, ri.wf_level_ind_TH);
		SELF.matchcodes_AP := IF(TRIM(le.matchcodes_AP) <> '', le.matchcodes_AP, ri.matchcodes_AP);
		SELF.matchcodes_CL := IF(TRIM(le.matchcodes_CL) <> '', le.matchcodes_CL, ri.matchcodes_CL);
		SELF.matchcodes_CR := IF(TRIM(le.matchcodes_CR) <> '', le.matchcodes_CR, ri.matchcodes_CR);
		SELF.matchcodes_ES := IF(TRIM(le.matchcodes_ES) <> '', le.matchcodes_ES, ri.matchcodes_ES);
		SELF.matchcodes_MD := IF(TRIM(le.matchcodes_MD) <> '', le.matchcodes_MD, ri.matchcodes_MD);
		SELF.matchcodes_SE := IF(TRIM(le.matchcodes_SE) <> '', le.matchcodes_SE, ri.matchcodes_SE);
		SELF.matchcodes_SP := IF(TRIM(le.matchcodes_SP) <> '', le.matchcodes_SP, ri.matchcodes_SP);
		SELF.matchcodes_SX := IF(TRIM(le.matchcodes_SX) <> '', le.matchcodes_SX, ri.matchcodes_SX);
		SELF.matchcodes_PP := IF(TRIM(le.matchcodes_PP) <> '', le.matchcodes_PP, ri.matchcodes_PP);
		SELF.matchcodes_TH := IF(TRIM(le.matchcodes_TH) <> '', le.matchcodes_TH, ri.matchcodes_TH);
		
		SELF := le;
	END;
	countedInput := ROLLUP(SORT(flattenedInputTemp, acctno, subj_phone10), LEFT.acctno = RIGHT.acctno AND LEFT.subj_phone10 = RIGHT.subj_phone10, rollupCounts(LEFT,RIGHT));
	
	WFFlattenedLayout combineCounts(WFFlattenedLayout le, WFFlattenedLayout ri) := TRANSFORM
		// Set all the counts
		SELF.wf_level_ind_AP := ri.wf_level_ind_AP;
		SELF.wf_level_ind_CL := ri.wf_level_ind_CL;
		SELF.wf_level_ind_CR := ri.wf_level_ind_CR;
		SELF.wf_level_ind_ES := ri.wf_level_ind_ES;
		SELF.wf_level_ind_MD := ri.wf_level_ind_MD;
		SELF.wf_level_ind_SE := ri.wf_level_ind_SE;
		SELF.wf_level_ind_SP := ri.wf_level_ind_SP;
		SELF.wf_level_ind_SX := ri.wf_level_ind_SX;
		SELF.wf_level_ind_PP := ri.wf_level_ind_PP;
		SELF.wf_level_ind_TH := ri.wf_level_ind_TH;
		SELF.matchcodes_AP := ri.matchcodes_AP;
		SELF.matchcodes_CL := ri.matchcodes_CL;
		SELF.matchcodes_CR := ri.matchcodes_CR;
		SELF.matchcodes_ES := ri.matchcodes_ES;
		SELF.matchcodes_MD := ri.matchcodes_MD;
		SELF.matchcodes_SE := ri.matchcodes_SE;
		SELF.matchcodes_SP := ri.matchcodes_SP;
		SELF.matchcodes_SX := ri.matchcodes_SX;
		SELF.matchcodes_PP := ri.matchcodes_PP;
		SELF.matchcodes_TH := ri.matchcodes_TH;
		
		// Grab the rest of the input
		SELF := le;
	END;
	
	flattenedInput := JOIN(flattenedInputTemp, countedInput, LEFT.acctno = RIGHT.acctno AND LEFT.subj_phone10 = RIGHT.subj_phone10, combineCounts(LEFT, RIGHT), ATMOST(RiskWise.max_atmost), KEEP(ut.limits.PHONE_PER_PERSON));
	
	phonesPlusPhonesTemp := flattenedInput (STD.Str.ToUpperCase(subj_phone_type_new) = 'PP');
	
	edaPhonesTemp := flattenedInput (STD.Str.ToUpperCase(subj_phone_type_new) <> 'PP');
	
	WFFlattenedLayout cleanPhones(WFFlattenedLayout le, BOOLEAN phonesPlus) := TRANSFORM
		// If phonesPlus is TRUE - blank everything but PP
		// If phonesPlus is FALSE - blank just PP
		SELF.wf_level_ind_AP := IF(phonesPlus, 0, le.wf_level_ind_AP);
		SELF.wf_level_ind_CL := IF(phonesPlus, 0, le.wf_level_ind_CL);
		SELF.wf_level_ind_CR := IF(phonesPlus, 0, le.wf_level_ind_CR);
		SELF.wf_level_ind_ES := IF(phonesPlus, 0, le.wf_level_ind_ES);
		SELF.wf_level_ind_MD := IF(phonesPlus, 0, le.wf_level_ind_MD);
		SELF.wf_level_ind_SE := IF(phonesPlus, 0, le.wf_level_ind_SE);
		SELF.wf_level_ind_SP := IF(phonesPlus, 0, le.wf_level_ind_SP);
		SELF.wf_level_ind_SX := IF(phonesPlus, 0, le.wf_level_ind_SX);
		SELF.wf_level_ind_PP := IF(phonesPlus, le.wf_level_ind_PP, 0);
		SELF.wf_level_ind_TH := 0;
		SELF.matchcodes_AP := IF(phonesPlus, '', le.matchcodes_AP);
		SELF.matchcodes_CL := IF(phonesPlus, '', le.matchcodes_CL);
		SELF.matchcodes_CR := IF(phonesPlus, '', le.matchcodes_CR);
		SELF.matchcodes_ES := IF(phonesPlus, '', le.matchcodes_ES);
		SELF.matchcodes_MD := IF(phonesPlus, '', le.matchcodes_MD);
		SELF.matchcodes_SE := IF(phonesPlus, '', le.matchcodes_SE);
		SELF.matchcodes_SP := IF(phonesPlus, '', le.matchcodes_SP);
		SELF.matchcodes_SX := IF(phonesPlus, '', le.matchcodes_SX);
		SELF.matchcodes_PP := IF(phonesPlus, le.matchcodes_PP, '');
		SELF.matchcodes_TH := '';
		
		SELF := le;
	END;
	
	phonesPlusPhones := PROJECT(phonesPlusPhonesTemp, cleanPhones(LEFT, TRUE));
															
	edaPhones := PROJECT(edaPhonesTemp, cleanPhones(LEFT, FALSE));
	
	/* ***********************************************************
	 *           Get Attributes - PhonesPlus and EDA             *
	 ************************************************************* */
	WFFlattenedAttributesLayout := RECORD
		// Aggregated Waterfall Phones Output
		WFFlattenedLayout;
		
		// Phones Plus Attributes
		UNSIGNED3 datelastseen := 0;
		UNSIGNED2 append_nonpublished_match := 0;
		UNSIGNED8 rules := 0;
		UNSIGNED4 eda_hist_match := 0;
		UNSIGNED8 src_rule := 0;
		BOOLEAN append_best_addr_match_flag := FALSE;
		
		// EDA Attributes
		STRING5 address_match_best := ''; // BOOLEAN
		STRING5 days_in_service := ''; // UNSIGNED2
		STRING1 dwelling := '';
		STRING1 eda_attr_subj := '';
		STRING5 num_phone_owners_cur := ''; // UNSIGNED2
		STRING5 num_phones_connected_addr := ''; //UNSIGNED2
	END;
	
	WFFlattenedAttributesLayoutTemp := RECORD
		WFFlattenedAttributesLayout;
		
		// These are used to help select a "unique" Phones Plus attribute record since there can be more than 1 record per phone number.
		STRING8 PPdatelastseen := '';
		STRING8 PPfirst_build_date := '';
		UNSIGNED1 PPconfidencescore := 0;
		STRING8 PPdatevendorlastreported := '';
		BOOLEAN PPappendbestaddrmatchflag := FALSE;
		DATA16 PPcellphoneidkey := (DATA)0;
		
		// These are used to help select a "unique" EDA attribute record since there can be more than 1 record per phone number.
		STRING8 EDAdatefirstseen := '';
	END;
	
	WFFlattenedAttributesLayoutTemp getPhonesPlusAttributes(WFFlattenedLayout le, Phonesplus_v2.Key_Phonesplus_Did ri) := TRANSFORM
		SELF.datelastseen := ri.datelastseen;
		SELF.append_nonpublished_match := ri.append_nonpublished_match;
		SELF.rules := ri.rules;
		SELF.eda_hist_match := ri.eda_hist_match;
		SELF.src_rule := ri.src_rule;
		SELF.append_best_addr_match_flag := ri.append_best_addr_match_flag;
		
		// For selecting a unique Phones Plus attribute record
		SELF.PPdatelastseen := (STRING)ri.datelastseen;
		SELF.PPfirst_build_date := (STRING)ri.first_build_date;
		SELF.PPconfidencescore := ri.confidencescore;
		SELF.PPdatevendorlastreported := (STRING)ri.DateVendorLastReported;
		SELF.PPappendbestaddrmatchflag := ri.append_best_addr_match_flag;
		SELF.PPcellphoneidkey := ri.CellPhoneIDKey;
		
		SELF := le;
		SELF := [];
	END;
	
	inputPhonesPlusTemp := JOIN(phonesPlusPhones, Phonesplus_v2.Key_Phonesplus_Did, 
															LEFT.did <> 0 AND KEYED(LEFT.did = RIGHT.l_did) AND TRIM(LEFT.subj_phone10) = TRIM(RIGHT.CellPhone)
															and ut.PermissionTools.glb.SrcOk(GLBPurpose, right.src, right.DateFirstSeen, right.dt_nonglb_last_seen),
															getPhonesPlusAttributes(LEFT, RIGHT), LEFT OUTER,
															LIMIT(ut.limits.PHONE_PER_PERSON, SKIP)); 

	// In the case of duplicate Phones Plus attributes use the following record selection logic:
	// Keep the record with the highest confidencescore, and if there are two with the same highest confidencescore
	// keep the record with the most recent datelastseen, and if there are two with the same datelastseen 
	// keep the record with the most recent first_build_date, and if there are two with the same first_build_date
	// keep the record with the most recent DateVendorLastReported, and if there are two with the same DateVendorLastReported
	// keep the record with the append_best_addr_match_flag set to TRUE.
	phonesPlusAttributesTemp := DEDUP(SORT(inputPhonesPlusTemp, AcctNo, DID, subj_phone10, subj_phone_type_new, 
																							-PPconfidencescore, -PPdatelastseen, -PPfirst_build_date, -PPdatevendorlastreported, -PPappendbestaddrmatchflag, -PPcellphoneidkey), 
																		AcctNo, DID, subj_phone10, subj_phone_type_new);
	inputPhonesPlus := PROJECT(phonesPlusAttributesTemp, TRANSFORM(WFFlattenedAttributesLayout, SELF := LEFT));
	
	WFFlattenedAttributesLayoutTemp getEDAAttributes(WFFlattenedLayout le, Gong_Platinum.Key_GongScoringAttributes ri) := TRANSFORM
		SELF.address_match_best := IF(ri.address_match_best, '1', IF(ri.address_match_best = FALSE, '0', ''));
		SELF.days_in_service := (STRING)ri.days_in_service;
		SELF.dwelling := ri.dwelling;
		
		// Not really part of the EDA attributes - this just indicates whether the matching EDA Attributes matches a waterfall output record having subj_phone_relationship = "subject".
		SELF.eda_attr_subj := IF(TRIM(STD.Str.ToUpperCase(le.subj_phone_relationship)) = 'SUBJECT', '1', IF(TRIM(le.subj_phone_relationship) <> '', '0', ''));
		
		SELF.num_phone_owners_cur := (STRING)ri.num_phone_owners_cur;
		SELF.num_phones_connected_addr := (STRING)ri.num_phones_connected_addr;
		
		// For selecting a unique EDA attribute record
		SELF.EDAdatefirstseen := (STRING)ri.dt_first_seen;
	
		SELF := le;
		SELF := [];
	END;	
	
	inputEDATemp := JOIN(edaPhones, Gong_Platinum.Key_GongScoringAttributes,
															(TRIM(LEFT.subj_phone10) NOT IN ['0', ''] AND TRIM(LEFT.subj_name_dual) <> '') AND 
															KEYED(LEFT.subj_name_dual = RIGHT.fsn AND LEFT.subj_phone10 = RIGHT.phone10) AND RIGHT.did <> 0,
															getEDAAttributes(LEFT, RIGHT), LEFT OUTER, LIMIT(ut.limits.PHONE_PER_PERSON * COUNT(edaPhones), SKIP));

	// In the case of duplicate EDA attributes use the following record selection logic:
	// Keep the record which matches SUBJECT  for the subj_phone_relationship
	// If there are multiple that match that relationship keep the record with the most recent dt_first_seen
	// If there are multiple with the most recent dt_first_seen keep the record with the largest num_phone_owners_cur
	// Then keep the largest num_phones_connected_addr
	// Then keep the one with address_match_best set to true
	// Lastly keep the one with dwelling populated
	EDAAttributesTemp := DEDUP(SORT(inputEDATemp, AcctNo, subj_phone10, subj_phone_type_new, -(UNSIGNED)eda_attr_subj, -(UNSIGNED)EDAdatefirstseen, -(UNSIGNED)num_phone_owners_cur, 
																		-(UNSIGNED)num_phones_connected_addr, -(UNSIGNED)address_match_best, -dwelling), AcctNo, subj_phone10, subj_phone_type_new);
																		
	inputEDA := PROJECT(EDAAttributesTemp, TRANSFORM(WFFlattenedAttributesLayout, SELF := LEFT));

	modelInput := inputPhonesPlus + inputEDA;
	
	/* ***********************************************************
	 *                  Phone Score Model - V1                   *
	 ************************************************************* */	
	
	historydate := 999999;
	#if(MODEL_DEBUG)
		Progressive_Phone.Common.Layout_Debug_v1 doModel(WFFlattenedAttributesLayout le) := TRANSFORM
	#else
		progressive_phone.layout_progressive_phone_common doModel(WFFlattenedAttributesLayout le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	// Aggregated Waterfall Inputs
	wf_level_ind_AP							:= le.wf_level_ind_AP;
	wf_level_ind_CL							:= le.wf_level_ind_CL;
	wf_level_ind_CR							:= le.wf_level_ind_CR;
	wf_level_ind_ES							:= le.wf_level_ind_ES;
	wf_level_ind_MD							:= le.wf_level_ind_MD;
	wf_level_ind_SE							:= le.wf_level_ind_SE;
	wf_level_ind_SP							:= le.wf_level_ind_SP;
	wf_level_ind_SX							:= le.wf_level_ind_SX;
	wf_level_ind_PP							:= le.wf_level_ind_PP;
	wf_level_ind_TH							:= le.wf_level_ind_TH;
	matchcodes_AP								:= le.matchcodes_AP;
	matchcodes_CL								:= le.matchcodes_CL;
	matchcodes_CR								:= le.matchcodes_CR;
	matchcodes_ES								:= le.matchcodes_ES;
	matchcodes_MD								:= le.matchcodes_MD;
	matchcodes_SE								:= le.matchcodes_SE;
	matchcodes_SP								:= le.matchcodes_SP;
	matchcodes_SX								:= le.matchcodes_SX;
	matchcodes_PP								:= le.matchcodes_PP;
	matchcodes_TH								:= le.matchcodes_TH;
	switch_type									:= le.switch_type;
	matchcodes									:= le.matchcodes;
	
	phone_type 									:= STD.Str.ToUpperCase(le.subj_phone_type_new);
	
	// Phones Plus Attributes
	datelastseen								:= le.datelastseen;
	append_nonpublished_match		:= le.append_nonpublished_match;
	rules												:= le.rules;
	eda_hist_match							:= le.eda_hist_match;
	src_rule										:= le.src_rule;
	append_best_addr_match_flag	:= le.append_best_addr_match_flag;
	
	// EDA Attributes
	address_match_best					:= le.address_match_best;
	days_in_service							:= le.days_in_service;
	dwelling										:= TRIM(le.dwelling);
	eda_attr_subj 							:= TRIM(le.eda_attr_subj);
	num_phone_owners_cur				:= le.num_phone_owners_cur;
	num_phones_connected_addr		:= le.num_phones_connected_addr;
	
	archive_date 							:= Models.Common.SAS_Date(IF(historydate = 999999, ((string) STD.Date.Today())[1..6], ((string)historydate)[1..6]));

	NULL := -999999999;

	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(STD.Str.Find(haystack, needle, 1) > 0);

	/* ***********************************************************************
	 *           PhonesPlus Attributes - PP and TH Search levels             *
	 *************************************************************************/	
	cell_ind := switch_type = 'C';

	_month := if(((STRING)datelastseen)[5..6] = '00', 1, (real)(trim(((STRING)datelastseen)[5..6])));
	
	_datelastseen := if(datelastseen = 0, NULL, Models.Common.SAS_Date((string)(datelastseen)));

	// age_last_seen := if(datelastseen = 0, NULL, round((archive_date - (ut.DaysSince1900(((string)datelastseen)[1..4], (string)_month, '1') - ut.DaysSince1900('1960', '1', '1'))) / 30.5));
	age_last_seen := IF(MIN(archive_date, _datelastseen) = NULL, NULL, round((archive_date - _datelastseen) / 30.5));

	age_last_seen_c120 := if(age_last_seen = NULL, NULL, min(if(age_last_seen = NULL, -NULL, age_last_seen), 120));

	age_last_seen_c120_rec := if(age_last_seen_c120 = NULL, 35, age_last_seen_c120);

	app_nonpub_match_1_ind := (append_nonpublished_match & 1) > 0;

	app_nonpub_match_2_ind := (append_nonpublished_match & 2) > 0;

	app_nonpub_match_gong := app_nonpub_match_1_ind or app_nonpub_match_2_ind;

	rules_7_ind := (rules & POWER(2, 6)) > 0;

	eda_hist_match_1_ind := (eda_hist_match & 1) > 0;

	src_rule_11_ind := (src_rule & POWER(2, 10)) > 0;

	matchcode_n := (INTEGER)(contains_i(matchcodes_PP, 'N') > 0);

	matchcode_a := (INTEGER)(contains_i(matchcodes_PP, 'A') > 0);

	matchcode_c := (INTEGER)(contains_i(matchcodes_PP, 'C') > 0);

	matchcode_z := (INTEGER)(contains_i(matchcodes_PP, 'Z') > 0);

	matchcode_lvl_n_a := map(
		matchcode_n = 0 and matchcode_a = 0 => 0,
    matchcode_n = 1 and matchcode_a = 0 => 1,
    matchcode_n = 0 and matchcode_a = 1 => 2,
                                           3);

	matchcode_lvl_n_a_c := map(
    matchcode_lvl_n_a = 0 and matchcode_c = 0 => 0,
    matchcode_lvl_n_a = 1 and matchcode_c = 0 => 1,
    matchcode_lvl_n_a <= 1                    => 2,
                                                 matchcode_lvl_n_a + 1);

	matchcode_lvl_n_a_c_z := map(
    matchcode_lvl_n_a_c <= 1                    => matchcode_lvl_n_a_c,
    matchcode_lvl_n_a_c = 2 and matchcode_z = 0 => matchcode_lvl_n_a_c,
                                                   matchcode_lvl_n_a_c + 1);

	matchcode_lvl_n_a_c_z_l := map(
    matchcode_lvl_n_a_c_z = 0 => -2.985150164,
    matchcode_lvl_n_a_c_z = 1 => -2.611999006,
    matchcode_lvl_n_a_c_z = 2 => -2.575019936,
    matchcode_lvl_n_a_c_z = 3 => -2.543973881,
    matchcode_lvl_n_a_c_z = 4 => -1.907361479,
                                 -1.759236278);

	age_last_seen_c120_rec_cell := (integer)((INTEGER)cell_ind = 1) * age_last_seen_c120_rec;

	pp_score := -2.152425827 +
		(integer)cell_ind * 1.4349129066 +
    age_last_seen_c120_rec * -0.008994549 +
    (integer)app_nonpub_match_gong * 1.0356119328 +
    (INTEGER)append_best_addr_match_flag * 0.4738231902 +
    (integer)rules_7_ind * 0.7673552294 +
    (integer)eda_hist_match_1_ind * -0.876424784 +
    (integer)src_rule_11_ind * 0.3414670756 +
    matchcode_lvl_n_a_c_z_l * 0.4091836379 +
    age_last_seen_c120_rec_cell * -0.012863423;

	pp_score_prob := exp(pp_score) / (1 + exp(pp_score));

	/* ***********************************************************************
	 * EDA Attributes Phone Section - Everything but PP and TH search levels *
	 *************************************************************************/
	matchcodes_a := contains_i(STD.Str.ToUpperCase(matchcodes_AP), 'A') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_CL), 'A') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_CR), 'A') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_ES), 'A') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_MD), 'A') > 0 or /*contains_i(STD.Str.ToUpperCase(matchcodes_PP), 'A') > 0 or*/ contains_i(STD.Str.ToUpperCase(matchcodes_SE), 'A') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_SP), 'A') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_SX), 'A') > 0;

	matchcodes_n := contains_i(STD.Str.ToUpperCase(matchcodes_AP), 'N') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_CL), 'N') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_CR), 'N') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_ES), 'N') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_MD), 'N') > 0 or /*contains_i(STD.Str.ToUpperCase(matchcodes_PP), 'N') > 0 or*/ contains_i(STD.Str.ToUpperCase(matchcodes_SE), 'N') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_SP), 'N') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_SX), 'N') > 0;

	matchcodes_c := contains_i(STD.Str.ToUpperCase(matchcodes_AP), 'C') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_CL), 'C') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_CR), 'C') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_ES), 'C') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_MD), 'C') > 0 or /*contains_i(STD.Str.ToUpperCase(matchcodes_PP), 'C') > 0 or*/ contains_i(STD.Str.ToUpperCase(matchcodes_SE), 'C') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_SP), 'C') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_SX), 'C') > 0;

	matchcodes_z := contains_i(STD.Str.ToUpperCase(matchcodes_AP), 'Z') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_CL), 'Z') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_CR), 'Z') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_ES), 'Z') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_MD), 'Z') > 0 or /*contains_i(STD.Str.ToUpperCase(matchcodes_PP), 'Z') > 0 or*/ contains_i(STD.Str.ToUpperCase(matchcodes_SE), 'Z') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_SP), 'Z') > 0 or contains_i(STD.Str.ToUpperCase(matchcodes_SX), 'Z') > 0;

	orth_lvl_sx_1 := 0;

	orth_lvl_sp_1 := 0;

	orth_lvl_md_1 := 0;

	orth_lvl_cl_1 := 0;

	orth_lvl_ap_1 := 0;

	orth_lvl_ap_es_se_sp_sx_1 := 0;

	orth_lvl_ap_cl_es_se_sx_1 := 0;

	orth_lvl_other_1 := 0;

	orth_lvl_md := map(
		wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_md_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 1 and wf_level_ind_SX = 0 => orth_lvl_md_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 1 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => 1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_md_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_md_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 1 and wf_level_ind_SX = 1 => orth_lvl_md_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_md_1,
                                                                                                                                                                                                   orth_lvl_md_1);

	orth_lvl_ap_cl_es_se_sx := map(
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_ap_cl_es_se_sx_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 1 and wf_level_ind_SX = 0 => orth_lvl_ap_cl_es_se_sx_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 1 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_ap_cl_es_se_sx_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_ap_cl_es_se_sx_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_ap_cl_es_se_sx_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 1 and wf_level_ind_SX = 1 => orth_lvl_ap_cl_es_se_sx_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => 1,
                                                                                                                                                                                                   orth_lvl_ap_cl_es_se_sx_1);

	orth_lvl_sx := map(
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => 1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 1 and wf_level_ind_SX = 0 => orth_lvl_sx_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 1 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_sx_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_sx_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_sx_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 1 and wf_level_ind_SX = 1 => orth_lvl_sx_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_sx_1,
                                                                                                                                                                                                   orth_lvl_sx_1);

	orth_lvl_cl := map(
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_cl_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 1 and wf_level_ind_SX = 0 => orth_lvl_cl_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 1 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_cl_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => 1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_cl_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 1 and wf_level_ind_SX = 1 => orth_lvl_cl_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_cl_1,
                                                                                                                                                                                                   orth_lvl_cl_1);

	orth_lvl_other := map(
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_other_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 1 and wf_level_ind_SX = 0 => orth_lvl_other_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 1 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_other_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_other_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_other_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 1 and wf_level_ind_SX = 1 => orth_lvl_other_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_other_1,
                                                                                                                                                                                                   1);

	orth_lvl_ap := map(
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_ap_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 1 and wf_level_ind_SX = 0 => orth_lvl_ap_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 1 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_ap_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_ap_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => 1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 1 and wf_level_ind_SX = 1 => orth_lvl_ap_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_ap_1,
                                                                                                                                                                                                   orth_lvl_ap_1);

	orth_lvl_ap_es_se_sp_sx := map(
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_ap_es_se_sp_sx_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 1 and wf_level_ind_SX = 0 => orth_lvl_ap_es_se_sp_sx_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 1 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_ap_es_se_sp_sx_1,
    wf_level_ind_AP = 0 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_ap_es_se_sp_sx_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 0 and wf_level_ind_MD = 0 and wf_level_ind_SE = 0 and wf_level_ind_SP = 0 and wf_level_ind_SX = 0 => orth_lvl_ap_es_se_sp_sx_1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 0 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 1 and wf_level_ind_SX = 1 => 1,
    wf_level_ind_AP = 1 and wf_level_ind_CL = 1 and wf_level_ind_CR = 0 and wf_level_ind_ES = 1 and wf_level_ind_MD = 0 and wf_level_ind_SE = 1 and wf_level_ind_SP = 0 and wf_level_ind_SX = 1 => orth_lvl_ap_es_se_sp_sx_1,
                                                                                                                                                                                                   orth_lvl_ap_es_se_sp_sx_1);

	orth_other_se := orth_lvl_other * wf_level_ind_SE;

	orth_other_sx := orth_lvl_other * wf_level_ind_SX;

	orth_other_ap := orth_lvl_other * wf_level_ind_AP;

	orth_oth_es := map(
    orth_lvl_other = 0  => 0,
    wf_level_ind_ES = 0 => 1,
                           2);

	orth_oth_es_se := map(
    orth_oth_es = 0                       => 0,
    orth_oth_es = 1 and orth_other_se = 0 => 1,
                                             orth_oth_es + 1);

	orth_oth_es_se_sx := map(
    orth_oth_es_se <= 1                      => orth_oth_es_se,
    orth_oth_es_se = 2 and orth_other_sx = 0 => orth_oth_es_se,
                                                orth_oth_es_se + 1);

	orth_oth_es_se_sx_ap := map(
    orth_oth_es_se_sx = 0                       => 1,
    orth_oth_es_se_sx = 1 and orth_other_ap = 0 => 0,
    orth_oth_es_se_sx = 2                       => 2,
    orth_oth_es_se_sx = 1 and orth_other_ap = 1 => 3,
    orth_oth_es_se_sx = 3 and orth_other_ap = 0 => 4,
    orth_oth_es_se_sx = 3 and orth_other_ap = 1 => 5,
                                                   6);

	orth_oth_es_se_sx_ap_l := map(
    orth_oth_es_se_sx_ap = 0 => -2.837406222,
    orth_oth_es_se_sx_ap = 1 => -2.652410061,
    orth_oth_es_se_sx_ap = 2 => -1.96746787,
    orth_oth_es_se_sx_ap = 3 => -1.634130525,
    orth_oth_es_se_sx_ap = 4 => -1.270034555,
    orth_oth_es_se_sx_ap = 5 => -1.18255871,
                                -1.010717909);

	match_orth_ap_cl_es_se_sx_c := orth_lvl_ap_cl_es_se_sx * (integer)matchcodes_c;

	days_in_service_rec := if(TRIM(days_in_service) = '', 3000, (INTEGER)days_in_service);

	num_phones_connected_addr_rec := if(TRIM(num_phones_connected_addr) = '', 4, min(if(TRIM(num_phones_connected_addr) = '', -NULL, (INTEGER)num_phones_connected_addr), 3));

	num_phone_owners_cur_c2 := if(TRIM(num_phone_owners_cur) = '', NULL, min(if(TRIM(num_phone_owners_cur) = '', -NULL, (INTEGER)num_phone_owners_cur), 2));
	// num_phone_owners_cur_c2 := min(if((STRING)num_phone_owners_cur = '', -NULL, num_phone_owners_cur), 2);

	num_phone_owners_cur_c2_rec := if(num_phone_owners_cur_c2 = NULL, 0, num_phone_owners_cur_c2);

	dwell_eda_subj_lvl := map(
    eda_attr_subj = ''                     => 0,
    eda_attr_subj = '0' and dwelling = 'S' => 1,
    eda_attr_subj = '0' and dwelling = ''  => 2,
    eda_attr_subj = '0' and dwelling = 'M' => 3,
    eda_attr_subj = '1' and dwelling = 'M' => 4,
    eda_attr_subj = '1' and dwelling = ''  => 5,
                                              6);

	dwell_eda_subj_lvl_l := map(
    dwell_eda_subj_lvl = 0 => -3.213863283,
    dwell_eda_subj_lvl = 1 => -3.110142625,
    dwell_eda_subj_lvl = 2 => -2.857679396,
    dwell_eda_subj_lvl = 3 => -2.831314008,
    dwell_eda_subj_lvl = 4 => -2.282382386,
    dwell_eda_subj_lvl = 5 => -1.746908903,
                              -1.730293147);

	address_match_best_rec := if(TRIM(address_match_best) = '', 2, (integer)address_match_best);
	// address_match_best_rec := (integer)address_match_best;

	match_orth_ap_cl_es_se_sx_n := orth_lvl_ap_cl_es_se_sx * (integer)matchcodes_n;

	match_orth_md_c := orth_lvl_md * (integer)matchcodes_c;

	match_orth_ap_es_se_sp_sx_n := orth_lvl_ap_es_se_sp_sx * (integer)matchcodes_n;

	match_orth_other_n := orth_lvl_other * (integer)matchcodes_n;

	match_orth_sx_n := orth_lvl_sx * (integer)matchcodes_n;

	eda_score := -0.104224489 +
    (integer)matchcodes_n * 2.1347669415 +
    orth_oth_es_se_sx_ap_l * 0.4912835663 +
    match_orth_ap_cl_es_se_sx_c * 1.2381794583 +
    orth_lvl_ap_es_se_sp_sx * 0.979799581 +
    days_in_service_rec * -0.000325594 +
    num_phones_connected_addr_rec * -0.291239147 +
    (integer)matchcodes_z * 0.4721715951 +
    num_phone_owners_cur_c2_rec * -0.340447483 +
    orth_lvl_ap * -1.156161409 +
    dwell_eda_subj_lvl_l * 0.4222739772 +
    address_match_best_rec * 0.5575855546 +
    orth_lvl_cl * -0.320926973 +
    match_orth_ap_cl_es_se_sx_n * -1.758226107 +
    (integer)matchcodes_a * 0.2980517317 +
    match_orth_md_c * 0.4878367975 +
    match_orth_ap_es_se_sp_sx_n * -1.576208606 +
    match_orth_other_n * -1.195848439 +
    match_orth_sx_n * -0.756372791;

	eda_score_prob := exp(eda_score) / (1 + exp(eda_score));

	/* ***********************************************************************
	 *      Pick the appropriate score part to use and return it.            *
	 *************************************************************************/
	phones_score_prob := if(wf_level_ind_pp = 1 OR wf_level_ind_th = 1, pp_score_prob, eda_score_prob);

	phones_score_logit := if(wf_level_ind_pp = 1 OR wf_level_ind_th = 1, pp_score, eda_score);

	point := 40;

	base := 600;

	odds := .11111;

	phones_score_temp := round(point * (ln(phones_score_prob / (1 - phones_score_prob)) - ln(odds)) / ln(2) + base);
	
	phones_score_cap := MIN(MAX(phones_score_temp, 0), 999);
	
	// If the phone is not part of the standard waterfall phones solution, override the score
	override_score := TRIM(phone_type) IN ['NE', 'RL', 'WK', 'TH', ''];
	
	phones_score := IF(override_score = TRUE, 100, phones_score_cap);
	
		#if(MODEL_DEBUG)
			/* Model Inputs */
			// These are handled by SELF := le;

			/* Model Variables */
			SELF.archive_date := archive_date;
			SELF.cell_ind := cell_ind;
			SELF._month := _month;
			SELF.age_last_seen := age_last_seen;
			SELF.age_last_seen_c120 := age_last_seen_c120;
			SELF.age_last_seen_c120_rec := age_last_seen_c120_rec;
			SELF.app_nonpub_match_1_ind := app_nonpub_match_1_ind;
			SELF.app_nonpub_match_2_ind := app_nonpub_match_2_ind;
			SELF.app_nonpub_match_gong := app_nonpub_match_gong;
			SELF.rules_7_ind := rules_7_ind;
			SELF.eda_hist_match_1_ind := eda_hist_match_1_ind;
			SELF.src_rule_11_ind := src_rule_11_ind;
			SELF.matchcode_n := matchcode_n;
			SELF.matchcode_a := matchcode_a;
			SELF.matchcode_c := matchcode_c;
			SELF.matchcode_z := matchcode_z;
			SELF.matchcode_lvl_n_a := matchcode_lvl_n_a;
			SELF.matchcode_lvl_n_a_c := matchcode_lvl_n_a_c;
			SELF.matchcode_lvl_n_a_c_z := matchcode_lvl_n_a_c_z;
			SELF.matchcode_lvl_n_a_c_z_l := matchcode_lvl_n_a_c_z_l;
			SELF.age_last_seen_c120_rec_cell := age_last_seen_c120_rec_cell;
			SELF.pp_score := pp_score;
			SELF.pp_score_prob := pp_score_prob;
			SELF.matchcodes_a := matchcodes_a;
			SELF.matchcodes_n := matchcodes_n;
			SELF.matchcodes_c := matchcodes_c;
			SELF.matchcodes_z := matchcodes_z;
			SELF.orth_lvl_sx_1 := orth_lvl_sx_1;
			SELF.orth_lvl_sp_1 := orth_lvl_sp_1;
			SELF.orth_lvl_md_1 := orth_lvl_md_1;
			SELF.orth_lvl_cl_1 := orth_lvl_cl_1;
			SELF.orth_lvl_ap_1 := orth_lvl_ap_1;
			SELF.orth_lvl_ap_es_se_sp_sx_1 := orth_lvl_ap_es_se_sp_sx_1;
			SELF.orth_lvl_ap_cl_es_se_sx_1 := orth_lvl_ap_cl_es_se_sx_1;
			SELF.orth_lvl_other_1 := orth_lvl_other_1;
			SELF.orth_lvl_md := orth_lvl_md;
			SELF.orth_lvl_ap_cl_es_se_sx := orth_lvl_ap_cl_es_se_sx;
			SELF.orth_lvl_sx := orth_lvl_sx;
			SELF.orth_lvl_cl := orth_lvl_cl;
			SELF.orth_lvl_other := orth_lvl_other;
			SELF.orth_lvl_ap := orth_lvl_ap;
			SELF.orth_lvl_ap_es_se_sp_sx := orth_lvl_ap_es_se_sp_sx;
			SELF.orth_other_se := orth_other_se;
			SELF.orth_other_sx := orth_other_sx;
			SELF.orth_other_ap := orth_other_ap;
			SELF.orth_oth_es := orth_oth_es;
			SELF.orth_oth_es_se := orth_oth_es_se;
			SELF.orth_oth_es_se_sx := orth_oth_es_se_sx;
			SELF.orth_oth_es_se_sx_ap := orth_oth_es_se_sx_ap;
			SELF.orth_oth_es_se_sx_ap_l := orth_oth_es_se_sx_ap_l;
			SELF.match_orth_ap_cl_es_se_sx_c := match_orth_ap_cl_es_se_sx_c;
			SELF.days_in_service_rec := days_in_service_rec;
			SELF.num_phones_connected_addr_rec := num_phones_connected_addr_rec;
			SELF.num_phone_owners_cur_c2 := num_phone_owners_cur_c2;
			SELF.num_phone_owners_cur_c2_rec := num_phone_owners_cur_c2_rec;
			SELF.dwell_eda_subj_lvl := dwell_eda_subj_lvl;
			SELF.dwell_eda_subj_lvl_l := dwell_eda_subj_lvl_l;
			SELF.address_match_best_rec := address_match_best_rec;
			SELF.match_orth_ap_cl_es_se_sx_n := match_orth_ap_cl_es_se_sx_n;
			SELF.match_orth_md_c := match_orth_md_c;
			SELF.match_orth_ap_es_se_sp_sx_n := match_orth_ap_es_se_sp_sx_n;
			SELF.match_orth_other_n := match_orth_other_n;
			SELF.match_orth_sx_n := match_orth_sx_n;
			SELF.eda_score := eda_score;
			SELF.eda_score_prob := eda_score_prob;
			SELF.phones_score_prob := phones_score_prob;
			SELF.phones_score_logit := phones_score_logit;
			SELF.point := point;
			SELF.base := base;
			SELF.odds := odds;
			SELF.phones_score := phones_score;
			
			SELF := le;
			SELF := [];
	#else
		SELF.phone_score := (STRING)phones_score;
		
		SELF := le;
		SELF := [];
	#end
	END;
/* ***********************************************************************
 * We need to pass each phone in the waterfall phones process through    *
 * the phone_score transform.                                            *
 *************************************************************************/
 #if(MODEL_DEBUG)
	layout_experian_phones_plus := RECORD
		progressive_phone.layout_experian_phones;
		Progressive_Phone.Common.Layout_Debug_v1 - progressive_phone.layout_progressive_phone_common; // Keep the attributes around!
	END;

	layout_progressive_phone_common_plus := RECORD
		// progressive_phone.layout_progressive_phone_common;
		Progressive_Phone.Common.Layout_Debug_v1; // Keep the attributes around!
	END;

	phonesScoredTemp := PROJECT(modelInput, doModel(LEFT));
	phonesScored := PROJECT(phonesScoredTemp, TRANSFORM(layout_progressive_phone_common_plus, SELF := LEFT; SELF := []));
#else
	phonesScored := PROJECT(modelInput, doModel(LEFT));
#end
	
	totalPhonesScored := COUNT(phonesScored);
	
/* ***********************************************************************
 * Once the phones have been scored they must be run through Experian    *
 * phone logic.  Batch can only use the flat file to increase found      *
 * phone scores - they cannot at this time call the gateway for unique   *
 * phones.                                                               *
 *************************************************************************/
 
	// We only want to boost the score or look for unique phones that match the input DID
	didsIn := PROJECT(DEDUP(SORT(inputDIDsBest, AcctNo, DID), AcctNo, DID), 
				TRANSFORM(progressive_phone.layout_experian_phones,
					SELF.DID := LEFT.DID,
					SELF.AcctNo := LEFT.AcctNo,
					self.subj_first := left.fname,
          self.subj_middle := left.mname,
          self.subj_last := left.lname, 
					SELF := []));
	
	// tempExperian
	progressive_phone.layout_experian_phones getExperian(progressive_phone.layout_experian_phones le, Experian_Phones.Key_Did_Digits ri) := TRANSFORM
		SELF.AcctNo := le.AcctNo;
		SELF.DID := if(ri.PIN_did <> 0 , ri.PIN_did, le.DID);
		SELF.ExperianPIN := ri.Encrypted_Experian_PIN;
		SELF.Phone_Last3Digits := ri.Phone_digits;
		SELF.phone_score := (STRING)ri.score;
		self.subj_last := if(ri.PIN_lname<>'' ,ri.PIN_lname,if( ri.rec_type <> 'SP',le.subj_last,''));
		self.subj_first := if(ri.PIN_lname<>'',ri.PIN_fname,if( ri.rec_type <> 'SP',le.subj_first,''));
		self.subj_middle := if(ri.PIN_lname<>'' ,ri.PIN_mname,if( ri.rec_type <> 'SP',le.subj_middle,''));
		self.subj_phone_relationship := if(ri.rec_type <> 'SP', 'Subject', 'Spouse');
		self := [];
	END;
	experianPhones := JOIN(didsIn, Experian_Phones.Key_Did_Digits, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.DID), getExperian(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.max_atmost), KEEP(ut.limits.PHONE_PER_PERSON));

	#if(MODEL_DEBUG)
	layout_experian_phones_plus grabExperian(layout_progressive_phone_common_plus le, experianPhones ri) := TRANSFORM
	#else
	progressive_phone.layout_experian_phones grabExperian(progressive_phone.layout_progressive_phone_common le, experianPhones ri) := TRANSFORM
	#end
		// Only augment phones that we were previously able to score
		keeper := le.phone_score <> '100';
		
		// Save the unique experian info
		SELF.ExperianPIN := IF(keeper, ri.ExperianPIN, ''); 
		SELF.Phone_Last3Digits := IF(keeper, ri.Phone_Last3Digits, '');
		
		// Existing LN phone found on Experian gateway - Augment the score by 30.
		SELF.phone_score := IF(le.subj_phone10[8..10] = ri.Phone_Last3Digits AND keeper, (STRING)((UNSIGNED)le.phone_score + 30), le.phone_score);
		
		SELF := le;
	END;
	flatFile := JOIN(phonesScored, experianPhones, LEFT.DID <> 0 AND TRIM(LEFT.subj_phone10) <> '' AND LEFT.AcctNo = RIGHT.AcctNo AND
																								 LEFT.DID = RIGHT.DID AND LEFT.subj_phone10[8..10] = RIGHT.Phone_Last3Digits, 
																grabExperian(LEFT, RIGHT), LEFT OUTER, LIMIT(RiskWise.max_atmost, SKIP), KEEP(totalPhonesScored));
	//flat file has bumped score.
	#if(MODEL_DEBUG)
	layout_progressive_phone_common_plus getSubjects(in_batch_rec le, layout_progressive_phone_common_plus ri) := TRANSFORM
	#else
	progressive_phone.layout_progressive_phone_common getSubjects(in_batch_rec le, progressive_phone.layout_progressive_phone_common ri) := TRANSFORM
	#end
		SELF.AcctNo := le.AcctNo;
		SELF.DID := le.DID;
		
		// If we have the DID information from the right, use the right, otherwise this is a unique phone not found
		// in the waterfall phones process
		useRight := le.DID = ri.DID;
		
		SELF.ssn := IF(useRight, ri.SSN, le.SSN);
		SELF.subj_phone10 := IF(useRight, ri.subj_phone10, ''); // le.Phone10
		SELF.subj_first := IF(useRight, ri.subj_first, le.FName);
		SELF.subj_middle := IF(useRight, ri.subj_middle, le.MName);
		SELF.subj_last := IF(useRight, ri.subj_last, le.LName);
		
		SELF.st := IF(useRight, ri.st, le.st);
		SELF.zip5 := IF(useRight, ri.zip5, le.z5);
		SELF.p_city_name := IF(useRight, ri.p_city_name, le.p_city_name);
		SELF.prim_range := IF(useRight, ri.prim_range, le.prim_range);
		SELF.predir := IF(useRight, ri.predir, le.predir);
		SELF.prim_name := IF(useRight, ri.prim_name, le.prim_name);
		SELF.addr_suffix := IF(useRight, ri.addr_suffix, le.addr_suffix);
		SELF.postdir := IF(useRight, ri.postdir, le.postdir);
		SELF.unit_desig := IF(useRight, ri.unit_desig, le.unit_desig);
		SELF.sec_range := IF(useRight, ri.sec_range, le.sec_range);
		
		// Since we are only using the input DIDs, this should always be the subject phone
		SELF.subj_phone_relationship := 'Subject';
		
		#if(MODEL_DEBUG)
		SELF := ri; // Keep the potential attributes around
		#end
		SELF := [];
	END;
	
	// Keep only the phonesScored that match input DID since SUBJECT doesn't always mean input subject.  It's possible the waterfall phones 
	// process didn't find any phones for the input DID either - so we need to keep the left outer DIDs.
	subjectPhones := JOIN(inputDIDsBest, phonesScored, LEFT.AcctNo = RIGHT.AcctNo AND LEFT.DID = RIGHT.DID, getSubjects(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.max_atmost), KEEP(totalPhonesScored));
	
	#if(MODEL_DEBUG)
	layout_experian_phones_plus grabUnique(progressive_phone.layout_experian_phones le) := TRANSFORM
	#else
 	layout_experian_phones grabUnique(progressive_phone.layout_experian_phones le) := TRANSFORM
	#end
   		// Flat file information
   		SELF.ExperianPin := le.ExperianPIN;
   		SELF.Phone_Last3Digits := le.Phone_Last3Digits;
   		SELF.Phone_Score := le.Phone_Score;
   		SELF.DID := le.DID;
   		SELF.AcctNo := le.AcctNo;
   		
   		 // Need to get this from the gateway
   		SELF.subj_phone10 := '';
   		SELF.switch_type := '';
   		SELF.subj_date_last := '';
   		
   		 // Mark this as an Experian (Metronet) Gateway phone - this is for royalty tracking purposes
   		SELF.subj_phone_type_new := MDR.sourceTools.src_Metronet_Gateway;
   		SELF.phpl_phone_carrier := '';
   		
   		// Blank unknown info since we are getting this information from the gateway
   		SELF.matches := TRUE;
   		SELF.match_name := FALSE;
   		SELF.match_street_address := FALSE;
   		SELF.match_city := FALSE;
   		SELF.match_state := FALSE;
   		SELF.match_zip := FALSE;
   		SELF.match_ssn := FALSE;
   		SELF.match_did := TRUE;
   		SELF.matchcodes := '';
   		SELF.subj_phone_type := '';
   		SELF.subj_date_first := '';
   		SELF.phpl_phones_plus_type := '';
   		SELF.phpl_carrier_city := '';
   		SELF.phpl_carrier_state := '';
   		SELF.sort_order_internal := 0;
   		SELF.sort_order := 0;
   		SELF.sub_rule_number := 0;
   		SELF.dup_phone_flag := 'N';
   		SELF.vendor := '';
   
   		// The rest of the information fill in best we can
   		SELF := le;
			#if(MODEL_DEBUG)
			SELF := [];
			#end
   	END;

    // The compiler stopped liking the ATMOST condition when the experianPhonesFilt filter was
		// part of the uniqueExperianTemp JOIN condition.
		experianPhonesFilt := experianPhones(DID <> 0 AND TRIM(Phone_Last3Digits) <> '');
 
		// we are not checking for RIGHT.DID = LEFT.DID because the spouse might have the same 3 digit phone but a different DID based on the join above to create experianPhones
	  uniqueExperianTemp := JOIN(experianPhonesFilt, subjectPhones,
															 LEFT.AcctNo = RIGHT.AcctNo AND LEFT.Phone_Last3Digits = RIGHT.subj_phone10[8..10],
															 grabUnique(LEFT), LEFT ONLY, 
															 ATMOST(ut.limits.PHONE_PER_PERSON));
		
	// Keep the highest scoring Experian Phone per Account Number
	// We only want unique experian phones that score at or above 630.  Don't make a gateway call for anything less than that
	#if(MODEL_DEBUG)
	layout_experian_phones_plus keepBest(layout_experian_phones_plus le, layout_experian_phones_plus ri) := TRANSFORM
	#else
	progressive_phone.layout_experian_phones keepBest(progressive_phone.layout_experian_phones le, progressive_phone.layout_experian_phones ri) := TRANSFORM
	#end
		SELF := IF((UNSIGNED)le.phone_score > (UNSIGNED)ri.phone_score, le, ri);
	END;
	
	// Return all the experian records which will be used to hit the metronet gateway
	uniqueExperian := ROLLUP(uniqueExperianTemp((UNSIGNED)Phone_Score >= MetronetScoreThreshold),
													LEFT.AcctNo = RIGHT.AcctNo, keepBest(LEFT, RIGHT));
	
	combo := flatFile + uniqueExperian;
	
	// Only allow the use of the Experian Flat File if there is a GLB Permissible Purpose and if the use of Experian Data is not restricted
	#if(MODEL_DEBUG)
	phonesScoredExperian := PROJECT(phonesScored, TRANSFORM(layout_experian_phones_plus, SELF := LEFT));
	#else
	phonesScoredExperian := PROJECT(phonesScored, TRANSFORM(Progressive_Phone.layout_experian_phones, SELF := LEFT));
	#end
	// REMOVE PFR AND USE EXPERIAN-----------------------
	final := MAP(~isPFR and ut.PermissionTools.glb.OK(GLBPurpose) AND ~Doxie.DataRestriction.isECHRestricted(Data_Restriction_Mask) => combo,
								isPFR and ut.PermissionTools.glb.OK(GLBPurpose) AND ~Doxie.DataRestriction.ExperianPhones => combo,
								phonesScoredExperian);
	
	final_out := ungroup(dedup(sort(group(final,acctno,subj_phone_type_new,subj_phone10,all),-phone_score),acctno,subj_phone_type_new,subj_phone10));
	// this is attempting to dedup phones so that there is only copy of a specific phone coming from a specific level for one acctno
	//  And we want to keep the record with the highest score.

	/* ****************************************
   *  Uncomment for debugging purposes only *
   ******************************************/
		// #STORED('EDAJoinResults', inputEDATemp);
	/* ****************************************
   *  End debugging section                 *
   ******************************************/
	 
	RETURN(final_out);
END;