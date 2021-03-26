IMPORT iesp, Royalty;

EXPORT RoyaltyEmailRisk := MODULE

  EXPORT GetRoyalties(DATASET(iesp.emailrisk.t_EmailRiskResponse) ds_gw_response) := FUNCTION

    dRoyal_counts := DATASET([{
      Royalty.Constants.RoyaltyCode.EMAIL_RISK_NR,
      Royalty.Constants.RoyaltyType.EMAIL_RISK_NR,
      0,
      COUNT(ds_gw_response),
      ''
    }], Royalty.Layouts.Royalty);

    RETURN dRoyal_counts;

  END;
END;
