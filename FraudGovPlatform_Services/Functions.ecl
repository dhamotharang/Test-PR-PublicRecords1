IMPORT CriminalRecords_BatchService, DeathV2_Services, FraudDefenseNetwork_Services, FraudGovPlatform_Services, 
			 FraudShared_Services, iesp, Patriot, risk_indicators, riskwise;

EXPORT Functions := MODULE

  EXPORT getKnownFraudDescriptionFromPayload(FraudShared_Services.Layouts.Raw_Payload_rec p_rec ) := FUNCTION

    dString1 := '(On: ' + TRIM(p_rec.Event_Date) + ') ';
    dString2 := '(From: '+ TRIM(p_rec.Event_Date) + ' To: ' + TRIM(p_rec.Event_End_Date) + ') ';

    eventDates := IF(p_rec.Event_Date=p_rec.Event_End_Date, dString1, dString2);
    eventType1 := TRIM(' ' + p_rec.Event_Type_1);
    eventType2 := TRIM(' ' + p_rec.Event_Type_2);
    eventType3 := TRIM(' ' + p_rec.Event_Type_3);

    RETURN TRIM(eventDates + eventType1 + eventType2 + eventType3);
  END;
	
	EXPORT getExternalServicesRecs(	DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in, 
																	FraudGovPlatform_Services.IParam.BatchParams batch_params ) := FUNCTION

		recs_Death := FraudGovPlatform_Services.Raw.GetDeath(ds_batch_in, batch_params);
		recs_Criminal := FraudGovPlatform_Services.Raw.GetCriminal(ds_batch_in, batch_params);
		recs_RedFlag := FraudGovPlatform_Services.Raw.GetRedFlags(ds_batch_in, batch_params);
		recs_Patriot := FraudGovPlatform_Services.Raw.GetGlobalWatchlist(ds_batch_in, batch_params);
		
		FraudGovPlatform_Services.Layouts.Batch_out_pre_rec xfm_Compilation(FraudShared_Services.Layouts.BatchIn_rec L) := TRANSFORM
			SELF.batchin_rec := L;
			SELF.childRecs_Death := recs_Death(acctno = L.acctno);
			SELF.childRecs_Criminal := recs_Criminal(acctno = L.acctno);
			SELF.childRecs_RedFlag := recs_RedFlag(seq = (INTEGER)L.acctno);
			SELF.childRecs_Patriot := UNGROUP(recs_Patriot(acctno = L.acctno));
			SELF := L;
			SELF := [];
		END;    

		final_recs := PROJECT(ds_batch_in, xfm_Compilation(LEFT));
		return final_recs;
	END;
		
	EXPORT getKnownFraudsRecs(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
														FraudGovPlatform_Services.IParam.BatchParams batch_params,
														DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) ds_payloads_in) := FUNCTION

		FraudGovPlatform_Services.Layouts.KnownFrauds_rec xfm_KNFDCompilation(
				FraudShared_Services.Layouts.BatchIn_rec L, 
				DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) R ) := TRANSFORM
		
			ds_sorted := SORT(R, -event_date);
			SELF.childRecs_KnownFrauds := ds_sorted;
			SELF := L;
		END;	

		knownFraudResults := DENORMALIZE(	ds_batch_in, ds_payloads_in, 
																			LEFT.acctno = RIGHT.acctno,
																			GROUP,
																			xfm_KNFDCompilation(LEFT, ROWS(RIGHT)),
																			LEFT OUTER);
		return knownFraudResults;
	END;
		
	EXPORT getVelocityRecs(	DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
													FraudGovPlatform_Services.IParam.BatchParams batch_params,
													DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) ds_payload) := FUNCTION

		contributionType_recs_norm := FraudShared_Services.Functions.getFragmentMatchTypes(ds_batch_in, ds_payload, batch_params);

		rules := FraudShared_Services.Functions.GetVelocityRules(batch_params.fraudplatform);

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
	
	EXPORT getKnownFraud(DATASET(FraudGovPlatform_Services.Layouts.KnownFrauds_rec) ds_known_risk_in) := FUNCTION
							
			FraudGovPlatform_Services.Layouts.KnownFrauds_BatchOut_rec xform_known_risk(FraudGovPlatform_Services.Layouts.KnownFrauds_rec L) := TRANSFORM
			
				UNSIGNED4 KNFD_CNT := COUNT(L.childRecs_KnownFrauds);
				
				SELF.known_risks_cnt := KNFD_CNT;
				SELF.known_risk_reason1 := IF(KNFD_CNT >= 1, getKnownFraudDescriptionFromPayload(L.childRecs_KnownFrauds[1]), '');
				SELF.known_risk_reason2 := IF(KNFD_CNT >= 2, getKnownFraudDescriptionFromPayload(L.childRecs_KnownFrauds[2]), '');
				SELF.known_risk_reason3 := IF(KNFD_CNT >= 3, getKnownFraudDescriptionFromPayload(L.childRecs_KnownFrauds[3]), '');
				SELF.known_risk_reason4 := IF(KNFD_CNT >= 4, getKnownFraudDescriptionFromPayload(L.childRecs_KnownFrauds[4]), '');
				SELF.known_risk_reason5 := IF(KNFD_CNT >= 5, getKnownFraudDescriptionFromPayload(L.childRecs_KnownFrauds[5]), '');
			
				SELF := l;
			END;
			
			ds_known_risk := PROJECT(ds_known_risk_in, xform_known_risk(LEFT));
			RETURN ds_known_risk;
	END;

	EXPORT getFlatBatchOut(DATASET(FraudGovPlatform_Services.Layouts.Batch_out_pre_rec) ds_records) := FUNCTION
	
		FraudGovPlatform_Services.Layouts.BatchOut_rec xfm_batchout(FraudGovPlatform_Services.Layouts.Batch_out_pre_rec L) := TRANSFORM
			SELF.Seq := L.batchin_rec.Seq;
			SELF.LexID := L.batchin_rec.did;

			SELF.known_risks_cnt 		:= L.childRecs_KnownFrauds[1].known_risks_cnt;
			SELF.known_risk_reason1 := L.childRecs_KnownFrauds[1].known_risk_reason1;
			SELF.known_risk_reason2 := L.childRecs_KnownFrauds[1].known_risk_reason2;
			SELF.known_risk_reason3 := L.childRecs_KnownFrauds[1].known_risk_reason3;
			SELF.known_risk_reason4 := L.childRecs_KnownFrauds[1].known_risk_reason4;
			SELF.known_risk_reason5 := L.childRecs_KnownFrauds[1].known_risk_reason5;
			
			unsigned4 VEL_CNT := COUNT(L.childRecs_Velocities);
			SELF.velocity_exceeded_cnt := VEL_CNT;
			SELF.velocity_exceeded_reason1 := IF(VEL_CNT >= 1, L.childRecs_Velocities[1].description, '');
			SELF.velocity_exceeded_reason2 := IF(VEL_CNT >= 2, L.childRecs_Velocities[2].description, '');
			SELF.velocity_exceeded_reason3 := IF(VEL_CNT >= 3, L.childRecs_Velocities[3].description, '');

			SELF := L;
			SELF := [];
		END;

		ds_results := PROJECT(ds_records, xfm_batchout(LEFT));
		
		RETURN ds_results;
	END;

END;