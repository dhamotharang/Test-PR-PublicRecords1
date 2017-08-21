import _control;

sourceIP		:=	_Control.IPAddress.edata10;
filepath		:=	'/data_build_5_2/easi/';					 
maxRecordSize	:=	60000;
group_name	:=	IF(_Control.ThisEnvironment.name='Dataland', 'thor_data50', 'thor400_84');
destination := EASI.Files09.cluster + 'in::easi::';
espserverIPport	:= IF(_Control.ThisEnvironment.name='Dataland', 'http://dataland_esp:8010/FileSpray',
													'http://prod_esp:8010/FileSpray');
			
SprayFile(string inFile, string outFile) := FUNCTION
	RETURN 	FileServices.SprayVariable(sourceIP, 
				filepath + inFile, maxRecordSize, ',','\n', '"',
				 group_name, destination + outFile,
				 -1,espserverIPport,-1,true,true,true); 				
END;

	PARALLEL(
		SprayFile('EASI_DEMS_00.csv', 'dems00'), 
		SprayFile('EASI_DEMS_09.csv', 'dems09'), 
		SprayFile('EASI_DEMS_10.csv', 'dems10'), 
		SprayFile('EASI_DEMS_15.csv', 'dems15'),
		SprayFile('EASI_XTRA_00.csv', 'xtra00'), 
		SprayFile('EASI_XTRA_10.csv', 'xtra10'), 
		SprayFile('EASI_XTRA_15.csv', 'xtra15'),
		SprayFile('EASI_NAICS_10.csv', 'naics10')
	);