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


TransformFile_EN(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_VTS0356.entity,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_VTS0356.common,SELF.ln_filedate := filedate; SELF := LEFT; self:= []));
	
	RETURN ds;
	
END;		


TransformFile_CO(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_VTS0356.Constituent,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')));
					
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
						SprayFile('Transitional Licensed Real Estate Appraiser.csv',','),
						SprayFile('Temporary Real Estate Appraiser.csv',','),
						SprayFile('Real Estate Salesperson.csv',','),
						SprayFile('Real Estate Salesperson Temporary.csv',','),
						SprayFile('Real Estate Brokerage Firm Branch Office.csv',','),
						SprayFile('Real Estate Brokerage Firm Main Office.csv',','),
						SprayFile('RealEstate Broker.csv',','),
						SprayFile('Real Estate Brokerage Firm Sole Proprietorship.csv',','),				
						SprayFile('Real Estate Broker Temporary License.csv',','),
						SprayFile('Real Estate Appraiser Trainee.csv',','),
						SprayFile('Registered Appraisal Management Company Main Office.csv',','),
						SprayFile('Registered Appraisal Management Company Branch Office.csv',','),
						SprayFile('Licensed Real Estate Appraiser.csv',','),
						SprayFile('Licensed Real Estate Appraiser Trainee.csv',','),
						SprayFile('Licensed Real Estate Appraiser Temporary License.csv',','),			
						SprayFile('Certified Residential Real Estate Appraiser.csv',','),
						SprayFile('Certified Residential Real Estate Appraiser Trainee.csv',','),
						SprayFile('Certified Residential Real Estate Appraiser Temporary License.csv',','),
						SprayFile('Certified General Real Estate Appraiser.csv',','),
						SprayFile('Certified General Real Estate Appraiser Trainee.csv',','),
						SprayFile('Certified General Real Estate Appraiser Temporary License.csv',',')								
						); 


//  Transform All Files
xform_all
	:= PARALLEL(
						OUTPUT(TransformFile_CO('Transitional Licensed Real Estate Appraiser.csv'),, destination + 'Transitional Licensed Real Estate Appraiser.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Temporary Real Estate Appraiser.csv'),, destination + 'Temporary Real Estate Appraiser.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Real Estate Salesperson.csv'),, destination + 'Real Estate Salesperson.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Real Estate Salesperson Temporary.csv'),, destination + 'Real Estate Salesperson Temporary.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_EN('Real Estate Brokerage Firm Branch Office.csv'),, destination + 'Real Estate Brokerage Firm Branch Office.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_EN('Real Estate Brokerage Firm Main Office.csv'),, destination + 'Real Estate Brokerage Firm Main Office.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('RealEstate Broker.csv'),, destination + 'RealEstate Broker.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Real Estate Brokerage Firm Sole Proprietorship.csv'),, destination + 'Real Estate Brokerage Firm Sole Proprietorship.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),	
						OUTPUT(TransformFile_CO('Real Estate Broker Temporary License.csv'),, destination + 'Real Estate Broker Temporary License.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Real Estate Appraiser Trainee.csv'),, destination + 'Real Estate Appraiser Trainee.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_En('Registered Appraisal Management Company Main Office.csv'),, destination + 'Registered Appraisal Management Company Main Office.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_En('Registered Appraisal Management Company Branch Office.csv'),, destination + 'Registered Appraisal Management Company Branch Office.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Licensed Real Estate Appraiser.csv'),, destination + 'Licensed Real Estate Appraiser.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Licensed Real Estate Appraiser Trainee.csv'),, destination + 'Licensed Real Estate Appraiser Trainee.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Licensed Real Estate Appraiser Temporary License.csv'),, destination + 'Licensed Real Estate Appraiser Temporary License.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Certified Residential Real Estate Appraiser.csv'),, destination + 'Certified Residential Real Estate Appraiser.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Certified Residential Real Estate Appraiser Trainee.csv'),, destination + 'Certified Residential Real Estate Appraiser Trainee.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Certified Residential Real Estate Appraiser Temporary License.csv'),, destination + 'Certified Residential Real Estate Appraiser Temporary License.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Certified General Real Estate Appraiser.csv'),, destination + 'Certified General Real Estate Appraiser.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Certified General Real Estate Appraiser Trainee.csv'),, destination + 'Certified General Real Estate Appraiser Trainee.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
						OUTPUT(TransformFile_CO('Certified General Real Estate Appraiser Temporary License.csv'),,destination + 'Certified General Real Estate Appraiser Temporary License.csv',CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE)
						);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('Transitional Licensed Real Estate Appraiser.csv'),
		AddToSuperfile('Temporary Real Estate Appraiser.csv'),
		AddToSuperfile('Real Estate Salesperson.csv'),
		AddToSuperfile('Real Estate Salesperson Temporary.csv'),
		AddToSuperfile('Real Estate Brokerage Firm Branch Office.csv'),
		AddToSuperfile('Real Estate Brokerage Firm Main Office.csv'),
		AddToSuperfile('RealEstate Broker.csv'),
		AddToSuperfile('Real Estate Brokerage Firm Sole Proprietorship.csv'),
		AddToSuperfile('Real Estate Broker Temporary License.csv'),
		AddToSuperfile('Real Estate Appraiser Trainee.csv'),
		AddToSuperfile('Registered Appraisal Management Company Main Office.csv'),
		AddToSuperfile('Registered Appraisal Management Company Branch Office.csv'),
		AddToSuperfile('Licensed Real Estate Appraiser.csv'),
		AddToSuperfile('Licensed Real Estate Appraiser Trainee.csv'),
		AddToSuperfile('Licensed Real Estate Appraiser Temporary License.csv'),			
		AddToSuperfile('Certified Residential Real Estate Appraiser.csv'),
		AddToSuperfile('Certified Residential Real Estate Appraiser Trainee.csv'),
		AddToSuperfile('Certified Residential Real Estate Appraiser Temporary License.csv'),
		AddToSuperfile('Certified General Real Estate Appraiser.csv'),
		AddToSuperfile('Certified General Real Estate Appraiser Trainee.csv'),
		AddToSuperfile('Certified General Real Estate Appraiser Temporary License.csv'),		
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
						FileServices.DeleteLogicalFile(destination + 'Transitional Licensed Real Estate Appraiser.raw'),
						FileServices.DeleteLogicalFile(destination + 'Temporary Real Estate Appraiser.raw'),
						FileServices.DeleteLogicalFile(destination + 'Real Estate Salesperson.raw'),
						FileServices.DeleteLogicalFile(destination + 'Real Estate Salesperson Temporary.raw'),
						FileServices.DeleteLogicalFile(destination + 'Real Estate Brokerage Firm Branch Office.raw'),
						FileServices.DeleteLogicalFile(destination + 'Real Estate Brokerage Firm Main Office.raw'),
						FileServices.DeleteLogicalFile(destination + 'RealEstate Broker.raw'),
						FileServices.DeleteLogicalFile(destination + 'Real Estate Brokerage Firm Sole Proprietorship.raw'),				
						FileServices.DeleteLogicalFile(destination + 'Real Estate Broker Temporary License.raw'),
						FileServices.DeleteLogicalFile(destination + 'Real Estate Appraiser Trainee.raw'),
						FileServices.DeleteLogicalFile(destination + 'Registered Appraisal Management Company Main Office.raw'),
						FileServices.DeleteLogicalFile(destination + 'Registered Appraisal Management Company Branch Office.raw'),
						FileServices.DeleteLogicalFile(destination + 'Licensed Real Estate Appraiser.raw'),
						FileServices.DeleteLogicalFile(destination + 'Licensed Real Estate Appraiser Trainee.raw'),
						FileServices.DeleteLogicalFile(destination + 'Licensed Real Estate Appraiser Temporary License.raw'),			
						FileServices.DeleteLogicalFile(destination + 'Certified Residential Real Estate Appraiser.raw'),
						FileServices.DeleteLogicalFile(destination + 'Certified Residential Real Estate Appraiser Trainee.raw'),
						FileServices.DeleteLogicalFile(destination + 'Certified Residential Real Estate Appraiser Temporary License.raw'),
						FileServices.DeleteLogicalFile(destination + 'Certified General Real Estate Appraiser.raw'),
						FileServices.DeleteLogicalFile(destination + 'Certified General Real Estate Appraiser Trainee.raw'),
						FileServices.DeleteLogicalFile(destination + 'Certified General Real Estate Appraiser Temporary License.raw')		
							 );



//  Spray All Files
export S0356_SprayFiles := SEQUENTIAL(
																			clear_super_active
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			

END;

