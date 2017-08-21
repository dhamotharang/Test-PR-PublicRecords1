// spray Utah Real Estate Appraisers and Agents File   
import ut, _control, Prof_License_Mari, Lib_FileServices;

//Files for S0683 are Located  //
export spray_UTS0683(string filedate) := MODULE

#workunit('name','Spray UTS0683'); 
shared filepath	  :=	'/data/data_build_5_2/MARI/in/UTROS0683/' + filedate +'/';	
shared maxRecordSize	:=	8192;
shared group_name	:=	Common_Prof_Lic_Mari.group_name;
shared superfile  := '~thor_data400::in::proflic_mari::UTS0683::using::rle_license';

shared destination := Prof_License_Mari.Common_Prof_Lic_Mari.SourcesFolder + 'UTS0683::'+ filedate + '::';

clear_super
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


TransformFile(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_UTS0683.raw,CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_UTS0683.src,SELF.ln_filedate := filedate; SELF := LEFT; self:= []));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);

END;		
	
//  Spray All Files
spray_all :=
	PARALLEL(
		SprayFile('license_list.txt','tab'));

//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('license_list.txt'),, 	destination + 'license_list.txt',	thor, OVERWRITE),
							OUTPUT(TransformFile('license_list.txt'),, 	destination + 'license_list.test',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"')), OVERWRITE),
				);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('license_list.txt'),
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::license_list.raw'),
							 );


//  Spray All Files
export S0683_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);

END;