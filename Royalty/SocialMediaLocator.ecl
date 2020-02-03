IMPORT iesp, Gateway, Royalty;

EXPORT SocialMediaLocator := MODULE
  //Returns a dataset of royalties for the SocialMediaLocator gateway
  EXPORT GetRoyalties(iesp.social_media_locator_response.t_SocialMediaLocatorResponse gw_response) := FUNCTION

    Royalty.Layouts.Royalty create_royalty_out() := TRANSFORM
      SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.SMLOCATOR;
      SELF.royalty_type := Royalty.Constants.RoyaltyType.SMLOCATOR;
      SELF.royalty_count := COUNT(gw_response.ReportResults);
      SELF.non_royalty_count := 0; //Doesn't make sense to populate this number in this context.
    END;

    royalty_out := ROW(create_royalty_out());
    RETURN royalty_out;
  END;
END;
