IMPORT Royalty;
EXPORT RoyaltyEFXDataMart := MODULE

	EXPORT GetBatchRoyaltiesByAcctno(dInF, dRecsOut, pPhoneType='royalty_type', fAcctno='acctno', fOrigAcctno='orig_acctno', royalty_type_value = 'Royalty.Constants.RoyaltyType.EFX_DATA_MART') := FUNCTIONMACRO
		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l, RECORDOF(dRecsOut) r) :=
		TRANSFORM
			SELF.acctno							:= l.fOrigAcctno;
			SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.EFX_DATA_MART;
			SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.EFX_DATA_MART;
			SELF.royalty_count 			:= 1; 
			SELF.non_royalty_count 	:= 0;
		END;

		dMNRecsOut := dRecsOut(pPhoneType=royalty_type_value);
		dRoyaltiesByAcctno := JOIN(dInF, dMNRecsOut, (STRING)LEFT.fAcctno = (STRING)RIGHT.fAcctno, tPrepForRoyalty(LEFT, RIGHT));
		RETURN dRoyaltiesByAcctno;
	ENDMACRO;
	
	EXPORT MAC_GetWebRoyalties(recs, royal_out, royalty_type_field = 'royalty_type', royalty_type_value = Royalty.Constants.RoyaltyType.EFX_DATA_MART) := 
		macro
			royal_out := 
					dataset(
						[{
							Royalty.Constants.RoyaltyCode.EFX_DATA_MART, 
							Royalty.Constants.RoyaltyType.EFX_DATA_MART, 
							count(recs(royalty_type_field = royalty_type_value)), 
							0
						}], 
						Royalty.Layouts.Royalty
					);			
		ENDMACRO;

END;