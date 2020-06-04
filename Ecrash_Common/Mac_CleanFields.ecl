//Clean up all string fields in a file. Add values to myCleanFunction map statement. Alpharetta Dev Test - W20150826-171535

EXPORT Mac_CleanFields(inputFile,outputFile) := MACRO

		LOADXML('<xml/>');

		#EXPORTXML(doCleanFieldMetaInfo, RECORDOF(inputFile))
		
		#uniquename(myCleanFunctionUTF)																							
		UTF8 %myCleanFunctionUTF%(utf8 x) := MAP(x IN [U'\\N', U'NULL', U'NUL', U'null']  => U'', 
																						 x+'N' = U'\\N' => U'',
																						 x);
		#uniquename(myCleanFunctionSTR)																							
		string %myCleanFunctionSTR%(string x) := MAP(x IN ['\\N', 'NULL', 'NUL', 'null'] => '', 
																							   x+'N' = '\\N' => '',
																							   x);
		
		#uniquename(tra)
		inputFile %tra%(inputFile le) :=
		TRANSFORM

		#IF (%'doCleanFieldText'%='')
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
			#IF (%'@type'% = 'utf')
			#SET (doCleanFieldText, 'SELF.' + %'@name'%)
				#APPEND (doCleanFieldText, ':= ' + %'myCleanFunctionUTF'% + '(le.')
			#APPEND (doCleanFieldText, %'@name'%)
			#APPEND (doCleanFieldText, ');\n')
			%doCleanFieldText%;
			#END
		 #END
		#END
			SELF := le;
END;

outputFile := PROJECT(inputFile, %tra%(LEFT));

ENDMACRO;
