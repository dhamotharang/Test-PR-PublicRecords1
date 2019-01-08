// EXPORT U_Study_Localized_Averages := 'todo';

//---------------------------------------------------------------------
// PRTE2_PropertyInfo.BWR_Despray_Base
//  - despray the Property Info base file for editing.
//---------------------------------------------------------------------
// NOTE: The CSV name "PropertyInfo_V2" is to indicate we totally altered
//  the main layouts removed gateway and editable_spreadsheet layouts
//---------------------------------------------------------------------

IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo as PII;
#workunit('name', 'Boca CT PropertyInfo Despray');

dateString := ut.GetDate;
LandUseFilterSet := ['SFR','AGR','VNY','HSR','RNH','RVL','RES','RRR','RWH','COO','CLH','BGW','HST', 'PPT', 'PRS','ZLL',''];  

DS_IN1				:= PII.Files.PII_ALPHA_BASE_SF_DS_Prod(vendor_source = 'B');
DS_IN					:= DS_IN1(land_use_code in LandUseFilterSet);

//------------------------------------------------------------
report00 := RECORD
	recTypeSrc	 := DS_IN.no_of_rooms;
	GroupCount := COUNT(GROUP);
END;
RepTable00 := TABLE(DS_IN,report00,no_of_rooms);
OUTPUT(SORT(RepTable00,-GroupCount),NAMED('no_of_rooms'),ALL);
//------------------------------------------------------------
report0 := RECORD
	recTypeSrc	 := DS_IN.air_conditioning_type;
	GroupCount := COUNT(GROUP);
END;
RepTable0 := TABLE(DS_IN,report0,air_conditioning_type);
OUTPUT(SORT(RepTable0,-GroupCount),NAMED('air_conditioning_type'),ALL);
//------------------------------------------------------------
report1 := RECORD
	recTypeSrc	 := DS_IN.construction_type;
	GroupCount := COUNT(GROUP);
END;
RepTable1 := TABLE(DS_IN,report1,construction_type);
OUTPUT(SORT(RepTable1,-GroupCount),NAMED('construction_type'),ALL);
//------------------------------------------------------------

report2 := RECORD
	recTypeSrc	 := DS_IN.exterior_wall;
	GroupCount := COUNT(GROUP);
END;
RepTable2 := TABLE(DS_IN,report2,exterior_wall);
OUTPUT(SORT(RepTable2,-GroupCount),NAMED('exterior_wall'),ALL);
//------------------------------------------------------------

report3 := RECORD
	recTypeSrc	 := DS_IN.garage;
	GroupCount := COUNT(GROUP);
END;
RepTable3 := TABLE(DS_IN,report3,garage);
OUTPUT(SORT(RepTable3,-GroupCount),NAMED('garage'),ALL);
//------------------------------------------------------------

report4 := RECORD
	recTypeSrc	 := DS_IN.heating;
	GroupCount := COUNT(GROUP);
END;
RepTable4 := TABLE(DS_IN,report4,heating);
OUTPUT(SORT(RepTable4,-GroupCount),NAMED('heating'),ALL);
//------------------------------------------------------------

report5 := RECORD
	recTypeSrc	 := DS_IN.foundation;
	GroupCount := COUNT(GROUP);
END;
RepTable5 := TABLE(DS_IN,report5,foundation);
OUTPUT(SORT(RepTable5,-GroupCount),NAMED('foundation'),ALL);
//------------------------------------------------------------

report6 := RECORD
	recTypeSrc	 := DS_IN.floor_type;
	GroupCount := COUNT(GROUP);
END;
RepTable6 := TABLE(DS_IN,report6,floor_type);
OUTPUT(SORT(RepTable6,-GroupCount),NAMED('floor_type'),ALL);
//------------------------------------------------------------

report7 := RECORD
	recTypeSrc	 := DS_IN.roof_cover;
	GroupCount := COUNT(GROUP);
END;
RepTable7 := TABLE(DS_IN,report7,roof_cover);
OUTPUT(SORT(RepTable7,-GroupCount),NAMED('roof_cover'),ALL);
//------------------------------------------------------------
// OUTPUT(MIN(DS_IN((INTEGER)building_square_footage>0),(INTEGER)building_square_footage),NAMED('MIN_building_sq_footage'));
// OUTPUT(MAX(DS_IN,(INTEGER)building_square_footage),NAMED('MAX_building_sq_footage'));
// OUTPUT(MIN(DS_IN((INTEGER)no_of_baths>0),(INTEGER)no_of_baths),NAMED('MIN_no_of_baths'));
// OUTPUT(MAX(DS_IN,(INTEGER)no_of_baths),NAMED('MAX_no_of_baths'));
// OUTPUT(MIN(DS_IN((INTEGER)no_of_bedrooms>0),(INTEGER)no_of_bedrooms),NAMED('MIN_no_of_bedrooms'));
// OUTPUT(MAX(DS_IN,(INTEGER)no_of_bedrooms),NAMED('MAX_no_of_bedrooms'));
// OUTPUT(MIN(DS_IN((INTEGER)no_of_fireplaces>0),(INTEGER)no_of_fireplaces),NAMED('MIN_no_of_fireplaces'));
// OUTPUT(MAX(DS_IN,(INTEGER)no_of_fireplaces),NAMED('MAX_no_of_fireplaces'));
// OUTPUT(MIN(DS_IN((INTEGER)no_of_stories>0),(INTEGER)no_of_stories),NAMED('MIN_no_of_stories'));
// OUTPUT(MAX(DS_IN,(INTEGER)no_of_stories),NAMED('MAX_no_of_stories'));
// OUTPUT(MIN(DS_IN((INTEGER)year_built>0),(INTEGER)year_built),NAMED('MIN_year_built'));
// OUTPUT(MAX(DS_IN,(INTEGER)year_built),NAMED('MAX_year_built'));
// OUTPUT(MIN(DS_IN((INTEGER)garage_square_footage>0),(INTEGER)garage_square_footage),NAMED('MIN_garage_square_footage'));
// OUTPUT(MAX(DS_IN,(INTEGER)garage_square_footage),NAMED('MAX_garage_square_footage'));
// OUTPUT(MIN(DS_IN((INTEGER)total_assessed_value>0),(INTEGER)total_assessed_value),NAMED('MIN_total_assessed_value'));
// OUTPUT(MAX(DS_IN,(INTEGER)total_assessed_value),NAMED('MAX_total_assessed_value'));

//------------------------------------------------------------


OUTPUT(DS_IN);
OUTPUT(COUNT(DS_IN));
OUTPUT(COUNT(DS_IN1));
OUTPUT(COUNT(PII.Files.PII_ALPHA_BASE_SF_DS_Prod));

