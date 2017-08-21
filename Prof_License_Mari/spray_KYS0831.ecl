// spray KYS0831 - Kentucky Real Estate Agents, Brokers, & Firms  	     
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_KYS0831(string filedate) := MODULE
	SHARED STRING7 code						:= 'KYS0831';
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
										Prof_License_Mari.Layout_KYS0831.real_estate,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_KYS0831.Common,SELF.ln_filetype := 'REL';
																																				 SELF.ln_filedate := filedate; 
																																				 SELF := LEFT; 
																																				 self:= []));
	
	RETURN ds;
	
END;		

// Transform Escrow
TransformFile_escrow(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_KYS0831.escrow,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_KYS0831.Common,SELF.ln_filetype := 'ESC';
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
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Active_Real_Estate.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Escrow.csv','comma');
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_rel('Active_Real_Estate.csv'),, 	destination + filedate + '::Active_Real_Estate.csv',	CSV(SEPARATOR(','),HEADING(1),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_escrow('Escrow.csv'),, 	destination + filedate + '::Escrow.csv',	CSV(SEPARATOR(','),HEADING(1),QUOTE('"')), OVERWRITE),
					 	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_rel('Active_Real_Estate.csv'),
		AddToSuperfile_rel('Escrow.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::Active_Real_Estate.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Escrow.raw'),
							 );


export S0831_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			
END;
