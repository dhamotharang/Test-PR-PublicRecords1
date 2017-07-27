import tools,ut,_control,wk_ut;
/*
  Wait4Workunits() -- waits for all of the workunits in the set passed to complete/abort/fail before returning.
*/
EXPORT Wait4Workunits(

   pSetWuids                                                  //assumption is that all of these wuids are in the same environment(pESP)(not a big leap)                                       
  ,piteration
  ,pversion
  ,pUniqueOutput      = '\'\''
  ,pESP               = 'wk_ut._constants.LocalEsp'
  ,pNotifyEmails      = 'wk_ut._Constants.EmailAddressNotify'
  ,pShouldEmail       = 'true'
  ,pPollingFrequency  = '\'5\''
	,pOutputEcl					= 'false'					                      // Should output the ecl as a string(for testing) or actually run the ecl

) := 
functionmacro

  #uniquename(Wait4workunitevent)

  watchercluster  := wk_ut._constants.Esp2Hthor(pESP);
  localesp        := wk_ut._constants.LocalEsp;
  
  // wuidsstring     := project(dataset([{''}],{string junk}),transform({string wuid},self.wuid := if(pSetWuids[counter] = '','','\'' + pSetWuids[counter] + '\'')))(wuid != '');
  wuidsstring     := normalize(dataset([{''}],{string junk}),count(pSetWuids),transform({string wuid},self.wuid := if(pSetWuids[counter] = '','','\'' + pSetWuids[counter] + '\'')))(wuid != '');
  wuidsstring2    := '[' + rollup(wuidsstring,true,transform({string wuid},self.wuid := left.wuid + ',' + right.wuid))[1].wuid + ']';
  notifymultiecl  := 'wk_ut.mac_NotifyMulti(' + wuidsstring2 + ',\'' + %'Wait4workunitevent'% + '\',\'' + pNotifyEmails + '\',\'' + pPollingFrequency + '\',\'' + localesp + '\');';

  createwatcherworkunit1 := wk_ut.CreateWuid(
     notifymultiecl
    ,watchercluster
    ,pESP
  ); 

  createwatcherworkunit1_html := '<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + createwatcherworkunit1   + '#/stub/Summary">Watcher Workunit</a>';
  
  wait4it1 := wait(event(%'Wait4workunitevent'%,'*'));
  
  // -- Create Watcher for Wuids in set.  Can't do it in this wuid because the set has to be a constant
  result1 := sequential(
       output('______________________________________________________________________________')
      ,output(pSetWuids                     ,named(pUniqueOutput + 'Wuids_kicked_off_for_'  + pversion + '_' + piteration))
      ,output(createwatcherworkunit1        ,named(pUniqueOutput + 'Watcher_for_'           + pversion + '_' + piteration))
      ,output(createwatcherworkunit1_html   ,named(pUniqueOutput + 'Watcher_for_'           + pversion + '_' + piteration + '__html'))
      ,output(%'Wait4workunitevent'%        ,named(pUniqueOutput + 'NotifyEvent_'           + pversion + '_' + piteration))
      ,output(wk_ut.do_WUWaitComplete(createwatcherworkunit1,,,pESP))
      ,output(wk_ut.do_WUWaitComplete(createwatcherworkunit1,,,pESP)) //do twice because sometimes it returns even though it all wuids did not complete/fail/abort.
      ,output('done waiting at ' + wk_ut.getTimeDate())
  );
  
  // dnormset      := normalize(dataset([{''}],{string junk}),count(pSetWuids),transform({string wuid},self.wuid := pSetWuids[counter])) : independent;
  // dindepent := pSetWuids : independent;
  
  ///////////////////
  wuidsresults     := normalize(dataset([{''}],{string junk}),count(pSetWuids),transform({string wuid},self.wuid := if(pSetWuids[counter] = '','','\'' + pSetWuids[counter] + '\'')))(wuid != '');
  wuidsresultsp    := project(wuidsresults,transform(recordof(left)
                        ,self.wuid := if(counter > 1,' ,','  ') + 'wk_ut.OutputWuidsNEmail(' + left.wuid + ',\'' + pversion + '\',\'' + piteration + '\',\'' + pNotifyEmails + '\',' + pShouldEmail + ')\n'
                      ));
  wuidsresults2    := 'sequential(\n' 
                      + rollup(wuidsresultsp,true,transform({string wuid},self.wuid := left.wuid + right.wuid))[1].wuid 
                      + if(pESP in wk_ut._Constants.LocalEsps ,' ,notify(\'' + %'Wait4workunitevent'% + '\', \'*\')\n'
                                                              ,' ,wk_ut.Remote_Notify(\'' + %'Wait4workunitevent'% + '\',\'' + localesp + '\')\n'
                        )
                      + ');\n'
                      ;
  myecl := wuidsresults2;

  createwatcherworkunit2 := wk_ut.CreateWuid(
     myecl
    ,watchercluster
    ,pESP
  ); 

  wait4it2 := wait(event(%'Wait4workunitevent'%,'*'));

  createwatcherworkunit2_html := '<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + createwatcherworkunit2   + '#/stub/Summary">Watcher Workunit2</a>';
  
  // -- Create another wuid to get the results for all of the wuids in set.  This allows 1 call to get the results from that wuid
  result2 := sequential(
       output('______________________________________________________________________________')
      ,output(createwatcherworkunit2  ,named(pUniqueOutput + 'Get_Results_' + pversion + '_' + piteration))
      ,output(createwatcherworkunit2  ,named(pUniqueOutput + 'Get_Results_' + pversion + '_' + piteration + '__html'))
      ,output(%'Wait4workunitevent'%  ,named(pUniqueOutput + 'Get_Results_NotifyEvent_' + pversion + '_' + piteration))
      // ,wait4it2
      ,output(wk_ut.do_WUWaitComplete(createwatcherworkunit2,,,pESP))
      ,output('done waiting for Get Results on ' + wk_ut.getTimeDate())
  );

  
  // dooutputsNEmail := nothor(apply(global(dindepent,few),wk_ut.OutputWuidsNEmail(wuid,pversion,piteration,pNotifyEmails,pShouldEmail)));
  dooutputsNEmail := %ECL%;
  
  // -- Get results from all Wuids in set
  getwuids            := wk_ut.get_DS_Result(createwatcherworkunit2,'Workunits',wk_ut.layouts.wks_slim,pESP); //--THIS FUNCTION NEEDS TO BE UPDATED FOR REMOTE CALLS(USING HTTPCALL). get workunit info for these wuids
  anyFailedOrAborted  := count(getwuids(wuid in pSetWuids/*WHAT TO DO ABOUT THIS NOW THAT WE USE THE FILE TO ACCUMULATE THE WUIDS?*/,trim(state) in ['failed','aborted'])) > 0;

  thiswuid            := if(wk_ut.get_Scalar_Result(workunit       ,'Workunits') != '',wk_ut.get_DS_Result(workunit        ,'Workunits',wk_ut.layouts.wks_slim),dataset([],wk_ut.layouts.wks_slim));
  Run_Total_Time_secs := sum(thiswuid(not regexfind('^.*?total$',trim(name),nocase)),Total_Time_secs);
  Run_Total_Thor_Time := wk_ut.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);

  getthiswuids            := wk_ut.get_DS_Result(workunit,'Workunits',wk_ut.layouts.wks_slim); //--THIS FUNCTION NEEDS TO BE UPDATED FOR REMOTE CALLS(USING HTTPCALL). get workunit info for these wuids

  iterwuids  := iterate(project(getthiswuids + getwuids,transform(recordof(left),self.Run_Total_Time_secs := left.Total_Time_secs,self := left)),transform(recordof(left)
    ,self.Run_Total_Time_secs := if(counter = 1,Run_Total_Time_secs,left.Run_Total_Time_secs) + right.Run_Total_Time_secs
    ,self.Run_Total_Thor_Time := wk_ut.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right));
  
  outputresults       := output(iterwuids,named('Workunits'),overwrite);

  doit :=  sequential(result1,result2/*,outputresults*/,iff(anyFailedOrAborted ,fail('Fail workunit because at least one wuid ' + getwuids(trim(state) in ['failed','aborted'])[1].wuid + ' has ' + getwuids(trim(state) in ['failed','aborted'])[1].state + '.')));

  return if(pOutputEcl = false  ,doit,sequential(output(notifymultiecl,named('NotifyMultiEcl')),output(myecl ,named('OutputWuidResultsEcl'))));

endmacro;
