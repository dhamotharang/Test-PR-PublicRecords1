EXPORT RoyaltyNetAcuityIpMetadata := MODULE

  EXPORT GetBatchRoyaltiesByAcctno(ds_in) := FUNCTIONMACRO

    Royalty.Layouts.RoyaltyForBatch tf_PrepForRoyalty(RECORDOF(ds_in) L) := TRANSFORM
      SELF.acctno            := L.orig_acctno;
      SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.NETACUITY_IPM;
      SELF.royalty_type      := Royalty.Constants.RoyaltyType.NETACUITY_IPM;
      // Check for input ip_address present and at least 1 major piece of ip_metadata was found and is being returned
      BOOLEAN IPMD_FOUND     := IF(L.ip_address !='' and (L.edge_country !='' or L.edge_region !='' or L.edge_city != ''),
                                   TRUE, FALSE);
      SELF.royalty_count     := IF(IPMD_FOUND, 1,0);
      SELF.non_royalty_count := IF(IPMD_FOUND, 0,1);
      SELF.count_entity      := L.ip_address;
    END;

    ds_RoyaltiesByAcctno := PROJECT(ds_in, tf_PrepForRoyalty(LEFT));

    RETURN ds_RoyaltiesByAcctno;

  ENDMACRO;

END;
