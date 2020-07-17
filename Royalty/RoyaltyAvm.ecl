IMPORT iesp, Royalty;

EXPORT RoyaltyAvm := MODULE
  //Returns a dataset of royalties for the Avm gateway
  EXPORT GetRoyalties(iesp.avm_internal_resp3.t_AVMInternalResponse gw_response) := FUNCTION

    Royalty.Layouts.Royalty create_royalty_out() := TRANSFORM
      SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.AVM;
      SELF.royalty_type := Royalty.Constants.RoyaltyType.AVM;
      SELF.royalty_count := IF(gw_response._Header.Status = 0, 1, 0);
      SELF.non_royalty_count := IF(gw_response._Header.Status != 0, 1, 0);
    END;

    royalty_out := ROW(create_royalty_out());
    RETURN royalty_out;
  END;
END;
