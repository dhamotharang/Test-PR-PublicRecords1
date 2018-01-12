EXPORT Spray_MA_Physician (string fdate) := module


import lib_fileservices,_control,lib_thorlib;

	string					CSVSeparator				:=	',';
	string					CSVQuote						:=	'"';
	string					PHYLF				:=	'~thor_data400::in::prolic::ma::physician::raw_'+fdate;
	
	string          sourceLZ              := '/data/hds_4/prolic/ma/physicians_pl/'+fdate+'/';
	string					PHYSF				:=	'~thor_data400::in::prolic::ma::physicians_pl::raw';
	string pServer			:= if ( _Control.ThisEnvironment.Name <> 'Prod_Thor' ,  _Control.IPAddress.bctlpedata12, _Control.IPAddress.bctlpedata11 );
         
	string pGroupName			:= thorlib.group();

	
	
	
	sprayMAFile	:=	if(	EXISTS(FileServices.RemoteDirectory(pServer,sourceLZ,'BORIM_STDREL_NPI.csv')) and FileServices.FindSuperFileSubName(PHYSF,PHYLF) = 0  ,
                       Sequential( 	if (  FileServices.SuperFileExists( PHYSF),FileServices.ClearSuperfile( PHYSF)),

	                              fileservices.sprayvariable(	pServer,
																												sourceLZ + 'BORIM_STDREL_NPI.csv',
																												 ,
																												CSVSeparator,
																												 ,
																												 CSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												pGroupName,
																												PHYLF,
																												,,,true,false,false
																											), 
																	output('No MA PHYSICIAN files recieved or MA PHYSICIAN were already Sprayed'))); 
																	
		addMASuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( PHYSF),FileServices.CreateSuperfile(PHYSF)),
																			 if (  FileServices.SuperFileExists( PHYSF),FileServices.ClearSuperfile( PHYSF)),
																			 FileServices.AddSuperfile( PHYSF,PHYLF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	export dospray	:=	Sequential(sprayMAFile,addMASuper);
	
	end;