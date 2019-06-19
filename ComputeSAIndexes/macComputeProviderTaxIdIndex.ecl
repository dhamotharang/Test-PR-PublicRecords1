EXPORT macComputeProviderTaxIdIndex(dIn, InProviderTaxId, JobId, keyName, GCID) := FUNCTIONMACRO
  LOCAL dInProviderTaxId	:= dIn((string)InProviderTaxId <> '');
  
  LOCAL strKeyName := '~sa::key::' + (STRING)keyName + '::' + (STRING)GCID + '::' + (STRING)JobId;

  LOCAL KeyProviderTaxId := INDEX(dInProviderTaxId, 
    {(string10) InProviderTaxId}, 
    {dInProviderTaxId}, 
    strKeyName);
		
  RETURN KeyProviderTaxId;
ENDMACRO;