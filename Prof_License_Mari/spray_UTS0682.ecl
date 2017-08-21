// spray Utah Mortgage Lenders  File   



import ut, _control, Prof_License_Mari, Lib_FileServices;

//Files for S0683 are Located  //
export spray_UTS0682(string filedate) := MODULE
#workunit('name','Spray UTS0682 ' + filedate); 


SHARED STRING7 code						:= 'UTS0682';
SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
SHARED superfile 							:= destination + 'using::' + 'mtg_license';


clear_super
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile));


// Transform Mortgage File
TransformFile_MTG(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_UTS0682.mortgage,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_UTS0682.common,SELF.file_type := 'MTG';
																																				SELF.PO_BOX  := if(left.PO_BOX != '' and regexfind('(^[0-9])', trim(left.PO_BOX)),
																																															'PO BOX ' + left.PO_BOX,
																																																		'');
																																				SELF.ln_filedate := filedate; 
																																				SELF := LEFT; 
																																				self:= []));
	
	RETURN ds;
	
END;		

// Transform Financial Institution
TransformFile_FIN(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_UTS0682.financial,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_UTS0682.common,SELF.file_type := 'FIN';
																																				SELF.ln_filedate := filedate; 
																																				SELF := LEFT; 
																																				self:= []));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filedate + '::' +filename);

END;		

	
//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'MTG-LEND.csv','comma');
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'INSTADDR.txt','comma');
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_MTG('MTG-LEND.csv'),, 	destination + filedate + '::MTG-LEND.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_FIN('INSTADDR.txt '),, 	destination + filedate + '::INSTADDR.txt',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE)
				);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('MTG-LEND.csv'),
		AddToSuperfile('INSTADDR.txt'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + 'mtg-len.raw'),
							 FileServices.DeleteLogicalFile(destination + 'instaddr.raw'),
							 
							 );

//  Spray All Files
export S0682_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			

END;


