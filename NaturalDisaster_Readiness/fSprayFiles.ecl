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
			machineIP and directory.  

			If no files are returned then FileServices.SprayVariable is called.  The format is as follows:
						FileServices.SprayVariable( sourceIP , sourcepath , [ maxrecordsize ] ,
																			[ srcCSVseparator ] , [ srcCSVterminator ] , [ srcCSVquote ] ,
																			  destinationgroup, destinationlogicalname [,timeout]
																			[,espserverIPport] [,maxConnections]
																			[,allowoverwrite] [,replicate] [, compress ])
						The sourceIP is _control.IPAddress.edata12;
						The sourcepath is '/hds_180/SIM/NaturalDisaster_Readiness/'+filedate+'/'+'*.txt';
						The maxrecordsize is the default value of 4096;
						The srcCSVseparator is ,;
						The srcCSVterminator is the default values of '\\n,\\t,\\n';
						The srcCSVquote is the default value of '\'';
						The destination group is 'thor400_30';
						The destinationlogicalname is cluster+'in::'+ _Dataset().name + '::'+filedate;
						The timeout is -1;
						The espserverIPport is the default value found in the lib_system.ws_fs_server attribute;
						The maxConnections if the default value of 1.
						The replicate is false;
						The compress is true;
		*/
		do_spray									:=	if (count(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,'/data/hds_180/SIM/NaturalDisaster_Readiness/data/'+filedate+'/','*.txt')(size>0)) >0,
																						FileServices.SprayVariable(_control.IPAddress.bctlpedata11
																						,'/data/hds_180/SIM/NaturalDisaster_Readiness/data/'+filedate+'/'+'*.txt'
																						,_Dataset().max_record_size
																						,'|'
																						,'\\n,\\r\\n'
																						,
																						,'thor400_44'
																						,cluster+'in::'+ _Dataset().name + '::'+filedate
																						,-1
																						,
																						,
																						,true
																						,
																						,true
																						)
																			);																						
	
		addSuper									:=	if (count(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,'/data/hds_180/SIM/NaturalDisaster_Readiness/data/'+filedate+'/','*.txt')(size>0)) >0,
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
