IMPORT dx_Property,ut,MDR;

EXPORT fn_getForeclosureRecs (DATASET(Layouts.batch_working) ds_work_recs,
															IParams.BatchParams in_mod) := FUNCTION

	ds_work_fid_recs := JOIN(ds_work_recs,dx_Property.Key_Foreclosure_DID,
		KEYED(LEFT.did=RIGHT.did),LEFT OUTER,LIMIT(ut.limits.Foreclosure_PER_DID,SKIP));

	ds_working_recs := JOIN(ds_work_fid_recs,dx_Property.Key_Foreclosures_FID,
		KEYED(LEFT.fid=RIGHT.fid) AND RIGHT.source=MDR.sourceTools.src_Foreclosures,
		TRANSFORM(Layouts.batch_working,
			SELF.has_foreclosure:=LEFT.prim_range=RIGHT.situs1_prim_range AND
				LEFT.prim_name=RIGHT.situs1_prim_name AND LEFT.z5=RIGHT.situs1_zip,
			SELF:=LEFT),
		LEFT OUTER,LIMIT(ut.limits.Foreclosure_MAX,SKIP));

	RETURN DEDUP(SORT(ds_working_recs,acctno,~has_foreclosure),acctno);
END;