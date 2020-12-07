import std, _Control, Inql_V2, wk_ut; 
#WORKUNIT('name', 'INQL PROCESS CONTROLLER');

_process(string prProcess ,boolean prFCRA, boolean prDaily) := Function 
     
	_prFCRA   :=if(prFCRA,'true','false');
	_prDaily  :=if(prDaily,'true','false');

	_thor 		:= Case(_Control.ThisEnvironment.ThisDaliIp, 
										_Control.IPAddress.NewLogTHOR_dali => INQL_v2._Constants.NONFCRA_THOR_GIT,
										_Control.IPAddress.FCRALogTHOR_dali => INQL_v2._Constants.FCRA_THOR_GIT,							
										INQL_v2._Constants.PROD_THOR_GIT); 
							
	_esp  		:= Case(_Control.ThisEnvironment.ThisDaliIp, 
										_Control.IPAddress.NewLogTHOR_dali => INQL_v2._Constants.NON_FCRA_ESP,
										_Control.IPAddress.FCRALogTHOR_dali => INQL_v2._Constants.FCRA_ESP,							
										INQL_v2._Constants.PROD_ESP); 

	_createWUID_ECL  := 	
		 '#WORKUNIT(\'protect\',true);\n'
		+'#WORKUNIT(\'name\', INQL_v2._CRON_ECL(\'' + prProcess + '\',' + _prFCRA + ',' + _prDaily + ').SCHEDULER_NAME);\n'
		+'wk_ut.CreateWuid('
		+'Inql_V2._CRON_ECL(\'' + prProcess + '\',' + _prFCRA + ',' + _prDaily + ').WU,\n'
		+'\''+ trim(_thor,left,right) + '\',\n'
		+'\''+ trim(_esp,left,right)  + '\',\n'
		+')\n'
		+'CRON_WHEN\n' 
		+',FAILURE(FileServices.SendEmail( \n'
		+'INQL_v2.email_notification_lists.BuildFailure\n'
		+',\'*** ALERT **** \' +  Inql_V2._CRON_ECL(\'' + prProcess + '\',' + _prFCRA + ',' + _prDaily + ').WU_VERSION\n'
		+',INQL_v2.email_msg(workunit).NOC_MSG\n'
		+')\n'
		+');';

	_cronWhen_ECL := Case( prProcess, 
												'PRODR3 EXTRACT'    => 	':WHEN(CRON(\'55 12 * * *\'))\n',
												'FILES CONSOLIDATE' => 	':WHEN(CRON(\'00 06 * * 1\'))\n' 
												,			                 	':WHEN(Inql_V2._CRON_ECL(\'' + prProcess + '\',' + _prFCRA + ',' + _prDaily + ').EVENT_NAME)\n'
												);

	schedule_ECL       :=  STD.Str.FindReplace( _createWUID_ECL, 'CRON_WHEN', _cronWhen_ECL); 
	noSchedule_ECL 		 := 'output(\''+ Inql_V2._CRON_ECL(prProcess ,prFCRA, prDaily).SCHEDULER_NAME + ' is running already \')'; 
 
	active_wu := INQL_v2.GetActiveWU(Inql_V2._CRON_ECL(prProcess ,prFCRA, prDaily).SCHEDULER_NAME);
	
	return wk_ut.CreateWuid (if(active_wu, noSchedule_ECL, schedule_ECL), 'hthor_eclcc', _esp);   

end; 
      																		 
NonFCRAProcesses      := Sequential(_process('FILES SPRAY', false,true) 
																	 ,_process('FILES SCRUB', false,true)
																	 ,_process('BASE PREP', false,true)   // Daily Base Pre-process
																	 ,_process('BASE POST', false,true)   // Daily Base post-process
																	 ,_process('BASE BUILD', false,false) // Weekly Base
																	 ,_process('BATCHR3 BUILD', false,true)				
																	 ,_process('FILES CONSOLIDATE', false,true)	
															 );

FCRAProcesses      		:= Sequential(_process('FILES SPRAY', true,true)
																	 ,_process('FILES SCRUB', true,true)
																	 ,_process('BASE PREP', true,true)   // Daily Base pre-process
																	 ,_process('BASE POST', true,true)   // Daily Base post-process																	 
																	 ,_process('BATCHR3 BUILD', true,true)		
 																	 ,_process('FILES CONSOLIDATE', true,true)	

															 );
															 
ProdProcesses      		:= Sequential(
                                    _process('PRODR3 EXTRACT', false,true)
																	 ,_process('BASE BUILD', false,true)	// NFCRA Daily Base														 
																	 ,_process('BASE BUILD', true,true)   // FCRA Daily Base
																	 ,_process('BASE BUILD', true,false)	// FCRA Weekly Base												 
																	 ,_process('KEYS BUILD', true,false)  // FCRA Weekly Keys
																	 ,_process('KEYS BUILD', false,true)  // NFCRA Daily Keys 
																	 ,_process('KEYS BUILD', false,false) // NFCRA Weekly Keys 
																	 ,_process('STATS REPORTS', false,false) // NFCRA Weekly Stats 																	 
																	 ,_process('STATS REPORTS', true,false)  // FCRA Weekly Stats		
																	 ,_process('FIDO CHANGE REPORT', false,true) // FIDO Change Daily Report
																	 );

Controller        		:= Case(_Control.ThisEnvironment.ThisDaliIp 
																	,_Control.IPAddress.NewLogTHOR_dali  																=> NonFCRAProcesses
																	,_Control.IPAddress.FCRALogTHOR_dali 																=> FCRAProcesses
																	,STD.System.Util.ResolveHostName(_Control.IPAddress.prod_thor_dali) => ProdProcesses
																	,output('Invalid cluster')
																	);
										
Controller;