IMPORT CriminalRecords_BatchService, FraudGovPlatform_Services, FraudShared_Services,Patriot , ut;

EXPORT Functions := MODULE
	
	EXPORT getExternalServicesRecs(	DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in, 
																	FraudGovPlatform_Services.IParam.BatchParams batch_params ) := FUNCTION

		recs_Death := FraudGovPlatform_Services.Raw.GetDeath(ds_batch_in, batch_params);
		recs_Criminal := FraudGovPlatform_Services.Raw.GetCriminal(ds_batch_in, batch_params);
		recs_RedFlag := FraudGovPlatform_Services.Raw.GetRedFlags(ds_batch_in, batch_params);
		recs_Patriot := FraudGovPlatform_Services.Raw.GetGlobalWatchlist(ds_batch_in, batch_params);
		
		FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw xfm_Compilation(FraudShared_Services.Layouts.BatchIn_rec L) := TRANSFORM
			SELF.batchin_rec := L;
			SELF.childRecs_Death := recs_Death(acctno = L.acctno);
			SELF.childRecs_Criminal := recs_Criminal(acctno = L.acctno);
			SELF.childRecs_RedFlag := recs_RedFlag(seq = (INTEGER)L.acctno);
			SELF.childRecs_Patriot := UNGROUP(recs_Patriot(acctno = L.acctno));
			SELF := L;
			SELF := [];
		END;

		final_recs := PROJECT(ds_batch_in, xfm_Compilation(LEFT));
		
		// Added for QA to display raw records coming out of external services, so its easy for them to test knownfrauds.
		#IF(FraudGovPlatform_Services.Constants.IS_DEBUG)
			output(recs_Death, named('recs_Death'));
			output(recs_Criminal, named('recs_Criminal'));
			output(recs_RedFlag, named('recs_RedFlag'));
			output(recs_Patriot, named('recs_Patriot'));
		#END
		
		return final_recs;
	END;
		
	EXPORT getKnownFraudRecs(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
														FraudGovPlatform_Services.IParam.BatchParams batch_params,
														DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) ds_payloads_in) := FUNCTION

		FraudGovPlatform_Services.Layouts.KnownFrauds_rec xfm_KNFDCompilation(FraudShared_Services.Layouts.BatchIn_rec L,
																																					DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) R ) := TRANSFORM
		
			ds_sorted := SORT(R, -event_date);
			SELF.payload := ds_sorted;
			SELF := L;
		END;

		knownFraudResults := DENORMALIZE(	ds_batch_in, ds_payloads_in, 
																			LEFT.acctno = RIGHT.acctno,
																			GROUP,
																			xfm_KNFDCompilation(LEFT, ROWS(RIGHT)),
																			LEFT OUTER);
		RETURN knownFraudResults;
		
	END;
		
	EXPORT getVelocityRecs(	DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
													FraudGovPlatform_Services.IParam.BatchParams batch_params,
													DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) ds_payload) := FUNCTION

		contributionType_recs_norm := FraudShared_Services.Functions.getFragmentMatchTypes(ds_batch_in, ds_payload, batch_params);

		rules := FraudShared_Services.Functions.GetVelocityRules(batch_params);

		velocity_recs := FraudShared_Services.Functions.GetVelocityExceeded(contributionType_recs_norm, rules);

		velocity_top_recs:= FraudShared_Services.Functions.GetTopVelocityExceeded(velocity_recs, batch_params.maxvelocities);

		ds_rec_velocity_recs_denorm_w_payload:= FraudShared_Services.Functions.AddPayload(velocity_top_recs,ds_payload);

		FraudGovPlatform_Services.Layouts.velocities xform_out(ds_rec_velocity_recs_denorm_w_payload l) := TRANSFORM
			SELF.acctno := (STRING)l.acctno,	
			SELF.ds_payload := l.ds_payload,
			SELF :=  l;
		END;

		ds_velocities :=  PROJECT(SORT(ds_rec_velocity_recs_denorm_w_payload,  acctno),  xform_out(LEFT));

		RETURN ds_velocities;
	END;	
	
	EXPORT getKnownFrauds(DATASET(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw) ds_records) := FUNCTION

		slim_knownrisk_rec := RECORD
			STRING20 acctno;
			STRING100 known_risk_reason;
			STRING8 event_date;
			STRING30 event_type;
		END;
		
		input_name_match(string fname_in, string lname_in, string mname_in, string fname_r, string lname_r, string mname_r) := FUNCTION
			BOOLEAN nameMatched := fname_in = fname_r AND lname_in = lname_r AND mname_in = mname_r; //strict matching of mname since req. says "match on Full Name"
			RETURN nameMatched;
		END;

		death_knownrisk_ds := JOIN(ds_records, ds_records.childrecs_death, 
															LEFT.batchin_rec.acctno = RIGHT.acctno,
															TRANSFORM(slim_knownrisk_rec,
																SELF.acctno := RIGHT.acctno,
																SELF.known_risk_reason := MAP(RIGHT.matchcode IN ['SN', 'S', 'ANSZC', 'ANSZ', 'ANSC', 'ANS', 'SNCZ', 'SNC', 'SNZ'] AND
																															LEFT.batchin_rec.dob = RIGHT.dob8 => 'Identity is deceased on ' + ut.date_YYYYMMDDtoDateSlashed(RIGHT.dod8),
																															
																															(LEFT.batchin_rec.did = (unsigned6) RIGHT.did and RIGHT.matchcode = '') OR
																															(RIGHT.matchcode IN ['N','Z','NZ'] AND
																															LEFT.batchin_rec.dob = RIGHT.dob8) => 'Identity elements associated with deceased individual on ' + ut.date_YYYYMMDDtoDateSlashed(RIGHT.dod8),
																														 
																														 ''),
																SELF.event_date := RIGHT.dod8,
																SELF.event_type := 'Death'));
		
		//*** CRIM KNOWN RISKS ***//
		crim_recs_raw := PROJECT(ds_records.childrecs_criminal, TRANSFORM(CriminalRecords_BatchService.Layouts.batch_out, SELF := LEFT, SELF := []));
		
		crim_recs_slim_rec := RECORD
			string20 acctno;
			string8 dob;
			string9 ssn;
			string30 lname;
			string30 fname;
			string30 mname;
			string1 curr_incar_flag;
			string8 offense_date;
		END;
		
		crim_recs_slim_rec NormIt(CriminalRecords_BatchService.Layouts.batch_out L , INTEGER C) := TRANSFORM
			SELF := L;
			SELF.offense_date := CHOOSE(C, L.off_date_1, L.off_date_2, L.off_date_3, L.off_date_4, L.off_date_5, L.off_date_6);
		END;
		
		crim_recs_norm := NORMALIZE(crim_recs_raw, 6 , NormIt(LEFT,COUNTER));
		crim_recs_norm_dedup := DEDUP(SORT(crim_recs_norm, acctno, -offense_date), acctno, offense_date);
		
		crim_knownrisk_ds := JOIN(ds_records, crim_recs_norm_dedup,
															LEFT.batchin_rec.acctno = RIGHT.acctno,
																TRANSFORM(slim_knownrisk_rec,
																	SELF.acctno := LEFT.batchin_rec.acctno,

																	name_ssn_dob_match := input_name_match(LEFT.batchin_rec.name_first, LEFT.batchin_rec.name_last, LEFT.batchin_rec.name_middle,
																																				 RIGHT.fname,RIGHT.lname,RIGHT.mname) AND 
																											  LEFT.batchin_rec.dob = RIGHT.dob AND
																												LEFT.batchin_rec.ssn = RIGHT.ssn;
																	
																	// Commented lines are actaully work for GRP-247 and will be added later on....not part of 11/14 roxie release.
																	SELF.known_risk_reason :=	MAP(name_ssn_dob_match AND RIGHT.curr_incar_flag = 'Y' => 'Identity is Incarcerated',
																																name_ssn_dob_match AND RIGHT.curr_incar_flag <> 'Y' => 'Identity has been convicted of fraud', 
																																~name_ssn_dob_match AND RIGHT.curr_incar_flag = 'Y' => 'Identity is associated with an incarcerated individual',
																																~name_ssn_dob_match AND RIGHT.curr_incar_flag <> 'Y' AND 
																																(RIGHT.fname <> '' OR RIGHT.lname <> '' OR RIGHT.ssn <> '') => 'Identity is associated with an individual convicted of fraud',
																															 '');
																	SELF.event_date := RIGHT.offense_date;
																	SELF.event_type := 'Criminal'));				
																	
		//*** RED FLAG KNOWN RISKS ***//
		
		ds_red_flag_temp := NORMALIZE(ds_records.childRecs_redFlag, 12, FraudGovPlatform_Services.Transforms.xnorm_red_flag(LEFT, COUNTER));
		
		FraudGovPlatform_Services.Layouts.red_flag_desc_w_cat_weight xnorm_red_flag_w_weight(FraudGovPlatform_Services.Layouts.red_flag_desc_w_details l, 
																																																																																FraudGovPlatform_Services.Layouts.red_flag_desc r) := TRANSFORM
				SELF := r;
				SELF := l;
		END;
		
		ds_red_flag_temp2 := NORMALIZE(ds_red_flag_temp, LEFT.hri_details, xnorm_red_flag_w_weight(LEFT,RIGHT));
		
		ds_red_flag_sorted := SORT(ds_red_flag_temp2, seq, category_weight, hri_weight);

		red_flag_knownrisk_ds := JOIN(ds_records, ds_red_flag_sorted,
																														LEFT.batchin_rec.acctno = (STRING)RIGHT.seq,
																																TRANSFORM(slim_knownrisk_rec,
																																		SELF.acctno := LEFT.batchin_rec.acctno,
																																		SELF.known_risk_reason :=	RIGHT.desc;
																																		SELF.event_date := '';
																																		SELF.event_type := 'RedFlag'));	

		// *** PATRIOT/GLOBAL WATCH LIST KNOWN RISKS ***
		patriot_recs_raw := PROJECT(ds_records.childRecs_Patriot, TRANSFORM(Patriot.layout_batch_out, SELF := LEFT, SELF := []));
		patriot_knownrisk_ds := JOIN(ds_records, patriot_recs_raw,
																LEFT.batchin_rec.acctno = RIGHT.acctno,
																	TRANSFORM(slim_knownrisk_rec,
																		SELF.acctno := LEFT.batchin_rec.acctno,
																		SELF.known_risk_reason :=	'Name match on the Global watch list';
																		SELF.event_date := ''; //No date to add. 
																		SELF.event_type := 'Patriot'));
																		
		//*** KNFD KNOWN RISKS ***//
		FraudGovPlatform_Services.Layouts.KnownFrauds_rec trans (FraudGovPlatform_Services.Layouts.KnownFrauds_rec R) := TRANSFORM
			SELF := R;
		END;
		
		knfd_raw_ds := NORMALIZE(ds_records, LEFT.childRecs_KnownFrauds_raw, trans(RIGHT));
		
		FraudShared_Services.Layouts.Raw_Payload_rec trans1 (FraudShared_Services.Layouts.Raw_Payload_rec R) := TRANSFORM
			SELF := R;
		END;
		
		knfd_payload_ds := NORMALIZE(knfd_raw_ds, LEFT.payload, trans1(RIGHT));
		
		knfd_knownrisk_ds := PROJECT(knfd_payload_ds,
																	TRANSFORM(slim_knownrisk_rec,
																		SELF.acctno := LEFT.acctno,
																		SELF.known_risk_reason := FraudGovPlatform_Services.Utilities.getKnownFraudDescriptionFromPayload(LEFT.event_date,
																																																	LEFT.event_end_date,
																																																	LEFT.Event_Type_1,
																																																	LEFT.Event_Type_2,
																																																	LEFT.Event_Type_3);
																		SELF.event_date := LEFT.event_date, 
																		SELF.event_type := 'KNFD'));
		
		//*** COMBINED KNOWN RISKS ***//
		known_risk_ds := sort(patriot_knownrisk_ds + death_knownrisk_ds + crim_knownrisk_ds + knfd_knownrisk_ds + red_flag_knownrisk_ds, acctno, -event_date)(known_risk_reason <> '');

		#IF(FraudGovPlatform_Services.Constants.IS_DEBUG)
			output(ds_records, named('ds_records'));															
			// output(death_knownrisk_ds, named('death_knownrisk_ds'));
			// output(crim_knownrisk_ds, named('crim_knownrisk_ds'));
			// output(patriot_knownrisk_ds, named('patriot_knownrisk_ds'));
			// output(knfd_knownrisk_ds, named('knfd_knownrisk_ds'));
			// output(known_risk_ds, named('known_risk_ds'));
		#END
		
		return known_risk_ds;
	END;

	EXPORT getFlatBatchOut(	DATASET(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw) ds_records) := FUNCTION

		ds_knownFraud := getKnownFrauds(ds_records);
		
		FraudGovPlatform_Services.Layouts.BatchOut_rec xfm_pre_batchout(FraudGovPlatform_Services.Layouts.Batch_out_pre_w_raw L) := TRANSFORM
			SELF.Seq := L.batchin_rec.Seq;
			SELF.LexID := L.batchin_rec.did;
			SELF.identity_resolved := IF(L.batchin_rec.did <> 0 , 'Y', 'N');
			
			unsigned4 VEL_CNT := COUNT(L.childRecs_Velocities);
			SELF.velocity_exceeded_cnt := VEL_CNT;
			SELF.velocity_exceeded_reason1 := IF(VEL_CNT >= 1, L.childRecs_Velocities[1].description, '');
			SELF.velocity_exceeded_reason2 := IF(VEL_CNT >= 2, L.childRecs_Velocities[2].description, '');
			SELF.velocity_exceeded_reason3 := IF(VEL_CNT >= 3, L.childRecs_Velocities[3].description, '');

			SELF := L;
			SELF := [];
		END;

		pre_ds_results := PROJECT(ds_records, xfm_pre_batchout(LEFT));
		
		FraudGovPlatform_Services.Layouts.BatchOut_rec xfm_batchout(FraudGovPlatform_Services.Layouts.BatchOut_rec L, DATASET(RECORDOF(ds_knownFraud)) R) := TRANSFORM
			
			SELF.known_risks_cnt 		:= COUNT(R);
			SELF.known_risk_reason1 := R[1].known_risk_reason;
			SELF.known_risk_reason2 := R[2].known_risk_reason;
			SELF.known_risk_reason3 := R[3].known_risk_reason;
			SELF.known_risk_reason4 := R[4].known_risk_reason;
			SELF.known_risk_reason5 := R[5].known_risk_reason;
			SELF := L;
		END;
		
		ds_results := DENORMALIZE(pre_ds_results, ds_knownFraud,
															LEFT.acctno = RIGHT.acctno,
															GROUP,
															xfm_batchout(LEFT, ROWS(RIGHT)));
		RETURN ds_results;
	END;

END;