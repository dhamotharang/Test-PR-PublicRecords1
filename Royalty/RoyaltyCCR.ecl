IMPORT MDR;
EXPORT RoyaltyCCR := MODULE

	EXPORT GetOnlineRoyalties(ds_in,pSource='Source') := FUNCTIONMACRO
		dRoyalOut := DATASET([{
			Royalty.Constants.RoyaltyCode.EFX_CCR,
			Royalty.Constants.RoyaltyType.EFX_CCR,
			COUNT(ds_in(pSource=MDR.sourceTools.src_Equifax)),
			0
		}],Royalty.Layouts.Royalty);
		RETURN dRoyalOut;
	ENDMACRO;

	EXPORT GetBatchRoyaltiesByAcctno(ds_in,pSource='Source',fAcctno='AccountNumber') := FUNCTIONMACRO
		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(ds_in L) := TRANSFORM
			SELF.acctno            := L.fAcctno;
			SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.EFX_CCR;
			SELF.royalty_type      := Royalty.Constants.RoyaltyType.EFX_CCR;
			SELF.royalty_count     := 1; 
			SELF.non_royalty_count := 0;
		END;
		dRoyaltiesByAcctno := PROJECT(ds_in(pSource=MDR.sourceTools.src_Equifax),tPrepForRoyalty(LEFT));
		RETURN dRoyaltiesByAcctno;
	ENDMACRO;
	
END;
