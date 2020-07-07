IMPORT $, Royalty, iesp, BatchShare, AutoKeyI;

EXPORT Search_Records(
                      iesp.emailsearchv2.t_EmailSearchV2SearchBy  rec_in,
                      $.IParams.SearchParams search_params) := FUNCTION


    ds_search_in := PROJECT(DATASET([rec_in],iesp.emailsearchv2.t_EmailSearchV2SearchBy), $.Transforms.xfSearchIn(LEFT));

    BatchShare.MAC_CapitalizeInput(ds_search_in, ds_batch);

    email_params := MODULE(PROJECT(search_params, $.IParams.EmailParams)) END;
    res_row := CASE(search_params.SearchType,
                 $.Constants.SearchType.EIA => $.EmailIdentityAppendSearch(ds_batch,email_params),
                 $.Constants.SearchType.EAA => $.EmailAddressAppendSearch(ds_batch,email_params, require_full_address_check:=TRUE),
                 $.Constants.SearchType.EIC => $.EmailIdentityCheckSearch(ds_batch,email_params),
                 ROW({[],[]}, $.Layouts.email_combined_rec)
                 );

   _recs := res_row.Records;
    all_royalties := $.Functions.CalculateRoyalties(res_row).Royalties;

    BOOLEAN no_results_found := ~EXISTS(_recs(~is_rejected_rec));
    BOOLEAN has_error := EXISTS(_recs(is_rejected_rec));
    _status := MAP(has_error => _recs(is_rejected_rec)[1].record_err_code,
                   no_results_found => AutoKeyI.errorcodes._codes.NO_RECORDS,
                   0);


    _header := ROW($.Transforms.xfAddHeader(_status,_recs(is_rejected_rec)));
    // final transform for records
    search_recs := CHOOSEN(PROJECT(_recs(~is_rejected_rec),
                           $.Transforms.xfSearchOut(LEFT)),iesp.Constants.Email.MAX_RECS);
    input_subject := ROW($.Transforms.xfInputEcho(rec_in, _recs[1].subject_lexid));

    response_row := ROW({_header, COUNT(search_recs), search_recs, input_subject}, iesp.emailsearchv2.t_EmailSearchV2Response);

    // Now combine results for output
    combined_rec := RECORD
      iesp.emailsearchv2.t_EmailSearchV2Response Response;
      DATASET(Royalty.Layouts.Royalty) Royalties;
    END;

    res := ROW({response_row, all_royalties}, combined_rec);

    // OUTPUT(ds_batch_in, named('ds_batch_in'));

    RETURN res;
END;
