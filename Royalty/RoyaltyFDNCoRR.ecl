Import Royalty; 

EXPORT RoyaltyFDNCoRR:= MODULE

	EXPORT GetBatchRoyaltiesByAcctno(dInF, royalty_Count_field='FDN_count') := FUNCTIONMACRO
	
		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l) := TRANSFORM
			SELF.acctno							:= l.acctno;
			SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.FDNCORR;
			SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.FDNCORR;
			SELF.royalty_count 			:= l.royalty_Count_field;
			SELF.non_royalty_count 	:= 0;
		END;
		
		dRoyaltiesByAcctno := project(dInF, tPrepForRoyalty(LEFT));
		
		RETURN dRoyaltiesByAcctno;
	ENDMACRO;

	EXPORT GetOnlineRoyalties(ds_in,isFDNOnly = FALSE,SourceField ='\'\'', SourceFieldValue='\'\'') := FUNCTIONMACRO

		dRoyalOut := 
			DATASET([{
				Royalty.Constants.RoyaltyCode.FDNCORR,
				Royalty.Constants.RoyaltyType.FDNCORR,
				IF(isFDNOnly,COUNT(ds_in),COUNT(ds_in(SourceField = SourceFieldValue))),
				0	}],Royalty.Layouts.Royalty);   
		
		RETURN dRoyalOut ;
	ENDMACRO;
		
END;