// spray KSS0903 Professional Licenses Files for MARI	   
IMPORT ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   
//Files for S0903 are Located  //
EXPORT spray_KSS0903 (STRING filedate) := MODULE

#workunit('name','Yogurt: Spray KSS0903');

SHARED filepath		  :=	'/data/data_build_5_2/MARI/in/KSS0903/' + filedate +'/';
SHARED sourcepath		:=	'/data/data_build_5_2/MARI/';
SHARED group_name	  :=	Common_Prof_Lic_Mari.group_name;
SHARED maxRecordSize	:=	8192;
SHARED destination := Common_Prof_Lic_Mari.SourcesFolder + 'KSS0903::' + filedate + '::';
SHARED superfile   := '~thor_data400::in::proflic_mari::kss0903::using::rle';


clear_super
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile));
	
	
SprayFile(STRING filename, STRING delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 IF(delim = 'tab','\t',''),'\r','',
																		 group_name, 
																		 destination + StringLib.StringToLowerCase(newname) + '.raw',
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 																									
END;
	

TransformFile(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := DATASET(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_KSS0903.raw,CSV(SEPARATOR(','),QUOTE('"'),HEADING(1), TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_KSS0903.common,SELF := LEFT; SELF :=[]));
	RETURN ds;
END;		


AddToSuperfile(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);
END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('broker_salesperson_licenses.csv','\\,')
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('broker_salesperson_licenses.csv'),, destination + 'broker_salesperson_licenses.csv', CSV(SEPARATOR(','),QUOTE('"'),HEADING(1), TERMINATOR('\n')), OVERWRITE)
	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('broker_salesperson_licenses.csv'),
		FileServices.FinishSuperFileTransaction()
	);

// Remove RAW file
remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + 'broker_salesperson_licenses.raw')
							 );
							 
//  Spray All Files
EXPORT S0903_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			

END;