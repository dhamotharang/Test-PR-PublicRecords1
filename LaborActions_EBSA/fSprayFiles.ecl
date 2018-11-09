import lib_fileservices,_control,lib_stringlib;

export fSprayFiles(string filedate)	:=	function
		/* 
			Creates an empty superfile; The false optional parameter indicates whether the sub-files 
      must be sequentiallynumbered; The last optional parameter is missing and defaults to false
			indicating that an error is posted if the superfile already exists.
		*/
		CreateSuper								:=	FileServices.CreateSuperFile(Filenames().Input.Sprayed,false);
		/* 
			Checks the existence of the superfile; if the superfile doesn't exist it CreateSuper is called
			(see above).
		*/								
		CreateSuperfileIfNotExist := 	if(NOT FileServices.SuperFileExists(Filenames().Input.Sprayed),CreateSuper); 
		/* 
			The FileServices.RemoteDirectory call returns a list of files as a dataset based upon the 
			machineIP and directory.  In this case the machineIP = serverip and the directory is
			'/hds_180/SIM/LaborActions_EBSA/'+filedate+'/','*.txt'.  

			If no files are returned then FileServices.SprayVariable is called.  The format is as follows:
						FileServices.SprayVariable( sourceIP , sourcepath , [ maxrecordsize ] ,
																			[ srcCSVseparator ] , [ srcCSVterminator ] , [ srcCSVquote ] ,
																			  destinationgroup, destinationlogicalname [,timeout]
																			[,espserverIPport] [,maxConnections]
																			[,allowoverwrite] [,replicate] [, compress ])
						The sourceIP is serverip;
						The sourcepath is '/hds_180/SIM/LaborActions_EBSA/'+filedate+'/'+'*.txt';
						The maxrecordsize is the default value of 4096;
						The srcCSVseparator is ,;
						The srcCSVterminator is the default values of '\\n,\\t,\\n';
						The srcCSVquote is the default value of '\'';
						The destination group is 'thor400_84';
						The destinationlogicalname is cluster+'in::'+ _Dataset().name + '::'+filedate;
						The timeout is -1;
						The espserverIPport is the default value found in the lib_system.ws_fs_server attribute;
						The maxConnections if the default value of 1.
						The replicate is true;
						The compress is true;
		*/

       serverip              := if ( _Control.ThisEnvironment.Name <> 'Prod_Thor',_control.IPAddress.bctlpedata12,_control.IPAddress.bctlpedata11);
			 
			 
		do_spray									:=	if (count(FileServices.RemoteDirectory(serverip,'/data/hds_180/SIM/LaborActions_EBSA/'+filedate+'/','*.txt')(size>0)) >0,
																					FileServices.SprayVariable(	serverip,
																																			'/data/hds_180/SIM/LaborActions_EBSA/'+filedate+'/'+'*.txt',
																																			,',',,,'thor400_36',cluster+'in::'+ _Dataset().name + '::'+filedate,-1,,,true,,true)
																			);
																			
		addSuper									:=	if (count(FileServices.RemoteDirectory(serverip,'/data/hds_180/SIM/LaborActions_EBSA/'+filedate+'/','*.txt')(size>0)) >0,
																					FileServices.AddSuperFile(Filenames().Input.Sprayed, 
																																		cluster+'in::'+ _Dataset().name + '::'+filedate
																																		)
																			);
										 
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Check to see if state sprayed file is already in superfile.
///// If state sprayed file is present remove sprayed file from subsuperfile and respray and add to superfile again. 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		doSeq:= sequential(	CreateSuperfileIfNotExist,
												if (fileservices.findsuperfilesubname(Filenames().Input.Sprayed, cluster+'in::'+ _Dataset().name + '::'+filedate) > 0,
																fileservices.removesuperfile(Filenames().Input.Sprayed, cluster+'in::'+ _Dataset().name + '::'+filedate)
														),
												sequential(	do_spray,
																		addSuper
																	 )
									    );									 
		return doSeq;
end;
