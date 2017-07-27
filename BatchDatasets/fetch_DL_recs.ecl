
IMPORT Doxie, DriversV2, DriversV2_Services;

/*
It is the responsibility of the calling attribute to set the following STORED values:

		#STORED('IncludeNonDMVSources' ,[ TRUE, FALSE ]);

		The #STOREDs value above is read from global scope by DriversV2_Services.DLRaw.
		narrow_view.by_seq. It cannot be passed as a formal parameter.
*/

EXPORT fetch_DL_recs( DATASET(doxie.layout_references_acctno) ds_acctno_refs ) :=
	FUNCTION

		layout_acctno_DLseq := RECORD
			doxie.layout_references_acctno;
			DriversV2.Layout_DL_Decoded.dl_seq;
		END;
		
		// Lookup dl_seq key values by DID; transform into record of {acctno, dl_seq}.
		by_did := 
			join(
				ds_acctno_refs, DriversV2.Key_DL_DID,
				keyed(left.did = right.did),
				transform( layout_acctno_DLseq, 
					self := right,
					self := left
				),
				limit(Constants.Limits.MAX_JOIN_LIMIT, SKIP)
			);

		dl_seqs := project(by_did, DriversV2_Services.layouts.seq);

		// Generate simple DL report by dl_seq number.
		dl_recs := DriversV2_Services.DLRaw.narrow_view.by_seq(dl_seqs);
		
		// Join back to acctno, did. No transform; just connect the right side to the left.			
		dl_recs_with_acctnos :=
			join(
				by_did, dl_recs,
				left.dl_seq = right.dl_seq,
				transform( layouts.layout_drivers_license_raw,
					self.acctno := left.acctno,
					self := right
				),
				inner, keep(1)
			);
		
		RETURN dl_recs_with_acctnos;
	END;