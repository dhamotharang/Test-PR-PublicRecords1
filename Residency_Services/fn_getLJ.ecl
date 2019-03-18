IMPORT doxie, LiensV2_Services, Residency_Services, STD, ut, BatchShare;

EXPORT fn_getLJ(DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids, 
                Residency_Services.IParam.BatchParams mod_params_in) := FUNCTION

		LJBatchParams := MODULE(PROJECT(mod_params_in, LiensV2_Services.IParam.batch_params,OPT))
			EXPORT BOOLEAN no_did_append := FALSE ;
			EXPORT party_types 					 := ['D'];
		END;	
		
	  LJBatch_In := PROJECT(ds_in_acctnos_dids,
		                      TRANSFORM(LiensV2_Services.Batch_Layouts.batch_in,
													  SELF.acctno := LEFT.acctno,
													  SELF.did    := LEFT.did ,
													  SELF := [] ));

		dsLJ := LiensV2_Services.Batch_records(LJBatch_In, LJBatchParams); 
		
		ds_JL_recs_flat := PROJECT(dsLJ, LiensV2_Services.batch_make_flat(LEFT));	

    TodaysDate := Residency_Services.Constants.TodaysDate;
		
		Fltrd_JL_recs_flat := ds_JL_recs_flat(ut.DaysApart(orig_filing_date, TodaysDate)
		                                      < Residency_Services.Constants.Days_in_Year);
			
		DenormLJrec := RECORD
			LiensV2_Services.layout_TMSID;
			UNSIGNED6 debtor_did;
			STRING2   debtor_st          := '';
			STRING18  debtor_county_name := '';
		END;
	
		DenormLJrec	tf_Normthem(Fltrd_JL_recs_flat l, INTEGER c) := TRANSFORM
			SELF.acctno:= l.acctno;
			SELF.tmsid := l.tmsid;
			SELF.debtor_did := (UNSIGNED)CHOOSE(c,l.debtor_1_party_1_did,l.debtor_1_party_2_did,l.debtor_2_party_1_did,l.debtor_2_party_2_did,l.debtor_3_party_1_did,l.debtor_3_party_2_did,l.debtor_4_party_1_did,l.debtor_4_party_2_did,l.debtor_5_party_1_did,l.debtor_5_party_2_did,l.debtor_6_party_1_did,l.debtor_6_party_2_did,l.debtor_7_party_1_did,l.debtor_7_party_2_did);
			SELF.debtor_county_name := CHOOSE(c,l.debtor_1_party_1_county_name,l.debtor_1_party_2_county_name,l.debtor_2_party_1_county_name,l.debtor_2_party_2_county_name,l.debtor_3_party_1_county_name,l.debtor_3_party_2_county_name,l.debtor_4_party_1_county_name,l.debtor_4_party_2_county_name,l.debtor_5_party_1_county_name,l.debtor_5_party_2_county_name,l.debtor_6_party_1_county_name,l.debtor_6_party_2_county_name,l.debtor_7_party_1_county_name,l.debtor_7_party_2_county_name);
			SELF.debtor_st          := CHOOSE(c,l.debtor_1_party_1_st,l.debtor_1_party_2_st,l.debtor_2_party_1_st,l.debtor_2_party_2_st,l.debtor_3_party_1_st,l.debtor_3_party_2_st,l.debtor_4_party_1_st,l.debtor_4_party_2_st,l.debtor_5_party_1_st,l.debtor_5_party_2_st,l.debtor_6_party_1_st,l.debtor_6_party_2_st,l.debtor_7_party_1_st,l.debtor_7_party_2_st);
		END;
	
		NormedLJrecs := NORMALIZE(Fltrd_JL_recs_flat,14,tf_Normthem(LEFT,COUNTER));
				
		FLtrdJLrecs := NormedLJrecs(debtor_did IN SET(LJBatch_In,did));
	
		Residency_Services.Layouts.Int_Service_output  tf_output(FLtrdJLrecs l) := TRANSFORM
			SELF.acctno      := l.acctno ;
			SELF.did         := l.debtor_did ;
			SELF.county_name := l.debtor_county_name ;
			SELF.st          := l.debtor_st ;
			SELF := [];
		END;
	
		LJrecs := PROJECT(FLtrdJLrecs, tf_output(LEFT));
			
	// OUTPUT(LJBatch_In,      NAMED('LJBatch_In'));
	// OUTPUT(dsLJ,            NAMED('dsLJ'));
	// OUTPUT(ds_JL_recs_flat, NAMED('ds_JL_recs_flat'));
	// OUTPUT(NormedLJrecs,    NAMED('NormedLJrecs'));
	// OUTPUT(nonblankjlrecs,  NAMED('nonblankjlrecs'));
	// OUTPUT(FLtrdJLrecs,     NAMED('FLtrdJLrecs'));
	// OUTPUT(LJrecs,          NAMED('LJrecs'));
	// OUTPUT(LJ_normalized,   NAMED('LJ_normalized'));

		RETURN LJrecs;
END;