IMPORT Royalty;
EXPORT RoyaltyAccudata := MODULE

  EXPORT GetOnlineRoyalties(inp, type_flag='TypeFlag') := 
  FUNCTIONMACRO
			dRoyalOut :=
					dataset(
						[{
							Royalty.Constants.RoyaltyCode.ACCUDATA_OCN_LNP, 
							Royalty.Constants.RoyaltyType.ACCUDATA_OCN_LNP, 
							count(inp(type_flag = Phones.Constants.TypeFlag.AccuData_OCN)), 
							0
						}], 
						Royalty.Layouts.Royalty
					);	
			RETURN dRoyalOut;		
  ENDMACRO;
 

  EXPORT GetBatchRoyaltiesByAcctno(dInF, dRecsOut, pTypeFlag='typeflag', fAcctno='acctno', fOrigAcctno='orig_acctno') := 
	FUNCTIONMACRO

		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l, RECORDOF(dRecsOut) r) :=
		TRANSFORM
			SELF.acctno							:= l.fOrigAcctno;
			SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.ACCUDATA_OCN_LNP;
			SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.ACCUDATA_OCN_LNP;
			SELF.royalty_count 			:= 1; 
			SELF.non_royalty_count 	:= 0;
		END;

		dMNRecsOut := dRecsOut(typeflag = Phones.Constants.TypeFlag.AccuData_OCN);
		dRoyaltiesByAcctno := JOIN(dInF, dMNRecsOut, (STRING)LEFT.fAcctno = (STRING)RIGHT.fAcctno, tPrepForRoyalty(LEFT, RIGHT));
		
		RETURN dRoyaltiesByAcctno;
		
  ENDMACRO;
	
END;



