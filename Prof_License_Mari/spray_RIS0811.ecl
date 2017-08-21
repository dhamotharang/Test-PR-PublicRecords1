//Spray files for Rhode Island Real Estate Appraisers, Agents, Brokers - RIS0811
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_RIS0811 := MODULE

	SHARED STRING7 code						:= 'RIS0811';
	//  Spray all raw files
	EXPORT S0811_SprayFiles(string pVersion) := FUNCTION
	
		//need to add appraiser file
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Licensed_Appraisers.csv', 'apr','comma'),
		                Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Real_Estate_Brokers_Salespersons.csv', 're','comma'),
										);
	END;

END;
