EXPORT mac_CleanFields(InputFile, OutputFile) := MACRO
	IMPORT STD;
	LOADXML('<xml/>');
	
	#EXPORTXML(doCleanFieldMetaInfo, RECORDOF(InputFile))

/* #UNIQUENAME(myCleanFunctionUTF)																							
   UTF8 %myCleanFunctionUTF%(UTF8 x) := MAP(x in [U'\\N', U'NULL', U'null', U'Null']  => U'', 
                 				                    x + 'N' = U'\\N' => U'',
							                              x);
*/							     
	#UNIQUENAME(myCleanFunctionSTR)																							
	STRING %myCleanFunctionSTR%(STRING x) := MAP(STD.Str.ToUpperCase(x) IN ['\\N', 'NULL', 'NUL'] => '', 
							                                 x + 'N' = '\\N' => '',
							                                 x);		
	#UNIQUENAME(tra)
	InputFile %tra%(InputFile le) := TRANSFORM
		#IF (%'doCleanFieldText'% = '')
		 #DECLARE(doCleanFieldText)
		#END
		#SET (doCleanFieldText, FALSE)
		#FOR (doCleanFieldMetaInfo)
		 #FOR (Field)
		#IF (%'@type'% = 'string')
			#SET (doCleanFieldText, 'SELF.' + %'@name'%)
				#APPEND (doCleanFieldText, ':= ' + %'myCleanFunctionSTR'% + '(le.')
			#APPEND (doCleanFieldText, %'@name'%)
			#APPEND (doCleanFieldText, ');\n')
			%doCleanFieldText%;
	  #END
/*
			#IF (%'@type'% = 'utf')
			#SET (doCleanFieldText, 'SELF.' + %'@name'%)
				#APPEND (doCleanFieldText, ':= ' + %'myCleanFunctionUTF'% + '(le.')
			#APPEND (doCleanFieldText, %'@name'%)
			#APPEND (doCleanFieldText, ');\n')
			%doCleanFieldText%;
			#end
*/
		 #END
		#END
		SELF := le;
  END;
OutputFile := PROJECT(InputFile, %tra%(LEFT));

ENDMACRO;