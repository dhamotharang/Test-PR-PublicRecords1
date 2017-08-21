// spray NVS0857 Neveda Real Estate Apprsaiser Licenses Files for MARI

IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_NVS0857 := MODULE

	#workunit('name','Spray NVS0857');
	SHARED STRING7 code						:= 'NVS0857';
	//  Spray all raw files
	EXPORT S0857_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'NRED Appraiser.csv', 'appr','comma'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'NRED Business Broker.csv', 'businessbroker','comma'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'NRED Real Estate Broker Salesperson.csv', 'brokersalesperson','comma'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'NRED Real Estate Broker.csv', 'broker','comma')
										);
	END;

END;