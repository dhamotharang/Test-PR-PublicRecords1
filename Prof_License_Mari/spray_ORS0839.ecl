// spray ORS0839 Professional Licenses Files for MARI	   
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_ORS0839 := MODULE

	#workunit('name','Spray ORS0839'); 
	SHARED STRING7 code						:= 'ORS0839';
	//  Spray all raw files
	EXPORT S0839_SprayFiles(string pVersion) := FUNCTION
	
		//DFI - Department of Financial Institutions
		RETURN PARALLEL(
							Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Active_Businesses.csv', 'act_business','comma');
							Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Active_and_Inactive_Individuals.csv', 'all_individual','comma');
							);
	END;

END;
	   
/*	   
export spray_ORS0839 := MODULE
shared filepath		  :=	'/data_build_5_2/MARI/in/ORS0839/';	
// shared sourcepath		:=	'/data_build_5_2/MARI/';

shared maxRecordSize	:=	8192;
shared group_name	:=	'thor40_241';

shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'ORS0839::';

// filedate	:= StringLib.GetDateYYYYMMDD();
filedate	:= '11.30.10';


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
																							TRUE,
																								FALSE); 				
END;

	

//  Spray All Files
export S0839_SprayFiles :=
	PARALLEL(
		SprayFile('active_businesses'+filedate+'.txt', 'active_business.txt','tab'), 
		SprayFile('active_inactive_individuals'+filedate+'.txt', 'active_inactive_ind.txt','tab') 
	);

END;
*/