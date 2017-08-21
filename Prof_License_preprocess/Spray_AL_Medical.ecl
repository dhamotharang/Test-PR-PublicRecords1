EXPORT Spray_AL_Medical(string filedate) := module

import VersionControl,_Control;


	string		pServer			:= _Control.IPAddress.bctlpedata11  ;
	string		pDir				:= '/data/hds_4/prolic/al/medical_exam/'+filedate;
	string		pGroupName	:= if ( _Control.ThisEnvironment.Name <> 'Prod_Thor' ,'thor400_dev01','thor400_60');
	boolean    pIsTesting  := false;



	lfile(string pkeyword) := '~thor_data400::in::prolic::al::medical_exam::' + pkeyword + filedate+'.csv';
	sfile(string pkeyword) := '~thor_data400::in::prolic::al::medical_exam::' + pkeyword;

	spry_physician_raw:=DATASET([

		 {pServer,pDir,'physician_assistant.csv' 			,0 ,lfile('phys_assistant'				),[{sfile('phys_assistant'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'physician.csv' 			,0 ,lfile('physicians'				),[{sfile('physicians'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}

		
		 	], VersionControl.Layout_Sprays.Info);
	
		export dospray :=  VersionControl.fSprayInputFiles(spry_physician_raw,pIsTesting := pIsTesting);

	
end;
