EXPORT Spray_IL_All_Available(string filedate) := module

import VersionControl,_Control,lib_thorlib;


		string pServer			:=  _Control.IPAddress.bctlpedata11 ;
	string		pDir				:= '/data/hds_4/prolic/il/all_available/'+filedate;
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile(string pkeyword) := '~thor_data400::in::prolic::IL::' + pkeyword + '.@version@.csv';
	sfile(string pkeyword) := '~thor_data400::in::prolic::IL::' + pkeyword + '::raw';

	spry_all_raw:=DATASET([

		 {pServer,pDir,'*.csv' 			,0 ,lfile('all_available'				),[{sfile('all_available'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		
		 	], VersionControl.Layout_Sprays.Info);
	
	export dospray :=  VersionControl.fSprayInputFiles(spry_all_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);
	
	end;