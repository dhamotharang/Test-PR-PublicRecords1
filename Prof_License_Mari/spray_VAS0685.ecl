// spray Virginia Bureau of Financial Institutions / Mortgage Lenders // Professional Licenses Files for MARI	   
import ut
	   ,_control
     ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   
export spray_VAS0685 := MODULE
#workunit('name','Spray VAS0685'); 
shared filepath		  :=	'/data/data_build_5_2/MARI/in/VAS0685/';	
// shared sourcepath		:=	'/data_build_5_2/MARI/';

shared maxRecordSize	:=	8192;
shared group_name	:=	Common_Prof_Lic_Mari.group_name;

shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'VAS0685::';

// filedate	:= StringLib.GetDateYYYYMMDD();


SprayFile(string filename, string newname, string delim) := FUNCTION
    
	// RETURN 	FileServices.SprayVariable(Prof_License_Mari.Common_Prof_Lic_Mari.sourceIP, 
																			// filepath + filename, 
																			// maxRecordSize,
																			// If(delim = 'tab','\\t','\\,'),'\r\n','"',
																			// Prof_License_Mari.Common_Prof_Lic_Mari.group_name, 
																			// destination + StringLib.StringToLowerCase(newname),
																			// -1,
																			// Prof_License_Mari.Common_Prof_Lic_Mari.espserverIPport,
																			// 1,
																			// true,
																					// true,
																								// false);
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\r\n','',
																		 group_name, 
																		 destination + StringLib.StringToLowerCase(newname),
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 			
END;

	

//  Spray All Files
export S0685_SprayFiles :=
	PARALLEL(
		SprayFile('AR_1449.csv', 'AR_1449_file.csv','comma'), 
		SprayFile('AR_6060.csv', 'AR_6060_file.csv','comma'), 
		SprayFile('AR_9790.csv', 'AR_9790_file.csv','comma')
	);

END;




// export spray_VAS0685 := 'todo';