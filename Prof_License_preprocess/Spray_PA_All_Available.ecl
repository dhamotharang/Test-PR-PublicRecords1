EXPORT Spray_PA_All_Available (string filedate) := module

import VersionControl,_Control,lib_thorlib;


	string pServer			:=  _Control.IPAddress.bctlpedata11 ;
	string		pDir				:= '/data/hds_4/prolic/pa/all/'+filedate;
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile_A(string pkeyword) := '~thor_data400::in::prolic::pa::'+ pkeyword + '::id_active_A::'+filedate;
	sfile_A(string pkeyword) := '~thor_data400::in::prolic::pa::'+ pkeyword + '::id_active_A::raw';
	
	lfile_inactive_A(string pkeyword) := '~thor_data400::in::prolic::pa::'+ pkeyword + '::id_inactive_A::' +filedate;
	sfile_inactive_A(string pkeyword) := '~thor_data400::in::prolic::pa::'+ pkeyword + '::id_inactive_A::raw';
	
	lfile_B(string pkeyword) := '~thor_data400::in::prolic::pa::'+ pkeyword + '::id_active_B::' +filedate;
	sfile_B(string pkeyword) := '~thor_data400::in::prolic::pa::'+ pkeyword + '::id_active_B::raw';
	
	lfile_inactive_B(string pkeyword) := '~thor_data400::in::prolic::pa::'+ pkeyword + '::id_inactive_B::' +filedate;
	sfile_inactive_B(string pkeyword) := '~thor_data400::in::prolic::pa::'+ pkeyword + '::id_inactive_B::raw';


	spry_all_raw:=DATASET([

		 {pServer,pDir,'id_*_active_format_A.txt' 			,0 ,lfile_A('all_available'				),[{sfile_A('all_available'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'id_*_active_format_B.txt' 			,0 ,lfile_B('all_available'				),[{sfile_B('all_available'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		  {pServer,pDir,'id_*_inactive_format_A.txt' 			,0 ,lfile_inactive_A('all_available'				),[{sfile_inactive_A('all_available'			)}],pGroupName,'','[0-9]{12}','VARIABLE'},
		 {pServer,pDir,'id_*_inactive_format_B.txt' 			,0 ,lfile_inactive_B('all_available'				),[{sfile_inactive_B('all_available'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		
		 	], VersionControl.Layout_Sprays.Info);
	
	export dospray :=  VersionControl.fSprayInputFiles(spry_all_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);
	
	end;