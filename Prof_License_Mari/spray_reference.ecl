IMPORT ut, _control, Prof_License_Mari, STD, lib_stringlib,Lib_date;

EXPORT spray_reference := MODULE

	EXPORT spray_csv(STRING pVersion, STRING filename, STRING newname, STRING delim) := FUNCTION
		filepath		    			:=	Common_Prof_Lic_Mari.referpath;	
		SHARED maxRecordSize	:=	8192;
		destination 					:= Common_Prof_Lic_Mari.SourcesFolder;
		sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname);
		spray_file						:= FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP,
																						filepath + pVersion + '/' + filename, 
																						maxRecordSize,
																						map(delim='comma'=>',',
																								delim='tab'=>'\\t',
																								delim='percent' =>'%',
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
		dest_file := destination + 'using::' + newname;
		create_super :=	IF(NOT FileServices.SuperFileExists(dest_file), FileServices.CreateSuperFile(dest_file));
		
		add_to_super := SEQUENTIAL(				 
												STD.File.StartSuperFileTransaction();
												STD.File.ClearSuperFile(dest_file),
												STD.File.AddSuperFile(dest_file, sprayed_file);
												STD.File.FinishSuperFileTransaction();
												);
		RETURN SEQUENTIAL(spray_file, create_super, add_to_super);

	END;
	
END;