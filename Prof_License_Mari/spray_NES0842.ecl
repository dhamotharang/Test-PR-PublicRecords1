// spray NES0842 Nebraska Real Estate Professional Licenses Files for MARI
// These is a problem where newline(\r\n or 0d0a) is found within  double quotes in the label and label2 fields.	
// Solution - excel function clean(substitute(cell,char(10),char(124)))
// Steps -
// 		a. Open the xls file
// 		b. Create a new column next to the column to be cleaned
// 		c. Select all cells in the new column (except the one on header row)
// 		d. Enter formula
// 		e. Control enter (so that all cells have the formula populated)
// 		f. Save the file to lexisnexis.csv
// 		g. Close file and open it again. Delete old label2 and label column
	

IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib, Lib_date;

EXPORT spray_NES0842 (string filedate):= MODULE

#workunit('name','Yogurt: Spray NES0842');
shared string7 code := 'NES0842';

shared filepath				:=	Common_Prof_Lic_Mari.sourcepath + code + '/' + filedate + '/';
shared maxRecordSize	:=	8192;
shared destination 					:= Common_Prof_Lic_Mari.SourcesFolder + code + '::' + filedate + '::';
superfile_rle := '~thor_data400::in::proflic_mari::nes0842::using::re';
// sprayed_file					:= destination + filedate + '::' + StringLib.StringToLowerCase(filename);

	// SHARED STRING7 code						:= 'NES0842';
	//  Spray all raw files
	// EXPORT S0842_SprayFiles(string pVersion) := FUNCTION
	
		// RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'lexisnexis.csv', 're','comma'),
										// );
	// END;

// END;

clear_super
	:=
		IF(FileServices.SuperFileExists(superfile_rle), 
			FileServices.ClearSuperFile(superfile_rle),
			FileServices.CreateSuperFile(superfile_rle));
											 

SprayFile(string filename, string delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 map(delim='comma'=>',',
																				  delim='tab'=>'\\t',
																								''),
																						'\r\n',
																						'',
																		 Common_Prof_Lic_Mari.group_name,
																		 destination + StringLib.StringToLowerCase(newname) + '.raw',
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 				
END;



TransformFile(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_NES0842.incoming,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_NES0842.common,SELF.ln_filedate := filedate; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_rle, destination + filename);

END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('lexisnexis.csv','\\,'), 	 
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('lexisnexis.csv'),, destination + 'lexisnexis.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),

	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('lexisnexis.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + 'lexisnexis.raw'),
							 );


//  Spray All Files
export S0842_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			

END;
