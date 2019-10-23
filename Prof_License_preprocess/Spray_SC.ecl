EXPORT Spray_SC(dataset({string ftype,string fdate})infile) := module

import VersionControl,_Control,lib_thorlib;


	string		pServer			:= _Control.IPAddress.bctlpedata11 ;
	string		pDir(string lictype)		:=  map ( lictype = 'medical'  => '/data/hds_4/prolic/sc/medical/'+infile(ftype = 'medical')[1].fdate ,
	                                             lictype = 'psychology' => '/data/hds_4/prolic/sc/psychology/'+infile(ftype = 'psychology')[1].fdate,
																							 '/data/hds_4/prolic/sc/social_workers/'+infile(ftype = 'social_worker')[1].fdate
																							 );
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile(string pkeyword) := '~thor_data400::in::prolic::sc::'+ pkeyword + '::@version@.csv';
	sfile(string pkeyword) := '~thor_data400::in::prolic::sc::' + pkeyword + '::raw';

	spry_medical_raw:=DATASET([

		 {pServer,pDir('medical'),'rcps*.txt' 			,0 ,lfile('medical::rcps'				),[{sfile('medical::rcps'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'phys*.txt' 			,0 ,lfile('medical::phys'				),[{sfile('medical::phys'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
      {pServer,pDir('medical'),'pas*.txt' 			,0 ,lfile('medical::pas'				),[{sfile('medical::pas'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'opts*.txt' 			,0 ,lfile('medical::opts'				),[{sfile('medical::opts'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'dnt*.txt' 			,0 ,lfile('medical::dnt'				),[{sfile('medical::dnt'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'dhy*.txt' 			,0 ,lfile('medical::dhy'				),[{sfile('medical::dhy'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'pharm*.txt' 			,0 ,lfile('medical::pharm'				),[{sfile('medical::pharm'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'PT*.txt' 			,0 ,lfile('medical::pta'				),[{sfile('medical::pta'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'OT*.txt' 			,0 ,lfile('medical::ota'				),[{sfile('medical::ota'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'ORTHOTEC*.txt' 			,0 ,lfile('medical::orthotec'				),[{sfile('medical::phys'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'DENTEC*.txt' 			,0 ,lfile('medical::dentec'				),[{sfile('medical::dentec'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'ccpt*.txt' 			,0 ,lfile('medical::ccpt'				),[{sfile('medical::ccpt'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'},
     {pServer,pDir('medical'),'drug*.txt' 			,0 ,lfile('medical::drug'				),[{sfile('medical::drug'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'|'}
     

		
		 	], VersionControl.Layout_Sprays.Info);
			
		domedspray :=  VersionControl.fSprayInputFiles(spry_medical_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);	
			
			spry_social_raw:=DATASET([

     	{pServer,pDir('social_worker'),'social_worker*.csv' 			,0 ,lfile('social_worker'				),[{sfile('social_worker'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}

		
		 	], VersionControl.Layout_Sprays.Info);
			
					dosocialspray :=  VersionControl.fSprayInputFiles(spry_social_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);	

   spry_psy_raw:=DATASET([

      {pServer,pDir('psychology'),'psychology*.csv' 			,0 ,lfile('psychology'				),[{sfile('psychology'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}

		
		 	], VersionControl.Layout_Sprays.Info);
			
					dopsyspray :=  VersionControl.fSprayInputFiles(spry_psy_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);	

	
		export dospray :=  map ( count(infile(ftype = 'medical')) = 1 and count(infile) = 1 => domedspray, 
                     count(infile(ftype = 'social_worker')) = 1 and count(infile) = 1 => dosocialspray,
									count(infile(ftype =	'psychology')) = 1 and count(infile) = 1 =>  dopsyspray,
									count(infile(ftype in ['medical','social_worker'])) = 2 and count(infile) = 2 =>  Sequential( domedspray, dosocialspray),
									 count(infile(ftype in ['medical','psychology'])) = 2 and count(infile) = 2 => Sequential(domedspray, dopsyspray),
									 count(infile(ftype in ['psychology','social_worker'])) = 2 and count(infile) = 2 => Sequential(dopsyspray,dosocialspray),
									 Sequential( domedspray, dopsyspray,dosocialspray) ) ;
                                      

	
end;
