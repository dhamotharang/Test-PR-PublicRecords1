EXPORT Spray_MI(dataset({string ftype,string fdate})infile) := module

import VersionControl,_control,lib_thorlib;

	string pServer			:=  _Control.IPAddress.bctlpedata11 ;
	string		pDir(string lictype)		:=  map ( lictype = 'TradeLic'  => '/data/hds_4/prolic/mi/trade/'+infile(ftype = 'Tradelic')[1].fdate,
	                                                                      '/data/hds_4/prolic/mi/all_available/'+infile(ftype = 'Health')[1].fdate
																						);
	string		pGroupName	:= thorlib.group();
	boolean    pIsTesting  := false;
		         
	
	lfile(string pkeyword) := '~thor_data400::in::prolic::mi::' + pkeyword + '.@version@.csv';
	sfile(string pkeyword) := '~thor_data400::in::prolic::mi::' + pkeyword+ '::raw';

	spry_trade_raw:=DATASET([

		 {pServer,pDir('TradeLic'),'*.csv' 			,0 ,lfile('trade_license'				),[{sfile('trade_license'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'\t','\\n,\\r\\n','"'}
		
		 	], VersionControl.Layout_Sprays.Info);
	
	 dospraytl :=  VersionControl.fSprayInputFiles(spry_trade_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);
	 
	 
	 spry_health_raw:=DATASET([

		 {pServer,pDir('Health'),'*act.txt' 			,0 ,lfile('health'				),[{sfile('health'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'\t','\\n,\\r\\n','"'}

		
		 	], VersionControl.Layout_Sprays.Info);
	
		 dosprayhlt :=  VersionControl.fSprayInputFiles(spry_health_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true);
	
	
	
								
																											
	
export out :=  map ( count(infile(ftype = 'TradeLic')) = 1 and  count(infile) = 1 => dospraytl,
		                       count(infile(ftype = 'Health')) = 1 and  count(infile) = 1 => dosprayhlt,
													 Sequential(dospraytl,dosprayhlt)
													 );	
	end;