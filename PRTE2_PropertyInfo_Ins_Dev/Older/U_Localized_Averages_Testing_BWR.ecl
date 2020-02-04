
IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo;

//---------------------------------------------------------------------

//---------------------------------------------------------------------
// Numeric fields
fake_building_square_footage := PRTE2_PropertyInfo.U_Localized_Averages_Sets.BUILDING_SQ_FT_RANDOM :GLOBAL;
fake_garage_square_footage 	:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.GARAGE_SQ_FT_RANDOM(fake_building_square_footage);
fake_no_of_stories 					:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_STORIES_RANDOM(fake_building_square_footage);
fake_no_of_bedrooms 				:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_BEDROOMS_RANDOM(fake_building_square_footage);
fake_no_of_rooms						:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_OF_ROOMS_RANDOM(fake_building_square_footage);
fake_no_of_baths 						:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_BATHS_RANDOM(fake_building_square_footage);
fake_no_of_fireplaces 			:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_FIREPLACE_RANDOM;
fake_total_assessed_value 	:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.ASSESS_VALUE_RANDOM;
fake_year_built 						:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.YEAR_BUILT_RANDOM;

// Codes

fake_air_conditioning_type 	:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.AIR_COND_TYPE_RANDOM;
fake_construction_type 			:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.CONSTR_TYPE_RANDOM;
fake_exterior_wall 					:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.EXTERIOR_WALL_RANDOM;
fake_garage  							:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.GARAGE_TYPE_RANDOM;
fake_heating  						:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.HEAT_TYPE_RANDOM;
fake_foundation  					:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.FOUNDATION_RANDOM;
fake_floor_type 					:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.FLOOR_TYPE_RANDOM;
fake_roof_cover  					:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.ROOF_COVER_RANDOM;
// fuel_type?
// fireplace_type?
// parking_type?
// basement_finish?

//	NOTE: above if you do not mark calls that use RAND above as :GLOBAL then RAND is performed each time it's referenced
OUTPUT(fake_building_square_footage,NAMED('fake_building_square_footage'));
OUTPUT(fake_garage_square_footage,NAMED('fake_garage_square_footage'));
OUTPUT(fake_no_of_fireplaces,NAMED('fake_no_of_fireplaces'));
OUTPUT(fake_no_of_stories,NAMED('fake_no_of_stories'));
OUTPUT(fake_total_assessed_value,NAMED('fake_total_assessed_value'));
OUTPUT(fake_no_of_baths,NAMED('fake_no_of_baths'));
OUTPUT(fake_no_of_bedrooms,NAMED('fake_no_of_bedrooms'));
OUTPUT(fake_year_built,NAMED('fake_year_built'));
OUTPUT(fake_air_conditioning_type,NAMED('fake_air_conditioning_type'));
OUTPUT(fake_construction_type,NAMED('fake_construction_type'));
OUTPUT(fake_exterior_wall,NAMED('fake_exterior_wall'));
OUTPUT(fake_floor_type,NAMED('fake_floor_type'));
OUTPUT(fake_foundation,NAMED('fake_foundation'));
OUTPUT(fake_garage,NAMED('fake_garage'));
OUTPUT(fake_heating,NAMED('fake_heating'));
OUTPUT(fake_roof_cover,NAMED('fake_roof_cover'));
//---------------------------------------------------------------------