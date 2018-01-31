
EXPORT Spray_AR(dataset({string ftype,string fdate})infile) := module

import VersionControl,_Control,lib_thorlib;
//spray dentists

	string		pServer			              :=  _Control.IPAddress.bctlpedata11  ;
	 
																 
	string		pDir(string ltype)				:= map ( ltype = 'dentists'  => '/data/hds_4/prolic/ar/dental/'+infile(ftype = 'dentists')[1].fdate,
	                                             ltype = 'optometry' => '/data/hds_4/prolic/ar/optimetrists_pl/'+infile(ftype = 'optometry')[1].fdate,
																                                      '/data/hds_4/prolic/ar/pharmacists/'+infile(ftype = 'pharmacy')[1].fdate
																             );
	                               
	string		pGroupName	             := thorlib.group();
	boolean    pIsTesting              := false;



	lfile(string pkeyword,string lictype) := '~thor_data400::in::prolic::ar::' + pkeyword + '::' + infile(ftype = lictype)[1].fdate ;
	sfile(string pkeyword) := '~thor_data400::in::prolic::ar::' + pkeyword + '::raw';

	spry_dentists_raw:=DATASET([

		 {pServer,pDir('dentists'),'AssistantList*.csv' 			,0 ,lfile('rda'	,	'dentists'		),[{sfile('rda'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir('dentists'),'HygenistsList*.csv' 			,0 ,lfile('rdh'	,	'dentists'			),[{sfile('rdh'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir('dentists'),'DentistList*.csv' 			,0 ,lfile('dds'		,	'dentists'		),[{sfile('dds'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}

		 	], VersionControl.Layout_Sprays.Info);
			
			
	spry_optometry_raw:=DATASET([

		 {pServer,pDir('optometry'),'Optometry*.csv' 			,0 ,lfile('optometrist'	,'optometry'			),[{sfile('optometrists'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		  	], VersionControl.Layout_Sprays.Info);
				
	spry_pharmacy_raw:=DATASET([

		 {pServer,pDir('pharmacy'),'All_Pharmacists*.csv' 			,0 ,lfile('pharmacist'	,	'pharmacy'		),[{sfile('pharmacist'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		  	], VersionControl.Layout_Sprays.Info);

	
	
	
	export dospray :=  Sequential( if ( count(infile(ftype = 'dentists')) = 1  , VersionControl.fSprayInputFiles(spry_dentists_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true)),
	                         if ( count(infile(ftype = 'optometry')) = 1  , VersionControl.fSprayInputFiles(spry_optometry_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true)),
	                         if ( count(infile(ftype = 'pharmacy')) = 1  , VersionControl.fSprayInputFiles(spry_pharmacy_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true)),
                          Output('All_AR_Files_Sprayed')
																			
													);																																														
																																																											
																																																		
	end;