//Returns a dataset of royalties for the Equifax EMS gateway.

IMPORT iesp, FCRAGateway_Services, Royalty;
EXPORT RoyaltyEquifaxEMS := MODULE
  EXPORT GetRoyalties(iesp.equifax_ems.t_EquifaxEmsResponse gw_response) := FUNCTION
    //Any response that is not an HTTP error status will be charged, even if there is no match found.
    is_royalty_charged := gw_response._Header.Status = FCRAGateway_Services.Constants.GatewayStatus.SUCCESS;
    
    Royalty.Layouts.Royalty create_royalty_out() := TRANSFORM
      SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.EFX_EMS;
      SELF.royalty_type := Royalty.Constants.RoyaltyType.EFX_EMS;
      SELF.royalty_count := IF(is_royalty_charged, 1, 0);
      SELF.non_royalty_count := IF(is_royalty_charged, 0, 1);
    END;
    
    royalty_out := ROW(create_royalty_out());
    RETURN royalty_out;
  END;
END;