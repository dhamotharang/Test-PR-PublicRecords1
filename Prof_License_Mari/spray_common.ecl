// spray file from source to destination, create super file in sprayed directory, and link the sprayed file to the super file 
//#workunit('name','Spray Common');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_common := MODULE

	EXPORT spray_csv(STRING8 pVersion, STRING7 code, STRING filename, STRING newname, STRING delim) := FUNCTION

		filepath		    :=	Common_Prof_Lic_Mari.sourcepath + code + '/';	
		SHARED maxRecordSize	:=	8192;
		destination 					:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
		sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(filename);

		spray_file						:= FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP,
																						filepath + pVersion + '/' + filename, 
																						maxRecordSize,
																						map(delim='comma'=>',',
																								delim='tab'=>'\\t',
																								delim='percent' =>'%',
																								delim='semi' => ';',
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
																				
		//Create a superfile in specified directory if it does not already exists. Clear it if it already exists.
		//Do no clear super file. 2/28/13 Cathy
		dest_file := destination + 'sprayed::' + newname;
		create_super :=	IF(NOT FileServices.SuperFileExists(dest_file), FileServices.CreateSuperFile(dest_file));
				
		add_to_super := SEQUENTIAL(				 
												FileServices.StartSuperFileTransaction();
												FileServices.AddSuperFile(dest_file, sprayed_file);
												FileServices.FinishSuperFileTransaction();
												);
		RETURN SEQUENTIAL(spray_file, create_super, add_to_super);

	END;
	
END;