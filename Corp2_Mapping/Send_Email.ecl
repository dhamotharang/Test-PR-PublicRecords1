import _control, corp2;

export Send_Email(
	 string		pState
	,string		pVersion
	,boolean  pMainHasRejRecs						= false
	,boolean  pARHasRejRecs							= false
	,boolean  pEventHasRejRecs					= false
	,boolean  pStockHasRejRecs					= false
	,integer 	pMainRejRecCnt						= 0
	,integer 	pARRejRecCnt							= 0
	,integer 	pEventRejRecCnt						= 0
	,integer 	pStockRejRecCnt						= 0
	,integer 	pMainTotRecCnt						= 0
	,integer 	pARTotRecCnt							= 0
	,integer 	pEventTotRecCnt						= 0
	,integer 	pStockTotRecCnt						= 0
	,string   pInvalidValue							= ''
	,string   pValidValues							= ''
	,string   pRunType									= ''
	,boolean  pMainOrbitSubmitFailed		= false
	,boolean  pAROrbitSubmitFailed			= false
	,boolean  pEventOrbitSubmitFailed		= false
	,boolean  pStockOrbitSubmitFailed		= false
	,string		pEmailAddress			=  corp2.Email_Notification_Lists.spray + ';' + _control.MyInfo.emailaddressnotify
) :=
module

	shared lRejectTemplate		 		 := Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+pVersion+'::rejected::';
	shared linTemplate		 		 		 := Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'	+pVersion+'::';

	export MappingSuccess			 		 := fileservices.sendemail(
																		corp2.Email_Notification_Lists.BuildSuccess,
																		'CORP2_MAPPING.'+ pState+' '+if(pRunType<>'',pRunType+' ','')+pVersion+' RAN SUCCESSFUL with NO REJECTED RECORDS on '+ _Control.ThisEnvironment.Name+'.',													
																		'Please see workunit #'+workunit+'.  '+'The data WAS ADDED to the spray superfile.'+'\n'+'\n'+
																		if (pMainTotRecCnt 	 <> 0	,linTemplate + 'main_'	+pState+'     The record count is: '+pMainTotRecCnt		+'\n'+'\n','') + 
																		if (pARTotRecCnt 		 <> 0	,linTemplate + 'ar_'		+pState+'     The record count is: '+pARTotRecCnt			+'\n'+'\n','') + 
																		if (pEventTotRecCnt <> 0	,linTemplate + 'event_'+pState+'     The record count is: '+pEventTotRecCnt	+'\n'+'\n','') + 
																		if (pStockTotRecCnt  <> 0	,linTemplate + 'stock_'	+pState+'     The record count is: '+pStockTotRecCnt	+'\n'+'\n','')
																		);
																
	export MappingFailed			 		 := fileservices.sendemail(
																		corp2.Email_Notification_Lists.BuildFailure,
																		'CORP2_MAPPING.'+ pState+' '+if(pRunType<>'',pRunType+' ','')+pVersion+' FAILED on '+ _Control.ThisEnvironment.Name+'-THRESHOLD EXCEEDED.',													
																		'Please see workunit #'+workunit+'.  '+'The data was NOT ADDED to the spray superfile.'+'\n'+'\n'+										
																		'Please review the data for version '+ pVersion + '.'
																		);
																		
	export InvalidFileDateParm 		 := fileservices.sendemail(
																		corp2.Email_Notification_Lists.BuildFailure,
																		'CORP2_MAPPING.'+ pState+' '+if(pRunType<>'',pRunType+' ','')+pVersion+' NO DATA PROCESSED on '+ _Control.ThisEnvironment.Name+'-INVALID FILEDATE PASSED.',													
																		'Please see workunit #'+workunit+'.  '+'An invalid filedate was passed to CORP2_MAPPING.'+pState+'. The date passed was '+pVersion+'.'
																		);
																		
	export InvalidFileRunType 		 := fileservices.sendemail(
																		corp2.Email_Notification_Lists.BuildFailure,
																		'CORP2_MAPPING.'+ pState+' '+if(pRunType<>'',pRunType+' ','')+pVersion+' NO DATA PROCESSED on '+ _Control.ThisEnvironment.Name+'-INVALID RUNTYPE PASSED.',													
																		'Please see workunit #'+workunit+'.  '+'An invalid runtype was passed to CORP2_MAPPING ' + pState+'.  The invalid runtype passed was '+pInvalidValue+'.'+'\n'+'\n'+
																		'The valid runtype values are '+pValidValues+'.'
																		);

	export RecordsRejected		 		 := fileservices.sendemail(
																		corp2.Email_Notification_Lists.BuildFailure,
																		'CORP2_MAPPING.'+ pState+' '+if(pRunType<>'',pRunType+' ','')+pVersion+' Has REJECTED RECORDS on '+ _Control.ThisEnvironment.Name+'.',													
																		'Please see workunit #'+workunit+'.  '+'\n'+'\n'+
																		'Please review the following files that contains rejected records:'+'\n'+'\n'+
																		if (pMainHasRejRecs		,lRejectTemplate + 'main_'	+pState+'.     The number of records rejected: '+pMainRejRecCnt		+'.\n'+'\n','') + 
																		if (pARHasRejRecs			,lRejectTemplate + 'ar_'		+pState+'.     The number of records rejected: '+pARRejRecCnt			+'.\n'+'\n','') + 
																		if (pEventHasRejRecs	,lRejectTemplate + 'event_'+pState+'.     The number of records rejected: '+pEventRejRecCnt	+'.\n'+'\n','') + 
																		if (pStockHasRejRecs	,lRejectTemplate + 'stock_'	+pState+'.     The number of records rejected: '+pStockRejRecCnt	+'.\n'+'\n','') + 
																		'\n'+'\n'+
																		'The following files were added to the sprayed superfiles:'+'\n'+'\n'+
																		if (pMainTotRecCnt 	 <> 0	,linTemplate + 'main_'	+pState+'.     The number of records added to superfile: '+pMainTotRecCnt		+'.\n'+'\n','') + 
																		if (pARTotRecCnt 	 	 <> 0	,linTemplate + 'ar_'		+pState+'.     The number of records added to superfile: '+pARTotRecCnt			+'.\n'+'\n','') + 
																		if (pEventTotRecCnt <> 0	,linTemplate + 'event_'+pState+'.     The number of records added to superfile: '+pEventTotRecCnt	+'.\n'+'\n','') + 
																		if (pStockTotRecCnt  <> 0	,linTemplate + 'stock_'	+pState+'.     The number of records added to superfile: '+pStockTotRecCnt	+'.\n'+'\n','')
																		);

	export FieldsInvalidPerScrubs  := fileservices.sendemail(
																		corp2.Email_Notification_Lists.BuildFailure,
																		'CORP2_MAPPING.'+ pState+' '+if(pRunType<>'',pRunType+' ','')+pVersion+' Has FIELDS THAT ARE INVALID BASED UPON SCRUB RULES on '+ _Control.ThisEnvironment.Name+'.',													
																		if (pMainHasRejRecs		,'Please review "Main_ScrubErrorReport" results in workunit #: '+workunit + '.' + '\n'+'\n','') + 
																		if (pARHasRejRecs			,'Please review "AR_ScrubErrorReport" results in workunit #: '+workunit + '.' + '\n'+'\n','') + 
																		if (pEventHasRejRecs	,'Please review "Event_ScrubErrorReport" results in workunit #: '+workunit + '.' + '\n'+'\n','') + 
																		if (pStockHasRejRecs	,'Please review "Stock_ScrubErrorReport" results in workunit #: '+workunit + '.' + '\n'+'\n','')
																		);

	export SubmitStatsFailed		  := fileservices.sendemail(
																		corp2.Email_Notification_Lists.BuildFailure,
																		'CORP2_MAPPING.'+ pState+' '+pVersion+' FAILED TO SEND STATS TO ORBIT on '+ _Control.ThisEnvironment.Name+' FOR THE FOLLOWING FILES:',													
																		if (pMainOrbitSubmitFailed	,'Please review "SubmitStatErrorCorp_'+pState+'_Main'+pVersion+'" results in workunit #: '+workunit + ' for faultcode and description.' + '\n'+'\n','') + 
																		if (pAROrbitSubmitFailed		,'Please review "SubmitStatErrorCorp_'+pState+'_AR'+pVersion+'" results in workunit #: '+workunit + ' for faultcode and description.' + '\n'+'\n','') + 
																		if (pEventOrbitSubmitFailed	,'Please review "SubmitStatErrorCorp_'+pState+'_Event'+pVersion+'" results in workunit #: '+workunit + ' for faultcode and description' + '\n'+'\n','') + 
																		if (pStockOrbitSubmitFailed	,'Please review "SubmitStatErrorCorp_'+pState+'_Stock'+pVersion+'" results in workunit #: '+workunit + ' for faultcode and description.' + '\n'+'\n','')
																		);
																		
end;