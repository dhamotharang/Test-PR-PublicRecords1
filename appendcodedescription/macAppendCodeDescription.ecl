EXPORT macAppendCodeDescription(dIn, codeField, descriptionField, dictIn, dictDescription) := FUNCTIONMACRO
	rOut := record
		RECORDOF(dIn);
		string descriptionField;
	end;
	
	dOut := PROJECT(dIn, 
		TRANSFORM(rOut,
			SELF.descriptionField := dictIn[(STRING)LEFT.codeField].dictDescription;
			SELF := LEFT));
			
	RETURN dOut;
ENDMACRO;