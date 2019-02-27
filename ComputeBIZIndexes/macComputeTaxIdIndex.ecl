EXPORT macComputeTaxIdIndex(dIn, InTaxId, InJobId, keyName) := FUNCTIONMACRO
	LOCAL dInTaxId	:= dIn((integer)InTaxId <> 0);
  
  LOCAL strKeyName      := '~biz::key::' + (STRING)keyName + 'taxid::' + (STRING)InJobId;
	LOCAL KeyTaxId			:= INDEX(dInTaxId, 
		{(string9) InTaxId}, 
		{dInTaxId}, 
    strKeyName);
		
	RETURN KeyTaxId;
ENDMACRO;