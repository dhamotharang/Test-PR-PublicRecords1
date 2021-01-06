import PropertyCharacteristics,std,ut,PropertyFieldFillInByLA2,codes;

export fnGenerateBestofAllNoMLS(dataset(PropertyCharacteristics.Layouts.TempBase) BkKnight,
                           dataset(PropertyCharacteristics.Layouts.TempBase) CLogic):=function 

    PropertyCharacteristics.Layouts.TempBase tFilterInvalid(PropertyCharacteristics.Layouts.TempBase L):=TRANSFORM
		AdjustedArchiveDate:=Std.Date.AdjustCalendar(L.dt_vendor_last_reported,0,0,1);
        self.air_conditioning_type:=if(STD.STR.TOUPPERCASE(L.air_conditioning_type ) in ['UNK','YES','NON','PKG','OTH','PKR','PRT'],'',STD.STR.TOUPPERCASE(L.air_conditioning_type));
        self.air_conditioning_type_desc:=if(STD.STR.TOUPPERCASE(L.air_conditioning_type_desc ) in ['TYPE UNKNOWN','YES','NONE','PACKAGE','OTHER','PACKAGE ROOF','PARTIAL'],'',STD.STR.TOUPPERCASE(L.air_conditioning_type_desc));
        self.exterior_wall:=if(STD.STR.TOUPPERCASE(L.exterior_wall ) in ['UNK','OTH'],'',STD.STR.TOUPPERCASE(L.exterior_wall));
        self.exterior_wall_desc:=if(STD.STR.TOUPPERCASE(L.exterior_wall_desc ) in ['TYPE UNKNOWN','OTHER'],'',STD.STR.TOUPPERCASE(L.exterior_wall_desc));
        self.fireplace_type:=if(STD.STR.TOUPPERCASE(L.fireplace_type ) in ['UNK','0V0'],'',L.fireplace_type);
        self.fireplace_type_desc:=if(STD.STR.TOUPPERCASE(L.fireplace_type_desc ) in ['TYPE UNKNOWN','MASSIVE'],'',STD.STR.TOUPPERCASE(L.fireplace_type_desc));
		self.fireplace_ind:=if(self.fireplace_type_desc='','',if(STD.STR.TOUPPERCASE(self.fireplace_type_desc)='NONE','N','Y'));
        self.floor_type:=if(STD.STR.TOUPPERCASE(L.floor_type ) in ['UNK','OTH','COV'],'',STD.STR.TOUPPERCASE(L.floor_type));
        self.floor_type_desc:=if(STD.STR.TOUPPERCASE(L.floor_type_desc ) in ['TYPE UNKNOWN','OTHER','COVERED'],'',STD.STR.TOUPPERCASE(L.floor_type_desc));
        self.foundation:=if(STD.STR.TOUPPERCASE(L.foundation ) in ['UNK','OTH','STD'],'',STD.STR.TOUPPERCASE(L.foundation));
        self.foundation_desc:=if(STD.STR.TOUPPERCASE(L.foundation_desc ) in ['TYPE UNKNOWN','OTHER','STANDARD'],'',STD.STR.TOUPPERCASE(L.foundation_desc));
        self.garage:=if(STD.STR.TOUPPERCASE(L.garage ) in ['UD0','NON'],'',STD.STR.TOUPPERCASE(L.garage));
        self.garage_desc:=if(STD.STR.TOUPPERCASE(L.garage_desc ) in ['UNDEFINED TYPE','NONE'],'',STD.STR.TOUPPERCASE(L.garage_desc));
        self.heating:=if(STD.STR.TOUPPERCASE(L.heating ) in ['UNK','YES','NON','OTH'],'',L.heating);
        self.heating_desc:=if(STD.STR.TOUPPERCASE(L.heating_desc ) in ['TYPE UNKNOWN','YES','NONE','OTHER'],'',STD.STR.TOUPPERCASE(L.heating_desc));
        self.parking_type:=if(STD.STR.TOUPPERCASE(L.parking_type ) in ['UNK','UD0'],'',L.parking_type);
        self.parking_type_desc:=if(STD.STR.TOUPPERCASE(L.parking_type_desc ) in ['TYPE UNKNOWN','UNDEFINED TYPE'],'',STD.STR.TOUPPERCASE(L.parking_type_desc));
        self.pool_type:=if(STD.STR.TOUPPERCASE(L.pool_type ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.pool_type));
        self.pool_type_desc:=if(STD.STR.TOUPPERCASE(L.pool_type_desc ) in ['TYPE UNKNOWN'],'',STD.STR.TOUPPERCASE(L.pool_type_desc));
		self.pool_indicator:=if(self.pool_type_desc='','',if(STD.STR.TOUPPERCASE(self.pool_type_desc)='NONE','N','Y'));
        self.style_type:=if(STD.STR.TOUPPERCASE(L.style_type ) in ['UNK','OTH'],'',STD.STR.TOUPPERCASE(L.style_type));
        self.style_type_desc:=if(STD.STR.TOUPPERCASE(L.style_type_desc ) in ['TYPE UNKNOWN','OTHER'],'',STD.STR.TOUPPERCASE(L.style_type_desc));
        self.structure_quality:=if(STD.STR.TOUPPERCASE(L.structure_quality ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.structure_quality));
        self.structure_quality_desc:=if(STD.STR.TOUPPERCASE(L.structure_quality_desc ) in ['TYPE UNKNOWN'],'',STD.STR.TOUPPERCASE(L.structure_quality_desc));
        self.roof_cover:=if(STD.STR.TOUPPERCASE(L.roof_cover ) in ['UNK','OTH'],'',STD.STR.TOUPPERCASE(L.roof_cover));
        self.roof_cover_desc:=if(STD.STR.TOUPPERCASE(L.roof_cover_desc ) in ['TYPE UNKNOWN','OTHER'],'',STD.STR.TOUPPERCASE(L.roof_cover_desc));
        self.sewer:=if(STD.STR.TOUPPERCASE(L.sewer ) in ['UNK','NON'],'',STD.STR.TOUPPERCASE(L.sewer));
        self.sewer_desc:=if(STD.STR.TOUPPERCASE(L.sewer_desc ) in ['TYPE UNKNOWN','NONE'],'',STD.STR.TOUPPERCASE(L.sewer_desc));
        self.construction_type:=if(STD.STR.TOUPPERCASE(L.construction_type ) in ['NON','UNK'],'',STD.STR.TOUPPERCASE(L.construction_type));
        self.construction_type_desc:=if(STD.STR.TOUPPERCASE(L.construction_type_desc ) in ['NONE','TYPE UNKNOWN'],'',STD.STR.TOUPPERCASE(L.construction_type_desc));
        self.flood_zone_panel:=if(STD.STR.TOUPPERCASE(L.flood_zone_panel ) in ['UNK','OTH','LIG'],'',STD.STR.TOUPPERCASE(L.flood_zone_panel));
        self.stories_type:=if(STD.STR.TOUPPERCASE(L.stories_type ) in ['TYPE UNKNOWN','OTHER','LIGHT'],'',STD.STR.TOUPPERCASE(L.stories_type));
        self.census_tract:=if(STD.STR.TOUPPERCASE(L.census_tract ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.census_tract));
        self.lot_number:=if(STD.STR.TOUPPERCASE(L.lot_number ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.lot_number));
        self.water:=if(STD.STR.TOUPPERCASE(L.water ) in ['UNK','NON'],'',STD.STR.TOUPPERCASE(L.water));
		self.water_desc:=if(STD.STR.TOUPPERCASE(L.water_desc ) in ['TYPE UNKNOWN','NONE'],'',STD.STR.TOUPPERCASE(L.water_desc));
        self.frame_type:=if(STD.STR.TOUPPERCASE(L.frame_type ) in ['UNK','NON'],'',STD.STR.TOUPPERCASE(L.frame_type));
        self.frame_type_desc:=if(STD.STR.TOUPPERCASE(L.frame_type_desc ) in ['TYPE UNKNOWN','NONE'],'',STD.STR.TOUPPERCASE(L.frame_type_desc));
        self.assessment_document_number:=if(STD.STR.TOUPPERCASE(L.assessment_document_number ) in ['UNK','NON'],'',STD.STR.TOUPPERCASE(L.assessment_document_number));
        self.deed_document_number:=if(STD.STR.TOUPPERCASE(L.deed_document_number ) in ['TYPE UNKNOWN','NONE'],'',STD.STR.TOUPPERCASE(L.deed_document_number));
        self.sale_type_code:=if(STD.STR.TOUPPERCASE(L.sale_type_code ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.sale_type_code));
        self.interest_rate_type_code:=if(STD.STR.TOUPPERCASE(L.interest_rate_type_code ) in ['UNK','UND'],'',STD.STR.TOUPPERCASE(L.interest_rate_type_code));
        self.basement_finish:=if(STD.STR.TOUPPERCASE(L.basement_finish ) in ['UNK','NON'],'',STD.STR.TOUPPERCASE(L.basement_finish));
		self.basement_finish_desc:=if(STD.STR.TOUPPERCASE(L.basement_finish_desc ) in ['TYPE UNKNOWN','NONE'],'',STD.STR.TOUPPERCASE(L.basement_finish_desc));
        self.loan_type_code:=if(STD.STR.TOUPPERCASE(L.loan_type_code ) in ['UNK','UND'],'',STD.STR.TOUPPERCASE(L.loan_type_code));
		self.no_of_full_baths:=if(L.no_of_full_baths='' or (real)L.no_of_full_baths <1 or (real)L.no_of_full_baths >10,'',STD.STR.TOUPPERCASE(L.no_of_full_baths));
        self.no_of_half_baths:=if(L.no_of_half_baths='' or (real)L.no_of_half_baths <0 or (real)L.no_of_half_baths >5,'',STD.STR.TOUPPERCASE(L.no_of_half_baths));
        no_of_baths_round_one:=if(self.no_of_full_baths='' and self.no_of_half_baths='',L.no_of_baths,(string)((real)self.no_of_full_baths + (0.5*((real)self.no_of_half_baths))));
		self.no_of_baths:=if((real)no_of_baths_round_one<1 or (real)no_of_baths_round_one >10,'',no_of_baths_round_one);
        self.no_of_bedrooms:=if((real)L.no_of_bedrooms <1 or (real)L.no_of_bedrooms >10,'',STD.STR.TOUPPERCASE(L.no_of_bedrooms));
        self.building_square_footage:=if((real)L.building_square_footage <250 or (real)L.building_square_footage >26136000,'',STD.STR.TOUPPERCASE(L.building_square_footage));
        self.living_area_square_footage:=if((real)L.living_area_square_footage <250 or (real)L.living_area_square_footage >30000,'',STD.STR.TOUPPERCASE(L.living_area_square_footage));
        self.acres:=if((real)L.acres <0.0057 or (real)L.acres >600,'',STD.STR.TOUPPERCASE(L.acres));
		self.lot_size:=if((real)L.lot_size <250 or (real)L.lot_size >26136000,'',L.lot_size);
        self.no_of_stories:=if((real)L.no_of_stories <0 or (real)L.no_of_stories >100,'',STD.STR.TOUPPERCASE(L.no_of_stories));
        self.no_of_fireplaces:=if((real)L.no_of_fireplaces <0 or (real)L.no_of_fireplaces >11,'',STD.STR.TOUPPERCASE(L.no_of_fireplaces));
        self.no_of_rooms:=if((real)L.no_of_rooms <0 or (real)L.no_of_rooms >62,'',STD.STR.TOUPPERCASE(L.no_of_rooms));
        self.no_of_units:=if((real)L.no_of_units <0 or (real)L.no_of_units >101,'',STD.STR.TOUPPERCASE(L.no_of_units));
        self.sale_date:=if((unsigned4)L.sale_date <20001030 or (unsigned4)L.sale_date > AdjustedArchiveDate,'',L.sale_date);
        self.sale_amount:=if((real)L.sale_amount <1 or (real)L.sale_amount >100000000,'',STD.STR.TOUPPERCASE(L.sale_amount));
        self.tax_amount:=if((real)L.tax_amount <100 or (real)L.tax_amount >10000000,'',STD.STR.TOUPPERCASE(L.tax_amount));
        self.assessed_year:=if((unsigned4)L.assessed_year <1800 or (unsigned4)L.assessed_year >(unsigned4)(((string)AdjustedArchiveDate)[1..4]),'',STD.STR.TOUPPERCASE(L.assessed_year));
        self.year_built:=if((unsigned4)L.year_built <1800 or (unsigned4)L.year_built >(unsigned4)(((string)AdjustedArchiveDate)[1..4]),'',STD.STR.TOUPPERCASE(L.year_built));
        self.assessed_land_value:=if((real)L.assessed_land_value <100 or (real)L.assessed_land_value >2000000,'',STD.STR.TOUPPERCASE(L.assessed_land_value));
        self.assessment_recording_date:=if((unsigned4)L.assessment_recording_date <19900101 or (unsigned4)L.assessment_recording_date > AdjustedArchiveDate,'',L.assessment_recording_date);
        self.basement_square_footage:=if((real)L.basement_square_footage <50,'',STD.STR.TOUPPERCASE(L.basement_square_footage));
        self.deed_recording_date:=if((unsigned4)L.deed_recording_date <19900101 or (unsigned4)L.deed_recording_date > AdjustedArchiveDate,'',L.deed_recording_date);
        self.effective_year_built:=if((unsigned4)L.effective_year_built <1800 or (unsigned4)L.effective_year_built >(unsigned4)(((string)AdjustedArchiveDate)[1..4]),'',STD.STR.TOUPPERCASE(L.effective_year_built));
        self.first_floor_square_footage:=if((real)L.first_floor_square_footage <250 or (real)L.first_floor_square_footage >30000,'',STD.STR.TOUPPERCASE(L.first_floor_square_footage));
        self.garage_square_footage:=if((real)L.garage_square_footage <50 or (real)L.garage_square_footage >8000,'',STD.STR.TOUPPERCASE(L.garage_square_footage));
        self.improvement_value:=if((real)L.improvement_value <1000,'',STD.STR.TOUPPERCASE(L.improvement_value));
        self.loan_amount:=if((real)L.loan_amount <5000 or (real)L.loan_amount >20000000,'',STD.STR.TOUPPERCASE(L.loan_amount));
        self.lot_depth_footage:=if((real)L.lot_depth_footage <50 or (real)L.lot_depth_footage >20000000,'',STD.STR.TOUPPERCASE(L.lot_depth_footage));
        self.lot_front_footage:=if((real)L.lot_front_footage <15 or (real)L.lot_front_footage >10000,'',STD.STR.TOUPPERCASE(L.lot_front_footage));
        self.market_land_value:=if((real)L.market_land_value <100,'',STD.STR.TOUPPERCASE(L.market_land_value));
        self.no_of_bath_fixtures:=if((real)L.no_of_bath_fixtures <0 or (real)L.no_of_bath_fixtures >65,'',STD.STR.TOUPPERCASE(L.no_of_bath_fixtures));
        self.percent_improved:=if((real)L.percent_improved <0 or (real)L.percent_improved >414,0.0,L.percent_improved);
        self.second_loan_amount:=if((real)L.second_loan_amount <1000 or (real)L.second_loan_amount >1000000,'',STD.STR.TOUPPERCASE(L.second_loan_amount));
        self.tax_year:=if((unsigned4)L.tax_year <1800 or (unsigned4)L.tax_year >(unsigned4)(((string)AdjustedArchiveDate)[1..4]),'',STD.STR.TOUPPERCASE(L.tax_year));
        self.total_assessed_value:=if((real)L.total_assessed_value <100,'',STD.STR.TOUPPERCASE(L.total_assessed_value));
        self.total_calculated_value:=if((real)L.total_calculated_value <100,'',STD.STR.TOUPPERCASE(L.total_calculated_value));
        self.total_land_value:=if((real)L.total_land_value <100,'',STD.STR.TOUPPERCASE(L.total_land_value));
        self.total_market_value:=if((real)L.total_market_value <100,'',STD.STR.TOUPPERCASE(L.total_market_value));
        self:=L;
    END;


    FilteredBK:=project(BkKnight,tFilterInvalid(left));
    FilteredCL:=project(CLogic,tFilterInvalid(left));


    LoadBlackKnight:=project(FilteredBK,transform(PropertyCharacteristics.Layouts.TempSourceCompare,
        self.BlackKnight.dt_vendor_first_reported:=left.dt_vendor_first_reported;//first
		self.BlackKnight.dt_vendor_last_reported:=left.dt_vendor_last_reported;//last

		self.BlackKnight.property_rid:=left.property_rid;
		self.BlackKnight.tax_sortby_date:=left.tax_sortby_date;
		self.BlackKnight.deed_sortby_date:=left.deed_sortby_date;
		self.BlackKnight.building_square_footage:=left.building_square_footage;
		self.BlackKnight.src_building_square_footage:=left.src_building_square_footage;
		self.BlackKnight.tax_dt_building_square_footage:=left.tax_dt_building_square_footage;
		
		self.BlackKnight.air_conditioning_type:=left.air_conditioning_type;
		self.BlackKnight.air_conditioning_type_desc:=left.air_conditioning_type_desc;
		self.BlackKnight.src_air_conditioning_type:=left.src_air_conditioning_type;
		self.BlackKnight.tax_dt_air_conditioning_type:=left.tax_dt_air_conditioning_type;
		
		self.BlackKnight.basement_finish:=left.basement_finish;
		self.BlackKnight.basement_finish_desc:=left.basement_finish_desc;
		self.BlackKnight.src_basement_finish:=left.src_basement_finish;
		self.BlackKnight.tax_dt_basement_finish:=left.tax_dt_basement_finish;
		
		self.BlackKnight.construction_type:=left.construction_type;
		self.BlackKnight.construction_type_desc:=left.construction_type_desc;
		self.BlackKnight.src_construction_type:=left.src_construction_type;
		self.BlackKnight.tax_dt_construction_type:=left.tax_dt_construction_type;
		
		self.BlackKnight.exterior_wall:=left.exterior_wall;
		self.BlackKnight.exterior_wall_desc:=left.exterior_wall_desc;
		self.BlackKnight.src_exterior_wall:=left.src_exterior_wall;
		self.BlackKnight.tax_dt_exterior_wall:=left.tax_dt_exterior_wall;
		
		self.BlackKnight.fireplace_ind:=left.fireplace_ind;
		self.BlackKnight.src_fireplace_ind:=left.src_fireplace_ind;
		self.BlackKnight.tax_dt_fireplace_ind:=left.tax_dt_fireplace_ind;
		
		self.BlackKnight.fireplace_type:=left.fireplace_type;
		self.BlackKnight.fireplace_type_desc:=left.fireplace_type_desc;
		self.BlackKnight.src_fireplace_type:=left.src_fireplace_type;
		self.BlackKnight.tax_dt_fireplace_type:=left.tax_dt_fireplace_type;
		
		self.BlackKnight.flood_zone_panel:=left.flood_zone_panel;
		self.BlackKnight.src_flood_zone_panel:=left.src_flood_zone_panel;
		self.BlackKnight.tax_dt_flood_zone_panel:=left.tax_dt_flood_zone_panel;
		
		self.BlackKnight.garage:=left.garage;
		self.BlackKnight.garage_desc:=left.garage_desc;
		self.BlackKnight.src_garage:=left.src_garage;
		self.BlackKnight.tax_dt_garage:=left.tax_dt_garage;
		
		self.BlackKnight.first_floor_square_footage:=left.first_floor_square_footage;
		self.BlackKnight.src_first_floor_square_footage:=left.src_first_floor_square_footage;
		self.BlackKnight.tax_dt_first_floor_square_footage:=left.tax_dt_first_floor_square_footage;
		
		self.BlackKnight.heating:=left.heating;
		self.BlackKnight.heating_desc:=left.heating_desc;
		self.BlackKnight.src_heating:=left.src_heating;
		self.BlackKnight.tax_dt_heating:=left.tax_dt_heating;
		
		self.BlackKnight.living_area_square_footage:=left.living_area_square_footage;
		self.BlackKnight.src_living_area_square_footage:=left.src_living_area_square_footage;
		self.BlackKnight.tax_dt_living_area_square_footage:=left.tax_dt_living_area_square_footage;
		
		self.BlackKnight.no_of_baths:=left.no_of_baths;
		self.BlackKnight.src_no_of_baths:=left.src_no_of_baths;
		self.BlackKnight.tax_dt_no_of_baths:=left.tax_dt_no_of_baths;
		
		self.BlackKnight.no_of_bedrooms:=left.no_of_bedrooms;
		self.BlackKnight.src_no_of_bedrooms:=left.src_no_of_bedrooms;
		self.BlackKnight.tax_dt_no_of_bedrooms:=left.tax_dt_no_of_bedrooms;
		
		self.BlackKnight.no_of_fireplaces:=left.no_of_fireplaces;
		self.BlackKnight.src_no_of_fireplaces:=left.src_no_of_fireplaces;
		self.BlackKnight.tax_dt_no_of_fireplaces:=left.tax_dt_no_of_fireplaces;
		
		self.BlackKnight.no_of_full_baths:=left.no_of_full_baths;
		self.BlackKnight.src_no_of_full_baths:=left.src_no_of_full_baths;
		self.BlackKnight.tax_dt_no_of_full_baths:=left.tax_dt_no_of_full_baths;
		
		self.BlackKnight.no_of_half_baths:=left.no_of_half_baths;
		self.BlackKnight.src_no_of_half_baths:=left.src_no_of_half_baths;
		self.BlackKnight.tax_dt_no_of_half_baths:=left.tax_dt_no_of_half_baths;
		
		self.BlackKnight.no_of_stories:=left.no_of_stories;
		self.BlackKnight.src_no_of_stories:=left.src_no_of_stories;
		self.BlackKnight.tax_dt_no_of_stories:=left.tax_dt_no_of_stories;
		
		self.BlackKnight.parking_type:=left.parking_type;
		self.BlackKnight.parking_type_desc:=left.parking_type_desc;
		self.BlackKnight.src_parking_type:=left.src_parking_type;
		self.BlackKnight.tax_dt_parking_type:=left.tax_dt_parking_type;
		
		self.BlackKnight.pool_indicator:=left.pool_indicator;
		self.BlackKnight.src_pool_indicator:=left.src_pool_indicator;
		self.BlackKnight.tax_dt_pool_indicator:=left.tax_dt_pool_indicator;
		
		self.BlackKnight.pool_type:=left.pool_type;
		self.BlackKnight.pool_type_desc:=left.pool_type_desc;
		self.BlackKnight.src_pool_type:=left.src_pool_type;
		self.BlackKnight.tax_dt_pool_type:=left.tax_dt_pool_type;
		
		self.BlackKnight.roof_cover:=left.roof_cover;
		self.BlackKnight.roof_cover_desc:=left.roof_cover_desc;
		self.BlackKnight.src_roof_cover:=left.src_roof_cover;
		self.BlackKnight.tax_dt_roof_cover:=left.tax_dt_roof_cover;
		
		self.BlackKnight.roof_type:=left.roof_type;
		self.BlackKnight.roof_type_desc:=left.roof_type_desc;
		self.BlackKnight.src_roof_type:=left.src_roof_type;
		self.BlackKnight.tax_dt_roof_type:=left.tax_dt_roof_type;
		
		self.BlackKnight.year_built:=left.year_built;
		self.BlackKnight.src_year_built:=left.src_year_built;
		self.BlackKnight.tax_dt_year_built:=left.tax_dt_year_built;
		
		self.BlackKnight.foundation:=left.foundation;
		self.BlackKnight.foundation_desc:=left.foundation_desc;
		self.BlackKnight.src_foundation:=left.src_foundation;
		self.BlackKnight.tax_dt_foundation:=left.tax_dt_foundation;
		
		self.BlackKnight.basement_square_footage:=left.basement_square_footage;
		self.BlackKnight.src_basement_square_footage:=left.src_basement_square_footage;
		self.BlackKnight.tax_dt_basement_square_footage:=left.tax_dt_basement_square_footage;
		
		self.BlackKnight.effective_year_built:=left.effective_year_built;
		self.BlackKnight.src_effective_year_built:=left.src_effective_year_built;
		self.BlackKnight.tax_dt_effective_year_built:=left.tax_dt_effective_year_built;
		
		self.BlackKnight.garage_square_footage:=left.garage_square_footage;
		self.BlackKnight.src_garage_square_footage:=left.src_garage_square_footage;
		self.BlackKnight.tax_dt_garage_square_footage:=left.tax_dt_garage_square_footage;
		
		self.BlackKnight.stories_type:=left.stories_type;
		self.BlackKnight.stories_type_desc:=left.stories_type_desc;
		self.BlackKnight.src_stories_type:=left.src_stories_type;
		self.BlackKnight.tax_dt_stories_type:=left.tax_dt_stories_type;
		
		self.BlackKnight.apn_number:=left.apn_number;
		self.BlackKnight.src_apn_number:=left.src_apn_number;
		self.BlackKnight.tax_dt_apn_number:=left.tax_dt_apn_number;
		
		self.BlackKnight.census_tract:=left.census_tract;
		self.BlackKnight.src_census_tract:=left.src_census_tract;
		self.BlackKnight.tax_dt_census_tract:=left.tax_dt_census_tract;
		
		self.BlackKnight.range:=left.range;
		self.BlackKnight.src_range:=left.src_range;
		self.BlackKnight.tax_dt_range:=left.tax_dt_range;
		
		self.BlackKnight.zoning:=left.zoning;
		self.BlackKnight.src_zoning:=left.src_zoning;
		self.BlackKnight.tax_dt_zoning:=left.tax_dt_zoning;
		
		self.BlackKnight.block_number:=left.block_number;
		self.BlackKnight.src_block_number:=left.src_block_number;
		self.BlackKnight.tax_dt_block_number:=left.tax_dt_block_number;
		
		self.BlackKnight.county_name:=left.county_name;
		self.BlackKnight.src_county_name:=left.src_county_name;
		self.BlackKnight.tax_dt_county_name:=left.tax_dt_county_name;
		
		self.BlackKnight.fips_code:=left.fips_code;
		self.BlackKnight.src_fips_code:=left.src_fips_code;
		self.BlackKnight.tax_dt_fips_code:=left.tax_dt_fips_code;
		
		self.BlackKnight.subdivision:=left.subdivision;
		self.BlackKnight.src_subdivision:=left.src_subdivision;
		self.BlackKnight.tax_dt_subdivision:=left.tax_dt_subdivision;
		
		self.BlackKnight.municipality:=left.municipality;
		self.BlackKnight.src_municipality:=left.src_municipality;
		self.BlackKnight.tax_dt_municipality:=left.tax_dt_municipality;
		
		self.BlackKnight.township:=left.township;
		self.BlackKnight.src_township:=left.src_township;
		self.BlackKnight.tax_dt_township:=left.tax_dt_township;
		
		self.BlackKnight.homestead_exemption_ind:=left.homestead_exemption_ind;
		self.BlackKnight.src_homestead_exemption_ind:=left.src_homestead_exemption_ind;
		self.BlackKnight.tax_dt_homestead_exemption_ind:=left.tax_dt_homestead_exemption_ind;
		
		self.BlackKnight.land_use_code:=left.land_use_code;
		self.BlackKnight.src_land_use_code:=left.src_land_use_code;
		self.BlackKnight.tax_dt_land_use_code:=left.tax_dt_land_use_code;
		
		self.BlackKnight.latitude:=left.latitude;
		self.BlackKnight.src_latitude:=left.src_latitude;
		self.BlackKnight.tax_dt_latitude:=left.tax_dt_latitude;
		
		self.BlackKnight.longitude:=left.longitude;
		self.BlackKnight.src_longitude:=left.src_longitude;
		self.BlackKnight.tax_dt_longitude:=left.tax_dt_longitude;
		
		self.BlackKnight.location_influence_code:=left.location_influence_code;
		self.BlackKnight.location_influence_desc:=left.location_influence_desc;
		self.BlackKnight.src_location_influence_code:=left.src_location_influence_code;
		self.BlackKnight.tax_dt_location_influence_code:=left.tax_dt_location_influence_code;
		
		self.BlackKnight.acres:=left.acres;
		self.BlackKnight.src_acres:=left.src_acres;
		self.BlackKnight.tax_dt_acres:=left.tax_dt_acres;
		
		self.BlackKnight.lot_depth_footage:=left.lot_depth_footage;
		self.BlackKnight.src_lot_depth_footage:=left.src_lot_depth_footage;
		self.BlackKnight.tax_dt_lot_depth_footage:=left.tax_dt_lot_depth_footage;
		
		self.BlackKnight.lot_front_footage:=left.lot_front_footage;
		self.BlackKnight.src_lot_front_footage:=left.src_lot_front_footage;
		self.BlackKnight.tax_dt_lot_front_footage:=left.tax_dt_lot_front_footage;
		
		self.BlackKnight.lot_number:=left.lot_number;
		self.BlackKnight.src_lot_number:=left.src_lot_number;
		self.BlackKnight.tax_dt_lot_number:=left.tax_dt_lot_number;
		
		self.BlackKnight.lot_size:=left.lot_size;
		self.BlackKnight.src_lot_size:=left.src_lot_size;
		self.BlackKnight.tax_dt_lot_size:=left.tax_dt_lot_size;
		
		self.BlackKnight.property_type_code:=left.property_type_code;
		self.BlackKnight.property_type_desc:=left.property_type_desc;
		self.BlackKnight.src_property_type_code:=left.src_property_type_code;
		self.BlackKnight.tax_dt_property_type_code:=left.tax_dt_property_type_code;
		
		self.BlackKnight.structure_quality:=left.structure_quality;
		self.BlackKnight.structure_quality_desc:=left.structure_quality_desc;
		self.BlackKnight.src_structure_quality:=left.src_structure_quality;
		self.BlackKnight.tax_dt_structure_quality:=left.tax_dt_structure_quality;
		
		self.BlackKnight.water:=left.water;
		self.BlackKnight.water_desc:=left.water_desc;
		self.BlackKnight.src_water:=left.src_water;
		self.BlackKnight.tax_dt_water:=left.tax_dt_water;
		
		self.BlackKnight.sewer:=left.sewer;
		self.BlackKnight.sewer_desc:=left.sewer_desc;
		self.BlackKnight.src_sewer:=left.src_sewer;
		self.BlackKnight.tax_dt_sewer:=left.tax_dt_sewer;
		
		self.BlackKnight.assessed_land_value:=left.assessed_land_value;
		self.BlackKnight.src_assessed_land_value:=left.src_assessed_land_value;
		self.BlackKnight.tax_dt_assessed_land_value:=left.tax_dt_assessed_land_value;
		
		self.BlackKnight.assessed_year:=left.assessed_year;
		self.BlackKnight.src_assessed_year:=left.src_assessed_year;
		self.BlackKnight.tax_dt_assessed_year:=left.tax_dt_assessed_year;
		
		self.BlackKnight.tax_amount:=left.tax_amount;
		self.BlackKnight.src_tax_amount:=left.src_tax_amount;
		self.BlackKnight.tax_dt_tax_amount:=left.tax_dt_tax_amount;
		
		self.BlackKnight.tax_year:=left.tax_year;
		self.BlackKnight.src_tax_year:=left.src_tax_year;
		
		self.BlackKnight.market_land_value:=left.market_land_value;
		self.BlackKnight.src_market_land_value:=left.src_market_land_value;
		self.BlackKnight.tax_dt_market_land_value:=left.tax_dt_market_land_value;
		
		self.BlackKnight.improvement_value:=left.improvement_value;
		self.BlackKnight.src_improvement_value:=left.src_improvement_value;
		self.BlackKnight.tax_dt_improvement_value:=left.tax_dt_improvement_value;
		
		self.BlackKnight.percent_improved:=left.percent_improved;
		self.BlackKnight.src_percent_improved:=left.src_percent_improved;
		self.BlackKnight.tax_dt_percent_improved:=left.tax_dt_percent_improved;
		
		self.BlackKnight.total_assessed_value:=left.total_assessed_value;
		self.BlackKnight.src_total_assessed_value:=left.src_total_assessed_value;
		self.BlackKnight.tax_dt_total_assessed_value:=left.tax_dt_total_assessed_value;
		
		self.BlackKnight.total_calculated_value:=left.total_calculated_value;
		self.BlackKnight.src_total_calculated_value:=left.src_total_calculated_value;
		self.BlackKnight.tax_dt_total_calculated_value:=left.tax_dt_total_calculated_value;
		
		self.BlackKnight.total_land_value:=left.total_land_value;
		self.BlackKnight.src_total_land_value:=left.src_total_land_value;
		self.BlackKnight.tax_dt_total_land_value:=left.tax_dt_total_land_value;
		
		self.BlackKnight.total_market_value:=left.total_market_value;
		self.BlackKnight.src_total_market_value:=left.src_total_market_value;
		self.BlackKnight.tax_dt_total_market_value:=left.tax_dt_total_market_value;
		
		self.BlackKnight.floor_type:=left.floor_type;
		self.BlackKnight.floor_type_desc:=left.floor_type_desc;
		self.BlackKnight.src_floor_type:=left.src_floor_type;
		self.BlackKnight.tax_dt_floor_type:=left.tax_dt_floor_type;
		
		self.BlackKnight.frame_type:=left.frame_type;
		self.BlackKnight.frame_type_desc:=left.frame_type_desc;
		self.BlackKnight.src_frame_type:=left.src_frame_type;
		self.BlackKnight.tax_dt_frame_type:=left.tax_dt_frame_type;
		
		self.BlackKnight.fuel_type:=left.fuel_type;
		self.BlackKnight.fuel_type_desc:=left.fuel_type_desc;
		self.BlackKnight.src_fuel_type:=left.src_fuel_type;
		self.BlackKnight.tax_dt_fuel_type:=left.tax_dt_fuel_type;
		
		self.BlackKnight.no_of_bath_fixtures:=left.no_of_bath_fixtures;
		self.BlackKnight.src_no_of_bath_fixtures:=left.src_no_of_bath_fixtures;
		self.BlackKnight.tax_dt_no_of_bath_fixtures:=left.tax_dt_no_of_bath_fixtures;
		
		self.BlackKnight.no_of_rooms:=left.no_of_rooms;
		self.BlackKnight.src_no_of_rooms:=left.src_no_of_rooms;
		self.BlackKnight.tax_dt_no_of_rooms:=left.tax_dt_no_of_rooms;
		
		self.BlackKnight.no_of_units:=left.no_of_units;
		self.BlackKnight.src_no_of_units:=left.src_no_of_units;
		self.BlackKnight.tax_dt_no_of_units:=left.tax_dt_no_of_units;
		
		self.BlackKnight.style_type:=left.style_type;
		self.BlackKnight.style_type_desc:=left.style_type_desc;
		self.BlackKnight.src_style_type:=left.src_style_type;
		self.BlackKnight.tax_dt_style_type:=left.tax_dt_style_type;
		
		self.BlackKnight.assessment_document_number:=left.assessment_document_number;
		self.BlackKnight.src_assessment_document_number:=left.src_assessment_document_number;
		self.BlackKnight.tax_dt_assessment_document_number:=left.tax_dt_assessment_document_number;
		
		self.BlackKnight.assessment_recording_date:=left.assessment_recording_date;
		self.BlackKnight.src_assessment_recording_date:=left.src_assessment_recording_date;
		self.BlackKnight.tax_dt_assessment_recording_date:=left.tax_dt_assessment_recording_date;
		
		self.BlackKnight.deed_document_number:=left.deed_document_number;
		self.BlackKnight.src_deed_document_number:=left.src_deed_document_number;
		self.BlackKnight.rec_dt_deed_document_number:=left.rec_dt_deed_document_number;
		
		self.BlackKnight.deed_recording_date:=left.deed_recording_date;
		self.BlackKnight.src_deed_recording_date:=left.src_deed_recording_date;
		
		self.BlackKnight.full_part_sale:=left.full_part_sale;
		self.BlackKnight.src_full_part_sale:=left.src_full_part_sale;
		self.BlackKnight.rec_dt_full_part_sale:=left.rec_dt_full_part_sale;
		
		self.BlackKnight.sale_amount:=left.sale_amount;
		self.BlackKnight.src_sale_amount:=left.src_sale_amount;
		self.BlackKnight.rec_dt_sale_amount:=left.rec_dt_sale_amount;
		
		self.BlackKnight.sale_date:=left.sale_date;
		self.BlackKnight.src_sale_date:=left.src_sale_date;
		self.BlackKnight.rec_dt_sale_date:=left.rec_dt_sale_date;
		
		self.BlackKnight.sale_type_code:=left.sale_type_code;
		self.BlackKnight.src_sale_type_code:=left.src_sale_type_code;
		self.BlackKnight.rec_dt_sale_type_code:=left.rec_dt_sale_type_code;
		
		self.BlackKnight.mortgage_company_name:=left.mortgage_company_name;
		self.BlackKnight.src_mortgage_company_name:=left.src_mortgage_company_name;
		self.BlackKnight.rec_dt_mortgage_company_name:=left.rec_dt_mortgage_company_name;
		
		self.BlackKnight.loan_amount:=left.loan_amount;
		self.BlackKnight.src_loan_amount:=left.src_loan_amount;
		self.BlackKnight.rec_dt_loan_amount:=left.rec_dt_loan_amount;
		
		self.BlackKnight.second_loan_amount:=left.second_loan_amount;
		self.BlackKnight.src_second_loan_amount:=left.src_second_loan_amount;
		self.BlackKnight.rec_dt_second_loan_amount:=left.rec_dt_second_loan_amount;
		
		self.BlackKnight.loan_type_code:=left.loan_type_code;
		self.BlackKnight.src_loan_type_code:=left.src_loan_type_code;
		self.BlackKnight.rec_dt_loan_type_code:=left.rec_dt_loan_type_code;
		
		self.BlackKnight.interest_rate_type_code:=left.interest_rate_type_code;
		self.BlackKnight.src_interest_rate_type_code:=left.src_interest_rate_type_code;
		self.BlackKnight.rec_dt_interest_rate_type_code:=left.rec_dt_interest_rate_type_code;
        Self:=Left;
        Self:=[];
    ));

    LoadCoreLogic:=project(FilteredCL,transform(PropertyCharacteristics.Layouts.TempSourceCompare,
        self.CoreLogic.dt_vendor_first_reported:=left.dt_vendor_first_reported;//first
		self.CoreLogic.dt_vendor_last_reported:=left.dt_vendor_last_reported;//last

		self.CoreLogic.property_rid:=left.property_rid;
		self.CoreLogic.tax_sortby_date:=left.tax_sortby_date;
		self.CoreLogic.deed_sortby_date:=left.deed_sortby_date;
		self.CoreLogic.building_square_footage:=left.building_square_footage;
		self.CoreLogic.src_building_square_footage:=left.src_building_square_footage;
		self.CoreLogic.tax_dt_building_square_footage:=left.tax_dt_building_square_footage;
		
		self.CoreLogic.air_conditioning_type:=left.air_conditioning_type;
		self.CoreLogic.air_conditioning_type_desc:=left.air_conditioning_type_desc;
		self.CoreLogic.src_air_conditioning_type:=left.src_air_conditioning_type;
		self.CoreLogic.tax_dt_air_conditioning_type:=left.tax_dt_air_conditioning_type;
		
		self.CoreLogic.basement_finish:=left.basement_finish;
		self.CoreLogic.basement_finish_desc:=left.basement_finish_desc;
		self.CoreLogic.src_basement_finish:=left.src_basement_finish;
		self.CoreLogic.tax_dt_basement_finish:=left.tax_dt_basement_finish;
		
		self.CoreLogic.construction_type:=left.construction_type;
		self.CoreLogic.construction_type_desc:=left.construction_type_desc;
		self.CoreLogic.src_construction_type:=left.src_construction_type;
		self.CoreLogic.tax_dt_construction_type:=left.tax_dt_construction_type;
		
		self.CoreLogic.exterior_wall:=left.exterior_wall;
		self.CoreLogic.exterior_wall_desc:=left.exterior_wall_desc;
		self.CoreLogic.src_exterior_wall:=left.src_exterior_wall;
		self.CoreLogic.tax_dt_exterior_wall:=left.tax_dt_exterior_wall;
		
		self.CoreLogic.fireplace_ind:=left.fireplace_ind;
		self.CoreLogic.src_fireplace_ind:=left.src_fireplace_ind;
		self.CoreLogic.tax_dt_fireplace_ind:=left.tax_dt_fireplace_ind;
		
		self.CoreLogic.fireplace_type:=left.fireplace_type;
		self.CoreLogic.fireplace_type_desc:=left.fireplace_type_desc;
		self.CoreLogic.src_fireplace_type:=left.src_fireplace_type;
		self.CoreLogic.tax_dt_fireplace_type:=left.tax_dt_fireplace_type;
		
		self.CoreLogic.flood_zone_panel:=left.flood_zone_panel;
		self.CoreLogic.src_flood_zone_panel:=left.src_flood_zone_panel;
		self.CoreLogic.tax_dt_flood_zone_panel:=left.tax_dt_flood_zone_panel;
		
		self.CoreLogic.garage:=left.garage;
		self.CoreLogic.garage_desc:=left.garage_desc;
		self.CoreLogic.src_garage:=left.src_garage;
		self.CoreLogic.tax_dt_garage:=left.tax_dt_garage;
		
		self.CoreLogic.first_floor_square_footage:=left.first_floor_square_footage;
		self.CoreLogic.src_first_floor_square_footage:=left.src_first_floor_square_footage;
		self.CoreLogic.tax_dt_first_floor_square_footage:=left.tax_dt_first_floor_square_footage;
		
		self.CoreLogic.heating:=left.heating;
		self.CoreLogic.heating_desc:=left.heating_desc;
		self.CoreLogic.src_heating:=left.src_heating;
		self.CoreLogic.tax_dt_heating:=left.tax_dt_heating;
		
		self.CoreLogic.living_area_square_footage:=left.living_area_square_footage;
		self.CoreLogic.src_living_area_square_footage:=left.src_living_area_square_footage;
		self.CoreLogic.tax_dt_living_area_square_footage:=left.tax_dt_living_area_square_footage;
		
		self.CoreLogic.no_of_baths:=left.no_of_baths;
		self.CoreLogic.src_no_of_baths:=left.src_no_of_baths;
		self.CoreLogic.tax_dt_no_of_baths:=left.tax_dt_no_of_baths;
		
		self.CoreLogic.no_of_bedrooms:=left.no_of_bedrooms;
		self.CoreLogic.src_no_of_bedrooms:=left.src_no_of_bedrooms;
		self.CoreLogic.tax_dt_no_of_bedrooms:=left.tax_dt_no_of_bedrooms;
		
		self.CoreLogic.no_of_fireplaces:=left.no_of_fireplaces;
		self.CoreLogic.src_no_of_fireplaces:=left.src_no_of_fireplaces;
		self.CoreLogic.tax_dt_no_of_fireplaces:=left.tax_dt_no_of_fireplaces;
		
		self.CoreLogic.no_of_full_baths:=left.no_of_full_baths;
		self.CoreLogic.src_no_of_full_baths:=left.src_no_of_full_baths;
		self.CoreLogic.tax_dt_no_of_full_baths:=left.tax_dt_no_of_full_baths;
		
		self.CoreLogic.no_of_half_baths:=left.no_of_half_baths;
		self.CoreLogic.src_no_of_half_baths:=left.src_no_of_half_baths;
		self.CoreLogic.tax_dt_no_of_half_baths:=left.tax_dt_no_of_half_baths;
		
		self.CoreLogic.no_of_stories:=left.no_of_stories;
		self.CoreLogic.src_no_of_stories:=left.src_no_of_stories;
		self.CoreLogic.tax_dt_no_of_stories:=left.tax_dt_no_of_stories;
		
		self.CoreLogic.parking_type:=left.parking_type;
		self.CoreLogic.parking_type_desc:=left.parking_type_desc;
		self.CoreLogic.src_parking_type:=left.src_parking_type;
		self.CoreLogic.tax_dt_parking_type:=left.tax_dt_parking_type;
		
		self.CoreLogic.pool_indicator:=left.pool_indicator;
		self.CoreLogic.src_pool_indicator:=left.src_pool_indicator;
		self.CoreLogic.tax_dt_pool_indicator:=left.tax_dt_pool_indicator;
		
		self.CoreLogic.pool_type:=left.pool_type;
		self.CoreLogic.pool_type_desc:=left.pool_type_desc;
		self.CoreLogic.src_pool_type:=left.src_pool_type;
		self.CoreLogic.tax_dt_pool_type:=left.tax_dt_pool_type;
		
		self.CoreLogic.roof_cover:=left.roof_cover;
		self.CoreLogic.roof_cover_desc:=left.roof_cover_desc;
		self.CoreLogic.src_roof_cover:=left.src_roof_cover;
		self.CoreLogic.tax_dt_roof_cover:=left.tax_dt_roof_cover;
		
		self.CoreLogic.roof_type:=left.roof_type;
		self.CoreLogic.roof_type_desc:=left.roof_type_desc;
		self.CoreLogic.src_roof_type:=left.src_roof_type;
		self.CoreLogic.tax_dt_roof_type:=left.tax_dt_roof_type;
		
		self.CoreLogic.year_built:=left.year_built;
		self.CoreLogic.src_year_built:=left.src_year_built;
		self.CoreLogic.tax_dt_year_built:=left.tax_dt_year_built;
		
		self.CoreLogic.foundation:=left.foundation;
		self.CoreLogic.foundation_desc:=left.foundation_desc;
		self.CoreLogic.src_foundation:=left.src_foundation;
		self.CoreLogic.tax_dt_foundation:=left.tax_dt_foundation;
		
		self.CoreLogic.basement_square_footage:=left.basement_square_footage;
		self.CoreLogic.src_basement_square_footage:=left.src_basement_square_footage;
		self.CoreLogic.tax_dt_basement_square_footage:=left.tax_dt_basement_square_footage;
		
		self.CoreLogic.effective_year_built:=left.effective_year_built;
		self.CoreLogic.src_effective_year_built:=left.src_effective_year_built;
		self.CoreLogic.tax_dt_effective_year_built:=left.tax_dt_effective_year_built;
		
		self.CoreLogic.garage_square_footage:=left.garage_square_footage;
		self.CoreLogic.src_garage_square_footage:=left.src_garage_square_footage;
		self.CoreLogic.tax_dt_garage_square_footage:=left.tax_dt_garage_square_footage;
		
		self.CoreLogic.stories_type:=left.stories_type;
		self.CoreLogic.stories_type_desc:=left.stories_type_desc;
		self.CoreLogic.src_stories_type:=left.src_stories_type;
		self.CoreLogic.tax_dt_stories_type:=left.tax_dt_stories_type;
		
		self.CoreLogic.apn_number:=left.apn_number;
		self.CoreLogic.src_apn_number:=left.src_apn_number;
		self.CoreLogic.tax_dt_apn_number:=left.tax_dt_apn_number;
		
		self.CoreLogic.census_tract:=left.census_tract;
		self.CoreLogic.src_census_tract:=left.src_census_tract;
		self.CoreLogic.tax_dt_census_tract:=left.tax_dt_census_tract;
		
		self.CoreLogic.range:=left.range;
		self.CoreLogic.src_range:=left.src_range;
		self.CoreLogic.tax_dt_range:=left.tax_dt_range;
		
		self.CoreLogic.zoning:=left.zoning;
		self.CoreLogic.src_zoning:=left.src_zoning;
		self.CoreLogic.tax_dt_zoning:=left.tax_dt_zoning;
		
		self.CoreLogic.block_number:=left.block_number;
		self.CoreLogic.src_block_number:=left.src_block_number;
		self.CoreLogic.tax_dt_block_number:=left.tax_dt_block_number;
		
		self.CoreLogic.county_name:=left.county_name;
		self.CoreLogic.src_county_name:=left.src_county_name;
		self.CoreLogic.tax_dt_county_name:=left.tax_dt_county_name;
		
		self.CoreLogic.fips_code:=left.fips_code;
		self.CoreLogic.src_fips_code:=left.src_fips_code;
		self.CoreLogic.tax_dt_fips_code:=left.tax_dt_fips_code;
		
		self.CoreLogic.subdivision:=left.subdivision;
		self.CoreLogic.src_subdivision:=left.src_subdivision;
		self.CoreLogic.tax_dt_subdivision:=left.tax_dt_subdivision;
		
		self.CoreLogic.municipality:=left.municipality;
		self.CoreLogic.src_municipality:=left.src_municipality;
		self.CoreLogic.tax_dt_municipality:=left.tax_dt_municipality;
		
		self.CoreLogic.township:=left.township;
		self.CoreLogic.src_township:=left.src_township;
		self.CoreLogic.tax_dt_township:=left.tax_dt_township;
		
		self.CoreLogic.homestead_exemption_ind:=left.homestead_exemption_ind;
		self.CoreLogic.src_homestead_exemption_ind:=left.src_homestead_exemption_ind;
		self.CoreLogic.tax_dt_homestead_exemption_ind:=left.tax_dt_homestead_exemption_ind;
		
		self.CoreLogic.land_use_code:=left.land_use_code;
		self.CoreLogic.src_land_use_code:=left.src_land_use_code;
		self.CoreLogic.tax_dt_land_use_code:=left.tax_dt_land_use_code;
		
		self.CoreLogic.latitude:=left.latitude;
		self.CoreLogic.src_latitude:=left.src_latitude;
		self.CoreLogic.tax_dt_latitude:=left.tax_dt_latitude;
		
		self.CoreLogic.longitude:=left.longitude;
		self.CoreLogic.src_longitude:=left.src_longitude;
		self.CoreLogic.tax_dt_longitude:=left.tax_dt_longitude;
		
		self.CoreLogic.location_influence_code:=left.location_influence_code;
		self.CoreLogic.location_influence_desc:=left.location_influence_desc;
		self.CoreLogic.src_location_influence_code:=left.src_location_influence_code;
		self.CoreLogic.tax_dt_location_influence_code:=left.tax_dt_location_influence_code;
		
		self.CoreLogic.acres:=left.acres;
		self.CoreLogic.src_acres:=left.src_acres;
		self.CoreLogic.tax_dt_acres:=left.tax_dt_acres;
		
		self.CoreLogic.lot_depth_footage:=left.lot_depth_footage;
		self.CoreLogic.src_lot_depth_footage:=left.src_lot_depth_footage;
		self.CoreLogic.tax_dt_lot_depth_footage:=left.tax_dt_lot_depth_footage;
		
		self.CoreLogic.lot_front_footage:=left.lot_front_footage;
		self.CoreLogic.src_lot_front_footage:=left.src_lot_front_footage;
		self.CoreLogic.tax_dt_lot_front_footage:=left.tax_dt_lot_front_footage;
		
		self.CoreLogic.lot_number:=left.lot_number;
		self.CoreLogic.src_lot_number:=left.src_lot_number;
		self.CoreLogic.tax_dt_lot_number:=left.tax_dt_lot_number;
		
		self.CoreLogic.lot_size:=left.lot_size;
		self.CoreLogic.src_lot_size:=left.src_lot_size;
		self.CoreLogic.tax_dt_lot_size:=left.tax_dt_lot_size;
		
		self.CoreLogic.property_type_code:=left.property_type_code;
		self.CoreLogic.property_type_desc:=left.property_type_desc;
		self.CoreLogic.src_property_type_code:=left.src_property_type_code;
		self.CoreLogic.tax_dt_property_type_code:=left.tax_dt_property_type_code;
		
		self.CoreLogic.structure_quality:=left.structure_quality;
		self.CoreLogic.structure_quality_desc:=left.structure_quality_desc;
		self.CoreLogic.src_structure_quality:=left.src_structure_quality;
		self.CoreLogic.tax_dt_structure_quality:=left.tax_dt_structure_quality;
		
		self.CoreLogic.water:=left.water;
		self.CoreLogic.water_desc:=left.water_desc;
		self.CoreLogic.src_water:=left.src_water;
		self.CoreLogic.tax_dt_water:=left.tax_dt_water;
		
		self.CoreLogic.sewer:=left.sewer;
		self.CoreLogic.sewer_desc:=left.sewer_desc;
		self.CoreLogic.src_sewer:=left.src_sewer;
		self.CoreLogic.tax_dt_sewer:=left.tax_dt_sewer;
		
		self.CoreLogic.assessed_land_value:=left.assessed_land_value;
		self.CoreLogic.src_assessed_land_value:=left.src_assessed_land_value;
		self.CoreLogic.tax_dt_assessed_land_value:=left.tax_dt_assessed_land_value;
		
		self.CoreLogic.assessed_year:=left.assessed_year;
		self.CoreLogic.src_assessed_year:=left.src_assessed_year;
		self.CoreLogic.tax_dt_assessed_year:=left.tax_dt_assessed_year;
		
		self.CoreLogic.tax_amount:=left.tax_amount;
		self.CoreLogic.src_tax_amount:=left.src_tax_amount;
		self.CoreLogic.tax_dt_tax_amount:=left.tax_dt_tax_amount;
		
		self.CoreLogic.tax_year:=left.tax_year;
		self.CoreLogic.src_tax_year:=left.src_tax_year;
		
		self.CoreLogic.market_land_value:=left.market_land_value;
		self.CoreLogic.src_market_land_value:=left.src_market_land_value;
		self.CoreLogic.tax_dt_market_land_value:=left.tax_dt_market_land_value;
		
		self.CoreLogic.improvement_value:=left.improvement_value;
		self.CoreLogic.src_improvement_value:=left.src_improvement_value;
		self.CoreLogic.tax_dt_improvement_value:=left.tax_dt_improvement_value;
		
		self.Corelogic.percent_improved:=left.percent_improved;
		self.CoreLogic.src_percent_improved:=left.src_percent_improved;
		self.CoreLogic.tax_dt_percent_improved:=left.tax_dt_percent_improved;
		
		self.CoreLogic.total_assessed_value:=left.total_assessed_value;
		self.CoreLogic.src_total_assessed_value:=left.src_total_assessed_value;
		self.CoreLogic.tax_dt_total_assessed_value:=left.tax_dt_total_assessed_value;
		
		self.CoreLogic.total_calculated_value:=left.total_calculated_value;
		self.CoreLogic.src_total_calculated_value:=left.src_total_calculated_value;
		self.CoreLogic.tax_dt_total_calculated_value:=left.tax_dt_total_calculated_value;
		
		self.CoreLogic.total_land_value:=left.total_land_value;
		self.CoreLogic.src_total_land_value:=left.src_total_land_value;
		self.CoreLogic.tax_dt_total_land_value:=left.tax_dt_total_land_value;
		
		self.CoreLogic.total_market_value:=left.total_market_value;
		self.CoreLogic.src_total_market_value:=left.src_total_market_value;
		self.CoreLogic.tax_dt_total_market_value:=left.tax_dt_total_market_value;
		
		self.CoreLogic.floor_type:=left.floor_type;
		self.CoreLogic.floor_type_desc:=left.floor_type_desc;
		self.CoreLogic.src_floor_type:=left.src_floor_type;
		self.CoreLogic.tax_dt_floor_type:=left.tax_dt_floor_type;
		
		self.CoreLogic.frame_type:=left.frame_type;
		self.CoreLogic.frame_type_desc:=left.frame_type_desc;
		self.CoreLogic.src_frame_type:=left.src_frame_type;
		self.CoreLogic.tax_dt_frame_type:=left.tax_dt_frame_type;
		
		self.CoreLogic.fuel_type:=left.fuel_type;
		self.CoreLogic.fuel_type_desc:=left.fuel_type_desc;
		self.CoreLogic.src_fuel_type:=left.src_fuel_type;
		self.CoreLogic.tax_dt_fuel_type:=left.tax_dt_fuel_type;
		
		self.CoreLogic.no_of_bath_fixtures:=left.no_of_bath_fixtures;
		self.CoreLogic.src_no_of_bath_fixtures:=left.src_no_of_bath_fixtures;
		self.CoreLogic.tax_dt_no_of_bath_fixtures:=left.tax_dt_no_of_bath_fixtures;
		
		self.CoreLogic.no_of_rooms:=left.no_of_rooms;
		self.CoreLogic.src_no_of_rooms:=left.src_no_of_rooms;
		self.CoreLogic.tax_dt_no_of_rooms:=left.tax_dt_no_of_rooms;
		
		self.CoreLogic.no_of_units:=left.no_of_units;
		self.CoreLogic.src_no_of_units:=left.src_no_of_units;
		self.CoreLogic.tax_dt_no_of_units:=left.tax_dt_no_of_units;
		
		self.CoreLogic.style_type:=left.style_type;
		self.CoreLogic.style_type_desc:=left.style_type_desc;
		self.CoreLogic.src_style_type:=left.src_style_type;
		self.CoreLogic.tax_dt_style_type:=left.tax_dt_style_type;
		
		self.CoreLogic.assessment_document_number:=left.assessment_document_number;
		self.CoreLogic.src_assessment_document_number:=left.src_assessment_document_number;
		self.CoreLogic.tax_dt_assessment_document_number:=left.tax_dt_assessment_document_number;
		
		self.CoreLogic.assessment_recording_date:=left.assessment_recording_date;
		self.CoreLogic.src_assessment_recording_date:=left.src_assessment_recording_date;
		self.CoreLogic.tax_dt_assessment_recording_date:=left.tax_dt_assessment_recording_date;
		
		self.CoreLogic.deed_document_number:=left.deed_document_number;
		self.CoreLogic.src_deed_document_number:=left.src_deed_document_number;
		self.CoreLogic.rec_dt_deed_document_number:=left.rec_dt_deed_document_number;
		
		self.CoreLogic.deed_recording_date:=left.deed_recording_date;
		self.CoreLogic.src_deed_recording_date:=left.src_deed_recording_date;
		
		self.CoreLogic.full_part_sale:=left.full_part_sale;
		self.CoreLogic.src_full_part_sale:=left.src_full_part_sale;
		self.CoreLogic.rec_dt_full_part_sale:=left.rec_dt_full_part_sale;
		
		self.CoreLogic.sale_amount:=left.sale_amount;
		self.CoreLogic.src_sale_amount:=left.src_sale_amount;
		self.CoreLogic.rec_dt_sale_amount:=left.rec_dt_sale_amount;
		
		self.CoreLogic.sale_date:=left.sale_date;
		self.CoreLogic.src_sale_date:=left.src_sale_date;
		self.CoreLogic.rec_dt_sale_date:=left.rec_dt_sale_date;
		
		self.CoreLogic.sale_type_code:=left.sale_type_code;
		self.CoreLogic.src_sale_type_code:=left.src_sale_type_code;
		self.CoreLogic.rec_dt_sale_type_code:=left.rec_dt_sale_type_code;
		
		self.CoreLogic.mortgage_company_name:=left.mortgage_company_name;
		self.CoreLogic.src_mortgage_company_name:=left.src_mortgage_company_name;
		self.CoreLogic.rec_dt_mortgage_company_name:=left.rec_dt_mortgage_company_name;
		
		self.CoreLogic.loan_amount:=left.loan_amount;
		self.CoreLogic.src_loan_amount:=left.src_loan_amount;
		self.CoreLogic.rec_dt_loan_amount:=left.rec_dt_loan_amount;
		
		self.CoreLogic.second_loan_amount:=left.second_loan_amount;
		self.CoreLogic.src_second_loan_amount:=left.src_second_loan_amount;
		self.CoreLogic.rec_dt_second_loan_amount:=left.rec_dt_second_loan_amount;
		
		self.CoreLogic.loan_type_code:=left.loan_type_code;
		self.CoreLogic.src_loan_type_code:=left.src_loan_type_code;
		self.CoreLogic.rec_dt_loan_type_code:=left.rec_dt_loan_type_code;
		
		self.CoreLogic.interest_rate_type_code:=left.interest_rate_type_code;
		self.CoreLogic.src_interest_rate_type_code:=left.src_interest_rate_type_code;
		self.CoreLogic.rec_dt_interest_rate_type_code:=left.rec_dt_interest_rate_type_code;
        Self:=Left;
        Self:=[];
    ));
    
    
	  PropertyCharacteristics.Layouts.TempSourceCompare tCombineCA_BK(PropertyCharacteristics.Layouts.TempSourceCompare L, PropertyCharacteristics.Layouts.TempSourceCompare R):=TRANSFORM
        self.BlackKnight:=R.BlackKnight;
        self.CollAnalytics:=L.CollAnalytics;
		self.data_source:=0;
		self.vendor_source:='G';
		self.vendor:='';
		self.vendor_preference:=0;
		self.current_record:='';
		self.fares_unformatted_apn:='';//corelogic
		self:=L;
		self:=R;
    END;
    PropertyCharacteristics.Layouts.TempSourceCompare tCombineCABK_CL(PropertyCharacteristics.Layouts.TempSourceCompare L, PropertyCharacteristics.Layouts.TempSourceCompare R):=TRANSFORM
        self.CoreLogic:=R.CoreLogic;
        self.BlackKnight:=L.BlackKnight;
        self.CollAnalytics:=L.CollAnalytics;
		self.data_source:=0;
		self.vendor_source:='G';
		self.vendor:='';
		self.vendor_preference:=0;
		self.current_record:='';
		self.fares_unformatted_apn:='';//corelogic
        self:=L;
		self:=R;
    END;
	DistLoadBK:=distribute(LoadBlackKnight,hash(prim_name,prim_range,zip,predir,postdir,addr_suffix,sec_range));
    DistLoadCL:=distribute(LoadCoreLogic,hash(prim_range,prim_name,sec_range,zip));

    
    CombineBK_CL_Not_CL_Only:=join(DistLoadBK,
                       DistLoadCL,
                       left.prim_name=right.prim_name and
                       left.prim_range=right.prim_range and
                       left.zip=right.zip and
                       left.predir=right.predir and
                       left.postdir=right.postdir and
                       left.addr_suffix=right.addr_suffix and
                       left.sec_range=right.sec_range,
                       tCombineCABK_CL(left,right),left outer,keep(1),local);
	CombineBK_CL_CL_Only:=join(DistLoadBK,
                       DistLoadCL,
                       left.prim_name=right.prim_name and
                       left.prim_range=right.prim_range and
                       left.zip=right.zip and
                       left.predir=right.predir and
                       left.postdir=right.postdir and
                       left.addr_suffix=right.addr_suffix and
                       left.sec_range=right.sec_range,
                       transform(right),right only,local);
	CombineBK_CL:=CombineBK_CL_Not_CL_Only+CombineBK_CL_CL_Only;
	SelectFromSources(string BK, string CL) := function 
        CleanBK:=trim(STD.STR.TOUPPERCASE(BK),left,right);
        CleanCL:=trim(STD.STR.TOUPPERCASE(CL),left,right);
		
        Result:=map(CleanBK<>'' => 'OKCTY',
                    CleanCL<>'' => 'FARES',
                    ''
        );
        return Result;
    end;

    SelectFromSourcesNumeric(string BK, string CL) := function 
        CleanBK:=trim(STD.STR.TOUPPERCASE(BK),left,right);
        CleanCL:=trim(STD.STR.TOUPPERCASE(CL),left,right);
		
        Result:=map(CleanBK<>'' => 'OKCTY',
                    CleanCL<>'' => 'FARES',
                    ''
        );
				return Result;
    end;

	SelectFromSourcesDate_Sales_Tax_Built(string BK, string CL) := function 
        CleanBK:=trim(STD.STR.TOUPPERCASE(BK),left,right);
        CleanCL:=trim(STD.STR.TOUPPERCASE(CL),left,right);

        Result:=map(CleanBK<>''  and (Real)CleanBK >= (Real)CleanCL => 'OKCTY',//if other sources match and not CA than BK skip if blank
                    CleanCL<>'' => 'FARES',
                    ''
        );
        return Result;
    end;

	SelectFromSourcesPercentImproved(udecimal5_2 BK, udecimal5_2 CL) := function 
       Result:=map(BK<>0 => 'OKCTY',
                    CL<>0 => 'FARES',
                    ''
        );
        return Result;
    end;

    

    PropertyCharacteristics.Layouts.TempBase tMappingRules(CombineBK_CL L):=TRANSFORM

		SelectFromSourcesDate:=map(L.BlackKnight.dt_vendor_last_reported <> 0=>'OKCTY',
					L.CoreLogic.dt_vendor_last_reported <>0=>'FARES',
					'');
		self.vendor_source:='G';
        self.src_building_square_footage:=SelectFromSourcesNumeric(L.BlackKnight.building_square_footage,L.CoreLogic.building_square_footage);
		self.building_square_footage:=STD.STR.TOUPPERCASE(map(self.src_building_square_footage='OKCTY'=>L.BlackKnight.building_square_footage,self.src_building_square_footage='FARES'=>L.CoreLogic.building_square_footage,''));
		self.tax_dt_building_square_footage:=STD.STR.TOUPPERCASE(map(self.src_building_square_footage='OKCTY'=>L.BlackKnight.tax_dt_building_square_footage,self.src_building_square_footage='FARES'=>L.CoreLogic.tax_dt_building_square_footage,''));
		
		self.src_air_conditioning_type:=SelectFromSources(L.BlackKnight.air_conditioning_type,L.CoreLogic.air_conditioning_type);
		self.air_conditioning_type:=STD.STR.TOUPPERCASE(map(self.src_air_conditioning_type='OKCTY'=>L.BlackKnight.air_conditioning_type,self.src_air_conditioning_type='FARES'=>L.CoreLogic.air_conditioning_type,''));
		self.air_conditioning_type_desc:=STD.STR.TOUPPERCASE(map(self.src_air_conditioning_type='OKCTY'=>L.BlackKnight.air_conditioning_type_desc,self.src_air_conditioning_type='FARES'=>L.CoreLogic.air_conditioning_type_desc,''));
		self.tax_dt_air_conditioning_type:=STD.STR.TOUPPERCASE(map(self.src_air_conditioning_type='OKCTY'=>L.BlackKnight.tax_dt_air_conditioning_type,self.src_air_conditioning_type='FARES'=>L.CoreLogic.tax_dt_air_conditioning_type,''));
		
		self.src_basement_finish:=SelectFromSources(L.BlackKnight.basement_finish,L.CoreLogic.basement_finish);
		self.basement_finish:=STD.STR.TOUPPERCASE(map(self.src_basement_finish='OKCTY'=>L.BlackKnight.basement_finish,self.src_basement_finish='FARES'=>L.CoreLogic.basement_finish,''));
		self.basement_finish_desc:=STD.STR.TOUPPERCASE(map(self.src_basement_finish='OKCTY'=>L.BlackKnight.basement_finish_desc,self.src_basement_finish='FARES'=>L.CoreLogic.basement_finish_desc,''));
		self.tax_dt_basement_finish:=STD.STR.TOUPPERCASE(map(self.src_basement_finish='OKCTY'=>L.BlackKnight.tax_dt_basement_finish,self.src_basement_finish='FARES'=>L.CoreLogic.tax_dt_basement_finish,''));
		
		self.src_construction_type:=SelectFromSources(L.BlackKnight.construction_type,L.CoreLogic.construction_type);
		self.construction_type:=STD.STR.TOUPPERCASE(map(self.src_construction_type='OKCTY'=>L.BlackKnight.construction_type,self.src_construction_type='FARES'=>L.CoreLogic.construction_type,''));
		self.construction_type_desc:=STD.STR.TOUPPERCASE(map(self.src_construction_type='OKCTY'=>L.BlackKnight.construction_type_desc,self.src_construction_type='FARES'=>L.CoreLogic.construction_type_desc,''));
		self.tax_dt_construction_type:=STD.STR.TOUPPERCASE(map(self.src_construction_type='OKCTY'=>L.BlackKnight.tax_dt_construction_type,self.src_construction_type='FARES'=>L.CoreLogic.tax_dt_construction_type,''));
		
		self.src_exterior_wall:=SelectFromSources(L.BlackKnight.exterior_wall,L.CoreLogic.exterior_wall);
		self.exterior_wall:=STD.STR.TOUPPERCASE(map(self.src_exterior_wall='OKCTY'=>L.BlackKnight.exterior_wall,self.src_exterior_wall='FARES'=>L.CoreLogic.exterior_wall,''));
		self.exterior_wall_desc:=STD.STR.TOUPPERCASE(map(self.src_exterior_wall='OKCTY'=>L.BlackKnight.exterior_wall_desc,self.src_exterior_wall='FARES'=>L.CoreLogic.exterior_wall_desc,''));
		self.tax_dt_exterior_wall:=STD.STR.TOUPPERCASE(map(self.src_exterior_wall='OKCTY'=>L.BlackKnight.tax_dt_exterior_wall,self.src_exterior_wall='FARES'=>L.CoreLogic.tax_dt_exterior_wall,''));
		
		self.src_fireplace_ind:=SelectFromSources(L.BlackKnight.fireplace_ind,L.CoreLogic.fireplace_ind);
		self.fireplace_ind:=STD.STR.TOUPPERCASE(map(self.src_fireplace_ind='OKCTY'=>L.BlackKnight.fireplace_ind,self.src_fireplace_ind='FARES'=>L.CoreLogic.fireplace_ind,''));
		self.tax_dt_fireplace_ind:=STD.STR.TOUPPERCASE(map(self.src_fireplace_ind='OKCTY'=>L.BlackKnight.tax_dt_fireplace_ind,self.src_fireplace_ind='FARES'=>L.CoreLogic.tax_dt_fireplace_ind,''));
		
		self.src_fireplace_type:=SelectFromSources(L.BlackKnight.fireplace_type,L.CoreLogic.fireplace_type);
		self.fireplace_type:=STD.STR.TOUPPERCASE(map(self.src_fireplace_type='OKCTY'=>L.BlackKnight.fireplace_type,self.src_fireplace_type='FARES'=>L.CoreLogic.fireplace_type,''));
		self.fireplace_type_desc:=STD.STR.TOUPPERCASE(map(self.src_fireplace_type='OKCTY'=>L.BlackKnight.fireplace_type_desc,self.src_fireplace_type='FARES'=>L.CoreLogic.fireplace_type_desc,''));
		self.tax_dt_fireplace_type:=STD.STR.TOUPPERCASE(map(self.src_fireplace_type='OKCTY'=>L.BlackKnight.tax_dt_fireplace_type,self.src_fireplace_type='FARES'=>L.CoreLogic.tax_dt_fireplace_type,''));
		
		self.src_flood_zone_panel:=SelectFromSources(L.BlackKnight.flood_zone_panel,L.CoreLogic.flood_zone_panel);
		self.flood_zone_panel:=STD.STR.TOUPPERCASE(map(self.src_flood_zone_panel='OKCTY'=>L.BlackKnight.flood_zone_panel,self.src_flood_zone_panel='FARES'=>L.CoreLogic.flood_zone_panel,''));
		self.tax_dt_flood_zone_panel:=STD.STR.TOUPPERCASE(map(self.src_flood_zone_panel='OKCTY'=>L.BlackKnight.tax_dt_flood_zone_panel,self.src_flood_zone_panel='FARES'=>L.CoreLogic.tax_dt_flood_zone_panel,''));
		
		self.src_garage:=SelectFromSources(L.BlackKnight.garage,L.CoreLogic.garage);
		self.garage:=STD.STR.TOUPPERCASE(map(self.src_garage='OKCTY'=>L.BlackKnight.garage,self.src_garage='FARES'=>L.CoreLogic.garage,''));
		self.garage_desc:=STD.STR.TOUPPERCASE(map(self.src_garage='OKCTY'=>L.BlackKnight.garage_desc,self.src_garage='FARES'=>L.CoreLogic.garage_desc,''));
		self.tax_dt_garage:=STD.STR.TOUPPERCASE(map(self.src_garage='OKCTY'=>L.BlackKnight.tax_dt_garage,self.src_garage='FARES'=>L.CoreLogic.tax_dt_garage,''));
		
		self.src_first_floor_square_footage:=SelectFromSourcesNumeric(L.BlackKnight.first_floor_square_footage,L.CoreLogic.first_floor_square_footage);
		self.first_floor_square_footage:=STD.STR.TOUPPERCASE(map(self.src_first_floor_square_footage='OKCTY'=>L.BlackKnight.first_floor_square_footage,self.src_first_floor_square_footage='FARES'=>L.CoreLogic.first_floor_square_footage,''));
		self.tax_dt_first_floor_square_footage:=STD.STR.TOUPPERCASE(map(self.src_first_floor_square_footage='OKCTY'=>L.BlackKnight.tax_dt_first_floor_square_footage,self.src_first_floor_square_footage='FARES'=>L.CoreLogic.tax_dt_first_floor_square_footage,''));
		
		self.src_heating:=SelectFromSources(L.BlackKnight.heating,L.CoreLogic.heating);
		self.heating:=STD.STR.TOUPPERCASE(map(self.src_heating='OKCTY'=>L.BlackKnight.heating,self.src_heating='FARES'=>L.CoreLogic.heating,''));
		self.heating_desc:=STD.STR.TOUPPERCASE(map(self.src_heating='OKCTY'=>L.BlackKnight.heating_desc,self.src_heating='FARES'=>L.CoreLogic.heating_desc,''));
		self.tax_dt_heating:=STD.STR.TOUPPERCASE(map(self.src_heating='OKCTY'=>L.BlackKnight.tax_dt_heating,self.src_heating='FARES'=>L.CoreLogic.tax_dt_heating,''));
		
		self.src_living_area_square_footage:=SelectFromSourcesNumeric(L.BlackKnight.living_area_square_footage,L.CoreLogic.living_area_square_footage);
		self.living_area_square_footage:=STD.STR.TOUPPERCASE(map(self.src_living_area_square_footage='OKCTY'=>L.BlackKnight.living_area_square_footage,self.src_living_area_square_footage='FARES'=>L.CoreLogic.living_area_square_footage,''));
		self.tax_dt_living_area_square_footage:=STD.STR.TOUPPERCASE(map(self.src_living_area_square_footage='OKCTY'=>L.BlackKnight.tax_dt_living_area_square_footage,self.src_living_area_square_footage='FARES'=>L.CoreLogic.tax_dt_living_area_square_footage,''));
		
		self.src_no_of_baths:=SelectFromSourcesNumeric(L.BlackKnight.no_of_baths,L.CoreLogic.no_of_baths);
		self.no_of_baths:=STD.STR.TOUPPERCASE(map(self.src_no_of_baths='OKCTY'=>L.BlackKnight.no_of_baths,self.src_no_of_baths='FARES'=>L.CoreLogic.no_of_baths,''));
		self.tax_dt_no_of_baths:=STD.STR.TOUPPERCASE(map(self.src_no_of_baths='OKCTY'=>L.BlackKnight.tax_dt_no_of_baths,self.src_no_of_baths='FARES'=>L.CoreLogic.tax_dt_no_of_baths,''));
		
		self.src_no_of_bedrooms:=SelectFromSourcesNumeric(L.BlackKnight.no_of_bedrooms,L.CoreLogic.no_of_bedrooms);
		self.no_of_bedrooms:=STD.STR.TOUPPERCASE(map(self.src_no_of_bedrooms='OKCTY'=>L.BlackKnight.no_of_bedrooms,self.src_no_of_bedrooms='FARES'=>L.CoreLogic.no_of_bedrooms,''));
		self.tax_dt_no_of_bedrooms:=STD.STR.TOUPPERCASE(map(self.src_no_of_bedrooms='OKCTY'=>L.BlackKnight.tax_dt_no_of_bedrooms,self.src_no_of_bedrooms='FARES'=>L.CoreLogic.tax_dt_no_of_bedrooms,''));
		
		self.src_no_of_fireplaces:=SelectFromSourcesNumeric(L.BlackKnight.no_of_fireplaces,L.CoreLogic.no_of_fireplaces);
		self.no_of_fireplaces:=STD.STR.TOUPPERCASE(map(self.src_no_of_fireplaces='OKCTY'=>L.BlackKnight.no_of_fireplaces,self.src_no_of_fireplaces='FARES'=>L.CoreLogic.no_of_fireplaces,''));
		self.tax_dt_no_of_fireplaces:=STD.STR.TOUPPERCASE(map(self.src_no_of_fireplaces='OKCTY'=>L.BlackKnight.tax_dt_no_of_fireplaces,self.src_no_of_fireplaces='FARES'=>L.CoreLogic.tax_dt_no_of_fireplaces,''));
		
		self.src_no_of_full_baths:=SelectFromSourcesNumeric(L.BlackKnight.no_of_full_baths,L.CoreLogic.no_of_full_baths);
		self.no_of_full_baths:=STD.STR.TOUPPERCASE(map(self.src_no_of_full_baths='OKCTY'=>L.BlackKnight.no_of_full_baths,self.src_no_of_full_baths='FARES'=>L.CoreLogic.no_of_full_baths,''));
		self.tax_dt_no_of_full_baths:=STD.STR.TOUPPERCASE(map(self.src_no_of_full_baths='OKCTY'=>L.BlackKnight.tax_dt_no_of_full_baths,self.src_no_of_full_baths='FARES'=>L.CoreLogic.tax_dt_no_of_full_baths,''));
		
		self.src_no_of_half_baths:=SelectFromSourcesNumeric(L.BlackKnight.no_of_half_baths,L.CoreLogic.no_of_half_baths);
		self.no_of_half_baths:=STD.STR.TOUPPERCASE(map(self.src_no_of_half_baths='OKCTY'=>L.BlackKnight.no_of_half_baths,self.src_no_of_half_baths='FARES'=>L.CoreLogic.no_of_half_baths,''));
		self.tax_dt_no_of_half_baths:=STD.STR.TOUPPERCASE(map(self.src_no_of_half_baths='OKCTY'=>L.BlackKnight.tax_dt_no_of_half_baths,self.src_no_of_half_baths='FARES'=>L.CoreLogic.tax_dt_no_of_half_baths,''));
		
		self.src_no_of_stories:=SelectFromSourcesNumeric(L.BlackKnight.no_of_stories,L.CoreLogic.no_of_stories);
		self.no_of_stories:=STD.STR.TOUPPERCASE(map(self.src_no_of_stories='OKCTY'=>L.BlackKnight.no_of_stories,self.src_no_of_stories='FARES'=>L.CoreLogic.no_of_stories,''));
		self.tax_dt_no_of_stories:=STD.STR.TOUPPERCASE(map(self.src_no_of_stories='OKCTY'=>L.BlackKnight.tax_dt_no_of_stories,self.src_no_of_stories='FARES'=>L.CoreLogic.tax_dt_no_of_stories,''));
		
		self.src_parking_type:=SelectFromSources(L.BlackKnight.parking_type,L.CoreLogic.parking_type);
		self.parking_type:=STD.STR.TOUPPERCASE(map(self.src_parking_type='OKCTY'=>L.BlackKnight.parking_type,self.src_parking_type='FARES'=>L.CoreLogic.parking_type,''));
		self.parking_type_desc:=STD.STR.TOUPPERCASE(map(self.src_parking_type='OKCTY'=>L.BlackKnight.parking_type_desc,self.src_parking_type='FARES'=>L.CoreLogic.parking_type_desc,''));
		self.tax_dt_parking_type:=STD.STR.TOUPPERCASE(map(self.src_parking_type='OKCTY'=>L.BlackKnight.tax_dt_parking_type,self.src_parking_type='FARES'=>L.CoreLogic.tax_dt_parking_type,''));
		
		self.src_pool_indicator:=SelectFromSources(L.BlackKnight.pool_indicator,L.CoreLogic.pool_indicator);
		self.pool_indicator:=STD.STR.TOUPPERCASE(map(self.src_pool_indicator='OKCTY'=>L.BlackKnight.pool_indicator,self.src_pool_indicator='FARES'=>L.CoreLogic.pool_indicator,''));
		self.tax_dt_pool_indicator:=STD.STR.TOUPPERCASE(map(self.src_pool_indicator='OKCTY'=>L.BlackKnight.tax_dt_pool_indicator,self.src_pool_indicator='FARES'=>L.CoreLogic.tax_dt_pool_indicator,''));
		
		self.src_pool_type:=SelectFromSources(L.BlackKnight.pool_type,L.CoreLogic.pool_type);
		self.pool_type:=STD.STR.TOUPPERCASE(map(self.src_pool_type='OKCTY'=>L.BlackKnight.pool_type,self.src_pool_type='FARES'=>L.CoreLogic.pool_type,''));
		self.pool_type_desc:=STD.STR.TOUPPERCASE(map(self.src_pool_type='OKCTY'=>L.BlackKnight.pool_type_desc,self.src_pool_type='FARES'=>L.CoreLogic.pool_type_desc,''));
		self.tax_dt_pool_type:=STD.STR.TOUPPERCASE(map(self.src_pool_type='OKCTY'=>L.BlackKnight.tax_dt_pool_type,self.src_pool_type='FARES'=>L.CoreLogic.tax_dt_pool_type,''));
		
		self.src_roof_cover:=SelectFromSources(L.BlackKnight.roof_cover,L.CoreLogic.roof_cover);
		self.roof_cover:=STD.STR.TOUPPERCASE(map(self.src_roof_cover='OKCTY'=>L.BlackKnight.roof_cover,self.src_roof_cover='FARES'=>L.CoreLogic.roof_cover,''));
		self.roof_cover_desc:=STD.STR.TOUPPERCASE(map(self.src_roof_cover='OKCTY'=>L.BlackKnight.roof_cover_desc,self.src_roof_cover='FARES'=>L.CoreLogic.roof_cover_desc,''));
		self.tax_dt_roof_cover:=STD.STR.TOUPPERCASE(map(self.src_roof_cover='OKCTY'=>L.BlackKnight.tax_dt_roof_cover,self.src_roof_cover='FARES'=>L.CoreLogic.tax_dt_roof_cover,''));
		
		self.src_roof_type:=SelectFromSources(L.BlackKnight.roof_type,L.CoreLogic.roof_type);
		self.roof_type:=STD.STR.TOUPPERCASE(map(self.src_roof_type='OKCTY'=>L.BlackKnight.roof_type,self.src_roof_type='FARES'=>L.CoreLogic.roof_type,''));
		self.roof_type_desc:=STD.STR.TOUPPERCASE(map(self.src_roof_type='OKCTY'=>L.BlackKnight.roof_type_desc,self.src_roof_type='FARES'=>L.CoreLogic.roof_type_desc,''));
		self.tax_dt_roof_type:=STD.STR.TOUPPERCASE(map(self.src_roof_type='OKCTY'=>L.BlackKnight.tax_dt_roof_type,self.src_roof_type='FARES'=>L.CoreLogic.tax_dt_roof_type,''));
		
		self.src_year_built:=SelectFromSourcesDate_Sales_Tax_Built(L.BlackKnight.year_built,L.CoreLogic.year_built);
		self.year_built:=STD.STR.TOUPPERCASE(map(self.src_year_built='OKCTY'=>L.BlackKnight.year_built,self.src_year_built='FARES'=>L.CoreLogic.year_built,''));
		self.tax_dt_year_built:=STD.STR.TOUPPERCASE(map(self.src_year_built='OKCTY'=>L.BlackKnight.tax_dt_year_built,self.src_year_built='FARES'=>L.CoreLogic.tax_dt_year_built,''));
		

		self.src_foundation:=SelectFromSources(L.BlackKnight.foundation,L.CoreLogic.foundation);
		self.foundation:=STD.STR.TOUPPERCASE(map(self.src_foundation='OKCTY'=>L.BlackKnight.foundation,self.src_foundation='FARES'=>L.CoreLogic.foundation,''));
		self.foundation_desc:=STD.STR.TOUPPERCASE(map(self.src_foundation='OKCTY'=>L.BlackKnight.foundation_desc,self.src_foundation='FARES'=>L.CoreLogic.foundation_desc,''));
		self.tax_dt_foundation:=STD.STR.TOUPPERCASE(map(self.src_foundation='OKCTY'=>L.BlackKnight.tax_dt_foundation,self.src_foundation='FARES'=>L.CoreLogic.tax_dt_foundation,''));
		
		self.src_basement_square_footage:=SelectFromSourcesNumeric(L.BlackKnight.basement_square_footage,L.CoreLogic.basement_square_footage);
		self.basement_square_footage:=STD.STR.TOUPPERCASE(map(self.src_basement_square_footage='OKCTY'=>L.BlackKnight.basement_square_footage,self.src_basement_square_footage='FARES'=>L.CoreLogic.basement_square_footage,''));
		self.tax_dt_basement_square_footage:=STD.STR.TOUPPERCASE(map(self.src_basement_square_footage='OKCTY'=>L.BlackKnight.tax_dt_basement_square_footage,self.src_basement_square_footage='FARES'=>L.CoreLogic.tax_dt_basement_square_footage,''));
		
		self.src_effective_year_built:=SelectFromSources(L.BlackKnight.effective_year_built,L.CoreLogic.effective_year_built);
		self.effective_year_built:=STD.STR.TOUPPERCASE(map(self.src_effective_year_built='OKCTY'=>L.BlackKnight.effective_year_built,self.src_effective_year_built='FARES'=>L.CoreLogic.effective_year_built,''));
		self.tax_dt_effective_year_built:=STD.STR.TOUPPERCASE(map(self.src_effective_year_built='OKCTY'=>L.BlackKnight.tax_dt_effective_year_built,self.src_effective_year_built='FARES'=>L.CoreLogic.tax_dt_effective_year_built,''));
		
		self.src_garage_square_footage:=SelectFromSourcesNumeric(L.BlackKnight.garage_square_footage,L.CoreLogic.garage_square_footage);
		self.garage_square_footage:=STD.STR.TOUPPERCASE(map(self.src_garage_square_footage='OKCTY'=>L.BlackKnight.garage_square_footage,self.src_garage_square_footage='FARES'=>L.CoreLogic.garage_square_footage,''));
		self.tax_dt_garage_square_footage:=STD.STR.TOUPPERCASE(map(self.src_garage_square_footage='OKCTY'=>L.BlackKnight.tax_dt_garage_square_footage,self.src_garage_square_footage='FARES'=>L.CoreLogic.tax_dt_garage_square_footage,''));
		
		self.src_stories_type:=SelectFromSources(L.BlackKnight.stories_type,L.CoreLogic.stories_type);
		self.stories_type:=STD.STR.TOUPPERCASE(map(self.src_stories_type='OKCTY'=>L.BlackKnight.stories_type,self.src_stories_type='FARES'=>L.CoreLogic.stories_type,''));
		self.stories_type_desc:=STD.STR.TOUPPERCASE(map(self.src_stories_type='OKCTY'=>L.BlackKnight.stories_type_desc,self.src_stories_type='FARES'=>L.CoreLogic.stories_type_desc,''));
		self.tax_dt_stories_type:=STD.STR.TOUPPERCASE(map(self.src_stories_type='OKCTY'=>L.BlackKnight.tax_dt_stories_type,self.src_stories_type='FARES'=>L.CoreLogic.tax_dt_stories_type,''));
		
		self.src_apn_number:=SelectFromSources(L.BlackKnight.apn_number,L.CoreLogic.apn_number);
		self.apn_number:=STD.STR.TOUPPERCASE(map(self.src_apn_number='OKCTY'=>L.BlackKnight.apn_number,self.src_apn_number='FARES'=>L.CoreLogic.apn_number,''));
		self.tax_dt_apn_number:=STD.STR.TOUPPERCASE(map(self.src_apn_number='OKCTY'=>L.BlackKnight.tax_dt_apn_number,self.src_apn_number='FARES'=>L.CoreLogic.tax_dt_apn_number,''));
		
		self.src_census_tract:=SelectFromSources(L.BlackKnight.census_tract,L.CoreLogic.census_tract);
		self.census_tract:=STD.STR.TOUPPERCASE(map(self.src_census_tract='OKCTY'=>L.BlackKnight.census_tract,self.src_census_tract='FARES'=>L.CoreLogic.census_tract,''));
		self.tax_dt_census_tract:=STD.STR.TOUPPERCASE(map(self.src_census_tract='OKCTY'=>L.BlackKnight.tax_dt_census_tract,self.src_census_tract='FARES'=>L.CoreLogic.tax_dt_census_tract,''));
		
		self.src_range:=SelectFromSources(L.BlackKnight.range,L.CoreLogic.range);
		self.range:=STD.STR.TOUPPERCASE(map(self.src_range='OKCTY'=>L.BlackKnight.range,self.src_range='FARES'=>L.CoreLogic.range,''));
		self.tax_dt_range:=STD.STR.TOUPPERCASE(map(self.src_range='OKCTY'=>L.BlackKnight.tax_dt_range,self.src_range='FARES'=>L.CoreLogic.tax_dt_range,''));
		
		self.src_zoning:=SelectFromSources(L.BlackKnight.zoning,L.CoreLogic.zoning);
		self.zoning:=STD.STR.TOUPPERCASE(map(self.src_zoning='OKCTY'=>L.BlackKnight.zoning,self.src_zoning='FARES'=>L.CoreLogic.zoning,''));
		self.tax_dt_zoning:=STD.STR.TOUPPERCASE(map(self.src_zoning='OKCTY'=>L.BlackKnight.tax_dt_zoning,self.src_zoning='FARES'=>L.CoreLogic.tax_dt_zoning,''));
		
		self.src_block_number:=SelectFromSources(L.BlackKnight.block_number,L.CoreLogic.block_number);
		self.block_number:=STD.STR.TOUPPERCASE(map(self.src_block_number='OKCTY'=>L.BlackKnight.block_number,self.src_block_number='FARES'=>L.CoreLogic.block_number,''));
		self.tax_dt_block_number:=STD.STR.TOUPPERCASE(map(self.src_block_number='OKCTY'=>L.BlackKnight.tax_dt_block_number,self.src_block_number='FARES'=>L.CoreLogic.tax_dt_block_number,''));
		
		self.src_county_name:=SelectFromSources(L.BlackKnight.county_name,L.CoreLogic.county_name);
		self.county_name:=STD.STR.TOUPPERCASE(map(self.src_county_name='OKCTY'=>L.BlackKnight.county_name,self.src_county_name='FARES'=>L.CoreLogic.county_name,''));
		self.tax_dt_county_name:=STD.STR.TOUPPERCASE(map(self.src_county_name='OKCTY'=>L.BlackKnight.tax_dt_county_name,self.src_county_name='FARES'=>L.CoreLogic.tax_dt_county_name,''));
		
		self.src_fips_code:=SelectFromSources(L.BlackKnight.fips_code,L.CoreLogic.fips_code);
		self.fips_code:=STD.STR.TOUPPERCASE(map(self.src_fips_code='OKCTY'=>L.BlackKnight.fips_code,self.src_fips_code='FARES'=>L.CoreLogic.fips_code,''));
		self.tax_dt_fips_code:=STD.STR.TOUPPERCASE(map(self.src_fips_code='OKCTY'=>L.BlackKnight.tax_dt_fips_code,self.src_fips_code='FARES'=>L.CoreLogic.tax_dt_fips_code,''));
		
		self.src_subdivision:=SelectFromSources(L.BlackKnight.subdivision,L.CoreLogic.subdivision);
		self.subdivision:=STD.STR.TOUPPERCASE(map(self.src_subdivision='OKCTY'=>L.BlackKnight.subdivision,self.src_subdivision='FARES'=>L.CoreLogic.subdivision,''));
		self.tax_dt_subdivision:=STD.STR.TOUPPERCASE(map(self.src_subdivision='OKCTY'=>L.BlackKnight.tax_dt_subdivision,self.src_subdivision='FARES'=>L.CoreLogic.tax_dt_subdivision,''));
		
		self.src_municipality:=SelectFromSources(L.BlackKnight.municipality,L.CoreLogic.municipality);
		self.municipality:=STD.STR.TOUPPERCASE(map(self.src_municipality='OKCTY'=>L.BlackKnight.municipality,self.src_municipality='FARES'=>L.CoreLogic.municipality,''));
		self.tax_dt_municipality:=STD.STR.TOUPPERCASE(map(self.src_municipality='OKCTY'=>L.BlackKnight.tax_dt_municipality,self.src_municipality='FARES'=>L.CoreLogic.tax_dt_municipality,''));
		
		self.src_township:=SelectFromSources(L.BlackKnight.township,L.CoreLogic.township);
		self.township:=STD.STR.TOUPPERCASE(map(self.src_township='OKCTY'=>L.BlackKnight.township,self.src_township='FARES'=>L.CoreLogic.township,''));
		self.tax_dt_township:=STD.STR.TOUPPERCASE(map(self.src_township='OKCTY'=>L.BlackKnight.tax_dt_township,self.src_township='FARES'=>L.CoreLogic.tax_dt_township,''));
		
		self.src_homestead_exemption_ind:=SelectFromSources(L.BlackKnight.homestead_exemption_ind,L.CoreLogic.homestead_exemption_ind);
		self.homestead_exemption_ind:=STD.STR.TOUPPERCASE(map(self.src_homestead_exemption_ind='OKCTY'=>L.BlackKnight.homestead_exemption_ind,self.src_homestead_exemption_ind='FARES'=>L.CoreLogic.homestead_exemption_ind,''));
		self.tax_dt_homestead_exemption_ind:=STD.STR.TOUPPERCASE(map(self.src_homestead_exemption_ind='OKCTY'=>L.BlackKnight.tax_dt_homestead_exemption_ind,self.src_homestead_exemption_ind='FARES'=>L.CoreLogic.tax_dt_homestead_exemption_ind,''));
		
		self.src_land_use_code:=SelectFromSources(L.BlackKnight.land_use_code,L.CoreLogic.land_use_code);
		self.land_use_code:=STD.STR.TOUPPERCASE(map(self.src_land_use_code='OKCTY'=>L.BlackKnight.land_use_code,self.src_land_use_code='FARES'=>L.CoreLogic.land_use_code,''));
		self.tax_dt_land_use_code:=STD.STR.TOUPPERCASE(map(self.src_land_use_code='OKCTY'=>L.BlackKnight.tax_dt_land_use_code,self.src_land_use_code='FARES'=>L.CoreLogic.tax_dt_land_use_code,''));
		
		self.src_latitude:=SelectFromSources(L.BlackKnight.latitude,L.CoreLogic.latitude);
		self.latitude:=STD.STR.TOUPPERCASE(map(self.src_latitude='OKCTY'=>L.BlackKnight.latitude,self.src_latitude='FARES'=>L.CoreLogic.latitude,''));
		self.tax_dt_latitude:=STD.STR.TOUPPERCASE(map(self.src_latitude='OKCTY'=>L.BlackKnight.tax_dt_latitude,self.src_latitude='FARES'=>L.CoreLogic.tax_dt_latitude,''));
		
		self.src_longitude:=SelectFromSources(L.BlackKnight.longitude,L.CoreLogic.longitude);
		self.longitude:=STD.STR.TOUPPERCASE(map(self.src_longitude='OKCTY'=>L.BlackKnight.longitude,self.src_longitude='FARES'=>L.CoreLogic.longitude,''));
		self.tax_dt_longitude:=STD.STR.TOUPPERCASE(map(self.src_longitude='OKCTY'=>L.BlackKnight.tax_dt_longitude,self.src_longitude='FARES'=>L.CoreLogic.tax_dt_longitude,''));
		
		self.src_location_influence_code:=SelectFromSources(L.BlackKnight.location_influence_code,L.CoreLogic.location_influence_code);
		self.location_influence_code:=STD.STR.TOUPPERCASE(map(self.src_location_influence_code='OKCTY'=>L.BlackKnight.location_influence_code,self.src_location_influence_code='FARES'=>L.CoreLogic.location_influence_code,''));
		self.location_influence_desc:=STD.STR.TOUPPERCASE(map(self.src_location_influence_code='OKCTY'=>L.BlackKnight.location_influence_desc,self.src_location_influence_code='FARES'=>L.CoreLogic.location_influence_desc,''));
		self.tax_dt_location_influence_code:=STD.STR.TOUPPERCASE(map(self.src_location_influence_code='OKCTY'=>L.BlackKnight.tax_dt_location_influence_code,self.src_location_influence_code='FARES'=>L.CoreLogic.tax_dt_location_influence_code,''));
		
		self.src_lot_size:=SelectFromSourcesNumeric(L.BlackKnight.lot_size,L.CoreLogic.lot_size);
		self.lot_size:=STD.STR.TOUPPERCASE(map(self.src_lot_size='OKCTY'=>L.BlackKnight.lot_size,self.src_lot_size='FARES'=>L.CoreLogic.lot_size,''));
		self.tax_dt_lot_size:=STD.STR.TOUPPERCASE(map(self.src_lot_size='OKCTY'=>L.BlackKnight.tax_dt_lot_size,self.src_lot_size='FARES'=>L.CoreLogic.tax_dt_lot_size,''));
		
		self.src_acres:=SelectFromSourcesNumeric(L.BlackKnight.acres,L.CoreLogic.acres);
		self.acres:=STD.STR.TOUPPERCASE(map(self.src_acres='OKCTY'=>L.BlackKnight.acres,self.src_acres='FARES'=>L.CoreLogic.acres,''));
		self.tax_dt_acres:=STD.STR.TOUPPERCASE(map(self.src_acres='OKCTY'=>L.BlackKnight.tax_dt_acres,self.src_acres='FARES'=>L.CoreLogic.tax_dt_acres,''));
		
		self.src_lot_depth_footage:=SelectFromSourcesNumeric(L.BlackKnight.lot_depth_footage,L.CoreLogic.lot_depth_footage);
		self.lot_depth_footage:=STD.STR.TOUPPERCASE(map(self.src_lot_depth_footage='OKCTY'=>L.BlackKnight.lot_depth_footage,self.src_lot_depth_footage='FARES'=>L.CoreLogic.lot_depth_footage,''));
		self.tax_dt_lot_depth_footage:=STD.STR.TOUPPERCASE(map(self.src_lot_depth_footage='OKCTY'=>L.BlackKnight.tax_dt_lot_depth_footage,self.src_lot_depth_footage='FARES'=>L.CoreLogic.tax_dt_lot_depth_footage,''));
		
		self.src_lot_front_footage:=SelectFromSourcesNumeric(L.BlackKnight.lot_front_footage,L.CoreLogic.lot_front_footage);
		self.lot_front_footage:=STD.STR.TOUPPERCASE(map(self.src_lot_front_footage='OKCTY'=>L.BlackKnight.lot_front_footage,self.src_lot_front_footage='FARES'=>L.CoreLogic.lot_front_footage,''));
		self.tax_dt_lot_front_footage:=STD.STR.TOUPPERCASE(map(self.src_lot_front_footage='OKCTY'=>L.BlackKnight.tax_dt_lot_front_footage,self.src_lot_front_footage='FARES'=>L.CoreLogic.tax_dt_lot_front_footage,''));
		
		self.src_lot_number:=SelectFromSources(L.BlackKnight.lot_number,L.CoreLogic.lot_number);
		self.lot_number:=STD.STR.TOUPPERCASE(map(self.src_lot_number='OKCTY'=>L.BlackKnight.lot_number,self.src_lot_number='FARES'=>L.CoreLogic.lot_number,''));
		self.tax_dt_lot_number:=STD.STR.TOUPPERCASE(map(self.src_lot_number='OKCTY'=>L.BlackKnight.tax_dt_lot_number,self.src_lot_number='FARES'=>L.CoreLogic.tax_dt_lot_number,''));
		
		
		self.src_property_type_code:=SelectFromSources(L.BlackKnight.property_type_code,L.CoreLogic.property_type_code);
		self.property_type_code:=STD.STR.TOUPPERCASE(map(self.src_property_type_code='OKCTY'=>L.BlackKnight.property_type_code,self.src_property_type_code='FARES'=>L.CoreLogic.property_type_code,''));
		self.property_type_desc:=STD.STR.TOUPPERCASE(map(self.src_property_type_code='OKCTY'=>L.BlackKnight.property_type_desc,self.src_property_type_code='FARES'=>L.CoreLogic.property_type_desc,''));
		self.tax_dt_property_type_code:=STD.STR.TOUPPERCASE(map(self.src_property_type_code='OKCTY'=>L.BlackKnight.tax_dt_property_type_code,self.src_property_type_code='FARES'=>L.CoreLogic.tax_dt_property_type_code,''));
		
		self.src_structure_quality:=SelectFromSources(L.BlackKnight.structure_quality,L.CoreLogic.structure_quality);
		self.structure_quality:=STD.STR.TOUPPERCASE(map(self.src_structure_quality='OKCTY'=>L.BlackKnight.structure_quality,self.src_structure_quality='FARES'=>L.CoreLogic.structure_quality,''));
		self.structure_quality_desc:=STD.STR.TOUPPERCASE(map(self.src_structure_quality='OKCTY'=>L.BlackKnight.structure_quality_desc,self.src_structure_quality='FARES'=>L.CoreLogic.structure_quality_desc,''));
		self.tax_dt_structure_quality:=STD.STR.TOUPPERCASE(map(self.src_structure_quality='OKCTY'=>L.BlackKnight.tax_dt_structure_quality,self.src_structure_quality='FARES'=>L.CoreLogic.tax_dt_structure_quality,''));
		
		self.src_water:=SelectFromSources(L.BlackKnight.water,L.CoreLogic.water);
		self.water:=STD.STR.TOUPPERCASE(map(self.src_water='OKCTY'=>L.BlackKnight.water,self.src_water='FARES'=>L.CoreLogic.water,''));
		self.water_desc:=STD.STR.TOUPPERCASE(map(self.src_water='OKCTY'=>L.BlackKnight.water_desc,self.src_water='FARES'=>L.CoreLogic.water_desc,''));
		self.tax_dt_water:=STD.STR.TOUPPERCASE(map(self.src_water='OKCTY'=>L.BlackKnight.tax_dt_water,self.src_water='FARES'=>L.CoreLogic.tax_dt_water,''));
		
		self.src_sewer:=SelectFromSources(L.BlackKnight.sewer,L.CoreLogic.sewer);
		self.sewer:=STD.STR.TOUPPERCASE(map(self.src_sewer='OKCTY'=>L.BlackKnight.sewer,self.src_sewer='FARES'=>L.CoreLogic.sewer,''));
		self.sewer_desc:=STD.STR.TOUPPERCASE(map(self.src_sewer='OKCTY'=>L.BlackKnight.sewer_desc,self.src_sewer='FARES'=>L.CoreLogic.sewer_desc,''));
		self.tax_dt_sewer:=STD.STR.TOUPPERCASE(map(self.src_sewer='OKCTY'=>L.BlackKnight.tax_dt_sewer,self.src_sewer='FARES'=>L.CoreLogic.tax_dt_sewer,''));
		
		self.src_assessed_land_value:=SelectFromSourcesNumeric(L.BlackKnight.assessed_land_value,L.CoreLogic.assessed_land_value);
		self.assessed_land_value:=STD.STR.TOUPPERCASE(map(self.src_assessed_land_value='OKCTY'=>L.BlackKnight.assessed_land_value,self.src_assessed_land_value='FARES'=>L.CoreLogic.assessed_land_value,''));
		self.tax_dt_assessed_land_value:=STD.STR.TOUPPERCASE(map(self.src_assessed_land_value='OKCTY'=>L.BlackKnight.tax_dt_assessed_land_value,self.src_assessed_land_value='FARES'=>L.CoreLogic.tax_dt_assessed_land_value,''));
		
		self.src_assessed_year:=SelectFromSources(L.BlackKnight.assessed_year,L.CoreLogic.assessed_year);
		self.assessed_year:=STD.STR.TOUPPERCASE(map(self.src_assessed_year='OKCTY'=>L.BlackKnight.assessed_year,self.src_assessed_year='FARES'=>L.CoreLogic.assessed_year,''));
		self.tax_dt_assessed_year:=STD.STR.TOUPPERCASE(map(self.src_assessed_year='OKCTY'=>L.BlackKnight.tax_dt_assessed_year,self.src_assessed_year='FARES'=>L.CoreLogic.tax_dt_assessed_year,''));
		
		self.src_tax_amount:=SelectFromSourcesNumeric(L.BlackKnight.tax_amount,L.CoreLogic.tax_amount);
		self.tax_amount:=STD.STR.TOUPPERCASE(map(self.src_tax_amount='OKCTY'=>L.BlackKnight.tax_amount,self.src_tax_amount='FARES'=>L.CoreLogic.tax_amount,''));
		self.tax_dt_tax_amount:=STD.STR.TOUPPERCASE(map(self.src_tax_amount='OKCTY'=>L.BlackKnight.tax_dt_tax_amount,self.src_tax_amount='FARES'=>L.CoreLogic.tax_dt_tax_amount,''));
		
		self.src_tax_year:=SelectFromSourcesDate_Sales_Tax_Built(L.BlackKnight.tax_year,L.CoreLogic.tax_year);
		self.tax_year:=STD.STR.TOUPPERCASE(map(self.src_tax_year='OKCTY'=>L.BlackKnight.tax_year,self.src_tax_year='FARES'=>L.CoreLogic.tax_year,''));
		

		self.src_market_land_value:=SelectFromSourcesNumeric(L.BlackKnight.market_land_value,L.CoreLogic.market_land_value);
		self.market_land_value:=STD.STR.TOUPPERCASE(map(self.src_market_land_value='OKCTY'=>L.BlackKnight.market_land_value,self.src_market_land_value='FARES'=>L.CoreLogic.market_land_value,''));
		self.tax_dt_market_land_value:=STD.STR.TOUPPERCASE(map(self.src_market_land_value='OKCTY'=>L.BlackKnight.tax_dt_market_land_value,self.src_market_land_value='FARES'=>L.CoreLogic.tax_dt_market_land_value,''));
		
		self.src_improvement_value:=SelectFromSourcesNumeric(L.BlackKnight.improvement_value,L.CoreLogic.improvement_value);
		self.improvement_value:=STD.STR.TOUPPERCASE(map(self.src_improvement_value='OKCTY'=>L.BlackKnight.improvement_value,self.src_improvement_value='FARES'=>L.CoreLogic.improvement_value,''));
		self.tax_dt_improvement_value:=STD.STR.TOUPPERCASE(map(self.src_improvement_value='OKCTY'=>L.BlackKnight.tax_dt_improvement_value,self.src_improvement_value='FARES'=>L.CoreLogic.tax_dt_improvement_value,''));
		
		self.src_percent_improved:=SelectFromSourcesPercentImproved(L.BlackKnight.percent_improved,L.CoreLogic.percent_improved);
		self.percent_improved:=map(self.src_percent_improved='OKCTY'=>L.BlackKnight.percent_improved,self.src_percent_improved='FARES'=>L.CoreLogic.percent_improved,0);
		self.tax_dt_percent_improved:=STD.STR.TOUPPERCASE(map(self.src_percent_improved='OKCTY'=>L.BlackKnight.tax_dt_percent_improved,self.src_percent_improved='FARES'=>L.CoreLogic.tax_dt_percent_improved,''));
		
		self.src_total_assessed_value:=SelectFromSourcesNumeric(L.BlackKnight.total_assessed_value,L.CoreLogic.total_assessed_value);
		self.total_assessed_value:=STD.STR.TOUPPERCASE(map(self.src_total_assessed_value='OKCTY'=>L.BlackKnight.total_assessed_value,self.src_total_assessed_value='FARES'=>L.CoreLogic.total_assessed_value,''));
		self.tax_dt_total_assessed_value:=STD.STR.TOUPPERCASE(map(self.src_total_assessed_value='OKCTY'=>L.BlackKnight.tax_dt_total_assessed_value,self.src_total_assessed_value='FARES'=>L.CoreLogic.tax_dt_total_assessed_value,''));
		
		self.src_total_calculated_value:=SelectFromSourcesNumeric(L.BlackKnight.total_calculated_value,L.CoreLogic.total_calculated_value);
		self.total_calculated_value:=STD.STR.TOUPPERCASE(map(self.src_total_calculated_value='OKCTY'=>L.BlackKnight.total_calculated_value,self.src_total_calculated_value='FARES'=>L.CoreLogic.total_calculated_value,''));
		self.tax_dt_total_calculated_value:=STD.STR.TOUPPERCASE(map(self.src_total_calculated_value='OKCTY'=>L.BlackKnight.tax_dt_total_calculated_value,self.src_total_calculated_value='FARES'=>L.CoreLogic.tax_dt_total_calculated_value,''));
		
		self.src_total_land_value:=SelectFromSourcesNumeric(L.BlackKnight.total_land_value,L.CoreLogic.total_land_value);
		self.total_land_value:=STD.STR.TOUPPERCASE(map(self.src_total_land_value='OKCTY'=>L.BlackKnight.total_land_value,self.src_total_land_value='FARES'=>L.CoreLogic.total_land_value,''));
		self.tax_dt_total_land_value:=STD.STR.TOUPPERCASE(map(self.src_total_land_value='OKCTY'=>L.BlackKnight.tax_dt_total_land_value,self.src_total_land_value='FARES'=>L.CoreLogic.tax_dt_total_land_value,''));
		
		self.src_total_market_value:=SelectFromSourcesNumeric(L.BlackKnight.total_market_value,L.CoreLogic.total_market_value);
		self.total_market_value:=STD.STR.TOUPPERCASE(map(self.src_total_market_value='OKCTY'=>L.BlackKnight.total_market_value,self.src_total_market_value='FARES'=>L.CoreLogic.total_market_value,''));
		self.tax_dt_total_market_value:=STD.STR.TOUPPERCASE(map(self.src_total_market_value='OKCTY'=>L.BlackKnight.tax_dt_total_market_value,self.src_total_market_value='FARES'=>L.CoreLogic.tax_dt_total_market_value,''));
		
		self.src_floor_type:=SelectFromSources(L.BlackKnight.floor_type,L.CoreLogic.floor_type);
		self.floor_type:=STD.STR.TOUPPERCASE(map(self.src_floor_type='OKCTY'=>L.BlackKnight.floor_type,self.src_floor_type='FARES'=>L.CoreLogic.floor_type,''));
		self.floor_type_desc:=STD.STR.TOUPPERCASE(map(self.src_floor_type='OKCTY'=>L.BlackKnight.floor_type_desc,self.src_floor_type='FARES'=>L.CoreLogic.floor_type_desc,''));
		self.tax_dt_floor_type:=STD.STR.TOUPPERCASE(map(self.src_floor_type='OKCTY'=>L.BlackKnight.tax_dt_floor_type,self.src_floor_type='FARES'=>L.CoreLogic.tax_dt_floor_type,''));
		
		self.src_frame_type:=SelectFromSources(L.BlackKnight.frame_type,L.CoreLogic.frame_type);
		self.frame_type:=STD.STR.TOUPPERCASE(map(self.src_frame_type='OKCTY'=>L.BlackKnight.frame_type,self.src_frame_type='FARES'=>L.CoreLogic.frame_type,''));
		self.frame_type_desc:=STD.STR.TOUPPERCASE(map(self.src_frame_type='OKCTY'=>L.BlackKnight.frame_type_desc,self.src_frame_type='FARES'=>L.CoreLogic.frame_type_desc,''));
		self.tax_dt_frame_type:=STD.STR.TOUPPERCASE(map(self.src_frame_type='OKCTY'=>L.BlackKnight.tax_dt_frame_type,self.src_frame_type='FARES'=>L.CoreLogic.tax_dt_frame_type,''));
		
		self.src_fuel_type:=SelectFromSources(L.BlackKnight.fuel_type,L.CoreLogic.fuel_type);
		self.fuel_type:=STD.STR.TOUPPERCASE(map(self.src_fuel_type='OKCTY'=>L.BlackKnight.fuel_type,self.src_fuel_type='FARES'=>L.CoreLogic.fuel_type,''));
		self.fuel_type_desc:=STD.STR.TOUPPERCASE(map(self.src_fuel_type='OKCTY'=>L.BlackKnight.fuel_type_desc,self.src_fuel_type='FARES'=>L.CoreLogic.fuel_type_desc,''));
		self.tax_dt_fuel_type:=STD.STR.TOUPPERCASE(map(self.src_fuel_type='OKCTY'=>L.BlackKnight.tax_dt_fuel_type,self.src_fuel_type='FARES'=>L.CoreLogic.tax_dt_fuel_type,''));
		
		self.src_no_of_bath_fixtures:=SelectFromSourcesNumeric(L.BlackKnight.no_of_bath_fixtures,L.CoreLogic.no_of_bath_fixtures);
		self.no_of_bath_fixtures:=STD.STR.TOUPPERCASE(map(self.src_no_of_bath_fixtures='OKCTY'=>L.BlackKnight.no_of_bath_fixtures,self.src_no_of_bath_fixtures='FARES'=>L.CoreLogic.no_of_bath_fixtures,''));
		self.tax_dt_no_of_bath_fixtures:=STD.STR.TOUPPERCASE(map(self.src_no_of_bath_fixtures='OKCTY'=>L.BlackKnight.tax_dt_no_of_bath_fixtures,self.src_no_of_bath_fixtures='FARES'=>L.CoreLogic.tax_dt_no_of_bath_fixtures,''));
		
		self.src_no_of_rooms:=SelectFromSourcesNumeric(L.BlackKnight.no_of_rooms,L.CoreLogic.no_of_rooms);
		self.no_of_rooms:=STD.STR.TOUPPERCASE(map(self.src_no_of_rooms='OKCTY'=>L.BlackKnight.no_of_rooms,self.src_no_of_rooms='FARES'=>L.CoreLogic.no_of_rooms,''));
		self.tax_dt_no_of_rooms:=STD.STR.TOUPPERCASE(map(self.src_no_of_rooms='OKCTY'=>L.BlackKnight.tax_dt_no_of_rooms,self.src_no_of_rooms='FARES'=>L.CoreLogic.tax_dt_no_of_rooms,''));
		
		self.src_no_of_units:=SelectFromSourcesNumeric(L.BlackKnight.no_of_units,L.CoreLogic.no_of_units);
		self.no_of_units:=STD.STR.TOUPPERCASE(map(self.src_no_of_units='OKCTY'=>L.BlackKnight.no_of_units,self.src_no_of_units='FARES'=>L.CoreLogic.no_of_units,''));
		self.tax_dt_no_of_units:=STD.STR.TOUPPERCASE(map(self.src_no_of_units='OKCTY'=>L.BlackKnight.tax_dt_no_of_units,self.src_no_of_units='FARES'=>L.CoreLogic.tax_dt_no_of_units,''));
		
		self.src_style_type:=SelectFromSources(L.BlackKnight.style_type,L.CoreLogic.style_type);
		self.style_type:=STD.STR.TOUPPERCASE(map(self.src_style_type='OKCTY'=>L.BlackKnight.style_type,self.src_style_type='FARES'=>L.CoreLogic.style_type,''));
		self.style_type_desc:=STD.STR.TOUPPERCASE(map(self.src_style_type='OKCTY'=>L.BlackKnight.style_type_desc,self.src_style_type='FARES'=>L.CoreLogic.style_type_desc,''));
		self.tax_dt_style_type:=STD.STR.TOUPPERCASE(map(self.src_style_type='OKCTY'=>L.BlackKnight.tax_dt_style_type,self.src_style_type='FARES'=>L.CoreLogic.tax_dt_style_type,''));
		
		self.src_assessment_document_number:=SelectFromSources(L.BlackKnight.assessment_document_number,L.CoreLogic.assessment_document_number);
		self.assessment_document_number:=STD.STR.TOUPPERCASE(map(self.src_assessment_document_number='OKCTY'=>L.BlackKnight.assessment_document_number,self.src_assessment_document_number='FARES'=>L.CoreLogic.assessment_document_number,''));
		self.tax_dt_assessment_document_number:=STD.STR.TOUPPERCASE(map(self.src_assessment_document_number='OKCTY'=>L.BlackKnight.tax_dt_assessment_document_number,self.src_assessment_document_number='FARES'=>L.CoreLogic.tax_dt_assessment_document_number,''));
		
		self.src_assessment_recording_date:=SelectFromSources(L.BlackKnight.assessment_recording_date,L.CoreLogic.assessment_recording_date);
		self.assessment_recording_date:=STD.STR.TOUPPERCASE(map(self.src_assessment_recording_date='OKCTY'=>L.BlackKnight.assessment_recording_date,self.src_assessment_recording_date='FARES'=>L.CoreLogic.assessment_recording_date,''));
		self.tax_dt_assessment_recording_date:=STD.STR.TOUPPERCASE(map(self.src_assessment_recording_date='OKCTY'=>L.BlackKnight.tax_dt_assessment_recording_date,self.src_assessment_recording_date='FARES'=>L.CoreLogic.tax_dt_assessment_recording_date,''));
		
		self.src_deed_document_number:=SelectFromSources(L.BlackKnight.deed_document_number,L.CoreLogic.deed_document_number);
		self.deed_document_number:=STD.STR.TOUPPERCASE(map(self.src_deed_document_number='OKCTY'=>L.BlackKnight.deed_document_number,self.src_deed_document_number='FARES'=>L.CoreLogic.deed_document_number,''));
		self.rec_dt_deed_document_number:=STD.STR.TOUPPERCASE(map(self.src_deed_document_number='OKCTY'=>L.BlackKnight.rec_dt_deed_document_number,self.src_deed_document_number='FARES'=>L.CoreLogic.rec_dt_deed_document_number,''));
		
		self.src_deed_recording_date:=SelectFromSources(L.BlackKnight.deed_recording_date,L.CoreLogic.deed_recording_date);
		self.deed_recording_date:=STD.STR.TOUPPERCASE(map(self.src_deed_recording_date='OKCTY'=>L.BlackKnight.deed_recording_date,self.src_deed_recording_date='FARES'=>L.CoreLogic.deed_recording_date,''));
		
		self.src_full_part_sale:=SelectFromSourcesNumeric(L.BlackKnight.full_part_sale,L.CoreLogic.full_part_sale);
		self.full_part_sale:=STD.STR.TOUPPERCASE(map(self.src_full_part_sale='OKCTY'=>L.BlackKnight.full_part_sale,self.src_full_part_sale='FARES'=>L.CoreLogic.full_part_sale,''));
		self.rec_dt_full_part_sale:=STD.STR.TOUPPERCASE(map(self.src_full_part_sale='OKCTY'=>L.BlackKnight.rec_dt_full_part_sale,self.src_full_part_sale='FARES'=>L.CoreLogic.rec_dt_full_part_sale,''));
		
		self.src_sale_amount:=SelectFromSourcesNumeric(L.BlackKnight.sale_amount,L.CoreLogic.sale_amount);
		self.sale_amount:=STD.STR.TOUPPERCASE(map(self.src_sale_amount='OKCTY'=>L.BlackKnight.sale_amount,self.src_sale_amount='FARES'=>L.CoreLogic.sale_amount,''));
		self.rec_dt_sale_amount:=STD.STR.TOUPPERCASE(map(self.src_sale_amount='OKCTY'=>L.BlackKnight.rec_dt_sale_amount,self.src_sale_amount='FARES'=>L.CoreLogic.rec_dt_sale_amount,''));
		
		//SelectFromSourcesDate_Sales_Tax_Built
		self.src_sale_date:=SelectFromSourcesDate_Sales_Tax_Built(L.BlackKnight.Sale_Date,L.CoreLogic.Sale_Date);
		self.sale_date:=STD.STR.TOUPPERCASE(map(self.src_sale_date='OKCTY'=>L.BlackKnight.sale_date,self.src_sale_date='FARES'=>L.CoreLogic.sale_date,''));
		self.rec_dt_sale_date:=STD.STR.TOUPPERCASE(map(self.src_sale_date='OKCTY'=>L.BlackKnight.rec_dt_sale_date,self.src_sale_date='FARES'=>L.CoreLogic.rec_dt_sale_date,''));
		
		self.property_rid:=map(SelectFromSourcesDate='MLS'=>L.CollAnalytics.property_rid,SelectFromSourcesDate='OKCTY'=>L.BlackKnight.property_rid,SelectFromSourcesDate='FARES'=>L.CoreLogic.property_rid,0);
		self.dt_vendor_first_reported:=map(SelectFromSourcesDate='MLS'=>L.CollAnalytics.dt_vendor_first_reported,SelectFromSourcesDate='OKCTY'=>L.BlackKnight.dt_vendor_first_reported,SelectFromSourcesDate='FARES'=>L.CoreLogic.dt_vendor_first_reported,0);
		self.dt_vendor_last_reported:=map(SelectFromSourcesDate='MLS'=>L.CollAnalytics.dt_vendor_last_reported,SelectFromSourcesDate='OKCTY'=>L.BlackKnight.dt_vendor_last_reported,SelectFromSourcesDate='FARES'=>L.CoreLogic.dt_vendor_last_reported,0);
		self.tax_sortby_date:=map(SelectFromSourcesDate='MLS'=>L.CollAnalytics.tax_sortby_date,SelectFromSourcesDate='OKCTY'=>L.BlackKnight.tax_sortby_date,SelectFromSourcesDate='FARES'=>L.CoreLogic.tax_sortby_date,'');
		self.deed_sortby_date:=map(SelectFromSourcesDate='MLS'=>L.CollAnalytics.tax_sortby_date,SelectFromSourcesDate='OKCTY'=>L.BlackKnight.tax_sortby_date,SelectFromSourcesDate='FARES'=>L.CoreLogic.tax_sortby_date,'');
		
		self.src_sale_type_code:=SelectFromSources(L.BlackKnight.sale_type_code,L.CoreLogic.sale_type_code);
		self.sale_type_code:=STD.STR.TOUPPERCASE(map(self.src_sale_type_code='OKCTY'=>L.BlackKnight.sale_type_code,self.src_sale_type_code='FARES'=>L.CoreLogic.sale_type_code,''));
		self.rec_dt_sale_type_code:=STD.STR.TOUPPERCASE(map(self.src_sale_type_code='OKCTY'=>L.BlackKnight.rec_dt_sale_type_code,self.src_sale_type_code='FARES'=>L.CoreLogic.rec_dt_sale_type_code,''));
		
		self.src_mortgage_company_name:=SelectFromSources(L.BlackKnight.mortgage_company_name,L.CoreLogic.mortgage_company_name);
		self.mortgage_company_name:=STD.STR.TOUPPERCASE(map(self.src_mortgage_company_name='OKCTY'=>L.BlackKnight.mortgage_company_name,self.src_mortgage_company_name='FARES'=>L.CoreLogic.mortgage_company_name,''));
		self.rec_dt_mortgage_company_name:=STD.STR.TOUPPERCASE(map(self.src_mortgage_company_name='OKCTY'=>L.BlackKnight.rec_dt_mortgage_company_name,self.src_mortgage_company_name='FARES'=>L.CoreLogic.rec_dt_mortgage_company_name,''));
		
		self.src_loan_amount:=SelectFromSourcesNumeric(L.BlackKnight.loan_amount,L.CoreLogic.loan_amount);
		self.loan_amount:=STD.STR.TOUPPERCASE(map(self.src_loan_amount='OKCTY'=>L.BlackKnight.loan_amount,self.src_loan_amount='FARES'=>L.CoreLogic.loan_amount,''));
		self.rec_dt_loan_amount:=STD.STR.TOUPPERCASE(map(self.src_loan_amount='OKCTY'=>L.BlackKnight.rec_dt_loan_amount,self.src_loan_amount='FARES'=>L.CoreLogic.rec_dt_loan_amount,''));
		
		self.src_second_loan_amount:=SelectFromSourcesNumeric(L.BlackKnight.second_loan_amount,L.CoreLogic.second_loan_amount);
		self.second_loan_amount:=STD.STR.TOUPPERCASE(map(self.src_second_loan_amount='OKCTY'=>L.BlackKnight.second_loan_amount,self.src_second_loan_amount='FARES'=>L.CoreLogic.second_loan_amount,''));
		self.rec_dt_second_loan_amount:=STD.STR.TOUPPERCASE(map(self.src_second_loan_amount='OKCTY'=>L.BlackKnight.rec_dt_second_loan_amount,self.src_second_loan_amount='FARES'=>L.CoreLogic.rec_dt_second_loan_amount,''));
		
		self.src_loan_type_code:=SelectFromSources(L.BlackKnight.loan_type_code,L.CoreLogic.loan_type_code);
		self.loan_type_code:=STD.STR.TOUPPERCASE(map(self.src_loan_type_code='OKCTY'=>L.BlackKnight.loan_type_code,self.src_loan_type_code='FARES'=>L.CoreLogic.loan_type_code,''));
		self.rec_dt_loan_type_code:=STD.STR.TOUPPERCASE(map(self.src_loan_type_code='OKCTY'=>L.BlackKnight.rec_dt_loan_type_code,self.src_loan_type_code='FARES'=>L.CoreLogic.rec_dt_loan_type_code,''));
		
		self.src_interest_rate_type_code:=SelectFromSources(L.BlackKnight.interest_rate_type_code,L.CoreLogic.interest_rate_type_code);
		self.interest_rate_type_code:=STD.STR.TOUPPERCASE(map(self.src_interest_rate_type_code='OKCTY'=>L.BlackKnight.interest_rate_type_code,self.src_interest_rate_type_code='FARES'=>L.CoreLogic.interest_rate_type_code,''));
		self.rec_dt_interest_rate_type_code:=STD.STR.TOUPPERCASE(map(self.src_interest_rate_type_code='OKCTY'=>L.BlackKnight.rec_dt_interest_rate_type_code,self.src_interest_rate_type_code='FARES'=>L.CoreLogic.rec_dt_interest_rate_type_code,''));

		self:=L;
		self:=[];
    END;

	FinalMapping:=project(CombineBK_CL,tMappingRules(left));
	
	BlankPercentImproved:=project(FinalMapping,transform(recordof(FinalMapping),self.src_percent_improved:=if(left.percent_improved=0,'',left.src_percent_improved);self.tax_dt_percent_improved:=if(left.percent_improved=0,'',left.tax_dt_percent_improved);self:=left;));

	set_single_family := ['SFR','AGR','VNY','HSR','RNH','RVL','RES','RRR','RWH','COO','CLH','BGW','HST', 'PPT', 'PRS','ZLL',''];	
	SingleFamily  			:=  BlankPercentImproved(land_use_code in set_single_family);
	NotSingleFamily  		:=  BlankPercentImproved(land_use_code not in set_single_family);
	

	SingleFamily_srt := sort(distribute(SingleFamily,hash(prim_range, prim_name, sec_range, zip, addr_suffix, predir, postdir, geo_blk)),
																		prim_range, prim_name, sec_range, zip, addr_suffix, predir, postdir, geo_blk,local);

	PropertyCharacteristics.Populate_Default_Data.Mac_Populate_Attribute_Default_Data_F_and_G(SingleFamily_srt,dPropAttributeDefaultData);
	
	PropertyCharacteristics.Layouts.TempBase tDefaultFilterInvalid(PropertyCharacteristics.Layouts.TempBase L):=TRANSFORM
		AdjustedArchiveDate:=Std.Date.AdjustCalendar(L.dt_vendor_last_reported,0,0,1);
        self.air_conditioning_type:=if(STD.STR.TOUPPERCASE(L.air_conditioning_type ) in ['UNK','YES','NON','PKG','OTH','PKR','PRT'],'',STD.STR.TOUPPERCASE(L.air_conditioning_type));
        self.air_conditioning_type_desc:=if(STD.STR.TOUPPERCASE(L.air_conditioning_type_desc ) in ['TYPE UNKNOWN','YES','NONE','PACKAGE','OTHER','PACKAGE ROOF','PARTIAL'],'',STD.STR.TOUPPERCASE(L.air_conditioning_type_desc));
        self.exterior_wall:=if(STD.STR.TOUPPERCASE(L.exterior_wall ) in ['UNK','OTH'],'',STD.STR.TOUPPERCASE(L.exterior_wall));
        self.exterior_wall_desc:=if(STD.STR.TOUPPERCASE(L.exterior_wall_desc ) in ['TYPE UNKNOWN','OTHER'],'',STD.STR.TOUPPERCASE(L.exterior_wall_desc));
        self.fireplace_type:=if(STD.STR.TOUPPERCASE(L.fireplace_type ) in ['UNK','0V0'],'',L.fireplace_type);
        self.fireplace_type_desc:=if(STD.STR.TOUPPERCASE(L.fireplace_type_desc ) in ['TYPE UNKNOWN','MASSIVE'],'',STD.STR.TOUPPERCASE(L.fireplace_type_desc));
		self.fireplace_ind:=if(self.fireplace_type_desc='','',if(STD.STR.TOUPPERCASE(self.fireplace_type_desc)='NONE','N','Y'));
        self.floor_type:=if(STD.STR.TOUPPERCASE(L.floor_type ) in ['UNK','OTH','COV'],'',STD.STR.TOUPPERCASE(L.floor_type));
        self.floor_type_desc:=if(STD.STR.TOUPPERCASE(L.floor_type_desc ) in ['TYPE UNKNOWN','OTHER','COVERED'],'',STD.STR.TOUPPERCASE(L.floor_type_desc));
        self.foundation:=if(STD.STR.TOUPPERCASE(L.foundation ) in ['UNK','OTH','STD'],'',STD.STR.TOUPPERCASE(L.foundation));
        self.foundation_desc:=if(STD.STR.TOUPPERCASE(L.foundation_desc ) in ['TYPE UNKNOWN','OTHER','STANDARD'],'',STD.STR.TOUPPERCASE(L.foundation_desc));
        self.garage:=if(STD.STR.TOUPPERCASE(L.garage ) in ['UD0','NON'],'',STD.STR.TOUPPERCASE(L.garage));
        self.garage_desc:=if(STD.STR.TOUPPERCASE(L.garage_desc ) in ['UNDEFINED TYPE','NONE'],'',STD.STR.TOUPPERCASE(L.garage_desc));
        self.heating:=if(STD.STR.TOUPPERCASE(L.heating ) in ['UNK','YES','NON','OTH'],'',L.heating);
        self.heating_desc:=if(STD.STR.TOUPPERCASE(L.heating_desc ) in ['TYPE UNKNOWN','YES','NONE','OTHER'],'',STD.STR.TOUPPERCASE(L.heating_desc));
        self.parking_type:=if(STD.STR.TOUPPERCASE(L.parking_type ) in ['UNK','UD0'],'',L.parking_type);
        self.parking_type_desc:=if(STD.STR.TOUPPERCASE(L.parking_type_desc ) in ['TYPE UNKNOWN','UNDEFINED TYPE'],'',STD.STR.TOUPPERCASE(L.parking_type_desc));
        self.pool_type:=if(STD.STR.TOUPPERCASE(L.pool_type ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.pool_type));
        self.pool_type_desc:=if(STD.STR.TOUPPERCASE(L.pool_type_desc ) in ['TYPE UNKNOWN'],'',STD.STR.TOUPPERCASE(L.pool_type_desc));
		self.pool_indicator:=if(self.pool_type_desc='','',if(STD.STR.TOUPPERCASE(self.pool_type_desc)='NONE','N','Y'));
        self.style_type:=if(STD.STR.TOUPPERCASE(L.style_type ) in ['UNK','OTH'],'',STD.STR.TOUPPERCASE(L.style_type));
        self.style_type_desc:=if(STD.STR.TOUPPERCASE(L.style_type_desc ) in ['TYPE UNKNOWN','OTHER'],'',STD.STR.TOUPPERCASE(L.style_type_desc));
        self.structure_quality:=if(STD.STR.TOUPPERCASE(L.structure_quality ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.structure_quality));
        self.structure_quality_desc:=if(STD.STR.TOUPPERCASE(L.structure_quality_desc ) in ['TYPE UNKNOWN'],'',STD.STR.TOUPPERCASE(L.structure_quality_desc));
        self.roof_cover:=if(STD.STR.TOUPPERCASE(L.roof_cover ) in ['UNK','OTH'],'',STD.STR.TOUPPERCASE(L.roof_cover));
        self.roof_cover_desc:=if(STD.STR.TOUPPERCASE(L.roof_cover_desc ) in ['TYPE UNKNOWN','OTHER'],'',STD.STR.TOUPPERCASE(L.roof_cover_desc));
        self.sewer:=if(STD.STR.TOUPPERCASE(L.sewer ) in ['UNK','NON'],'',STD.STR.TOUPPERCASE(L.sewer));
        self.sewer_desc:=if(STD.STR.TOUPPERCASE(L.sewer_desc ) in ['TYPE UNKNOWN','NONE'],'',STD.STR.TOUPPERCASE(L.sewer_desc));
        self.construction_type:=if(STD.STR.TOUPPERCASE(L.construction_type ) in ['NON','UNK'],'',STD.STR.TOUPPERCASE(L.construction_type));
        self.construction_type_desc:=if(STD.STR.TOUPPERCASE(L.construction_type_desc ) in ['NONE','TYPE UNKNOWN'],'',STD.STR.TOUPPERCASE(L.construction_type_desc));
        self.flood_zone_panel:=if(STD.STR.TOUPPERCASE(L.flood_zone_panel ) in ['UNK','OTH','LIG'],'',STD.STR.TOUPPERCASE(L.flood_zone_panel));
        self.stories_type:=if(STD.STR.TOUPPERCASE(L.stories_type ) in ['TYPE UNKNOWN','OTHER','LIGHT'],'',STD.STR.TOUPPERCASE(L.stories_type));
        self.census_tract:=if(STD.STR.TOUPPERCASE(L.census_tract ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.census_tract));
        self.lot_number:=if(STD.STR.TOUPPERCASE(L.lot_number ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.lot_number));
        self.water:=if(STD.STR.TOUPPERCASE(L.water ) in ['UNKNOWN'],'',STD.STR.TOUPPERCASE(L.water));
        self.frame_type:=if(STD.STR.TOUPPERCASE(L.frame_type ) in ['UNK','NON'],'',STD.STR.TOUPPERCASE(L.frame_type));
        self.frame_type_desc:=if(STD.STR.TOUPPERCASE(L.frame_type_desc ) in ['TYPE UNKNOWN','NONE'],'',STD.STR.TOUPPERCASE(L.frame_type_desc));
        self.assessment_document_number:=if(STD.STR.TOUPPERCASE(L.assessment_document_number ) in ['UNK','NON'],'',STD.STR.TOUPPERCASE(L.assessment_document_number));
        self.deed_document_number:=if(STD.STR.TOUPPERCASE(L.deed_document_number ) in ['TYPE UNKNOWN','NONE'],'',STD.STR.TOUPPERCASE(L.deed_document_number));
        self.sale_type_code:=if(STD.STR.TOUPPERCASE(L.sale_type_code ) in ['UNK'],'',STD.STR.TOUPPERCASE(L.sale_type_code));
        self.interest_rate_type_code:=if(STD.STR.TOUPPERCASE(L.interest_rate_type_code ) in ['UNK','UND'],'',STD.STR.TOUPPERCASE(L.interest_rate_type_code));
        
		//special scenario for bath values
		/*self.no_of_full_baths:=if(L.no_of_baths='','',if(L.no_of_full_baths='' or (real)L.no_of_full_baths <1 or (real)L.no_of_full_baths >10,'0',STD.STR.TOUPPERCASE(L.no_of_full_baths)));
        self.no_of_half_baths:=if(L.no_of_baths='','',if(L.no_of_half_baths='' or (real)L.no_of_half_baths <0 or (real)L.no_of_half_baths >5,'0',STD.STR.TOUPPERCASE(L.no_of_half_baths)));
		no_of_baths_round_one:=if(L.no_of_baths='','',(string)((real)self.no_of_full_baths + (0.5*((real)self.no_of_half_baths))));
		self.no_of_baths:=if((real)no_of_baths_round_one<1 or (real)no_of_baths_round_one >10,'',no_of_baths_round_one);
        */
		self.no_of_full_baths:=if(L.no_of_full_baths='' or (real)L.no_of_full_baths <1 or (real)L.no_of_full_baths >10,'',STD.STR.TOUPPERCASE(L.no_of_full_baths));
		self.src_no_of_full_baths:=if(self.no_of_full_baths='','',L.src_no_of_full_baths);
		self.tax_dt_no_of_full_baths:=if(self.no_of_full_baths='','',L.tax_dt_no_of_full_baths);

		self.no_of_half_baths:=if(self.no_of_full_baths='','',if(L.no_of_half_baths='' or (real)L.no_of_half_baths <0 or (real)L.no_of_half_baths >5,'0',STD.STR.TOUPPERCASE(L.no_of_half_baths)));
		self.src_no_of_half_baths:=map(
									self.no_of_half_baths=''=>'',
									self.no_of_half_baths='0'=>self.src_no_of_full_baths,
									L.src_no_of_half_baths);
		self.tax_dt_no_of_half_baths:=map(
									self.no_of_half_baths=''=>'',
									self.no_of_half_baths='0'=>self.tax_dt_no_of_full_baths,
									L.tax_dt_no_of_half_baths);
		no_of_baths_round_one:=if(self.no_of_full_baths='',L.no_of_baths,(string)((real)self.no_of_full_baths + (0.5*((real)self.no_of_half_baths))));
		self.no_of_baths:=if((real)no_of_baths_round_one<1 or (real)no_of_baths_round_one >10,'',no_of_baths_round_one);
		self.src_no_of_baths:=map(
								self.no_of_baths=''=>'',
								self.no_of_full_baths=''=>L.src_no_of_baths,
								self.src_no_of_full_baths);
		self.tax_dt_no_of_baths:=map(
								self.no_of_baths=''=>'',
								self.no_of_full_baths=''=>L.tax_dt_no_of_baths,
								self.tax_dt_no_of_full_baths);

		self.no_of_bedrooms:=if((real)L.no_of_bedrooms <1 or (real)L.no_of_bedrooms >10,'',STD.STR.TOUPPERCASE(L.no_of_bedrooms));
        self.building_square_footage:=if((real)L.building_square_footage <250 or (real)L.building_square_footage >26136000,'',STD.STR.TOUPPERCASE(L.building_square_footage));
        self.living_area_square_footage:=if((real)L.living_area_square_footage <250 or (real)L.living_area_square_footage >30000,'',STD.STR.TOUPPERCASE(L.living_area_square_footage));
        self.acres:=if((real)L.acres <0.0057 or (real)L.acres >600,'',STD.STR.TOUPPERCASE(L.acres));
		self.src_acres:=if(self.acres='','',L.src_acres);
		self.tax_dt_acres:=if(self.acres='','',L.tax_dt_acres);
		prelot_size:=if(self.acres='',L.lot_size,if((real)L.lot_size<(0.9*((real)L.acres)*43560) or (real)L.lot_size>(1.1*((real)L.acres)*43560),(string)((real)L.acres*43560),STD.STR.TOUPPERCASE(L.lot_size)));
		self.lot_size:=if((real)prelot_size <250 or (real)prelot_size >26136000,'',prelot_size);
        //self.src_lot_size:=if(self.lot_size=L.lot_size,L.src_lot_size,if((real)L.lot_size<(0.9*((real)L.acres)*43560) or (real)L.lot_size>(1.1*((real)L.acres)*43560),L.src_acres,L.src_lot_size));
		//self.tax_dt_lot_size:=if(self.acres='',L.tax_dt_lot_size,if((real)L.lot_size<(0.9*((real)L.acres)*43560) or (real)L.lot_size>(1.1*((real)L.acres)*43560),L.tax_dt_acres,L.tax_dt_lot_size));
		self.src_lot_size:=map(self.lot_size=''=>'',
							   self.lot_size=L.lot_size=>L.src_lot_size,
							   self.src_acres);
		self.tax_dt_lot_size:=map(self.lot_size=''=>'',
							   self.lot_size=L.lot_size=>L.tax_dt_lot_size,
							   self.tax_dt_acres);	
		self.no_of_stories:=if((real)L.no_of_stories <0 or (real)L.no_of_stories >100,'',STD.STR.TOUPPERCASE(L.no_of_stories));
        self.no_of_fireplaces:=if((real)L.no_of_fireplaces <0 or (real)L.no_of_fireplaces >11,'',STD.STR.TOUPPERCASE(L.no_of_fireplaces));
        self.no_of_rooms:=if((real)L.no_of_rooms <0 or (real)L.no_of_rooms >62,'',STD.STR.TOUPPERCASE(L.no_of_rooms));
        self.no_of_units:=if((real)L.no_of_units <0 or (real)L.no_of_units >101,'',STD.STR.TOUPPERCASE(L.no_of_units));
        self.sale_date:=if((unsigned4)L.sale_date <20001030 or (unsigned4)L.sale_date > AdjustedArchiveDate,'',L.sale_date);
        self.sale_amount:=if((real)L.sale_amount <1 or (real)L.sale_amount >100000000,'',STD.STR.TOUPPERCASE(L.sale_amount));
        self.tax_amount:=if((real)L.tax_amount <100 or (real)L.tax_amount >10000000,'',STD.STR.TOUPPERCASE(L.tax_amount));
        self.assessed_year:=if((unsigned4)L.assessed_year <1800 or (unsigned4)L.assessed_year >(unsigned4)(((string)AdjustedArchiveDate)[1..4]),'',STD.STR.TOUPPERCASE(L.assessed_year));
        self.year_built:=if((unsigned4)L.year_built <1800 or (unsigned4)L.year_built >(unsigned4)(((string)AdjustedArchiveDate)[1..4]),'',STD.STR.TOUPPERCASE(L.year_built));
        self.assessed_land_value:=if((real)L.assessed_land_value <100 or (real)L.assessed_land_value >2000000,'',STD.STR.TOUPPERCASE(L.assessed_land_value));
        self.assessment_recording_date:=if((unsigned4)L.assessment_recording_date <19900101 or (unsigned4)L.assessment_recording_date > AdjustedArchiveDate,'',L.assessment_recording_date);
        self.basement_square_footage:=if((real)L.basement_square_footage <50,'',STD.STR.TOUPPERCASE(L.basement_square_footage));
        self.deed_recording_date:=if((unsigned4)L.deed_recording_date <19900101 or (unsigned4)L.deed_recording_date > AdjustedArchiveDate,'',L.deed_recording_date);
        self.effective_year_built:=if((unsigned4)L.effective_year_built <1800 or (unsigned4)L.effective_year_built >(unsigned4)(((string)AdjustedArchiveDate)[1..4]),'',STD.STR.TOUPPERCASE(L.effective_year_built));
        self.first_floor_square_footage:=if((real)L.first_floor_square_footage <250 or (real)L.first_floor_square_footage >30000,'',STD.STR.TOUPPERCASE(L.first_floor_square_footage));
        self.garage_square_footage:=if((real)L.garage_square_footage <50 or (real)L.garage_square_footage >8000,'',STD.STR.TOUPPERCASE(L.garage_square_footage));
        self.improvement_value:=if((real)L.improvement_value <1000,'',STD.STR.TOUPPERCASE(L.improvement_value));
        self.loan_amount:=if((real)L.loan_amount <5000 or (real)L.loan_amount >20000000,'',STD.STR.TOUPPERCASE(L.loan_amount));
        self.lot_depth_footage:=if((real)L.lot_depth_footage <50 or (real)L.lot_depth_footage >20000000,'',STD.STR.TOUPPERCASE(L.lot_depth_footage));
        self.lot_front_footage:=if((real)L.lot_front_footage <15 or (real)L.lot_front_footage >10000,'',STD.STR.TOUPPERCASE(L.lot_front_footage));
        self.market_land_value:=if((real)L.market_land_value <100,'',STD.STR.TOUPPERCASE(L.market_land_value));
        self.no_of_bath_fixtures:=if((real)L.no_of_bath_fixtures <0 or (real)L.no_of_bath_fixtures >65,'',STD.STR.TOUPPERCASE(L.no_of_bath_fixtures));
        self.percent_improved:=if((real)L.percent_improved <0 or (real)L.percent_improved >414,0.0,L.percent_improved);
        self.second_loan_amount:=if((real)L.second_loan_amount <1000 or (real)L.second_loan_amount >1000000,'',STD.STR.TOUPPERCASE(L.second_loan_amount));
        self.tax_year:=if((unsigned4)L.tax_year <1800 or (unsigned4)L.tax_year >(unsigned4)(((string)AdjustedArchiveDate)[1..4]),'',STD.STR.TOUPPERCASE(L.tax_year));
        self.total_assessed_value:=if((real)L.total_assessed_value <100,'',STD.STR.TOUPPERCASE(L.total_assessed_value));
        self.total_calculated_value:=if((real)L.total_calculated_value <100,'',STD.STR.TOUPPERCASE(L.total_calculated_value));
        self.total_land_value:=if((real)L.total_land_value <100,'',STD.STR.TOUPPERCASE(L.total_land_value));
        self.total_market_value:=if((real)L.total_market_value <100,'',STD.STR.TOUPPERCASE(L.total_market_value));
        //clear out filtered values' sources and dates
		self.src_building_square_footage:=if(self.building_square_footage='','',L.src_building_square_footage);
		self.tax_dt_building_square_footage:=if(self.building_square_footage='','',L.tax_dt_building_square_footage);

		self.src_air_conditioning_type:=if(self.air_conditioning_type='','',L.src_air_conditioning_type);
		self.tax_dt_air_conditioning_type:=if(self.air_conditioning_type='','',L.tax_dt_air_conditioning_type);

		self.src_construction_type:=if(self.construction_type='','',L.src_construction_type);
		self.tax_dt_construction_type:=if(self.construction_type='','',L.tax_dt_construction_type);

		self.src_exterior_wall:=if(self.exterior_wall='','',L.src_exterior_wall);
		self.tax_dt_exterior_wall:=if(self.exterior_wall='','',L.tax_dt_exterior_wall);

		self.src_fireplace_ind:=if(self.fireplace_ind='','',L.src_fireplace_ind);
		self.tax_dt_fireplace_ind:=if(self.fireplace_ind='','',L.tax_dt_fireplace_ind);

		self.src_fireplace_type:=if(self.fireplace_type='','',L.src_fireplace_type);
		self.tax_dt_fireplace_type:=if(self.fireplace_type='','',L.tax_dt_fireplace_type);

		self.src_flood_zone_panel:=if(self.flood_zone_panel='','',L.src_flood_zone_panel);
		self.tax_dt_flood_zone_panel:=if(self.flood_zone_panel='','',L.tax_dt_flood_zone_panel);

		self.src_garage:=if(self.garage='','',L.src_garage);
		self.tax_dt_garage:=if(self.garage='','',L.tax_dt_garage);

		self.src_first_floor_square_footage:=if(self.first_floor_square_footage='','',L.src_first_floor_square_footage);
		self.tax_dt_first_floor_square_footage:=if(self.first_floor_square_footage='','',L.tax_dt_first_floor_square_footage);

		self.src_heating:=if(self.heating='','',L.src_heating);
		self.tax_dt_heating:=if(self.heating='','',L.tax_dt_heating);

		self.src_living_area_square_footage:=if(self.living_area_square_footage='','',L.src_living_area_square_footage);
		self.tax_dt_living_area_square_footage:=if(self.living_area_square_footage='','',L.tax_dt_living_area_square_footage);

		self.src_no_of_bedrooms:=if(self.no_of_bedrooms='','',L.src_no_of_bedrooms);
		self.tax_dt_no_of_bedrooms:=if(self.no_of_bedrooms='','',L.tax_dt_no_of_bedrooms);

		self.src_no_of_fireplaces:=if(self.no_of_fireplaces='','',L.src_no_of_fireplaces);
		self.tax_dt_no_of_fireplaces:=if(self.no_of_fireplaces='','',L.tax_dt_no_of_fireplaces);

		self.src_no_of_stories:=if(self.no_of_stories='','',L.src_no_of_stories);
		self.tax_dt_no_of_stories:=if(self.no_of_stories='','',L.tax_dt_no_of_stories);

		self.src_parking_type:=if(self.parking_type='','',L.src_parking_type);
		self.tax_dt_parking_type:=if(self.parking_type='','',L.tax_dt_parking_type);

		self.src_pool_indicator:=if(self.pool_indicator='','',L.src_pool_indicator);
		self.tax_dt_pool_indicator:=if(self.pool_indicator='','',L.tax_dt_pool_indicator);

		self.src_pool_type:=if(self.pool_type='','',L.src_pool_type);
		self.tax_dt_pool_type:=if(self.pool_type='','',L.tax_dt_pool_type);

		self.src_roof_cover:=if(self.roof_cover='','',L.src_roof_cover);
		self.tax_dt_roof_cover:=if(self.roof_cover='','',L.tax_dt_roof_cover);

		self.src_year_built:=if(self.year_built='','',L.src_year_built);
		self.tax_dt_year_built:=if(self.year_built='','',L.tax_dt_year_built);

		self.src_foundation:=if(self.foundation='','',L.src_foundation);
		self.tax_dt_foundation:=if(self.foundation='','',L.tax_dt_foundation);

		self.src_basement_square_footage:=if(self.basement_square_footage='','',L.src_basement_square_footage);
		self.tax_dt_basement_square_footage:=if(self.basement_square_footage='','',L.tax_dt_basement_square_footage);

		self.src_effective_year_built:=if(self.effective_year_built='','',L.src_effective_year_built);
		self.tax_dt_effective_year_built:=if(self.effective_year_built='','',L.tax_dt_effective_year_built);

		self.src_garage_square_footage:=if(self.garage_square_footage='','',L.src_garage_square_footage);
		self.tax_dt_garage_square_footage:=if(self.garage_square_footage='','',L.tax_dt_garage_square_footage);

		self.src_stories_type:=if(self.stories_type='','',L.src_stories_type);
		self.tax_dt_stories_type:=if(self.stories_type='','',L.tax_dt_stories_type);

		self.src_census_tract:=if(self.census_tract='','',L.src_census_tract);
		self.tax_dt_census_tract:=if(self.census_tract='','',L.tax_dt_census_tract);

		self.src_lot_depth_footage:=if(self.lot_depth_footage='','',L.src_lot_depth_footage);
		self.tax_dt_lot_depth_footage:=if(self.lot_depth_footage='','',L.tax_dt_lot_depth_footage);

		self.src_lot_front_footage:=if(self.lot_front_footage='','',L.src_lot_front_footage);
		self.tax_dt_lot_front_footage:=if(self.lot_front_footage='','',L.tax_dt_lot_front_footage);

		self.src_lot_number:=if(self.lot_number='','',L.src_lot_number);
		self.tax_dt_lot_number:=if(self.lot_number='','',L.tax_dt_lot_number);

		self.src_structure_quality:=if(self.structure_quality='','',L.src_structure_quality);
		self.tax_dt_structure_quality:=if(self.structure_quality='','',L.tax_dt_structure_quality);

		self.src_water:=if(self.water='','',L.src_water);
		self.tax_dt_water:=if(self.water='','',L.tax_dt_water);

		self.src_sewer:=if(self.sewer='','',L.src_sewer);
		self.tax_dt_sewer:=if(self.sewer='','',L.tax_dt_sewer);

		self.src_assessed_land_value:=if(self.assessed_land_value='','',L.src_assessed_land_value);
		self.tax_dt_assessed_land_value:=if(self.assessed_land_value='','',L.tax_dt_assessed_land_value);

		self.src_assessed_year:=if(self.assessed_year='','',L.src_assessed_year);
		self.tax_dt_assessed_year:=if(self.assessed_year='','',L.tax_dt_assessed_year);

		self.src_tax_amount:=if(self.tax_amount='','',L.src_tax_amount);
		self.tax_dt_tax_amount:=if(self.tax_amount='','',L.tax_dt_tax_amount);

		self.src_tax_year:=if(self.tax_year='','',L.src_tax_year);

		self.src_market_land_value:=if(self.market_land_value='','',L.src_market_land_value);
		self.tax_dt_market_land_value:=if(self.market_land_value='','',L.tax_dt_market_land_value);

		self.src_improvement_value:=if(self.improvement_value='','',L.src_improvement_value);
		self.tax_dt_improvement_value:=if(self.improvement_value='','',L.tax_dt_improvement_value);

		self.src_percent_improved:=if(self.percent_improved=0,'',L.src_percent_improved);
		self.tax_dt_percent_improved:=if(self.percent_improved=0,'',L.tax_dt_percent_improved);

		self.src_total_assessed_value:=if(self.total_assessed_value='','',L.src_total_assessed_value);
		self.tax_dt_total_assessed_value:=if(self.total_assessed_value='','',L.tax_dt_total_assessed_value);

		self.src_total_calculated_value:=if(self.total_calculated_value='','',L.src_total_calculated_value);
		self.tax_dt_total_calculated_value:=if(self.total_calculated_value='','',L.tax_dt_total_calculated_value);

		self.src_total_land_value:=if(self.total_land_value='','',L.src_total_land_value);
		self.tax_dt_total_land_value:=if(self.total_land_value='','',L.tax_dt_total_land_value);

		self.src_total_market_value:=if(self.total_market_value='','',L.src_total_market_value);
		self.tax_dt_total_market_value:=if(self.total_market_value='','',L.tax_dt_total_market_value);

		self.src_floor_type:=if(self.floor_type='','',L.src_floor_type);
		self.tax_dt_floor_type:=if(self.floor_type='','',L.tax_dt_floor_type);

		self.src_frame_type:=if(self.frame_type='','',L.src_frame_type);
		self.tax_dt_frame_type:=if(self.frame_type='','',L.tax_dt_frame_type);

		self.src_no_of_bath_fixtures:=if(self.no_of_bath_fixtures='','',L.src_no_of_bath_fixtures);
		self.tax_dt_no_of_bath_fixtures:=if(self.no_of_bath_fixtures='','',L.tax_dt_no_of_bath_fixtures);

		self.src_no_of_rooms:=if(self.no_of_rooms='','',L.src_no_of_rooms);
		self.tax_dt_no_of_rooms:=if(self.no_of_rooms='','',L.tax_dt_no_of_rooms);

		self.src_no_of_units:=if(self.no_of_units='','',L.src_no_of_units);
		self.tax_dt_no_of_units:=if(self.no_of_units='','',L.tax_dt_no_of_units);

		self.src_style_type:=if(self.style_type='','',L.src_style_type);
		self.tax_dt_style_type:=if(self.style_type='','',L.tax_dt_style_type);

		self.src_assessment_document_number:=if(self.assessment_document_number='','',L.src_assessment_document_number);
		self.tax_dt_assessment_document_number:=if(self.assessment_document_number='','',L.tax_dt_assessment_document_number);

		self.src_assessment_recording_date:=if(self.assessment_recording_date='','',L.src_assessment_recording_date);
		self.tax_dt_assessment_recording_date:=if(self.assessment_recording_date='','',L.tax_dt_assessment_recording_date);

		self.src_deed_document_number:=if(self.deed_document_number='','',L.src_deed_document_number);
		self.rec_dt_deed_document_number:=if(self.deed_document_number='','',L.rec_dt_deed_document_number);

		self.src_deed_recording_date:=if(self.deed_recording_date='','',L.src_deed_recording_date);

		self.src_sale_amount:=if(self.sale_amount='','',L.src_sale_amount);
		self.rec_dt_sale_amount:=if(self.sale_amount='','',L.rec_dt_sale_amount);

		self.src_sale_date:=if(self.sale_date='','',L.src_sale_date);
		self.rec_dt_sale_date:=if(self.sale_date='','',L.rec_dt_sale_date);

		self.src_sale_type_code:=if(self.sale_type_code='','',L.src_sale_type_code);
		self.rec_dt_sale_type_code:=if(self.sale_type_code='','',L.rec_dt_sale_type_code);

		self.src_loan_amount:=if(self.loan_amount='','',L.src_loan_amount);
		self.rec_dt_loan_amount:=if(self.loan_amount='','',L.rec_dt_loan_amount);

		self.src_second_loan_amount:=if(self.second_loan_amount='','',L.src_second_loan_amount);
		self.rec_dt_second_loan_amount:=if(self.second_loan_amount='','',L.rec_dt_second_loan_amount);

		self.src_interest_rate_type_code:=if(self.interest_rate_type_code='','',L.src_interest_rate_type_code);
		self.rec_dt_interest_rate_type_code:=if(self.interest_rate_type_code='','',L.rec_dt_interest_rate_type_code);
        self:=L;
    END;
	FilterOutDefaultOutOfRange:=project(NotSingleFamily+dPropAttributeDefaultData,tDefaultFilterInvalid(left));
	FilterOutNoDefaultOutOfRange:=project(BlankPercentImproved,tDefaultFilterInvalid(left));
	//ReCombineData:=NotSingleFamily+FilterOutDefaultOutOfRange;
	NoDefault:=PropertyCharacteristics.Functions.fnCollapseAceAID(FilterOutNoDefaultOutOfRange);
	 dPropAddrCollapseAceAID	:=	PropertyCharacteristics.Functions.fnCollapseAceAID(FilterOutDefaultOutOfRange);
    PropertyCharacteristics.Mac_Property_Rollup(dPropAddrCollapseAceAID,dCombinedRollup,true,true);
	PropertyCharacteristics.Mac_Property_Rollup(NoDefault,dCombinedRollupNoDefault,true,true);
	//output(BlankPercentImproved);
    
return dCombinedRollup;
end;