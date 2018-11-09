EXPORT Spray_CA_All_Available(string filedate) := module

import VersionControl,_Control,lib_thorlib;


	string		pServer			:= _Control.IPAddress.bctlpedata11  ;
	string		pDir				:= '/data/hds_4/prolic/ca/all_available/'+filedate;
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile(string pkeyword) := '~thor_data400::in::prolic::CA::all_available::' + pkeyword + '.@version@.csv';
	sfile(string pkeyword) := '~thor_data400::in::prolic::CA::all_available::' + pkeyword ;

	spry_all_raw:=DATASET([

		 {pServer,pDir,'Breeze*Data*.csv' 			,0 ,lfile('breeze'				),[{sfile('breeze'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		
		 {pServer,pDir,'Legacy*Data*.csv' 			,0 ,lfile('legacy'				),[{sfile('legacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}

		
		 	], VersionControl.Layout_Sprays.Info);
	
	export dospray :=  Sequential( FileServices.ClearSuperfile('~thor_data400::in::prolic::CA::all_available::breeze'),
	                         FileServices.ClearSuperfile('~thor_data400::in::prolic::CA::all_available::legacy'),
													 VersionControl.fSprayInputFiles(spry_all_raw,pIsTesting := pIsTesting)
													 );
	
	end;