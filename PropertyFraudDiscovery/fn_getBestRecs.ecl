IMPORT Govt_Collections_Services;

EXPORT fn_getBestRecs(DATASET(Layouts.batch_in) ds_batch_in,
	IParams.BatchParams in_mod) := FUNCTION

	gcs_mod := MODULE(PROJECT(in_mod,Govt_Collections_Services.IParams.BatchParams,OPT))END;
	ds_gcs_batch_in := PROJECT(ds_batch_in,TRANSFORM(Govt_Collections_Services.Layouts.batch_working,SELF:=LEFT,SELF:=[]));

	ds_best_addr_recs := Govt_Collections_Services.fn_getBestAddressRecs(ds_gcs_batch_in,gcs_mod);		// 4.3.4
	ds_expd_ssn_recs  := Govt_Collections_Services.fn_getExpandedSSNRecs(ds_best_addr_recs,gcs_mod);	// 4.3.2
	ds_ADL_best_recs  := Govt_Collections_Services.fn_getBestADLRecs(ds_expd_ssn_recs,gcs_mod);				// 4.3.3

	ds_working_recs := JOIN(ds_batch_in,ds_ADL_best_recs,LEFT.acctno=RIGHT.acctno,
											TRANSFORM(Layouts.batch_working,SELF.did:=(UNSIGNED)RIGHT.lex_id,SELF:=LEFT,SELF:=RIGHT,SELF:=[]),
											KEEP(1));

	RETURN ds_working_recs;
END;
