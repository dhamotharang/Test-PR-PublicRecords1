/*
output(wk_ut_dev.get_Attribute_Text('wk_ut_dev.test_att')); // run this first to get the ecl with the backslashed quotes
then, put it in ecltext attribute so it is a constant, and then kick this off below.
ecltext := 'iteration := \'@iteration@\';pversion  := \'@version@\';#workunit(\'name\',\'wk_ut_dev.test_att \' + pversion + \' \' + iteration);output(iteration ,named(\'iteration\'));output(pversion  ,named(\'pversion\'));';
wk_ut_dev.mac_ChainWuids(ecltext,1,2,'20130316',['iteration','pversion'],pOutputEcl := false);
*/
/*
  check the status of each iteration that finishes.  if it fails, should fail this workunit.
  should put fail message in the summarreport, and also in the email
  could put files used in a child dataset?
  put time it finished in dataset, maybe process time too?
also, in the email it would be nice for it to report the results set that you pass in(like matches performed).

*/
import tools,wk_ut_dev,_control,ut;
EXPORT mac_ChainWuids(

	 pECL
	,pIterationStartValue                                         // will replace any @iteration@ in the pECL with this value
	,pNumIterations                                               // all subsequent iterations will increment the above this many times
	,pversion           	= ''	                                  // will replace any @version@ in the pECL with this value. 
  ,pSetResults          = '[]'                                  // output these results after each iteration.  These are named results from the workunit kicked off.
  ,pcluster             = wk_ut_dev._Constants.Groupname(,true)            // Thor cluster on which to run the iterations.
  ,pNotifyEmails        = '_control.MyInfo.EmailAddressNotify'  // Email Addresses to send reports to.
	,pESP							    = 'wk_ut_dev._Constants.LocalEsp'	      // ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242:8145'
	,pOutputEcl					  = 'false'					                      // Should output the generated ecl as a string(for testing) or actually run the ecl
  ,pUniqueOutput        = '\'\''                                // Unique String to Identify these iterations from others in the same workunit.
  ,pOutputFilename      = '\'\''                                // filename template to output the workunits dataset to. Use @version@ and @iteration@ tokens within it to allow the name to be unique per iteration. 
  ,pOutputSuperfile     = '\'\''                                // superfile to add the above file to. 
	,pForceRun					  = 'false'					                      // Should force running of all the iterations.  Don't skip if they've already been run. only for when using the pOutputFilename.
  ,pPollingFrequency    = '\'5\''                               // in minutes.  So 5 means poll every 5 minutes.
  ,pSetStopCondition    = '[]'                                  // if condition is true, don't kick off next iteration.  In effect, making pNumIterations a max # of iterations instead of total iterations
                                                                // example: ['MatchesPerformed','< 1000000'].  This will pull the MatchesPerformed value from the finished iteration, and if it is less than 1 million
                                                                // it will not kick off the next iteration, it will stop there.  THIS HAS BEEN IMPLEMENTED, BUT 
                                                                // IS BLOCKED BY JIRA ISSUE 11172.
) :=
functionmacro
	
  import tools,wk_ut_dev,_control,ut,std;
  
  #UNIQUENAME(PREECL          )
  #UNIQUENAME(ECL             )
  #UNIQUENAME(ECLTEMP         )
  #UNIQUENAME(ECLTEXT         )
  #UNIQUENAME(LOOPTEXT        )
  #UNIQUENAME(PREVCNTR        )
  #UNIQUENAME(CNTR            )
  #UNIQUENAME(RESULTCNTR      )
  #UNIQUENAME(EXTRAEMAIL      )
  #UNIQUENAME(SUMMARYREPORT   )
  #UNIQUENAME(SUMMARYSET      )
  #UNIQUENAME(STRINGFILLER    )
  #UNIQUENAME(FILLER          )
  #UNIQUENAME(LEN             )
  #UNIQUENAME(SCALARFIELD     )
  #UNIQUENAME(SCALARRESULT    )
  #UNIQUENAME(SCALARINDEXFIELD)
  #UNIQUENAME(SCALARFIELDS    )
  #UNIQUENAME(SCALARSETFIELDS )
  #UNIQUENAME(SCALARTEMP      )
  #UNIQUENAME(RESULTSTEMP     )
  #UNIQUENAME(EXTRAPARENS     )
  #UNIQUENAME(SETWUIDS        )

  #UNIQUENAME(STOPCNTR        )
  #UNIQUENAME(STOPCONDITION   )
  #UNIQUENAME(STOPOPERATOR    )
  #UNIQUENAME(STOPVALUE       )
  #UNIQUENAME(STOPTEMP        )
  #UNIQUENAME(STOPVALUETYPE   )
  #UNIQUENAME(NOTIFYMASTEREVENT   )
  #UNIQUENAME(WAIT4MASTEREVENT   )
  #UNIQUENAME(GETWUIDSECL   )
  #UNIQUENAME(LOCALESP   )
  #UNIQUENAME(OUTPUTFILENAME   )
  #UNIQUENAME(LOOPFILENAME   )
  #UNIQUENAME(REJECTCOND   )
  #UNIQUENAME(REJECTCONDS   )
  #UNIQUENAME(MASTERCASE   )
  #UNIQUENAME(MASTERSEQUENTIAL   )

  #UNIQUENAME(WATCHERCLUSTER   )
  #SET(WATCHERCLUSTER,wk_ut_dev._Constants.Esp2Hthor(pESP))
  
  #SET(LOCALESP,wk_ut_dev._constants.LocalEsp)

  #SET(RESULTCNTR ,1)
  #SET(SUMMARYSET ,#TEXT(pSetResults))
  #SET(CNTR ,(UNSIGNED)pIterationStartValue)
  #SET(ECL,'')
  // #SET(ECL,'SEQUENTIAL(\n')
  #SET(PREECL,'')
  #SET(ECLTEMP,'')
  #SET(GETWUIDSECL,'')
  //need three slashes for quotes, \\\'.  have 7 now which uses 29 slashes here .  4 slashes = 1, + 1. So three slashes would be 13.  4*3 + 1
  //need two slashes for line feed, \\n.. have 4 now.  uses 13 slashes here, so 3 slashes = 1 + 1 extra.  so for 2 resultant slashes we need 2*3 + 1 = 7.
  #SET(ECLTEXT  ,regexreplace('\r',regexreplace('\n',regexreplace('\'',pECL,'\\\\\\\\\\\\\''),'\\\\\\\n',nocase),''))
  // #SET(ECLTEXT  ,regexreplace('\r',regexreplace('\n',regexreplace('\'',pECL,'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\''),'\\\\\\\\\\\\\n',nocase),''))
  #IF(regexfind('@version@'  ,%'ECLTEXT'% ,nocase))
    #SET(ECLTEXT  ,regexreplace('@version@'   ,%'ECLTEXT'% ,pversion               ,nocase))
  #END
  
  #IF(regexfind('@version@'  ,pOutputFilename ,nocase))
    #SET(OUTPUTFILENAME  ,regexreplace('@version@'  , pOutputFilename ,pversion               ,nocase))
    #SET(REJECTCOND ,'cond := rejected(')
  #ELSIF(pOutputFilename != '')
    #SET(OUTPUTFILENAME  ,pOutputFilename)
    #SET(REJECTCOND ,'cond := rejected(')
  #ELSE
    #SET(OUTPUTFILENAME  ,'')
    #SET(REJECTCOND ,'')
  #END

  #SET(SUMMARYREPORT,'')
	#SET(STRINGFILLER, '                                                                           ')
  #SET(EXTRAPARENS,'')
  #SET(PREVCNTR,0)
  #SET(SETWUIDS ,'[')
  #SET(REJECTCONDS ,'')
  #SET(MASTERCASE ,'\n\tcase(cond\n')
  #SET(MASTERSEQUENTIAL,'')
  //loop for each iteration
  #LOOP
    #IF(%CNTR% >= ((UNSIGNED)pNumIterations + (UNSIGNED)pIterationStartValue))
      #BREAK
    #END
    #IF(regexfind('@iteration@',%'ECLTEXT'%        ,nocase))
      #SET(LOOPTEXT  ,regexreplace('\n',regexreplace('\r\n',regexreplace('@iteration@' ,%'ECLTEXT'%,%'CNTR'% ,nocase),'\\\\n'),'\\\\n'))  
    #ELSE
      #SET(LOOPTEXT  ,regexreplace('\n',regexreplace('\r\n',%'ECLTEXT'%,'\\\\n'),'\\\\n'))
    #END
    
    #IF(regexfind('@iteration@',%'OUTPUTFILENAME'%        ,nocase))
      #SET(LOOPFILENAME  ,regexreplace('@iteration@' ,%'OUTPUTFILENAME'%,%'CNTR'% ,nocase))  
    #ELSE
      #SET(LOOPFILENAME  ,%'OUTPUTFILENAME'%)  
    #END
        
    #IF(%CNTR% != pIterationStartValue)
      //not the first iteration
      #APPEND(ECL ,'')
      // #APPEND(ECL ,'\t,')
      #APPEND(SETWUIDS,',')
      #APPEND(GETWUIDSECL,' + ')
      #APPEND(REJECTCOND,'\t,cond' + %'CNTR'%)
      
      #SET(REJECTCONDS  ,regexreplace(';',%'REJECTCONDS'%,' or STD.File.FileExists(\'' + %'LOOPFILENAME'% + '\');',nocase))
      #APPEND(REJECTCONDS ,'cond' + %'CNTR'% + ' := STD.File.FileExists(\'' + %'LOOPFILENAME'% + '\');\n')
/*      
  ,1 => sequential(cond1,cond2,cond3)
	,2 => sequential(cond2,cond3)
	,3 => sequential(cond3)
  );
 */
      #SET(MASTERCASE  ,regexreplace('[)]',%'MASTERCASE'%,',kick_iter'+ %'CNTR'% + ')',nocase))
      #APPEND(MASTERCASE  ,'\t\t,' + (%CNTR% - (UNSIGNED)pIterationStartValue + 1) + ' => sequential(kick_iter' + %'CNTR'% + ')\n')
      #APPEND(MASTERSEQUENTIAL  ,'\t,kick_iter' + %'CNTR'% + '\n')
    #ELSE
      //First iteration
      #APPEND(ECL ,'')
      // #APPEND(ECL ,'\t ')
      #APPEND(REJECTCONDS ,'cond' + %'CNTR'% + ' := STD.File.FileExists(\'' + %'LOOPFILENAME'% + '\');\n')
      #APPEND(REJECTCOND,'\t cond' + %'CNTR'%)
      #APPEND(MASTERCASE  ,'\t\t,' + (%CNTR% - (UNSIGNED)pIterationStartValue + 1) + ' => sequential(kick_iter' + %'CNTR'% + ')\n')
      #APPEND(MASTERSEQUENTIAL  ,'\t kick_iter' + %'CNTR'% + '\n')
    #END
        
/*
after first iteration
cond1 := STD.File.FileExists('~temp::lbentley::20130719::it36')\n
cond2 := \n
    
cond1 := STD.File.FileExists('~temp::lbentley::20130719::it36') or STD.File.FileExists('~temp::lbentley::20130719::it37') or STD.File.FileExists('~temp::lbentley::20130719::it38');
cond2 := STD.File.FileExists('~temp::lbentley::20130719::it37') or STD.File.FileExists('~temp::lbentley::20130719::it38');
cond3 := STD.File.FileExists('~temp::lbentley::20130719::it38');
*/

    #SET(RESULTCNTR ,1)
    #SET(EXTRAEMAIL ,'')
    #SET(RESULTSTEMP,'')
    #SET(ECLTEMP ,'')
    //loop to generate code to get results from iteration
    #LOOP  
      #IF(%RESULTCNTR% > count(pSetResults))
        #BREAK
      #END
      
      //new stuff --------------
      #SET(SCALARTEMP   ,wk_ut_dev.mac_parsefieldname(pSetResults[%RESULTCNTR%]))
      
      #SET(SCALARFIELD      ,STD.Str.Extract(%'SCALARTEMP'%,1))
      #SET(SCALARRESULT     ,STD.Str.Extract(%'SCALARTEMP'%,2))
      #SET(SCALARINDEXFIELD ,STD.Str.Extract(%'SCALARTEMP'%,3))

      #IF(trim(%'SCALARINDEXFIELD'%) != '' and %CNTR% = (UNSIGNED)pIterationStartValue)
        #APPEND(PREECL  ,%'SCALARFIELD'% + '_lay := ' + pSetResults[%RESULTCNTR% + 1] + ';\n')
      #END

      #SET(LEN				,length(trim(%'SCALARFIELD'%,left,right)))
      #SET(FILLER			,%'STRINGFILLER'%[1..(25 - (%LEN% - 1	))])

      #IF(trim(%'SCALARINDEXFIELD'%) = '')
        #APPEND(RESULTSTEMP ,%'SCALARRESULT'% + pversion + %'CNTR'% + '  := global(wk_ut_dev.get_Scalar_Result(wuid' + %'CNTR'% + ',\'' + %'SCALARRESULT'% + '\',\'' + pESP + '\'),few);\n')
        #APPEND(ECLTEMP    ,'\t,output(' + %'SCALARRESULT'% + pversion + %'CNTR'%                                                     + ' ,named(\'' + trim(pUniqueOutput,all) + %'SCALARFIELD'% + '_' + pversion + '_' + %'CNTR'% + '\'))\n')
        #APPEND(EXTRAEMAIL ,'+ \'' + %'SCALARFIELD'% + %'FILLER'% + ' : \' + ' + %'SCALARRESULT'% + pversion + %'CNTR'%                                                         + ' + \'\\n\'\n')


      #ELSE
        #APPEND(RESULTSTEMP ,%'SCALARRESULT'% + pversion + %'CNTR'% + '  := global(if((unsigned)wk_ut_dev.get_DS_Count(wuid' + %'CNTR'% + ',\'' + %'SCALARRESULT'% + '\',\'' + pESP + '\') != 0,wk_ut_dev.get_DS_Result    (wuid' + %'CNTR'% + ',\'' + %'SCALARRESULT'% + '\'  ,' + %'SCALARFIELD'% + '_lay' + ',\'' + pESP + '\' )  ,dataset([],' + %'SCALARFIELD'% + '_lay' + '))' + %'SCALARINDEXFIELD'% + ',few);\n')
        #APPEND(ECLTEMP     ,'\t,output(' + %'SCALARRESULT'% + pversion + %'CNTR'% + ',named(\'' + trim(pUniqueOutput,all) + %'SCALARFIELD'% + '_' + pversion + '_' + %'CNTR'% + '\'))\n')
        #APPEND(EXTRAEMAIL  ,'+ \'' + %'SCALARFIELD'% + %'FILLER'% + ' : \' + ' + %'SCALARRESULT'% + pversion + %'CNTR'%                                                                                                                                                                                                                                                       + ' + \'\\n\'\n')
      #END

      #SET(STOPCNTR       ,1)
      #SET(STOPCONDITION  ,'')
      //loop to generate code to test stop condition
      #LOOP  
        #IF(%STOPCNTR% > count(pSetStopCondition))
          #BREAK


        #END
        
        #SET(STOPTEMP     ,wk_ut_dev.mac_parse_Condition(pSetStopCondition[%STOPCNTR% + 1]))
        #SET(STOPOPERATOR ,STD.Str.Extract(%'STOPTEMP'%,1))
        #SET(STOPVALUE    ,STD.Str.Extract(%'STOPTEMP'%,2))
        #SET(STOPVALUETYPE,wk_ut_dev.mac_DetermineValueType(%'STOPVALUE'%))
        
        #IF(%STOPCNTR% = 1)
          #APPEND(STOPCONDITION ,'if(')
        #ELSE
          #APPEND(STOPCONDITION ,' and ')
        #END

        #IF(STD.Str.ToLowerCase(%'SCALARFIELD'%) = STD.Str.ToLowerCase(pSetStopCondition[%STOPCNTR%]))
          #APPEND(STOPCONDITION ,' (' + %'STOPVALUETYPE'% + ')' + %'SCALARRESULT'% + pversion + %'PREVCNTR'% + pSetStopCondition[%STOPCNTR% + 1])
        #END 
        // ,if((unsigned)global(wk_ut_dev.get_Scalar_Result(wuid36,'MatchesPerformed'),few) < 10000 , 
        // sequential(
            
        #SET(STOPCNTR ,%STOPCNTR% + 2) 

      #END

      #IF(trim(%'SCALARINDEXFIELD'%) = '')
        #SET(RESULTCNTR ,%RESULTCNTR% + 1) 
      #ELSE
        #SET(RESULTCNTR ,%RESULTCNTR% + 2) 
      #END

    #END
///////////

    #IF(count(pSetStopCondition) = 0 or %CNTR% = (UNSIGNED)pIterationStartValue)
      #APPEND(ECL ,'kick_iter' + %'CNTR'% + ' :=  sequential(\n')
      #APPEND(ECL ,'\t output(kickiter'   + %'CNTR'% + ',named(\'' + pUniqueOutput + 'Iteration_' + pversion + '_' + %CNTR% + '\'))\n')
      #APPEND(ECL ,'\t,output(\'<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=\' + kickiter' + %'CNTR'% + ' + \'">\' + kickiter' + %'CNTR'% + ' + \'</a>\',named(\'' + pUniqueOutput + 'Iteration_' + pversion + '_' + %CNTR% + '__html\'))\n')
      
      #APPEND(ECL ,'\t,output(\'' + %'NOTIFYMASTEREVENT'% + '\',named(\'' + pUniqueOutput + 'NotifyEvent_' + pversion + '_' + %CNTR% + '\'))\n')
      // #APPEND(ECL ,'\t,wait(\'' + %'NOTIFYMASTEREVENT'% + '\')\n')
      #APPEND(ECL ,'\t,output(wk_ut_dev.do_WUWaitComplete(kickiter'   + %'CNTR'% + '))\n')
      #APPEND(ECL ,'\t,output(\'done waiting at \' + ut.GetTimeDate())\n')

      // #APPEND(ECL ,'wk_ut_dev.CreateWuid(\'wk_ut_dev.RunWuid(\\\'' + %'LOOPTEXT'% + '\\\',\\\'' + %'CNTR'% + '\\\',\\\'' + pversion + '\\\',\\\'' + pCluster + '\\\',\\\'' + %'NOTIFYMASTEREVENT'% + '\\\',\\\'' + %'WAIT4MASTEREVENT'% + '\\\',\\\'\' + WORKUNIT + \'\\\',\\\'' + pESP + '\\\',,,\\\'' + trim(pUniqueOutput,all)  + '\\\',\\\'' + trim(pPollingFrequency,all)  + '\\\')\',\'' + %'WATCHERCLUSTER'% + '\')\n')
    #ELSE
      #APPEND(ECL ,%'STOPCONDITION'% + ',\n\tsequential(\n\t\twk_ut_dev.CreateWuid(\'wk_ut_dev.RunWuid(\\\'' + %'LOOPTEXT'% + '\\\',\\\'' + %'CNTR'% + '\\\',\\\'' + pversion + '\\\',\\\'' + pCluster + '\\\',\\\'' + %'NOTIFYMASTEREVENT'% + '\\\',\\\'' + %'WAIT4MASTEREVENT'% + '\\\',\\\'\' + WORKUNIT + \'\\\',\\\'' + %'LOOPFILENAME'% + '\\\',\\\'' + pOutputSuperfile + '\\\',\\\'' + %'LOCALESP'% + '\\\',,,\\\'' + trim(pUniqueOutput,all)  + '\\\',\\\'' + trim(pPollingFrequency,all)  + '\\\')\',\'' + %'WATCHERCLUSTER'% + '\',\'' + pESP + '\')\n')
      #APPEND(ECL ,',wait(\'' + %'NOTIFYMASTEREVENT'% + '\')')
      #APPEND(EXTRAPARENS,'))')
        // ,if((unsigned)global(wk_ut_dev.get_Scalar_Result(wuid36,'MatchesPerformed'),few) < 10000 , 
    // sequential(

    #END
    // #APPEND(ECL,%'ECLTEMP'%)
///////////
    #APPEND(PREECL ,'wuid' + %'CNTR'% + '   := nothor(global(wk_ut_dev.get_Scalar_Result(global(wk_ut_dev.get_Scalar_Result(workunit,\'' + trim(pUniqueOutput,all) + 'Iteration_'   + pversion + '_' + %'CNTR'% + '\'),few),\'' + trim(pUniqueOutput,all) + 'Iteration_'   + pversion + '_' + %'CNTR'% + '\',\'' + pESP + '\'),few)) : global;\n')    
    #APPEND(SETWUIDS  ,'realjobname' + %'CNTR'%)

    #APPEND(PREECL ,'get_wuids' + %'CNTR'% + '   := wk_ut_dev.get_DS_Result(global(wk_ut_dev.get_Scalar_Result(workunit,\'' + trim(pUniqueOutput,all) + 'Iteration_'   + pversion + '_' + %'CNTR'% + '\',\'' + pESP + '\'),few),\'Workunits\',wk_ut_dev.layouts.wks_slim,\'' + pESP + '\'); //get workunit info for these wuids\n')
    #APPEND(PREECL ,'get_thiswuids' + %'CNTR'% + ' := wk_ut_dev.get_DS_Result(workunit,\'Workunits\',wk_ut_dev.layouts.wks_slim); //get workunit info for this wuid\n')

    #APPEND(PREECL ,'Errors' + %'CNTR'% + '     := global(wk_ut_dev.get_Errors(wuid' + %'CNTR'% + ',\'' + pESP + '\'),few);\n')
    #APPEND(PREECL ,'get_wuids_' + %'CNTR'% + '             := wk_ut_dev.get_DS_Result(workunit,\'Workunits\',wk_ut_dev.layouts.wks_slim); //get workunit info for these wuids\n')
    #APPEND(PREECL ,'get_wuids_iter' + %'CNTR'% + '   := iterate(project(get_wuids' + %'CNTR'% + ',transform(recordof(left),self.Total_thor_Time := left.total_thor_time,self.Total_Time_secs := wk_ut_dev.Convert2Seconds(self.Total_thor_Time)\n')
    #APPEND(PREECL ,'      ,self.Run_Total_Time_secs:= if(counter = 1 ,self.Total_Time_secs + sum(get_thiswuids' + %'CNTR'% + ',Total_Time_secs),self.Total_Time_secs),self := left))\n')
    #APPEND(PREECL ,'      ,transform(recordof(left)\n')
    #APPEND(PREECL ,'      ,self.Run_Total_Time_secs := if(counter = 1,0,left.Run_Total_Time_secs) + right.Run_Total_Time_secs\n')
    #APPEND(PREECL ,'      ,self.Run_Total_Thor_Time := wk_ut_dev.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right));\n')
   
    #APPEND(PREECL ,'getAdvice' + %'CNTR'% + '   := global(wk_ut_dev.get_Scalar_Result(global(wk_ut_dev.get_Scalar_Result(workunit,\'' + trim(pUniqueOutput,all) + 'Iteration_'   + pversion + '_' + %'CNTR'% + '\',\'' + pESP + '\'),few),\'Advice\',\'' + pESP + '\'),few);\n')    
    #APPEND(PREECL ,'getstate' + %'CNTR'% + '   := global(wk_ut_dev.get_State(wuid' + %'CNTR'% + ',\'' + pESP + '\'),few);\n')    
    
    #APPEND(PREECL ,'realstate' + %'CNTR'% + '  := if(getstate' + %'CNTR'% + '[1..6] = \'failed\' ,\'failed\' ,getstate' + %'CNTR'% + ');\n')
    #APPEND(PREECL ,'thor_time' + %'CNTR'% + '  := global(wk_ut_dev.get_TotalTime(wuid' + %'CNTR'% + ',\'' + pESP + '\'),few);\n')    
    #APPEND(PREECL ,'realjobname' + %'CNTR'% + '    := global(wk_ut_dev.get_Jobname(wuid' + %'CNTR'% + ',\'' + pESP + '\'),few);  \n') 

    #APPEND(PREECL ,'jobname' + %'CNTR'% + ' := if(realjobname' + %'CNTR'% + ' != \'\' ,realjobname' + %'CNTR'% + ' ,wuid' + %'CNTR'% + ');\n')
    #APPEND(PREECL ,'fail' + %'CNTR'% + ' := iff((getstate' + %'CNTR'% + ' not in [\'completed\'] and getstate' + %'CNTR'% + ' not in [\'completed\']) and not regexfind(\'skip|move on\',getAdvice' + %'CNTR'% + ',nocase),fail(\'Fail workunit because wuid \' + wuid' + %'CNTR'% + ' + \' has/is \' + getstate' + %'CNTR'% + ' + \' with the following error(s):\\n\' + Errors' + %'CNTR'% + '));\n')
    #APPEND(PREECL,%'RESULTSTEMP'%)
    #APPEND(PREECL ,'sendemail' + %'CNTR'% + ' := wk_ut_dev.Send_Email(\n')
    #APPEND(PREECL ,trim(#TEXT(pNotifyEmails),all) + '\n')
    #APPEND(PREECL ,',jobname' + %'CNTR'% + '                + \' has \' + getstate' + %'CNTR'% + ' + \' in \' + thor_time' + %'CNTR'% + ' + \' on \' + _Control.ThisEnvironment.Name + \' on this date: \' + ut.GetTimeDate()\n')

    #APPEND(PREECL ,', if(jobname' + %'CNTR'% + ' != \'\'\n')
    #APPEND(PREECL ,', \'Jobname                    : \' + jobname' + %'CNTR'% + ' + \'\\n\',\'\')\n')
    #APPEND(PREECL ,'+ \'workunit                   : \' + wuid' + %'CNTR'% + ' + \'\\n\' \n')
    #APPEND(PREECL ,'+ \'State                      : \' + getstate' + %'CNTR'% + ' + \'\\n\'\n')
    #APPEND(PREECL ,'+ \'Total Thor Time            : \' + thor_time' + %'CNTR'% + ' + \'\\n\'\n')
    #APPEND(PREECL ,'+ \'Iteration                  : ' + %'CNTR'% + '\\n\'\n')
    #APPEND(PREECL ,'+ \'Version                    : ' + pversion + '\\n\'\n')
    #APPEND(PREECL ,%'EXTRAEMAIL'%)
    #APPEND(PREECL ,'+ if(trim(Errors' + %'CNTR'% + ') != \'\' ,\'FailMessage(s): \\n\' + Errors' + %'CNTR'% + ',\'\')\n')
    #APPEND(PREECL ,');\n')

    #APPEND(PREECL ,'outsummary' + %'CNTR'% + '     := output(project(wk_ut_dev.mac_CreateSummaryReport(\'' + pversion + '\',wuid' + %'CNTR'% + ',wuid' + %'CNTR'% + ',,,,' + %'SUMMARYSET'% + ',,,[\'Iteration\'],[\'' + %'CNTR'% + '\'],,,1,pESP := ' + #TEXT(pEsp) + '),{recordof(left) - filesread - fileswritten}),named(\'SummaryReport' + trim(pUniqueOutput,all) + '\'),EXTEND);\n')
    #APPEND(PREECL ,'kickiter'   + %'CNTR'% + '     := wk_ut_dev.CreateWuid(\'wk_ut_dev.RunWuid(\\\'' + %'LOOPTEXT'% + '\\\',\\\'' + %'CNTR'% + '\\\',\\\'' + pversion + '\\\',\\\'' + pCluster + '\\\',\\\'' + %'NOTIFYMASTEREVENT'% + '\\\',\\\'' + %'WAIT4MASTEREVENT'% + '\\\',\\\'\' + WORKUNIT + \'\\\',\\\'' + %'LOOPFILENAME'% + '\\\',\\\'' + pOutputSuperfile + '\\\',\\\'' + %'LOCALESP'% + '\\\',,,\\\'' + trim(pUniqueOutput,all)  + '\\\',\\\'' + trim(pPollingFrequency,all)  + '\\\')\',\'' + %'WATCHERCLUSTER'% + '\',\'' + pESP + '\');\n')

    #APPEND(ECL, '\t,sendemail'  + %'CNTR'% + '\n')
    #IF(pOutputSuperfile != '')
      #APPEND(ECL, '\t,output(dataset(\'' + pOutputSuperfile + '\',wk_ut_dev.layouts.wks_slim,thor),named(\'Workunits\'),overwrite,all)\n')
    #ELSE
      #APPEND(ECL, '\t,output(get_wuids_' + %'CNTR'% + ' + get_wuids_iter' + %'CNTR'% + ',named(\'Workunits\'),overwrite)\n')
    #END
    
    // #IF(trim(%'LOOPFILENAME'%) != '') 
      // #APPEND(ECL, '\t,tools.macf_WriteFile(\'' + %'LOOPFILENAME'% + '\',get_wuids_iter' + %'CNTR'% + ',false,false,true)\n')
    
      // #IF(pOutputSuperfile != '')
        // #APPEND(ECL, '\t,std.file.addsuperfile(\'' + pOutputSuperfile + '\',\'' + %'LOOPFILENAME'% + '\')\n')
      // #END
    // #END
    
    #APPEND(ECL, '\t,outsummary' + %'CNTR'% + '\n')
    #APPEND(ECL, '\t,fail' + %'CNTR'% + '\n')
    #APPEND(ECL, '\t,output(\'_____________________________________________________________\')\n')
    #APPEND(ECL, '\t);\n')
    
    #APPEND(GETWUIDSECL ,'get_wuids' + %'CNTR'%)
    #SET(PREVCNTR ,%CNTR%)
    #SET(CNTR ,%CNTR% + 1)
  #END

  //do sum total stuff
  
  #APPEND(SETWUIDS  ,']')
  #IF(%'LOOPFILENAME'% != '' and pForceRun = false)
    #APPEND(ECL,'return sequential(' + %'MASTERCASE'% + '\t)\n')
  #ELSE
    #APPEND(ECL,'return sequential(\n' + %'MASTERSEQUENTIAL'%)
  #END
  
  #IF((unsigned)pNumIterations > 1)
    #APPEND(ECL    ,'\t,outputSumTimings\n')
    #APPEND(ECL    ,'\t,output(\'-----------------------------------------------------------------------------------------------\')\n')
    // #APPEND(PREECL ,'get_wuids             := ' + %'GETWUIDSECL'% + '; //get workunit info for these wuids\n')
    #APPEND(PREECL ,'get_wuids             := wk_ut_dev.get_DS_Result(workunit,\'Workunits\',wk_ut_dev.layouts.wks_slim); //get workunit info for these wuids\n')
    #APPEND(PREECL ,'get_wuids_filt        := get_wuids(name in ' + %'SETWUIDS'% + ');\n')
    #APPEND(PREECL ,'sumseconds            := sum(get_wuids_filt,Total_Time_secs);\n')
    #APPEND(PREECL ,'totalthortime         := wk_ut_dev.ConvertSecs2ThorTime(sumseconds);\n')
    #APPEND(PREECL ,'outputSumTimings      := output(get_wuids + dataset([{\'' + trim(pUniqueOutput,all) + ' Subtotal\',\'\',\'\',\'\',\'' + pversion + '\',\'\',0.0,\'\',0.0,totalthortime,sumseconds,ut.GetTimeDate()}],wk_ut_dev.layouts.wks_slim),named(\'Workunits\'),overwrite);\n')
  #END

  #IF(%'LOOPFILENAME'% != '')
    #APPEND(PREECL  ,%'REJECTCONDS'% + '\n' + %'REJECTCOND'% + '\n);\n')
  #END
  
  #APPEND(ECL ,')' + %'EXTRAPARENS'% + ';')
////////    #SET(ECL,'SEQUENTIAL(\n')

  #SET(ECL  ,%'PREECL'% + %'ECL'%)
  // #SET(ECL  ,%'PREECL'% + 'return ' + %'ECL'%)

	#if(pOutputEcl = true)
		return %'ECL'%;
	#ELSE
		%ECL%
	#END

endmacro;