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

// Transform Timashare
// TransformFile_reb(string filename) := FUNCTION
	// n := StringLib.StringFind(filename, '.',1);
	// newname := filename[1..(n-1)];
	// sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	// dsraw := dataset(sprayed_file,
										// Prof_License_Mari.Layout_IDS0827.raw,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	// ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_IDS0827.Common,SELF.ln_file_type := 'BRK';
																																				// SELF.ln_filedate := filedate; 
																																				// SELF := LEFT; 
																																				// self:= []));
	
	// RETURN ds;
	
// END;		




AddToSuperfile_rel(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_rel, destination + filedate + '::' +filename);
			
END;		


//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'All_Licenses.csv','comma');
		// Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Timeshare_Land_Registration.csv','comma');
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_rel('All_Licenses.csv'),, 	destination + filedate + '::All_Licenses.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							// OUTPUT(TransformFile_rel('Timeshare_Land_Registration.csv'),, 	destination + filedate + '::Timeshare_Land_Registration.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
					 	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_rel('All_Licenses.csv'),
		// AddToSuperfile_rel('Timeshare_Land_Registration.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::All_Licenses.raw'),
							 // FileServices.DeleteLogicalFile(destination + filedate + '::Timeshare_Land_Registration.raw'),
							 );


export S0827_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			
END;







	//  Spray All Files
	// EXPORT S0827_SprayFiles(string pVersion) := FUNCTION
	
		//Use for 20130502 and 20130807
		/*RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Company_modified.csv', 'company','comma'); 		
					          Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Licensee_modified.csv', 'licensee','comma'); 		
										);*/
		//For 20130913		
		//Associate Broker.csv is renamed to Broker.csv
		// RETURN PARALLEL(//Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Broker.csv', 'associate_broker','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Broker_not_active.csv', 'broker_inactive','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Cert_Instructor.csv', 'cert_instructor','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Companies.csv', 'companies','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Designated_Broker.csv', 'desig_broker','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Limited_Broker.csv', 'limited_broker','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Managing_Assoc_Broker.csv', 'managing_associate_broker','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Managing_Broker.csv', 'managing_broker','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Managing_Salesperson.csv', 'managing_salesperson','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Salesperson.csv', 'salesperson','comma'); 		

										//For 20140714
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Licensees.csv', 'licensees','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'branch office all.csv', 'branchoffice','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'corporations all.csv', 'corporations','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'llc all.csv', 'llc','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'llp all.csv', 'llp','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'lp all.csv', 'lp','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'partnerships all.csv', 'partnerships','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'sp all.csv', 'sp','comma'); 		
										
										//For 20140813
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Assoc_Broker_Licensees.csv', 'associate_broker','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Branch_Companies.csv', 'branch','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Broker_Licensees.csv', 'broker','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Corp_Companies.csv', 'corporation','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Desig_Broker_Licensees.csv', 'desig_broker','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Limited_Broker_Licensees.csv', 'limited_broker','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Limited_lib_Companies.csv', 'llc','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'limited_lib_part_Companies.csv', 'llp','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'limited_part_Companies.csv', 'lp','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Manag_Assoc_broker_Licensees.csv', 'managing_associate_broker','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'partnership_Companies.csv', 'partnership','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'sales_Licensees.csv', 'salesperson','comma'); 		
					          // Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'sole_prop_Companies.csv', 'sp','comma'); 		

										// );

	// END;

// END;

