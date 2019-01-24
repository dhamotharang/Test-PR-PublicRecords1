﻿IMPORT STD, SALT38, SALTRoutines;
FieldTypeLayout := RECORD
	UNSIGNED8 Field_Number;
	STRING Field_Name;
	STRING Potential_KEL_Field_Type;
	STRING Potential_ECL_Field_Type;
	RECORDOF(SALT38.MAC_Character_Counts.ResultLine_Layout) - cardinality - minval30 - maxval30 - asnumber_minval - asnumber_maxval - asnumber_mean - asnumber_var - len - words - characters - fldno - fieldname;
END;
EXPORT SALT_Profile_Produce_ENTITY(DATASET(FieldTypeLayout) FieldTypes, INTEGER NumberOfDataPatternsToShow = 5, INTEGER NumberOfFrequentTermsToShow = 3) := FUNCTION
	populatedFields := FieldTypes (TRIM(Potential_KEL_Field_Type) != 'Never Populated: STRING' AND TRIM(Potential_KEL_Field_Type) != 'Never Populated: INTEGER');
	
	ResultLayout := RECORD
		UNSIGNED8 LineNumber;
		STRING Line;
	END;
	
	ResultLayout intoENTITY(RECORDOF(FieldTypes) le, UNSIGNED8 cntr) := TRANSFORM
		SELF.LineNumber := cntr;
		
		FieldType := STD.Str.FindReplace(STD.Str.FindReplace(le.Potential_KEL_Field_Type, 'Unknown: ', ''), ' or STRING', '');
		FieldName := STD.Str.ToTitleCase(STD.Str.FindReplace(STD.Str.FindReplace(le.Field_Name, '__', ' '), '_', ' '));
		NullType := CASE(FieldType,
			'BOOLEAN'	=> '',
			'STRING'	=> '=NULL(\'\')',
			'DATE'		=> '',
			'INTEGER'	=> '=NULL(0)',
			'REAL'		=> '=NULL(R\'0.0\')',
							'');
		
		SELF.Line := TRIM(FieldType) + ' ' + TRIM(FieldName, ALL) + TRIM(NullType) + ',';
	END;
	
	ResultLayout intoUSE(RECORDOF(FieldTypes) le, UNSIGNED8 cntr) := TRANSFORM
		SELF.LineNumber := 90004 + cntr;
		
		FieldName := STD.Str.ToTitleCase(STD.Str.FindReplace(STD.Str.FindReplace(le.Field_Name, '__', ' '), '_', ' '));
		FieldMapping := STD.Str.FindReplace(le.Field_Name, '__', '.');
		SELF.Line := TRIM(FieldName, ALL) + ' = ' + TRIM(FieldMapping) + ',';
	END;
	
	head := DATASET([{0, '// ----- ENTITY Fields -----'}], ResultLayout);
	entity := PROJECT(populatedFields, intoENTITY(LEFT, COUNTER));
	
	mid := DATASET([{90000, ''}, {90001, ''}, {90002, ''}, {90003, '// ----- USE Mappings -----'}], ResultLayout);
	use := PROJECT(populatedFields, intoUSE(LEFT, COUNTER));
	
	result := PROJECT(SORT(head + entity + mid + use, LineNumber), TRANSFORM(RECORDOF(LEFT) - LineNumber, SELF := LEFT));
	
	RETURN result;
END;