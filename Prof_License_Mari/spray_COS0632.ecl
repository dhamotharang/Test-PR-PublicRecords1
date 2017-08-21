import ut, _control, Prof_License_Mari, Lib_FileServices;

//Colorado Uniform Consumer Credit:S0632 //
export spray_COS0632(string filedate) := MODULE
shared code						:= 'COS0632';
export sourcepath		:=	'/data/data_build_5_2/MARI/in/';
shared filepath		  	:=	Prof_License_Mari.Common_Prof_Lic_Mari.sourcepath+code+'/' + filedate +'/';	
shared maxRecordSize	:=	8192;
shared superfile 			:= Prof_License_Mari.Common_Prof_Lic_Mari.MariDestpath+code+'::using::uccc';
shared destination 		:= Prof_License_Mari.Common_Prof_Lic_Mari.SourcesFolder + code + '::'+ filedate + '::';

clear_super
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile));


file_transfer := sequential(FileServices.StartSuperFileTransaction()
                              	,FileServices.ClearSuperFile(Prof_License_Mari.thor_cluster + 'in::proflic_mari::'+ code + '::used::uccc')
															
																,FileServices.AddSuperFile(Prof_License_Mari.thor_cluster + 'in::proflic_mari::'+ code + '::used::uccc'
																														,Prof_License_Mari.thor_cluster + 'in::proflic_mari::'+ code + '::using::uccc',, true)
																
																,FileServices.ClearSuperFile(Prof_License_Mari.thor_cluster + 'in::proflic_mari::'+ code + '::using::uccc')
																
																,FileServices.AddSuperFile(Prof_License_Mari.thor_cluster + 'in::proflic_mari::'+ code + '::using::uccc' 
                                                            ,Prof_License_Mari.thor_cluster + 'in::proflic_mari::'+ code + '::sprayed::uccc',, true)
																,FileServices.FinishSuperFileTransaction());

											
SprayFile(string filename, string delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\r','',
																		 Prof_License_Mari.Common_Prof_Lic_Mari.group_name, 
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
										Prof_License_Mari.Layout_COS0632.raw,CSV(HEADING(0),SEPARATOR(','),QUOTE('"'),TERMINATOR('\r\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_COS0632.src,SELF.ln_filedate := filedate; SELF := LEFT; self:= []));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);

END;		
	

//  Spray All Files
spray_all :=
	PARALLEL(
		SprayFile('UcccReport.csv','comma'));
	


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('ucccreport.csv'),, 	destination + 'ucccreport.csv',	CSV(HEADING(1),SEPARATOR(','),TERMINATOR('\r\n'),QUOTE('"')), OVERWRITE),
				);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('ucccreport.csv'),
		FileServices.FinishSuperFileTransaction()
	);

remove_all
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + 'ucccreport.raw'),
							 );
//  Spray All Files
export S0632_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_all);
																			// ,file_transfer);

END;