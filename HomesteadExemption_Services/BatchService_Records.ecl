
IMPORT ut;

// EXPORT BatchService_Records(DATASET(Layouts.batch_in) ds_batch_in, IParams.BatchParams in_mod) := 
EXPORT BatchService_Records(DATASET(HomesteadExemption_Services.Layouts.batch_in_raw_with_seq) ds_batch_in, 
														HomesteadExemption_Services.IParams.BatchParams in_mod) :=
	FUNCTION

		// ---------------------------------------------------------------------------
		// 
		// 0. Normalize and clean input records.
		// 
		// ---------------------------------------------------------------------------	
		
		// Normalize the batch_in records--they each contain two persons.
		ds_batch_in_norm  := 
			NORMALIZE( 
				ds_batch_in, 
				2, 
				HomesteadExemption_Services.Transforms.xfm_norm(LEFT,COUNTER) 
			);		
		
		// Clean the normalized records: parse the name, clean the address, ssn and dob.
		ds_batch_in_cleaned := 
			PROJECT( 
				ds_batch_in_norm, 
				HomesteadExemption_Services.Transforms.xfm_clean_record(LEFT) 
			);
		
		// ---------------------------------------------------------------------------
		// 
		// 1. Start output records: set seed.
		// 
		// ---------------------------------------------------------------------------			
		ds_temp_seed := 
			PROJECT( 
				ds_batch_in_cleaned, 
				TRANSFORM( HomesteadExemption_Services.Layouts.layout_temp_intermediate,
					SELF.acctno := LEFT.acctno,
					SELF        := []
				)
			);		

		// Transform the acctnos that have the '_1' and '_2' (appended in the BatchService 
		// attribute) to simply the acctno. This will be used toward the end as part of
		// constructing the final layout.
		HomesteadExemption_Services.Layouts.batch_out xfm_derive_seqNo1(Layouts.layout_temp_intermediate le) := 
			TRANSFORM
				SELF.acctno := ut.StringSplit(le.acctno, '_')[1];
				SELF        := [];
			END;
		
		ds_acctnos := PROJECT( ds_temp_seed, xfm_derive_seqNo1(LEFT) );

		ds_batch_out_seed :=
			UNGROUP( TOPN( GROUP( SORT( ds_acctnos, acctno ), acctno ), 1, acctno ) );	

		// ---------------------------------------------------------------------------
		// 
		// 2. Get Best ADL records...
		// 
		// ---------------------------------------------------------------------------
		HomesteadExemption_Services.Layouts.layout_temp_ADLBest_recs
				ds_ADL_best_recs := HomesteadExemption_Services.fn_getADLBestRecs(ds_batch_in_cleaned, in_mod);
		
		// ...and append to a temp dataset. 
		ds_batch_out_with_ADL_best :=
			JOIN(
				ds_temp_seed, ds_ADL_best_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( HomesteadExemption_Services.Layouts.layout_temp_intermediate, 
					SELF.acctno    := LEFT.acctno, 
					SELF.did       := RIGHT.did,
					best_dob := if ((integer)RIGHT.best_dob > 0, RIGHT.best_dob, '');
					SELF.owner_age := if (best_dob <> '',(STRING)(ut.GetAge(best_dob)),''),
					SELF.owner_ssn := RIGHT.best_ssn,
					SELF           := LEFT, 
					SELF           := [] 
				),
				LEFT OUTER,
				KEEP(1)
			); 
		
		// Append the LexID/did obtained here to the batch input. We'll use this
		// dataset having the DID to fetch all subsequent records.
		ds_batch_in_wDID :=
			JOIN(
				ds_batch_in_cleaned, ds_ADL_best_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM(HomesteadExemption_Services.Layouts.batch_in,
					SELF.acctno     := LEFT.acctno,
					SELF.did        := RIGHT.did,
					SELF.ssn        := IF( TRIM(LEFT.ssn) != '', LEFT.ssn, RIGHT.best_ssn ),
					SELF.name_first := IF( TRIM(LEFT.name_first) != '', LEFT.name_first, RIGHT.best_fname ),
					SELF            := LEFT
				),
				INNER,
				KEEP(1)
			);		
			
		// ---------------------------------------------------------------------------
		// 
		// 3. Get Deceased records...
		// 
		// ---------------------------------------------------------------------------		
		HomesteadExemption_Services.Layouts.layout_temp_deceased_recs
				ds_deceased_recs := HomesteadExemption_Services.fn_getDeceasedRecs(ds_batch_in_wDID, in_mod);
		
		// ...and append to a temp dataset.
		ds_batch_out_with_deceased := 
			JOIN(
				ds_batch_out_with_ADL_best, ds_deceased_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM(HomesteadExemption_Services.Layouts.layout_temp_intermediate, 
					SELF.acctno := LEFT.acctno, SELF := RIGHT, SELF := LEFT, SELF := [] 
				),
				LEFT OUTER,
				KEEP(1)
			);
			
		// ---------------------------------------------------------------------------
		// 
		// 4. Get Drivers License records...
		// 
		// ---------------------------------------------------------------------------	
		HomesteadExemption_Services.Layouts.layout_temp_dl_recs
				ds_drivers_license_recs := HomesteadExemption_Services.fn_getDriversLicenseRecs(ds_batch_in_wDID, in_mod);		

		// ...and append to a temp dataset.
		ds_batch_out_with_drivers_license := 
			JOIN(
				ds_batch_out_with_deceased, ds_drivers_license_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM(HomesteadExemption_Services.Layouts.layout_temp_intermediate, 
					SELF.acctno := LEFT.acctno, SELF := RIGHT, SELF := LEFT, SELF := [] 
				),
				LEFT OUTER,
				KEEP(1)
			);

		// ---------------------------------------------------------------------------
		// 
		// 5. Get Voter records...
		// 
		// ---------------------------------------------------------------------------	
		HomesteadExemption_Services.Layouts.layout_temp_voter_recs
				ds_voter_recs := HomesteadExemption_Services.fn_getVoterRecs(ds_batch_in_wDID, in_mod);		

		// ...and append to a temp dataset.
		ds_batch_out_with_voter_data := 
			JOIN(
				ds_batch_out_with_drivers_license, ds_voter_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM(HomesteadExemption_Services.Layouts.layout_temp_intermediate, 
					SELF.acctno := LEFT.acctno, SELF := RIGHT, SELF := LEFT, SELF := [] 
				),
				LEFT OUTER,
				KEEP(1)
			);		

		// ---------------------------------------------------------------------------
		// 
		// 6. Now denormalize the temp dataset into the final output, where are up to 
		// two persons in the same record.
		// 
		// ---------------------------------------------------------------------------		
		layout_temp_plus_seq := RECORD
			HomesteadExemption_Services.Layouts.layout_temp_intermediate;
			UNSIGNED seq;
		END;
		
		layout_temp_plus_seq xfm_derive_seqNo(HomesteadExemption_Services.Layouts.layout_temp_intermediate le) := 
			TRANSFORM
						set_acctno := ut.StringSplit(le.acctno, '_');
				SELF.acctno := set_acctno[1];
				SELF.seq    := (UNSIGNED)set_acctno[2];
				SELF        := le;
			END;
		
		ds_batch_out_with_voter_data_plus_seq := 
			PROJECT( ds_batch_out_with_voter_data, xfm_derive_seqNo(LEFT) );

		HomesteadExemption_Services.Layouts.batch_out xfm_denorm2(Layouts.batch_out le, DATASET(layout_temp_plus_seq) allRows) :=
			TRANSFORM
				SELF.acctno                := le.acctno;
				SELF.did1                  := allRows(seq = 1)[1].did;
				SELF.did2                  := allRows(seq = 2)[1].did;
				SELF.owner_1_age           := allRows(seq = 1)[1].owner_age;
				SELF.owner_2_age           := allRows(seq = 2)[1].owner_age;
				SELF.owner_1_SSN           := allRows(seq = 1)[1].owner_ssn;
				SELF.owner_2_SSN           := allRows(seq = 2)[1].owner_ssn;
				SELF.owner_1_isDeceased    := allRows(seq = 1)[1].owner_isDeceased;
				SELF.owner_2_isDeceased    := allRows(seq = 2)[1].owner_isDeceased;
				SELF.owner_1_Date_of_death := allRows(seq = 1)[1].owner_date_of_death;
				SELF.owner_2_Date_of_death := allRows(seq = 2)[1].owner_date_of_death;	
				SELF.dl_state_1            := allRows(seq = 1)[1].dl_state;
				SELF.dl_activation_date_1  := allRows(seq = 1)[1].dl_activation_date;
				SELF.dl_state_2            := allRows(seq = 2)[1].dl_state;
				SELF.dl_activation_date_2  := allRows(seq = 2)[1].dl_activation_date;	
				SELF.res_st_1              := allRows(seq = 1)[1].res_st;
				SELF.voter_status_exp_1    := allRows(seq = 1)[1].voter_status_exp;
				SELF.active_status_exp_1   := allRows(seq = 1)[1].active_status_exp;
				SELF.res_st_2              := allRows(seq = 2)[1].res_st;
				SELF.voter_status_exp_2    := allRows(seq = 2)[1].voter_status_exp;
				SELF.active_status_exp_2   := allRows(seq = 2)[1].active_status_exp;	
				SELF := le;
				SELF := []
			END;

		ds_batch_out_so_far :=
			DENORMALIZE(
				ds_batch_out_seed, ds_batch_out_with_voter_data_plus_seq,
				LEFT.acctno = RIGHT.acctno,
				GROUP,
				xfm_denorm2(LEFT,ROWS(RIGHT))
			);		
			
		// ---------------------------------------------------------------------------
		// 
		// 7. Get Property records...
		// 
		// ---------------------------------------------------------------------------
		
		// QUESTION: do we need to pass in the params 'nss' and 'isFCRA'???
		HomesteadExemption_Services.Layouts.layout_property_recs
				ds_property_recs := HomesteadExemption_Services.fn_getPropertyRecs(ds_batch_in_wDID, in_mod);

		// ...and append to the final layout.
		ds_batch_out_with_property_data := 
			JOIN(
				ds_batch_out_so_far, ds_property_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM(HomesteadExemption_Services.Layouts.batch_out, 
					SELF.acctno := LEFT.acctno, SELF := RIGHT, SELF := LEFT, SELF := [] 
				),
				LEFT OUTER,
				KEEP(1)
			);	
			
		// ---------------------------------------------------------------------------
		// 
		// 7. Add Phone records to each of the Property records.
		// 
		// ---------------------------------------------------------------------------	
		HomesteadExemption_Services.Layouts.batch_out
			ds_batch_out_with_phone_data := HomesteadExemption_Services.fn_getPhonesRecs(ds_batch_out_with_property_data, in_mod);
		
		ds_batch_out := ds_batch_out_with_phone_data;
		// OUTPUT(ds_ADL_best_recs,NAMED('ds_ADL_best_recs'));
		// OUTPUT(ds_property_recs,NAMED('ds_property_recs'));
		RETURN ds_batch_out;
		
	END;