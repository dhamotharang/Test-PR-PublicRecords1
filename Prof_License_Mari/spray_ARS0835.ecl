// spray ARS0835 Professional Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;  EXPORT spray_ARS0835(STRING filedate) := MODULE

 #workunit('name','Yogurt:Spray ARS0835');
	SHARED code 									:= 'ARS0835';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  SHARED superfile_active 			:= destination + 'sprayed::' + 'active';
	SHARED superfile_inactive 		:= destination + 'sprayed::' + 'inactive';
	

clear_super	:=
							PARALLEL(
												FileServices.ClearSuperFile(superfile_active);
												FileServices.ClearSuperFile(superfile_inactive);			
												);


// Transform Real Estate License
TransformFile_active(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_ARS0835.active,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_ARS0835.Common, SELF := LEFT; 
																																				 SELF:= []));
	RETURN ds;
	
END;		

TransformFile_inactive(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_ARS0835.inactive,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_ARS0835.Common,SELF := LEFT; 
																																				SELF:= []));
	
	RETURN ds;
	
END;		


AddToSuperfile_active(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_active, destination + filedate + '::' +filename);
			
END;		

AddToSuperfile_inactive(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_inactive, destination + filedate + '::' +filename);
			
END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'active.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'inactive.csv','comma');		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_active('active.csv'),, 	destination + filedate + '::active.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_inactive('inactive.csv'),, 	destination + filedate + '::inactive.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
					 	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_active('active.csv'),
		AddToSuperfile_inactive('inactive.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::active.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::inactive.raw'),
							 );
EXPORT S0835_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			
END;
