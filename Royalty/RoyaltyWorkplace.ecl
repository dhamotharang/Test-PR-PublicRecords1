EXPORT RoyaltyWorkplace := module
	
	EXPORT GetEmailRoyaltySet(dRecsOut, Emailsrcfield):= FUNCTIONMACRO
		
		dRoyaltiesByEmail := 
			PROJECT(dRecsOut, 
					TRANSFORM(Royalty.Layouts.RoyaltyForBatch,
						_isPayable 							:= LEFT.Emailsrcfield IN Royalty.Constants.EMAIL_ROYALTY_SET();						
						SELF.acctno 						:= LEFT.acctno;										
						SELF.royalty_type_code	:= Royalty.Functions.GetEmailRoyaltyCode(LEFT.Emailsrcfield);
						SELF.royalty_type 			:= Royalty.Functions.GetEmailRoyaltyType(LEFT.Emailsrcfield);
						SELF.royalty_count 			:= IF(_isPayable, 1, SKIP); // we currently only track royalty sources, so I'm keeping that same behavior.
						SELF.non_royalty_count 	:= 0;
						));
	
	RETURN dRoyaltiesByEmail;
	ENDMACRO;		
	
	export GetBatchRoyaltySet(dRecsOut, pSrcField='source', pReturnDetails = 'false', pSpouseSrcField='spouse_source',
														pEmailSrc1= 'email_src1', pEmailSrc2= 'email_src2', pEmailSrc3= 'email_src3',
														pEmailSrc_spouse1= 'spouse_email_src1', pEmailSrc_spouse2= 'spouse_email_src2', pEmailSrc_spouse3= 'spouse_email_src3'
														) := functionmacro
		
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
			
			
			dRoyaltiesByEmail1:= Royalty.RoyaltyWorkplace.GetEmailRoyaltySet(dRecsOut, pEmailSrc1);	
			dRoyaltiesByEmail2:= Royalty.RoyaltyWorkplace.GetEmailRoyaltySet(dRecsOut, pEmailSrc2);	
			dRoyaltiesByEmail3:= Royalty.RoyaltyWorkplace.GetEmailRoyaltySet(dRecsOut, pEmailSrc3);	
			dRoyaltiesByEmail_spouse_1:= Royalty.RoyaltyWorkplace.GetEmailRoyaltySet(dRecsOut, pEmailSrc_spouse1);	
			dRoyaltiesByEmail_spouse_2:= Royalty.RoyaltyWorkplace.GetEmailRoyaltySet(dRecsOut, pEmailSrc_spouse2);	
			dRoyaltiesByEmail_spouse_3:= Royalty.RoyaltyWorkplace.GetEmailRoyaltySet(dRecsOut, pEmailSrc_spouse3);	
						
		dRoyalties := Royalty.GetBatchRoyalties(ungroup(dRoyaltiesByAcctno+dRoyaltiesByAcctnoSpouse+dRoyaltiesByEmail1+dRoyaltiesByEmail2+dRoyaltiesByEmail3+dRoyaltiesByEmail_spouse_1+dRoyaltiesByEmail_spouse_2+dRoyaltiesByEmail_spouse_3), pReturnDetails);		
		return dRoyalties;
	endmacro;
end;