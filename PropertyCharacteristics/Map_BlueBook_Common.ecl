import	ut;

export	Map_BlueBook_Common	:=
module

	// Map MLS1 to common
	PropertyCharacteristics.Layouts.Common	tMLS1_Map2Common(PropertyCharacteristics.Files.Prepped.MLS1	pInput)	:=
	transform
		self.vendor_source								:=	'MLS1';
		self.vendor_preference						:=	4;
		self.process_date									:=	pInput.ProcessDate;
		self.tax_sortby_date							:=	'';
		self.deed_sortby_date							:=	'';
		self.property_street_address			:=	pInput.Append_PrepAddr1;
		self.property_city_state_zip			:=	pInput.Append_PrepAddr2;
		self.property_raw_aid							:=	pInput.Append_RawAID;
		self.building_square_footage			:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.PropertyType)	!=	'LAND PROPERTY',
																							stringlib.stringfilterout(pInput.SqFootage,','),
																							''
																						);
		self.air_conditioning_type_desc		:=	pInput.CoolingFeatures;
		self.basement_finish_desc					:=	if(	regexfind(	'(BASEMENT IS )([0-9]+[ ]?SQ|[0-9]+[ ]?[X][ ]?[0-9]+|[0-9]+[ ]?)',
																													PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.Basement),
																													nocase
																												),
																							'UNFINISHED BASEMENT',
																							pInput.Basement
																						);
		self.construction_type_desc				:=	pInput.ExteriorConstruction;
		self.exterior_wall_desc						:=	pInput.ExteriorFinish;
		self.fireplace_ind								:=	if(	pInput.FireplaceFeatures	!=	''	or	pInput.FireplaceFeatures1	!=	'',
																							'Y',
																							'N'
																						);
		self.fireplace_type_desc					:=	if(	pInput.FireplaceFeatures	!=	'',
																							pInput.FireplaceFeatures,
																							pInput.FireplaceFeatures1
																						);
		self.flood_zone_panel							:=	'';
		self.garage_desc									:=	pInput.Carport;
		self.first_floor_square_footage		:=	'';
		self.heating_desc									:=	pInput.HeatingFeatures;
		self.living_area_square_footage		:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.PropertyType)	!=	'LAND PROPERTY',
																							stringlib.stringfilterout(pInput.SqFootage,','),
																							''
																						);
		self.no_of_baths									:=	pInput.NumBaths;
		self.no_of_bedrooms								:=	pInput.NumBeds;
		self.no_of_fireplaces							:=	'';
		self.no_of_full_baths							:=	'';
		self.no_of_half_baths							:=	'';
		self.no_of_stories								:=	case(	PropertyCharacteristics.Functions.clean2Upper(pInput.NumStories),
																								'SINGLE STORY'						=>	'1',
																								'STORY AND A HALF'				=>	'1.5',
																								'TWO STORY'								=>	'2',
																								'TWO AND A HALF STORY'		=>	'2.5',
																								'THREE STORY'							=>	'3',
																								'THREE AND A HALF STORY'	=>	'3.5',
																								'THREE OR MORE STORIES'		=>	'3+',
																								'FOUR OR MORE STORIES'		=>	'4+',
																								''
																						);
		self.parking_type_desc						:=	if(	pInput.ParkingFeatures	!=	'',
																							pInput.ParkingFeatures,
																							pInput.ParkingFeatures1
																						);
		self.pool_indicator								:=	if(pInput.PoolFeatures	!=	'','Y','N');
		self.pool_type_desc								:=	pInput.PoolFeatures;
		self.roof_cover_desc							:=	pInput.Roofing;
		self.year_built										:=	if((integer)pInput.YearBuilt	>	(integer)ut.GetDate[1..4],'',pInput.YearBuilt);
		self.foundation_desc							:=	if(stringlib.stringfind(stringlib.stringtouppercase(pInput.ExteriorConstruction),'FOUNDATION',1)	>	0,pInput.ExteriorConstruction,'');
		self.basement_square_footage			:=	if(	regexfind(	'(BASEMENT IS )([0-9]+[ ]?SQ|[0-9]+[ ]?[X][ ]?[0-9]+|[0-9]+[ ]?)',
																													stringlib.stringfilterout(PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.Basement),','),
																													nocase
																												),
																							map(	regexfind('[0-9]+[ ]?[X][ ]?[0-9]+',PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.Basement),nocase)	=>	(string)((real4)regexfind('([0-9]+)([ ]?[X][ ]?)([0-9]+)',Functions.fn_remove_zeroes(pInput.Basement),1,nocase)*(real4)regexfind('([0-9]+)([ ]?[X][ ]?)([0-9]+)',Functions.fn_remove_zeroes(pInput.Basement),3,nocase)),
																										regexfind('([0-9]+)',PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.Basement),1,nocase)
																									),
																							''
																						);
		self.effective_year_built					:=	'';
		self.garage_square_footage				:=	'';
		self.stories_type									:=	'';
		self.apn_number										:=	'';
		self.range												:=	'';
		self.block_number									:=	'';
		self.zoning												:=	'';
		self.census_tract									:=	'';
		self.county_name									:=	pInput.County;
		self.fips_code										:=	'';
		self.latitude											:=	'';
		self.longitude										:=	'';
		self.subdivision									:=	'';
		self.municipality									:=	'';
		self.township											:=	'';
		self.homestead_exemption_ind			:=	'';
		self.land_use_code								:=	'';
		self.location_influence_code			:=	'';
		self.location_influence_desc			:=	pInput.View;
		self.lot_depth_footage						:=	'';
		self.lot_front_footage						:=	'';
		self.lot_number										:=	'';
		self.lot_size											:=	'';
		self.acres												:=	pInput.Acre;
		self.property_type_code						:=	'';
		self.property_type_desc						:=	pInput.PropertyType;
		self.structure_quality						:=	'';
		self.sewer_desc										:=	'';
		self.water_desc										:=	'';
		self.tax_amount										:=	'';
		self.tax_year											:=	'';
		self.assessed_land_value					:=	'';
		self.assessed_year								:=	'';
		self.improvement_value						:=	'';
		self.market_land_value						:=	'';
		self.percent_improved							:=	0;
		self.total_assessed_value					:=	'';
		self.total_market_value						:=	'';
		self.total_land_value							:=	'';
		self.total_calculated_value				:=	'';
		self.floor_type_desc							:=	'';
		self.frame_type_desc							:=	'';
		self.style_type_desc							:=	pInput.Style;
		self.fuel_type_desc								:=	'';
		self.no_of_bath_fixtures					:=	'';
		self.no_of_rooms									:=	'';
		self.no_of_units									:=	pInput.NumUnits;
		self.assessment_document_number		:=	'';
		self.assessment_recording_date		:=	'';
		self.deed_document_number					:=	'';
		self.deed_recording_date					:=	'';
		self.full_part_sale								:=	'';
		self.sale_amount									:=	'';
		self.sale_date										:=	'';
		self.sale_type_code								:=	'';
		self.loan_amount									:=	'';
		self.second_loan_amount						:=	'';
		self.loan_type_code								:=	'';
		self.interest_rate_type_code			:=	'';
		self.mortgage_company_name				:=	'';
		
		self															:=	[];
	end;
	
	dMLS1_Map2Common	:=	project(PropertyCharacteristics.Files.Prepped.MLS1,tMLS1_Map2Common(left));
	
	PropertyCharacteristics.Functions.Mac_remove_Zeroes(dMLS1_Map2Common,dMLS1_Map2CommonCleaned);
	
	export	MLS1_Map2Common	:=	dMLS1_Map2CommonCleaned;

	// Map MLS2 to common
	PropertyCharacteristics.Layouts.Common	tMLS2_Map2Common(PropertyCharacteristics.Files.Prepped.MLS2	pInput)	:=
	transform
		self.vendor_source								:=	'MLS2';
		self.vendor_preference						:=	4;
		self.process_date									:=	pInput.ProcessDate;
		self.tax_sortby_date							:=	'';
		self.deed_sortby_date							:=	'';
		self.property_street_address			:=	pInput.Append_PrepAddr1;
		self.property_city_state_zip			:=	pInput.Append_PrepAddr2;
		self.property_raw_aid							:=	pInput.Append_RawAID;
		self.building_square_footage			:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.PropertyType)	!=	'LAND PROPERTY',
																							stringlib.stringfilterout(pInput.SqFootage,','),
																							''
																						);
		self.air_conditioning_type_desc		:=	pInput.CoolingFeatures;
		self.basement_finish_desc					:=	if(	regexfind(	'(BASEMENT IS )([0-9]+[ ]?SQ|[0-9]+[ ]?[X][ ]?[0-9]+|[0-9]+[ ]?)',
																													PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.Basement),
																													nocase
																												),
																							'UNFINISHED BASEMENT',
																							pInput.Basement
																						);
		self.construction_type_desc				:=	pInput.ExteriorConstruction;
		self.exterior_wall_desc						:=	'';
		self.fireplace_ind								:=	if(	pInput.FireplaceFeatures	!=	''	or	pInput.FireplaceFeatures1	!=	'',
																							'Y',
																							'N'
																						);
		self.fireplace_type_desc					:=	if(	pInput.FireplaceFeatures	!=	'',
																							pInput.FireplaceFeatures,
																							pInput.FireplaceFeatures1
																						);
		self.flood_zone_panel							:=	'';
		self.garage_desc									:=	pInput.Carport;
		self.first_floor_square_footage		:=	'';
		self.heating_desc									:=	pInput.HeatingFeatures;
		self.living_area_square_footage		:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.PropertyType)	!=	'LAND PROPERTY',
																							stringlib.stringfilterout(pInput.SqFootage,','),
																							''
																						);
		self.no_of_baths									:=	pInput.NumBaths;
		self.no_of_bedrooms								:=	pInput.NumBeds;
		self.no_of_fireplaces							:=	'';
		self.no_of_full_baths							:=	'';
		self.no_of_half_baths							:=	'';
		self.no_of_stories								:=	case(	PropertyCharacteristics.Functions.clean2Upper(pInput.NumStories),
																								'SINGLE STORY'						=>	'1',
																								'STORY AND A HALF'				=>	'1.5',
																								'TWO STORY'								=>	'2',
																								'TWO AND A HALF STORY'		=>	'2.5',
																								'THREE STORY'							=>	'3',
																								'THREE AND A HALF STORY'	=>	'3.5',
																								'THREE OR MORE STORIES'		=>	'3+',
																								'FOUR OR MORE STORIES'		=>	'4+',
																								''
																						);
		self.parking_type_desc						:=	if(	pInput.ParkingFeatures	!=	'',
																							pInput.ParkingFeatures,
																							pInput.ParkingFeatures1
																						);
		self.pool_indicator								:=	if(pInput.PoolFeatures	!=	'','Y','N');
		self.pool_type_desc								:=	pInput.PoolFeatures;
		self.roof_cover_desc							:=	pInput.Roofing;
		self.year_built										:=	if((integer)pInput.YearBuilt	>	(integer)ut.GetDate[1..4],'',pInput.YearBuilt);
		self.foundation_desc							:=	if(stringlib.stringfind(stringlib.stringtouppercase(pInput.ExteriorConstruction),'FOUNDATION',1)	>	0,pInput.ExteriorConstruction,'');
		self.basement_square_footage			:=	if(	regexfind(	'(BASEMENT IS )([0-9]+[ ]?SQ|[0-9]+[ ]?[X][ ]?[0-9]+|[0-9]+[ ]?)',
																													stringlib.stringfilterout(PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.Basement),','),
																													nocase
																												),
																							map(	regexfind('[0-9]+[ ]?[X][ ]?[0-9]+',PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.Basement),nocase)	=>	(string)((real4)regexfind('([0-9]+)([ ]?[X][ ]?)([0-9]+)',Functions.fn_remove_zeroes(pInput.Basement),1,nocase)*(real4)regexfind('([0-9]+)([ ]?[X][ ]?)([0-9]+)',Functions.fn_remove_zeroes(pInput.Basement),3,nocase)),
																										regexfind('([0-9]+)',PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.Basement),1,nocase)
																									),
																							''
																						);
		self.effective_year_built					:=	'';
		self.garage_square_footage				:=	'';
		self.stories_type									:=	'';
		self.apn_number										:=	'';
		self.range												:=	'';
		self.block_number									:=	'';
		self.zoning												:=	'';
		self.census_tract									:=	'';
		self.county_name									:=	pInput.County;
		self.fips_code										:=	'';
		self.latitude											:=	'';
		self.longitude										:=	'';
		self.subdivision									:=	'';
		self.municipality									:=	'';
		self.township											:=	'';
		self.homestead_exemption_ind			:=	'';
		self.land_use_code								:=	'';
		self.location_influence_code			:=	'';
		self.location_influence_desc			:=	pInput.View;
		self.lot_depth_footage						:=	'';
		self.lot_front_footage						:=	'';
		self.lot_number										:=	'';
		self.lot_size											:=	'';
		self.acres												:=	pInput.Acre;
		self.property_type_code						:=	'';
		self.property_type_desc						:=	pInput.PropertyType;
		self.structure_quality						:=	'';
		self.sewer_desc										:=	'';
		self.water_desc										:=	'';
		self.tax_amount										:=	'';
		self.tax_year											:=	'';
		self.assessed_land_value					:=	'';
		self.assessed_year								:=	'';
		self.improvement_value						:=	'';
		self.market_land_value						:=	'';
		self.percent_improved							:=	0;
		self.total_assessed_value					:=	'';
		self.total_market_value						:=	'';
		self.total_land_value							:=	'';
		self.total_calculated_value				:=	'';
		self.floor_type_desc							:=	'';
		self.frame_type_desc							:=	'';
		self.style_type_desc							:=	pInput.Style;
		self.fuel_type_desc								:=	'';
		self.no_of_bath_fixtures					:=	'';
		self.no_of_rooms									:=	'';
		self.no_of_units									:=	pInput.NumUnits;
		self.assessment_document_number		:=	'';
		self.assessment_recording_date		:=	'';
		self.deed_document_number					:=	'';
		self.deed_recording_date					:=	'';
		self.full_part_sale								:=	'';
		self.sale_amount									:=	'';
		self.sale_date										:=	'';
		self.sale_type_code								:=	'';
		self.loan_amount									:=	'';
		self.second_loan_amount						:=	'';
		self.loan_type_code								:=	'';
		self.interest_rate_type_code			:=	'';
		self.mortgage_company_name				:=	'';
		
		self															:=	[];
	end;
	
	dMLS2_Map2Common	:=	project(PropertyCharacteristics.Files.Prepped.MLS2,tMLS2_Map2Common(left));
	
	PropertyCharacteristics.Functions.Mac_remove_Zeroes(dMLS2_Map2Common,dMLS2_Map2CommonCleaned);
	
	export	MLS2_Map2Common	:=	dMLS2_Map2CommonCleaned;

	// Map MLS3 to common
	PropertyCharacteristics.Layouts.Common	tMLS3_Map2Common(PropertyCharacteristics.Files.Prepped.MLS3	pInput)	:=
	transform
		string	vTaxYear									:=	if(	length(stringlib.stringcleanspaces(pInput.TaxYear))	=	2,
																							if(	(integer)pInput.TaxYear	<=	20,
																									'20'	+	stringlib.stringcleanspaces(pInput.TaxYear),
																									'19'	+	stringlib.stringcleanspaces(pInput.TaxYear)
																								),
																							pInput.TaxYear
																						);
		string	vSoldDate									:=	map(	regexfind('[0-9]{1,2}[/][0-9]{1,2}[/](18|19|2[0-9])[0-9]{2}$',stringlib.stringcleanspaces(pInput.SoldDate))																																																																			=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.SoldDate)),
																								regexfind('[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2}$',stringlib.stringcleanspaces(pInput.SoldDate))																																																																										=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.SoldDate),'%m/%d/%y'),
																								regexfind('[0-9]{1,2}[-][0-9]{1,2}[-](18|19|2[0-9])[0-9]{2}$',stringlib.stringcleanspaces(pInput.SoldDate))																																																																			=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.SoldDate),'%m-%d-%Y'),
																								regexfind('[0-9]{1,2}[-][0-9]{1,2}[-][0-9]{2}$',stringlib.stringcleanspaces(pInput.SoldDate))																																																																										=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.SoldDate),'%m-%d-%y'),
																								regexfind('[0-9]{1,2}[-](JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER)[-](18|19|2[0-9])[0-9]{2}$',stringlib.stringcleanspaces(pInput.SoldDate),nocase)	=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.SoldDate),'%d-%b-%Y'),
																								regexfind('[0-9]{1,2}[-](JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER)[-][0-9]{2}$',stringlib.stringcleanspaces(pInput.SoldDate),nocase)								=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.SoldDate),'%d-%b-%y'),
																								regexfind('(18|19|2[0-9])[0-9]{6}$',stringlib.stringcleanspaces(pInput.SoldDate))																																																																																=>	stringlib.stringcleanspaces(pInput.SoldDate),
																								''
																						);
		string	vListingDate							:=	map(	regexfind('[0-9]{1,2}[/][0-9]{1,2}[/](18|19|2[0-9])[0-9]{2}$',stringlib.stringcleanspaces(pInput.ListingDate))																																																																			=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.ListingDate)),
																								regexfind('[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{2}$',stringlib.stringcleanspaces(pInput.ListingDate))																																																																										=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.ListingDate),'%m/%d/%y'),
																								regexfind('[0-9]{1,2}[-][0-9]{1,2}[-](18|19|2[0-9])[0-9]{2}$',stringlib.stringcleanspaces(pInput.ListingDate))																																																																			=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.ListingDate),'%m-%d-%Y'),
																								regexfind('[0-9]{1,2}[-][0-9]{1,2}[-][0-9]{2}$',stringlib.stringcleanspaces(pInput.ListingDate))																																																																										=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.ListingDate),'%m-%d-%y'),
																								regexfind('[0-9]{1,2}[-](JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER)[-](18|19|2[0-9])[0-9]{2}$',stringlib.stringcleanspaces(pInput.ListingDate),nocase)	=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.ListingDate),'%d-%b-%Y'),
																								regexfind('[0-9]{1,2}[-](JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER)[-][0-9]{2}$',stringlib.stringcleanspaces(pInput.ListingDate),nocase)								=>	ut.ConvertDate(stringlib.stringcleanspaces(pInput.ListingDate),'%d-%b-%y'),
																								regexfind('(18|19|2[0-9])[0-9]{6}$',stringlib.stringcleanspaces(pInput.ListingDate))																																																																																=>	stringlib.stringcleanspaces(pInput.ListingDate),
																								''
																						);
		
		self.vendor_source								:=	'MLS3';
		self.vendor_preference						:=	3;
		self.process_date									:=	pInput.ProcessDate;
		self.tax_sortby_date							:=	map(	PropertyCharacteristics.Functions.fn_remove_zeroes(vTaxYear)			!=	''	=>	vTaxYear	+	'0000',
																								PropertyCharacteristics.Functions.fn_remove_zeroes(vSoldDate)			!=	''	=>	vSoldDate,
																								PropertyCharacteristics.Functions.fn_remove_zeroes(vListingDate)	!=	''	=>	vListingDate,
																								''
																							);
		self.deed_sortby_date							:=	map(	PropertyCharacteristics.Functions.fn_remove_zeroes(vSoldDate)	!=	''	=>	vSoldDate,
																								''
																							);
		self.property_street_address			:=	pInput.Append_PrepAddr1;
		self.property_city_state_zip			:=	pInput.Append_PrepAddr2;
		self.property_raw_aid							:=	pInput.Append_RawAID;
		self.building_square_footage			:=	stringlib.stringfilterout(pInput.GrossLivingArea,',');
		self.air_conditioning_type_desc		:=	pInput.Cooling;
		self.basement_finish_desc					:=	if(	pInput.BasementFeature	!=	'',
																							if(	regexfind(	'(BASEMENT IS )([0-9]+[ ]?SQ|[0-9]+[ ]?[X][ ]?[0-9]+|[0-9]+[ ]?)',
																															PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.BasementFeature),
																															nocase
																														),
																									'UNFINISHED BASEMENT',
																									pInput.BasementFeature
																								),
																							if(	stringlib.stringcleanspaces(pInput.Basement)	=	'1',
																									'UNFINISHED BASEMENT',
																									''
																								)
																						);
		self.construction_type_desc				:=	pInput.Construction;
		self.exterior_wall_desc						:=	'';
		self.fireplace_ind								:=	if((integer)PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.Fireplaces)	>	0,'Y','N');
		self.fireplace_type_desc					:=	'';
		self.flood_zone_panel							:=	'';
		self.garage_desc									:=	pInput.GarageDesc;
		self.first_floor_square_footage		:=	stringlib.stringfilterout(pInput.FirstFloorSqFt,',');
		self.heating_desc									:=	pInput.Heating;
		self.living_area_square_footage		:=	if(	pInput.GrossLivingArea	!=	'',
																							stringlib.stringfilterout(pInput.GrossLivingArea,','),
																							(string)((integer)stringlib.stringfilterout(pInput.FirstFloorSqFt,',')	+	(integer)stringlib.stringfilterout(pInput.SecondFloorSqFt,','))
																						);
		self.no_of_baths									:=	pInput.BathsTotal;
		self.no_of_bedrooms								:=	pInput.Bedrooms;
		self.no_of_fireplaces							:=	pInput.Fireplaces;
		self.no_of_full_baths							:=	pInput.FullBaths;
		self.no_of_half_baths							:=	pInput.HalfBaths;
		self.no_of_stories								:=	if(	pInput.LivingLevels	!=	''	and	~regexfind('FEATURES',stringlib.stringcleanspaces(pInput.LivingLevels),nocase),
																							pInput.LivingLevels,
																							if(	pInput.Levels	!=	''	and	~regexfind('FEATURES',stringlib.stringcleanspaces(pInput.Levels),nocase),
																									pInput.Levels,
																									''
																								)
																						);
		self.parking_type_desc						:=	pInput.ParkingFeature;
		self.pool_indicator								:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.PoolYN)	in	['Y','N','U'],
																							PropertyCharacteristics.Functions.clean2Upper(pInput.PoolYN),
																							''
																							);
		self.pool_type_desc								:=	pInput.PoolDesc;
		self.roof_cover_desc							:=	pInput.RoofDesc;
		self.year_built										:=	if((integer)pInput.YearBuilt	>	(integer)ut.GetDate[1..4],'',pInput.YearBuilt);
		self.foundation_desc							:=	pInput.FoundationType;
		self.basement_square_footage			:=	if(	regexfind(	'(BASEMENT IS )([0-9]+[ ]?SQ|[0-9]+[ ]?[X][ ]?[0-9]+|[0-9]+[ ]?)',
																													stringlib.stringfilterout(PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.BasementFeature),','),
																													nocase
																												),
																							map(	regexfind('[0-9]+[ ]?[X][ ]?[0-9]+',PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.BasementFeature),nocase)	=>	(string)((real4)regexfind('([0-9]+)([ ]?[X][ ]?)([0-9]+)',Functions.fn_remove_zeroes(pInput.BasementFeature),1,nocase)*(real4)regexfind('([0-9]+)([ ]?[X][ ]?)([0-9]+)',Functions.fn_remove_zeroes(pInput.BasementFeature),3,nocase)),
																										regexfind('([0-9]+)',PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.BasementFeature),1,nocase)
																									),
																							''
																						);
		self.effective_year_built					:=	'';
		self.garage_square_footage				:=	if(	regexfind('^[0-9]*$',PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.GarageCapacity)),
																							(string)(200*(integer)PropertyCharacteristics.Functions.fn_remove_zeroes(stringlib.stringfilterout(pInput.GarageCapacity,','))),
																							''
																						);
		self.stories_type									:=	'';
		self.apn_number										:=	pInput.TaxID;
		self.range												:=	'';
		self.block_number									:=	pInput.Census;
		self.census_tract									:=	pInput.Census;
		self.zoning												:=	pInput.Zoning;
		self.county_name									:=	pInput.CountyName;
		self.fips_code										:=	'';
		self.latitude											:=	pInput.Latitude;
		self.longitude										:=	pInput.Longitude;
		self.subdivision									:=	pInput.SubdivisionName;
		self.municipality									:=	'';
		self.township											:=	'';
		self.homestead_exemption_ind			:=	'';
		self.land_use_code								:=	pInput.PropClassID;
		self.location_influence_code			:=	'';
		self.lot_depth_footage						:=	'';
		self.lot_front_footage						:=	'';
		self.lot_number										:=	pInput.LotNo;
		self.lot_size											:=	if(	pInput.LotDescription	!=	'',
																							pInput.LotDescription,
																							pInput.LotSize
																						);
		self.acres												:=	pInput.Acres;
		self.property_type_code						:=	'';
		self.property_type_desc						:=	pInput.PropType;
		self.structure_quality						:=	'';
		self.sewer_desc										:=	pInput.Sewer;
		self.water_desc										:=	pInput.SewerWater;
		self.tax_amount										:=	pInput.TaxAmount;
		self.tax_year											:=	vTaxYear;
		self.assessed_land_value					:=	if(	pInput.LandValue	!=	'',
																							pInput.LandValue,
																							pInput.LandAssessment
																						);
		self.assessed_year								:=	'';
		self.improvement_value						:=	pInput.ImprovementAssessment;
		self.market_land_value						:=	pInput.LandValue;
		self.total_assessed_value					:=	pInput.AssessedValue;
		self.percent_improved							:=	Functions.pct(self.improvement_value,self.total_assessed_value);
		self.total_market_value						:=	'';
		self.total_land_value							:=	'';
		self.total_calculated_value				:=	'';
		self.floor_type_desc							:=	pInput.FloorDesc;
		self.frame_type_desc							:=	'';
		self.style_type_desc							:=	pInput.Style;
		self.fuel_type_desc								:=	pInput.HeatDesc;
		self.no_of_bath_fixtures					:=	'';
		self.no_of_rooms									:=	pInput.TotalRooms;
		self.no_of_units									:=	pInput.UnitsInComplex;
		self.assessment_document_number		:=	'';
		self.assessment_recording_date		:=	if(	regexreplace('^[0]+$',stringlib.stringcleanspaces(vSoldDate),'')	!=	'',
																							stringlib.stringcleanspaces(vSoldDate),
																							''
																						);
		self.deed_document_number					:=	'';
		self.deed_recording_date					:=	if(	regexreplace('^[0]+$',stringlib.stringcleanspaces(vSoldDate),'')	!=	'',
																							stringlib.stringcleanspaces(vSoldDate),
																							''
																						);;
		self.full_part_sale								:=	'';
		self.sale_amount									:=	pInput.SalePrice;
		self.sale_date										:=	PropertyCharacteristics.Functions.fFormatDate(vSoldDate);
		self.sale_type_code								:=	'';
		self.loan_amount									:=	'';
		self.second_loan_amount						:=	'';
		self.loan_type_code								:=	'';
		self.interest_rate_type_code			:=	'';
		self.mortgage_company_name				:=	'';
		/*
		self.rec_date_sale_amount					:=	if(	regexreplace('^[0]+$',stringlib.stringcleanspaces(pInput.SoldDate),'')	!=	'',
																							stringlib.stringcleanspaces(pInput.SoldDate),
																							''
																						);
		self.rec_date_sale_date						:=	if(	regexreplace('^[0]+$',stringlib.stringcleanspaces(pInput.SoldDate),'')	!=	'',
																							stringlib.stringcleanspaces(pInput.SoldDate),
																							''
																						);
		*/
		self															:=	[];
	end;

	dMLS3_Map2Common	:=	project(PropertyCharacteristics.Files.Prepped.MLS3,tMLS3_Map2Common(left));
	
	PropertyCharacteristics.Functions.Mac_remove_Zeroes(dMLS3_Map2Common,dMLS3_Map2CommonCleaned);
	
	export	MLS3_Map2Common	:=	dMLS3_Map2CommonCleaned;

	// Map MLS4 to common
	PropertyCharacteristics.Layouts.Common	tMLS4_Map2Common(PropertyCharacteristics.Files.Prepped.MLS4	pInput)	:=
	transform
		self.vendor_source								:=	'MLS4';
		self.vendor_preference						:=	4;
		self.process_date									:=	pInput.ProcessDate;
		self.tax_sortby_date							:=	'';
		self.deed_sortby_date							:=	'';
		self.property_street_address			:=	pInput.Append_PrepAddr1;
		self.property_city_state_zip			:=	pInput.Append_PrepAddr2;
		self.property_raw_aid							:=	pInput.Append_RawAID;
		self.building_square_footage			:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.PropertyType)	!=	'LAND PROPERTY',
																							stringlib.stringfilterout(pInput.SqFootage,','),
																							''
																						);
		self.air_conditioning_type_desc		:=	pInput.CoolingFeatures;
		self.basement_finish_desc					:=	'';
		self.construction_type_desc				:=	pInput.ExteriorConstruction;
		self.exterior_wall_desc						:=	'';
		self.fireplace_ind								:=	if(	pInput.FireplaceFeatures	!=	''	or	pInput.FireplaceFeatures1	!=	'',
																							'Y',
																							'N'
																						);
		self.fireplace_type_desc					:=	if(	pInput.FireplaceFeatures	!=	'',
																							pInput.FireplaceFeatures,
																							pInput.FireplaceFeatures1
																						);
		self.flood_zone_panel							:=	'';
		self.garage_desc									:=	pInput.Garage;
		self.first_floor_square_footage		:=	'';
		self.heating_desc									:=	pInput.HeatingFeatures;
		self.living_area_square_footage		:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.PropertyType)	!=	'LAND PROPERTY',
																							stringlib.stringfilterout(pInput.SqFootage,','),
																							''
																						);
		self.no_of_baths									:=	pInput.NumBaths;
		self.no_of_bedrooms								:=	pInput.NumBeds;
		self.no_of_fireplaces							:=	'';
		self.no_of_full_baths							:=	pInput.TotalFullBaths;
		self.no_of_half_baths							:=	'';
		self.no_of_stories								:=	case(	PropertyCharacteristics.Functions.clean2Upper(pInput.NumStories),
																								'SINGLE STORY'						=>	'1',
																								'STORY AND A HALF'				=>	'1.5',
																								'TWO STORY'								=>	'2',
																								'TWO AND A HALF STORY'		=>	'2.5',
																								'THREE STORY'							=>	'3',
																								'THREE AND A HALF STORY'	=>	'3.5',
																								'THREE OR MORE STORIES'		=>	'3+',
																								'FOUR OR MORE STORIES'		=>	'4+',
																								''
																						);
		self.parking_type_desc						:=	if(	pInput.ParkingFeatures	!=	'',
																							pInput.ParkingFeatures,
																							pInput.ParkingFeatures1
																						);
		self.pool_indicator								:=	if(pInput.PoolFeatures	!=	'','Y','N');
		self.pool_type_desc								:=	pInput.PoolFeatures;
		self.roof_cover_desc							:=	pInput.Roofing;
		self.year_built										:=	pInput.YearBuilt;
		self.foundation_desc							:=	if(stringlib.stringfind(stringlib.stringtouppercase(pInput.ExteriorConstruction),'FOUNDATION',1)	>	0,pInput.ExteriorConstruction,'');
		self.basement_square_footage			:=	'';
		self.effective_year_built					:=	'';
		self.garage_square_footage				:=	'';
		self.stories_type									:=	'';
		self.apn_number										:=	'';
		self.range												:=	'';
		self.block_number									:=	'';
		self.zoning												:=	pInput.Zoning;
		self.census_tract									:=	'';
		self.county_name									:=	pInput.County;
		self.fips_code										:=	'';
		self.latitude											:=	'';
		self.longitude										:=	'';
		self.subdivision									:=	'';
		self.municipality									:=	'';
		self.township											:=	'';
		self.homestead_exemption_ind			:=	'';
		self.land_use_code								:=	'';
		self.location_influence_code			:=	'';
		self.lot_depth_footage						:=	'';
		self.lot_front_footage						:=	'';
		self.lot_number										:=	'';
		self.lot_size											:=	'';
		self.acres												:=	pInput.Acre;
		self.property_type_code						:=	'';
		self.property_type_desc						:=	pInput.PropertyType;
		self.structure_quality						:=	'';
		self.sewer_desc										:=	'';
		self.water_desc										:=	'';
		self.tax_amount										:=	'';
		self.tax_year											:=	'';
		self.assessed_land_value					:=	'';
		self.assessed_year								:=	'';
		self.improvement_value						:=	'';
		self.market_land_value						:=	'';
		self.percent_improved							:=	0;
		self.total_assessed_value					:=	'';
		self.total_market_value						:=	'';
		self.total_land_value							:=	'';
		self.total_calculated_value				:=	'';
		self.floor_type_desc							:=	'';
		self.frame_type_desc							:=	'';
		self.style_type_desc							:=	pInput.Style;
		self.fuel_type_desc								:=	'';
		self.no_of_bath_fixtures					:=	'';
		self.no_of_rooms									:=	'';
		self.no_of_units									:=	pInput.NumUnits;
		self.assessment_document_number		:=	'';
		self.assessment_recording_date		:=	'';
		self.deed_document_number					:=	'';
		self.deed_recording_date					:=	'';
		self.full_part_sale								:=	'';
		self.sale_amount									:=	'';
		self.sale_date										:=	'';
		self.sale_type_code								:=	'';
		self.loan_amount									:=	'';
		self.second_loan_amount						:=	'';
		self.loan_type_code								:=	'';
		self.interest_rate_type_code			:=	'';
		self.mortgage_company_name				:=	'';
		
		self															:=	[];
	end;
	
	dMLS4_Map2Common	:=	project(PropertyCharacteristics.Files.Prepped.MLS4,tMLS4_Map2Common(left));
	
	PropertyCharacteristics.Functions.Mac_remove_Zeroes(dMLS4_Map2Common,dMLS4_Map2CommonCleaned);
	
	export	MLS4_Map2Common	:=	dMLS4_Map2CommonCleaned;
	
	// Temporary common layout for BlueBook data
	shared	rBBTemp_layout	:=
	record
		unsigned8	PolicyID;
		PropertyCharacteristics.Layouts.Common;
	end;
	
	// Map INSURANCE1 to common
	PropertyCharacteristics.Layout_In.StructureDetail	tIns1IBCodes(PropertyCharacteristics.Layout_In.StructureDetail	ri)	:=
	transform
		self	:=	ri;
	end;
	
	Ins1IBCodes				:=	normalize(PropertyCharacteristics.Files.Prepped.Insurance1(PolicyID	!=	0),left.IBCodes,tIns1IBCodes(right));
	Ins1IBCodesDist		:=	distribute(Ins1IBCodes,PolicyID);
	Ins1IBCodesSort		:=	sort(Ins1IBCodesDist,PolicyID,category,-Value,local);
	Ins1IBCodesDedup	:=	dedup(Ins1IBCodesSort,PolicyID,category,local);
	
	rBBTemp_layout	tIns1Common(PropertyCharacteristics.Layout_In.BlueBook_Prepped	pInput)	:=
	transform
		self.process_date									:=	pInput.ProcessDate;
		self.property_street_address			:=	pInput.Append_PrepAddr1;
		self.property_city_state_zip			:=	pInput.Append_PrepAddr2;
		self.property_raw_aid							:=	pInput.Append_RawAID;
		self.county												:=	'';
		
		self.living_area_square_footage		:=	stringlib.stringfilterout(pInput.LivingArea,',');
		self.no_of_baths									:=	pInput.Baths;
		self.no_of_bedrooms								:=	pInput.Bedrooms;
		self.no_of_fireplaces							:=	(string)((integer)pInput.Fireplaces);
		self.fireplace_ind								:=	if((integer)pInput.Fireplaces	>	0,'Y','N');
		self.no_of_stories								:=	(string)((integer)pInput.Stories);
		self.pool_indicator								:=	pInput.Pool;
		self.year_built										:=	pInput.YearBuilt;
		self.census_tract									:=	pInput.CensusTract;
		self.county_name									:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.County)	!=	'NULL',
																							PropertyCharacteristics.Functions.clean2Upper(pInput.County),
																							''
																						);
		self.fips_code										:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.FipsCode)	!=	'NULL',
																							pInput.FipsCode,
																							''
																						);
		self.no_of_rooms									:=	(string)((integer)pInput.TotalRooms);
		self.lot_size											:=	pInput.LotArea;
		self.insurbase_codes							:=	project(pInput.IBCodes,PropertyCharacteristics.Layout_Codes.TradeMaterials);
		self															:=	pInput;
		self															:=	[];
	end;
	
	dIns1Prep2Common	:=	project(PropertyCharacteristics.Files.Prepped.Insurance1(PolicyID	!=	0),tIns1Common(left));
	
	rBBTemp_layout	tIns1_Map2Common(rBBTemp_layout	le,PropertyCharacteristics.Layout_In.StructureDetail	ri)	:=
	transform
		self.vendor_source								:=	'INS1';
		self.vendor_preference						:=	2;
		self.tax_sortby_date							:=	'';
		self.deed_sortby_date							:=	'';
		self.air_conditioning_type				:=	if(	le.air_conditioning_type	!=	'',
																							le.air_conditioning_type,
																							if(ri.category	=	'001',ri.material,'')
																						);
		self.basement_finish							:=	if(	le.basement_finish	!=	'',
																							le.basement_finish,
																							if(ri.category	=	'013',ri.material,'')
																						);
		self.construction_type						:=	if(	le.construction_type	!=	'',
																							le.construction_type,
																							if(ri.category	=	'005',ri.material,'')
																						);
		self.exterior_wall								:=	if(	le.exterior_wall	!=	'',
																							le.exterior_wall,
																							if(ri.category	=	'005',ri.material,'')
																						);
		self.garage												:=	if(	le.garage	!=	'',
																							le.garage,
																							if(ri.category	=	'012',ri.material,'')
																						);
		self.heating											:=	if(	le.heating	!=	'',
																							le.heating,
																							if(ri.category	=	'001',ri.material,'')
																						);
		self.parking_type									:=	if(	le.parking_type	!=	'',
																							le.parking_type,
																							if(ri.category	=	'012',ri.material,'')
																						);
		self.roof_cover										:=	if(	le.roof_cover	!=	'',
																							le.roof_cover,
																							if(ri.category	=	'006',ri.material,'')
																						);
		self.foundation										:=	if(	le.foundation	!=	'',
																							le.foundation,
																							if(ri.category	=	'007',ri.material,'')
																						);
		self.floor_type										:=	if(	le.floor_type	!=	'',
																							le.floor_type,
																							if(ri.category	=	'003',ri.material,'')
																						);
		self.fuel_type										:=	if(	le.fuel_type	!=	'',
																							le.fuel_type,
																							if(ri.category	=	'001',ri.material,'')
																						);
		self															:=	le;
	end;
	
	dIns1_Map2Common	:=	denormalize(	distribute(dIns1Prep2Common,PolicyID),
																			Ins1IBCodesDedup,
																			left.PolicyID	=	right.PolicyID,
																			tIns1_Map2Common(left,right),
																			local
																		);
	
	PropertyCharacteristics.Functions.Mac_remove_Zeroes(dIns1_Map2Common,dIns1_Map2CommonCleaned);
	
	// Bring back to common layout
	export	Ins1_Map2Common	:=	project(dIns1_Map2CommonCleaned,PropertyCharacteristics.Layouts.Common);
/*
	// Map INSURANCE2	to common
	PropertyCharacteristics.Layout_In.StructureDetail	tIns2IBCodes(PropertyCharacteristics.Layout_In.StructureDetail	ri)	:=
	transform
		self	:=	ri;
	end;
	
	Ins2IBCodes				:=	normalize(PropertyCharacteristics.Files.Prepped.Insurance2(PolicyID	!=	0),left.IBCodes,tIns2IBCodes(right));
	Ins2IBCodesDist		:=	distribute(Ins2IBCodes,PolicyID);
	Ins2IBCodesSort		:=	sort(Ins2IBCodesDist,PolicyID,category,-Value,local);
	Ins2IBCodesDedup	:=	dedup(Ins2IBCodesSort,PolicyID,category,local);
	
	// Reformat prepped INS2 file to base common	
	rBBTemp_layout	tIns2Common(PropertyCharacteristics.Layout_In.BlueBook_Prepped	pInput)	:=
	transform
		self.process_date									:=	pInput.ProcessDate;
		self.property_street_address			:=	pInput.Append_PrepAddr1;
		self.property_city_state_zip			:=	pInput.Append_PrepAddr2;
		self.property_raw_aid							:=	pInput.Append_RawAID;
		self.county												:=	'';
		
		self.living_area_square_footage		:=	stringlib.stringfilterout(pInput.LivingArea,',');
		self.no_of_baths									:=	pInput.Baths;
		self.no_of_bedrooms								:=	pInput.Bedrooms;
		self.no_of_fireplaces							:=	(string)((integer)pInput.Fireplaces);
		self.fireplace_ind								:=	if((integer)pInput.Fireplaces	>	0,'Y','N');
		self.no_of_stories								:=	(string)((integer)pInput.Stories);
		self.pool_indicator								:=	pInput.Pool;
		self.year_built										:=	pInput.YearBuilt;
		self.census_tract									:=	pInput.CensusTract;
		self.county_name									:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.County)	!=	'NULL',
																							PropertyCharacteristics.Functions.clean2Upper(pInput.County),
																							''
																						);
		self.fips_code										:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.FipsCode)	!=	'NULL',
																							pInput.FipsCode,
																							''
																						);
		self.no_of_rooms									:=	(string)((integer)pInput.TotalRooms);
		self.lot_size											:=	pInput.LotArea;
		self.insurbase_codes							:=	project(pInput.IBCodes,PropertyCharacteristics.Layout_Codes.TradeMaterials);
		self															:=	pInput;
		self															:=	[];
	end;
	
	dIns2Prep2Common	:=	project(PropertyCharacteristics.Files.Prepped.Insurance2(PolicyID	!=	0),tIns2Common(left));
	
	rIns2Temp_layout	tIns2_Map2Common(rBBTemp_layout	le,PropertyCharacteristics.Layout_In.StructureDetail	ri)	:=
	transform
		self.vendor_source								:=	'INS2';
		self.vendor_preference						:=	2;
		self.tax_sortby_date							:=	'';
		self.deed_sortby_date							:=	'';
		self.air_conditioning_type				:=	if(	le.air_conditioning_type	!=	'',
																							le.air_conditioning_type,
																							if(ri.category	=	'001',ri.material,'')
																						);
		self.basement_finish							:=	if(	le.basement_finish	!=	'',
																							le.basement_finish,
																							if(ri.category	=	'013',ri.material,'')
																						);
		self.construction_type						:=	if(	le.construction_type	!=	'',
																							le.construction_type,
																							if(ri.category	=	'005',ri.material,'')
																						);
		self.exterior_wall								:=	if(	le.exterior_wall	!=	'',
																							le.exterior_wall,
																							if(ri.category	=	'005',ri.material,'')
																						);
		self.garage												:=	if(	le.garage	!=	'',
																							le.garage,
																							if(ri.category	=	'012',ri.material,'')
																						);
		self.heating											:=	if(	le.heating	!=	'',
																							le.heating,
																							if(ri.category	=	'001',ri.material,'')
																						);
		self.parking_type									:=	if(	le.parking_type	!=	'',
																							le.parking_type,
																							if(ri.category	=	'012',ri.material,'')
																						);
		self.roof_cover										:=	if(	le.roof_cover	!=	'',
																							le.roof_cover,
																							if(ri.category	=	'006',ri.material,'')
																						);
		self.foundation										:=	if(	le.foundation	!=	'',
																							le.foundation,
																							if(ri.category	=	'007',ri.material,'')
																						);
		self.floor_type										:=	if(	le.floor_type	!=	'',
																							le.floor_type,
																							if(ri.category	=	'003',ri.material,'')
																						);
		self.fuel_type										:=	if(	le.fuel_type	!=	'',
																							le.fuel_type,
																							if(ri.category	=	'001',ri.material,'')
																						);
		self															:=	le;
	end;
	
	dIns2_Map2Common	:=	denormalize(	distribute(dIns2Prep2Common,PolicyID),
																			Ins2IBCodesDedup,
																			left.PolicyID	=	right.PolicyID,
																			tIns2_Map2Common(left,right),
																			local
																		);
	
	PropertyCharacteristics.Functions.Mac_remove_Zeroes(dIns2_Map2Common,dIns2_Map2CommonCleaned);
	
	// Bring back to common layout
	export	Ins2_Map2Common	:=	project(dIns2_Map2CommonCleaned,PropertyCharacteristics.Layouts.Common);
	*/
	
	// Map APPRAISER	to common
	PropertyCharacteristics.Layout_In.StructureDetail	tApprIBCodes(PropertyCharacteristics.Layout_In.StructureDetail	ri)	:=
	transform
		self	:=	ri;
	end;
	
	ApprIBCodes				:=	normalize(PropertyCharacteristics.Files.Prepped.Appraiser(PolicyID	!=	0),left.IBCodes,tApprIBCodes(right));
	ApprIBCodesDist		:=	distribute(ApprIBCodes,PolicyID);
	ApprIBCodesSort		:=	sort(ApprIBCodesDist,PolicyID,category,-Value,local);
	ApprIBCodesDedup	:=	dedup(ApprIBCodesSort,PolicyID,category,local);
	
	rBBTemp_layout	tApprCommon(PropertyCharacteristics.Layout_In.BlueBook_Prepped	pInput)	:=
	transform
		self.process_date									:=	pInput.ProcessDate;
		self.property_street_address			:=	pInput.Append_PrepAddr1;
		self.property_city_state_zip			:=	pInput.Append_PrepAddr2;
		self.property_raw_aid							:=	pInput.Append_RawAID;
		self.county												:=	'';
		
		self.living_area_square_footage		:=	stringlib.stringfilterout(pInput.LivingArea,',');
		self.no_of_baths									:=	pInput.Baths;
		self.no_of_bedrooms								:=	pInput.Bedrooms;
		self.no_of_fireplaces							:=	(string)((integer)pInput.Fireplaces);
		self.fireplace_ind								:=	if((integer)pInput.Fireplaces	>	0,'Y','N');
		self.no_of_stories								:=	(string)((integer)pInput.Stories);
		self.pool_indicator								:=	pInput.Pool;
		self.year_built										:=	pInput.YearBuilt;
		self.census_tract									:=	pInput.CensusTract;
		self.county_name									:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.County)	!=	'NULL',
																							PropertyCharacteristics.Functions.clean2Upper(pInput.County),
																							''
																						);
		self.fips_code										:=	if(	PropertyCharacteristics.Functions.clean2Upper(pInput.FipsCode)	!=	'NULL',
																							pInput.FipsCode,
																							''
																						);
		self.no_of_rooms									:=	(string)((integer)pInput.TotalRooms);
		self.lot_size											:=	pInput.LotArea;
		self.insurbase_codes							:=	project(pInput.IBCodes,PropertyCharacteristics.Layout_Codes.TradeMaterials);
		self															:=	pInput;
		self															:=	[];
	end;
	
	dApprPrep2Common	:=	project(PropertyCharacteristics.Files.Prepped.Appraiser(PolicyID	!=	0),tApprCommon(left));
	
	rBBTemp_layout	tAppr_Map2Common(rBBTemp_layout	le,PropertyCharacteristics.Layout_In.StructureDetail	ri)	:=
	transform
		self.vendor_source								:=	'APPR';
		self.vendor_preference						:=	1;
		self.tax_sortby_date							:=	'';
		self.deed_sortby_date							:=	'';
		self.air_conditioning_type				:=	if(	le.air_conditioning_type	!=	'',
																							le.air_conditioning_type,
																							if(ri.category	=	'001',ri.material,'')
																						);
		self.basement_finish							:=	if(	le.basement_finish	!=	'',
																							le.basement_finish,
																							if(ri.category	=	'013',ri.material,'')
																						);
		self.construction_type						:=	if(	le.construction_type	!=	'',
																							le.construction_type,
																							if(ri.category	=	'005',ri.material,'')
																						);
		self.exterior_wall								:=	if(	le.exterior_wall	!=	'',
																							le.exterior_wall,
																							if(ri.category	=	'005',ri.material,'')
																						);
		self.garage												:=	if(	le.garage	!=	'',
																							le.garage,
																							if(ri.category	=	'012',ri.material,'')
																						);
		self.heating											:=	if(	le.heating	!=	'',
																							le.heating,
																							if(ri.category	=	'001',ri.material,'')
																						);
		self.parking_type									:=	if(	le.parking_type	!=	'',
																							le.parking_type,
																							if(ri.category	=	'012',ri.material,'')
																						);
		self.roof_cover										:=	if(	le.roof_cover	!=	'',
																							le.roof_cover,
																							if(ri.category	=	'006',ri.material,'')
																						);
		self.foundation										:=	if(	le.foundation	!=	'',
																							le.foundation,
																							if(ri.category	=	'007',ri.material,'')
																						);
		self.floor_type										:=	if(	le.floor_type	!=	'',
																							le.floor_type,
																							if(ri.category	=	'003',ri.material,'')
																						);
		self.fuel_type										:=	if(	le.fuel_type	!=	'',
																							le.fuel_type,
																							if(ri.category	=	'001',ri.material,'')
																						);
		self															:=	le;
	end;
	
	dAppr_Map2Common	:=	denormalize(	distribute(dApprPrep2Common,PolicyID),
																			ApprIBCodesDedup,
																			left.PolicyID	=	right.PolicyID,
																			tAppr_Map2Common(left,right),
																			local
																		);
	
	PropertyCharacteristics.Functions.Mac_remove_Zeroes(dAppr_Map2Common,dAppr_Map2CommonCleaned);
	
	// Bring back to common layout
	export	Appr_Map2Common	:=	project(dAppr_Map2CommonCleaned,PropertyCharacteristics.Layouts.Common);

end;