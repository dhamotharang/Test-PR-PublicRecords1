/*
  when total thor time is zero, then add up the graphs, + any copies, sprays, desprays, etc.
  if total thor time is non-zero, then take that, and add to it any copies, sprays, desprays
  total of all subgraph timings != total thor time.  total thor time is usually a little more
*/
import WsWorkunits,std;
EXPORT get_TotalTime(

   string   wuid
  ,string   pesp          = _Config.LocalEsp
  ,boolean  pDoNotFail    = false
  ,boolean  pOutputDebug  = false

) := 
function

  total_thor_time_soapcall_raw  := WsWorkunits.Get_Thor_Time(wuid,pesp);
  total_thor_time_stdlib_raw    := STD.System.Workunit.WorkunitTimings(wuid)(regexfind('(Process: TimeTotalExecute|Total thor time)',name,nocase))[1].duration;
  
  thor_time_secs_soapcall       := WorkMan.Convert2Seconds(total_thor_time_soapcall_raw);
  thor_time_secs_stdlib         := (real)total_thor_time_stdlib_raw / 1000;
  
  total_time_soap_out           := WorkMan.ConvertSecs2ReadableTime(thor_time_secs_soapcall);
  total_time_stdlib_out         := WorkMan.ConvertSecs2ReadableTime(thor_time_secs_stdlib  );

  total_time := if(trim(pesp) in Workman._Config.LocalEsps and (real)total_thor_time_stdlib_raw > 0.0 
                  ,total_time_stdlib_out  
                  ,total_time_soap_out
                );
  
  outputdebug := sequential(
     output(total_thor_time_soapcall_raw   ,named('total_thor_time_soapcall_raw' ))
    ,output(total_thor_time_stdlib_raw     ,named('total_thor_time_stdlib_raw'   ))
    ,output(thor_time_secs_soapcall        ,named('thor_time_secs_soapcall'      ))
    ,output(thor_time_secs_stdlib          ,named('thor_time_secs_stdlib'        ))
    ,output(total_time_soap_out            ,named('total_time_soap_out'          ))
    ,output(total_time_stdlib_out          ,named('total_time_stdlib_out'        ))
    ,output(total_time                     ,named('total_time'                   ))
  );
  
  return when(total_time  ,if(pOutputDebug  ,outputdebug));

  // dtimes          := if(pDoNotFail   = false  ,WorkMan.get_WUInfo(wuid,pesp).dnormTimers    ,WorkMan.get_WUInfo(wuid,pesp).dnormTimers_nofail   );
  // dcopytimes := project(dtimes,transform({recordof(left),string total_seconds,string rtotal_secs,string total_pretty,string rtotal_pretty}
    // ,self.total_seconds   := (string)WorkMan.Convert2Seconds(left.value)
    // ,self.total_pretty    := WorkMan.ConvertSecs2ReadableTime((real8)self.total_seconds)
    // ,self.rtotal_secs     := self.total_seconds
    // ,self.rtotal_pretty   := ''
    // ,self                 := left
  // ));

  // dsort := sort(dcopytimes((unsigned)total_seconds > 0),name);
  // diterate := iterate(dsort,transform(recordof(left),self.rtotal_secs := (string)((real8)left.rtotal_secs + (real8)right.rtotal_secs),self.rtotal_pretty := WorkMan.ConvertSecs2ReadableTime((real8)self.rtotal_secs),self := right));

  // dgraphtimes := dcopytimes(regexfind('^graph'  ,name,nocase),subgraphid != '');
  // ddfutimes   := dcopytimes(regexfind('[(]elapsed[)]' ,name,nocase));
  
  // total_time_secs   := thor_time_secs + if(thor_time_secs = 0.0  ,sum(dgraphtimes,(real8)total_seconds) ,0.0) + sum(ddfutimes,(real8)total_seconds);
  // total_time_secs   := thor_time_secs;
  
  // thor_time         := WorkMan.ConvertSecs2ReadableTime(thor_time_secs);
  // total_time        := WorkMan.ConvertSecs2ReadableTime(total_time_secs);
  // total_graph_time  := WorkMan.ConvertSecs2ReadableTime(sum(dgraphtimes,(real8)total_seconds));
  // total_dfu_time    := WorkMan.ConvertSecs2ReadableTime(sum(ddfutimes,(real8)total_seconds));
  
  // output(dcopytimes);
  // output(diterate,all);
// (regexfind('copy.*elapsed',name,nocase))

  // outputdebug := sequential(
     // output(total_thor_time           ,named('total_thor_time'  ))
    // ,output(total_graph_time          ,named('total_graph_time' ))
    // ,output(total_dfu_time            ,named('total_dfu_time'   ))
    // ,output(thor_time                 ,named('thor_time'        ))
    // ,output(total_time                ,named('total_time'       ))
    // ,output(choosen(dtimes      ,1000),named('dtimes'           ),all)
    // ,output(choosen(dcopytimes  ,1000),named('dcopytimes'       ),all)
    // ,output(choosen(dgraphtimes ,1000),named('dgraphtimes'      ),all)
    // ,output(choosen(ddfutimes   ,1000),named('ddfutimes'        ),all)
  // );
  
  // return when(total_time  ,if(pOutputDebug  ,outputdebug));
  
end;