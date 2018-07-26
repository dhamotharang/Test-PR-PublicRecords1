IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;
	   
EXPORT spray_NJS0033(STRING filedate) := MODULE
	
	#workunit('name','Yogurt: Spray NJS0033');
	SHARED code						        := 'NJS0033';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  SHARED superfile_apr 					:= destination + 'using::' + 'apr';
	
clear_super
	:=
		IF(FileServices.SuperFileExists(superfile_apr)
			,FileServices.ClearSuperFile(superfile_apr)
			,FileServices.CreateSuperFile(superfile_apr));


// Transform Real Estate License
TransformFile_apr(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_NJS0033.profession,CSV(SEPARATOR('%'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_NJS0033.Common, SELF := LEFT; 
																																				 SELF:= []));
	
	RETURN ds;
	
END;		


AddToSuperfile_apr(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_apr, destination + filedate + '::' +filename);
			
END;		


//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Standard Individual all status.txt','comma');
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_apr('Standard Individual all status.txt'),, 	destination + filedate + '::Standard Individual all status.txt',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
					 	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_apr('Standard Individual all status.txt'),
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::Standard Individual all status.raw'),
							 );


EXPORT S0033_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			
END;
