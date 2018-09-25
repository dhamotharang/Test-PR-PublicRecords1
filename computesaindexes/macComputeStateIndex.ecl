EXPORT macComputeStateIndex(dIn, InState, JobId, KeyName, GCID) := FUNCTIONMACRO
	LOCAL dInState := dIn(InState <> '');  
  
  LOCAL strKeyName   := '~sa::key::' + (STRING)KeyName + '::' + (STRING)GCID + '::' + (STRING)JobId;
	
	LOCAL KeyState := INDEX(dInState, 
		{(string2)InState}, 
		{dInState}, 
    strKeyName);
		
	RETURN KeyState;
ENDMACRO;