EXPORT RoyaltyWorkplace := module

	export GetBatchRoyaltySet(dRecsOut, pSrcField='source', pReturnDetails = 'false', pSpouseSrcField='spouse_source') := functionmacro
		
		dRoyaltiesByAcctno := 
			project(dRecsOut, 
					transform(Royalty.Layouts.RoyaltyForBatch,
						_isPayable 							:= left.pSrcField in Royalty.Constants.WORKPLACE_ROYALTY_SET;
						_rCode									:= Royalty.Functions.GetWorkplaceTypeCode(left.pSrcField);
						_rType									:= Royalty.Functions.GetRoyaltyType(_rCode);										
						self.acctno 						:= left.acctno;										
						self.royalty_type_code	:= _rCode;
						self.royalty_type 			:= _rType;
						self.royalty_count 			:= if(_isPayable, 1, skip); // we currently only track royalty sources, so I'm keeping that same behavior.
						self.non_royalty_count 	:= 0;
						));		
    
		dRoyaltiesByAcctnoSpouse := 
			project(dRecsOut, 
					transform(Royalty.Layouts.RoyaltyForBatch,
						_isPayable 							:= left.pSpouseSrcField in Royalty.Constants.WORKPLACE_ROYALTY_SET;
						_rCode									:= Royalty.Functions.GetWorkplaceTypeCode(left.pSpouseSrcField, true);
						_rType									:= Royalty.Functions.GetRoyaltyType(_rCode);										
						self.acctno 						:= left.acctno;										
						self.royalty_type_code	:= _rCode;
						self.royalty_type 			:= _rType;
						self.royalty_count 			:= if(_isPayable, 1, skip); // we currently only track royalty sources, so I'm keeping that same behavior.
						self.non_royalty_count 	:= 0;
						));				
		
		dRoyalties := Royalty.GetBatchRoyalties(ungroup(dRoyaltiesByAcctno+dRoyaltiesByAcctnoSpouse), pReturnDetails);		
		return dRoyalties;
	endmacro;
end;