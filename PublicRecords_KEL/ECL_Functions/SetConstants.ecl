EXPORT SetConstants := MODULE
  EXPORT IsBlank(STRING FieldToCheck, STRING DefaultVal) := IF(FieldToCheck = '', DefaultVal, FieldToCheck);
	
	EXPORT IsBlank2Fields(STRING Field1ToCheck, STRING Default1Val, STRING Field2ToCheck, STRING Default2Val) :=
				IF(Field1ToCheck = '', 
					Default1Val, 
					IF(Field2ToCheck = '', Default2Val, Field2ToCheck));
END;