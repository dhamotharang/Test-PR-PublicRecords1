IMPORT BatchServices;

EXPORT AccuityBankData_Functions := MODULE

  // Set 1 or 2 bank routing/state/ip_addr related output fields based upon error_code and/or err_search values
  // which were already set in BatchServices.AccuityBankData_Records before this function is called.
  EXPORT fn_SetOutputs (DATASET(BatchServices.AccuityBankData_Layouts.batch_wrk) ds_batch_wrk_in,
                        BOOLEAN IncludeGeotriangulationComparison = FALSE,
                        BOOLEAN GeoTriangQueryRun = FALSE
                       ) := FUNCTION

    CNST := BatchServices.AccuityBankData_Constants;

    //  v--- Cloned from BatchServices.AccuityBankData_BatchService "setOutputs" transform and revised as needed
    // Needed to make it a function so it could be called by both BatchServices.AccuityBankData_BatchService AND
    // GeoTriangulation_Services.BatchService
    BatchServices.AccuityBankData_Layouts.batch_out tf_SetOutputs (BatchServices.AccuityBankData_Layouts.batch_wrk L) := TRANSFORM 

      SELF.acctno := IF(GeoTriangQueryRun, L.acctno, L.orig_acctno);  // For GeoTriang Batch service runs, need to preserve seq acctno, not orig_acctno

      SELF.ultimate_bank_in_state := MAP(
        L.error_code = CNST.ErrCode.INSUFFICIENT_INPUT   => CNST.ErrMsg.INSUFFICIENT_INPUT,
        L.err_search = CNST.SrchCode.BANK_STATE_MATCHED  => CNST.SrchMsg.BANK_STATE_MATCHED,
        L.err_search = CNST.SrchCode.BANK_STATE_NO_MATCH => CNST.SrchMsg.BANK_STATE_NO_MATCH,
        L.err_search = CNST.SrchCode.BANK_STATE_NULL     => CNST.SrchMsg.BANK_STATE_NULL,
        L.err_search = CNST.SrchCode.ABA_RTN_NOT_FOUND   => CNST.SrchMsg.ABA_RTN_NOT_FOUND,
        '');

      NO_MATCH_OR_NULL      := [CNST.SrchCode.BANK_STATE_NO_MATCH, CNST.SrchCode.BANK_STATE_NULL];
      SELF.geotriangulation := IF(IncludeGeotriangulationComparison,
        MAP((L.error_code = CNST.ErrCode.INSUFFICIENT_INPUT OR 
             L.err_search = CNST.SrchCode.ABA_RTN_NOT_FOUND)                              => '',
            L.in_region = ''                                                              => CNST.ErrMsg.INSUFFICIENT_INPUT,
            L.err_search = CNST.SrchCode.BANK_STATE_MATCHED AND L.in_region =  L.in_state => CNST.GeoMsg.REGION_MATCHED,
            L.err_search = CNST.SrchCode.BANK_STATE_MATCHED AND L.in_region != L.in_state => CNST.GeoMsg.REGION_IP_MISMATCH,
            L.err_search IN NO_MATCH_OR_NULL AND L.in_region=L.in_state                   => CNST.GeoMsg.REGION_BANK_MISMATCH,
            L.err_search IN NO_MATCH_OR_NULL AND L.in_region!=L.in_state                  => CNST.GeoMsg.REGION_NO_MATCH,
            ''),
        '');

      SELF := L;
		  SELF := [];
    END;
          
    ds_outputs_set := PROJECT(ds_batch_wrk_in, tf_SetOutputs(LEFT));

    // *--- DEBUG ---* //
    //OUTPUT(ds_batch_wrk_in, NAMED('fnso_ds_batch_wrk_in'));
    //OUTPUT(ds_outputs_set,  NAMED('fnso_ds_outputs_set'));
      
    RETURN ds_outputs_set;
  
  END;

END;