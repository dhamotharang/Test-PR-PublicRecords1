
// spray IAS0826 Iowa Real Estate Commission & Appraisals Licenses Files for MARI	     
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;

EXPORT spray_IAS0826(STRING pVersion)  := MODULE

	#workunit('name','Spray IAS0826');
	SHARED STRING7 code						:= 'IAS0826';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
	SHARED superfile 							:= destination + 'sprayed::' + 'apr';
	

TransformFile(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := dataset(sprayed_file,
										Prof_License_Mari.Layout_IAS0826.raw,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_IAS0826.Common, SELF.ln_filedate := pVersion; 
																																				 SELF := LEFT; 
																																				 SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + pVersion + '::' +filename);

END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'Data Mart IA Appr mailing list.csv','comma'),
		Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'Data Mart IA Appr mailing list_AMC.csv','comma');
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('Data Mart IA Appr mailing list.csv'),, destination + pVersion + '::Data Mart IA Appr mailing list.csv', 
							                      CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n'])), OVERWRITE),
							OUTPUT(TransformFile('Data Mart IA Appr mailing list_AMC.csv'),, destination + pVersion + '::Data Mart IA Appr mailing list_AMC.csv', 
							                      CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n'])), OVERWRITE);												

	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('Data Mart IA Appr mailing list.csv');
		AddToSuperfile('Data Mart IA Appr mailing list_AMC.csv');
		FileServices.FinishSuperFileTransaction()
	);

clear_super
	:=
		IF(FileServices.SuperFileExists(superfile), 
			FileServices.ClearSuperFile(superfile),
			FileServices.CreateSuperFile(superfile));

remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + pVersion + '::Data Mart IA Appr mailing list.raw'),
							 FileServices.DeleteLogicalFile(destination + pVersion + '::Data Mart IA Appr mailing list_AMC.raw')
							 );
							 
//  Spray All Files
export S0826_SprayFiles := SEQUENTIAL(clear_super, spray_all, xform_all, super_all, remove_raw);
																			

END;



