// spray MIS0298 Professional Licenses Files for MARI	   
import ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	  
//Files for S0812 are Located  //
export spray_MIS0298 (string filedate) := MODULE

#workunit('name','Yogurt: Spray MIS0298');

shared filepath		    :=	'/data/data_build_5_2/MARI/in/MIS0298/' + filedate +'/';
shared sourcepath			:=	'/data/data_build_5_2/MARI/';
SHARED group_name	    :=	Common_Prof_Lic_Mari.group_name;
shared maxRecordSize	:=	8192;
shared destination       := Common_Prof_Lic_Mari.SourcesFolder + 'MIS0298::' + filedate + '::';
shared superfile  := '~thor_data400::in::proflic_mari::MIS0298::using::real_estate';
  
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
										Prof_License_Mari.Layout_Mis0298.raw,CSV(SEPARATOR(','),QUOTE('"'),HEADING(1), TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_Mis0298.raw, SELF := LEFT; SELF :=[]));
	RETURN ds;
END;		


AddToSuperfile(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);
END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('All_Real_Estate.csv','\\,') 
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('All_Real_Estate.csv'),, destination + 'All_Real_Estate.csv', CSV(SEPARATOR(','),QUOTE('"'),HEADING(1), TERMINATOR('\n')), OVERWRITE)
	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('All_Real_Estate.csv'),
		FileServices.FinishSuperFileTransaction()
	);


//  Spray All Files
EXPORT S0298_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,xform_all
																			,super_all);
																			

END;