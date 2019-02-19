// spray ALS0845 Professional Licenses Files for MARI	   


import ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   

//Files for S0845 are Located  //
export spray_ALS0845 (string filedate) := MODULE
#workunit('name','Yogurt:Spray ALS0845 ' + filedate);

shared filepath		    :=	'/data/data_build_5_2/MARI/in/ALS0845/' + filedate +'/';
shared sourcepath		:=	'/data/data_build_5_2/MARI/';
shared group_name	:=	Common_Prof_Lic_Mari.group_name;
shared maxRecordSize	:=	8192;
shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'ALS0845::' + filedate + '::';
shared superfile := '~thor_data400::in::proflic_mari::als0845::using::licensee';


clear_super
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile));
	
	
SprayFile(string filename, string delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\r','',
																		 group_name, 
																		 destination + StringLib.StringToLowerCase(newname) + '.raw',
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 																									
END;
	

TransformFile(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_ALS0845.Licensee,CSV(SEPARATOR(','),QUOTE('"'),HEADING(1),TERMINATOR('\r\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_ALS0845.Common,SELF.ln_filedate := filedate; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);

END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		
		SprayFile('Licensee.csv','\\,') 
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('Licensee.csv'),, destination + 'Licensee.csv', CSV(SEPARATOR(','),QUOTE('"'),HEADING(1)), OVERWRITE)
	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
			
		AddToSuperfile('Licensee.csv'),
		
		FileServices.FinishSuperFileTransaction()
	);

// Remove RAW file
   remove_raw		:=	FileServices.DeleteLogicalFile('Licensee.raw');
	


//  Spray All Files
export S0845_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			

END;


