// spray NCS0841 Professional Licenses Files for MARI	   
import ut
	   ,_control
     ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   
export spray_NCS0841 (string filedate):= MODULE
shared filepath	  :=	'/data/data_build_5_2/MARI/in/NCS0841/' + filedate +'/';		
shared maxRecordSize	:=	8192;
shared group_name	:=	Common_Prof_Lic_Mari.group_name;
shared destination:= Common_Prof_Lic_Mari.SourcesFolder + 'NCS0841::';
shared superfile  := '~thor_data400::in::proflic_mari::NCS0841::sprayed::rle_license';

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
																		 destination + filedate + '::'+StringLib.StringToLowerCase(newname) + '.raw',
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
	dsraw := dataset(destination + filedate + '::'+StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_NCS0841.raw,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\r\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_NCS0841.src,
																SELF.ln_filedate := filedate; 
																SELF := LEFT;
																SELF := []));
	
	RETURN ds;
END;		

AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filedate + '::'+filename);
END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('rptINListAlpha.csv',',') 	 
	);

//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('rptINListAlpha.csv'),, destination  + filedate + '::rptINListAlpha.csv', CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\r\n')),OVERWRITE);
									
	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),		
		AddToSuperfile('rptINListAlpha.csv'),
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::rptINListAlpha.raw'),
							 );


//  Spray All Files
export S0841_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);

END;