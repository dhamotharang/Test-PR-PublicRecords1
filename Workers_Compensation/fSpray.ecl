import lib_fileservices,_control,lib_stringlib;

export fSpray(string filedate)	:=	function
	CreateSuper		:=	FileServices.CreateSuperFile(Filenames().Input.Sprayed,false);
								
	CreateSuperfileIfNotExist := 	if(NOT FileServices.SuperFileExists(Filenames().Input.Sprayed),CreateSuper); 

	do_spray :=	if(COUNT(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,
								'/data/hds_180/SIM/Workers_Compensation/'+filedate+'/','*.csv')(size>0)) >0,
								FileServices.SprayVariable(_control.IPAddress.bctlpedata11,
								'/data/hds_180/SIM/Workers_Compensation/'+filedate+'/'+'*.csv',
								,'\t',,,'thor400_66',cluster+'in::'+ _Dataset().name + '::'+filedate,-1,,,true,true));
																			
	addSuper :=	if (COUNT(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,
								'/data/hds_180/SIM/Workers_Compensation/'+filedate+'/','*.csv')(size>0)) >0,
								FileServices.AddSuperFile(Filenames().Input.Sprayed, 
								cluster+'in::'+ _Dataset().name + '::'+filedate));
										 	
/* Check to see if sprayed file is already in superfile.  If sprayed file is present,
   remove sprayed file from subsuperfile and respray and add to superfile again. */

	doSeq:= sequential(	CreateSuperfileIfNotExist,
											if (fileservices.findsuperfilesubname(Filenames().Input.Sprayed, cluster+'in::'+ _Dataset().name + '::'+filedate) > 0,
													fileservices.removesuperfile(Filenames().Input.Sprayed, cluster+'in::'+ _Dataset().name + '::'+filedate))
											   ,do_spray
											   ,addSuper);									 
		return doSeq;
end;
