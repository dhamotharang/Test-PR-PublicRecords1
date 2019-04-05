import _control,tools,ut;

EXPORT OutputWuidsNEmail(

   string  pWuid
  ,string  pversion      
  ,string  piteration     = '1'
  ,string  pNotifyEmails  = wk_ut._Constants.EmailAddressNotify
  ,boolean pShouldEmail   = true
  ,string  pEsp           = _constants.LocalEsp
  
) :=
function

  getstate1       := wk_ut.get_State(pWuid,pEsp);    
  realstate1      := if(getstate1[1..6] = 'failed' ,'failed' ,getstate1);
  thor_time1      := wk_ut.get_TotalTime(pWuid,pEsp); 
  thor_time_secs  := wk_ut.Convert2Seconds(thor_time1);
  jobname1        := wk_ut.get_Jobname(pWuid,pEsp);   
  Errors          := wk_ut.get_Errors(pWuid,pEsp);
  owner           := wk_ut.get_Owner(pWuid,pEsp);
  
  // -- get total time for existing wuids to calculate the running total.
  thiswuid            := if(wk_ut.get_Scalar_Result(workunit       ,'Workunits') != '',wk_ut.get_DS_Result(workunit        ,'Workunits',wk_ut.layouts.wks_slim),dataset([],wk_ut.layouts.wks_slim));
  Run_Total_Time_secs := sum(thiswuid(not regexfind('^.*?total$',trim(name),nocase)),Total_Time_secs) + thor_time_secs;
  Run_Total_Thor_Time := wk_ut.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);
  
  //name, wuid, iteration#, version, thor time, etc
  dWUDetails1 := dataset([{jobname1 ,'',pWuid ,owner,pEsp,wk_ut._Constants.Esp2Name(pesp),getstate1 ,piteration ,pversion ,thor_time1,thor_time_secs,Run_Total_Thor_Time,Run_Total_Time_secs,'',0,'',Errors}] ,layouts.wks_slim);
  jobname2 := if(jobname1 != '' ,jobname1 ,pWuid);
  sendemail1 := wk_ut.Send_Email(
                             pNotifyEmails
                            ,jobname2 + ' has ' + getstate1 + ' in ' + thor_time1 + ' on ' + _Control.ThisEnvironment.Name + ' on this date: ' + wk_ut.getTimeDate()
                            , if(jobname1 != ''
                            , 'Jobname        : ' + jobname1 + '\n','')
                            + 'workunit       : ' + pWuid + '\n' 
                            + 'State          : ' + getstate1 + '\n'
                            + 'Total Thor Time: ' + thor_time1 + '\n'
                            + 'Iteration      : ' + piteration + '\n'
                            + 'Version        : ' + pversion + '\n'
                            + if(trim(Errors) != '' ,'FailMessage(s): \n' + Errors,'')
                          );

  //Grab child's 'Workunits' result if necessary, total up time
  childwuids := if(wk_ut.get_Scalar_Result(pWuid,'Workunits',pEsp) != '' and pESP in _constants.LocalEsps,wk_ut.get_DS_Result(pWuid,'Workunits',wk_ut.layouts.wks_slim),dataset([],wk_ut.layouts.wks_slim));

  // sortwuids  := sort(getwuids,wuid);
  iterwuids  := iterate(project(childwuids,transform(recordof(left),self.Run_Total_Time_secs := left.Total_Time_secs,self := left)),transform(recordof(left)
    ,self.Run_Total_Time_secs := if(counter = 1,Run_Total_Time_secs,left.Run_Total_Time_secs) + right.Run_Total_Time_secs
    ,self.Run_Total_Thor_Time := wk_ut.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right));

  doit :=  iff(pWuid != '',sequential(output(dedup(dWUDetails1 + iterwuids,wuid,all),named('Workunits'),overwrite),if(pShouldEmail ,sendemail1)));
  
  return doit;

end;