IMPORT iesp, Gateway, Royalty;

EXPORT RoyaltyNetWise := MODULE

  //Returns a dataset of royalties for the NetWise (Email) Data gateway
  EXPORT GetRoyalties(DATASET(iesp.net_wise_search.t_NetWiseEmailSearchResponse) ds_gw_response)
    := FUNCTION

    //Any response that is not an http error status and has <Results> data being returned will be charged as royalty.
    ds_royalty_counts := DATASET([{
      Royalty.Constants.RoyaltyCode.NETWISE_EMAIL,    // royalty_type_code
      Royalty.Constants.RoyaltyType.NETWISE_EMAIL,    // royalty_type
      COUNT(ds_gw_response((_Header.Status = Gateway.Constants.defaults.STATUS_SUCCESS) // royalty_count
                           AND 
                           // At least 1 non-blank <Results> record being returned.
                           RecordCount > 0)), //See Gateway.NetwiseSearch.Functions for more info.
      0,  //non-royalty count, always zero since only gateway(royalty) data is returned
      ''  // count_entity;  N/A for netwise
      }], Royalty.Layouts.Royalty);

    RETURN ds_royalty_counts;
  END;

END;
