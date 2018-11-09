EXPORT Spray_TX (dataset({string ftype,string fdate})infile) := module

import VersionControl,_Control,lib_thorlib;


	string		pServer			:=  _Control.IPAddress.bctlpedata11 ;
	string		pDir(string lictype)		:=  map ( lictype = 'nurses'  => '/data/hds_4/prolic/tx/nurses/'+infile(ftype = 'nurses')[1].fdate,
	                                                                      '/data/hds_4/prolic/tx/medical_pl/'+infile(ftype = 'medical')[1].fdate
																						);
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile_nurse(string pkeyword) := '~thor_data400::in::prolic::tx::nurse::' + pkeyword + '.@version@.csv';
	sfile_nurse(string pkeyword) := '~thor_data400::in::prolic::tx::nurse::' + pkeyword + '::raw';
	
	lfile_med(string pkeyword) := '~thor_data400::in::prolic::tx::medical::' + pkeyword + '.@version@.csv';
	sfile_med(string pkeyword) := '~thor_data400::in::prolic::tx::medical::' + pkeyword + '::raw';
	
	
	

	spry_nurse_raw:=DATASET([

		 {pServer,pDir('nurses'),'RN-All.txt' 			,0 ,lfile_nurse('rn'				),[{sfile_nurse('rn'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir('nurses'),'APRN-All.txt' 			,0 ,lfile_nurse('aprn'				),[{sfile_nurse('aprn'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir('nurses'),'LVN-All.txt' 			,0 ,lfile_nurse('lvn'				),[{sfile_nurse('lvn'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}

    
		
		 	], VersionControl.Layout_Sprays.Info);
			
			
					donursespray :=  VersionControl.fSprayInputFiles(spry_nurse_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);	
					
					
					spry_medical_raw:=DATASET([

		
    	{pServer,pDir('medical'),'*PHYALLD.TXT' 			,0 ,lfile_med('phy'				),[{sfile_med('phy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir('medical'),'*PAACTD.TXT' 			,0 ,lfile_med('pas'				),[{sfile_med('pas'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir('medical'),'*ACACTD.TXT' 			,0 ,lfile_med('acpt'				),[{sfile_med('acpt'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}

		
		 	], VersionControl.Layout_Sprays.Info);

						domedspray :=  VersionControl.fSprayInputFiles(spry_medical_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);	

export dospray :=  map ( count(infile(ftype = 'medical')) = 1 and count(infile) = 1 => domedspray, 
                     count(infile(ftype = 'nurses')) = 1 and count(infile) = 1 => donursespray,
									count(infile(ftype in ['medical','nurses'])) = 2 and count(infile) = 2 =>  Sequential( domedspray, donursespray)
									);
									
	end;