IMPORT BatchServices,Bank_Routing;

EXPORT AccuityBankData_Records(
	DATASET(BatchServices.AccuityBankData_Layouts.batch_wrk) ds_batch_wrk
	) := FUNCTION

	CNST:=BatchServices.AccuityBankData_Constants;

	ds_batch_join := JOIN(ds_batch_wrk,Bank_Routing.key_rtn,
		LEFT.in_routing_nbr=RIGHT.routing_number_micr,
		TRANSFORM(BatchServices.AccuityBankData_Layouts.batch_wrk,
			SELF.err_search:=MAP(
				RIGHT.routing_number_micr='' => CNST.SrchCode.ABA_RTN_NOT_FOUND,
				RIGHT.state='' => CNST.SrchCode.BANK_STATE_NULL,
				LEFT.in_state!=RIGHT.state => CNST.SrchCode.BANK_STATE_NO_MATCH,
				LEFT.in_state=RIGHT.state => CNST.SrchCode.BANK_STATE_MATCHED,
				0),
			SELF.routing_number:=RIGHT.routing_number_micr,
			SELF.routing_state:=RIGHT.state,
			SELF:=LEFT),
		LEFT OUTER,LIMIT(CNST.Limits.JOIN_LIMIT,SKIP));

	ds_batch_out := DEDUP(SORT(ds_batch_join,(UNSIGNED)acctno,err_search),acctno);

	RETURN ds_batch_out;
END;
