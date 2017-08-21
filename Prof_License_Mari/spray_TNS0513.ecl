// spray Utah Real Estate Appraisers and Agents File   
import ut, _control, Prof_License_Mari, Lib_FileServices;

export spray_TNS0513(string filedate) := MODULE
// #workunit('name','Spray TNS0513'); 

shared filepath		  :=	'/data/data_build_5_2/MARI/in/TNROS0513/' + filedate +'/';	
shared maxRecordSize:=	8192;
shared group_name	  :=	Common_Prof_Lic_Mari.group_name;
shared superfile    := '~thor_data400::in::proflic_mari::TNS0513::using::rle_license';

shared destination := Prof_License_Mari.Common_Prof_Lic_Mari.SourcesFolder + 'TNS0513::'+ filedate + '::';

clear_super_active
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile));


SprayFile(string filename, string delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\r\n','',
																		 group_name, 
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
										Prof_License_Mari.Layout_TNS0513.raw,CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_TNS0513.src,SELF.ln_filedate := filedate; SELF := LEFT; self:= [ ]));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);

END;		
	

//  Spray All Files
spray_all :=
	PARALLEL(
		SprayFile('1501.txt','\t');
		SprayFile('1503.txt','\t');
		SprayFile('2501.txt','\t');
		SprayFile('2502.txt','\t');
		SprayFile('2507.txt','\t');
		SprayFile('2509.txt','\t'));
		
	


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('1501.txt'),, 	destination + '1501.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('1503.txt'),, 	destination + '1503.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('2501.txt'),, 	destination + '2501.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('2502.txt'),, 	destination + '2502.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('2507.txt'),, 	destination + '2507.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('2509.txt'),, 	destination + '2509.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
				);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('1501.txt'),
		AddToSuperfile('1503.txt'),
		AddToSuperfile('2501.txt'),
		AddToSuperfile('2502.txt'),
		AddToSuperfile('2507.txt'),
		AddToSuperfile('2509.txt'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + '1501.raw'),
							 FileServices.DeleteLogicalFile(destination + '1503.raw'),
							 FileServices.DeleteLogicalFile(destination + '2501.raw'),
							 FileServices.DeleteLogicalFile(destination + '2502.raw'),
							 FileServices.DeleteLogicalFile(destination + '2507.raw'),
							 FileServices.DeleteLogicalFile(destination + '2509.raw'),
							 );


//  Spray All Files
export S0513_SprayFiles := SEQUENTIAL(
																			clear_super_active
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);

END;


