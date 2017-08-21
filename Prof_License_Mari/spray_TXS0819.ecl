// spray TXS0819 Professional Licenses Files for MARI

import ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib, Lib_date;
	   

export spray_TXS0819 (string filedate) := MODULE
#workunit('name','Spray TXS0819 -' + filedate);

SHARED STRING7 code						:= 'TXS0819';
SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
SHARED superfile		 					:= destination + 'using::' + 'rle_license';
SHARED superfile_cnty					:= destination + 'using::' + 'county_names_common';


clear_super
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile));
	

clear_super_cnty
	:=
		IF(FileServices.SuperFileExists(superfile_cnty)
			,FileServices.ClearSuperFile(superfile_cnty)
			,FileServices.CreateSuperFile(superfile_cnty));

TransformFile(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_TXS0819.raw_new,CSV(SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')));

	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_TXS0819.common,SELF.ln_filedate := filedate; 
																																				SELF := LEFT; 
																																				));
	
	RETURN ds;
	
END;		

TransformFile_County(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_TXS0819.county_name,CSV(SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')));

	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.layouts_reference.county_names_common,SELF.SOURCE_UPD := code[3..7]; 
																																												SELF.FIELD			 := 'COUNTY_NAME';
																																												SELF := LEFT; 
																																				));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filedate + '::' +filename);
			
			
END;		

AddToSuperfile_cnty(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_cnty, destination + filedate + '::' +filename);
			
			
END;	

spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'erwfile.txt','tab');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'inspfile.txt','tab');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'trecfile.txt','tab');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'county.txt','tab');
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('erwfile.txt'),, 	destination + filedate + '::erwfile.txt',		CSV(SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('inspfile.txt'),, 	destination + filedate + '::inspfile.txt',	CSV(SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('trecfile.txt'),, 	destination + filedate + '::trecfile.txt',	CSV(SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_County('county.txt'),, 		destination + filedate + '::county.txt',	CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						 	);	
	
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
			
		AddToSuperfile('erwfile.txt');
		AddToSuperfile('inspfile.txt');
		AddToSuperfile('trecfile.txt');
		AddToSuperfile_cnty('county.txt');
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::erwfile.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::inspfile.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::trecfile.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::county.raw'),
							 );
//  Spray All Files
export S0819_SprayFiles := SEQUENTIAL(
																			parallel(clear_super, clear_super_cnty)
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			

END;








