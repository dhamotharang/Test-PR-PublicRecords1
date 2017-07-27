EXPORT RoyaltyWorldCheck := module
	
	export GetBatchRoyaltySet(dRecsOut, pSrcField='score', pReturnDetails = 'false') := functionmacro

		dRoyaltiesByAcctno := 
				project(dRecsOut, 
								transform(Royalty.Layouts.RoyaltyForBatch,
										self.acctno 						:= left.acctno;										
										self.royalty_type_code	:= Royalty.Constants.RoyaltyCode.WORLDCHECK;
										self.royalty_type 			:= Royalty.Constants.RoyaltyType.WORLDCHECK;
										self.royalty_count 			:= if(left.pSrcField<>'', 1, skip);
										self.non_royalty_count 	:= 0;
								));		 

		dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, pReturnDetails);	
		return dRoyalties;
		
	endmacro;
end;