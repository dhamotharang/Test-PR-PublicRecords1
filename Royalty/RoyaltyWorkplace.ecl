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

  EXPORT GetRoyaltySet(dRecsIn, pSrcField='source') := FUNCTIONMACRO

    royalty_set := Royalty.Constants.WORKPLACE_ROYALTY_SET;

    Royalty.Layouts.Royalty xAddRoyalty(RECORDOF(dRecsIn) L) := TRANSFORM  
      royalty_type_code      := Royalty.Functions.GetWorkplaceTypeCode(L.pSrcField);
      royalty_type           := Royalty.Functions.GetRoyaltyType(royalty_type_code);
      is_royalty             := L.pSrcField IN royalty_set;
      is_valid_type_code     := royalty_type_code > 0;

      SELF.royalty_type      := royalty_type;
      SELF.royalty_type_code := IF(is_valid_type_code, royalty_type_code, SKIP);
      SELF.royalty_count     := IF(is_royalty, 1, 0);
      SELF.non_royalty_count := IF(is_royalty, 0, SKIP);
    END;

    royalties_sorted := sort(project(dRecsIn, xAddRoyalty(left)), Royalty_type_code);    
    
    Royalty.Layouts.Royalty xCombine(Royalty.Layouts.Royalty L, Royalty.Layouts.Royalty R) := transform
      self.Royalty_type_code := L.Royalty_type_code;
      self.Royalty_type := L.Royalty_type;
      self.Royalty_count := L.Royalty_count + R.Royalty_count;
      self.non_Royalty_count := L.non_Royalty_count + R.non_Royalty_count;
      self.count_entity := L.count_entity + R.count_entity;
    end;

    combined_royalties := rollup(royalties_sorted, LEFT.Royalty_type_code = RIGHT.Royalty_type_code, xCombine(LEFT, RIGHT));

    RETURN combined_royalties;

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