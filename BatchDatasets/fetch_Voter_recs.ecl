
IMPORT BatchShare, Doxie, votersV2_services;
			 
EXPORT fetch_Voter_recs( DATASET(Layouts.batch_in) ds_batch_in, BatchShare.IParam.BatchParamsV2 in_mod ) :=
	FUNCTION
		
		ds_acctno_refs := PROJECT( ds_batch_in, doxie.layout_references_acctno );
		
		// Get voters' IDs from DIDs (grouped by acctno)
		ds_acctno_refs_grpd := GROUP( SORT( ds_acctno_refs, acctno ), acctno );
		ds_vtids := VotersV2_Services.raw.Get_vtids_from_dids_batch(ds_acctno_refs_grpd,FALSE);
		ds_vtids_for_source_view := PROJECT( UNGROUP(ds_vtids), VotersV2_Services.Transforms.acct_rec );

		//** report layout
		ds_voter_records_raw := 
				votersV2_services.raw.SOURCE_VIEW.by_vtid(ds_vtids_for_source_view,in_mod.ssn_mask,FALSE,in_mod.application_type);
		
		ds_voter_records := 
			JOIN(
				ds_batch_in, ds_voter_records_raw, 
				LEFT.did = (UNSIGNED6)RIGHT.did, 
				TRANSFORM( Layouts.layout_voters_raw,
					SELF.acctno := LEFT.acctno, 
					SELF        := RIGHT					
				), 
				INNER,
				LIMIT(Constants.Limits.MAX_JOIN_LIMIT,SKIP)
			);
			
		RETURN ds_voter_records;
	END;
  