EXPORT Provide_Advice(

   pNotifyEvent  
  ,pEventExtraValue
  
) := 
functionmacro

return WorkMan.mac_Notify(pNotifyEvent,pEventExtraValue,'Advice');

endmacro;