IMPORT MDR,Royalty;
EXPORT RoyaltyAccudata_CNAM := MODULE

  EXPORT GetOnlineRoyalties(inp, type_flag='source') := 
  FUNCTIONMACRO
			dRoyalOut :=
					DATASET(
						[{
							Royalty.Constants.RoyaltyCode.ACCUDATA_CNAM_CNM2, 
							Royalty.Constants.RoyaltyType.ACCUDATA_CNAM_CNM2, 
							COUNT(inp(type_flag = MDR.sourceTools.src_Phones_Accudata_CNAM_CNM2)), 
							0
						}], 
						Royalty.Layouts.Royalty
					);	
			RETURN dRoyalOut;		
  ENDMACRO;
 
	  EXPORT GetBatchRoyaltiesByAcctno(dInP, fSource='source', fPhone='phone', fAcctno='acctno') := 
	FUNCTIONMACRO

		// we're counting hits by phone
		dDupRecs := DEDUP(SORT(dInP(fSource = MDR.sourceTools.src_Phones_Accudata_CNAM_CNM2), fPhone, fAcctno), fPhone);

		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(recordof(dInP) l, integer c) :=
		TRANSFORM
			SELF.acctno							:= l.fAcctno;
			SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.ACCUDATA_CNAM_CNM2;
			SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.ACCUDATA_CNAM_CNM2;
			SELF.royalty_count 			:= c; 
			SELF.non_royalty_count 	:= 0;
		END;
		dRoyaltiesByAcctno := PROJECT(dDupRecs, tPrepForRoyalty(LEFT, 1));	
		
		RETURN SORT(dRoyaltiesByAcctno,fAcctno);
		
  ENDMACRO;
END;

