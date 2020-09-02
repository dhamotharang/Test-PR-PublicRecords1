IMPORT PRTE2_PropertyInfo_Ins_MLS, PRTE2_Common_DevOnly,PRTE2_Common,PRTE2_PropertyInfo_Ins_PreMLS;

BaseLayout := PRTE2_PropertyInfo_Ins_MLS.Layouts.AlphaPropertyCSVRec_MLS;

DS_Prop := SORT(PRTE2_PropertyInfo_Ins_MLS.Files.PII_ALPHA_BASE_SF_DS,property_rid);
// CloneableDS := CHOOSEN(DS_Prop(vendor_source = 'E'),100);
CloneableDS := DS_Prop(vendor_source = 'E');

    // DS_Prop := PRTE2_PropertyInfo_Ins_MLS.Files.PII_ALPHA_BASE_SF_DS;
    EnhanceableDS1A := DS_Prop(vendor_source='A');
    EnhanceableDS1B := DS_Prop(vendor_source='B');
    EnhanceableDS1C := DS_Prop(vendor_source='C');
    EnhanceableDS1D := DS_Prop(vendor_source='D');
    // Remember, CloneableDS = source E
    GatheredToMakeRandom := CloneableDS+CloneableDS+CloneableDS+
                        EnhanceableDS1C+EnhanceableDS1C+
                        EnhanceableDS1D+EnhanceableDS1D+
                        EnhanceableDS1B;
    // the above results in DSProp=296752, ClonableDS=50920 and GatheredToMakeRandom=394208
    // the below after despray in BWR_3_Refill_Best_Values_Sources resulted in 296752
    // -----------------------------------------------------------------------------------
    EnhanceableDSa := PRTE2_Common_DevOnly.MAC_Add_Sort_Random(GatheredToMakeRandom);   // more MLS, next OKC, next FARES, next B+DEFLT
    EnhanceableDS := DISTRIBUTE(EnhanceableDSa,HASH(fares_unformatted_apn));
    CloneableDS_D := DISTRIBUTE(CloneableDS,HASH(fares_unformatted_apn));
    // FYI: Reviewed results and appears to work properly if no rows had a non-empty value.
    rowPickU (rowsInDS, fieldName) := FUNCTIONMACRO
        RETURN rowsInDS(fieldName<>0)[1];
    ENDMACRO;

    rowPick (rowsInDS, fieldName) := FUNCTIONMACRO
        RETURN rowsInDS(fieldName<>'')[1];
    ENDMACRO;

    rowPick2 (rowsInDS, fieldName) := FUNCTIONMACRO
        RETURN rowsInDS(fieldName<>'')[2];
    ENDMACRO;

    OUTPUT(CloneableDS_D(fares_unformatted_apn='1009467701'));
    OUTPUT(EnhanceableDS(fares_unformatted_apn='1009467701'));
    rightLayout := RECORDOF(EnhanceableDS);
    TestingLayout := {RECORDOF(CloneableDS_D), Dataset(rightLayout) rightRecs := Dataset([],rightLayout)};
    finalSetF := DENORMALIZE(CloneableDS_D,EnhanceableDS,
                    LEFT.fares_unformatted_apn = RIGHT.fares_unformatted_apn,
                    GROUP,
                    TRANSFORM(TestingLayout,
                            SELF.vendor_source := 'F';
                            rowsIn := SORT(ROWS(RIGHT),RND_NUM);
                            // rowsIn2 := SORT(ROWS(RIGHT),-RND_NUM);      // trying to get some randomness within the record.
                            Boolean recFound := COUNT(rowsIn)>0;

                            SELF.building_square_footage := rowPick(rowsIn, building_square_footage).building_square_footage;
                            SELF.src_building_square_footage := rowPick(rowsIn,building_square_footage).src_building_square_footage;
                            SELF.tax_dt_building_square_footage := rowPick(rowsIn,building_square_footage).tax_dt_building_square_footage;

                            SELF.air_conditioning_type := rowPick2(rowsIn,air_conditioning_type).air_conditioning_type;
                            SELF.src_air_conditioning_type := rowPick2(rowsIn,air_conditioning_type).src_air_conditioning_type;
                            SELF.tax_dt_air_conditioning_type := rowPick2(rowsIn,air_conditioning_type).tax_dt_air_conditioning_type;

                            SELF.basement_finish := rowPick(rowsIn,basement_finish).basement_finish;
                            SELF.src_basement_finish := rowPick(rowsIn,basement_finish).src_basement_finish;
                            SELF.tax_dt_basement_finish := rowPick(rowsIn,basement_finish).tax_dt_basement_finish;

                            SELF.construction_type := rowPick2(rowsIn,construction_type).construction_type;
                            SELF.src_construction_type := rowPick2(rowsIn,construction_type).src_construction_type;
                            SELF.tax_dt_construction_type := rowPick2(rowsIn,construction_type).tax_dt_construction_type;

                            SELF.exterior_wall := rowPick(rowsIn,exterior_wall).exterior_wall;
                            SELF.src_exterior_wall := rowPick(rowsIn,exterior_wall).src_exterior_wall;
                            SELF.tax_dt_exterior_wall := rowPick(rowsIn,exterior_wall).tax_dt_exterior_wall;

                            SELF.fireplace_ind := rowPick2(rowsIn,fireplace_ind).fireplace_ind;
                            SELF.src_fireplace_ind := rowPick2(rowsIn,fireplace_ind).src_fireplace_ind;
                            SELF.tax_dt_fireplace_ind := rowPick2(rowsIn,fireplace_ind).tax_dt_fireplace_ind;

                            SELF.fireplace_type := rowPick(rowsIn,fireplace_type).fireplace_type;
                            SELF.src_fireplace_type := rowPick(rowsIn,fireplace_type).src_fireplace_type;
                            SELF.tax_dt_fireplace_type := rowPick(rowsIn,fireplace_type).tax_dt_fireplace_type;

                            SELF.flood_zone_panel := rowPick2(rowsIn,flood_zone_panel).flood_zone_panel;
                            SELF.src_flood_zone_panel := rowPick2(rowsIn,flood_zone_panel).src_flood_zone_panel;
                            SELF.tax_dt_flood_zone_panel := rowPick2(rowsIn,flood_zone_panel).tax_dt_flood_zone_panel;

                            SELF.garage := rowPick(rowsIn,garage).garage;
                            SELF.src_garage := rowPick(rowsIn,garage).src_garage;
                            SELF.tax_dt_garage := rowPick(rowsIn,garage).tax_dt_garage;

                            SELF.first_floor_square_footage := rowPick2(rowsIn,first_floor_square_footage).first_floor_square_footage;
                            SELF.src_first_floor_square_footage := rowPick2(rowsIn,first_floor_square_footage).src_first_floor_square_footage;
                            SELF.tax_dt_first_floor_square_footage := rowPick2(rowsIn,first_floor_square_footage).tax_dt_first_floor_square_footage;

                            SELF.heating := rowPick(rowsIn,heating).heating;
                            SELF.src_heating := rowPick(rowsIn,heating).src_heating;
                            SELF.tax_dt_heating := rowPick(rowsIn,heating).tax_dt_heating;

                            SELF.living_area_square_footage := rowPick(rowsIn,living_area_square_footage).living_area_square_footage;
                            SELF.src_living_area_square_footage := rowPick(rowsIn,living_area_square_footage).src_living_area_square_footage;
                            SELF.tax_dt_living_area_square_footage := rowPick(rowsIn,living_area_square_footage).tax_dt_living_area_square_footage;

                            SELF.no_of_baths := rowPick(rowsIn,no_of_baths).no_of_baths;
                            SELF.src_no_of_baths := rowPick(rowsIn,no_of_baths).src_no_of_baths;
                            SELF.tax_dt_no_of_baths := rowPick(rowsIn,no_of_baths).tax_dt_no_of_baths;

                            SELF.no_of_bedrooms := rowPick2(rowsIn,no_of_bedrooms).no_of_bedrooms;
                            SELF.src_no_of_bedrooms := rowPick2(rowsIn,no_of_bedrooms).src_no_of_bedrooms;
                            SELF.tax_dt_no_of_bedrooms := rowPick2(rowsIn,no_of_bedrooms).tax_dt_no_of_bedrooms;

                            SELF.no_of_fireplaces := rowPick(rowsIn,no_of_fireplaces).no_of_fireplaces;
                            SELF.src_no_of_fireplaces := rowPick(rowsIn,no_of_fireplaces).src_no_of_fireplaces;
                            SELF.tax_dt_no_of_fireplaces := rowPick(rowsIn,no_of_fireplaces).tax_dt_no_of_fireplaces;

                            SELF.no_of_full_baths := rowPick(rowsIn,no_of_full_baths).no_of_full_baths;
                            SELF.src_no_of_full_baths := rowPick(rowsIn,no_of_full_baths).src_no_of_full_baths;
                            SELF.tax_dt_no_of_full_baths := rowPick(rowsIn,no_of_full_baths).tax_dt_no_of_full_baths;

                            SELF.no_of_half_baths := rowPick(rowsIn,no_of_half_baths).no_of_half_baths;
                            SELF.src_no_of_half_baths := rowPick(rowsIn,no_of_half_baths).src_no_of_half_baths;
                            SELF.tax_dt_no_of_half_baths := rowPick(rowsIn,no_of_half_baths).tax_dt_no_of_half_baths;

                            SELF.no_of_stories := rowPick2(rowsIn,no_of_stories).no_of_stories;
                            SELF.src_no_of_stories := rowPick2(rowsIn,no_of_stories).src_no_of_stories;
                            SELF.tax_dt_no_of_stories := rowPick2(rowsIn,no_of_stories).tax_dt_no_of_stories;

                            SELF.parking_type := rowPick(rowsIn,parking_type).parking_type;
                            SELF.src_parking_type := rowPick(rowsIn,parking_type).src_parking_type;
                            SELF.tax_dt_parking_type := rowPick(rowsIn,parking_type).tax_dt_parking_type;

                            SELF.pool_indicator := rowPick(rowsIn,pool_indicator).pool_indicator;
                            SELF.src_pool_indicator := rowPick(rowsIn,pool_indicator).src_pool_indicator;
                            SELF.tax_dt_pool_indicator := rowPick(rowsIn,pool_indicator).tax_dt_pool_indicator;

                            SELF.pool_type := rowPick(rowsIn,pool_type).pool_type;
                            SELF.src_pool_type := rowPick(rowsIn,pool_type).src_pool_type;
                            SELF.tax_dt_pool_type := rowPick(rowsIn,pool_type).tax_dt_pool_type;

                            SELF.roof_cover := rowPick2(rowsIn,roof_cover).roof_cover;
                            SELF.src_roof_cover := rowPick2(rowsIn,roof_cover).src_roof_cover;
                            SELF.tax_dt_roof_cover := rowPick2(rowsIn,roof_cover).tax_dt_roof_cover;

                            SELF.roof_type := rowPick2(rowsIn,roof_type).roof_type;
                            SELF.src_roof_type := rowPick2(rowsIn,roof_type).src_roof_type;
                            SELF.tax_dt_roof_type := rowPick2(rowsIn,roof_type).tax_dt_roof_type;

                            SELF.year_built := rowPick(rowsIn,year_built).year_built;
                            SELF.src_year_built := rowPick(rowsIn,year_built).src_year_built;
                            SELF.tax_dt_year_built := rowPick(rowsIn,year_built).tax_dt_year_built;

                            SELF.foundation := rowPick(rowsIn,foundation).foundation;
                            SELF.src_foundation := rowPick(rowsIn,foundation).src_foundation;
                            SELF.tax_dt_foundation := rowPick(rowsIn,foundation).tax_dt_foundation;

                            SELF.basement_square_footage := rowPick(rowsIn,basement_square_footage).basement_square_footage;
                            SELF.src_basement_square_footage := rowPick(rowsIn,basement_square_footage).src_basement_square_footage;
                            SELF.tax_dt_basement_square_footage := rowPick(rowsIn,basement_square_footage).tax_dt_basement_square_footage;

                            SELF.effective_year_built := rowPick2(rowsIn,effective_year_built).effective_year_built;
                            SELF.src_effective_year_built := rowPick2(rowsIn,effective_year_built).src_effective_year_built;
                            SELF.tax_dt_effective_year_built := rowPick2(rowsIn,effective_year_built).tax_dt_effective_year_built;

                            SELF.garage_square_footage := rowPick(rowsIn,garage_square_footage).garage_square_footage;
                            SELF.src_garage_square_footage := rowPick(rowsIn,garage_square_footage).src_garage_square_footage;
                            SELF.tax_dt_garage_square_footage := rowPick(rowsIn,garage_square_footage).tax_dt_garage_square_footage;

                            SELF.stories_type := rowPick(rowsIn,stories_type).stories_type;
                            SELF.src_stories_type := rowPick(rowsIn,stories_type).src_stories_type;
                            SELF.tax_dt_stories_type := rowPick(rowsIn,stories_type).tax_dt_stories_type;

                            SELF.apn_number := rowPick2(rowsIn,apn_number).apn_number;
                            SELF.src_apn_number := rowPick2(rowsIn,apn_number).src_apn_number;
                            SELF.tax_dt_apn_number := rowPick2(rowsIn,apn_number).tax_dt_apn_number;

                            SELF.census_tract := rowPick2(rowsIn,census_tract).census_tract;
                            SELF.src_census_tract := rowPick2(rowsIn,census_tract).src_census_tract;
                            SELF.tax_dt_census_tract := rowPick2(rowsIn,census_tract).tax_dt_census_tract;

                            // range will just have to stay with whatever the cloned record had, can't get compiler to accept range as a field
                            // rowBadTermRange := rowsIn(range <>'')[1];
                            // SELF.range := rowBadTermRange.range;
                            // SELF.src_range := rowBadTermRange.src_range;
                            // SELF.tax_dt_range := rowBadTermRange.tax_dt_range;

                            // cloned record (E) has nothing for range, so this is better
                            //  than nothing - at least not every record will be blank like before.
                            // BUT IT IS KILLING PROCESS
                            // bestGuessRange := EnhanceableDS1C(fares_unformatted_apn=LEFT.fares_unformatted_apn)[1];
                            // let's try this...
                            // bestGuessRange := rowsIn(vendor_source='C')[1];  // if no C then these will be blank.
                            // SELF.range := bestGuessRange.range;
                            // SELF.src_range := bestGuessRange.src_range;
                            // SELF.tax_dt_range := bestGuessRange.tax_dt_range;

                            SELF.zoning := rowPick(rowsIn,zoning).zoning;
                            SELF.src_zoning := rowPick(rowsIn,zoning).src_zoning;
                            SELF.tax_dt_zoning := rowPick(rowsIn,zoning).tax_dt_zoning;

                            SELF.block_number := rowPick(rowsIn,block_number).block_number;
                            SELF.src_block_number := rowPick(rowsIn,block_number).src_block_number;
                            SELF.tax_dt_block_number := rowPick(rowsIn,block_number).tax_dt_block_number;

                            SELF.county_name := rowPick2(rowsIn,county_name).county_name;
                            SELF.src_county_name := rowPick2(rowsIn,county_name).src_county_name;
                            SELF.tax_dt_county_name := rowPick2(rowsIn,county_name).tax_dt_county_name;

                            SELF.fips_code := rowPick(rowsIn,fips_code).fips_code;
                            SELF.src_fips_code := rowPick(rowsIn,fips_code).src_fips_code;
                            SELF.tax_dt_fips_code := rowPick(rowsIn,fips_code).tax_dt_fips_code;

                            SELF.subdivision := rowPick(rowsIn,subdivision).subdivision;
                            SELF.src_subdivision := rowPick(rowsIn,subdivision).src_subdivision;
                            SELF.tax_dt_subdivision := rowPick(rowsIn,subdivision).tax_dt_subdivision;

                            SELF.municipality := rowPick(rowsIn,municipality).municipality;
                            SELF.src_municipality := rowPick(rowsIn,municipality).src_municipality;
                            SELF.tax_dt_municipality := rowPick(rowsIn,municipality).tax_dt_municipality;

                            SELF.township := rowPick2(rowsIn,township).township;
                            SELF.src_township := rowPick2(rowsIn,township).src_township;
                            SELF.tax_dt_township := rowPick2(rowsIn,township).tax_dt_township;

                            SELF.homestead_exemption_ind := rowPick(rowsIn,homestead_exemption_ind).homestead_exemption_ind;
                            SELF.src_homestead_exemption_ind := rowPick(rowsIn,homestead_exemption_ind).src_homestead_exemption_ind;
                            SELF.tax_dt_homestead_exemption_ind := rowPick(rowsIn,homestead_exemption_ind).tax_dt_homestead_exemption_ind;

                            SELF.land_use_code := rowPick(rowsIn,land_use_code).land_use_code;
                            SELF.src_land_use_code := rowPick(rowsIn,land_use_code).src_land_use_code;
                            SELF.tax_dt_land_use_code := rowPick(rowsIn,land_use_code).tax_dt_land_use_code;

                            SELF.latitude := rowPick(rowsIn,latitude).latitude;
                            SELF.src_latitude := rowPick(rowsIn,latitude).src_latitude;
                            SELF.tax_dt_latitude := rowPick(rowsIn,latitude).tax_dt_latitude;

                            SELF.longitude := rowPick(rowsIn,longitude).longitude;
                            SELF.src_longitude := rowPick(rowsIn,longitude).src_longitude;
                            SELF.tax_dt_longitude := rowPick(rowsIn,longitude).tax_dt_longitude;

                            SELF.location_influence_code := rowPick(rowsIn,location_influence_code).location_influence_code;
                            SELF.src_location_influence_code := rowPick(rowsIn,location_influence_code).src_location_influence_code;
                            SELF.tax_dt_location_influence_code := rowPick(rowsIn,location_influence_code).tax_dt_location_influence_code;

                            SELF.acres := rowPick2(rowsIn,acres).acres;
                            SELF.src_acres := rowPick2(rowsIn,acres).src_acres;
                            SELF.tax_dt_acres := rowPick2(rowsIn,acres).tax_dt_acres;

                            SELF.lot_depth_footage := rowPick(rowsIn,lot_depth_footage).lot_depth_footage;
                            SELF.src_lot_depth_footage := rowPick(rowsIn,lot_depth_footage).src_lot_depth_footage;
                            SELF.tax_dt_lot_depth_footage := rowPick(rowsIn,lot_depth_footage).tax_dt_lot_depth_footage;

                            SELF.lot_front_footage := rowPick(rowsIn,lot_front_footage).lot_front_footage;
                            SELF.src_lot_front_footage := rowPick(rowsIn,lot_front_footage).src_lot_front_footage;
                            SELF.tax_dt_lot_front_footage := rowPick(rowsIn,lot_front_footage).tax_dt_lot_front_footage;

                            SELF.lot_number := rowPick(rowsIn,lot_number).lot_number;
                            SELF.src_lot_number := rowPick(rowsIn,lot_number).src_lot_number;
                            SELF.tax_dt_lot_number := rowPick(rowsIn,lot_number).tax_dt_lot_number;

                            SELF.lot_size := rowPick2(rowsIn,lot_size).lot_size;
                            SELF.src_lot_size := rowPick2(rowsIn,lot_size).src_lot_size;
                            SELF.tax_dt_lot_size := rowPick2(rowsIn,lot_size).tax_dt_lot_size;

                            SELF.property_type_code := rowPick(rowsIn,property_type_code).property_type_code;
                            SELF.src_property_type_code := rowPick(rowsIn,property_type_code).src_property_type_code;
                            SELF.tax_dt_property_type_code := rowPick(rowsIn,property_type_code).tax_dt_property_type_code;

                            SELF.structure_quality := rowPick(rowsIn,structure_quality).structure_quality;
                            SELF.src_structure_quality := rowPick(rowsIn,structure_quality).src_structure_quality;
                            SELF.tax_dt_structure_quality := rowPick(rowsIn,structure_quality).tax_dt_structure_quality;

                            SELF.water := rowPick(rowsIn,water).water;
                            SELF.src_water := rowPick(rowsIn,water).src_water;
                            SELF.tax_dt_water := rowPick(rowsIn,water).tax_dt_water;

                            SELF.sewer := rowPick(rowsIn,sewer).sewer;
                            SELF.src_sewer := rowPick(rowsIn,sewer).src_sewer;
                            SELF.tax_dt_sewer := rowPick(rowsIn,sewer).tax_dt_sewer;

                            SELF.assessed_land_value := rowPick(rowsIn,assessed_land_value).assessed_land_value;
                            SELF.src_assessed_land_value := rowPick(rowsIn,assessed_land_value).src_assessed_land_value;
                            SELF.tax_dt_assessed_land_value := rowPick(rowsIn,assessed_land_value).tax_dt_assessed_land_value;

                            SELF.assessed_year := rowPick(rowsIn,assessed_year).assessed_year;
                            SELF.src_assessed_year := rowPick(rowsIn,assessed_year).src_assessed_year;
                            SELF.tax_dt_assessed_year := rowPick(rowsIn,assessed_year).tax_dt_assessed_year;

                            SELF.tax_amount := rowPick(rowsIn,tax_amount).tax_amount;
                            SELF.src_tax_amount := rowPick(rowsIn,tax_amount).src_tax_amount;
                            SELF.tax_dt_tax_amount := rowPick(rowsIn,tax_amount).tax_dt_tax_amount;

                            SELF.tax_year := rowPick(rowsIn,tax_year).tax_year;
                            SELF.src_tax_year := rowPick(rowsIn,tax_year).src_tax_year;

                            SELF.market_land_value := rowPick(rowsIn,market_land_value).market_land_value;
                            SELF.src_market_land_value := rowPick(rowsIn,market_land_value).src_market_land_value;
                            SELF.tax_dt_market_land_value := rowPick(rowsIn,market_land_value).tax_dt_market_land_value;

                            SELF.improvement_value := rowPick(rowsIn,improvement_value).improvement_value;
                            SELF.src_improvement_value := rowPick(rowsIn,improvement_value).src_improvement_value;
                            SELF.tax_dt_improvement_value := rowPick(rowsIn,improvement_value).tax_dt_improvement_value;

                            SELF.percent_improved := rowPickU(rowsIn,percent_improved).percent_improved;
                            SELF.src_percent_improved := rowPickU(rowsIn,percent_improved).src_percent_improved;
                            SELF.tax_dt_percent_improved := rowPickU(rowsIn,percent_improved).tax_dt_percent_improved;

                            SELF.total_assessed_value := rowPick(rowsIn,total_assessed_value).total_assessed_value;
                            SELF.src_total_assessed_value := rowPick(rowsIn,total_assessed_value).src_total_assessed_value;
                            SELF.tax_dt_total_assessed_value := rowPick(rowsIn,total_assessed_value).tax_dt_total_assessed_value;

                            SELF.total_calculated_value := rowPick(rowsIn,total_calculated_value).total_calculated_value;
                            SELF.src_total_calculated_value := rowPick(rowsIn,total_calculated_value).src_total_calculated_value;
                            SELF.tax_dt_total_calculated_value := rowPick(rowsIn,total_calculated_value).tax_dt_total_calculated_value;

                            SELF.total_land_value := rowPick(rowsIn,total_land_value).total_land_value;
                            SELF.src_total_land_value := rowPick(rowsIn,total_land_value).src_total_land_value;
                            SELF.tax_dt_total_land_value := rowPick(rowsIn,total_land_value).tax_dt_total_land_value;

                            SELF.total_market_value := rowPick(rowsIn,total_market_value).total_market_value;
                            SELF.src_total_market_value := rowPick(rowsIn,total_market_value).src_total_market_value;
                            SELF.tax_dt_total_market_value := rowPick(rowsIn,total_market_value).tax_dt_total_market_value;

                            SELF.floor_type := rowPick(rowsIn,floor_type).floor_type;
                            SELF.src_floor_type := rowPick(rowsIn,floor_type).src_floor_type;
                            SELF.tax_dt_floor_type := rowPick(rowsIn,floor_type).tax_dt_floor_type;

                            SELF.frame_type := rowPick(rowsIn,frame_type).frame_type;
                            SELF.src_frame_type := rowPick(rowsIn,frame_type).src_frame_type;
                            SELF.tax_dt_frame_type := rowPick(rowsIn,frame_type).tax_dt_frame_type;

                            SELF.fuel_type := rowPick(rowsIn,fuel_type).fuel_type;
                            SELF.src_fuel_type := rowPick(rowsIn,fuel_type).src_fuel_type;
                            SELF.tax_dt_fuel_type := rowPick(rowsIn,fuel_type).tax_dt_fuel_type;

                            SELF.no_of_bath_fixtures := rowPick(rowsIn,no_of_bath_fixtures).no_of_bath_fixtures;
                            SELF.src_no_of_bath_fixtures := rowPick(rowsIn,no_of_bath_fixtures).src_no_of_bath_fixtures;
                            SELF.tax_dt_no_of_bath_fixtures := rowPick(rowsIn,no_of_bath_fixtures).tax_dt_no_of_bath_fixtures;

                            SELF.no_of_rooms := rowPick(rowsIn,no_of_rooms).no_of_rooms;
                            SELF.src_no_of_rooms := rowPick(rowsIn,no_of_rooms).src_no_of_rooms;
                            SELF.tax_dt_no_of_rooms := rowPick(rowsIn,no_of_rooms).tax_dt_no_of_rooms;

                            SELF.no_of_units := rowPick(rowsIn,no_of_units).no_of_units;
                            SELF.src_no_of_units := rowPick(rowsIn,no_of_units).src_no_of_units;
                            SELF.tax_dt_no_of_units := rowPick(rowsIn,no_of_units).tax_dt_no_of_units;

                            SELF.style_type := rowPick(rowsIn,style_type).style_type;
                            SELF.src_style_type := rowPick(rowsIn,style_type).src_style_type;
                            SELF.tax_dt_style_type := rowPick(rowsIn,style_type).tax_dt_style_type;

                            SELF.assessment_document_number := rowPick(rowsIn,assessment_document_number).assessment_document_number;
                            SELF.src_assessment_document_number := rowPick(rowsIn,assessment_document_number).src_assessment_document_number;
                            SELF.tax_dt_assessment_document_number := rowPick(rowsIn,assessment_document_number).tax_dt_assessment_document_number;

                            SELF.assessment_recording_date := rowPick(rowsIn,assessment_recording_date).assessment_recording_date;
                            SELF.src_assessment_recording_date := rowPick(rowsIn,assessment_recording_date).src_assessment_recording_date;
                            SELF.tax_dt_assessment_recording_date := rowPick(rowsIn,assessment_recording_date).tax_dt_assessment_recording_date;

                            SELF.deed_document_number := rowPick(rowsIn,deed_document_number).deed_document_number;
                            SELF.src_deed_document_number := rowPick(rowsIn,deed_document_number).src_deed_document_number;
                            SELF.rec_dt_deed_document_number := rowPick(rowsIn,deed_document_number).rec_dt_deed_document_number;

                            SELF.deed_recording_date := rowPick(rowsIn,deed_recording_date).deed_recording_date;
                            SELF.src_deed_recording_date := rowPick(rowsIn,deed_recording_date).src_deed_recording_date;

                            SELF.full_part_sale := rowPick(rowsIn,full_part_sale).full_part_sale;
                            SELF.src_full_part_sale := rowPick(rowsIn,full_part_sale).src_full_part_sale;
                            SELF.rec_dt_full_part_sale := rowPick(rowsIn,full_part_sale).rec_dt_full_part_sale;

                            SELF.sale_amount := rowPick(rowsIn,sale_amount).sale_amount;
                            SELF.src_sale_amount := rowPick(rowsIn,sale_amount).src_sale_amount;
                            SELF.rec_dt_sale_amount := rowPick(rowsIn,sale_amount).rec_dt_sale_amount;

                            SELF.sale_date := rowPick(rowsIn,sale_date).sale_date;
                            SELF.src_sale_date := rowPick(rowsIn,sale_date).src_sale_date;
                            SELF.rec_dt_sale_date := rowPick(rowsIn,sale_date).rec_dt_sale_date;

                            SELF.sale_type_code := rowPick(rowsIn,sale_type_code).sale_type_code;
                            SELF.src_sale_type_code := rowPick(rowsIn,sale_type_code).src_sale_type_code;
                            SELF.rec_dt_sale_type_code := rowPick(rowsIn,sale_type_code).rec_dt_sale_type_code;

                            SELF.mortgage_company_name := rowPick(rowsIn,mortgage_company_name).mortgage_company_name;
                            SELF.src_mortgage_company_name := rowPick(rowsIn,mortgage_company_name).src_mortgage_company_name;
                            SELF.rec_dt_mortgage_company_name := rowPick(rowsIn,mortgage_company_name).rec_dt_mortgage_company_name;

                            SELF.loan_amount := rowPick(rowsIn,loan_amount).loan_amount;
                            SELF.src_loan_amount := rowPick(rowsIn,loan_amount).src_loan_amount;
                            SELF.rec_dt_loan_amount := rowPick(rowsIn,loan_amount).rec_dt_loan_amount;

                            SELF.second_loan_amount := rowPick(rowsIn,second_loan_amount).second_loan_amount;
                            SELF.src_second_loan_amount := rowPick(rowsIn,second_loan_amount).src_second_loan_amount;
                            SELF.rec_dt_second_loan_amount := rowPick(rowsIn,second_loan_amount).rec_dt_second_loan_amount;

                            SELF.loan_type_code := rowPick(rowsIn,loan_type_code).loan_type_code;
                            SELF.src_loan_type_code := rowPick(rowsIn,loan_type_code).src_loan_type_code;
                            SELF.rec_dt_loan_type_code := rowPick(rowsIn,loan_type_code).rec_dt_loan_type_code;

                            SELF.interest_rate_type_code := rowPick(rowsIn,interest_rate_type_code).interest_rate_type_code;
                            SELF.src_interest_rate_type_code := rowPick(rowsIn,interest_rate_type_code).src_interest_rate_type_code;
                            SELF.rec_dt_interest_rate_type_code := rowPick(rowsIn,interest_rate_type_code).rec_dt_interest_rate_type_code;
                    SELF.rightRecs := rowsIn;
                    SELF := left), local);
// OUTPUT(finalSetF);
finalSetF2 := PROJECT(finalSetF,RECORDOF(CloneableDS_D));
// -------------------------------------------------------------------------------------
EXPORT_DS := SORT(finalSetF2,fares_unformatted_apn,vendor_source);
// -------------------------------------------------------------------------------------
dateString 		:= PRTE2_Common.Constants.TodayString;
desprayName 	:= 'PropertyInfo_3_Refill_BestOnly_'+dateString+'.csv';
lzFilePathFile	:= PRTE2_PropertyInfo_Ins_PreMLS.Constants.SourcePathForPIICSV + desprayName;
LandingZoneIP 	:= PRTE2_PropertyInfo_Ins_PreMLS.Constants.LandingZoneIP;
TempCSV			:= PRTE2_PropertyInfo_Ins_PreMLS.Files.Alpha_Spray_Name;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathFile);