
import ut, _control, Prof_License_Mari, Lib_FileServices;

//Colorado Real Estate Mortgage:S0865 //
export spray_COS0865(string filedate) := MODULE

	shared code						:= 'COS0865';
	SHARED destination 		:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  shared superfile_active	  	:= Prof_License_Mari.Common_Prof_Lic_Mari.MariDestpath +code+' ::using::active';
  shared superfile_inactive		:= Prof_License_Mari.Common_Prof_Lic_Mari.MariDestpath +code+' ::using::inactive';
  //shared superfile_expired		:= Prof_License_Mari.Common_Prof_Lic_Mari.MariDestpath +code+' ::using::expired';
	
clear_super_active
	:=
		IF(FileServices.SuperFileExists(superfile_active)
			,FileServices.ClearSuperFile(superfile_active)
			,FileServices.CreateSuperFile(superfile_active));
			
clear_super_inactive
	:=
		IF(FileServices.SuperFileExists(superfile_inactive)
			,FileServices.ClearSuperFile(superfile_inactive)
			,FileServices.CreateSuperFile(superfile_inactive));


// clear_super_expired
	// :=
		// IF(FileServices.SuperFileExists(superfile_expired)
			// ,FileServices.ClearSuperFile(superfile_expired)
			// ,FileServices.CreateSuperFile(superfile_expired));

TransformFile_active(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	ds := dataset(destination + filedate + '::' + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_COS0865.active,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\r\n')));
					
	RETURN ds;
	
END;		


TransformFile_inactive(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	ds := dataset(destination + filedate + '::' + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_COS0865.inactive,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\r\n')));
					
	RETURN ds;
	
END;		

// TransformFile_expired(string filename) := FUNCTION
	// n := StringLib.StringFind(filename, '.',1);
	// newname := filename[1..(n-1)];
	// ds := dataset(destination + filedate + '::' + StringLib.StringToLowerCase(newname) + '.raw',
										// Prof_License_Mari.Layout_COS0865.expired,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\r\n')));
					
	
	// RETURN ds;
	
// END;	

AddToSuperfile_active(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_active, destination + filedate + '::' + filename);
END;		
	
	
AddToSuperfile_inactive(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_inactive, destination + filedate + '::' + filename);
END;		

// AddToSuperfile_expired(string filename) := FUNCTION
	// RETURN 	
	// FileServices.AddSuperFile(superfile_expired, destination + filedate + '::' + filename);
// END;		
	


//  Spray All Files
spray_all :=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'MLO_-_Mortgage_Loan_Originator_-_Active.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'MLO_-_Mortgage_Loan_Originator_-_Inactive.csv','comma');
		// Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'MLO_-_Mortgage_Loan_Originator_-_Expired.csv','comma');
		);
	


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_active('MLO_-_Mortgage_Loan_Originator_-_Active.csv'),, 	destination + filedate + '::MLO_-_Mortgage_Loan_Originator_-_Active.csv',	CSV(HEADING(1),SEPARATOR(','),TERMINATOR('\r\n'),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_inactive('MLO_-_Mortgage_Loan_Originator_-_Inactive.csv'),, 	destination + filedate + '::MLO_-_Mortgage_Loan_Originator_-_Inactive.csv',	CSV(HEADING(1),SEPARATOR(','),TERMINATOR('\r\n'),QUOTE('"')), OVERWRITE),
//							OUTPUT(TransformFile_expired('MLO_-_Mortgage_Loan_Originator_-_Expired.csv'),, 	destination + filedate + '::MLO_-_Mortgage_Loan_Originator_-_Expired.csv',	CSV(HEADING(1),SEPARATOR(','),TERMINATOR('\r\n'),QUOTE('"')), OVERWRITE),
				);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_active('MLO_-_Mortgage_Loan_Originator_-_Active.csv'),
		AddToSuperfile_inactive('MLO_-_Mortgage_Loan_Originator_-_Inactive.csv'),
//		AddToSuperfile_expired('MLO_-_Mortgage_Loan_Originator_-_Expired.csv'),
		FileServices.FinishSuperFileTransaction()
	);

remove_all
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::MLO_-_Mortgage_Loan_Originator_-_Active.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::MLO_-_Mortgage_Loan_Originator_-_Inactive.raw'),
//							 FileServices.DeleteLogicalFile(destination + filedate + '::MLO_-_Mortgage_Loan_Originator_-_Expired.raw'),
							 );
//  Spray All Files
export S0865_SprayFiles := SEQUENTIAL(
																			clear_super_active
																			,clear_super_inactive
																			//,clear_super_expired
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_all);
																			

END;