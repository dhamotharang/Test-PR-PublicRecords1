// spray ALS0635 Professional Licenses Files for MARI	   


import ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib, Lib_date;
	   

//Files for S0635 are Located  //
export spray_ALS0635 (string filedate) := MODULE

#workunit('name','Spray ALS0635');

shared filepath		    :=	'/data/data_build_5_2/MARI/in/ALS0635/' + filedate +'/';
shared sourcepath			:=	'/data/data_build_5_2/MARI/';
shared group_name			:=	Common_Prof_Lic_Mari.group_name;
shared maxRecordSize	:=	8192;
shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'ALS0635::' + filedate + '::';
shared superfile_mtg := '~thor_data400::in::proflic_mari::alS0635::using::mtg_license';

	   
clear_super_mtg
	:=
		IF(FileServices.SuperFileExists(superfile_mtg)
			,FileServices.ClearSuperFile(superfile_mtg)
			,FileServices.CreateSuperFile(superfile_mtg)
			);		 


			
SprayFile(string filename, string delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\r','',
																		 group_name, 
																		 destination + StringLib.StringToLowerCase(newname) + '.raw',
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 																									
END;



TransformFile_Mtg(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_ALS0635.Mortgage_License,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_ALS0635.Mortgage_License_src,SELF.ln_filedate := filedate; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfileMtg(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_mtg, destination + filename);

END;		



//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('ProfessionalLicenseDownload.csv','\\,'), 	 
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Mtg('ProfessionalLicenseDownload.csv'),, destination + 'ProfessionalLicenseDownload.csv', CSV(Heading(1), SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							

	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfileMtg(' ProfessionalLicenseDownload.csv'),
		FileServices.FinishSuperFileTransaction()
	);


//  Spray All Files
export S0635_SprayFiles := SEQUENTIAL(
																			clear_super_mtg
																		  ,spray_all
																			,xform_all
																			,super_all);
																			

END;


