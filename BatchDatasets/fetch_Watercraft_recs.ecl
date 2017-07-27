
IMPORT Doxie, FCRA, ut, Watercraft, WatercraftV2_Services;
 			 
EXPORT fetch_Watercraft_recs( DATASET(Layouts.batch_in) ds_batch_in ) :=
	FUNCTION

		ds_acctno_refs := PROJECT( ds_batch_in, doxie.layout_references_acctno );
		flagfile := fcra.compliance.blank_flagfile;

		layout_temp := RECORD
			STRING20 acctno;
			UNSIGNED6 did;
			STRING2	 state_origin;
			STRING30 watercraft_key;
			STRING30 sequence_key;
		END;
		
		ds_watercraftkeys_raw :=
			JOIN(
				ds_acctno_refs, watercraft.key_watercraft_did(isFCRA := FALSE),
				KEYED(LEFT.did = RIGHT.l_did), 
				TRANSFORM(layout_temp,
					SELF := LEFT,
					SELF := RIGHT
				), 
				INNER,
				LIMIT(Constants.Limits.MAX_JOIN_LIMIT,SKIP)
			);

		ds_watercraftkeys := 
			PROJECT(
				ds_watercraftkeys_raw,
				TRANSFORM( WatercraftV2_Services.Layouts.search_watercraftkey,
					SELF.watercraft_key := LEFT.watercraft_key;
					SELF.sequence_key   := LEFT.sequence_key;
					SELF.state_origin   := LEFT.state_origin;
					SELF.isDeepDive     := FALSE;
				)
			);

		ds_watercraft_raw := 
			UNGROUP(WatercraftV2_Services.get_watercraft(ds_watercraftkeys, '', FALSE, flagfile).report());
		
		ds_watercraft :=
			JOIN(
				ds_watercraftkeys_raw, ds_watercraft_raw,
				LEFT.watercraft_key = RIGHT.watercraft_key AND
				LEFT.sequence_key = RIGHT.sequence_key,
				TRANSFORM( Layouts.layout_watercraft_raw,
					SELF.acctno := LEFT.acctno,
					SELF.did := LEFT.did,
					SELF := RIGHT
				),
				INNER,
				KEEP(1)
			);
			
		RETURN ds_watercraft;
	END;