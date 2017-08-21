// spray Ohio Department of Commerce Professional Licenses Files for MARI	    
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_OHS0654 := MODULE

	#workunit('name','Spray OHS0654');
	SHARED STRING7 code						:= 'OHS0654';
	//  Spray all raw files
	EXPORT S0654_SprayFiles(string pVersion) := FUNCTION
	
		//DFI - Department of Financial Institutions
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'DFI.csv', 'dfi','comma'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Real Estate and Profession Licensing.csv', 're','comma')
										);
	END;

END;
	   
/*	   
export spray_OHS0654 := MODULE
shared filepath		  :=	'/data_build_5_2/MARI/in/OHS0654/';	
// shared sourcepath		:=	'/data_build_5_2/MARI/';

shared maxRecordSize	:=	8192;
shared group_name	:=	'thor40_241';

shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'OHS0654::';

// filedate	:= StringLib.GetDateYYYYMMDD();


SprayFile(string filename, string newname, string delim) := FUNCTION
    
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																			filepath + filename, 
																			maxRecordSize,
																			If(delim = 'tab','\\t','\\,'),'\r\n','"',
																			Common_Prof_Lic_Mari.group_name, 
																			destination + StringLib.StringToLowerCase(newname),
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 	 				
END;

	

//  Spray All Files
export S0654_SprayFiles :=
	PARALLEL(
		SprayFile('Broker.txt', 'BROKER_file.txt','tab'), 
		SprayFile('Certified General Appraiser.txt','CGA_file.txt','tab'), 
		SprayFile('Certified General Appraiser - Reciprocity.txt', 'CGAR_file.txt','tab'), 
    SprayFile('Certified General Appraiser - Temporary.txt', 'CGAT_file.txt','tab'),
		SprayFile('Certified Residential Appraiser.txt', 'CRA_file.txt','tab'), 
		SprayFile('Certified Residential Appraiser - Reciprocity.txt','CRAR_file.txt','tab'), 
		SprayFile('Certified Residential Appraiser - Temporary.txt','CRAT_file.txt','tab'),
    SprayFile('Foreign Corporation.txt', 'FOREIGN_file.txt','tab'), 
    SprayFile('Licensed Residential Appraiser.txt', 'LRA_file.txt','tab'),
		SprayFile('Licensed Residential Appraiser - Reciprocity.txt', 'LRAR_file.txt','tab'), 
		SprayFile('Licensed Residential Appraiser -Temporary.txt','LRAT_file.txt','tab'),
		SprayFile('LOAN ORIGINATOR.txt', 'LO_file.txt','tab'), 
		SprayFile('MORTGAGE BROKER.txt','BRK_file.txt','tab'), 
		SprayFile('Real Estate Company.txt', 'RLC_file.txt','tab'), 
    SprayFile('Registered Appraiser Assistant.txt', 'RREAA_file.txt','tab'),
		SprayFile('Salesperson.txt', 'SALESPERSON_file.txt','tab'), 
		SprayFile('SECOND MORTGAGE.txt','SBRK_file.txt','tab') 
	);

END;
*/
