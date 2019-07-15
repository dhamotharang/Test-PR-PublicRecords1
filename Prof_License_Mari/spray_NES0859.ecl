// spray Nebraska Real Estate Appraisers Licenses Files for MARI	   


import ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib, Lib_date;
	   
export spray_NES0859(string filedate):= MODULE

#workunit('name','Yogurt: Spray spray_NES0859'); 
shared mod_name		:= 'NES0859';
shared filepath		  :=	Common_Prof_Lic_Mari.sourcepath + mod_name + '/' + filedate +'/';	
shared maxRecordSize	:=	8192;
shared group_name	:=	Common_Prof_Lic_Mari.group_name;
shared superfile := Common_Prof_Lic_Mari.SourcesFolder + mod_name + '::using::appr';
shared destination := Common_Prof_Lic_Mari.SourcesFolder + mod_name + '::'+ filedate + '::';

clear_super
	:=
		IF(FileServices.SuperFileExists(superfile), 
			FileServices.ClearSuperFile(superfile),
			FileServices.CreateSuperFile(superfile));
											 

SprayFile(string filename, string delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\r\n','',
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
										Prof_License_Mari.layout_NES0859.raw,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.layout_NES0859.src,SELF.ln_filedate := filedate; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);

END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('Appraiser_NE.csv','\\,');		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('Appraiser_NE.csv'),, destination + 'appraiser.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE);

	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('appraiser.csv'),
		FileServices.FinishSuperFileTransaction()
	);


//  Spray All Files
export S0859_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,xform_all
																			,super_all);
																			

END;