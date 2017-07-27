import wk_ut;
EXPORT mac_Notify(

   pNotifyEvent  
  ,pEventExtraValue    = '\'*\''
  ,pEventExtraTag      = '\'\''   //xml tag without the <>
	,pESP							   = 'wk_ut._constants.localesp'                	// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242'

) :=
functionmacro

  IsEspLocal := if(   pESP in wk_ut._constants.LocalEsps
                    ,true
                    ,false
                );
  
  Event_Extra := map(pEventExtraTag = '' => pEventExtraValue
                    ,                       '<Event><' + pEventExtraTag + '>' + pEventExtraValue + '</' + pEventExtraTag + '></Event>'
                 );
                 
  doNotify := if(IsEspLocal ,notify(pNotifyEvent, Event_Extra)
                            ,wk_ut.Remote_Notify(pNotifyEvent,pESP,Event_Extra)
  );

  return doNotify;

endmacro;