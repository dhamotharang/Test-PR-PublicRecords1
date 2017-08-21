IMPORT LN_PropertyV2, LN_PropertyV2_Fast, ut;

EXPORT verify_ln_fares_id_are_unique := MODULE

	SHARED	base_a := LN_PropertyV2.File_Assessment;
	SHARED	prep_a := ln_propertyv2_fast.files.prep.assessment;

	SHARED	base_d := LN_PropertyV2.File_deed;
	SHARED	prep_d := ln_propertyv2_fast.files.prep.deed_mortg;

	EXPORT in_prep_not_yet_in_base(string p_date) := FUNCTION // This will fail if ran against process_date already in full base
		
		prep_af := prep_a(process_date>=p_date);
		prep_as	:= sort(distribute(prep_af,hash64(ln_fares_id)),ln_fares_id,local);
		reca 		:= record
			prep_as.ln_fares_id;
			counta:= count(group);
		end;
		table_at:= table(prep_as,
											reca,
											prep_as.ln_fares_id
											);
		sele_ad := table_at(counta>1);
		dups_ap := join(sort(distribute(base_a, hash64(ln_fares_id)),ln_fares_id,local)
									 ,sort(distribute(prep_af,hash64(ln_fares_id)),ln_fares_id,local),LEFT.ln_fares_id=RIGHT.ln_fares_id,local);
		dups_ad := join(sort(distribute(prep_af,hash64(ln_fares_id)),ln_fares_id,local)
									 ,sort(distribute(sele_ad,hash64(ln_fares_id)),ln_fares_id,local),LEFT.ln_fares_id=RIGHT.ln_fares_id,local);

		prep_df := prep_d(process_date>=p_date);
		prep_ds	:= sort(distribute(prep_df,hash64(ln_fares_id)),ln_fares_id,local);
		recd := record
			prep_ds.ln_fares_id;
			countd:= count(group);
		end;
		table_dt:= table(prep_ds,
											recd,
											prep_ds.ln_fares_id
											);
		sele_dd := table_dt(countd>1);
		dups_dp := join(sort(distribute(base_d, hash64(ln_fares_id)),ln_fares_id,local)
									 ,sort(distribute(prep_df,hash64(ln_fares_id)),ln_fares_id,local),LEFT.ln_fares_id=RIGHT.ln_fares_id,local);
		dups_dd := join(sort(distribute(prep_df,hash64(ln_fares_id)),ln_fares_id,local)
									 ,sort(distribute(sele_dd,hash64(ln_fares_id)),ln_fares_id,local),LEFT.ln_fares_id=RIGHT.ln_fares_id,local);
									 
		dup_count := count(dups_ap)+count(dups_dp)+count(dups_ad)+count(dups_dd);
		there_are_no_dups := if (dup_count>0, when(false,parallel(
				 output(choosen(dups_ap,1000,1),named('prep_assessment_ln_fares_ids_already_in_base_sample'))
				,output(choosen(dups_dp,1000,1),named('prep_deed_ln_fares_ids_already_in_base_sample'))
				,output(choosen(dups_ad,1000,1),named('prep_assessment_ln_fares_ids_duplicate_within_prep_sample'))
				,output(choosen(dups_dd,1000,1),named('prep_deed_ln_fares_duplicate_within_prep_sample')))
																							 )
													,true);
		return ASSERT(there_are_no_dups, 'prep_ln_fares_ids_are_not_unique',FAIL);
	END;

	EXPORT in_base_file := FUNCTION

		// process_date
		dups_aib := join(base_a,base_a,LEFT.ln_fares_id=RIGHT.ln_fares_id AND LEFT.process_date <> RIGHT.process_date,local,hash);
		dups_dib := join(base_d,base_d,LEFT.ln_fares_id=RIGHT.ln_fares_id AND LEFT.process_date <> RIGHT.process_date,local,hash);
		//fares_unformatted_apn
		dups_aab := join(base_a,base_a,LEFT.ln_fares_id=RIGHT.ln_fares_id AND LEFT.fares_unformatted_apn <> RIGHT.fares_unformatted_apn,local,hash);
		dups_dab := join(base_d,base_d,LEFT.ln_fares_id=RIGHT.ln_fares_id AND LEFT.fares_unformatted_apn <> RIGHT.fares_unformatted_apn,local,hash);
			
		dup_count := count(dups_aib)+count(dups_dib)
								+count(dups_aab)+count(dups_dab);
		there_are_no_dups := if (dup_count<=2, when(false,parallel( // We have 1 pair of duplicates !!! (OD0056721109)
				 output(choosen(dups_aib,1000,1),named('Duplicate_assessment_ln_fares_ids_process_date_sample'))
				,output(choosen(dups_dib,1000,1),named('Duplicate_deed_ln_fares_ids_process_date_sample'))
				,output(choosen(dups_aab,1000,1),named('Duplicate_assessment_ln_fares_ids_apn_sample'))
				,output(choosen(dups_dab,1000,1),named('Duplicate_deed_ln_fares_ids_apn_sample'))
				)
																							 )
													,true);
		return ASSERT(there_are_no_dups, 'prep_ln_fares_ids_are_not_unique',FAIL);

	END;

END;