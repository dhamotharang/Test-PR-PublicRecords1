IMPORT PhonesPlus_V2;
EXPORT Prep_Source_Level_Ingest := FUNCTION
//this is a placeholder module to have a default dataset for Ingest if the infile parameter is not passed

		dsBaseDetail := DATASET([], PhonesPlus_V2.Layout_Source_Level_Base);
	
		RETURN dsBaseDetail;																								

END;