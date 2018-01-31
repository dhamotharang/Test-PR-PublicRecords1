
EXPORT Spray_VA(dataset({string ftype,string fdate})infile) := module

import VersionControl,_Control,lib_thorlib;


	string		pServer			                 :=    _Control.IPAddress.bctlpedata11 ;
	string		pDir(string lictype)				:=  map ( lictype = 'health'  => '/data/hds_4/prolic/va/health/'+infile(ftype = 'health')[1].fdate,
	                                                                      '/data/hds_4/prolic/va/all/'+infile(ftype = 'available')[1].fdate
																								);
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile(string pkeyword) := '~thor_data400::in::prolic::va::' + pkeyword + infile(ftype = pkeyword)[1].fdate;
	sfile(string pkeyword) := '~thor_data400::in::prolic::va::' + pkeyword + '::raw';

	spry_med_raw:=DATASET([

		 {pServer,pDir('health'),'*txt' 			,0 ,lfile('health'				),[{sfile('health'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'}
		
		 	], VersionControl.Layout_Sprays.Info);
	
	 dospraymed :=  VersionControl.fSprayInputFiles(spry_med_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);
	

spry_all_raw	:=	if(	EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,pDir('available'),'*txt' )) and FileServices.FindSuperFileSubName(sfile('all_available'			),lfile('available'				)) = 0  ,
                       Sequential( 	if (  FileServices.SuperFileExists( sfile('all_available'			)),FileServices.ClearSuperfile( sfile('all_available'			))),
														
	                              fileservices.sprayvariable(	_control.IPAddress.bctlpedata11,
																												pDir('available') + '/' + '*.txt',
																												 ,
																												'\t',
																												 ,
																												 '',
																										//		_control.TargetGroup.Thor400_20,
																												'thor400_44',
																												lfile('available'				),
																												,,,true,false,false
																											)), 
																	output('No VA ALL AVAILABLE files recieved or VA ALL AVAILABLE were already Sprayed')); 
																	
		addVASuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( sfile('all_available'			)),FileServices.CreateSuperfile(sfile('all_available'			))),
																			 if (  FileServices.SuperFileExists( sfile('all_available'			)),FileServices.ClearSuperfile( sfile('all_available'			))),
																			 FileServices.AddSuperfile( sfile('all_available'			),lfile('available'				)),
																			 FileServices.FinishSuperFileTransaction( )
																		);
	dosprayall := Sequential( spry_all_raw,addVASuper);

	
	  
		 export out :=  map ( count(infile(ftype = 'available')) = 1 and  count(infile) = 1 => dosprayall,
		                       count(infile(ftype = 'health')) = 1 and  count(infile) = 1 => dospraymed,
													 Sequential(dosprayall,dospraymed)
													 );
	
	end;