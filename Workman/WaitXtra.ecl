/*
  basically waits for the event to trigger, then outputs the eventextra text, then performs a notify.
  only does this once, then exits the scheduler and completes the job.
  I am doing this in it's own wuid because wait() doesn't allow you to get it's eventextra text, only 'when' does(as of 20140725)
  Basically the parent wuid would kick this off in it's own wuid, and then wait for the pNotifyEvent to trigger.
  outside of the build, using the notify function, you would "give advice"(in the eventextra) to the build on what to do at certain points, such as if a wuid fails.
  by outputting that advice, the parent wuid can get that scalar result(the advice) and make decisions based on it
*/
EXPORT WaitXtra(

   pEventName
  ,pEventExtraTag 
  ,pNotifyEvent   
  ,pNamedResult   = '\'Advice\''
	,pESP					  = 'WorkMan._Config.localesp'                	// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242'

) :=
functionmacro

  IsEspLocal := if(   pESP in WorkMan._Config.LocalEsps
                    ,true
                    ,false
                );

  doNotify := if(IsEspLocal ,notify(pNotifyEvent, '*')
                            ,WorkMan.Remote_Notify(pNotifyEvent,pESP)
  );

  returnresult := sequential(

     output(EVENTEXTRA(pEventExtraTag) ,named(pNamedResult),overwrite)
    ,doNotify
  
  ) ;
  
  returnresult : when(pEventName,count(1));
  
  return returnresult;
  
endmacro;

// #workunit('name','Use WAIT(), try to get eventextra--doesnt work');
/*
sequential(
   WAIT('MyService')
  output(eventextra('wuid'))
  );
// ) : when('MyService');

// and a call to the service
NOTIFY('MyService'  ,'<Event><wuid>'+WORKUNIT+'</wuid></Event>');

*/


// sequential(
   // WAIT('MyService')
  // output(eventextra('wuid'))
  // );
// ) : when('MyService',count(1));
// wait('MyService')

// and a call to the service
// NOTIFY(EVENT('MyService'  ,'<Event><wuid>'+WORKUNIT+'</wuid></Event>'),eventextra('wuid'));
// NOTIFY('MyService'  ,'<Event><wuid>'+WORKUNIT+'</wuid></Event>');

/*
  so basically i want to do this:
  kick off wuid
  wait
  check status of wuid
  if failed or aborted
    wait
    get eventextra to figure out what to do next
    if 'move on'
      go to next iteration
    elseif fail
      fail
    else
      rerun iteration
*/