// spray MDS0834 Professional Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;  
EXPORT spray_MDS0834(STRING filedate) := MODULE

	SHARED code 									:= 'MDS0834';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  SHARED superfile 			        := destination + 'using::' + 'file';

clear_super	:= 
      IF(FileServices.SuperFileExists(superfile)
			  ,FileServices.ClearSuperFile(superfile)
			  ,FileServices.CreateSuperFile(superfile)
			  );

// Transform Real Estate License
TransformFile(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_MDS0834.raw,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_MDS0834.Common, SELF := LEFT; 
																																				 SELF:= []));
	RETURN ds;
END;		

TransformFile_Two(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_MDS0834.raw_2,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_MDS0834.Common, SELF := LEFT; 
																																				 SELF:= []));
	RETURN ds;
END;	



AddTosuperfile(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filedate + '::' +filename);
END;		


//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'sp1.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'sp2.csv','comma');		
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'sp3.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'sp4.csv','comma');	
	);

//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('sp1.csv'),, 	destination + filedate + '::sp1.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_Two('sp2.csv'),, 	destination + filedate + '::sp2.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_Two('sp3.csv'),, 	destination + filedate + '::sp3.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_Two('sp4.csv'),, 	destination + filedate + '::sp4.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE)
					 	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddTosuperfile('sp1.csv'),
		AddTosuperfile('sp2.csv'),
		AddTosuperfile('sp3.csv'),
		AddTosuperfile('sp4.csv'),
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::sp1.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::sp2.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::sp3.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::sp4.raw'),
							 );
EXPORT S0834_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			
END;