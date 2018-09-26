//FUNCTIONMACRO didn't allow to return a DICTIONARY
EXPORT macComputeDictionary(dIn, codeField, descriptionField, dictOut) := MACRO
	LOCAL rCodeDescription := RECORD
		STRING Code;
		STRING Description;
	END;
	
	LOCAL dCodeDescription := PROJECT(dIn,
		TRANSFORM(rCodeDescription,
			SELF.Code 				:= (STRING)LEFT.CodeField,
			SELF.Description 	:= (STRING)LEFT.DescriptionField));
	
	dictOut := DICTIONARY(dCodeDescription,{Code => Description});
ENDMACRO;