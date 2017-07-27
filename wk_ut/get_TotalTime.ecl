/*
  when total thor time is zero, then add up the graphs, + any copies, sprays, desprays, etc.
  if total thor time is non-zero, then take that, and add to it any copies, sprays, desprays
  total of all subgraph timings != total thor time.  total thor time is usually a little more
*/
EXPORT get_TotalTime(

   string   wuid
  ,string   pesp        = _constants.LocalEsp
  ,boolean  pDoNotFail  = false

) := 
function

  total_thor_time := if(pDoNotFail   = false  ,wk_ut.get_WUInfo(wuid,pesp).totalthortime  ,wk_ut.get_WUInfo(wuid,pesp).totalthortime_nofail );
  dtimes          := if(pDoNotFail   = false  ,wk_ut.get_WUInfo(wuid,pesp).dnormTimers    ,wk_ut.get_WUInfo(wuid,pesp).dnormTimers_nofail   );

  thor_time_secs := wk_ut.Convert2Seconds(total_thor_time);
  
  dcopytimes := project(dtimes,transform({recordof(left),string total_seconds,string rtotal_secs,string total_pretty,string rtotal_pretty}
    ,self.total_seconds   := (string)wk_ut.Convert2Seconds(left.value)
    ,self.total_pretty    := wk_ut.ConvertSecs2ReadableTime((real8)self.total_seconds)
    ,self.rtotal_secs     := self.total_seconds
    ,self.rtotal_pretty   := ''
    ,self                 := left
  ));

  dsort := sort(dcopytimes((unsigned)total_seconds > 0),name);
  diterate := iterate(dsort,transform(recordof(left),self.rtotal_secs := (string)((real8)left.rtotal_secs + (real8)right.rtotal_secs),self.rtotal_pretty := wk_ut.ConvertSecs2ReadableTime((real8)self.rtotal_secs),self := right));

  dgraphtimes := dcopytimes(regexfind('^graph'  ,name,nocase),subgraphid != '');
  ddfutimes   := dcopytimes(regexfind('elapsed' ,name,nocase));
  
  total_time_secs   := thor_time_secs + if(thor_time_secs = 0.0  ,sum(dgraphtimes,(real8)total_seconds) ,0.0) + sum(ddfutimes,(real8)total_seconds);
  
  total_time        := wk_ut.ConvertSecs2ThorTime(total_time_secs);
  total_graph_time  := wk_ut.ConvertSecs2ReadableTime(sum(dgraphtimes,(real8)total_seconds));
  total_dfu_time    := wk_ut.ConvertSecs2ReadableTime(sum(ddfutimes,(real8)total_seconds));
  
  // output(dcopytimes);
  // output(diterate,all);
// (regexfind('copy.*elapsed',name,nocase))

  // return sequential(
     // output(total_thor_time           ,named('total_thor_time'  ))
    // ,output(total_graph_time          ,named('total_graph_time' ))
    // ,output(total_dfu_time            ,named('total_dfu_time'   ))
    // ,output(total_time                ,named('total_time'       ))
    // ,output(choosen(dcopytimes  ,1000),named('dcopytimes'       ),all)
    // ,output(choosen(dgraphtimes ,1000),named('dgraphtimes'      ),all)
    // ,output(choosen(ddfutimes   ,1000),named('ddfutimes'        ),all)
  // );
  
  return total_time;
  
end;