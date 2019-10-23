
EXPORT Spray_OK_Medical(string filedate) := module

import VersionControl,_Control,lib_thorlib;



	string pServer			:=  _Control.IPAddress.bctlpedata11 ;
	string		pDir				:= '/data/hds_4/prolic/ok/medical_perfusionists_podiatric/'+filedate;
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile(string pkeyword) := '~thor_data400::in::prolic::ok::' + pkeyword + '::'+ filedate;
	sfile(string pkeyword) := '~thor_data400::in::prolic::ok::' + pkeyword + '::raw';

	spry_all_raw:=DATASET([

		 {pServer,pDir,'*csv' 			,0 ,lfile('medical'				),[{sfile('medical'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		
		 	], VersionControl.Layout_Sprays.Info);
	
	export dospray :=  VersionControl.fSprayInputFiles(spry_all_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);
	
	end;