IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;
//#workunit('name','Spray Common');

EXPORT spray_common_modified := MODULE

	EXPORT spray_csv(STRING8 pVersion, STRING7 code, STRING filename, STRING delim) := FUNCTION
		filepath		    :=	Common_Prof_Lic_Mari.sourcepath + code + '/';	
		SHARED maxRecordSize	:=	8192;
		destination 					:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
		
// Strip suffix indicator		
		n := StringLib.StringFind(filename, '.',1);
 	  newname := filename[1..(n-1)];
    sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
		
		spray_file						:= FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP,
																						filepath + pVersion + '/' + filename, 
																						maxRecordSize,
																						map(delim='comma'=>',',
																								delim='tab'=>'\\t',
																								''),
																						'\r\n',
																						'',
																						Common_Prof_Lic_Mari.group_name, 
																						sprayed_file,
																						,
																						,
																						,
																						TRUE,
																						,
																						FALSE);
																						
		RETURN spray_file;																				

	END;

END;	
	
	