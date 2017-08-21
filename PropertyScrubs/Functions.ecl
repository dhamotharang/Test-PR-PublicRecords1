/*2013-12-17T02:40:29Z (ayeesha_prod kayttala)

*/
import lib_stringlib, ut, mdr;

EXPORT Functions := module

//Assessor 

export apn                           								:= 'APNMissing'; 
export propertyStreet                								:= 'PropertyStreetMissing' ;
export propertyCityStateZip          								:= 'PropertyCityStateMissing' ;
export AssesseName                   								:= 'AsesseenameMissing' ;
export TaxYear                       								:= 'TaxYearMissing' ; 
export RecordingDate                 								:= 'RecordingDateMissing'; 
export STANDARDIZED_LAND_USE_CODE    								:= 'LAND_USE';
export assessee_ownership_rights_code               := 'OWNER_OWNERSHIP_RIGHTS_CODE';      
export assessee_relationship_code                   := 'OWNER_RELATIONSHIP_CODE'; 
export assessee_name_type_code                      := 'ASSESSEE_NAME_TYPE_CODE'; 
export second_assessee_name_type_code               := 'SECOND_ASSESSEE_NAME_TYPE_CODE'; 
export mail_care_of_name_type_code                  := 'MAIL_CARE_OF_NAME_TYPE_CODE'; 
export record_type_code                             := 'RECORD_TYPE_CODE'; 
export legal_lot_code                               := 'LEGAL_LOT_CODE'; 
export ownership_type_code                          := 'OWNERSHIP_TYPE_CODE'; 
export new_record_type_code                         := 'NEW_RECORD_TYPE_CODE'; 
export sales_price_code                             := 'SALE_CODE'; 
export prior_sales_price_code 									    := 'PRIOR_SALES_PRICE_CODE';   
export mortgage_loan_type_code 								      := 'MORTGAGE_LOAN_TYPE_CODE';
export mortgage_lender_type_code                    := 'MORTGAGE_LENDER_TYPE_CODE';  
export tax_exemption1_code                          := 'TAX_EXEMPTION1_CODE';  
export tax_exemption2_code                          := 'TAX_EXEMPTION2_CODE';
export tax_exemption3_code                          := 'TAX_EXEMPTION3_CODE';
export tax_exemption4_code                          := 'TAX_EXEMPTION4_CODE';
export no_of_stories                                := 'STORIES_CODE'; 
export garage_type_code                             := 'GARAGE';   
export pool_code                                    := 'POOL_CODE';
export exterior_walls_code                          := 'EXTERIOR_WALLS';
export roof_type_code                               := 'ROOF_TYPE';
export heating_code                                 := 'HEATING';  
export heating_fuel_type_code                       := 'FUEL';  
export air_conditioning_type_code                   := 'AIR_CONDITIONING_TYPE_CODE';  
export building_class_code                          := 'BUILDING_CLASS_CODE'; 
export site_influence1_code                         := 'LOCATION_INFLUENCE'; 
export amenities1_code                              := 'AMENITIES1_CODE';  
export amenities2_code                              := 'AMENITIES2_CODE';  
export amenities3_code                              := 'AMENITIES3_CODE'; 
export amenities4_code                              := 'AMENITIES4_CODE'; 
export other_buildings1_code                        := 'BLDG_IMPV_CODE';   
export fireplace_indicator                          := 'FIREPLACE_INDICATOR';
export property_address_code                        := 'PROPERTY_ADDRESS_CODE';
export floor_cover_code                             := 'FLOOR_COVER';  
export building_quality_code                        := 'QUALITY';  
//export Assessed_Value_Year                          := 'AssessedValueYearMissing';

export Rule_bitmap_code(string Rulebit = '')  := map(
								
													Rulebit = apn  					                                                  => ut.bit_set(0,0),
													Rulebit = propertyStreet						                                      => ut.bit_set(0,1),
													Rulebit = propertyCityStateZip		                                        => ut.bit_set(0,2),
													Rulebit = AssesseName						                                          => ut.bit_set(0,3),
													Rulebit = TaxYear					                                                => ut.bit_set(0,4),
													Rulebit = RecordingDate                                                   => ut.bit_set(0,5),
													Rulebit = STANDARDIZED_LAND_USE_CODE                                      => ut.bit_set(0,6),
													Rulebit = assessee_ownership_rights_code                                  => ut.bit_set(0,7),        
                          Rulebit =  assessee_relationship_code                                     => ut.bit_set(0,8),
                          Rulebit = assessee_name_type_code                                         => ut.bit_set(0,9),
                          Rulebit =  second_assessee_name_type_code                                 => ut.bit_set(0,10),
                          Rulebit = mail_care_of_name_type_code                                     => ut.bit_set(0,11),
                          Rulebit = record_type_code                                                => ut.bit_set(0,12),
                          Rulebit = legal_lot_code                                                  => ut.bit_set(0,13),
                          Rulebit = ownership_type_code                                             => ut.bit_set(0,14), 
                          Rulebit = new_record_type_code                                            => ut.bit_set(0,15),
                          Rulebit = sales_price_code                                                => ut.bit_set(0,16),
                          Rulebit = prior_sales_price_code 									                        => ut.bit_set(0,17), 
                          Rulebit = mortgage_loan_type_code 								                        => ut.bit_set(0,18),
                          Rulebit = mortgage_lender_type_code                                       => ut.bit_set(0,19),
                          Rulebit = tax_exemption1_code                                             => ut.bit_set(0,20),  
                          Rulebit = tax_exemption2_code                                             => ut.bit_set(0,21),
                          Rulebit = tax_exemption3_code                                             => ut.bit_set(0,22),
                          Rulebit = tax_exemption4_code                                             => ut.bit_set(0,23),
                          Rulebit = no_of_stories                                                   => ut.bit_set(0,24),
                          Rulebit = garage_type_code                                                => ut.bit_set(0,25),
                          Rulebit = pool_code                                                       => ut.bit_set(0,26),
                          Rulebit = exterior_walls_code                                             => ut.bit_set(0,27),
                          Rulebit = roof_type_code                                                  => ut.bit_set(0,28),
                          Rulebit = heating_code                                                    => ut.bit_set(0,29),
                          Rulebit = heating_fuel_type_code                                          => ut.bit_set(0,30),
                          Rulebit = air_conditioning_type_code                                      => ut.bit_set(0,31),
                          Rulebit = building_class_code                                             => ut.bit_set(0,32),
                          Rulebit = site_influence1_code                                            => ut.bit_set(0,33), 
                          Rulebit = amenities1_code                                                 => ut.bit_set(0,34),
                          Rulebit = amenities2_code                                                 => ut.bit_set(0,35), 
                          Rulebit = amenities3_code                                                 => ut.bit_set(0,36),
                          Rulebit = amenities4_code                                                 => ut.bit_set(0,37), 
                          Rulebit = other_buildings1_code                                           => ut.bit_set(0,38),
                          Rulebit = fireplace_indicator                                             => ut.bit_set(0,39),
                          Rulebit = property_address_code                                           => ut.bit_set(0,40),
                          Rulebit = floor_cover_code                                                => ut.bit_set(0,41), 
                          Rulebit = building_quality_code                                           => ut.bit_set(0,42),
													//Rulebit = Assessed_Value_Year                                             => ut.bit_set(0,43),
                        	0);

export	string	fGetRuleFromBitmap(unsigned bitmap_src) := function

		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_src)	:=	pValue & bitmap_src = bitmap_src;
		
		string		translated_value		:=	if(bitmap_src = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(apn					 )),	' ' + apn						,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(propertyStreet )),' ' + propertyStreet						,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(propertyCityStateZip)),	' ' + propertyCityStateZip,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(AssesseName)),			' ' +AssesseName,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(TaxYear						)),			' ' + TaxYear					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(RecordingDate						)),			' ' + RecordingDate					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(STANDARDIZED_LAND_USE_CODE						)),			' ' + STANDARDIZED_LAND_USE_CODE					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(assessee_ownership_rights_code						)),			' ' + assessee_ownership_rights_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(assessee_relationship_code						)),			' ' + assessee_relationship_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(assessee_name_type_code						)),			' ' + assessee_name_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(second_assessee_name_type_code						)),			' ' + second_assessee_name_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(mail_care_of_name_type_code						)),			' ' + mail_care_of_name_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(record_type_code						)),			' ' + record_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(legal_lot_code						)),			' ' + legal_lot_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(ownership_type_code 						)),			' ' + ownership_type_code 					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(new_record_type_code						)),			' ' + new_record_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(sales_price_code						)),			' ' + sales_price_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(prior_sales_price_code 						)),			' ' + prior_sales_price_code 					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(mortgage_loan_type_code 						)),			' ' + mortgage_loan_type_code 					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(mortgage_lender_type_code						)),			' ' + mortgage_lender_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(tax_exemption1_code						)),			' ' + tax_exemption1_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(tax_exemption2_code						)),			' ' + tax_exemption2_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(tax_exemption3_code						)),			' ' + tax_exemption3_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(tax_exemption4_code						)),			' ' + tax_exemption4_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(no_of_stories						)),			' ' + no_of_stories					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(garage_type_code						)),			' ' + garage_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(pool_code						)),			' ' + pool_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(exterior_walls_code 						)),			' ' + exterior_walls_code 					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(roof_type_code						)),			' ' + roof_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(heating_code						)),			' ' + heating_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(heating_fuel_type_code						)),			' ' + heating_fuel_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(air_conditioning_type_code						)),			' ' + air_conditioning_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(building_class_code						)),			' ' + building_class_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(site_influence1_code						)),			' ' + site_influence1_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(amenities1_code						)),			' ' + amenities1_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(amenities2_code						)),			' ' + amenities2_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(amenities3_code						)),			' ' + amenities3_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(amenities4_code						)),			' ' + amenities4_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(other_buildings1_code						)),			' ' + other_buildings1_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(fireplace_indicator						)),			' ' + fireplace_indicator					,'')
									  +	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(property_address_code						)),			' ' + property_address_code					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(floor_cover_code 						)),			' ' + floor_cover_code 					,'')
										+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(building_quality_code 						)),			' ' + building_quality_code 					,'')
                    //+	   if(fFlagIsOn(bitmap_src, Rule_bitmap_code(Assessed_Value_Year 						)),			' ' + Assessed_Value_Year 					,'')
									
										);
	return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
end;	

export thrshold( string ruleDesc ='' , string vendor_source_flag ) := Map( 

                          vendor_source_flag='O' and ruleDesc = 'APNMissing' => 5 ,
													vendor_source_flag='O' and ruleDesc = 'AsesseenameMissing' => 5 ,
													vendor_source_flag='F' and ruleDesc = 'APNMissing' => 5 ,
													vendor_source_flag='F' and ruleDesc = 'AsesseenameMissing' => 5 ,
													/*vendor_source_flag='O' and ruleDesc = 'PropertyCityStateMissing' => 5 ,
													vendor_source_flag='O' and ruleDesc = 'AssessedValueYearMissing' => 5 ,
													vendor_source_flag='O' and ruleDesc = 'TaxYearMissing' => 5 ,
													vendor_source_flag='O' and ruleDesc = 'RecordingDateMissing' => 5 ,
													vendor_source_flag='O' and ruleDesc = 'PropertyStreetMissing' => 5 ,
                          vendor_source_flag='F' and ruleDesc = 'PropertyCityStateMissing' => 5 ,
													vendor_source_flag='F' and ruleDesc = 'AssessedValueYearMissing' => 5 ,
													vendor_source_flag='F' and ruleDesc = 'TaxYearMissing' => 8 ,
													vendor_source_flag='F' and ruleDesc = 'RecordingDateMissing' => 52 ,
													vendor_source_flag='F' and ruleDesc = 'PropertyStreetMissing' => 16 ,
													 */
													 0); 


// deeds&Mortgages 


export dapn                           								              := 'APNMissing'; 
export dpropertyStreet                								              := 'PropertyStreetMissing' ;
export dpropertyCityStateZip          								              := 'PropertyCityStateMissing' ;
export downerName                   								                := 'OwnernameMissing' ;
export dRecordingDate                 								              := 'RecordingDateMissing'; 
export ddocument_type_code                                          := 'DOCUMENT_TYPE' ;
export dlegal_lot_code                                              := 'LEGAL_LOT_CODE' ;
export dsales_price_code                                            := 'SALE_CODE';
export dproperty_use_code                                           := 'PROPERTY_INDICATOR_CODE';
export dcondo_code                                                  := 'CONDO_CODE';
export dfirst_td_loan_type_code                                     := 'MORTGAGE_LOAN_TYPE_CODE';
export dfirst_td_lender_type_code                                   := 'FIRST_TD_LENDER_TYPE_CODE';
export dsecond_td_lender_type_code                                  := 'FIRST_TD_LENDER_TYPE_CODE';
export dbuyer1_id                                                   := 'BUYER1_ID_CODE';
export dbuyer2_id                                                   := 'BUYER2_ID_CODE';
export dbuyer_vesting                                               := 'BUYER_VESTING_CODE';
export dborrower1_id                                                := 'BORROWER1_ID_CODE';
export dborrower2_id                                                := 'BORROWER2_ID_CODE';
export dborrower_vesting                                            := 'BORROWER_VESTING_CODE';
export dseller1_id_code                                             := 'SELLER1_ID_CODE';
export dseller2_id_code                                             := 'SELLER2_ID_CODE';
export drecord_type                                                 := 'RECORD_TYPE';
export dtype_financing                                              := 'TYPE_FINANCING';
export drate_change_frequency                                       := 'RATE_CHANGE_FREQUENCY';
export dadjustable_rate_index                                       := 'ADJUSTABLE_RATE_INDEX';
export dfixed_step_rate_rider                                       := 'FIXED_STEP_RATE_RIDER';


export DRule_bitmap_code(string Rulebit = '')  := map(
								
				Rulebit = dapn                                  => ut.bit_set(0,0),							         
				Rulebit = dpropertyStreet                       => ut.bit_set(0,1),							             
				Rulebit = dpropertyCityStateZip                 => ut.bit_set(0,2),							             
				Rulebit = downerName                   	        => ut.bit_set(0,3),						                
				Rulebit = dRecordingDate                 	      => ut.bit_set(0,4),							              
				Rulebit = ddocument_type_code                   => ut.bit_set(0,5),                       
				Rulebit = dlegal_lot_code                       => ut.bit_set(0,6),                     
				Rulebit = dsales_price_code                     => ut.bit_set(0,7),                       
				Rulebit = dproperty_use_code                    => ut.bit_set(0,8),                     
				Rulebit = dcondo_code                           => ut.bit_set(0,9),                       
				Rulebit = dfirst_td_loan_type_code              => ut.bit_set(0,10),                      
				Rulebit = dfirst_td_lender_type_code            => ut.bit_set(0,11),                       
				Rulebit = dsecond_td_lender_type_code           => ut.bit_set(0,12),                     
				Rulebit = dbuyer1_id                            => ut.bit_set(0,13),                      
				Rulebit = dbuyer2_id                            => ut.bit_set(0,14),                       
				Rulebit = dbuyer_vesting                        => ut.bit_set(0,15),                       
				Rulebit = dborrower1_id                         => ut.bit_set(0,16),                      
				Rulebit = dborrower2_id                         => ut.bit_set(0,17),                       
				Rulebit = dborrower_vesting                     => ut.bit_set(0,18),                       
				Rulebit = dseller1_id_code                      => ut.bit_set(0,19),                       
				Rulebit = dseller2_id_code                      => ut.bit_set(0,20),                       
				Rulebit = drecord_type                          => ut.bit_set(0,21),                      
				Rulebit = dtype_financing                       => ut.bit_set(0,22),                       
				Rulebit = drate_change_frequency                => ut.bit_set(0,23),                      
				Rulebit = dadjustable_rate_index                => ut.bit_set(0,24),                       
				Rulebit = dfixed_step_rate_rider                => ut.bit_set(0,25),  
   
                        	0);

export	string	fGetRuleFromBitmapDeeds(unsigned bitmap_src) := function

		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_src)	:=	pValue & bitmap_src = bitmap_src;
		
		string		translated_value		:=	if(bitmap_src = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dapn					 )),	' ' + dapn						,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dpropertyStreet )),' ' + dpropertyStreet						,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dpropertyCityStateZip)),	' ' + dpropertyCityStateZip,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(downerName)),			' ' +downerName,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dRecordingDate						)),			' ' + dRecordingDate					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(ddocument_type_code						)),			' ' + ddocument_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dlegal_lot_code						)),			' ' + dlegal_lot_code					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dsales_price_code						)),			' ' + dsales_price_code					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dproperty_use_code						)),			' ' + dproperty_use_code					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dcondo_code						)),			' ' + dcondo_code					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dfirst_td_loan_type_code						)),			' ' + dfirst_td_loan_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dsecond_td_lender_type_code						)),			' ' + dsecond_td_lender_type_code					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dbuyer1_id						)),			' ' + dbuyer1_id					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dbuyer2_id 						)),			' ' + dbuyer2_id 					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dbuyer_vesting						)),			' ' + dbuyer_vesting					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dborrower1_id						)),			' ' + dborrower1_id					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dborrower2_id 						)),			' ' + dborrower2_id 					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dborrower_vesting 						)),			' ' + dborrower_vesting 					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dseller1_id_code						)),			' ' + dseller1_id_code					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dseller2_id_code						)),			' ' + dseller2_id_code					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(drecord_type						)),			' ' + drecord_type					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dtype_financing						)),			' ' + dtype_financing					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(drate_change_frequency						)),			' ' + drate_change_frequency					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dadjustable_rate_index						)),			' ' + dadjustable_rate_index					,'')
										+	   if(fFlagIsOn(bitmap_src, DRule_bitmap_code(dfixed_step_rate_rider						)),			' ' + dfixed_step_rate_rider					,'')
																		
										);
	return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
end;	


export Dthrshold( string ruleDesc ='' , string vendor_source_flag ) := Map( 

                          vendor_source_flag='O' and ruleDesc = 'APNMissing' => 25 ,
													vendor_source_flag='O' and ruleDesc = 'OwnernameMissing' => 5 ,
													vendor_source_flag='F' and ruleDesc = 'APNMissing' => 5 ,
													vendor_source_flag='F' and ruleDesc = 'OwnernameMissing' => 5 ,
													/*vendor_source_flag='O' and ruleDesc = 'PropertyCityStateMissing' => 5 ,
													vendor_source_flag='O' and ruleDesc = 'AssessedValueYearMissing' => 5 ,
													vendor_source_flag='O' and ruleDesc = 'TaxYearMissing' => 5 ,
													vendor_source_flag='O' and ruleDesc = 'RecordingDateMissing' => 5 ,
													vendor_source_flag='O' and ruleDesc = 'PropertyStreetMissing' => 5 ,
                          vendor_source_flag='F' and ruleDesc = 'PropertyCityStateMissing' => 5 ,
													vendor_source_flag='F' and ruleDesc = 'AssessedValueYearMissing' => 5 ,
													vendor_source_flag='F' and ruleDesc = 'TaxYearMissing' => 8 ,
													vendor_source_flag='F' and ruleDesc = 'RecordingDateMissing' => 52 ,
													vendor_source_flag='F' and ruleDesc = 'PropertyStreetMissing' => 16 ,
													 */
													 0); 
													 
end; 

