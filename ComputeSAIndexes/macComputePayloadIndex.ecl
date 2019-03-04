EXPORT macComputePayloadIndex(dIn, InRecordId, JobId, keyName, GCID) := FUNCTIONMACRO
	LOCAL dInPayload	:= dIn;
  
  LOCAL strKeyName  := '~sa::key::' + (STRING)keyName + '::' + (STRING)GCID + '::' + (STRING)JobId;

	LOCAL KeyPayload	:= INDEX(dInPayload, 
		{(unsigned8) InRecordId}, 
		{dInPayload}, 
    strKeyName);
		
	RETURN KeyPayload;
ENDMACRO;