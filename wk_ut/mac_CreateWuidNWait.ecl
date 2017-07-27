/*NOT USED AT THIS TIME, look at wk_ut.CreateWuidNWait*/
import tools,ut,_control;
EXPORT mac_CreateWuidNWait(
   ecl
  ,piteration
  ,pversion
  ,pSetResults   = '[]'                                                                                 // output these results after each iteration
  ,pNumTries     = '3'                                                                                  // how many times should it try to resubmit the workunit if it fails(Not implemented yet!!)
  ,pcluster      = wk_ut._Constants.Groupname(,true)
	,pESP					 = wk_ut._Constants.LocalEsp	// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242:8145'
  ,pNotifyEmails = wk_ut._Constants.EmailAddressNotify
  ,pShouldWait   = 'true'
	,pOutputEcl		 = 'false'					                                                                    // Should output the generated ecl as a string(for testing)(true) or actually run the ecl(false)
) := 
functionmacro

  #UNIQUENAME(ECL)
  #UNIQUENAME(CNTR)
  #UNIQUENAME(SUMMLAYOUT)
  #UNIQUENAME(SUMMROW)
  #UNIQUENAME(EXTRAEMAILINFO)

  #SET(ECL  ,'createworkunit1 := tools.mod_Soapcalls.fSubmitNewWorkunit(ecl,pcluster,pcluster,pESP,\'8010\') : independent; // add independent so that they don\'t get reevalulated each time they are accessed')
  #uniquename(workunitevent)

  #APPEND(ECL ,'watchercluster := if(tools._Constants.isDev  ,\'infinband_hthor\',\'hthor\');\n')
  
  #APPEND(ECL ,'createwatcherworkunit1 := tools.mod_Soapcalls.fSubmitNewWorkunit(\'\'wk_ut.mac_Watcher(\\\'\' + createworkunit1 + \'\\\',\\\'' + %'workunitevent'% + '\\\',\\\'' + pNotifyEmails + '\\\',\\\'5\\\');\'\',watchercluster,watchercluster,pESP,\'8010\') : independent; // add independent so that they don\'t get reevalulated each time they are accessed\n')

  wait4it1 := iff(pShouldWait = true ,wait(event(%'workunitevent'%,'*')));
  
  result1 := sequential(
       output(createworkunit1         ,named('Iteration_'   + pversion + '_' + piteration))
      ,output(createwatcherworkunit1  ,named('Watcher_for_' + pversion + '_' + piteration))
      ,output(%'workunitevent'%       ,named('NotifyEvent ' + pversion + '_' + piteration))
      ,wait4it1
      ,output('done waiting at ' + wk_ut.getTimeDate())
  );
  
  getstate1   := wk_ut.get_WUInfo(createworkunit1).State;    
  realstate1  := if(getstate1[1..6] = 'failed' ,'failed' ,getstate1);
  thor_time1  := wk_ut.get_TotalTime(createworkunit1);    
  jobname1    := wk_ut.get_WUInfo(createworkunit1).JobName;   
  
  #SET(CNTR ,1)
  #SET(SUMMLAYOUT ,'{layouts.wks_slim')
  #SET(SUMMROW    ,'{jobname1 ,createworkunit1 ,getstate1 ,piteration ,pversion ,thor_time1,wk_ut.getTimeDate(),createwatcherworkunit1,' + %'workunitevent'%)
  #SET(EXTRAEMAILINFO ,'')

  #LOOP  
    #IF(%CNTR% > count(pSetResults))
      #BREAK
    #END
    #APPEND(SUMMLAYOUT  ,' ,string ' + pSetResults[%CNTR%])
    #APPEND(SUMMROW ,',wk_ut.get_Scalar_Result(' + createworkunit1 + ',\'' + pSetResults[%CNTR%] + '\') ')
    #SET(CNTR ,%CNTR% + 1)
  #END
  #APPEND(SUMMLAYOUT ,'}')
  #APPEND(SUMMROW ,'}')

  
  //name, wuid, iteration#, version, thor time, etc
  dWUDetails1 := dataset([{jobname1 ,createworkunit1 ,getstate1 ,piteration ,pversion ,thor_time1}] ,layouts.wks_slim);
  jobname2 := if(jobname1 != '' ,jobname1 ,createworkunit1);
  sendemail1 := wk_ut.Send_Email(
                             pNotifyEmails
                            ,jobname2 + ' has ' + getstate1 + ' in ' + thor_time1 + ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + wk_ut.getTimeDate()
                            , if(jobname1 != ''
                             ,'Jobname        : ' + jobname1 + '\n','')
                            + 'workunit       : ' + createworkunit1 + '\n' 
                            + 'State          : ' + getstate1 + '\n'
                            + 'Total Thor Time: ' + thor_time1 + '\n'
                            + 'Iteration      : ' + piteration + '\n'
                            + 'Version        : ' + pversion
                          );

  doit :=  sequential(result1,output(dWUDetails1,named('Workunits'),EXTEND),sendemail1,iff(getstate1 in ['failed','aborted'] ,fail('Fail workunit because wuid ' + createworkunit1 + ' has ' + getstate1 + '.')));
//  doit :=  iff(realstate1 = 'completed' ,sequential(output(dWUDetails1,named('Workunits'),EXTEND)/*,sendemail1*/) 
//          ,sequential(output('Attempted 3 times to get this iteration(' + piteration + ') to run, but it failed each time.' ),fail(''))
//            )));
 //         );
  #SET(ECL  ,'return ' + %'ECL'%)

	#if(pOutputEcl = true)
		return %'ECL'%;
	#ELSE
		%ECL%
	#END

endmacro;
