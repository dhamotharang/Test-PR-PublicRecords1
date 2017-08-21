// spray Vermont Professional Licenses Files for MARI	   
import ut,_control,Prof_License_Mari,Lib_FileServices,lib_stringlib;
	   
//Files for S0356 are Located  //
export spray_VTS0356(string filedate) := MODULE
#workunit('name','Spray VTS0356'); 

shared filepath		 :=	'/data/data_build_5_2/MARI/in/VTS0356/' + filedate +'/';	
shared maxRecordSize	:=	8192;
SHARED group_name  :=	Common_Prof_Lic_Mari.group_name;
shared superfile   := '~thor_data400::in::proflic_mari::vts0356::using::rle_license';
shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'VTS0356::'+ filedate + '::';

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
										Prof_License_Mari.Layout_VTS0356.raw,CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_VTS0356.common,SELF.ln_filedate := filedate; SELF := LEFT; self:= []));
	
	RETURN ds;
	
END;		


TransformFile_amc(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_VTS0356.amc,CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_VTS0356.common,SELF.ln_filedate := filedate; SELF := LEFT; self:= []));

	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);

END;		
	

//  Spray All Files
spray_all :=
	PARALLEL(		
						SprayFile('Appraisal_Management_Companies_-_ACTIVE_ONLY.txt', 	'tab'), 
						SprayFile('General_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt',    'tab'),
						SprayFile('Licensed_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt', 	 'tab'), 
						SprayFile('Real_Estate_-_Brokers_Sales_Offices_-_ACTIVE_ONLY.txt','tab'),
						SprayFile('Real_Estate(ALL_Credentials).txt', 	'tab'), 
						SprayFile('Real_Estate_Appraiser_and_Appraisal_Management_Companies_-_ACTIVE_ONLY.txt','tab'),
            SprayFile('Real_Estate_Brokers_-_ACTIVE_ONLY.txt','tab'),
						SprayFile('Real_Estate_Companies_-_Main_Branch_Sole_-_ACTIVE_ONLY.txt','tab'),
		        SprayFile('Real_Estate_Salesperson_-_ACTIVE_ONLY.txt', 	'tab'),				
						SprayFile('Residential_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt', 	'tab')); 


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('Appraisal_Management_Companies_-_ACTIVE_ONLY.txt'),, 	destination + 'Appraisal_Management_Companies_-_ACTIVE_ONLY.txt',	CSV(SEPARATOR('\t'),TERMINATOR('\n')), OVERWRITE, NAMED('AMC')),
							OUTPUT(TransformFile('General_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt'),, destination + 'General_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt',CSV(SEPARATOR('\t'),TERMINATOR('\n')), OVERWRITE, NAMED('APPR')),
							OUTPUT(TransformFile('Licensed_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt'),, 	destination + 'Licensed_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt',	CSV(SEPARATOR('\t'),TERMINATOR('\n')), OVERWRITE, NAMED('LIC_APPR')),
							OUTPUT(TransformFile('Real_Estate_-_Brokers_Sales_Offices_-_ACTIVE_ONLY.txt'),, destination + 'Real_Estate_-_Brokers_Sales_Offices_-_ACTIVE_ONLY.txt',CSV(SEPARATOR('\t'),TERMINATOR('\n')), OVERWRITE, NAMED('BRKR_SALES_OFC')),
							OUTPUT(TransformFile_amc('Real_Estate(ALL_Credentials).txt'),, 	destination + 'Real_Estate(ALL_Credentials).txt',	CSV(SEPARATOR('\t'),TERMINATOR('\n')), OVERWRITE, NAMED('ALL_Credentials')),
							OUTPUT(TransformFile_amc('Real_Estate_Appraiser_and_Appraisal_Management_Companies_-_ACTIVE_ONLY.txt'),, 	destination + 'Real_Estate_Appraiser_and_Appraisal_Management_Companies_-_ACTIVE_ONLY.txt',	CSV(SEPARATOR('\t'),TERMINATOR('\n')), OVERWRITE, NAMED('APPR_AMC')),
							OUTPUT(TransformFile('Real_Estate_Brokers_-_ACTIVE_ONLY.txt'),, destination + 'Real_Estate_Brokers_-_ACTIVE_ONLY.txt',CSV(SEPARATOR('\t'),TERMINATOR('\n')), OVERWRITE, NAMED('BRKR')),
							OUTPUT(TransformFile('Real_Estate_Companies_-_Main_Branch_Sole_-_ACTIVE_ONLY.txt'),, 	destination + 'Real_Estate_Companies_-_Main_Branch_Sole_-_ACTIVE_ONLY.txt',	CSV(SEPARATOR('\t'),TERMINATOR('\n')), OVERWRITE,NAMED('BRNCH_SOLE')),
							OUTPUT(TransformFile('Real_Estate_Salesperson_-_ACTIVE_ONLY.txt'),, destination + 'Real_Estate_Salesperson_-_ACTIVE_ONLY.txt',CSV(SEPARATOR('\t'),TERMINATOR('\n')), OVERWRITE, NAMED('SALES')),
							OUTPUT(TransformFile('Residential_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt'),, 	destination + 'Residential_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt',	CSV(SEPARATOR('\t'),TERMINATOR('\n')), OVERWRITE, NAMED('RES_APPR'))
							

	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('Appraisal_Management_Companies_-_ACTIVE_ONLY.txt'),
		AddToSuperfile('General_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt'),
		AddToSuperfile('Licensed_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt'),
		AddToSuperfile('Real_Estate_-_Brokers_Sales_Offices_-_ACTIVE_ONLY.txt'),
		AddToSuperfile('Real_Estate(ALL_Credentials).txt'),
		AddToSuperfile('Real_Estate_Appraiser_and_Appraisal_Management_Companies_-_ACTIVE_ONLY.txt'),
		AddToSuperfile('Real_Estate_Brokers_-_ACTIVE_ONLY.txt'),
		AddToSuperfile('Real_Estate_Companies_-_Main_Branch_Sole_-_ACTIVE_ONLY.txt'),
		AddToSuperfile('Real_Estate_Salesperson_-_ACTIVE_ONLY.txt'),
		AddToSuperfile('Residential_Real_Estate_Appraiser_-_ACTIVE_ONLY.txt'),
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
							 // FileServices.DeleteLogicalFile(destination + 'Real_Estate.raw'),
							 // FileServices.DeleteLogicalFile(destination + 'Real_Estate_Appraiser_and_Appraisal_Management_Company.raw'),
							 FileServices.DeleteLogicalFile(destination + 'Appraisal_Management_Companies_-_ACTIVE_ONLY.raw'),
							 FileServices.DeleteLogicalFile(destination + 'General_Real_Estate_Appraiser_-_ACTIVE_ONLY.raw'),
							 FileServices.DeleteLogicalFile(destination + 'Licensed_Real_Estate_Appraiser_-_ACTIVE_ONLY.raw'),
							 FileServices.DeleteLogicalFile(destination + 'Real_Estate_-_Brokers_Sales_Offices_-_ACTIVE_ONLY.raw'),
							 FileServices.DeleteLogicalFile(destination + 'Real_Estate(ALL_Credentials).raw'),
							 FileServices.DeleteLogicalFile(destination + 'Real_Estate_Appraiser_and_Appraisal_Management_Companies_-_ACTIVE_ONLY.raw'),
							 FileServices.DeleteLogicalFile(destination + 'Real_Estate_Brokers_-_ACTIVE_ONLY.raw'),
							 FileServices.DeleteLogicalFile(destination + 'Real_Estate_Companies_-_Main_Branch_Sole_-_ACTIVE_ONLY.raw'),
							 FileServices.DeleteLogicalFile(destination + 'Real_Estate_Salesperson_-_ACTIVE_ONLY.raw'),
							 FileServices.DeleteLogicalFile(destination + 'Residential_Real_Estate_Appraiser_-_ACTIVE_ONLY.raw')
							 );



//  Spray All Files
export S0356_SprayFiles := SEQUENTIAL(
																			clear_super_active
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			

END;

