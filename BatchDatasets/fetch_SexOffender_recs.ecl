
IMPORT Doxie, SexOffender, SexOffender_Services, Suppress, ut;
			 
EXPORT fetch_SexOffender_recs( DATASET(doxie.layout_references_acctno) ds_acctno_refs ) :=
	FUNCTION   // For testing: did 2257537864

		sex_off_docIds := 
			JOIN(
				ds_acctno_refs, SexOffender.Key_SexOffender_DID(FALSE),
				KEYED(LEFT.did = RIGHT.did),
				TRANSFORM( SexOffender_Services.layouts.lookup_id_rec,
					SELF.acctno              := LEFT.acctno,
					SELF.seisint_primary_key := RIGHT.seisint_primary_key,
					SELF.isDeepDive          := FALSE
				),
				INNER,
				LIMIT(Constants.Limits.MAX_JOIN_LIMIT,SKIP)
			);
		
		SexOffender_Services.Layouts.rec_offender_plus_acctno
				sex_offender_rpt := SexOffender_Services.Raw.batch_view.getOffendersRecs(sex_off_docIds,FALSE);
		
		RETURN sex_offender_rpt;
	END;
	