// spray AKS0376 Professional Licenses Files for MARI	   

import ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   

//Files for S0376 are Located  //
export spray_AKS0376 (string filedate) := MODULE

#workunit('name','Yogurt:Spray AKS0376');

shared filepath		    :=	'/data/data_build_5_2/MARI/in/AKS0376/' + filedate +'/';
shared sourcepath		:=	'/data/data_build_5_2/MARI/';
shared group_name	:=	'thor400_66';
shared maxRecordSize	:=	8192;
shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'AKS0376::' + filedate + '::';
shared superfile := '~thor_data400::in::proflic_mari::aks0376::using::occlic';


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
	

TransformFile(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_AKS0376.OccLic,csv(SEPARATOR(','),quote('"'),heading(1), terminator('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_AKS0376.OccLic_src,SELF.ln_filedate := filedate; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);

END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		
		SprayFile('ProfessionalLicenseDownload.CSV','\\,') 
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('ProfessionalLicenseDownload.CSV'),, destination + 'ProfessionalLicenseDownload.CSV', csv(SEPARATOR(','),quote('"'),heading(1), terminator('\n')), OVERWRITE)
	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
			
		AddToSuperfile('ProfessionalLicenseDownload.CSV'),
		
		FileServices.FinishSuperFileTransaction()
	);


//  Spray All Files
export S0376_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,xform_all
																			,super_all);
																			

END;


