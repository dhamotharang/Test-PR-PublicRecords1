EXPORT Push_Event_Result_Link(
   string pEventName
  ,string pAdvice 
  ,string pESP        = WorkMan._Config.LocalEsp           
) := 
// 'http://' + pESP + ':8010/WsWorkunits/WUShowScheduled?PushEventName=' + pEventName + '&PushEventText=%3CEvent%3E%3CAdvice%3E' + pAdvice + '%3C/Advice%3E%3C/Event%3E';
'http://' + pESP + ':8010/WsWorkunits/WUPushEvent?EventName=' + pEventName + '&EventText=%3CEvent%3E%3CAdvice%3E' + pAdvice + '%3C/Advice%3E%3C/Event%3E';

// http://10.241.12.207:8010/WsWorkunits/WUPushEvent?EventName=__WAIT4MASTEREVENT__55610__&EventText=%3CEvent%3E%3CAdvice%3ERerun%3C%2FAdvice%3E%3C%2FEvent%3E  -- works