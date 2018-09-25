EXPORT macComputePayloadIndex(dIn, InRecordId, InJobId) := FUNCTIONMACRO

  LOCAL strKeyName      := '~biz::key::payload::' + (STRING)InJobId;
	LOCAL KeyPayload 			:= INDEX(dIn, {(INTEGER)InRecordId}, {dIn}, strKeyName);
		
  RETURN KeyPayload;
ENDMACRO;