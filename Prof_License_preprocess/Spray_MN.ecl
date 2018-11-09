EXPORT Spray_MN(dataset({string ftype,string fdate})infile) := module

import VersionControl,_Control,lib_thorlib;


	string pServer			:=  _Control.IPAddress.bctlpedata11 ;
	string		pDir(string lictype)		:=  map ( lictype = 'available'  => '/data/hds_4/prolic/mn/all/'+infile(ftype = 'available')[1].fdate,
	                                                                      '/data/hds_4/prolic/mn/physicians/'+infile(ftype = 'physician')[1].fdate
																						);
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile(string pkeyword) := '~thor_data400::in::prolic::mn::' + pkeyword + '.@version@.csv';
	sfile(string pkeyword) := '~thor_data400::in::prolic::mn::' + pkeyword;

	spry_all_raw:=DATASET([

		 {pServer,pDir('available'),'DENTIST.TXT' 			,0 ,lfile('dentist'				),[{sfile('dentist'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		,{pServer,pDir('available'),'ENGINEER.TXT' 		,0 ,lfile('engineer'			),[{sfile('engineer'	  )}],pGroupName,'','[0-9]{12}','VARIABLE'}
		//,{pServer,pDir('available'),'CPA.TXT' 			,0 ,lfile('cpa'				),[{sfile('cpa'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		,{pServer,pDir('available'),'ARCHITEC.TXT' 			  ,0 ,lfile('architect'					),[{sfile('architect'				)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		,{pServer,pDir('available'),'VETS.TXT' 			  ,0 ,lfile('vets'				  ),[{sfile('vets'			  )}],pGroupName,'','[0-9]{12}','VARIABLE'}
		,{pServer,pDir('available'),'BLDGCONT.TXT' 			  ,0 ,lfile('bldgcont'				  ),[{sfile('bldgcont'			  )}],pGroupName,'','[0-9]{8}','VARIABLE'}

		 	], VersionControl.Layout_Sprays.Info);
	
	 dosprayall :=  VersionControl.fSprayInputFiles(spry_all_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);
	
	

	spry_physician_raw:=DATASET([

		 {pServer,pDir('physician'),'*.txt' 			,0 ,lfile('physician'				),[{sfile('physician'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}

		
		 	], VersionControl.Layout_Sprays.Info);
	
		 dosprayphy :=  VersionControl.fSprayInputFiles(spry_physician_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= false);
		 
		 export out :=  map ( count(infile(ftype = 'available')) = 1 and  count(infile) = 1 => dosprayall,
		                       count(infile(ftype = 'physician')) = 1 and  count(infile) = 1 => dosprayphy,
													 Sequential(dosprayall,dosprayphy)
													 );

	
end;
