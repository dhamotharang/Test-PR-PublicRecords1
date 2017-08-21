IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_SDS0844 := MODULE

	#workunit('name','Spray  spray_SDS0844'); 
	SHARED STRING7 code						:= 'SDS0844';
	//  Spray all raw files
	EXPORT S0844_SprayFiles(string pVersion) := FUNCTION
	
		//need to add appraiser file
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'SDRECLicenseExport.csv', 'rle_license','comma'),
										);
	END;

END;	   
