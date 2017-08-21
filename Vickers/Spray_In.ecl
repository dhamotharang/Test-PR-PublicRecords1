EXPORT Spray_In(string filedate) := module

import lib_fileservices,_control;

	string					CSVSeparator				:=	'|';
	string					CSVQuote						:=	'"';
	string					InsiderFilingLF				:=	'~thor_data400::in::vickers::'+filedate+'::insider_filing_raw';
	string					InsiderFilerLF				:=	'~thor_data400::in::vickers::'+filedate+'::insider_filer_raw';
	string					InsiderSecurityLF			:=	'~thor_data400::in::vickers::'+filedate+'::insider_security_raw';
	string          sourceLZ              := '/data/prod_data_build_10/production_data/business_headers/vickers/in/';
	string					InsiderFilingSF				:=	'~thor_data400::in::vickers::insider_filing_raw';
	string					InsiderFilerSF				:=	'~thor_data400::in::vickers::insider_filer_raw';
	string					InsiderSecuritySF			:=	'~thor_data400::in::vickers::insider_security_raw';          
	
	// Spray Insider Filing
	
	
	
	sprayInsiderFilingFile	:=	if(	EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,sourceLZ,'InsiderSeisintFiling6yrRpt.txt*')) ,

	                              fileservices.sprayvariable(	_control.IPAddress.bctlpedata11,
																												sourceLZ + 'InsiderSeisintFiling6yrRpt.txt*',
																												 ,
																												CSVSeparator,
																												 ,
																												CSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												'thor400_44',
																												InsiderFilingLF,
																												,,,true,false,false
																											), 
																	output('No Insider Filing files recieved or Insider Filing Files were already Sprayed')); 
																	
		addIFilingSuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( InsiderFilingSF),FileServices.CreateSuperfile(InsiderFilingSF)),
																			 if (  FileServices.SuperFileExists( InsiderFilingSF),FileServices.ClearSuperfile( InsiderFilingSF)),
																			 FileServices.AddSuperfile( InsiderFilingSF,InsiderFilingLF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	sprayIFilingFile	:=	Sequential(sprayInsiderFilingFile,addIFilingSuper);
	
	// Spray Insider Filer 
	sprayInsiderFilerFile	:=	if(	EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,sourceLZ,'InsiderSeisintFiler6yrRpt*')) ,

	                              fileservices.sprayvariable(	_control.IPAddress.bctlpedata11,
																												sourceLZ + 'InsiderSeisintFiler6yrRpt.txt*',
																												 ,
																												CSVSeparator,
																												 ,
																												CSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												'thor400_44',
																												InsiderFilerLF,
																												,,,true,false,false
																											), 
																	output('No Insider Filer files recieved or Insider Filer Files were already Sprayed')); 
																	
		addIFilerSuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( InsiderFilerSF),FileServices.CreateSuperfile(InsiderFilerSF)),
																			 if (  FileServices.SuperFileExists( InsiderFilerSF),FileServices.ClearSuperfile( InsiderFilerSF)),
																			 FileServices.AddSuperfile( InsiderFilerSF,InsiderFilerLF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	sprayIFilerFile	:=	Sequential(sprayInsiderFilerFile,addIFilerSuper);
	
// Spray Insider Security	
	sprayInsiderSecFile	:=	if(	EXISTS(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,sourceLZ,'InsiderSeisintSecurity6yrRpt*')) ,

	                              fileservices.sprayvariable(	_control.IPAddress.bctlpedata11,
																												sourceLZ + 'InsiderSeisintSecurity6yrRpt.txt*',
																												 ,
																												CSVSeparator,
																												 ,
																												CSVQuote,
																										//		_control.TargetGroup.Thor400_20,
																												'thor400_44',
																												InsiderSecurityLF,
																												,,,true,false,false
																											), 
																	output('No Insider Security files recieved or Insider Security Files were already Sprayed')); 
																	
		addISecSuper   := Sequential (  FileServices.StartSuperFileTransaction( ),
		                                   if ( NOT FileServices.SuperFileExists( InsiderSecuritySF),FileServices.CreateSuperfile(InsiderSecuritySF)),
																			 if (  FileServices.SuperFileExists( InsiderSecuritySF),FileServices.ClearSuperfile( InsiderSecuritySF)),
																			 FileServices.AddSuperfile( InsiderSecuritySF,InsiderSecurityLF),
																			 FileServices.FinishSuperFileTransaction( )
																		);
																			 
																											
	
	sprayISecFile	:=	Sequential(sprayInsiderSecFile,addISecSuper);
	
	
	export raw := Sequential( sprayIFilingFile, sprayIFilerFile,sprayISecFile);
	
	end;
	