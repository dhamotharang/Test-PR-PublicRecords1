// spray New York Professional Licenses Files for MARI	   
IMPORT ut,_control,Prof_License_Mari,Lib_FileServices,lib_stringlib,Lib_date;


//Files for S0828 are Located  //
EXPORT spray_NYS0828(STRING filedate) := MODULE
#workunit('name','Spray NYS0828'); 	   

	SHARED STRING7 code		:= 'NYS0828';
	SHARED destination 								:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  SHARED superfile_appr 						:= destination + 'using::' + 'appraiser';
	SHARED superfile_prof       			:= destination + 'using::' + 'professional';
	
clear_super_appr
	:=
		IF(FileServices.SuperFileExists(superfile_appr)
			,FileServices.ClearSuperFile(superfile_appr)
			,FileServices.CreateSuperFile(superfile_appr));

clear_super_prof
	:=
		IF(FileServices.SuperFileExists(superfile_prof)
			,FileServices.ClearSuperFile(superfile_prof)
			,FileServices.CreateSuperFile(superfile_prof));

// Transform Mortgage File
TransformFile_appr(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_NYS0828.appraiser,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n','\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_NYS0828.Common,SELF.LN_FILE_TYPE := 'APR';
																																				SELF.ln_filedate := filedate; 
																																				SELF := LEFT; 
																																				SELF:= []));
	
	RETURN ds;
	
END;		

// Transform Active Broker
TransformFile_prof(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_NYS0828.professional,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n','\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_NYS0828.Common,SELF.ln_file_type := 'PRO';
																																				SELF.ln_filedate := filedate; 
																																				SELF := LEFT; 
																																				SELF:= []));
	
	RETURN ds;
	
END;		


AddToSuperfile_Appr(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_appr, destination + filedate + '::' +filename);
			
END;		


AddToSuperfile_Prof(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_prof, destination + filedate + '::' +filename);
			
END;	



//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Real_Estate_Appraisers.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Active_Real_Estate_Salespersons_and_Brokers.csv','comma');

	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_appr('Real_Estate_Appraisers.csv'),, 	destination + filedate + '::Real_Estate_Appraisers.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_prof('Active_Real_Estate_Salespersons_and_Brokers.csv'),, 	destination + filedate + '::Active_Real_Estate_Salespersons_and_Brokers.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE)
				);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_Appr('Real_Estate_Appraisers.csv'),
		AddToSuperfile_prof('Active_Real_Estate_Salespersons_and_Brokers.csv'),
		// AddToSuperfile_Appr('Salesperson.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::Real_Estate_Appraisers.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Active_Real_Estate_Salespersons_and_Brokers.raw')
							 // FileServices.DeleteLogicalFile(destination + filedate + '::Salesperson.raw'),
							 );


EXPORT S0828_SprayFiles := SEQUENTIAL(
																			clear_super_appr
																			,clear_super_prof
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			
END;

