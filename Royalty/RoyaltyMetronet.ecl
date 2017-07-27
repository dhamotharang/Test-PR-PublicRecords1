IMPORT MDR;

EXPORT RoyaltyMetronet := MODULE

	EXPORT GetBatchRoyaltiesByAcctno(dInF, dRecsOut, pPhoneType='subj_phone_type_new', fAcctno='acctno', fOrigAcctno='orig_acctno') := 
	FUNCTIONMACRO

		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l, RECORDOF(dRecsOut) r) :=
		TRANSFORM
			SELF.acctno							:= l.fOrigAcctno;
			SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.METRONET;
			SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.METRONET;
			SELF.royalty_count 			:= 1; 
			SELF.non_royalty_count 	:= 0;
		END;

		dMNRecsOut := dRecsOut(pPhoneType=MDR.sourceTools.src_Metronet_Gateway);
		dRoyaltiesByAcctno := JOIN(dInF, dMNRecsOut, (STRING)LEFT.fAcctno = (STRING)RIGHT.fAcctno, tPrepForRoyalty(LEFT, RIGHT));
		
		RETURN dRoyaltiesByAcctno;
		
	ENDMACRO;
	
end;