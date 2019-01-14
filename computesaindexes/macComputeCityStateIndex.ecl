EXPORT macComputeCityStateIndex(dIn, InCity, InState, JobId, keyName, GCID) := FUNCTIONMACRO
	LOCAL dInCityState := dIn(InCity <> '' AND InState <> '');  
  
  LOCAL strKeyName   := '~sa::key::' + (STRING)keyName + '::' + (STRING)GCID + '::' + (STRING)JobId;
	
	LOCAL KeyCityState := INDEX(dInCityState, 
		{(string25)InCity, (string2)InState}, 
		{dInCityState}, 
    strKeyName);
		
	RETURN KeyCityState;
ENDMACRO;