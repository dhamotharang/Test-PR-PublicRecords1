// spray SCS0852 South Carolina Real Estate Agents, Brokers, & Firm
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_SCS0852 := MODULE

	#workunit('name','Spray SCS0852');
	SHARED STRING7 code						:= 'SCS0852';
	//  Spray all raw files
	EXPORT S0852_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Active Agents.csv', 'active','comma'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Inactive Agents.csv', 'inactive','comma'),
										);
	END;

END;