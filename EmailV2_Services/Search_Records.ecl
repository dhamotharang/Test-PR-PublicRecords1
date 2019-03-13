IMPORT $, Royalty, iesp, BatchShare, AutoKeyI;

EXPORT Search_Records(
                      iesp.emailfinder.t_EmailFinderSearchBy  rec_in,
                      $.IParams.SearchParams search_params) := FUNCTION

      
    ds_search_in := PROJECT(DATASET([rec_in],iesp.emailfinder.t_EmailFinderSearchBy), $.Transforms.xfSearchIn(LEFT));
  
    BatchShare.MAC_CapitalizeInput(ds_search_in, ds_batch);
    
    email_params := MODULE(PROJECT(search_params, $.IParams.EmailParams)) END;
    
    res_row := CASE(search_params.SearchType,
                 $.Constants.SearchType.EIA => $.EmailIdentityAppendSearch(ds_batch,email_params),
                 $.Constants.SearchType.EAA => $.EmailAddressAppendSearch(ds_batch,email_params),
                 $.Constants.SearchType.EIC => $.EmailIdentityCheckSearch(ds_batch,email_params),
                 ROW({[],[]}, $.Layouts.email_combined_rec) 
                 );
                 
    _recs := res_row.Records;
    gw_royalties:= PROJECT(res_row.Royalties, Royalty.Layouts.Royalty);  // royalties for gateway sources are already counted
    
    inh_royalties := Royalty.RoyaltyEmail.GetRoyaltySet(_recs, email_src);
    
    BOOLEAN no_results_found := ~EXISTS(_recs(~is_rejected_rec));
    BOOLEAN has_error := EXISTS(_recs(is_rejected_rec));
    _status := MAP(has_error => _recs(is_rejected_rec)[1].record_err_code,
                   no_results_found => AutoKeyI.errorcodes._codes.NO_RECORDS,
                   0);
                         
    
    _header := ROW($.Transforms.xfAddHeader(_status,_recs(is_rejected_rec)));  
    // final transform for records
    search_recs := CHOOSEN(PROJECT(_recs(~is_rejected_rec), 
                           $.Transforms.xfSearchOut(LEFT, search_params.dob_mask)),iesp.Constants.Email.MAX_RECS);
    input_subject := ROW($.Transforms.xfInputEcho(rec_in, _recs[1].subject_lexid)); 
    
    response_row := ROW({_header, search_recs, input_subject}, iesp.emailfinder.t_EmailFinderSearchResponse);
    
    // Now combine results for output 
    combined_rec := RECORD
      iesp.emailfinder.t_EmailFinderSearchResponse Response;
      DATASET(Royalty.Layouts.Royalty) Royalties;
    END;

    res := ROW({response_row, inh_royalties + gw_royalties}, combined_rec);
    
    // OUTPUT(ds_batch_in, named('ds_batch_in'));
    
    RETURN res;
END;
