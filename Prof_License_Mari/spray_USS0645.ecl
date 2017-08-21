// spray USS0645 - HUD (Housing & Urban Development) Mortgage Lenders  
IMPORT ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	      
//Files for S0645 are Located  //
EXPORT spray_USS0645(STRING filedate) := MODULE

#workunit('name','Spray USS0645');
SHARED filepath		    :=	'/data/data_build_5_2/MARI/in/USS0645/' + filedate +'/';
SHARED sourcepath			:=	'/data/data_build_5_2/MARI/';
SHARED group_name			:=	Common_Prof_Lic_Mari.group_name;
SHARED maxRecordSize	:=	8192;
SHARED destination := Common_Prof_Lic_Mari.SourcesFolder + 'USS0645::' + filedate + '::';
SHARED superfile_lender := '~thor_data400::in::proflic_mari::USS0645::using::lenders';
SHARED superfile_re := '~thor_data400::in::proflic_mari::USS0645::using::reference_company ';

	   
clear_super_lender
	:=
		IF(FileServices.SuperFileExists(superfile_lender)
			,FileServices.ClearSuperFile(superfile_lender)
			,FileServices.CreateSuperFile(superfile_lender)
			);		 


clear_super_re
	:=
		IF(FileServices.SuperFileExists(superfile_re)
			,FileServices.ClearSuperFile(superfile_re)
			,FileServices.CreateSuperFile(superfile_re)
			);		
			
SprayFile(STRING filename, STRING delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\n','',
																		 group_name, 
																		 destination + StringLib.StringToLowerCase(newname) + '.raw',
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 																									
END;



TransformFile_Lender(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := DATASET(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_USS0645.FOIA,CSV(SEPARATOR(','),QUOTE('"')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_USS0645.COMMON, SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


// TransformFile_Reference(STRING filename) := FUNCTION
	// n := StringLib.StringFind(filename, '.',1);
	// newname := filename[1..(n-1)];
	// dsraw := DATASET(destination + StringLib.StringToLowerCase(newname) + '.raw',
										// Prof_License_Mari.Layout_USS0645.reference,CSV(SEPARATOR(','),QUOTE('"')));
					
	// ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_USS0645.COMMON, SELF := LEFT; SELF :=[]));
	
	// RETURN ds;
	
// END;		


AddToSuperfile_lender(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_lender, destination + filename);

END;		

// AddToSuperfile_reference(STRING filename) := FUNCTION
	// RETURN 	
			// FileServices.AddSuperFile(superfile_re, destination + filename);

// END;	

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('FOIA.csv','\\,'), 	 
		// SprayFile('reference.csv','\\,') 
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Lender('FOIA.csv'),, destination + 'FOIA.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							// OUTPUT(TransformFile_Reference('reference.csv'),, destination + 'reference.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE)	

	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_lender('FOIA.csv'),
		// AddToSuperfile_reference('reference.csv'),
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + 'foia.raw'),
							 // FileServices.DeleteLogicalFile(destination +  '::reference.raw'),
							 );

//  Spray All Files
EXPORT S0645_SprayFiles := SEQUENTIAL(
																			clear_super_lender
																			,clear_super_re
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																		

END;