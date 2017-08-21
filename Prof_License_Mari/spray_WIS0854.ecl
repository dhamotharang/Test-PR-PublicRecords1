// spray Wisconsin Real Estate Appraisers, Agents, Brokers, & Firms Professional Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib, Lib_date;
	   
EXPORT spray_WIS0854 (STRING filedate):= MODULE

#workunit('name','Spray WIS0854'); 
SHARED filepath		 :=	'/data/data_build_5_2/MARI/in/WIS0854/' + filedate +'/';	
SHARED maxRecordSize	:=	8192;
SHARED group_name	 :=	Common_Prof_Lic_Mari.group_name;
SHARED superfile   := '~thor_data400::in::proflic_mari::wis0854::using::rle_license';
SHARED destination := Common_Prof_Lic_Mari.SourcesFolder + 'WIS0854::'+ filedate + '::';

clear_super
	:=
		IF(FileServices.SuperFileExists(superfile), 
			FileServices.ClearSuperFile(superfile),
			FileServices.CreateSuperFile(superfile));
											 

SprayFile(STRING filename, STRING delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 IF(delim = 'tab','\t',''),'\r\n','',
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
										Prof_License_Mari.Layout_WIS0854.raw,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_WIS0854.src,SELF.ln_filedate := filedate; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfile(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);

END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('LicenseBulkListOrder.csv','\\,')
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('LicenseBulkListOrder.csv'),,	 destination + 'LicenseBulkListOrder.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE)	

	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('LicenseBulkListOrder.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + 'LicenseBulkListOrder.raw')
							 );


//  Spray All Files
EXPORT S0854_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw );
																			
END;