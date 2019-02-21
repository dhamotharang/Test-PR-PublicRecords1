
IMPORT BatchShare, Doxie, Doxie_Raw, FCRA;

EXPORT fetch_Aircraft_recs( DATASET(doxie.layout_references_acctno) ds_acctno_refs, BatchShare.IParam.BatchParamsV2 in_mod ) :=
	FUNCTION
		faa_dids_pre := PROJECT(ds_acctno_refs, doxie.layout_references);
		faa_dids     := DEDUP(SORT(faa_dids_pre, did), did);
		faa_bdids    := DATASET([], doxie.layout_ref_bdid);
		ds_flags     := fcra.compliance.blank_flagfile;
		dateval      := 0;
		
		ds_aircraft_raw := // function call
				Doxie_Raw.AirCraft_Raw( 
					faa_dids, 
					faa_bdids, 
					dateval, 
					in_mod.dppa, 
					in_mod.glb, 
					in_mod.ssn_mask, 
					in_mod.application_type,
					FALSE, 
					ds_flags);
		
		ds_aircraft :=
			JOIN(
				ds_acctno_refs, ds_aircraft_raw,
				LEFT.did = (UNSIGNED6)RIGHT.did_out,
				TRANSFORM( Layouts.layout_faa_raw,
					SELF.acctno := LEFT.acctno,
					SELF.did := LEFT.did,
					SELF := RIGHT
				),
				INNER,
				LIMIT(Constants.Limits.MAX_JOIN_LIMIT,SKIP)
			);
			
		RETURN ds_aircraft;
	END;
  