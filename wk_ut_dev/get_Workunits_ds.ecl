EXPORT get_Workunits_ds(

   string pWuid
  ,string pversion
  ,string piteration
  ,string pesp        = _constants.LocalEsp
  
) :=
function

  getstate       := wk_ut_dev.get_State(pWuid,pesp);    
  realstate      := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  thor_time      := wk_ut_dev.get_TotalTime(pWuid,pesp); 
  thor_time_secs := wk_ut_dev.Convert2Seconds(thor_time);
  jobname        := wk_ut_dev.get_Jobname(pWuid,pesp);   
  Errors         := wk_ut_dev.get_Errors(pWuid,pesp);
  
  thiswuid            := if(wk_ut_dev.get_Scalar_Result(pWuid       ,'Workunits',pesp) != '',wk_ut_dev.get_DS_Result(pWuid        ,'Workunits',wk_ut_dev.layouts.wks_slim,pesp),dataset([],wk_ut_dev.layouts.wks_slim));
  Run_Total_Time_secs := sum(thiswuid,Total_Time_secs) + thor_time_secs;
  Run_Total_Thor_Time := wk_ut_dev.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);

  //name, wuid, iteration#, version, thor time, etc
  dWUDetails := dataset([{jobname ,pWuid ,getstate ,piteration ,pversion ,thor_time,thor_time_secs,Run_Total_Thor_Time,Run_Total_Time_secs,'',0.0,'',Errors}] ,layouts.wks_slim);

  return thiswuid + dWUDetails;
  
end;