EXPORT get_Workunits_ds(

   string pWuid
  ,string pversion
  ,string piteration
  ,string pesp        = _Config.LocalEsp
  
) :=
function

  getstate       := WorkMan.get_State(pWuid,pesp);    
  realstate      := if(getstate[1..6] = 'failed' ,'failed' ,getstate);
  thor_time      := WorkMan.get_TotalTime(pWuid,pesp); 
  thor_time_secs := WorkMan.Convert2Seconds(thor_time);
  jobname        := WorkMan.get_Jobname(pWuid,pesp);   
  Errors         := WorkMan.get_Errors(pWuid,pesp);
  
  thiswuid            := if(WorkMan.get_Scalar_Result(pWuid       ,'Workunits',pesp) != '',WorkMan.get_DS_Result(pWuid        ,'Workunits',WorkMan.layouts.wks_slim,pesp),dataset([],WorkMan.layouts.wks_slim));
  Run_Total_Time_secs := sum(thiswuid,Total_Time_secs) + thor_time_secs;
  Run_Total_Thor_Time := WorkMan.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);

  //name, wuid, iteration#, version, thor time, etc
  dWUDetails := dataset([{jobname ,'',pWuid ,'',pesp,Workman._Config.Esp2Name(pesp),getstate ,piteration ,pversion ,thor_time,thor_time_secs,Run_Total_Thor_Time,Run_Total_Time_secs,'',0.0,'',Errors}] ,layouts.wks_slim);

  return thiswuid + dWUDetails;
  
end;