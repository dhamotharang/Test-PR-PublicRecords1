import _control;
/**
	spray EASI source files
**/
sourceIP		:=	_Control.IPAddress.edata10;
filepath		:=	'/data_build_5_2/easi/2010/';					 
maxRecordSize	:=	60000;
groupname	:=	IF(_Control.ThisEnvironment.name='Dataland', 'thor20_241_10', 'thor400_84');

destination := Easi2010.cluster + 'in::easi::' + Easi2010.version + '::';
//espserverIPport	:= IF(_Control.ThisEnvironment.name='Dataland', 'http://dataland_esp:8010/FileSpray',
//													'http://prod_esp:8010/FileSpray');
espserverIPport	:= 'http://' +_Control.ThisEnvironment.ESP_IPAddress + ':8010/FileSpray';

superbase := Easi2010.cluster + 'in::easi::';
filebase :=  Easi2010.cluster + 'in::easi::' + Easi2010.version + '::';
	
CreateSuperFiles := SEQUENTIAL(
	IF(NOT FileServices.SuperFileExists(superbase + 'current_census'),
		FileServices.CreateSuperFile(superbase + 'current_census')),
	IF(NOT FileServices.SuperFileExists(superbase + 'current_yr'),
		FileServices.CreateSuperFile(superbase + 'current_yr')),
	IF(NOT FileServices.SuperFileExists(superbase + 'five_yr_projection'),
		FileServices.CreateSuperFile(superbase + 'five_yr_projection')),
	IF(NOT FileServices.SuperFileExists(superbase + 'naics'),
		FileServices.CreateSuperFile(superbase + 'naics'))

);

ClearSuperFiles := SEQUENTIAL(
	FileServices.StartSuperFileTransaction( ),
	FileServices.ClearSuperFile(superbase + 'current_census'),
	FileServices.ClearSuperFile(superbase + 'current_yr'),
	FileServices.ClearSuperFile(superbase + 'five_yr_projection'),
	FileServices.ClearSuperFile(superbase + 'naics'),
	FileServices.FinishSuperFileTransaction( )
);

AddToSuperFiles := SEQUENTIAL(
	FileServices.StartSuperFileTransaction( ),
	FileServices.AddSuperFile(superbase + 'current_census',
		filebase + 'current_census'),
	FileServices.AddSuperFile(superbase + 'current_yr',
		filebase + 'current_yr'),
	FileServices.AddSuperFile(superbase + 'five_yr_projection',
		filebase + 'five_yr_projection'),
	FileServices.AddSuperFile(superbase + 'naics',
		filebase + 'naics'),
	FileServices.FinishSuperFileTransaction( )
);
			
SprayFile(string inFile, string outFile) := FUNCTION
	RETURN 	FileServices.SprayVariable(sourceIP, 
				filepath + inFile, maxRecordSize, ',','\n', '"',
				 groupname, destination + outFile,
				 -1,espserverIPport,-1,true,false,true); 				
END;

SEQUENTIAL(
	CreateSuperFiles,
	ClearSuperFiles,
	PARALLEL(
		SprayFile('EASI_DEMS_10.csv', 'current_census'), 
		SprayFile('EASI_DEMS_11.csv', 'current_yr'),
		SprayFile('EASI_DEMS_16.csv', 'five_yr_projection'),
		SprayFile('EASI_NAICS_11.csv', 'naics')
	),
	AddToSuperFiles,
	OUTPUT('EASI Vendor Files Sprayed')
);