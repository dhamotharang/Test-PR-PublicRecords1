EXPORT Spray_WI_All_Available(string fdate) := module

import lib_fileservices,_control,lib_thorlib;

	string					CSVSeparator				:=	',';
	string					CSVQuote						:=	'"';
	string					AALF				:=	'~thor_data400::in::prolic::wi::all_available::raw_'+fdate;
	
	string          sourceLZ              := '/data/hds_4/prolic/wi/all_available/'+fdate+'/';
	string					AASF				:=	'~thor_data400::in::prolic::wi::all_available::raw';
		string		pGroupName	:= thorlib.group();
         
	
	
	
	
	sprayWIFile	:=	if(	EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,sourceLZ,'*.csv')) and FileServices.FindSuperFileSubName(AASF,AALF) = 0  ,
                       Sequential( 	if (  FileServices.SuperFileExists( AASF),FileServices.ClearSuperfile( AASF)),
														
	                              fileservices.sprayvariable(	_control.IPAddress.bctlpedata11,
																												sourceLZ + '*.csv',
																												 ,
																												CSVSeparator,
																												 ,
																												 CSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												pGroupName,
																												AALF,
																												,,,true,false,false
																											), 
																	output('No WI ALL AVAILABLE files recieved or WI ALL AVAILABLE were already Sprayed'))); 
																	
		addWISuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( AASF),FileServices.CreateSuperfile(AASF)),
																			 if (  FileServices.SuperFileExists( AASF),FileServices.ClearSuperfile( AASF)),
																			 FileServices.AddSuperfile( AASF,AALF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	export dospray	:=	Sequential(sprayWIFile,addWISuper);
	
	end;