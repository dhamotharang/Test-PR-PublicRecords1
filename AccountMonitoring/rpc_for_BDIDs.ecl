IMPORT Business_Header, Business_Header_SS;

EXPORT rpc_for_BDIDs( DATASET(layouts.DIDMetaRec) batch_in ) :=
	FUNCTION

		UCase := StringLib.StringToUpperCase;
		
		Business_Header_SS.Layout_BDID_InBatch xfm_to_inbatch(layouts.DIDMetaRec l) :=
			TRANSFORM
				SELF.seq         := l.seq;
				SELF.fein        := (qSTRING9) UCase(l.ssn);
				SELF.company_name:= (qSTRING120)UCase(l.comp_name);
				SELF.prim_range  := (qSTRING10)UCase(l.prim_range);
				SELF.predir      := (qSTRING2) UCase(l.predir);
				SELF.prim_name   := (qSTRING28)UCase(l.prim_name);
				SELF.addr_suffix := (qSTRING4) UCase(l.addr_suffix);
				SELF.postdir     := (qSTRING2) UCase(l.postdir);
				SELF.unit_desig  := (qSTRING10)UCase(l.unit_desig);
				SELF.sec_range   := (qSTRING8) UCase(l.sec_range);
				SELF.p_city_name := (qSTRING25)UCase(l.p_city_name);
				SELF.st          := (qSTRING2) UCase(l.st);
				SELF.z5          := (qSTRING5) UCase(l.z5);
				SELF.zip4        := (qSTRING4) UCase(l.zip4);
				SELF.ssn         := (qSTRING9) UCase(l.ssn);
			END;
			
		f_in := PROJECT( batch_in, xfm_to_inbatch(LEFT) );

		f_out := PIPE(f_in
			, 'roxiepipe' +
			' -iw ' + SIZEOF(Business_Header_SS.Layout_BDID_InBatch) +
			' -vip' +
			' -t 10' +
			' -ow ' + SIZEOF(Business_Header.layout_BDID_OutBatch_Expanded) +
			' -b 100' +
			' -mr 2' +
			' -h ' + AccountMonitoring.constants.PROD_VIP +
			' -r Result' +
			' -q "<Business_Header.BH_BDID_Batch_Service format=\'raw\'>' +
			'<bdid_batch_in id=\'id\' format=\'raw\'></bdid_batch_in>' +
			'</Business_Header.BH_BDID_Batch_Service>"'
			, Business_Header.layout_BDID_OutBatch_Expanded);

		f_out_best    := DEDUP(SORT(DISTRIBUTED(f_out), seq, -score, LOCAL), seq, LOCAL);
		best_out_slim := PROJECT( f_out_best, {Business_Header_SS.Layout_BDID_OutBatch.seq, Business_Header_SS.Layout_BDID_OutBatch.bdid} );
		RETURN best_out_slim;

	END;

