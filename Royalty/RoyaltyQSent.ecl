EXPORT RoyaltyQSent := MODULE

	EXPORT GetBatchRoyaltiesByAcctno(dInF, dRecsOut, pVendorID='vendor_id', pTypeFlag='typeflag', fAcctno='acctno', fOrigAcctno='orig_acctno') := 
	FUNCTIONMACRO

		import MDR,Phones;

		Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l, RECORDOF(dRecsOut) r) :=
		TRANSFORM
			
			_rtype := map(
				r.pVendorID=MDR.sourceTools.src_Inhouse_QSent 					=> Royalty.Constants.RoyaltyCode.QSENT,
				r.pTypeFlag=Phones.Constants.TypeFlag.DataSource_iQ411 	=> Royalty.Constants.RoyaltyCode.QSENT_IQ411,
				r.pTypeFlag=Phones.Constants.TypeFlag.DataSource_PV 		=> Royalty.Constants.RoyaltyCode.QSENT_PVS,
				0);
		
			self.acctno							:= l.fOrigAcctno;
			self.royalty_type_code	:= if(_rtype>0, _rtype, skip);
			self.royalty_type 			:= Royalty.Functions.GetRoyaltyType(_rtype);
			self.royalty_count 			:= 1; 
			self.non_royalty_count 	:= 0;			
		END;
		
		dRoyaltiesByAcctno := JOIN(dInF, dRecsOut, (string)LEFT.fAcctno = (string)RIGHT.fAcctno, tPrepForRoyalty(LEFT, RIGHT)); 			
		RETURN dRoyaltiesByAcctno;
		
	ENDMACRO;

end;	