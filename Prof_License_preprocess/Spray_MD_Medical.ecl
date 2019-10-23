EXPORT Spray_MD_Medical(string fdate) := module

import lib_fileservices,_control,lib_thorlib;

	string					CSVSeparator				:=	',';
	string					CSVQuote						:=	'"';
	string					MEDLF				:=	'~thor_data400::in::prolic::md::medical::raw_'+fdate;
	
	string          sourceLZ              := '/data/hds_4/prolic/md/medical/'+fdate+'/';
	string					MEDSF				:=	'~thor_data400::in::prolic::md::medical::raw';
	         
	string pServer			:= if ( _Control.ThisEnvironment.Name <> 'Prod_Thor' ,  _Control.IPAddress.bctlpedata12, _Control.IPAddress.bctlpedata11 );

		string pGroupName			:= thorlib.group();
	
	
	sprayMDFile	:=	if(	EXISTS(FileServices.RemoteDirectory(pServer,sourceLZ,'*.csv')) and FileServices.FindSuperFileSubName(MEDSF,MEDLF) = 0  ,
                       Sequential( 	if (  FileServices.SuperFileExists( MEDSF),FileServices.ClearSuperfile( MEDSF)),

	                              fileservices.sprayvariable(	pServer,
																												sourceLZ + '*.csv',
																												 ,
																												CSVSeparator,
																												 ,
																												 CSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												pGroupName,
																												MEDLF,
																												,,,true,false,false
																											), 
																	output('No MD medical files recieved or MA MEDSICIAN were already Sprayed'))); 
																	
		addMDSuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( MEDSF),FileServices.CreateSuperfile(MEDSF)),
																			 if (  FileServices.SuperFileExists( MEDSF),FileServices.ClearSuperfile( MEDSF)),
																			 FileServices.AddSuperfile( MEDSF,MEDLF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	export dospray	:=	Sequential(sprayMDFile,addMDSuper);
	
	end;