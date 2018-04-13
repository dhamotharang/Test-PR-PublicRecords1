EXPORT RoyaltyEmail := module

	export GetBatchRoyaltySet(dRecsOut, pSrcField='email_src', vMaxEmailPerAcctno = 10, 
		pReturnDetails = 'false', isFCRA = false) := functionmacro
		 	
		 // Rule: for each acctno, count only 1 royalty by src  
		 dTopRecsBySrc	:= dedup(sort(topn(dRecsOut, vMaxEmailPerAcctno, acctno), acctno, pSrcField), acctno, pSrcField); 

		 // royalties by acctno
		 dRoyaltiesByAcctno := 
							project(dTopRecsBySrc, 
									transform(Royalty.Layouts.RoyaltyForBatch,
										_isPayable 							:= left.pSrcField in Royalty.Constants.EMAIL_ROYALTY_SET(isFCRA);
										self.acctno 						:= left.acctno;										
										self.royalty_type_code	:= Royalty.Functions.GetEmailRoyaltyCode(left.pSrcField);
										self.royalty_type 			:= Royalty.Functions.GetEmailRoyaltyType(left.pSrcField);
										self.royalty_count 			:= if(_isPayable, 1, 0);
										self.non_royalty_count 	:= if(_isPayable, 0, 1);
										));
		 
		 dRoyalties := Royalty.GetBatchRoyalties(ungroup(dRoyaltiesByAcctno(royalty_type_code>0)), pReturnDetails);			 
		 return dRoyalties;
		 
	endmacro;
	
end;