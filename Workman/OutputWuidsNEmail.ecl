import _control,tools,ut;

EXPORT OutputWuidsNEmail(

   string  pWuid
  ,string  pversion      
  ,string  piteration     = '1'
  ,string  pNotifyEmails  = WorkMan._Config.EmailAddressNotify
  ,boolean pShouldEmail   = true
  ,string  pEsp           = _Config.LocalEsp
  
) :=
function

  getstate1       := WorkMan.get_State(pWuid,pEsp);    
  realstate1      := if(getstate1[1..6] = 'failed' ,'failed' ,getstate1);
  thor_time1      := WorkMan.get_TotalTime(pWuid,pEsp); 
  thor_time_secs  := WorkMan.Convert2Seconds(thor_time1);
  jobname1        := WorkMan.get_Jobname(pWuid,pEsp);   
  Errors          := WorkMan.get_Errors(pWuid,pEsp);

  // -- get total time for existing wuids to calculate the running total.
  thiswuid            := if(WorkMan.get_Scalar_Result(workunit       ,'Workunits') != '',WorkMan.get_DS_Result(workunit        ,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  Run_Total_Time_secs := sum(thiswuid(not regexfind('^.*?total$',trim(name),nocase)),Total_Time_secs) + thor_time_secs;
  Run_Total_Thor_Time := WorkMan.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);
  
  //name, wuid, iteration#, version, thor time, etc
  dWUDetails1 := dataset([{jobname1 ,'',pWuid ,pEsp,WorkMan._Config.Esp2Name(pesp),getstate1 ,piteration ,pversion ,thor_time1,thor_time_secs,Run_Total_Thor_Time,Run_Total_Time_secs}] ,layouts.wks_slim);

  jobname2 := if(jobname1 != '' ,jobname1 ,pWuid);
  sendemail1 := WorkMan.Send_Email(
                             pNotifyEmails
                            ,jobname2 + ' has ' + getstate1 + ' in ' + thor_time1 + ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + WorkMan.getTimeDate()
                            , if(jobname1 != ''
                            , 'Jobname'         + '\t\t\t: '    + jobname1                                                                             + '\n','')
                            + 'workunit'        + '\t\t\t: '    + pWuid                                                                         + '\n' 
                            + 'workunit link'   + '\t\t\t: '    + 'http://' + pEsp + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + pWuid + '#/stub/Summary\n' 
                            + 'State'           + '\t\t\t\t: '  + getstate1                                                                            + '\n'
                            + 'Total Thor Time' + '\t\t\t: '    + thor_time1                                                                           + '\n'
                            + 'Iteration'       + '\t\t\t: '    + piteration                                                                           + '\n'
                            + 'Version'         + '\t\t\t\t: '  + pversion                                                                            + '\n'
                            + if(trim(Errors) != '' ,'FailMessage(s): \n' + Errors,'')
                          );

  //Grab child's 'Workunits' result if necessary, total up time
  childwuids := if(WorkMan.get_Scalar_Result(pWuid,'Workunits',pEsp) != '' and pESP in _Config.LocalEsps,WorkMan.get_DS_Result(pWuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));

  // sortwuids  := sort(getwuids,wuid);
  iterwuids  := iterate(project(childwuids,transform(recordof(left),self.Run_Total_Time_secs := left.Total_Time_secs,self := left)),transform(recordof(left)
    ,self.Run_Total_Time_secs := if(counter = 1,Run_Total_Time_secs,left.Run_Total_Time_secs) + right.Run_Total_Time_secs
    ,self.Run_Total_Thor_Time := WorkMan.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right));

  doit :=  iff(pWuid != '',sequential(output(dWUDetails1 + iterwuids,named('Workunits'),OVERWRITE),if(pShouldEmail ,sendemail1)));
  
  return doit;

end;