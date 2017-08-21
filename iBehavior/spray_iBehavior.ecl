//#workunit('name','Spray iBehavior'); 

import ut
	   ,_control
     ,iBehavior
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   
export spray_iBehavior(string filedate, string batch) := MODULE

shared filepath		  :=	'/data/hds_3/iBehavior/data/' + filedate + '/';	
shared sourceIP		 	:=	_Control.IPAddress.bctlpedata11;
shared maxRecordSize	:=	8192;
shared group_name	:=	'thor400_44';

export destination := '~thor_data400::in::ibehavior::' +filedate+ '::';

shared superfile := '~thor_data400::in::ibehavior_using';

SprayFile(string filename, string newname, integer recsize) := FUNCTION
	RETURN 	FileServices.sprayfixed(sourceIP, 
																		 filepath + filename, 
																		 recsize,
																		 group_name, 
																		 destination + StringLib.StringToLowerCase(newname),
																			,
																				,
																					,
																						TRUE,
																							TRUE,
																								TRUE); 				
END;


//  Spray All Files
export Spray_All :=
	PARALLEL(
  	SprayFile('lexis_nexis_install_data_'+batch+'.dat.OUT.00', '00',1090),
    SprayFile('lexis_nexis_install_data_'+batch+'.dat.OUT.01', '01',1090), 		 
    SprayFile('lexis_nexis_install_data_'+batch+'.dat.OUT.02', '02',1090), 		 
    SprayFile('lexis_nexis_install_data_'+batch+'.dat.OUT.03', '03',1090), 		 
    SprayFile('lexis_nexis_install_data_'+batch+'.dat.OUT.04', '04',1090), 		 
    SprayFile('lexis_nexis_install_data_'+batch+'.dat.OUT.05', '05',1090), 		 
    SprayFile('lexis_nexis_install_data_'+batch+'.dat.OUT.06', '06',1090), 		 
    SprayFile('lexis_nexis_install_data_'+batch+'.dat.OUT.07', '07',1090)
		//SprayFile('lexis_nexis_install_data_'+batch+'.dat.OUT.08', '08',1090)
	);

AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);

END;		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
			
		AddToSuperfile('00'),
		AddToSuperfile('01'),
		AddToSuperfile('02'),
		AddToSuperfile('03'),
		AddToSuperfile('04'),
		AddToSuperfile('05'),
    AddToSuperfile('06'),
    AddToSuperfile('07'),
		//AddToSuperfile('08'),

			
		FileServices.FinishSuperFileTransaction()
	);
  
//  Spray All Files
export iBehavior_SprayFiles := SEQUENTIAL(spray_all
                                          ,super_all);
																		

END;

