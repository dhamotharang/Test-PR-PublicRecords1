IMPORT iesp, Gateway, Royalty;

EXPORT RoyaltyBriteverify := MODULE  
  //Returns a dataset of royalties for the BriteVerify gateway
	EXPORT GetRoyalties(DATASET(iesp.briteverify_email.t_BriteVerifyEmailResponse) ds_gw_response) := FUNCTION
		//Any response that is not an HTTP error status will be charged as royalty.
		dRoyal_counts := DATASET([{
			Royalty.Constants.RoyaltyCode.BRITE_VERIFY_EMAIL,                                    // royalty_type_code
			Royalty.Constants.RoyaltyType.BRITE_VERIFY_EMAIL,                                    // royalty_type
			COUNT(ds_gw_response(_Header.Status = Gateway.Constants.defaults.STATUS_SUCCESS)),   // royalty_count
			COUNT(ds_gw_response(_Header.Status != Gateway.Constants.defaults.STATUS_SUCCESS)),  // non_royalty_count
      ''                                                                                  // count_entity
		}],Royalty.Layouts.Royalty);

		RETURN dRoyal_counts;
	END;
END;