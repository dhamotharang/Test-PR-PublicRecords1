IMPORT Royalty,Phones;
EXPORT RoyaltyZumigoGetLineIdentity := MODULE

  EXPORT GetOnlineRoyalties(inp, type_flag='source') := 
  FUNCTIONMACRO
			dRoyalOut :=
					dataset(
						[{
							Royalty.Constants.RoyaltyCode.ZUMIGO_IDENTITY, 
							Royalty.Constants.RoyaltyType.ZUMIGO_IDENTITY, 
							count(inp(type_flag = Phones.Constants.GatewayValues.ZumigoIdentity)), 
							0
						}], 
						Royalty.Layouts.Royalty
					);	
			RETURN dRoyalOut;		
  ENDMACRO;
 

  EXPORT GetBatchRoyaltiesByAcctno(dInF, fSource='source', fPhone='submitted_phonenumber', fAcctno='acctno') := 
	FUNCTIONMACRO

		// we're counting hits by phone
		dInFHits := dedup(sort(dInF(fSource = Phones.Constants.GatewayValues.ZumigoIdentity), fPhone, fAcctno), fPhone);
		dInNoHits := join(dedup(sort(dInF, fAcctno), fAcctno), dInFHits, left.fAcctno = right.fAcctno, left only);

		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(recordof(dInF) l, integer c) :=
		TRANSFORM
			SELF.acctno							:= l.fAcctno;
			SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.ZUMIGO_IDENTITY;
			SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.ZUMIGO_IDENTITY;
			SELF.royalty_count 			:= c; 
			SELF.non_royalty_count 	:= 0;
		END;
		dHits := project(dInFHits, tPrepForRoyalty(left, 1));
		dNoHits := project(dInNoHits, tPrepForRoyalty(left, 0));		
		dRoyaltiesByAcctno := sort(dHits + dNoHits, fAcctno);
		
		RETURN dRoyaltiesByAcctno;
		
  ENDMACRO;
	
END;



