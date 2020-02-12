IMPORT iesp, Gateway, Royalty;

EXPORT RoyaltyNetWise := MODULE

  //Returns a dataset of royalties for the NetWise (Email) Data gateway
  EXPORT GetRoyalties(DATASET(iesp.net_wise_search.t_NetWiseEmailSearchResponse) ds_gw_response)
    := FUNCTION

    //Any response that is not an http error status and has data being returned will be charged as royalty.
    ds_royalty_counts := DATASET([{
      Royalty.Constants.RoyaltyCode.NETWISE_EMAIL,    // royalty_type_code
      Royalty.Constants.RoyaltyType.NETWISE_EMAIL,    // royalty_type
      COUNT(ds_gw_response((_Header.Status = Gateway.Constants.defaults.STATUS_SUCCESS) // royalty_count
                           AND 
                           // at least 1 of the 5 possible 'Results' child ds recs should have some data on it
                           (Results[1].Name.Text != '' or
                            Results[2].Name.Text != '' or 
                            Results[3].Name.Text != '' or 
                            Results[4].Name.Text != '' or 
                            Results[5].Name.Text != '')
                          )),
      0,  //non-royalty count, always zero for since only gateway(royalty) data is returned
      ''  // count_entity;  N/A for netwise
      }], Royalty.Layouts.Royalty);

    RETURN ds_royalty_counts;
  END;

END;
