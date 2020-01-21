IMPORT iesp, Gateway, Royalty;

EXPORT RoyaltyNetWise := MODULE

  //Returns a dataset of royalties for the NetWise (Email) Data gateway
  EXPORT GetRoyalties(DATASET(iesp.net_wise_search.t_NetWiseEmailSearchResponseEx) ds_gw_response)
    := FUNCTION

    //Any response that is not an http error status will be charged as royalty.
    ds_royalty_counts := DATASET([{
      Royalty.Constants.RoyaltyCode.NETWISE_EMAIL,    // royalty_type_code
      Royalty.Constants.RoyaltyType.NETWISE_EMAIL,    // royalty_type
      COUNT(ds_gw_response(Response._Header.Status =  // royalty_count
                           Gateway.Constants.defaults.STATUS_SUCCESS)),
      0,  //non-royalty count, always zero for since only gateway(royalty) data is returned
      ''  // count_entity;  N/A for netwise
      }], Royalty.Layouts.Royalty);

    RETURN ds_royalty_counts;
  END;

END;
