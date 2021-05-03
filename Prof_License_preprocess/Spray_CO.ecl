EXPORT Spray_CO(dataset({string ftype,string fdate})infile) := module


import VersionControl,_Control,lib_thorlib;


	string		pServer			:= _Control.IPAddress.bctlpedata11  ;
	string		pDir(string ftype)		:=  map ( ftype = 'medical'  => '/data/hds_4/prolic/co/medical/'+infile(ftype = 'medical')[1].fdate,
	                                                                      '/data/hds_4/prolic/co/all_available/'+infile(ftype = 'available')[1].fdate
																						);
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile_med(string pkeyword) := '~thor_data400::in::prolic::co::medical::' + pkeyword +  '.@version@.csv' ;
	sfile_med(string pkeyword) := '~thor_data400::in::prolic::co::medical::' + pkeyword ;

	spry_physician_raw:=DATASET([

		 {pServer,pDir('medical'),'*.csv' 			,0 ,lfile_med('all'				),[{sfile_med('raw'			)}],pGroupName,'','[0-9]{12}','VARIABLE'} ], VersionControl.Layout_Sprays.Info);
	
		 dospraymedical :=  VersionControl.fSprayInputFiles(spry_physician_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= false,pShouldSprayMultipleFilesAs1 := true);
		 
		 lfile_all(string pkeyword) := '~thor_data400::in::prolic::co::'+pkeyword +'::' + '.@version@.csv' ;
	sfile_all(string pkeyword) := '~thor_data400::in::prolic::co::'+pkeyword+'::raw' ;
		 
		 spry_available_raw := DATASET([

		 {pServer,pDir('available'),'*csv' 			,0 ,lfile_all('all_available'				),[{sfile_all('all_available'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}

		
		 	], VersionControl.Layout_Sprays.Info);
			
		 dosprayavailable :=  VersionControl.fSprayInputFiles(spry_available_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= false);
		 
		 export dospray	:=	map ( count(infile(ftype = 'medical')) = 1 and  count(infile) = 1 => Sequential( FileServices.ClearSuperfile( '~thor_data400::in::prolic::co::medical::raw1') , FileServices.ClearSuperfile( '~thor_data400::in::prolic::co::medical::raw2') ,dospraymedical) ,
		                       count(infile(ftype = 'available')) = 1 and  count(infile) = 1 => Sequential( FileServices.ClearSuperfile( '~thor_data400::in::prolic::co::all_available::raw'),dosprayavailable),
													 Sequential(dospraymedical,dosprayavailable)
													 );

	
end;
