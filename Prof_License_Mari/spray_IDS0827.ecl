// spray Ohio Department of Commerce Professional Licenses Files for MARI	   
IMPORT Prof_License_Mari;

EXPORT spray_IDS0827(string filedate) := MODULE
#workunit('name','Spray IDS0827'); 	   

	SHARED STRING7 code						:= 'IDS0827';
	SHARED destination 								:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  SHARED superfile_rel 						:= destination + 'using::' + 'rel';
	

clear_super
	:=
		IF(FileServices.SuperFileExists(superfile_rel)
			,FileServices.ClearSuperFile(superfile_rel)
			,FileServices.CreateSuperFile(superfile_rel));


// Transform License
TransformFile_rel(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layouts_IDS0827.raw,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layouts_IDS0827.Common,SELF.ln_filedate := filedate; 
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
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Active_License_Search_Results.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Expired_License_Search_Results.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Inactive_License_Search_Results.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Revoked_License_Search_Results.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Surrendered_License_Search_Results.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Suspended_License_Search_Results.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Terminated_License_Search_Results.csv','comma');
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_rel('Active_License_Search_Results.csv'),, 	destination + filedate + '::Active_License_Search_Results.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_rel('Expired_License_Search_Results.csv'),, 	destination + filedate + '::Expired_License_Search_Results.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_rel('Inactive_License_Search_Results.csv'),, 	destination + filedate + '::Inactive_License_Search_Results.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_rel('Revoked_License_Search_Results.csv'),, 	destination + filedate + '::Revoked_License_Search_Results.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_rel('Surrendered_License_Search_Results.csv'),, 	destination + filedate + '::Surrendered_License_Search_Results.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_rel('Suspended_License_Search_Results.csv'),, 	destination + filedate + '::Suspended_License_Search_Results.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_rel('Terminated_License_Search_Results.csv'),, 	destination + filedate + '::Terminated_License_Search_Results.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
					 	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_rel('Active_License_Search_Results.csv'),
		AddToSuperfile_rel('Expired_License_Search_Results.csv'),
		AddToSuperfile_rel('Inactive_License_Search_Results.csv'),
		AddToSuperfile_rel('Revoked_License_Search_Results.csv'),
		AddToSuperfile_rel('Surrendered_License_Search_Results.csv'),
		AddToSuperfile_rel('Suspended_License_Search_Results.csv'),
		AddToSuperfile_rel('Terminated_License_Search_Results.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::Active_License_Search_Results.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Expired_License_Search_Results.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Inactive_License_Search_Results.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Revoked_License_Search_Results.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Surrendered_License_Search_Results.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Suspended_License_Search_Results.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Terminated_License_Search_Results.raw'),
							 );


export S0827_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			
END;



