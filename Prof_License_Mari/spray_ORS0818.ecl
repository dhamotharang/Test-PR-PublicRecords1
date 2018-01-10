IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_ORS0818(string pVersion) := MODULE

	#workunit('name','Spray ORS0818');
	SHARED STRING7 code						:= 'ORS0818';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
	SHARED superfile 							:= destination + 'using::' + 'apr';



clear_super
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile));


	
TransformFile(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_ORS0818.INCOMING,CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_ORS0818.COMMON, SELF.FILE_DATE	:= pVersion;	SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + pVersion + '::' +filename);

END;		
	
//  Spray All Files
spray_all	:=
	PARALLEL(
	 Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'AMC Company.csv','comma');
	 Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'Registered Appraiser Assistant.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'State Certified General Appraiser.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'State Certified Residential Appraiser.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'State Licensed Appraiser.csv','comma');
					);
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('AMC Company.csv'),, destination + pVersion + '::AMC Company.csv', CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE);							
							OUTPUT(TransformFile('Registered Appraiser Assistant.csv'),, destination + pVersion + '::Registered Appraiser Assistant.csv', CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE);							
							OUTPUT(TransformFile('State Certified General Appraiser.csv'),, destination + pVersion + '::State Certified General Appraiser.csv', CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE);							
							OUTPUT(TransformFile('State Certified Residential Appraiser.csv'),, destination + pVersion + '::State Certified Residential Appraiser.csv', CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE);							
							OUTPUT(TransformFile('State Licensed Appraiser.csv'),, destination + pVersion + '::State Licensed Appraiser.csv', CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE);							
							);	
	
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('AMC Company.csv'),
		AddToSuperfile('Registered Appraiser Assistant.csv'),
		AddToSuperfile('State Certified General Appraiser.csv'),
		AddToSuperfile('State Certified Residential Appraiser.csv'),
		AddToSuperfile('State Licensed Appraiser.csv'),		
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + pVersion + '::AMC Company.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::Registered Appraiser Assistant.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::State Certified General Appraiser.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::State Certified Residential Appraiser.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::State Licensed Appraiser.raw')							 
							 );


//  Spray All Files
export SprayFiles := 		SEQUENTIAL(clear_super,spray_all,xform_all,super_all,remove_raw);
																	 
																			
END;