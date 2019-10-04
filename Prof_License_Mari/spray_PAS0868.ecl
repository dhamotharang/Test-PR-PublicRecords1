// spray PAS0868 - Pennsylvania Real Estate Appraisers, Agents, Brokers, & Firms  
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_PAS0868(string pVersion) := MODULE

	#workunit('name','Spray PAS0868');
	SHARED STRING7 code						:= 'PAS0868';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
	SHARED superfile_active				:= destination + 'using::' + 'active';
	SHARED superfile_inactive1		:= destination + 'using::' + 'inactive1';
	SHARED superfile_inactive2		:= destination + 'using::' + 'inactive2';
	SHARED superfile_inactive3		:= destination + 'using::' + 'inactive3';	
	SHARED superfile_inactive4		:= destination + 'using::' + 'inactive4';	

clear_super_active
	:=
		IF(FileServices.SuperFileExists(superfile_active)
			,FileServices.ClearSuperFile(superfile_active)
			,FileServices.CreateSuperFile(superfile_active));

clear_super_inactive1
	:=
		IF(FileServices.SuperFileExists(superfile_inactive1)
			,FileServices.ClearSuperFile(superfile_inactive1)
			,FileServices.CreateSuperFile(superfile_inactive1));

clear_super_inactive2
	:=
		IF(FileServices.SuperFileExists(superfile_inactive2)
			,FileServices.ClearSuperFile(superfile_inactive2)
			,FileServices.CreateSuperFile(superfile_inactive2));

clear_super_inactive3
	:=
		IF(FileServices.SuperFileExists(superfile_inactive3)
			,FileServices.ClearSuperFile(superfile_inactive3)
			,FileServices.CreateSuperFile(superfile_inactive3));
			
clear_super_inactive4
	:=
		IF(FileServices.SuperFileExists(superfile_inactive4)
			,FileServices.ClearSuperFile(superfile_inactive4)
			,FileServices.CreateSuperFile(superfile_inactive4));			
			
TransformFile_active(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_PAS0868.active,CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_PAS0868.COMMON, SELF.status:= 'ACTIVE';	SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		

TransformFile_inactive1(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_PAS0868.inactive_1,CSV(SEPARATOR(','),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_PAS0868.COMMON, SELF.status:= 'INACTIVE';	SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;

TransformFile_inactive2(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_PAS0868.inactive_2,CSV(SEPARATOR(','),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_PAS0868.COMMON, SELF.status:= 'INACTIVE';	SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;

TransformFile_inactive3(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_PAS0868.inactive_3,CSV(SEPARATOR(','),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_PAS0868.COMMON, SELF.status:= 'INACTIVE';	SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;


TransformFile_inactive4(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_PAS0868.inactive_4,CSV(SEPARATOR(','),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_PAS0868.COMMON, SELF.status:= 'INACTIVE';	SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;

AddToSuperfile_active(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_active, destination + pVersion + '::' +filename);

END;		
	
AddToSuperfile_inactive1(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_inactive1, destination + pVersion + '::' +filename);

END;		
	
AddToSuperfile_inactive2(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_inactive2, destination + pVersion + '::' +filename);

END;

AddToSuperfile_inactive3(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_inactive3, destination + pVersion + '::' +filename);

END;	
	
AddToSuperfile_inactive4(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_inactive4, destination + pVersion + '::' +filename);

END;		
	
//  Spray All Files
spray_all	:=
	PARALLEL(
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'LicenseList_active_1.csv','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'LicenseList_active_2.csv','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 900 type 12001 inactive format B.txt','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 900 type 12005 inactive format B.txt','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 900 type 12010 inactive format B.txt','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 900 type 12030 inactive format B.txt','comma');		
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12001 inactive format B.txt','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12150 inactive format A.txt','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12190 inactive format A.txt','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12200 inactive format A.txt','comma');		
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12270 A-E inactive format B.txt','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12270 F-J inactive format B.txt','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12270 K-N inactive format B.txt','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12270 O-T inactive format B.txt','comma');	
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12270 K-N inactive format B.txt','comma');
	  Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12270 U-Z inactive format B.txt','comma');	
		Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'id 1200 type 12310 inactive format B.txt','comma');	
					);
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_active('LicenseList_active_1.csv'),, destination + pVersion + '::LicenseList_active_1.csv', CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE);							
							OUTPUT(TransformFile_active('LicenseList_active_2.csv'),, destination + pVersion + '::LicenseList_active_2.csv', CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE);		
							OUTPUT(TransformFile_inactive1('id 900 type 12001 inactive format B.txt'),, destination + pVersion + '::id_900_type_12001_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);
							OUTPUT(TransformFile_inactive1('id 900 type 12005 inactive format B.txt'),, destination + pVersion + '::id_900_type_12005_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);
							OUTPUT(TransformFile_inactive1('id 900 type 12010 inactive format B.txt'),, destination + pVersion + '::id_900_type_12010_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);
							OUTPUT(TransformFile_inactive1('id 900 type 12030 inactive format B.txt'),, destination + pVersion + '::id_900_type_12030_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);		
							OUTPUT(TransformFile_inactive2('id 1200 type 12001 inactive format B.txt'),, destination + pVersion + '::id_1200_type_12001_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);
							OUTPUT(TransformFile_inactive4('id 1200 type 12150 inactive format A.txt'),, destination + pVersion + '::id_1200_type_12150_inactive_format_A.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);
							OUTPUT(TransformFile_inactive3('id 1200 type 12190 inactive format A.txt'),, destination + pVersion + '::id_1200_type_12190_inactive_format_A.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);
							OUTPUT(TransformFile_inactive4('id 1200 type 12200 inactive format A.txt'),, destination + pVersion + '::id_1200_type_12200_inactive_format_A.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);		
							OUTPUT(TransformFile_inactive2('id 1200 type 12270 A-E inactive format B.txt'),, destination + pVersion + '::id_1200_type_12270_A-E_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);
							OUTPUT(TransformFile_inactive2('id 1200 type 12270 F-J inactive format B.txt'),, destination + pVersion + '::id_1200_type_12270_F-J_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);
							OUTPUT(TransformFile_inactive2('id 1200 type 12270 K-N inactive format B.txt'),, destination + pVersion + '::id_1200_type_12270_K-N_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);
							OUTPUT(TransformFile_inactive2('id 1200 type 12270 O-T inactive format B.txt'),, destination + pVersion + '::id_1200_type_12270_O-T_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);	
							OUTPUT(TransformFile_inactive2('id 1200 type 12270 U-Z inactive format B.txt'),, destination + pVersion + '::id_1200_type_12270_U-Z_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);
							OUTPUT(TransformFile_inactive2('id 1200 type 12310 inactive format B.txt'),, destination + pVersion + '::id_1200_type_12310_inactive_format_B.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])), OVERWRITE);							
							);	
	
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_active('LicenseList_active_1.csv'),
		AddToSuperfile_active('LicenseList_active_2.csv'),	
		AddToSuperfile_inactive1('id_900_type_12001_inactive_format_B.txt'),
		AddToSuperfile_inactive1('id_900_type_12005_inactive_format_B.txt'),	
		AddToSuperfile_inactive1('id_900_type_12010_inactive_format_B.txt'),
		AddToSuperfile_inactive1('id_900_type_12030_inactive_format_B.txt'),	
		AddToSuperfile_inactive2('id_1200_type_12001_inactive_format_B.txt'),
		AddToSuperfile_inactive4('id_1200_type_12150_inactive_format_A.txt'),	
		AddToSuperfile_inactive3('id_1200_type_12190_inactive_format_A.txt'),
		AddToSuperfile_inactive4('id_1200_type_12200_inactive_format_A.txt'),	
		AddToSuperfile_inactive2('id_1200_type_12270_A-E_inactive_format_B.txt'),
		AddToSuperfile_inactive2('id_1200_type_12270_F-J_inactive_format_B.txt'),
		AddToSuperfile_inactive2('id_1200_type_12270_K-N_inactive_format_B.txt'),
		AddToSuperfile_inactive2('id_1200_type_12270_O-T_inactive_format_B.txt'),
		AddToSuperfile_inactive2('id_1200_type_12270_U-Z_inactive_format_B.txt'),
		AddToSuperfile_inactive2('id_1200_type_12310_inactive_format_B.txt'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + pVersion + '::LicenseList_active_1.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::LicenseList_active_2.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 1200 type 12310 inactive format b.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 1200 type 12270 a-e inactive format b.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 1200 type 12270 f-j inactive format b.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 1200 type 12270 k-n inactive format b.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 1200 type 12270 o-t inactive format b.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 1200 type 12270 u-z inactive format b.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 1200 type 12200 inactive format a.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 1200 type 12190 inactive format a.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 1200 type 12150 inactive format a.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 1200 type 12001 inactive format b.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 900 type 12030 inactive format b.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 900 type 12010 inactive format b.raw'),							 
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 900 type 12005 inactive format b.raw'),			
							 FileServices.DeleteLogicalFile(destination + pVersion + '::id 900 type 12001 inactive format b.raw')							 
							 );


//  Spray All Files
export S0868_SprayFiles := 		SEQUENTIAL(clear_super_active,clear_super_inactive1,clear_super_inactive2,clear_super_inactive3,clear_super_inactive4,spray_all,xform_all,super_all,remove_raw);
																	 
end;		