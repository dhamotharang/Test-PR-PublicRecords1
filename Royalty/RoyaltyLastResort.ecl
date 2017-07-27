import MDR;

EXPORT RoyaltyLastResort := module
	
	EXPORT GetBatchRoyaltiesByAcctno(dInF, dRecsOut, pVendorID='vendor_id', pEntityField='phone', pAcctno = 'orig_acctno') := 
	FUNCTIONMACRO

		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l, RECORDOF(dRecsOut) r) :=
		TRANSFORM
			self.acctno							:= l.pAcctno;
			self.royalty_type_code	:= Royalty.Constants.RoyaltyCode.LAST_RESORT;
			self.royalty_type 			:= Royalty.Constants.RoyaltyType.LAST_RESORT;
			self.royalty_count 			:= 1; 
			self.non_royalty_count 	:= 0;
			self.count_entity				:= r.pEntityField;
		END;
		
		dLRRecsOut := dRecsOut(pVendorID=MDR.sourceTools.src_wired_Assets_Royalty);
		dRoyaltiesByAcctno := JOIN(dInF, dLRRecsOut, LEFT.acctno = RIGHT.acctno, tPrepForRoyalty(LEFT, RIGHT));

		RETURN dRoyaltiesByAcctno;
		
	endmacro;
	
end;