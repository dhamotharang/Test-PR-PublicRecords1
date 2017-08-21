// macro to produce a comma-delimited list of field names from an input dataset
// will skip any fields in exceptFields, which is expected to be a SET OF STRING with UPPERCASE values
// Example:
// MAC_FieldListCSV(myDS, ['MYFIELD1','MYFIELD2'], ',');
EXPORT MAC_FieldListCSVFromDataset(dsIn, exceptFields, delimiter) := FUNCTIONMACRO
	#EXPORTXML(recXML, RECORDOF(dsIn));
	#DECLARE(outFieldList)
	#SET(outFieldList, '' )
	#FOR (recXML)
		#FOR (Field)
			#APPEND(outFieldList, IF(STD.Str.ToUppercase(%'{@name}'%) NOT IN exceptFields, %'{@name}'% + delimiter, ''))
		#END
	#END
	returnLength := LENGTH(%'outFieldList'%) - LENGTH(delimiter);
	RETURN %'outFieldList'%[1..returnLength];
ENDMACRO;
