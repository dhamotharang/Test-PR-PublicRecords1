import lib_fileservices,_control,VersionControl,lib_thorlib;

EXPORT Spray_IA(dataset({string ftype,string fdate})infile) := module

//Spray Medical


		string pServer			:=  _Control.IPAddress.bctlpedata11 ;
	string		pDir(string lictype)		:=  map ( lictype = 'medical'  => '/data/hds_4/prolic/ia/medical/'+infile(ftype = 'medical')[1].fdate,
	                                                                      '/data/hds_4/prolic/ia/dental_pl/'+infile(ftype = 'dentist')[1].fdate
																						);
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;



	lfile(string pkeyword) := '~thor_data400::in::prolic::ia::' + pkeyword + '.@version@.csv';
	sfile(string pkeyword) := '~thor_data400::in::prolic::ia::' + pkeyword + '::raw';
	
	spry_medical_raw:=DATASET([

		 {pServer,pDir('medical'),'PHYDATA.csv' 			,0 ,lfile('medical'				),[{sfile('medical'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		

		 	], VersionControl.Layout_Sprays.Info);
	
	 dospraymedical :=  VersionControl.fSprayInputFiles(spry_medical_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);
	
	

	spry_dentists_raw:=DATASET([

		 {pServer,pDir('dentist'),'dentist*.csv' 			,0 ,lfile('dentist'				),[{sfile('dentist'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}

		
		 	], VersionControl.Layout_Sprays.Info);
			
	 	 dospraydental :=  VersionControl.fSprayInputFiles(spry_dentists_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);

																											
	
	export dospray	:=	map ( count(infile(ftype = 'medical')) = 1 and  count(infile) = 1 => dospraymedical,
		                       count(infile(ftype = 'dentist')) = 1 and  count(infile) = 1 => dospraydental,
													 Sequential(dospraymedical,dospraydental)
													 );
	end;