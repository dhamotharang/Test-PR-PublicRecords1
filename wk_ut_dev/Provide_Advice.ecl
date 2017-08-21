EXPORT Provide_Advice(

   pNotifyEvent  
  ,pEventExtraValue
  
) := 
functionmacro

return wk_ut_dev.mac_Notify(pNotifyEvent,pEventExtraValue,'Advice');

endmacro;