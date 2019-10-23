import WorkMan;
EXPORT mac_Notify(

   pNotifyEvent  
  ,pEventExtraValue    = '\'*\''
  ,pEventExtraTag      = '\'\''   //xml tag without the <>
	,pESP							   = 'WorkMan._Config.localesp'                	// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242'

) :=
functionmacro

  IsEspLocal := if(   pESP in WorkMan._Config.LocalEsps
                    ,true
                    ,false
                );
  
  Event_Extra := map(pEventExtraTag = '' => pEventExtraValue
                    ,                       '<Event><' + pEventExtraTag + '>' + pEventExtraValue + '</' + pEventExtraTag + '></Event>'
                 );
                 
  doNotify := if(IsEspLocal ,notify(pNotifyEvent, Event_Extra)
                            ,WorkMan.Remote_Notify(pNotifyEvent,pESP,Event_Extra)
  );

  return doNotify;

endmacro;