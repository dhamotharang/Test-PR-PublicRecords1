IMPORT $, Royalty, BatchServices, BatchShare;

EXPORT Batch_Records(
                      DATASET($.Layouts.batch_email_input) batch_in,
                      $.IParams.BatchParams batch_params,
                      BOOLEAN useCannedRecs = FALSE) := FUNCTION

      
    sample_email_set := BatchServices._Sample_inBatchMaster('EMAIL');
    test_email_recs := PROJECT(sample_email_set, TRANSFORM($.Layouts.batch_in_rec,
                                                            SELF.email := LEFT.sic_code,
                                                            SELF.phone10 := IF(LEFT.homephone<>'',LEFT.homephone,LEFT.workphone),
                                                            SELF := LEFT));
  
    batch_in_recs := PROJECT(batch_in, TRANSFORM($.Layouts.batch_in_rec,
                            SELF.phone10 := IF(LEFT.homephone<>'',LEFT.homephone,LEFT.workphone),
                            SELF := LEFT));
  
  
    ds_batch_in_email := IF (NOT useCannedRecs, batch_in_recs, test_email_recs);

    BatchShare.MAC_CapitalizeInput(ds_batch_in_email, ds_batch_in);
    
    email_params := MODULE(PROJECT(batch_params, $.IParams.EmailParams)) END;
    
    _recs := CASE(batch_params.SearchType,
                 $.Constants.SearchType.EIA => $.EmailIdentityAppendSearch(ds_batch_in,email_params),
                 $.Constants.SearchType.EAA => $.EmailAddressAppendSearch(ds_batch_in,email_params),
                 DATASET([],$.Layouts.email_final_rec) 
                 );
    
    
    // groupping records for royalty counts
    srtd_recs := GROUP(SORT(_recs, acctno, -date_last_seen, date_first_seen, -original.login_date, -process_date, RECORD), acctno);
    dRoyalties := Royalty.RoyaltyEmail.GetBatchRoyaltySet(srtd_recs, email_src, batch_params.MaxResultsPerAcct, batch_params.ReturnDetailedRoyalties);
    
    // Now combine results for output 
    res := ROW({_recs, dRoyalties}, $.Layouts.email_combined_rec);
    RETURN res;
END;
