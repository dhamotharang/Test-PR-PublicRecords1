// PRTE2_PropertyInfo.U_Localized_Averages_DOIT

/* 
***********************************************************************************
Logic in the query or ESP:
				L.A. cannot be used if Source A (300) OR Source B (200) is available
        if either A or B is present, localized averaging CANNOT be used
				see 'DEFLT' and set that Confidence Factor = 900 
    Which records are touched?
        Only records that are OKCTY source
        It is available in all 50 states and DC
        Localized averaging falls under Source B in a property report
        Only if Land_use := ['' (empty), 'SFR','AGR','VNY','HSR','RNH','RVL','RES','RRR','RWH','COO','CLH','BGW','HST', 'PPT', 'PRS','ZLL',''];   (added '' EG: Blank)

    Which fields are touched?
        if any of the 17 below are blank, then fill them with some fake localized average.
        set the source = 'DEFLT'
    ONE THOUGHT - only do 10 per state?  no decided not
        It is easier to just push thru any records that qualify above and any fields that qualify above
***********************************************************************************
*/

IMPORT PRTE2_Common, ut,STD;
IMPORT PRTE2_PropertyInfo, PropertyCharacteristics;
#workunit('name', 'Boca CT PropertyInfo Despray');

dateString := ut.GetDate+'';
LandingZoneIP 		:= PRTE2_PropertyInfo.Constants.LandingZoneIP;
TempCSV						:= PRTE2_PropertyInfo.Files.PII_CSV_FILE + '::' +  WORKUNIT;

ExportName1 := PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + 'PropInfo_noChanges_'+dateString+'.csv';
ExportName2a := PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + 'PropInfo_Pre_Enhanced_'+dateString+'.csv';
ExportName2 := PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + 'PropInfo_Enhanced_'+dateString+'.csv';
ExportName3 := PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + 'PropInfo_all_'+dateString+'.csv';

LandUseFilterSet 	:= ['SFR','AGR','VNY','HSR','RNH','RVL','RES','RRR','RWH','COO','CLH','BGW','HST', 'PPT', 'PRS','ZLL',''];  
DS_IN1						:= PRTE2_PropertyInfo.Files.PII_ALPHA_BASE_SF_DS_Prod(vendor_source = 'B');
DS_IN2a						:= PRTE2_PropertyInfo.Files.PII_ALPHA_BASE_SF_DS_Prod(vendor_source <> 'B');
DS_IN2b						:= DS_IN1(land_use_code not in LandUseFilterSet);
DS_NoChanges			:= DS_IN2a+DS_IN2b;

DS_IN							:= DS_IN1(land_use_code in LandUseFilterSet);
// DS_IN							:= PRTE2_PropertyInfo.Files.PII_ALPHA_BASE_SF_DS_Prod(land_use_code in LandUseFilterSet);

//----------- GLOBALS -------------------------------------------------
cleanValue(STRING someValue) := PropertyCharacteristics.Functions.fn_remove_zeroes(someValue);
isEMPTY(STRING s1) := cleanValue(s1)='';
isNumGT10(STRING s1) := ( (INTEGER)s1 > 10);
ReplaceIF(STRING s1, STRING s2) := IF(isEMPTY(s1), s2, s1);							// check s1, either keep it or return s2
ReplaceIF3(STRING s1, STRING s2, STRING s3) := IF(isEMPTY(s1), s3, s2);	// check s1, then return either s2 or 3
isTargetStory(STRING s1) := (s1='0.5' OR s1='1.3' OR s1='1.4' OR s1[1..3]='1.6' OR s1[1..3]='1.7'  OR s1[1..3]='1.8');
ReplaceNumStory(String s1, STRING s2) := IF( isTargetStory(s1), S2, S1 );		 //OR isNumGT10(s1)
ReplaceNumStory3(STRING s1, STRING s2, STRING s3) := IF(isTargetStory(s1), s3, s2);	// check s1, then return either s2 or 3
fakeSOURCE := 'DEFLT';
fakeTaxDate := '';			// Terri says leave tax year blank 

//----------- TRANSFORM1 -------------------------------------------------
DS_IN transfrmIN1( DS_IN L ) := TRANSFORM
			FindRandomBSF := PRTE2_PropertyInfo.U_Localized_Averages_Sets.BUILDING_SQ_FT_RANDOM;
			SELF.building_square_footage := ReplaceIF(L.building_square_footage, FindRandomBSF);
			SELF.src_building_square_footage := ReplaceIF3(L.building_square_footage, L.src_building_square_footage, fakeSOURCE);
			SELF.tax_dt_building_square_footage := ReplaceIF3(L.building_square_footage, L.tax_dt_building_square_footage, fakeTAXDate);
			SELF := L;
END;
//----------- TRANSFORM2 -------------------------------------------------
DS_IN transfrmIN2( DS_IN L ) := TRANSFORM		
			
			STRING final_building_square_footage 	:= L.building_square_footage;
			STRING fake_garage_square_footage 		:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.GARAGE_SQ_FT_RANDOM(final_building_square_footage);
			STRING fake_no_of_stories 						:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_STORIES_RANDOM(final_building_square_footage);
			STRING fake_no_of_baths 							:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_BATHS_RANDOM(final_building_square_footage);
			STRING fake_no_of_bedrooms 						:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_BEDROOMS_RANDOM(final_building_square_footage);
			STRING fake_no_of_rooms								:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_OF_ROOMS_RANDOM(final_building_square_footage);

			STRING fake_no_of_fireplaces 					:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_FIREPLACE_RANDOM;
			STRING fake_total_assessed_value 			:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.ASSESS_VALUE_RANDOM;
			STRING fake_year_built 								:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.YEAR_BUILT_RANDOM;

			STRING fake_air_conditioning_type 		:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.AIR_COND_TYPE_RANDOM;
			STRING fake_construction_type 				:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.CONSTR_TYPE_RANDOM;
			STRING fake_exterior_wall 						:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.EXTERIOR_WALL_RANDOM;
			STRING fake_garage  									:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.GARAGE_TYPE_RANDOM;
			STRING fake_foundation  							:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.FOUNDATION_RANDOM;
			STRING fake_floor_type 								:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.FLOOR_TYPE_RANDOM;
			STRING fake_roof_cover  							:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.ROOF_COVER_RANDOM;
			STRING fake_heating  									:= PRTE2_PropertyInfo.U_Localized_Averages_Sets.HEAT_TYPE_RANDOM;

			SELF.building_square_footage 			:= L.building_square_footage;	// Keeping values from first pass
			SELF.air_conditioning_type 				:= ReplaceIF(L.air_conditioning_type, fake_air_conditioning_type);
			SELF.construction_type 						:= ReplaceIF(L.construction_type, fake_construction_type);
			SELF.exterior_wall 								:= ReplaceIF(L.exterior_wall, fake_exterior_wall);
			SELF.floor_type 									:= ReplaceIF(L.floor_type, fake_floor_type);
			SELF.foundation 									:= ReplaceIF(L.foundation, fake_foundation);
			SELF.garage 											:= ReplaceIF(L.garage, fake_garage);
			SELF.heating 											:= ReplaceIF(L.heating, fake_heating);
			SELF.garage_square_footage 				:= ReplaceIF(L.garage_square_footage, fake_garage_square_footage);
			SELF.no_of_baths 									:= ReplaceIF(L.no_of_baths, fake_no_of_baths);
			SELF.no_of_bedrooms 							:= ReplaceIF(L.no_of_bedrooms, fake_no_of_bedrooms);
			SELF.no_of_fireplaces 						:= ReplaceIF(L.no_of_fireplaces, fake_no_of_fireplaces);
			SELF.no_of_stories 								:= ReplaceNumStory(L.no_of_stories, fake_no_of_stories);
			SELF.roof_cover 									:= ReplaceIF(L.roof_cover, fake_roof_cover);
			SELF.total_assessed_value 				:= ReplaceIF(L.total_assessed_value, fake_total_assessed_value);
			SELF.year_built 									:= ReplaceIF(L.year_built, fake_year_built);		
			SELF.no_of_rooms 									:= ReplaceIF(L.no_of_rooms, fake_no_of_rooms);		

			// SELF.src_building_square_footage 			
			SELF.src_air_conditioning_type 		:= ReplaceIF3(L.air_conditioning_type, L.src_air_conditioning_type, fakeSOURCE);
			SELF.src_construction_type 				:= ReplaceIF3(L.construction_type, L.src_construction_type, fakeSOURCE);
			SELF.src_exterior_wall 						:= ReplaceIF3(L.exterior_wall, L.src_exterior_wall, fakeSOURCE);
			SELF.src_floor_type 							:= ReplaceIF3(L.floor_type, L.src_floor_type, fakeSOURCE);
			SELF.src_foundation 							:= ReplaceIF3(L.foundation, L.src_foundation, fakeSOURCE);
			SELF.src_garage 									:= ReplaceIF3(L.garage, L.src_garage, fakeSOURCE);
			SELF.src_garage_square_footage 		:= ReplaceIF3(L.garage_square_footage, L.src_garage_square_footage, fakeSOURCE);
			SELF.src_heating 									:= ReplaceIF3(L.heating, L.src_heating, fakeSOURCE);
			SELF.src_no_of_baths 							:= ReplaceIF3(L.no_of_baths, L.src_no_of_baths, fakeSOURCE);
			SELF.src_no_of_bedrooms 					:= ReplaceIF3(L.no_of_bedrooms, L.src_no_of_bedrooms, fakeSOURCE);
			SELF.src_no_of_fireplaces 				:= ReplaceIF3(L.no_of_fireplaces, L.src_no_of_fireplaces, fakeSOURCE);
			SELF.src_no_of_stories 						:= ReplaceNumStory3(L.no_of_stories, L.src_no_of_stories, fakeSOURCE);
			SELF.src_roof_cover 							:= ReplaceIF3(L.roof_cover, L.src_roof_cover, fakeSOURCE);
			SELF.src_total_assessed_value 		:= ReplaceIF3(L.total_assessed_value, L.src_total_assessed_value, fakeSOURCE);
			SELF.src_year_built 							:= ReplaceIF3(L.year_built, L.src_year_built, fakeSOURCE);
			SELF.src_no_of_rooms 							:= ReplaceIF3(L.no_of_rooms, L.src_no_of_rooms, fakeSOURCE);		

			// SELF.tax_dt_building_square_footage 			
			SELF.tax_dt_air_conditioning_type := ReplaceIF3(L.air_conditioning_type, L.tax_dt_air_conditioning_type, fakeTAXDate);
			SELF.tax_dt_construction_type 		:= ReplaceIF3(L.construction_type, L.tax_dt_construction_type, fakeTAXDate);
			SELF.tax_dt_exterior_wall 				:= ReplaceIF3(L.exterior_wall, L.tax_dt_exterior_wall, fakeTAXDate);
			SELF.tax_dt_floor_type 						:= ReplaceIF3(L.floor_type, L.tax_dt_floor_type, fakeTAXDate);
			SELF.tax_dt_foundation 						:= ReplaceIF3(L.foundation, L.tax_dt_foundation, fakeTAXDate);
			SELF.tax_dt_garage 								:= ReplaceIF3(L.garage, L.tax_dt_garage, fakeTAXDate);
			SELF.tax_dt_garage_square_footage	:= ReplaceIF3(L.garage_square_footage, L.tax_dt_garage_square_footage, fakeTAXDate);
			SELF.tax_dt_heating 							:= ReplaceIF3(L.heating, L.tax_dt_heating, fakeTAXDate);
			SELF.tax_dt_no_of_baths 					:= ReplaceIF3(L.no_of_baths, L.tax_dt_no_of_baths, fakeTAXDate);
			SELF.tax_dt_no_of_bedrooms 				:= ReplaceIF3(L.no_of_bedrooms, L.tax_dt_no_of_bedrooms, fakeTAXDate);
			SELF.tax_dt_no_of_fireplaces 			:= ReplaceIF3(L.no_of_fireplaces, L.tax_dt_no_of_fireplaces, fakeTAXDate);
			SELF.tax_dt_no_of_stories 				:= ReplaceNumStory3(L.no_of_stories, L.tax_dt_no_of_stories, fakeTAXDate);
			SELF.tax_dt_roof_cover 						:= ReplaceIF3(L.roof_cover, L.tax_dt_roof_cover, fakeTAXDate);
			SELF.tax_dt_total_assessed_value	:= ReplaceIF3(L.total_assessed_value, L.tax_dt_total_assessed_value, fakeTAXDate);
			SELF.tax_dt_year_built 						:= ReplaceIF3(L.year_built, L.tax_dt_year_built, fakeTAXDate);
			SELF.tax_dt_no_of_rooms 					:= ReplaceIF3(L.no_of_rooms, L.tax_dt_no_of_rooms, fakeTAXDate);		

			SELF := L;
END;
//-----------------------------------------------------------------------------------------------------
	DS_IN_enh1 := PROJECT(DS_IN, transfrmIN1(LEFT));
	DS_Enhanced := PROJECT(DS_IN_enh1, transfrmIN2(LEFT));
	EXPORT_DS := DS_NoChanges+DS_Enhanced;		// + no_change_DS;
/*	
	dOthers	:=	dPropCleanFields(vendor_source	=	'B');
	// Populate default data for property characteristics
	// PropertyCharacteristics.Populate_Property_LA_Data.Mac_Populate_Default_Data(dOthers,dPropCharDefaultData);	
	dOthers_srt := sort(distribute(dOthers,hash(st, county,geo_blk,zip, zip4)),st, county,geo_blk,zip, zip4,local);

	
	PropertyCharacteristics.Proc_Build_Base
	PropertyCharacteristics.Populate_Default_Data.Mac_Populate_Default_Data(dOthers,dPropCharDefaultData);
	PropertyCharacteristics.Populate_Default_Data.Mac_Populate_Attribute_Default_Data(dPropCharDefaultData,dPropAttributeDefaultData);
*/

//---------------------------------------------------------------------

PRTE2_Common.DesprayCSV(SORT(DS_NoChanges,Property_RID), TempCSV, LandingZoneIP, ExportName1);
PRTE2_Common.DesprayCSV(SORT(DS_IN,Property_RID), TempCSV, LandingZoneIP, ExportName2a);
PRTE2_Common.DesprayCSV(SORT(DS_Enhanced,Property_RID), TempCSV, LandingZoneIP, ExportName2);
PRTE2_Common.DesprayCSV(SORT(EXPORT_DS,Property_RID), TempCSV, LandingZoneIP, ExportName3);


//---------------------------------------------------------------------

