import std, _Control, Inql_FFD, wk_ut; 
#WORKUNIT('name', 'HIST INQL PROCESS CONTROLLER');

_process(string prProcess ,boolean prFCRA, boolean prDaily) := Function 
     
	_prFCRA   :=if(prFCRA,'true','false');
	_prDaily  :=if(prDaily,'true','false');

	_thor := 'thor400_44_eclcc'; 
							
	_esp  := INQL_FFD._Constants.FCRA_ESP;

	_createWUID_ECL  := 	
		 '#WORKUNIT(\'protect\',true);\n'
		+'#WORKUNIT(\'name\', INQL_FFD._CRON_ECL(\'' + prProcess + '\',' + _prFCRA + ',' + _prDaily + ').SCHEDULER_NAME);\n'
		+'wk_ut.CreateWuid('
		+'Inql_FFD._CRON_ECL(\'' + prProcess + '\',' + _prFCRA + ',' + _prDaily + ').WU,\n'
		+'\''+ trim(_thor,left,right) + '\',\n'
		+'\''+ trim(_esp,left,right)  + '\',\n'
		+')\n'
		+'CRON_WHEN\n' 
		+',FAILURE(FileServices.SendEmail( \n'
		+'INQL_FFD.email_notification_lists.BuildFailure\n'
		+',\'*** ALERT **** \' +  Inql_FFD._CRON_ECL(\'' + prProcess + '\',' + _prFCRA + ',' + _prDaily + ').WU_VERSION\n'
		+',INQL_FFD.email_msg(workunit).NOC_MSG\n'
		+')\n'
		+');';

	_cronWhen_ECL := ':WHEN(Inql_FFD._CRON_ECL(\'' + prProcess + '\',' + _prFCRA + ',' + _prDaily + ').EVENT_NAME)\n';

	schedule_ECL       :=  STD.Str.FindReplace( _createWUID_ECL, 'CRON_WHEN', _cronWhen_ECL); 
	noSchedule_ECL 		 := 'output(\''+ Inql_FFD._CRON_ECL(prProcess ,prFCRA, prDaily).SCHEDULER_NAME + ' is running already \')'; 
 
	active_wu := INQL_FFD._Functions.Get_Active_WU(Inql_FFD._CRON_ECL(prProcess ,prFCRA, prDaily).SCHEDULER_NAME);
	
	return wk_ut.CreateWuid (if(active_wu, noSchedule_ECL, schedule_ECL), 'hthor', _esp);   

end; 
      																		 
ProdProcesses         := Sequential(_process('FILES SCRUB', true,true)
																	 ,_process('BASE BUILD', true,true)
															 );
															 
NonFCRAProcesses      := output('There is no process in this cluster');	

FCRAProcesses      		:= output('There is no process in this cluster');											

Controller        		:= Case(_Control.ThisEnvironment.ThisDaliIp 
																	,_Control.IPAddress.NewLogTHOR_dali  																=> NonFCRAProcesses
																	,_Control.IPAddress.FCRALogTHOR_dali 																=> FCRAProcesses
																	,STD.System.Util.ResolveHostName(_Control.IPAddress.prod_thor_dali) => ProdProcesses
																	,output('Invalid cluster')
																	);
										
Controller;