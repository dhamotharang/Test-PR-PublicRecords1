//Iowa Real Estate Professionals License File
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_IAS0887(string filedate) := MODULE

	SHARED STRING7 code						:= 'IAS0887';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
	SHARED superfile_rel 					:= destination + 'sprayed::' + 'rle';

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
										Prof_License_Mari.Layout_IAS0887.real_estate,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_IAS0887.Common,SELF.ln_filedate := filedate; 
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
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'choicepoint_RE_mailing_list.csv','comma');
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_rel('choicepoint_RE_mailing_list.csv'),, 	destination + filedate + '::choicepoint_RE_mailing_list.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
					 	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_rel('choicepoint_RE_mailing_list.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::choicepoint_RE_mailing_list.raw'),
							 );


export S0887_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			
END;
