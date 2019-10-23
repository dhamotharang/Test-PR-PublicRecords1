EXPORT Spray_HI_All_Available(string fdate) := module

//Spray Medical

import lib_fileservices,_control,lib_thorlib;

	string					CSVSeparator				:=	',';
	string					CSVQuote						:=	'"';
	string					AALF				:=	'~thor_data400::in::prolic::hi::all_available::raw_'+fdate;
	
	string          sourceLZ              := '/data/hds_4/prolic/hi/all_available/'+fdate+'/';
	string					AASF				:=	'~thor_data400::in::prolic::hi::all_available::raw';
	         
		string pServer			:= if ( _Control.ThisEnvironment.Name <> 'Prod_Thor' ,  _Control.IPAddress.bctlpedata12, _Control.IPAddress.bctlpedata11 );
	string pGroupName			:= thorlib.group();

	
	
	
	sprayhiFile	:=	if(	EXISTS(FileServices.RemoteDirectory(pServer,sourceLZ,'LICENSE_DATA.CSV')) and FileServices.FindSuperFileSubName(AASF,AALF) = 0  ,
                       Sequential( 	if (  FileServices.SuperFileExists( AASF),FileServices.ClearSuperfile( AASF)),

	                              fileservices.sprayvariable(	pServer,
																												sourceLZ + 'LICENSE_DATA.CSV',
																												 ,
																												CSVSeparator,
																												 ,
																												 CSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												pGroupName,
																												AALF,
																												,,,true,false,false
																											), 
																	output('No HI ALL AVAILABLE files recieved or HI ALL AVAILABLE were already Sprayed'))); 
																	
		addhiSuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( AASF),FileServices.CreateSuperfile(AASF)),
																			 if (  FileServices.SuperFileExists( AASF),FileServices.ClearSuperfile( AASF)),
																			 FileServices.AddSuperfile( AASF,AALF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	export dospray	:=	Sequential(sprayhiFile,addhiSuper);
	
	end;