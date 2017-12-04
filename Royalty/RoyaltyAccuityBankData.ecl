EXPORT RoyaltyAccuityBankData := MODULE

	EXPORT GetBatchRoyaltiesByAcctno(ds_in) := FUNCTIONMACRO
		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(ds_in) L) := TRANSFORM
			SELF.acctno            := L.orig_acctno;
			SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.ACCUITY_BANK_ROUTING;
			SELF.royalty_type      := Royalty.Constants.RoyaltyType.ACCUITY_BANK_ROUTING;
			SELF.royalty_count     := IF(L.routing_number!='',1,0);
			SELF.non_royalty_count := IF(L.routing_number!='',0,1);
		END;
		dRoyaltiesByAcctno := PROJECT(ds_in,tPrepForRoyalty(LEFT));
		RETURN dRoyaltiesByAcctno;
	ENDMACRO;
	
END;
