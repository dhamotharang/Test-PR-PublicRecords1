EXPORT Spray_NJ_All_Available(string filedate) := module

import VersionControl,_Control;


	string pServer			:=  _Control.IPAddress.bctlpedata11 ;
	string		pDir				:= '/data/hds_4/prolic/nj/all_available/'+filedate;
	string		pGroupName	:= if ( _Control.ThisEnvironment.Name <> 'Prod_Thor' ,'thor400_dev01','thor400_60');
	boolean    pIsTesting  := false;



	lfile(string pkeyword) := '~thor_data400::in::prolic::nj::' + pkeyword + '.@version@.csv';
	sfile(string pkeyword) := '~thor_data400::in::prolic::nj::' + pkeyword + '::raw';

	spry_all_raw:=DATASET([

		 {pServer,pDir,'*.txt' 			,0 ,lfile('all_available'				),[{sfile('all_available'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		
		 	], VersionControl.Layout_Sprays.Info);
	
	export dospray :=  VersionControl.fSprayInputFiles(spry_all_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);
	
	end;