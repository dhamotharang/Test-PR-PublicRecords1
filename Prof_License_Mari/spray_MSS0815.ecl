// spray MSS0815 Mississippi Appraiser Licenses Files for MARI	   
IMPORT ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
EXPORT spray_MSS0815 (STRING filedate) := MODULE
#workunit('name','Spray MSS0815');

SHARED filepath		    :=	'/data/data_build_5_2/MARI/in/MSS0815/' + filedate +'/';
SHARED sourcepath			:=	'/data/data_build_5_2/MARI/';
SHARED group_name			:=	Common_Prof_Lic_Mari.group_name;
SHARED maxRecordSize	:=	8192;
SHARED destination := Common_Prof_Lic_Mari.SourcesFolder + 'mss0815::' + filedate + '::';
SHARED superfile_apr := '~thor_data400::in::proflic_mari::mss0815::using::apr';
SHARED superfile_re := '~thor_data400::in::proflic_mari::mss0815::using::re';

	   
clear_super_apr
	:=
		IF(FileServices.SuperFileExists(superfile_apr)
			,FileServices.ClearSuperFile(superfile_apr)
			,FileServices.CreateSuperFile(superfile_apr)
			);		 


clear_super_re
	:=
		IF(FileServices.SuperFileExists(superfile_re)
			,FileServices.ClearSuperFile(superfile_re)
			,FileServices.CreateSuperFile(superfile_re)
			);		
			
SprayFile(STRING filename, STRING delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\n','',
																		 group_name, 
																		 destination + StringLib.StringToLowerCase(newname) + '.raw',
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 																									
END;



TransformFile_apr(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := DATASET(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_MSS0815.apr,CSV(SEPARATOR(','),QUOTE('"')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_MSS0815.common; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


TransformFile_re(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := DATASET(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_MSS0815.re,CSV(SEPARATOR(','),QUOTE('"')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_MSS0815.common; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfileApr(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_apr, destination + filename);

END;		

AddToSuperfileRe(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_re, destination + filename);

END;	

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('mab electronic list_lexisnexis.csv','comma'), 	 
		SprayFile('mrec electronic list_lexisnexis.csv','comma') 
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_apr('mab electronic list_lexisnexis.csv'),, destination + 'mab electronic list_lexisnexis.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_re('mrec electronic list_lexisnexis.csv'),, destination + 'mrec electronic list_lexisnexis.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE)	

	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfileApr('mab electronic list_lexisnexis.csv'),
		AddToSuperfileRe('mrec electronic list_lexisnexis.csv'),
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + 'mab electronic list_lexisnexis.raw'),
							 FileServices.DeleteLogicalFile(destination + 'mrec electronic list_lexisnexis.raw'),
							 );

//  Spray All Files
EXPORT S0815_SprayFiles := SEQUENTIAL(
																			clear_super_apr
																			,clear_super_re
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																		

END;