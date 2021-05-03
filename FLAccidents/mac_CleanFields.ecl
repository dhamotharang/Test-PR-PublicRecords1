export mac_CleanFields(inputFile,outputFile) := macro

		loadxml('<xml/>');

		#exportxml(doCleanFieldMetaInfo, recordof(inputFile))
		
/*              #uniquename(myCleanFunctionUTF)																							
                UTF8 %myCleanFunctionUTF%(utf8 x)     := map(x in [U'\\N', U'NULL', U'null', U'Null']  => U'', 
                 				             x+'N' = U'\\N'                            => U'',
							     x);
*/							     
		#uniquename(myCleanFunctionSTR)																							
		string %myCleanFunctionSTR%(string x) := map(x in ['\\N', 'NULL', 'null', 'Null'] => '', 
							     x+'N' = '\\N'                        => '',
							     x);
		
		#uniquename(tra)
		inputFile %tra%(inputFile le) :=
		transform

		#if (%'doCleanFieldText'%='')
		 #declare(doCleanFieldText)
		#end
		#set (doCleanFieldText, false)
		#for (doCleanFieldMetaInfo)
		 #for (Field)
			#if (%'@type'% = 'string')
			#set (doCleanFieldText, 'SELF.' + %'@name'%)
				#append (doCleanFieldText, ':= ' + %'myCleanFunctionSTR'% + '(le.')
			#append (doCleanFieldText, %'@name'%)
			#append (doCleanFieldText, ');\n')
			%doCleanFieldText%;
			#end
/*
			#if (%'@type'% = 'utf')
			#set (doCleanFieldText, 'self.' + %'@name'%)
				#append (doCleanFieldText, ':= ' + %'myCleanFunctionUTF'% + '(le.')
			#append (doCleanFieldText, %'@name'%)
			#append (doCleanFieldText, ');\n')
			%doCleanFieldText%;
			#end
*/
		 #end
		#end
			self := le;
end;

outputFile := project(inputFile, %tra%(left));

ENDMACRO;