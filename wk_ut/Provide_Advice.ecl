EXPORT Provide_Advice(

   pNotifyEvent  
  ,pEventExtraValue
  
) := 
functionmacro

return wk_ut.mac_Notify(pNotifyEvent,pEventExtraValue,'Advice');

endmacro;