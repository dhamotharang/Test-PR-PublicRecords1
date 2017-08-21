import lib_WorkunitServices,_control,ut;

export Workunit_utils :=
module

	export setWorkunitStates 		:= ['blocked','completed','failed','running','wait','aborted','compiling','compiled','submitted',''/*blank is unknown*/];
	export setNegativeStates		:= ['failed','aborted',''];
	export setPositiveStates		:= ['blocked','completed','running','wait','compiling','compiled','submitted'];
	export setFinishedStates		:= ['completed'];
	export setNotFinishedStates	:= ['blocked','running','compiling','compiled','submitted'];
	export setFailedStates			:= ['failed','aborted'];
	
	export setSeverity				:= [0/*info*/,1/*warnings*/,2/*errors*/];
	//severity has to be a 2 already(lib_WorkunitServices.WsMessage)
	export setResubmittable_error_codes := [-4,-3,0,4,5,7,16,22,24,30,32,113,1000,3000,9000,10056];

	export IsWorkunitResbmittable(unsigned4 pseverity, unsigned4 pcode) := pseverity = 2 and pcode in setResubmittable_error_codes;
	
	export GetWUState(string pWorkunit)	:= 
	function
  
		dWorkunits				 :=	lib_WorkunitServices.WorkunitServices.WorkUnitList(pWorkunit)(wuid = pWorkunit)[1];
		dWorkunitsFinished :=	dWorkunits.state in setFinishedStates;
		dWorkunitsFailed	 :=	dWorkunits.state in setNegativeStates;
    
		dfailedWUmsg			 := rollup(project(lib_WorkunitServices.WorkunitServices.WorkunitMessages(trim(dWorkunits.wuid))(severity = 2),{string message}),true,transform({string message},self.message := trim(left.message,left,right) + '\n' + trim(right.message,left,right)))[1].message;
    
//    return dWorkunits;
  
		return	map(	dWorkunitsFinished = true 	=> (string)dWorkunits.state	
								,	dWorkunitsFailed	 = true   => 'failed: ' + (string)dfailedWUmsg
								,		                             (string)dWorkunits.state
            );  
	end;

	export GetJobName(string pWorkunit)	:= lib_WorkunitServices.WorkunitServices.WorkUnitList(pWorkunit)(wuid = pWorkunit)[1].job;

  export mac_NotifyMe(
  
     pWorkunit
    ,pNotifyEmails     = '_control.MyInfo.EmailAddressNotify'
    ,pPollingFrequency = '\'5\''                              //in minutes.  So 5 means poll every 5 minutes.
  
  ) :=
  macro
  
    cronFreq        := CRON('0-59/' + pPollingFrequency + ' * * * *');
    emails          := pNotifyEmails;
    watchworkunit   := pWorkunit;

    getstate    := trim(tools.Workunit_utils.GetWUState(watchworkunit),left,right);
    realstate   := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
    realjobname := trim(tools.Workunit_utils.GetJobName(watchworkunit));
    jobname     := if(realjobname = ''  ,watchworkunit  ,realjobname + ' (' + watchworkunit + ')');
    
    sendemail := tools.fun_SendEmail(
                               emails
                              ,jobname + ' has ' + realstate + ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + ut.GetTimeDate()
                              ,watchworkunit + ' ' + if(realjobname != '',realjobname,'') + '\n' + getstate
                            );
    dothis := sequential(
       output(pWorkunit + if(realstate = 'running' ,' is ',' has ') + getstate + ' on ' + ut.GetTimeDate())
      ,iff((realstate = 'completed' or realstate = 'failed' or realstate = 'aborted') and realstate != 'running'  ,sequential(sendemail,FAIL('Watcher stopped, email has been sent because wuid ' + pWorkunit + ' has ' + realstate + ' on ' + ut.GetTimeDate() + ' with this error: ' + getstate)))
    ) : failure(tools.fun_SendEmail(emails,'Watcher ' + workunit + ' has failed','For this reason: \n' + failmessage));
    
    dothis : WHEN(cronFreq);

  endmacro;

	
	export AreMyFilesBeingUsed(string pFileExpression) :=
	function

		dRunningWorkunits				:=	lib_WorkunitServices.WorkunitServices.WorkUnitList('','','','','','running','',pFileExpression);
			
		return dRunningWorkunits;
		
	end;
	
end;