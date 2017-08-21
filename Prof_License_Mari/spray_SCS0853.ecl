// spray SCS0853 South Carolina Real Estate Appraisers
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_SCS0853(string filedate) := MODULE
#workunit('name','Spray SCS0853');

	SHARED STRING7 code						:= 'SCS0853';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  SHARED superfile_apr 					:= destination + 'sprayed::' + 'apr';


	// Spray all raw files
	// EXPORT S0853_SprayFiles(string pVersion) := FUNCTION
	
		// RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'ContactsByBoard.csv', 'apr','comma'),
										// );
	// END;

// END;


clear_super
	:=
		IF(FileServices.SuperFileExists(superfile_apr)
			,FileServices.ClearSuperFile(superfile_apr)
			,FileServices.CreateSuperFile(superfile_apr));


// Transform Appraiser
TransformFile_apr(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_SCS0853.current,CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_SCS0853.Common,SELF.ln_filedate := filedate; 
																																				SELF := LEFT; 
																																				self:= []));
	
	RETURN ds;
	
END;		



AddToSuperfile_apr(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_apr, destination + filedate + '::' +filename);
			
END;		


//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'ContactsByBoard.csv','comma');
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_apr('ContactsByBoard.csv'),, 	destination + filedate + '::ContactsByBoard.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
					 	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_apr('ContactsByBoard.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::ContactsByBoard.raw'),
							 
							 );


export S0853_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw
																			);
																			
END;
