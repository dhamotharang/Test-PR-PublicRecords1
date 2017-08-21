export translate_source(

	string2 source
	
) :=
function
	
	LOADXML('<xml/>');

	dsources := lbentley.sourcetools.dSource_Codes;
	
	#IF (%'SourceDatasetMetaInfo'%='')
	 #DECLARE(SourceDatasetMetaInfo)
	#END

	#EXPORT(SourceDatasetMetaInfo, dsources)

	return %'SourceDatasetMetaInfo'%;
	
end;
/*
		export TranslateSource(string2 pSource) :=
	case(pSource
		,src_ACA                       => 'American Correctional Association'                         
		,src_Accurint_Arrest_Log       => 'Accurint Arrest Log'                                       
		,src_Accurint_Crim_Court       => 'Accurint Crim Court'                                       

export CleanFields(inputFile,outputFile) := macro
LOADXML('<xml/>');

#EXPORTXML(doCleanFieldMetaInfo, recordof(inputFile))

#uniquename (myCleanFunction)
string %myCleanFunction%(string x) := regexreplace('[^ -~]+',x,'');

#uniquename (tra)
inputFile %tra%(inputFile le) :=
TRANSFORM

#IF (%'doCleanFieldText'%='')
 #DECLARE(doCleanFieldText)
#END
#SET (doCleanFieldText, false)
#FOR (doCleanFieldMetaInfo)
 #FOR (Field)
  #IF (%'@type'% = 'string')
	#SET (doCleanFieldText, 'SELF.' + %'@name'%)
    #APPEND (doCleanFieldText, ':= ' + %'myCleanFunction'% + '(le.')
	#APPEND (doCleanFieldText, %'@name'%)
	#APPEND (doCleanFieldText, ')')
 	%doCleanFieldText%;
  #END
 #END
#END
	SELF := le;
END;

outputFile := PROJECT(inputFile, %tra%(LEFT));

endmacro;
*/