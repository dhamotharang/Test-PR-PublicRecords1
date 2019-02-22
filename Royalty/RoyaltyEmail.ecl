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

	export GetRoyaltySet(dRecsIn, pSrcField='email_src', isFCRA = false) := functionmacro

    _royalty_set 	:= Royalty.Constants.EMAIL_ROYALTY_SET(isFCRA);
    
    Royalty.Layouts.Royalty xAddRoyalty(recordof(dRecsIn) l) := transform	
      _royalty_type_code 		 := Royalty.Functions.GetEmailRoyaltyCode(l.pSrcField);
      self.royalty_type_code := IF(_royalty_type_code> 0, _royalty_type_code, skip);
      self.royalty_type 		 := Royalty.Functions.GetEmailRoyaltyType(l.pSrcField);
      self.royalty_count 		 := if(l.pSrcField in _royalty_set, 1, 0);
      self.non_royalty_count := if(l.pSrcField in _royalty_set, 0, 1);
    end;

    royalties_sorted := sort(project(dRecsIn, xAddRoyalty(left)), Royalty_type_code);		
    
    Royalty.Layouts.Royalty	xCombine(Royalty.Layouts.Royalty L, Royalty.Layouts.Royalty R) := transform
      self.Royalty_type_code := L.Royalty_type_code;
      self.Royalty_type := L.Royalty_type;
      self.Royalty_count := L.Royalty_count + R.Royalty_count;
      self.non_Royalty_count := L.non_Royalty_count + R.non_Royalty_count;
      self.count_entity := L.count_entity + R.count_entity;
    end;

    CombinedRoyalties := rollup(royalties_sorted, LEFT.Royalty_type_code = RIGHT.Royalty_type_code, xCombine(LEFT, RIGHT));

    return CombinedRoyalties;
	endmacro;
	
end;