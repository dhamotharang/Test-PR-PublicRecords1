import ln_propertyV2,ut; 

EXPORT fValidateDeeds := module

   // Set bitmap for Deeds 
export  GetBitmap( dataset(recordof(LN_PropertyV2.layout_deed_mortgage_common_model_base)	)	Inf ) := function 
	
ln_propertyV2.layouts.layout_deed_mortgage_common_model_base_scrubs  tBitmap(Inf l ) := transform 

				unsigned8	lAPNMissing								                 :=	if(l.apnt_or_pin_number = '', 				  ut.bit_set(0, 0), 0);
				unsigned8	lPropStreetAddressMissing	                 :=	if(l.property_full_street_address = '', ut.bit_set(0, 1), 0);
				unsigned8 lPropCityStateZipMissing	 			           :=	if(l.property_address_citystatezip = '',			ut.bit_set(0, 2), 0);
				unsigned8	lOwnerNameMissing			 			               :=	if(l.name1 = '' and l.name2 ='',								ut.bit_set(0, 3), 0);
        unsigned8 lRecordingDateMissing                      := if(l.recording_date = '',               ut.bit_set(0, 4), 0);
				unsigned8 ldocument_type_code                        := if(L.document_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('DOCUMENT_TYPE', L.document_type_code,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,5),0);                                    
        unsigned8 llegal_lot_code                            := if(L.legal_lot_code <>'' and LN_PropertyV2.fn_codesv3_desc('LEGAL_LOT_CODE', L.legal_lot_code,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,6),0);                         
        unsigned8 lsales_price_code                          := if(L.sales_price_code <>'' and LN_PropertyV2.fn_codesv3_desc('SALE_CODE', L.sales_price_code,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,7),0);                        
        unsigned8 lproperty_use_code                         := if(L.property_use_code <>'' and LN_PropertyV2.fn_codesv3_desc('PROPERTY_INDICATOR_CODE', L.property_use_code,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,8),0);                     
        unsigned8 lcondo_code                                := if(L.condo_code <>'' and LN_PropertyV2.fn_codesv3_desc('CONDO_CODE', L.condo_code,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,9),0);                 
        unsigned8 lfirst_td_loan_type_code                   := if(L.first_td_loan_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('MORTGAGE_LOAN_TYPE_CODE', L.first_td_loan_type_code,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,10),0);               
        unsigned8 lfirst_td_lender_type_code                 := if(L.first_td_lender_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('FIRST_TD_LENDER_TYPE_CODE', L.first_td_lender_type_code,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,11),0);              
        unsigned8 lsecond_td_lender_type_code                := if(L.second_td_lender_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('FIRST_TD_LENDER_TYPE_CODE', L.second_td_lender_type_code,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,12),0);             
      
		    buyer1_id										                         := if(l.buyer_or_borrower_ind='O', L.name1_id_code,				'');
		    buyer2_id										                         := if(l.buyer_or_borrower_ind='O', L.name2_id_code,				'');
		    buyer_vesting								                         := if(l.buyer_or_borrower_ind='O', L.vesting_code,					'');
		    borrower1_id								                         := if(l.buyer_or_borrower_ind='B', L.name1_id_code,				'');
		    borrower2_id								                         := if(l.buyer_or_borrower_ind='B', L.name2_id_code,				'');
		    borrower_vesting						                         := if(l.buyer_or_borrower_ind='B', L.vesting_code,					'');
		
			  unsigned8 lbuyer1_id                                 := if(buyer1_id <>'' and LN_PropertyV2.fn_codesv3_desc('BUYER1_ID_CODE', buyer1_id,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,13),0);             
        unsigned8 lbuyer2_id                                 := if(buyer2_id <>'' and LN_PropertyV2.fn_codesv3_desc('DOCUMENT_TYPE', buyer2_id,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,14),0);            
        unsigned8 lbuyer_vesting                             := if(buyer_vesting <>'' and LN_PropertyV2.fn_codesv3_desc('BUYER_VESTING_CODE', buyer_vesting,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,15),0);             
        unsigned8 lborrower1_id                              := if(borrower1_id <>'' and LN_PropertyV2.fn_codesv3_desc('BORROWER1_ID_CODE', borrower1_id,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,16),0);            
        unsigned8 lborrower2_id                              := if(borrower2_id <>'' and LN_PropertyV2.fn_codesv3_desc('BORROWER2_ID_CODE', borrower2_id,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,17),0);          
        unsigned8 lborrower_vesting                          := if(borrower_vesting <>'' and LN_PropertyV2.fn_codesv3_desc('BORROWER_VESTING_CODE', borrower_vesting,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,18),0);         
        unsigned8 lseller1_id_code                           := if(L.seller1_id_code <>'' and LN_PropertyV2.fn_codesv3_desc('SELLER1_ID_CODE', L.seller1_id_code,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,19),0);         
        unsigned8 lseller2_id_code                           := if(L.seller2_id_code <>'' and LN_PropertyV2.fn_codesv3_desc('SELLER2_ID_CODE', L.seller2_id_code,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,20),0);          
        unsigned8 lrecord_type                               := if(L.record_type <>'' and LN_PropertyV2.fn_codesv3_desc('RECORD_TYPE', L.record_type,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,21),0);          
        unsigned8 ltype_financing                            := if(L.type_financing <>'' and LN_PropertyV2.fn_codesv3_desc('TYPE_FINANCING', L.type_financing,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,22),0);          
        unsigned8 lrate_change_frequency                     := if(L.rate_change_frequency <>'' and LN_PropertyV2.fn_codesv3_desc('RATE_CHANGE_FREQUENCY', L.rate_change_frequency,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,23),0);         
        unsigned8 ladjustable_rate_index                     := if(L.adjustable_rate_index <>'' and LN_PropertyV2.fn_codesv3_desc('ADJUSTABLE_RATE_INDEX', L.adjustable_rate_index,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,24),0);         
        unsigned8 lfixed_step_rate_rider      			         := if(L.fixed_step_rate_rider <>'' and LN_PropertyV2.fn_codesv3_desc('FIXED_STEP_RATE_RIDER', L.fixed_step_rate_rider,'FARES_1080',self.vendor_source_flag) = '',ut.bit_set(0,25),0);
				
	
				self := l ; 																														 
  			self.RuleBitMap                      := lAPNMissing
																						 |	lPropStreetAddressMissing
																						 |	lPropCityStateZipMissing
																						 |	lOwnerNameMissing
																						 |  lRecordingDateMissing
																						 |  ldocument_type_code                                        
																						 |  llegal_lot_code                                             
																						 |  lsales_price_code                                           
																						 |  lproperty_use_code                                           
																						 |  lcondo_code                                                  
																						 |  lfirst_td_loan_type_code                                     
																						 |  lfirst_td_lender_type_code                                  
																						 |  lsecond_td_lender_type_code                                  
																						 |  lbuyer1_id                                                   
																						 |  lbuyer2_id                                                   
																					   |  lbuyer_vesting                                               
																				     |  lborrower1_id                                                
																					   |  lborrower2_id                                               
																				     |  lborrower_vesting                                           
																				     |  lseller1_id_code                                             
																				     |  lseller2_id_code                                             
																				     |  lrecord_type                                                
																			       |  ltype_financing                                              
																						 |  lrate_change_frequency                                       
																					   |  ladjustable_rate_index                                      
																					   |  lfixed_step_rate_rider ;
			

end; 

  DeedsBitmap  := project(Inf  , tBitmap( left)); 
	
	return DeedsBitmap;
	
	end; 
 
 export  GetRawCode( dataset(recordof(ln_propertyV2.layouts.layout_deed_mortgage_common_model_base_scrubs )	)	DeedsBitmap ) := function 


   LN_   := DeedsBitmap(vendor_source_flag ='O');
   Fares := DeedsBitmap(vendor_source_flag in ['F','S']);

   MaxprocessDateLN    := Max(LN_,process_date); 

   MaxProcessDateFares := Max(Fares,process_date); 

  DeedsLatestRaw   :=   LN_( process_date = MaxprocessDateLN) +  
	                       Fares( process_date = MaxProcessDateFares);
												 

 SlimDeeds           := project( DeedsLatestRaw , transform(LN_PropertyV2.Layouts.StatsLayout, 
                                                     self.vendor_source_flag            := if(left.vendor_source_flag = 'S' , 'F',left.vendor_source_flag);
																										 self.RecordsTotal                  := if(left.vendor_source_flag = 'O' , count(DeedsLatestRaw(vendor_source_flag = 'O')),count(DeedsLatestRaw(vendor_source_flag in[ 'F','S'])));
																										 self.RuleDesc                      := PropertyScrubs.Functions.fGetRuleFromBitmapDeeds(left.RuleBitMap);
                                                                   
																										 self                     := left)
																			); 
															
																			
  NormRules          		:= Normalize(SlimDeeds, length(stringlib.stringfilter(left.RuleDesc, ' ')) + 1, transform(LN_PropertyV2.Layouts.StatsLayout,
																				ParseRule := ' ' + left.RuleDesc + ' ';
																				tRuleDesc := ParseRule[stringlib.stringfind(ParseRule, ' ', counter)+1..stringlib.stringfind(ParseRule, ' ', counter+1)-1];
																				self.RuleDesc := if(trim(tRuleDesc ,left,right) = '', skip, tRuleDesc);
																				self := left)
																				);
						
	
  tAggregateRules := table(NormRules, {NormRules.process_date, NormRules.vendor_source_flag, NormRules.RuleDesc, NormRules.RecordsTotal, unsigned8 Rulecnt := count(group)}, NormRules.process_date, NormRules.vendor_source_flag, NormRules.RuleDesc, few);
  
	output(taggregateRules,named('RulesAggregateCnts'));

  MissingCodes := PropertyScrubs.fMissingCodesDeeds (DeedsLatestRaw );
	
  GetRawCodes  := sort(join (tAggregateRules, MissingCodes(count_ >10), left.RuleDesc = right.field_name and 
	                                          left.vendor_source_flag = right.source_code[1]  , 
																			            transform(LN_PropertyV2.Layouts.RawcodeStatsLayout, 
	                                                                  self:= left,
																																		self.RulePct                    := (left.rulecnt/left.RecordsTotal)*100 ; 
																																		threshld                        := propertyScrubs.Functions.Dthrshold (left.ruledesc,left.vendor_source_flag);
																																		FieldAcceptedPct                := if(threshld =0 ,self.RulePct,threshld);
																																		self.RejectWarning              := if(self.RulePct > FieldAcceptedPct ,'Y','N');
																																		self.rawCodeMissing             := right.raw_code, 
																																		self.rawCodeMissingcnt          := right.count_), 
																																		left outer
							                         ),vendor_source_flag, ruledesc,rawcodemissing); 
													 
  return GetRawCodes;

end;
end;
