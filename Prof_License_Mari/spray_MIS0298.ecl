// spray MIS0298 Professional Licenses Files for MARI	   
import ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   

//Files for S0812 are Located  //
export spray_MIS0298 (string filedate) := MODULE

#workunit('name','Spray MIS0298');

shared filepath		    :=	'/data/data_build_5_2/MARI/in/MIS0298/' + filedate +'/';
shared sourcepath			:=	'/data/data_build_5_2/MARI/';
SHARED group_name	    :=	Common_Prof_Lic_Mari.group_name;
shared maxRecordSize	:=	8192;
shared destination       := Common_Prof_Lic_Mari.SourcesFolder + 'MIS0298::' + filedate + '::';
shared superfile_broker  := '~thor_data400::in::proflic_mari::MIS0298::using::broker';
shared superfile_rle     := '~thor_data400::in::proflic_mari::MIS0298::using::real_estate';
shared superfile_MiscLic := '~thor_data400::in::proflic_mari::MIS0298::using::MiscLic';
	   
clear_super_broker
	:=
		IF(FileServices.SuperFileExists(superfile_broker)
			,FileServices.ClearSuperFile(superfile_broker)
			,FileServices.CreateSuperFile(superfile_broker)
			);		 


clear_super_rle
	:=
		IF(FileServices.SuperFileExists(superfile_rle)
			,FileServices.ClearSuperFile(superfile_rle)
			,FileServices.CreateSuperFile(superfile_rle)
			);		
			
clear_super_MiscLic
	:=
		IF(FileServices.SuperFileExists(superfile_MiscLic)
			,FileServices.ClearSuperFile(superfile_MiscLic)
			,FileServices.CreateSuperFile(superfile_MiscLic)
			);					
			
SprayFile(string filename, string delim) := FUNCTION
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


TransformFile_broker(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_MIS0298.Broker,CSV(SEPARATOR(','),quote('"')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_MIS0298.Broker,SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


TransformFile_rle(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_MIS0298.RealEstate,CSV(SEPARATOR(','),quote('"')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_MIS0298.RealEstate,SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		

TransformFile_MiscLic(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_MIS0298.MiscLic,CSV(SEPARATOR(','),quote('"')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_MIS0298.MiscLic,SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;	

AddToSuperfileBroker(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_broker, destination + filename);

END;		

AddToSuperfileRle(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_rle, destination + filename);

END;	

AddToSuperfileMiscLic(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_MiscLic, destination + filename);

END;

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('65 active 1-2.txt','\\,'), 	 
		SprayFile('65 active 3.txt','\\,'), 
		SprayFile('65 active 4.txt','\\,'), 	 
		SprayFile('65 active 5.txt','\\,'), 
		SprayFile('65 inactive all.txt','\\,'), 	 
		SprayFile('active l2k all professions.txt','\\,'), 
		SprayFile('inactive l2k all professions 1.txt','\\,'), 	 
		SprayFile('inactive l2k all professions 2.txt','\\,') 		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_broker('65 active 1-2.txt'),, destination + '65 active 1-2.txt', CSV(SEPARATOR(','),quote('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_broker('65 active 3.txt'),, destination + '65 active 3.txt', CSV(SEPARATOR(','),quote('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_rle('65 active 4.txt'),, destination + '65 active 4.txt', CSV(SEPARATOR(','),quote('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_rle('65 active 5.txt'),, destination + '65 active 5.txt', CSV(SEPARATOR(','),quote('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_rle('65 inactive all.txt'),, destination + '65 inactive all.txt', CSV(SEPARATOR(','),quote('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_MiscLic('active l2k all professions.txt'),, destination + 'active l2k all professions.txt', CSV(SEPARATOR(','),quote('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_MiscLic('inactive l2k all professions 1.txt'),, destination + 'inactive l2k all professions 1.txt', CSV(SEPARATOR(','),quote('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_MiscLic('inactive l2k all professions 2.txt'),, destination + 'inactive l2k all professions 2.txt', CSV(SEPARATOR(','),quote('"'),TERMINATOR('\n')), OVERWRITE)
	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfileBroker('65 active 1-2.txt'),
		AddToSuperfileBroker('65 active 3.txt'),
		AddToSuperfileRle('65 active 4.txt'),
		AddToSuperfileRle('65 active 5.txt'),
		AddToSuperfileRle('65 inactive all.txt'),
		AddToSuperfileMiscLic('active l2k all professions.txt'),
		AddToSuperfileMiscLic('inactive l2k all professions 1.txt'),
		AddToSuperfileMiscLic('inactive l2k all professions 2.txt'),		
		FileServices.FinishSuperFileTransaction()
	);

// Remove RAW file
remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + '65 active 1-2.raw'),
							 FileServices.DeleteLogicalFile(destination + '65 active 3.raw'),
							 FileServices.DeleteLogicalFile(destination + '65 active 4.raw'),
							 FileServices.DeleteLogicalFile(destination + '65 active 5.raw'),
							 FileServices.DeleteLogicalFile(destination + '65 inactive all.raw'),
							 FileServices.DeleteLogicalFile(destination + 'active l2k all professions.raw'),
							 FileServices.DeleteLogicalFile(destination + 'inactive l2k all professions 1.raw'),
							 FileServices.DeleteLogicalFile(destination + 'inactive l2k all professions 2.raw')
							 );
//  Spray All Files
export S0298_SprayFiles := SEQUENTIAL(
																			clear_super_broker
																			,clear_super_rle
																			,clear_super_MiscLic
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																		

END;


