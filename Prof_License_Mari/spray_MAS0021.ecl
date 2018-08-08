
// spray MAS0021 Professional Licenses Files for MARI	   
import ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
//Files for s0021 are Located  //
EXPORT spray_MAS0021 (STRING filedate) := MODULE

#workunit('name','Yogurt: Spray MAS0021');

SHARED filepath		    :=	'/data/data_build_5_2/MARI/in/MAS0021/' + filedate +'/';
SHARED sourcepath		:=	'/data/data_build_5_2/MARI/';
SHARED group_name	:=	Common_Prof_Lic_Mari.group_name;
SHARED maxRecordSize	:=	8192;
SHARED destination := Common_Prof_Lic_Mari.SourcesFolder + 'MAS0021::' + filedate + '::';
SHARED superfile := '~thor_data400::in::proflic_mari::MAS0021::using::re';


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
										Prof_License_Mari.Layout_MAS0021.raw,CSV(SEPARATOR(','),QUOTE('"'), TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_MAS0021.common, SELF := LEFT; SELF :=[]));
	RETURN ds;
END;		


AddToSuperfile(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);
END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('rebrokers.csv','comma');
		SprayFile('resales.csv','comma');
		SprayFile('reapp.csv','comma');
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('rebrokers.csv'),, destination + 'rebrokers.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('resales.csv'),, destination + 'resales.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('reapp.csv'),, destination + 'reapp.csv', CSV(SEPARATOR(','),QUOTE('"'), TERMINATOR('\n')), OVERWRITE),
	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('rebrokers.csv'),
		AddToSuperfile('resales.csv'),
		AddToSuperfile('reapp.csv'),
		FileServices.FinishSuperFileTransaction()
	);

// Remove RAW file
   remove_raw		
	 :=	
	 SEQUENTIAL(
	   FileServices.DeleteLogicalFile(destination +'rebrokers.raw'),
		 FileServices.DeleteLogicalFile(destination +'resales.raw'),
		 FileServices.DeleteLogicalFile(destination +'reapp.raw'));
	


//  Spray All Files
EXPORT s0021_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			

END;