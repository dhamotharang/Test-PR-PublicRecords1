//wk_ut.Convert2Seconds();
fdoit(string wuid) := 
function
  getstate1   := wk_ut.get_WUInfo(wuid).State;    
  realstate1  := if(getstate1[1..6] = 'failed' ,'failed' ,getstate1);
  thor_time1  := wk_ut.get_WUInfo(wuid).TotalThorTime;    
  jobname1    := wk_ut.get_WUInfo(wuid).JobName;   
  Errors      := wk_ut.get_WUInfo(wuid).Errors;
  
  //name, wuid, iteration#, version, thor time, etc
  dWUDetails1 := dataset([{jobname1 ,wuid ,getstate1 ,'1' ,bipv2.KeySuffix ,thor_time1}] ,wk_ut.Layouts.wks_slim);

  return dWUDetails1;
  
end;

wuid1 := wk_ut.get_DS_Result('W20140314-171443','Workunits',wk_ut.Layouts.wks_slim);
wuid2 := wk_ut.get_DS_Result('W20140316-015546','Workunits',wk_ut.Layouts.wks_slim);  //best
wuid3 := wk_ut.get_DS_Result('W20140316-015606','Workunits',wk_ut.Layouts.wks_slim);  //seleid rel
wuid4 := wk_ut.get_DS_Result('W20140316-015538','Workunits',wk_ut.Layouts.wks_slim);  //just xlink
wuid5 := wk_ut.get_DS_Result('W20140316-015557','Workunits',wk_ut.Layouts.wks_slim);  //seg stats
wuid6 := wk_ut.get_DS_Result('W20140316-230433','Workunits',wk_ut.Layouts.wks_slim);  //top biz, misc keys
wuid7 := wk_ut.get_DS_Result('W20140317-020752','Workunits',wk_ut.Layouts.wks_slim);  //weekly keys
wuid8 := fdoit('W20140316-160549');  //strata stats
wuid9 := fdoit('W20140316-144042');  //xlink copy--not thor time.
wuid10 := fdoit('W20140317-094635');  //xlink sample by itself    


dconcat := 
wuid1 
+ wuid2 
+ wuid3 
+ wuid4 
+ wuid5 
+ wuid6 
+ wuid7 
+ wuid8 
+ wuid9 
+ wuid10
;

dproj := project(dconcat,transform({recordof(left),string total_seconds,string total_calc_time,string rtotal_secs := '',string rtotal_pretty}
  ,self.total_seconds   := (string)wk_ut.Convert2Seconds(left.total_thor_time)
  ,self.total_calc_time := wk_ut.ConvertSecs2ReadableTime((real8)self.total_seconds)
  ,self.rtotal_secs     := self.total_seconds
  ,self.rtotal_pretty   := ''
  ,self := left
));

dsort := sort(dproj((unsigned)total_seconds > 0),wuid);
diterate := iterate(dsort,transform(recordof(left),self.rtotal_secs := (string)((real8)left.rtotal_secs + (real8)right.rtotal_secs),self.rtotal_pretty := wk_ut.ConvertSecs2ReadableTime((real8)self.rtotal_secs),self := right));


output(dconcat ,named('dconcat' ),all);
output(dproj   ,named('dproj'   ),all);
output(sort(dproj,wuid)   ,named('dprojsort'   ),all);
output(sort(dproj((unsigned)total_seconds > 0),wuid)   ,named('dprojsortfilt'   ),all);

output(diterate   ,named('diterate'   ),all);

/*

=if(INT(1/86400*K11) > 0, INT(1/86400*K11) & " day(s), " ,"") & if(INT(MOD(K11,86400)/3600) > 0 ,INT(MOD(K11,86400)/3600) & " hour(s), " ,"") & if(INT(MOD(K11,3600)/60) > 0 ,INT(MOD(K11,3600)/60) &" minutes, " ,"") & if(MOD(K11,60) > 0 ,MOD(K11,60) & " seconds"  ,"")
=if(INT(1/86400*K15) > 0, INT(1/86400*K15) & " day(s), " ,"") & if(INT(MOD(K15,86400)/3600) > 0 ,INT(MOD(K15,86400)/3600) & " hour(s), " ,"") & if(INT(MOD(K15,3600)/60) > 0 ,INT(MOD(K15,3600)/60) &" minutes, " ,"") & if(MOD(K15,60) > 0 ,MOD(K15,60) & " seconds"  ,"")
=if(INT(1/86400*K19) > 0, INT(1/86400*K19) & " day(s), " ,"") & if(INT(MOD(K19,86400)/3600) > 0 ,INT(MOD(K19,86400)/3600) & " hour(s), " ,"") & if(INT(MOD(K19,3600)/60) > 0 ,INT(MOD(K19,3600)/60) &" minutes, " ,"") & if(MOD(K19,60) > 0 ,MOD(K19,60) & " seconds"  ,"")
=if(INT(1/86400*I30) > 0, INT(1/86400*I30) & " day(s), " ,"") & if(INT(MOD(I30,86400)/3600) > 0 ,INT(MOD(I30,86400)/3600) & " hour(s), " ,"") & if(INT(MOD(I30,3600)/60) > 0 ,INT(MOD(I30,3600)/60) &" minutes, " ,"") & if(MOD(I30,60) > 0 ,MOD(I30,60) & " seconds"  ,"")

*/