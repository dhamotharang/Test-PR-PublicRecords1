// spray MES0691 Professional Licenses Files for MARI	   

import ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   

//Files for S0691 are Located  //
export spray_MES0691 := MODULE

#workunit('name','Spray MES0691');
shared filepath		    :=	'/data/data_build_5_2/MARI/in/MES0691/';	
shared sourcepath		:=	'/data/data_build_5_2/MARI/';

shared maxRecordSize	:=	8192;
shared group_name	:=	Common_Prof_Lic_Mari.group_name;

destination := Common_Prof_Lic_Mari.SourcesFolder + 'MES0691::';

filedate	:= StringLib.GetDateYYYYMMDD();


SprayFile(string filename, string newname, string delim) := FUNCTION
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
																							TRUE,
																								FALSE); 				
END;


//  Spray All Files
export S0691_SprayFiles :=
	PARALLEL(
		SprayFile('brokers.csv', 'LENDERS','comma'), 		 
		SprayFile('Lenders.csv','BROKERS','comma') 
	);

END;