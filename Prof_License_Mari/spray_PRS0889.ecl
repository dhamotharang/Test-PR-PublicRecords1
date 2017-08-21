// spray PRS0889 Puerto Rico Mortgage Lenders  
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_PRS0889 := MODULE

	#workunit('name','Spray PRS0889'); 
	SHARED STRING7 code						:= 'PRS0889';
	//  Spray all raw files
	EXPORT S0889_SprayFiles(string pVersion) := FUNCTION
	
		//DFI - Department of Financial Institutions
		RETURN PARALLEL(
							Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'BANCOS.csv', 'cbanks','comma');
							Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'IF.csv', 'lenders','comma');
							Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'IH.csv', 'lenders','comma');
							Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'PPP.csv', 'lenders','comma');
							);
	END;

END;