// spray COS0821 Professional Licenses Files for MARI	   


IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;	   

EXPORT spray_COS0821(STRING filedate) := MODULE
#workunit('name','Spray COS0821 '+ filedate);

	SHARED code												:= 'COS0821';
	SHARED destination 								:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  SHARED superfile_sub  						:= destination + 'using::' + 'subdivision';
	SHARED superfile_inactive_brkr   	:= destination + 'using::' + 'inactvie_brokers';
	SHARED superfile_inactive_app   	:= destination + 'using::' + 'inactive_appraisers';
	SHARED superfile_AMC_company			:= destination + 'using::' + 'AMC_company';
	SHARED superfile_active_res_brkr 	:= destination + 'using::' + 'active_res_brokers';
	SHARED superfile_active_company		:= destination + 'using::' + 'active_company';
	SHARED superfile_active_prop			:= destination + 'using::' + 'active_proprietors';
	SHARED superfile_active_ass_brkr	:= destination + 'using::' + 'active_ass_brokers';	
	SHARED superfile_active_app 			:= destination + 'using::' + 'active_appraisers';
	
	
clear_superfile_sub
	:=
		IF(FileServices.SuperFileExists(superfile_sub)
			,FileServices.ClearSuperFile(superfile_sub)
			,FileServices.CreateSuperFile(superfile_sub));
			
clear_superfile_inactive_brkr
	:=
		IF(FileServices.SuperFileExists(superfile_inactive_brkr)
			,FileServices.ClearSuperFile(superfile_inactive_brkr)
			,FileServices.CreateSuperFile(superfile_inactive_brkr));			

clear_superfile_inactive_app
	:=
		IF(FileServices.SuperFileExists(superfile_inactive_app)
			,FileServices.ClearSuperFile(superfile_inactive_app)
			,FileServices.CreateSuperFile(superfile_inactive_app));
			
clear_superfile_AMC_company
	:=
		IF(FileServices.SuperFileExists(superfile_AMC_company)
			,FileServices.ClearSuperFile(superfile_AMC_company)
			,FileServices.CreateSuperFile(superfile_AMC_company));
			
clear_superfile_active_res_brkr
	:=
		IF(FileServices.SuperFileExists(superfile_active_res_brkr)
			,FileServices.ClearSuperFile(superfile_active_res_brkr)
			,FileServices.CreateSuperFile(superfile_active_res_brkr));
						
clear_superfile_active_company
	:=
		IF(FileServices.SuperFileExists(superfile_active_company)
			,FileServices.ClearSuperFile(superfile_active_company)
			,FileServices.CreateSuperFile(superfile_active_company));
			
clear_superfile_active_prop
	:=
		IF(FileServices.SuperFileExists(superfile_active_prop)
			,FileServices.ClearSuperFile(superfile_active_prop)
			,FileServices.CreateSuperFile(superfile_active_prop));
			
clear_superfile_active_ass_brkr
	:=
		IF(FileServices.SuperFileExists(superfile_active_ass_brkr)
			,FileServices.ClearSuperFile(superfile_active_ass_brkr)
			,FileServices.CreateSuperFile(superfile_active_ass_brkr));
						
clear_superfile_active_app
	:=
		IF(FileServices.SuperFileExists(superfile_active_app)
			,FileServices.ClearSuperFile(superfile_active_app)
			,FileServices.CreateSuperFile(superfile_active_app));						
						
clear_super
	:=
		SEQUENTIAL(clear_superfile_sub;
		           clear_superfile_inactive_brkr;			
							 clear_superfile_inactive_app;
							 clear_superfile_AMC_company;
							 clear_superfile_active_res_brkr;
							 clear_superfile_active_company;
							 clear_superfile_active_prop;
							 clear_superfile_active_ass_brkr;
							 clear_superfile_active_app;			
			       );


// Transform Subdivision File
// License Type : SD
TransformFile_Sub(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_COS0821.Real_Estate_Subdivision,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_COS0821.Broker_Common,SELF.ln_file_type := 'Real_Estate_Subdivision';
																																				SELF.ln_filedate := filedate; 
																																				SELF := LEFT; 
																																				SELF:= []));	
	RETURN ds;
	
END;		

// Transform Inactive Broker File
//License Type: EA,EI, ER,FA,IA,II,IR
TransformFile_inactive_brkr(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_COS0821.Inactive_BRKR,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_COS0821.Broker_Common,SELF.ln_file_type := 'INACTIVE/EXPIRED BRKR';
																																							 SELF.ln_filedate := filedate; 
																																							 SELF := LEFT; 
																																							 SELF:= []));
	
	RETURN ds;
	
END;		


// Transform Inactive Appraiser File
//License Types: AL, CG, CR,
TransformFile_inactive_app(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_COS0821.Inactive_APPR,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_COS0821.Broker_Common,SELF.ln_file_type := 'INACTIVE/EXPIRED APPR';
																																							 SELF.ln_filedate := filedate; 
																																							 SELF := LEFT; 
																																							 SELF:= []));
	
	RETURN ds;
	
END;		


// Transform Appraisal_Management_Company File
//License Type: IC, AMC
TransformFile_AMC_company(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_COS0821.AMC_Cmpny,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_COS0821.Broker_Common,SELF.ln_file_type := 'AMC CMPANY';
																																							 SELF.ln_filedate := filedate; 
																																							 SELF := LEFT; 
																																							 SELF:= []));
	
	RETURN ds;
	
END;

// Active_Associate_Brokers File
//License Type: EA, FA, IA
TransformFile_active_ass_brkr(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_COS0821.Active_BRKR,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_COS0821.Broker_Common,SELF.ln_file_type := 'ACTV ASSOC BRKR';
																																							 SELF.ln_filedate := filedate; 
																																							 SELF := LEFT; 
																																							 SELF:= []));
	
	RETURN ds;
	
END;
// Transform Active_Real_Estate_Companies File
//License Type  EC, IC
TransformFile_active_company(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_COS0821.Real_Estate_Companies,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_COS0821.Broker_Common,SELF.ln_file_type := 'CMPNY';
																																							 SELF.ln_filedate := filedate; 
																																							 SELF := LEFT; 
																																							 SELF:= []));
	
	RETURN ds;
	
END;


//Transform Active_Individual_Proprietors File
//License_type  EI, II
TransformFile_active_prop(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_COS0821.Active_Prop,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_COS0821.Broker_Common,SELF.ln_file_type := 'ACTIVE PROP';
																																							 SELF.ln_filedate := filedate; 
																																							 SELF := LEFT; 
																																							 SELF:= []));
	
	RETURN ds;
	
END;

//Transform Active_Responsible_Broker File
//License_type  ER, IR,
TransformFile_active_res_brkr(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_COS0821.Active_Individual,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_COS0821.Broker_Common,SELF.ln_file_type := 'ACTIVE RES BRKR';
																																							 SELF.ln_filedate := filedate; 
																																							 SELF := LEFT; 
																																							 SELF:= []));
	
	RETURN ds;
	
END;

//Transform Active_Appraisers File
//License Type:AL, AV, CG, CR
TransformFile_active_app(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_COS0821.Active_APPR,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_COS0821.Broker_Common,SELF.ln_file_type := 'ACTIVE APPR';
																																							 SELF.ln_filedate := filedate; 
																																							 SELF.STATUS := 'ACTIVE';
																																							 SELF := LEFT; 
																																							 SELF:= []));
	
	RETURN ds;
	
END;

//Add to SuperFile
AddToSuperfile_sub(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_sub, destination + filedate + '::' +filename);
			
END;		


AddToSuperfile_inactive_brkr(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_inactive_brkr, destination + filedate + '::' +filename);
			
END;	

AddToSuperfile_inactive_app(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_inactive_app, destination + filedate + '::' +filename);

END;	

AddToSuperfile_AMC_company(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_AMC_company, destination + filedate + '::' +filename);

END;	

AddToSuperfile_active_res_brkr(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_active_res_brkr, destination + filedate + '::' +filename);
			
END;		


AddToSuperfile_active_company(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_active_company, destination + filedate + '::' +filename);
			
END;	

AddToSuperfile_active_app(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_active_app, destination + filedate + '::' +filename);

END;	

AddToSuperfile_active_prop(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_active_prop, destination + filedate + '::' +filename);

END;

AddToSuperfile_active_ass_brkr(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_active_ass_brkr, destination + filedate + '::' +filename);

END;

 // Spray All Files	
spray_all	:=
	PARALLEL(
						Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Active_Appraisers.csv','comma');
						Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Active_Associate_Brokers.csv','comma');
						Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Active_Individual_Proprietors.csv','comma');
						Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Active_Real_Estate_Companies.csv','comma');
						Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Active_Responsible_Brokers.csv','comma');
						Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'AMC_-_Appraisal_Management_Company_-_Active.csv','comma');
						Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Inactive_Appraisers.csv','comma');
						Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Inactive_Real_Estate_Brokers.csv','comma');
						Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'SD_-_Subdivision_Developer_-_Active.csv','comma');
           );

xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_active_app('Active_Appraisers.csv'),, 	destination + filedate + '::Active_Appraisers.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_inactive_app ('Inactive_Appraisers.csv'),, destination + filedate + '::Inactive_Appraisers.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_AMC_company('AMC_-_Appraisal_Management_Company_-_Active.csv'),, 	destination + filedate + '::AMC_-_Appraisal_Management_Company_-_Active.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_active_ass_brkr('Active_Associate_Brokers.csv'),, 	destination + filedate + '::Active_Associate_Brokers.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_inactive_brkr('Inactive_Real_Estate_Brokers.csv'),, 	destination + filedate + '::Inactive_Real_Estate_Brokers.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_active_company('Active_Real_Estate_Companies.csv'),, 	destination + filedate + '::Active_Real_Estate_Companies.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_active_prop('Active_Individual_Proprietors.csv'),, 	destination + filedate + '::Active_Individual_Proprietors.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_active_res_brkr('Active_Responsible_Brokers.csv'),, 	destination + filedate + '::Active_Responsible_Brokers.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							OUTPUT(TransformFile_sub('SD_-_Subdivision_Developer_-_Active.csv'),, 	destination + filedate + '::SD_-_Subdivision_Developer_-_Active.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
				);	



//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_active_app('Active_Appraisers.csv'),
		AddToSuperfile_inactive_app('Inactive_Appraisers.csv'),
		AddToSuperfile_AMC_company('AMC_-_Appraisal_Management_Company_-_Active.csv'),
		AddToSuperfile_active_company('Active_Real_Estate_Companies.csv'),
		AddToSuperfile_active_ass_brkr('Active_Associate_Brokers.csv'),
		AddToSuperfile_inactive_brkr('Inactive_Real_Estate_Brokers.csv'),
		AddToSuperfile_active_prop('Active_Individual_Proprietors.csv'),
		AddToSuperfile_active_res_brkr('Active_Responsible_Brokers.csv'),
		AddToSuperfile_sub('SD_-_Subdivision_Developer_-_Active.csv'),
		FileServices.FinishSuperFileTransaction()
	);

														 
remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::Active_Appraisers.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Active_Associate_Brokers.raw'),	
							 FileServices.DeleteLogicalFile(destination + filedate + '::Active_Individual_Proprietors.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Active_Real_Estate_Companies.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Active_Responsible_Brokers.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::AMC_-_Appraisal_Management_Company_-_Active.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Inactive_Appraisers.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::Inactive_Real_Estate_Brokers.raw'),
							 FileServices.DeleteLogicalFile(destination + filedate + '::SD_-_Subdivision_Developer_-_Active.raw'),
						 );
	

//  Spray All Files
EXPORT S0821_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw
																			);
																			

END;
