import std, _Control, IDA, wk_ut; 
#WORKUNIT('name', 'IDA PROCESS CONTROLLER');

_process(string prProcess ,boolean pUseProd, boolean pDaily) := Function 

  _pUseProd  :=if(pUseProd,'true','false');   
	_pDaily   :=if(pDaily,'true','false');

	_thor 		:= Case(_Control.ThisEnvironment.ThisDaliIp, 
										STD.System.Util.ResolveHostName(IDA._Constants().dataland_dali)  => IDA._Constants().DATALAND_THOR_GIT,					
										IDA._Constants().PROD_THOR_GIT); 
							
	_esp  		:= Case(_Control.ThisEnvironment.ThisDaliIp, 
										STD.System.Util.ResolveHostName(IDA._Constants().dataland_dali)  => IDA._Constants().DATALAND_ESP,					
										IDA._Constants().PROD_ESP); 
										
  _cluster  := if(pUseProd,'hthor_eclcc', 'hthor_dev_eclcc');

	_createWUID_ECL  := 	
		 '#WORKUNIT(\'protect\',true);\n'
		+'#WORKUNIT(\'name\', IDA._CRON_ECL(\'' + prProcess + '\',' + _pUseProd + ',' + _pDaily + ').SCHEDULER_NAME);\n'
		+'wk_ut.CreateWuid('
		+'IDA._CRON_ECL(\'' + prProcess + '\',' + _pUseProd  + ',' + _pDaily + ').WU,\n'
		+'\''+ trim(_thor,left,right) + '\',\n'
		+'\''+ trim(_esp,left,right)  + '\',\n'
		+')\n'
		+'CRON_WHEN\n' 
		+',FAILURE(FileServices.SendEmail( \n'
		+'IDA.email_notification_lists.BuildFailure\n'
		+',\'*** ALERT **** \' +  IDA._CRON_ECL(\'' + prProcess + '\',' + _pUseProd + ',' + _pDaily + ').WU_VERSION\n'
		+',IDA.email_msg(workunit,'+_pUseProd+').NOC_MSG\n'
		+')\n'
		+');';

	_cronWhen_ECL := Case( prProcess, 
											   'IDA REAPPEND'    =>  ':WHEN(IDA._CRON_ECL(\'' + prProcess + '\',' + _pUseProd + ',' + _pDaily + ').EVENT_NAME)\n' 
											  ,'IDA HEADER FLAG' =>  ':WHEN(IDA._CRON_ECL(\'' + prProcess + '\',' + _pUseProd + ',' + _pDaily + ').EVENT_NAME)\n' 
											  ,'IDA BUILD'       =>  ':WHEN(CRON(\'0  0-23/2 * * *\'))\n'  
											  ,			             ':WHEN(IDA._CRON_ECL(\'' + prProcess + '\',' + _pUseProd + ',' + _pDaily + ').EVENT_NAME)\n'
												);

	schedule_ECL       :=  STD.Str.FindReplace( _createWUID_ECL, 'CRON_WHEN', _cronWhen_ECL); 
	noSchedule_ECL 		 := 'output(\''+ IDA._CRON_ECL(prProcess , pUseProd, pDaily).SCHEDULER_NAME + ' is running already \')'; 
 
	active_wu := IDA.GetActiveWU(IDA._CRON_ECL(prProcess , pUseProd, pDaily).SCHEDULER_NAME);
	
	return wk_ut.CreateWuid (if(active_wu, noSchedule_ECL, schedule_ECL), _cluster, _esp);   

end; 

DatalandProcesses  		:= Sequential(_process('IDA BUILD',false,true)
                                    ,_process('IDA HEADER FLAG',false,false)
                                    ,_process('IDA REAPPEND',false,false)
															    );
															 
ProdProcesses      		:= Sequential(_process('IDA BUILD',true,true)
                                    ,_process('IDA HEADER FLAG',true,false)
                                    ,_process('IDA REAPPEND',true,false)
																	);

Controller        		:= Case(_Control.ThisEnvironment.ThisDaliIp 
																	,STD.System.Util.ResolveHostName(IDA._Constants().dataland_dali)   => DatalandProcesses
																	,STD.System.Util.ResolveHostName(IDA._Constants().prod_thor_dali)  => ProdProcesses
																	,output('Invalid cluster')
																	);
										
Controller;
      																		 