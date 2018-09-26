EXPORT macComputeAccountIndex(dIn, InAccount, InJobId) := FUNCTIONMACRO
  
  LOCAL strKeyName      := '~biz::key::account::' + (STRING)InJobId;
	LOCAL KeyAccount 			:= INDEX(dIn, {(STRING200)InAccount}, {dIn}, strKeyName);
		
  RETURN KeyAccount;
ENDMACRO;