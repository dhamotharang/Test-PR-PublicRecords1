// spray Wyoming Real Estate Professional Licenses Files for MARI	   
IMPORT Prof_License_Mari;

EXPORT spray_WYS0858(string filedate) := MODULE
#workunit('name','Spray WYS0858'); 	   

	SHARED STRING7 code						:= 'WYS0858';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  SHARED superfile_rel 					:= destination + 'sprayed::' + 'rel';
	

clear_super
	:=
		IF(FileServices.SuperFileExists(superfile_rel)
			,FileServices.ClearSuperFile(superfile_rel)
			,FileServices.CreateSuperFile(superfile_rel));


// Transform Real Estate License
TransformFile_rel(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_WYS0858.real_estate,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n','\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_WYS0858.Common,SELF.ln_filetype := 'REL';
																																				 SELF.ln_filedate := filedate; 
																																				 SELF := LEFT; 
																																				 self:= []));
	
	RETURN ds;
	
END;		

// Transform Appraiser
TransformFile_apr(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_WYS0858.appraiser,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n','\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_WYS0858.Common,SELF.ln_filetype := 'APR';
																																				SELF.ln_filedate := filedate; 
																																				SELF := LEFT; 
																																				self:= []));
	
	RETURN ds;
	
END;		


// Transform Appraisal Company
TransformFile_amc(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_WYS0858.Business,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n','\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_WYS0858.Common,SELF.ln_filetype := 'AMC';
																																				SELF.ln_filedate := filedate; 
																																				SELF := LEFT; 
																																				self:= []));
	
	RETURN ds;
	
END;		


AddToSuperfile_rel(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_rel, destination + filedate + '::' +filename);
			
END;		


//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'All Appraisers Permits.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Real Estate.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Appraisal Management Company Registration.csv','comma');
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_apr('All Appraisers Permits.csv'),, 	destination + filedate + '::All Appraisers Permits.csv',	CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n','\n'])), OVERWRITE),
							OUTPUT(TransformFile_rel('Real Estate.csv'),, 	destination + filedate + '::Real Estate.csv',	CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n','\n'])), OVERWRITE),
							OUTPUT(TransformFile_amc('Appraisal Management Company Registration.csv'),, 	destination + filedate + '::Appraisal Management Company Registration.csv',	CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n','\n'])), OVERWRITE),
					 	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_rel('All Appraisers Permits.csv'),
		AddToSuperfile_rel('Real Estate.csv'),
		AddToSuperfile_rel('Appraisal Management Company Registration.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::All Appraisers Permits.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Real Estate.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Appraisal Management Company Registration.raw'),
							 );


export S0858_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw
																			);
																			
END;
