import lib_fileservices,_control,lib_stringlib;

export fSpray(string filedate)	:=	function
	CreateCertSuper :=	FileServices.CreateSuperFile('~thor_data400::in::insurance_certification::sprayed::certification',false);
	CreatePoliSuper	:=	FileServices.CreateSuperFile('~thor_data400::in::insurance_certification::sprayed::policy',false);
			
	CreateCertSuperfileIfNotExist := if(NOT FileServices.SuperFileExists('~thor_data400::in::insurance_certification::sprayed::certification'),CreateCertSuper); 
	CreatePoliSuperfileIfNotExist	:= if(NOT FileServices.SuperFileExists('~thor_data400::in::insurance_certification::sprayed::policy'),CreatePoliSuper);
	
	doCert	:=	if(COUNT(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,
												'/data/hds_180/SIM/Insurance_Certification/'+filedate+'/','*Certification.txt')(size>0)) >0,
							  		sequential( 
										FileServices.SprayVariable(_control.IPAddress.bctlpedata11,
												'/data/hds_180/SIM/Insurance_Certification/'+filedate+'/'+'*Certification.txt',
												,'|',,'\"','thor400_44','~thor_data400::'+'in::'+ 'insurance_certification' + '::'+filedate+ '::certification',-1,,,true,false),
										FileServices.ClearSuperfile('~thor_data400::in::insurance_certification::sprayed::certification'),
										FileServices.AddSuperFile(	'~thor_data400::in::insurance_certification::sprayed::certification', 
																								'~thor_data400::'+'in::'+ 'insurance_certification' + '::'+filedate+ '::certification')));
																
	doPoli	:=	if(COUNT(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,
												'/data/hds_180/SIM/Insurance_Certification/'+filedate+'/','*Policy.txt')(size>0)) >0,
							  		sequential( 
										FileServices.SprayVariable(_control.IPAddress.bctlpedata11,
												'/data/hds_180/SIM/Insurance_Certification/'+filedate+'/'+'*Policy.txt',
												,'|',,'\"','thor400_44','~thor_data400::'+'in::'+ 'insurance_certification' + '::'+filedate+ '::policy',-1,,,true,false),
										FileServices.ClearSuperfile('~thor_data400::in::insurance_certification::sprayed::policy'),
										FileServices.AddSuperFile(	'~thor_data400::in::insurance_certification::sprayed::policy', 
																								'~thor_data400::'+'in::'+ 'insurance_certification' + '::'+filedate+ '::policy')));
	
	doParallel := parallel(doCert, doPoli);
																													 
	return doParallel;
end;
