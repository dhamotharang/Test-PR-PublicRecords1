import	Address,AID,AID_Build,Codes,LN_PropertyV2,ut;

//JIRA DF-21659 Bad Square Footage Data Correction - begin
dTaxOrig	:=	distribute(LN_PropertyV2.File_Assessment,hash32(ln_fares_id));
layoutTaxLayout := ln_propertyv2.layout_property_common_model_base;



//blank out building_area for the records that match criteria
layoutTaxLayout	tBlankBuildingArea(dTaxOrig le)	:= 
transform
	self.building_area := if(trim(le.building_area) <> '' 	and (trim(le.sales_price)=trim(le.building_area) or trim(le.prior_sales_price)=trim(le.building_area)),'',le.building_area);
	self.building_area1 := if(trim(le.building_area1) <> '' 	and (trim(le.sales_price)=trim(le.building_area1) or trim(le.prior_sales_price)=trim(le.building_area1)),'',le.building_area1);
	self.building_area2 := if(trim(le.building_area2) <> '' 	and (trim(le.sales_price)=trim(le.building_area2) or trim(le.prior_sales_price)=trim(le.building_area2)),'',le.building_area2);
	self.building_area3 := if(trim(le.building_area3) <> '' 	and (trim(le.sales_price)=trim(le.building_area3) or trim(le.prior_sales_price)=trim(le.building_area3)),'',le.building_area3);
	self.building_area4 := if(trim(le.building_area4) <> '' 	and (trim(le.sales_price)=trim(le.building_area4) or trim(le.prior_sales_price)=trim(le.building_area4)),'',le.building_area4);
	self.building_area5 := if(trim(le.building_area5) <> '' 	and (trim(le.sales_price)=trim(le.building_area5) or trim(le.prior_sales_price)=trim(le.building_area5)),'',le.building_area5);
	self.building_area6 := if(trim(le.building_area6) <> '' 	and (trim(le.sales_price)=trim(le.building_area6) or trim(le.prior_sales_price)=trim(le.building_area6)),'',le.building_area6);
	self.building_area7 := if(trim(le.building_area7) <> '' 	and (trim(le.sales_price)=trim(le.building_area7) or trim(le.prior_sales_price)=trim(le.building_area7)),'',le.building_area7);
	self		:=	le;
end;

dTaxBadSF := project(dTaxOrig(process_date < '20180329' //only want to update old records that have been verified as incorrect
																														and vendor_source_flag = 'F' 
																														and state_code = 'NJ'								
																														and trim(county_name) in (['UNION','HUDSON'])
																														and(
																																			(trim(building_area) <> '' 	and (trim(sales_price)=trim(building_area) or trim(prior_sales_price)=trim(building_area)))
																																			or
																																			(trim(building_area1) <> '' and (trim(sales_price)=trim(building_area1) or trim(prior_sales_price)=trim(building_area1)))
																																			or
																																			(trim(building_area2) <> '' and (trim(sales_price)=trim(building_area2) or trim(prior_sales_price)=trim(building_area2)))
																																			or
																																			(trim(building_area3) <> '' and (trim(sales_price)=trim(building_area3) or trim(prior_sales_price)=trim(building_area3)))
																																			or
																																			(trim(building_area4) <> '' and (trim(sales_price)=trim(building_area4) or trim(prior_sales_price)=trim(building_area4)))
																																				or
																																			(trim(building_area5) <> '' and (trim(sales_price)=trim(building_area5) or trim(prior_sales_price)=trim(building_area5)))
																																			or
																																			(trim(building_area6) <> '' and (trim(sales_price)=trim(building_area6) or trim(prior_sales_price)=trim(building_area6)))
																																			or
																																			(trim(building_area7) <> '' and (trim(sales_price)=trim(building_area7) or trim(prior_sales_price)=trim(building_area7)))
																																	)
																														)
																						,tBlankBuildingArea(left), local);
	
dTaxGoodSF 	:= join(dTaxOrig, dTaxBadSF, LEFT.ln_fares_id = RIGHT.ln_fares_id, LOCAL, LEFT ONLY);

dTax := dTaxBadSF + dTaxGoodSF;

//blank out fares_living_area_square_feet for records that match criteria
dAddlFaresTaxOrig		:=	distribute(Ln_PropertyV2.File_addl_Fares_tax,hash32(ln_fares_id));
layoutAddlFaresTax := LN_PropertyV2.layout_addl_fares_tax;

layoutCombined := RECORD
layoutTaxLayout;
layoutAddlFaresTax - ln_fares_id;
END;

layoutCombined	tCombine(dTaxOrig	le,dAddlFaresTaxOrig	ri)	:=
transform
	self := le;
	self	:=	ri;
end;

dCombined	:=	join(dTaxOrig,
										dAddlFaresTaxOrig,
										left.ln_fares_id	=	right.ln_fares_id,
										tCombine(left,right),
										inner,
										local
									);

dAddlFaresTaxBadSF := project(dCombined(process_date < '20180329' //only want to update old records that have been verified as incorrect
																														and vendor_source_flag = 'F' 
																														and length(trim(fares_living_square_feet)) > 0 
																														and state_code = 'NJ'								
																														and trim(county_name) in (['UNION','HUDSON'])
																														and(trim(sales_price)=trim(fares_living_square_feet)or trim(prior_sales_price)=trim(fares_living_square_feet)))
																						,TRANSFORM(layoutAddlFaresTax,	SELF.fares_living_square_feet := '';	SELF := LEFT;));

dAddlFaresTaxGoodSF 	:= join(dAddlFaresTaxOrig, dAddlFaresTaxBadSF, LEFT.ln_fares_id = RIGHT.ln_fares_id, LOCAL, LEFT ONLY);							
																			
dAddlFaresTax := dAddlFaresTaxBadSF + dAddlFaresTaxGoodSF;																								
//JIRA DF-21659 Bad Square Footage Data Correction - end

dDeeds					:=	distribute(LN_PropertyV2.File_Deed(current_record	=	'Y'),hash32(ln_fares_id));
dAddlFaresDeeds	:=	distribute(Ln_PropertyV2.File_addl_Fares_deed,hash32(ln_fares_id));
dSearch					:=	LN_PropertyV2.File_Search_DID(source_code	in	['BP','OP']);

// Pull AID key
dAID	:=	distribute(pull(AID_Build.Key_AID_Base),RawAID);

// Get clean aid from the raw aid
rAppendCleanAID_layout	:=
record
	AID.Common.xAID	Append_CleanAID;
	dSearch;
end;

rAppendCleanAID_layout	tCleanAID(dSearch	le,AID_Build.Key_AID_Base	ri)	:=
transform
	self.Append_CleanAID	:=	ri.AceAID;
	self									:=	le;
end;

dSearchCleanAID	:=	join(	distribute(dSearch(Append_RawAID	!=	0),Append_RawAID),
													dAID,
													left.Append_RawAID	=	right.RawAID,
													tCleanAID(left,right),
													left outer,
													local
												);

dSearchCleanAIDDist	:=	distribute(dSearchCleanAID,hash32(ln_fares_id));

// Join to the additional fares tax file and get the required fields
rAddlTax_layout	:=
record
	dTax;
	string5	vendor_source;
	dAddlFaresTax.fares_flood_zone;
	dAddlFaresTax.fares_property_indicator;
	dAddlFaresTax.fares_view;
	dAddlFaresTax.fares_calculated_land_value;
	dAddlFaresTax.fares_calculated_improvement_value;
	dAddlFaresTax.fares_calculated_total_value;
	dAddlFaresTax.fares_second_mortgage_amt;
	dAddlFaresTax.fares_living_square_feet;
	dAddlFaresTax.fares_ground_floor_square_feet;
	dAddlFaresTax.fares_basement_square_feet;
	dAddlFaresTax.fares_garage_square_feet;
	dAddlFaresTax.fares_total_baths_calculated;
	dAddlFaresTax.fares_no_of_full_baths;
	dAddlFaresTax.fares_no_of_half_baths;
	dAddlFaresTax.fares_no_of_bath_fixtures;
	dAddlFaresTax.fares_fire_place_type;
	dAddlFaresTax.fares_pool_indicator;
	dAddlFaresTax.fares_frame;
	dAddlFaresTax.fares_parking_type;
	dAddlFaresTax.fares_stories_code;
end;

rAddlTax_layout	tAddlTax(dTax	le,dAddlFaresTax	ri)	:=
transform
	self.vendor_source	:=	if(le.vendor_source_flag	in	['F','S'],'FARES','OKCTY');
	self								:=	le;
	self								:=	ri;
end;

dAddlTax	:=	join(	dTax,
										dAddlFaresTax,
										left.ln_fares_id	=	right.ln_fares_id,
										tAddlTax(left,right),
										left outer,
										local
									);

// Join the assessment (tax) file to the search file to get the clean property address and raw AID
rTaxCleanAddr_layout	:=
record
	dAddlTax;
	dSearchCleanAIDDist.Append_PrepAddr1;
	dSearchCleanAIDDist.Append_PrepAddr2;
	dSearchCleanAIDDist.Append_RawAID;
	dSearchCleanAIDDist.Append_CleanAID;
	Address.Layout_Clean182;
	Address.Layout_Clean_Name;
end;

rTaxCleanAddr_layout	tTaxCleanAddr(dAddlTax	le,dSearchCleanAIDDist	ri)	:=
transform
	self.name_score			:=	'';
	self.addr_suffix		:=	ri.suffix;
	self								:=	le;
	self								:=	ri;
end;

dTaxCleanAddr	:=	join(	dAddlTax,
												dSearchCleanAIDDist,
												left.ln_fares_id			=	right.ln_fares_id	and
												right.source_code[1]	=	'O',
												tTaxCleanAddr(left,right),
												left outer,
												keep(1),
												local
											);

// Join to the additional fares deeds file and get the required fields
rAddlDeeds_layout	:=
record
	dDeeds;
	dAddlFaresDeeds.fares_transaction_type;
	string5	vendor_source;
end;

rAddlDeeds_layout	tAddlDeeds(dDeeds	le,dAddlFaresDeeds	ri)	:=
transform
	self.vendor_source	:=	if(le.vendor_source_flag	in	['F','S'],'FARES','OKCTY');
	self								:=	le;
	self								:=	ri;
end;

dAddlDeeds	:=	join(	dDeeds,
											dAddlFaresDeeds,
											left.ln_fares_id	=	right.ln_fares_id,
											tAddlDeeds(left,right),
											left outer,
											local
										);

// Join the deeds file to the search file to get the clean property address and raw AID
rDeedsCleanAddr_layout	:=
record
	dAddlDeeds;
	dSearchCleanAIDDist.Append_PrepAddr1;
	dSearchCleanAIDDist.Append_PrepAddr2;
	dSearchCleanAIDDist.Append_RawAID;
	dSearchCleanAIDDist.Append_CleanAID;
	Address.Layout_Clean182;
	Address.Layout_Clean_Name;
end;

rDeedsCleanAddr_layout	tDeedsCleanAddr(dAddlDeeds	le,dSearchCleanAIDDist	ri)	:=
transform
	self.name_score			:=	'';
	self.addr_suffix		:=	ri.suffix;
	self								:=	le;
	self								:=	ri;
end;

dDeedsCleanAddr	:=	join(	dAddlDeeds,
													dSearchCleanAIDDist,
													left.ln_fares_id	=	right.ln_fares_id,
													tDeedsCleanAddr(left,right),
													left outer,
													keep(1),
													local
												);

// Reformat the tax file to the temp base file layout
rTempBase_layout	:=
record
	string2		state;
	string1		flgMatchDeed;
	PropertyCharacteristics.Layouts.Common;
end;

// Functions used while convering the LN property records to the common layout
fDropZip4	(string pLineLast) :=	regexreplace('(^| )([0-9]{5})[-]?[0-9]{4}($| .*)',pLineLast,'\\1\\2');

// Filter out records which have incomplete cleaned addresses
dTaxCleanAddrPopulated		:=	dTaxCleanAddr(	prim_range	!=	''	and
																							prim_name		!=	''	and
																							(zip	!=	''	or	(v_city_name	!=	''	and	st	!=	''))
																						);
dTaxCleanAddrNotPopulated	:=	dTaxCleanAddr(~(	prim_range	!=	''	and
																								prim_name		!=	''	and
																								(zip	!=	''	or	(v_city_name	!=	''	and	st	!=	''))
																							)
																						);
// Map property data to common
rTempBase_layout	tPropertyMap2Common(dTaxCleanAddrPopulated	pInput)	:=
transform
	string	vNoStories	:=	regexreplace(	'^[O]+$',
																				regexreplace(	'[,]|[.]+',
																											regexreplace(	'AA|[A][+][A]',
																																		regexreplace(	'BB|[B][+][B]',
																																									regexreplace(	'[A][+][B]|[B][+][A]|BA',
																																																stringlib.stringfilterout(pInput.no_of_stories,' '),
																																																'AB',
																																																nocase
																																															),
																																									'B',
																																									nocase
																																								),
																																		'A',
																																		nocase
																																	),
																											'.',
																											nocase
																										),
																				'',
																				nocase
																			);
	
	self.tax_sortby_date							:=	map(	PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.tax_year)							!=	''	=>	pInput.tax_year	+	'0000',
																							PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.assessed_value_year)	!=	''	=>	pInput.assessed_value_year	+	'0000',
																							PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.recording_date)				!=	''	=>	pInput.recording_date,
																							''
																						);
	self.deed_sortby_date							:=	'';
	self.vendor_source								:=	pInput.vendor_source;
	self.vendor_preference						:=	if(pInput.vendor_source	=	'OKCTY',5,6);
	self.state												:=	pInput.state_code;
	self.property_street_address			:=	pInput.Append_PrepAddr1;
	self.property_city_state_zip			:=	pInput.Append_PrepAddr2;
	self.property_raw_aid							:=	pInput.Append_RawAID;
	self.property_ace_aid							:=	pInput.Append_CleanAID;
	self.building_square_footage			:=	if(	pInput.vendor_source	=	'FARES'	and	pInput.building_area_indicator	=	'B'	and	regexreplace('^[0]*$',pInput.building_area,'')	!=	'',
																						stringlib.stringfilterout(pInput.building_area,','),
																						map(	pInput.vendor_source	=	'OKCTY'	and	pInput.building_area_indicator	=	'T'	and	regexreplace('^[0]*$',pInput.building_area,'')	!=	''	=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.building_area1_indicator	=	'T'	and	regexreplace('^[0]*$',pInput.building_area1,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area1,','),
																									pInput.building_area2_indicator	=	'T'	and	regexreplace('^[0]*$',pInput.building_area2,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area2,','),
																									pInput.building_area3_indicator	=	'T'	and	regexreplace('^[0]*$',pInput.building_area3,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area3,','),
																									pInput.building_area4_indicator	=	'T'	and	regexreplace('^[0]*$',pInput.building_area4,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area4,','),
																									pInput.building_area5_indicator	=	'T'	and	regexreplace('^[0]*$',pInput.building_area5,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area5,','),
																									pInput.building_area6_indicator	=	'T'	and	regexreplace('^[0]*$',pInput.building_area6,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area6,','),
																									pInput.building_area7_indicator	=	'T'	and	regexreplace('^[0]*$',pInput.building_area7,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area7,','),
																									pInput.vendor_source	=	'OKCTY'	and	pInput.building_area_indicator	=	'R'	and	regexreplace('^[0]*$',pInput.building_area,'')	!=	''	=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.building_area1_indicator	=	'R'	and	regexreplace('^[0]*$',pInput.building_area1,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area1,','),
																									pInput.building_area2_indicator	=	'R'	and	regexreplace('^[0]*$',pInput.building_area2,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area2,','),
																									pInput.building_area3_indicator	=	'R'	and	regexreplace('^[0]*$',pInput.building_area3,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area3,','),
																									pInput.building_area4_indicator	=	'R'	and	regexreplace('^[0]*$',pInput.building_area4,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area4,','),
																									pInput.building_area5_indicator	=	'R'	and	regexreplace('^[0]*$',pInput.building_area5,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area5,','),
																									pInput.building_area6_indicator	=	'R'	and	regexreplace('^[0]*$',pInput.building_area6,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area6,','),
																									pInput.building_area7_indicator	=	'R'	and	regexreplace('^[0]*$',pInput.building_area7,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area7,','),
																									regexreplace('^[0]*$',pInput.fares_living_square_feet,'')	!=	''																																			=>	stringlib.stringfilterout(pInput.fares_living_square_feet,','),
																									pInput.vendor_source	=	'OKCTY'	and	pInput.building_area_indicator	=	'E'	and	regexreplace('^[0]*$',pInput.building_area,'')	!=	''	=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.building_area_indicator	=	'L'					and	regexreplace('^[0]*$',pInput.building_area,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.building_area1_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area1,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area1,','),
																									pInput.building_area2_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area2,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area2,','),
																									pInput.building_area3_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area3,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area3,','),
																									pInput.building_area4_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area4,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area4,','),
																									pInput.building_area5_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area5,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area5,','),
																									pInput.building_area6_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area6,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area6,','),
																									pInput.building_area7_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area7,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area7,','),
																									''
																								)
																					);
	self.air_conditioning_type				:=	if(	pInput.air_conditioning_code	!=	'',
																						stringlib.stringcleanspaces(pInput.air_conditioning_code),
																						stringlib.stringcleanspaces(pInput.air_conditioning_type_code)
																					);
	self.basement_finish							:=	pInput.basement_code;
	self.construction_type						:=	pInput.type_construction_code;
	self.exterior_wall								:=	pInput.exterior_walls_code;
	self.fireplace_ind								:=	pInput.fireplace_indicator;
	self.fireplace_type								:=	pInput.fares_fire_place_type;
	self.flood_zone_panel							:=	pInput.fares_flood_zone;
	self.garage												:=	pInput.garage_type_code;
	self.first_floor_square_footage		:=	if(	regexreplace('^[0]*$',pInput.fares_ground_floor_square_feet,'')	!=	'',
																						stringlib.stringfilterout(pInput.fares_ground_floor_square_feet,','),
																						map(	pInput.vendor_source	=	'FARES'	and	pInput.building_area_indicator	=	'R'																																			=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.vendor_source	=	'OKCTY'	and	pInput.building_area_indicator	in	['1','B']	and	regexreplace('^[0]*$',pInput.building_area,'')	!=	''	=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.building_area1_indicator	in	['1','B']	and	regexreplace('^[0]*$',pInput.building_area1,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area1,','),
																									pInput.building_area2_indicator	in	['1','B']	and	regexreplace('^[0]*$',pInput.building_area2,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area2,','),
																									pInput.building_area3_indicator	in	['1','B']	and	regexreplace('^[0]*$',pInput.building_area3,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area3,','),
																									pInput.building_area4_indicator	in	['1','B']	and	regexreplace('^[0]*$',pInput.building_area4,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area4,','),
																									pInput.building_area5_indicator	in	['1','B']	and	regexreplace('^[0]*$',pInput.building_area5,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area5,','),
																									pInput.building_area6_indicator	in	['1','B']	and	regexreplace('^[0]*$',pInput.building_area6,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area6,','),
																									pInput.building_area7_indicator	in	['1','B']	and	regexreplace('^[0]*$',pInput.building_area7,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area7,','),
																									''
																								)
																					);
	self.heating											:=	pInput.heating_code;
	self.living_area_square_footage		:=	if(	regexreplace('^[0]*$',pInput.fares_living_square_feet,'')	!=	'',
																						stringlib.stringfilterout(pInput.fares_living_square_feet,','),
																						map(	pInput.vendor_source	=	'OKCTY'	and	pInput.building_area_indicator	=	'E'	and	regexreplace('^[0]*$',pInput.building_area,'')	!=	''	=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.building_area_indicator	=	'L'					and	regexreplace('^[0]*$',pInput.building_area,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.building_area1_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area1,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area1,','),
																									pInput.building_area2_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area2,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area2,','),
																									pInput.building_area3_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area3,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area3,','),
																									pInput.building_area4_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area4,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area4,','),
																									pInput.building_area5_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area5,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area5,','),
																									pInput.building_area6_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area6,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area6,','),
																									pInput.building_area7_indicator	in	['E','L']	and	regexreplace('^[0]*$',pInput.building_area7,'')	!=	''															=>	stringlib.stringfilterout(pInput.building_area7,','),
																									''
																								)
																						);
	self.no_of_baths									:=	pInput.no_of_baths;
	self.no_of_bedrooms								:=	pInput.no_of_bedrooms;
	self.no_of_fireplaces							:=	pInput.fireplace_number;
	self.no_of_full_baths							:=	pInput.no_of_baths;
	self.no_of_half_baths							:=	pInput.no_of_partial_baths;
	self.no_of_stories								:=	if(	PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.no_of_stories)	!=	'',
																						if(	pInput.vendor_source	=	'FARES',
																								PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.no_of_stories),
																								if(	regexfind('(S/L|B/L|[1-9]/L|S/E|S/F|^[0-9]+[.]?[0-9]*[+]?[AB]?[AB]?$|^[1-9]*[1-9][/][1-9][+]?[AB]?[AB]?$)',vNoStories,nocase),
																										map(	vNoStories	=	'S/L'																									=>	'1',
																													vNoStories	=	'B/L'																									=>	'2',
																													regexfind('[1-9]/L',vNoStories,nocase)															=>	regexfind('[1-9]',vNoStories,0,nocase),
																													regexfind('^[0-9]+[.]?[0-9]*[+]?[AB]?[AB]?$',vNoStories,nocase)			=>	regexfind('^[0-9]+[.]?[0-9]*',vNoStories,0,nocase),
																													regexfind('^[1-9]*[1-9][/][1-9][+]?[AB]?[AB]?$',vNoStories,nocase)	=>	regexreplace('[1-9][/][1-9]',regexfind('^[1-9]*[1-9][/][1-9]',vNoStories,0,nocase),' $0'),
																													''
																												),
																										''
																									)
																							),
																						''
																					);
	self.parking_type									:=	pInput.fares_parking_type;
	self.pool_indicator								:=	if(	pInput.fares_pool_indicator	!=	'',
																						pInput.fares_pool_indicator,
																						if(	pInput.pool_code	!=	''	and	pInput.pool_code	!=	'C',
																								'Y',
																								'')
																					);
	self.pool_type										:=	pInput.pool_code;
	self.roof_cover										:=	pInput.roof_cover_code;
	self.year_built										:=	pInput.year_built;
	self.foundation										:=	pInput.foundation_code;
	self.basement_square_footage			:=	if(	regexreplace('^[0]*$',pInput.fares_basement_square_feet,'')	!=	'',
																						stringlib.stringfilterout(pInput.fares_basement_square_feet,','),
																						map(	pInput.vendor_source	=	'OKCTY'	and	pInput.building_area_indicator	=	'W'	and	regexreplace('^[0]*$',pInput.building_area,'')	!=	''	=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.building_area1_indicator	=	'W'	and	regexreplace('^[0]*$',pInput.building_area1,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area1,','),
																									pInput.building_area2_indicator	=	'W'	and	regexreplace('^[0]*$',pInput.building_area2,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area2,','),
																									pInput.building_area3_indicator	=	'W'	and	regexreplace('^[0]*$',pInput.building_area3,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area3,','),
																									pInput.building_area4_indicator	=	'W'	and	regexreplace('^[0]*$',pInput.building_area4,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area4,','),
																									pInput.building_area5_indicator	=	'W'	and	regexreplace('^[0]*$',pInput.building_area5,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area5,','),
																									pInput.building_area6_indicator	=	'W'	and	regexreplace('^[0]*$',pInput.building_area6,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area6,','),
																									pInput.building_area7_indicator	=	'W'	and	regexreplace('^[0]*$',pInput.building_area7,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area7,','),
																									''
																								)
																					);
	self.effective_year_built					:=	pInput.effective_year_built;
	self.garage_square_footage				:=	if(	regexreplace('^[0]*$',pInput.fares_garage_square_feet,'')	!=	'',
																						stringlib.stringfilterout(pInput.fares_garage_square_feet,','),
																						map(	pInput.vendor_source	=	'OKCTY'	and	pInput.building_area_indicator	=	'G'	and	regexreplace('^[0]*$',pInput.building_area,'')	!=	''	=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.building_area1_indicator	=	'G'	and	regexreplace('^[0]*$',pInput.building_area1,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area1,','),
																									pInput.building_area2_indicator	=	'G'	and	regexreplace('^[0]*$',pInput.building_area2,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area2,','),
																									pInput.building_area3_indicator	=	'G'	and	regexreplace('^[0]*$',pInput.building_area3,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area3,','),
																									pInput.building_area4_indicator	=	'G'	and	regexreplace('^[0]*$',pInput.building_area4,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area4,','),
																									pInput.building_area5_indicator	=	'G'	and	regexreplace('^[0]*$',pInput.building_area5,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area5,','),
																									pInput.building_area6_indicator	=	'G'	and	regexreplace('^[0]*$',pInput.building_area6,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area6,','),
																									pInput.building_area7_indicator	=	'G'	and	regexreplace('^[0]*$',pInput.building_area7,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area7,','),
																									pInput.vendor_source	=	'OKCTY'	and	pInput.building_area_indicator	=	'C'	and	regexreplace('^[0]*$',pInput.building_area,'')	!=	''	=>	stringlib.stringfilterout(pInput.building_area,','),
																									pInput.building_area1_indicator	=	'C'	and	regexreplace('^[0]*$',pInput.building_area1,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area1,','),
																									pInput.building_area2_indicator	=	'C'	and	regexreplace('^[0]*$',pInput.building_area2,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area2,','),
																									pInput.building_area3_indicator	=	'C'	and	regexreplace('^[0]*$',pInput.building_area3,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area3,','),
																									pInput.building_area4_indicator	=	'C'	and	regexreplace('^[0]*$',pInput.building_area4,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area4,','),
																									pInput.building_area5_indicator	=	'C'	and	regexreplace('^[0]*$',pInput.building_area5,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area5,','),
																									pInput.building_area6_indicator	=	'C'	and	regexreplace('^[0]*$',pInput.building_area6,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area6,','),
																									pInput.building_area7_indicator	=	'C'	and	regexreplace('^[0]*$',pInput.building_area7,'')	!=	''																			=>	stringlib.stringfilterout(pInput.building_area7,','),
																									if((integer)Functions.fn_remove_zeroes(pInput.parking_no_of_cars)	!=	0,(string)(((integer)Functions.fn_remove_zeroes(pInput.parking_no_of_cars))*200),'')
																								)
																					);
	self.stories_type									:=	pInput.fares_stories_code;
	self.apn_number										:=	pInput.apna_or_pin_number;
	self.range												:=	if(	pInput.legal_sec_twn_rng_mer	!=	'',
																						Functions.parseSecTwnRange(pInput.legal_sec_twn_rng_mer,'RNG'),
																						''
																					);
	self.block_number									:=	pInput.legal_block;
	self.zoning												:=	pInput.zoning;
	self.census_tract									:=	pInput.census_tract;
	self.county_name									:=	pInput.county_name;
	self.fips_code										:=	pInput.fips_code;
	self.latitude											:=	pInput.geo_lat;
	self.longitude										:=	pInput.geo_long;
	self.subdivision									:=	pInput.legal_subdivision_name;
	self.municipality									:=	pInput.legal_city_municipality_township;
	self.township											:=	if(	pInput.legal_sec_twn_rng_mer	!=	'',
																						Functions.parseSecTwnRange(pInput.legal_sec_twn_rng_mer,'TWN'),
																						''
																					);
	self.homestead_exemption_ind			:=	if(	pInput.tax_exemption1_code	=	'D'	or
																						pInput.tax_exemption2_code	=	'D'	or
																						pInput.tax_exemption3_code	=	'D'	or
																						pInput.tax_exemption4_code	=	'D',
																						'Y',
																						if(pInput.homestead_homeowner_exemption	=	'H','Y','')
																					);
	self.land_use_code								:=	pInput.standardized_land_use_code;
	self.location_influence_code			:=	if(	pInput.site_influence1_code	!=	'',
																						pInput.site_influence1_code,
																						if(	pInput.vendor_source	=	'FARES',
																								pInput.fares_view,
																								if(	pInput.site_influence2_code	!=	'',
																										pInput.site_influence2_code,
																										pInput.site_influence3_code
																									)
																							)
																					);
	self.lot_depth_footage						:=	if(	pInput.lot_size_depth_feet	!=	'',
																						pInput.lot_size_depth_feet,
																						if(	stringlib.stringfind(Functions.clean2Upper(pInput.land_dimensions),'X',1)	!=	0,
																								pInput.land_dimensions[stringlib.stringfind(Functions.clean2Upper(pInput.land_dimensions),'X',1)+1..],
																								pInput.land_dimensions
																							)
																					);
	self.lot_front_footage						:=	if(	pInput.lot_size_frontage_feet	!=	'',
																						pInput.lot_size_frontage_feet,
																						if(	stringlib.stringfind(Functions.clean2Upper(pInput.land_dimensions),'X',1)	!=	0,
																								pInput.land_dimensions[1..stringlib.stringfind(Functions.clean2Upper(pInput.land_dimensions),'X',1)-1],
																								pInput.land_dimensions
																							)
																					);
	self.lot_number										:=	pInput.legal_lot_number;
	self.lot_size											:=	pInput.land_square_footage;
	self.acres												:=	if(	pInput.land_acres	!=	'',
																						pInput.land_acres,
																						if(	pInput.lot_size_acres	!=	'',
																								(string)((integer)pInput.lot_size_acres/1000),
																								''
																							)
																					);
	self.property_type_code						:=	pInput.fares_property_indicator;
	self.structure_quality						:=	pInput.building_quality_code;
	self.sewer												:=	pInput.sewer_code;
	self.water												:=	pInput.water_code;
	self.floor_type										:=	pInput.floor_cover_code;
	self.frame_type										:=	pInput.fares_frame;
	self.style_type										:=	pInput.style_code;
	self.fuel_type										:=	pInput.heating_fuel_type_code;
	self.no_of_bath_fixtures					:=	if(	regexreplace('^[0]*$',pInput.fares_no_of_bath_fixtures,'')	!=	'',
																						pInput.fares_no_of_bath_fixtures,
																						regexreplace('^[0]*$',pInput.no_of_plumbing_fixtures,'')
																					);
	self.no_of_rooms									:=	pInput.no_of_rooms;
	self.no_of_units									:=	pInput.no_of_units;
	
	self.assessed_year								:=	pInput.assessed_value_year;
	self.tax_amount										:=	pInput.tax_amount;
	self.tax_year											:=	pInput.tax_year;
	self.assessed_land_value					:=	pInput.assessed_land_value;
	self.improvement_value						:=	pInput.assessed_improvement_value;
	self.market_land_value						:=	pInput.market_land_value;
	self.total_assessed_value					:=	pInput.assessed_total_value;
	self.percent_improved							:=	PropertyCharacteristics.Functions.pct(self.improvement_value,self.total_assessed_value);
	self.total_market_value						:=	pInput.market_total_value;
	self.total_land_value							:=	pInput.fares_calculated_land_value;
	self.total_calculated_value				:=	pInput.fares_calculated_total_value;
	self.assessment_document_number		:=	pInput.recorder_document_number;
	self.assessment_recording_date		:=	pInput.recording_date;
	self.sale_date										:=	pInput.sale_date;
	self.sale_amount									:=	pInput.sales_price;
	self.loan_amount									:=	pInput.mortgage_loan_amount;
	self.mortgage_company_name				:=	pInput.mortgage_lender_name;
	self.loan_type_code								:=	pInput.mortgage_loan_type_code;
	self.roof_type										:=  pInput.roof_type_code;
	self															:=	pInput;
	self															:=	[];
end;

dTax2Common	:=	project(dTaxCleanAddrPopulated,tPropertyMap2Common(left));

// Join to CodesV3 to get the stories description
rTempBase_layout	tStoriesDesc(dTax2Common	le,Codes.File_Codes_V3_In	ri)	:=
transform
	self.no_of_stories	:=	if(	le.no_of_stories	=	''	and	le.vendor_source	=	'FARES',
															map(	ri.code	=	'SPLIT LEVEL'	=>	'1',
																		ri.code	=	'BI-LEVEL'		=>	'2',
																		ri.code	=	'TRI-LEVEL'		=>	'3',
																		regexfind('[^0-9]*([0-9]*[ |/]*[1-9]*[ |/]*[1-9]*)',ri.long_desc,1,nocase)
																	),
															le.no_of_stories
														);
	self								:=	le;
end;

dStoriesDesc	:=	join(	dTax2Common,
												Codes.File_Codes_V3_In(file_name	=	'FARES_2580'	and	field_name	=	'STORIES_CODE'and	field_name2	=	'FAR_F'),
												left.stories_type	=	right.code,
												tStoriesDesc(left,right),
												left outer,
												lookup
											);

// Convert fractions in the no_of_stories field to decimals
rTempBase_layout	tConvert2Decimals(dStoriesDesc	pInput)	:=
transform
	vCleanNoStories			:=	stringlib.stringcleanspaces(pInput.no_of_stories);
	self.no_of_stories	:=	if(	regexfind('[1-9]*[/][1-9]*',vCleanNoStories),
															PropertyCharacteristics.Functions.fn_remove_zeroes((string)((integer)stringlib.stringcleanspaces(regexfind('[0-9]+[ ]',vCleanNoStories,0,nocase))	+	((integer)(regexfind('([1-9]*)[/]([1-9]*)',vCleanNoStories,1))/(integer)(regexfind('([1-9]*)[/]([1-9]*)',vCleanNoStories,2))))),
															vCleanNoStories
														);
	self								:=	pInput;
end;

dStoriesConversion	:=	project(dStoriesDesc,tConvert2Decimals(left));

// Distribute by source and cleaned address
dTax2CommonDist			:=	distribute(dStoriesConversion,hash32(vendor_source,property_ace_aid));
dDeedsCleanAddrDist	:=	distribute(	dDeedsCleanAddr(prim_range	!=	''	and	prim_name	!=	''	and	zip	!=	''),
																		hash32(vendor_source,Append_CleanAID)
																	);

// Join to the deeds file to get the deed information for the property
rTempBase_layout	tDeedsInfo(dTax2CommonDist	le,dDeedsCleanAddrDist	ri)	:=
transform
	self.flgMatchDeed											:=	if(	le.vendor_source		=	ri.vendor_source	and
																								le.property_ace_aid	=	ri.Append_CleanAID,
																								'Y',
																								'N'
																							);
	self.deed_sortby_date									:=	map(	PropertyCharacteristics.Functions.fn_remove_zeroes(ri.recording_date)	!=	''	=>	ri.recording_date,
																									PropertyCharacteristics.Functions.fn_remove_zeroes(ri.contract_date)		!=	''	=>	ri.contract_date,
																									PropertyCharacteristics.Functions.fn_remove_zeroes(le.sale_date)				!=	''	=>	le.sale_date,
																									''
																								);
	self.deed_document_number							:=	ri.document_number;
	self.full_part_sale										:=	ri.sales_price_code;
	self.sale_amount											:=	if(ri.sales_price	!=	'',ri.sales_price,le.sale_amount);
	self.sale_date												:=	if(ri.contract_date	!=	'',ri.contract_date,le.sale_date);
	self.sale_type_code										:=	ri.fares_transaction_type;
	self.loan_amount											:=	if(ri.first_td_loan_amount	!=	'',ri.first_td_loan_amount,le.loan_amount);
	self.second_loan_amount								:=	ri.second_td_loan_amount;
	self.loan_type_code										:=	if(ri.first_td_loan_type_code	!=	'',ri.first_td_loan_type_code,le.loan_type_code);
	self.interest_rate_type_code					:=	ri.type_financing;
	self.mortgage_company_name						:=	if(ri.lender_name	!=	'',ri.lender_name,le.mortgage_company_name);
	self.deed_recording_date							:=	ri.recording_date;
	self																	:=	le;
end;

dTaxDeedInfo	:=		join(	dTax2CommonDist,
													dDeedsCleanAddrDist,
													left.vendor_source		=	right.vendor_source	and
													left.property_ace_aid	=	right.Append_CleanAID,
													tDeedsInfo(left,right),
													left outer,
													keep(1),
													local
												);

// Match deeds by fipscode and apn number for records which didn't have the address populated
dTaxDeedMatch		:=	dTaxDeedInfo(flgMatchDeed	=	'Y');
dTaxDeedNoMatch	:=	distribute(dTaxDeedInfo(flgMatchDeed	=	'N'),hash32(vendor_source,fips_code,fares_unformatted_apn));

dDeedsAPNDist		:=	distribute(dDeedsCleanAddr,hash32(vendor_source,fips_code,fares_unformatted_apn));

PropertyCharacteristics.Layouts.Common	tDeedsInfo1(dTax2CommonDist	le,dDeedsCleanAddrDist	ri)	:=
transform
	self.deed_document_number							:=	ri.document_number;
	self.full_part_sale										:=	ri.sales_price_code;
	self.sale_amount											:=	if(ri.sales_price	!=	'',ri.sales_price,le.sale_amount);
	self.sale_date												:=	if(ri.contract_date	!=	'',ri.contract_date,le.sale_date);
	self.sale_type_code										:=	ri.fares_transaction_type;
	self.loan_amount											:=	if(ri.first_td_loan_amount	!=	'',ri.first_td_loan_amount,le.loan_amount);
	self.second_loan_amount								:=	ri.second_td_loan_amount;
	self.loan_type_code										:=	if(ri.first_td_loan_type_code	!=	'',ri.first_td_loan_type_code,le.loan_type_code);
	self.interest_rate_type_code					:=	ri.first_td_interest_rate;
	self.mortgage_company_name						:=	if(ri.lender_name	!=	'',ri.lender_name,le.mortgage_company_name);
	self.deed_recording_date							:=	ri.recording_date;
	self																	:=	le;
end;

dTaxDeedInfo1	:=		join(	dTaxDeedNoMatch,
													dDeedsAPNDist,
													left.vendor_source					=	right.vendor_source	and
													left.fips_code							=	right.fips_code			and
													left.fares_unformatted_apn	=	right.fares_unformatted_apn,
													tDeedsInfo1(left,right),
													left outer,
													keep(1),
													local
												);

dTaxDeedCombined	:=	project(dTaxDeedMatch,PropertyCharacteristics.Layouts.Common)	+	dTaxDeedInfo1;

// Clean fields which contain all zeroes
PropertyCharacteristics.Functions.Mac_Remove_Zeroes(dTaxDeedCombined,dTaxDeedCleaned);

export	Map_LNProperty_Common	:=	dTaxDeedCleaned	:	persist('~thor_data400::persist::propertyinfo::lnproperty2common');