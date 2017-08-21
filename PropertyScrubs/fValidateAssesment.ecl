import ln_propertyV2,ut; 


EXPORT fValidateAssesment := module

   // Set bitmap for Assessor 
export  GetBitmap( dataset(recordof(LN_PropertyV2.Layout_Property_Common_Model_BASE)	)	Inf ) := function 
	
ln_propertyV2.layouts.layout_property_common_model_base_scrubs  tscrub(Inf l ) := transform 

				unsigned8	lAPNMissing								                 :=	if(l.apna_or_pin_number = '', 				  ut.bit_set(0, 0), 0);
				unsigned8	lPropStreetAddressMissing	                 :=	if(l.property_full_street_address = '', ut.bit_set(0, 1), 0);
				unsigned8 lPropCityStateZipMissing	 			           :=	if(l.property_city_state_zip = '',			ut.bit_set(0, 2), 0);
				unsigned8	lAssesseeNameMissing			 			           :=	if(l.assessee_name = '',								ut.bit_set(0, 3), 0);
				unsigned8	lTaxYearMissing						 			           :=	if(l.tax_year = '',											ut.bit_set(0, 4), 0);
        unsigned8 lRecordingDateMissing                      := if(l.recording_date = '',               ut.bit_set(0, 5), 0);
     		unsigned8 lSTANDARDIZED_LAND_USE_CODEMissing         := if(L.standardized_land_use_code <>'' and LN_PropertyV2.fn_codesv3_desc('LAND_USE', L.standardized_land_use_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,6),0);  
				unsigned8 lassessee_ownership_rights_code            := if(L.assessee_ownership_rights_code <>'' and LN_PropertyV2.fn_codesv3_desc('OWNER_OWNERSHIP_RIGHTS_CODE', L.assessee_ownership_rights_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,7),0);  
				unsigned8 lassessee_relationship_code                := if(L.assessee_relationship_code <>'' and LN_PropertyV2.fn_codesv3_desc('OWNER_RELATIONSHIP_CODE', L.assessee_relationship_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,8),0);  
				unsigned8 lassessee_name_type_code                   := if(L.assessee_name_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('ASSESSEE_NAME_TYPE_CODE', L.assessee_name_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,9),0);  
				unsigned8 lsecond_assessee_name_type_code            := if(L.second_assessee_name_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('SECOND_ASSESSEE_NAME_TYPE_CODE', L.second_assessee_name_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,10),0);  
				unsigned8 lmail_care_of_name_type_code               := if(L.mail_care_of_name_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('MAIL_CARE_OF_NAME_TYPE_CODE', L.mail_care_of_name_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,11),0);  
				unsigned8 lrecord_type_code                          := if(L.record_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('RECORD_TYPE_CODE', L.record_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,12),0);  
				unsigned8 llegal_lot_code                            := if(L.legal_lot_code <>'' and LN_PropertyV2.fn_codesv3_desc('LEGAL_LOT_CODE', L.legal_lot_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,13),0);  
				unsigned8 lownership_type_code                       := if(L.ownership_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('OWNERSHIP_TYPE_CODE', L.ownership_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,14),0);  
				unsigned8 lnew_record_type_code                      := if(L.new_record_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('NEW_RECORD_TYPE_CODE', L.new_record_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,15),0);  
				unsigned8 lsales_price_code                          := if(L.sales_price_code <>'' and LN_PropertyV2.fn_codesv3_desc('SALE_CODE', L.sales_price_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,16),0);  
				unsigned8 lprior_sales_price_code 									 := if(L.prior_sales_price_code <>'' and LN_PropertyV2.fn_codesv3_desc('PRIOR_SALES_PRICE_CODE', L.prior_sales_price_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,17),0);  
				unsigned8 lmortgage_loan_type_code 								   := if(L.mortgage_loan_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('MORTGAGE_LOAN_TYPE_CODE', L.mortgage_loan_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,18),0);  
				unsigned8 lmortgage_lender_type_code                 := if(L.mortgage_lender_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('MORTGAGE_LENDER_TYPE_CODE', L.mortgage_lender_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,19),0);  
				unsigned8 ltax_exemption1_code                       := if(L.tax_exemption1_code <>'' and LN_PropertyV2.fn_codesv3_desc('TAX_EXEMPTION1_CODE', L.tax_exemption1_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,20),0);  
				unsigned8 ltax_exemption2_code                       := if(L.tax_exemption2_code <>'' and LN_PropertyV2.fn_codesv3_desc('TAX_EXEMPTION2_CODE', L.tax_exemption2_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,21),0);  
				unsigned8 ltax_exemption3_code                       := if(L.tax_exemption3_code <>'' and LN_PropertyV2.fn_codesv3_desc('TAX_EXEMPTION3_CODE', L.tax_exemption3_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,22),0);  
				unsigned8 ltax_exemption4_code                       := if(L.tax_exemption4_code <>'' and LN_PropertyV2.fn_codesv3_desc('TAX_EXEMPTION4_CODE', L.tax_exemption4_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,23),0);  
				unsigned8 lno_of_stories                             := if(L.no_of_stories <>'' and LN_PropertyV2.fn_codesv3_desc('STORIES_CODE', L.no_of_stories,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,24),0);  
				unsigned8 lgarage_type_code                          := if(L.garage_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('GARAGE', L.garage_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,25),0);  
				unsigned8 lpool_code                                 := if(L.pool_code <>'' and LN_PropertyV2.fn_codesv3_desc('POOL_CODE', L.pool_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,26),0);  
				unsigned8 lexterior_walls_code                       := if(L.exterior_walls_code <>'' and LN_PropertyV2.fn_codesv3_desc('EXTERIOR_WALLS', L.exterior_walls_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,27),0);  
				unsigned8 lroof_type_code                            := if(L.roof_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('ROOF_TYPE', L.roof_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,28),0);  
				unsigned8 lheating_code                              := if(L.heating_code <>'' and LN_PropertyV2.fn_codesv3_desc('HEATING', L.heating_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,29),0);  
				unsigned8 lheating_fuel_type_code                    := if(L.heating_fuel_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('FUEL', L.heating_fuel_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,30),0);  
				unsigned8 lair_conditioning_type_code                := if(L.air_conditioning_type_code <>'' and LN_PropertyV2.fn_codesv3_desc('AIR_CONDITIONING_TYPE_CODE', L.air_conditioning_type_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,31),0);  
				unsigned8 lbuilding_class_code                       := if(L.building_class_code <>'' and LN_PropertyV2.fn_codesv3_desc('BUILDING_CLASS_CODE', L.building_class_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,32),0);  
				unsigned8 lsite_influence1_code                      := if(L.site_influence1_code <>'' and LN_PropertyV2.fn_codesv3_desc('LOCATION_INFLUENCE', L.site_influence1_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,33),0);  
				unsigned8 lamenities1_code                           := if(L.amenities1_code <>'' and LN_PropertyV2.fn_codesv3_desc('AMENITIES1_CODE', L.amenities1_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,34),0);  
				unsigned8 lamenities2_code                           := if(L.amenities2_code <>'' and LN_PropertyV2.fn_codesv3_desc('AMENITIES2_CODE', L.amenities2_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,35),0);  
				unsigned8 lamenities3_code                           := if(L.amenities3_code <>'' and LN_PropertyV2.fn_codesv3_desc('AMENITIES3_CODE', L.amenities3_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,36),0);  
				unsigned8 lamenities4_code                           := if(L.amenities4_code <>'' and LN_PropertyV2.fn_codesv3_desc('AMENITIES4_CODE', L.amenities4_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,37),0);  
				unsigned8 lother_buildings1_code                     := if(L.other_buildings1_code <>'' and LN_PropertyV2.fn_codesv3_desc('BLDG_IMPV_CODE', L.other_buildings1_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,38),0);  
				unsigned8 lfireplace_indicator                       := if(L.fireplace_indicator <>'' and LN_PropertyV2.fn_codesv3_desc('FIREPLACE_INDICATOR', L.fireplace_indicator,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,39),0);  
			  unsigned8 lproperty_address_code                     := if(L.property_address_code <>'' and LN_PropertyV2.fn_codesv3_desc('PROPERTY_ADDRESS_CODE', L.property_address_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,40),0);  
				unsigned8 lfloor_cover_code                          := if(L.floor_cover_code <>'' and LN_PropertyV2.fn_codesv3_desc('FLOOR_COVER', L.floor_cover_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,41),0);  
				unsigned8 lbuilding_quality_code                     := if(L.building_quality_code <>'' and LN_PropertyV2.fn_codesv3_desc('QUALITY', L.building_quality_code,'FARES_2580',self.vendor_source_flag) = '',ut.bit_set(0,42),0);  
        unsigned8 lAssessedValueYearMissing                  := if(l.assessed_value_year = '', ut.bit_set(0,43),0);

		    self := l ; 
  			self.RuleBitMap                      := lAPNMissing
																						 |	lPropStreetAddressMissing
																						 |	lPropCityStateZipMissing
																						 |	lAssesseeNameMissing
																						 |	lTaxYearMissing
																						 |  lRecordingDateMissing
																						 |  lSTANDARDIZED_LAND_USE_CODEMissing
																						 |  lassessee_ownership_rights_code          
																						 |  lassessee_relationship_code               
																						 | 	lassessee_name_type_code                  
																						 |  lsecond_assessee_name_type_code           
				                                     |  lmail_care_of_name_type_code             
				                                     |  lrecord_type_code                         
				                                     |  llegal_lot_code                           
				                                     |  lownership_type_code                       
				                                     |  lnew_record_type_code                     
				                                     |  lsales_price_code                         
				                                     |  lprior_sales_price_code 									   
				                                     |  lmortgage_loan_type_code 								 
				                                     |  lmortgage_lender_type_code                
																						 |  ltax_exemption1_code                        
				                                     |  ltax_exemption2_code                      
				                                     |  ltax_exemption3_code                      
				                                     |  ltax_exemption4_code                     
																						 |  lno_of_stories                            
				                                     |  lgarage_type_code                         
				                                     |  lpool_code                                
				                                     |  lexterior_walls_code                      
				                                     |  lroof_type_code                          
				                                     |  lheating_code                             
				                                     |  lheating_fuel_type_code                   
				                                     |  lair_conditioning_type_code               
				                                     |  lbuilding_class_code                      
				                                     |  lsite_influence1_code                      
				                                     |  lamenities1_code                          
				                                     |  lamenities2_code                          
				                                     |  lamenities3_code                         
				                                     |  lamenities4_code                          
				                                     |  lother_buildings1_code                    
				                                     |  lfireplace_indicator 
																						 |  lproperty_address_code                  
				                                     |  lfloor_cover_code                         
				                                     |  lbuilding_quality_code ; 
																						// |  lAssessedValueYearMissing;
			

end; 

  AssessorBitmap  := project(Inf  , tscrub( left)); 
	
	return AssessorBitmap;
	
	end; 
 
 export  GetRawCode( dataset(recordof(ln_propertyV2.layouts.layout_property_common_model_base_scrubs)	)	AssessorBitmap ) := function 


   LN_   := AssessorBitmap(vendor_source_flag ='O');
   Fares := AssessorBitmap(vendor_source_flag in ['F','S']);

   MaxprocessDateLN    := Max(LN_,process_date); 

   MaxProcessDateFares := Max(Fares,process_date); 

  AssessorLatestRaw   := LN_( process_date = MaxprocessDateLN) +  
	                       Fares(process_date = MaxProcessDateFares);

 SlimAssessor           := project( AssessorLatestRaw , transform(LN_PropertyV2.Layouts.StatsLayout, 
                                                     self.vendor_source_flag            := if(left.vendor_source_flag = 'S' , 'F',left.vendor_source_flag);
																										 self.RecordsTotal                  := if(left.vendor_source_flag = 'O' , count(AssessorLatestRaw(vendor_source_flag = 'O')),count(AssessorLatestRaw(vendor_source_flag in[ 'F','S'])));
																										 self.RuleDesc                      := PropertyScrubs.Functions.fGetRuleFromBitmap(left.RuleBitMap);
                                                                   
																										 self                     := left)
																			); 
															
																			
  NormRules          		:= Normalize(SlimAssessor, length(stringlib.stringfilter(left.RuleDesc, ' ')) + 1, transform(LN_PropertyV2.Layouts.StatsLayout,
																				ParseRule := ' ' + left.RuleDesc + ' ';
																				tRuleDesc := ParseRule[stringlib.stringfind(ParseRule, ' ', counter)+1..stringlib.stringfind(ParseRule, ' ', counter+1)-1];
																				self.RuleDesc := if(trim(tRuleDesc ,left,right) = '', skip, tRuleDesc);
																				self := left)
																				);
						
	
  tAggregateRules := table(NormRules, {NormRules.process_date, NormRules.vendor_source_flag, NormRules.RuleDesc, NormRules.RecordsTotal, unsigned8 Rulecnt := count(group)}, NormRules.process_date, NormRules.vendor_source_flag, NormRules.RuleDesc, few);
  
	output(taggregateRules);

  MissingCodes := PropertyScrubs.fMissingCodes (AssessorLatestRaw );
	
  GetRawCodes  := sort(join (tAggregateRules, MissingCodes(count_ >10), left.RuleDesc = right.field_name and 
	                                          left.vendor_source_flag = right.source_code[1]  , 
																			            transform(LN_PropertyV2.Layouts.RawcodeStatsLayout, 
	                                                                  self:= left,
																																		self.RulePct                    := (left.rulecnt/left.RecordsTotal)*100 ; 
																																		threshld                        := propertyScrubs.Functions.thrshold (left.ruledesc,left.vendor_source_flag);
																																		FieldAcceptedPct                := if(threshld =0 ,self.RulePct,threshld);
																																		self.RejectWarning              := if(self.RulePct > FieldAcceptedPct ,'Y','N');
																																		self.rawCodeMissing             := right.raw_code, 
																																		self.rawCodeMissingcnt          := right.count_), 
																																		left outer
							                         ),vendor_source_flag, ruledesc,rawcodemissing); 
													 
  return GetRawCodes;

end;
end;
