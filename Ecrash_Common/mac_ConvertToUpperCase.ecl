IMPORT STD;
//Convert all the string fields in a file to Upper case. 

EXPORT Mac_ConvertToUpperCase(inputFile, outputFile) := MACRO;
IMPORT STD;
LOADXML('<xml/>');

		#EXPORTXML(doCleanFieldMetaInfo, RECORDOF(inputFile))
		
/* 		#uniquename(myCleanFunctionUTF)																							
   		UTF8 %myCleanFunctionUTF%(utf8 x) := STD.Uni.ToUpperCase(x);
*/
		#uniquename(myCleanFunctionSTR)																							
		string %myCleanFunctionSTR%(string x) := STD.Str.ToUpperCase(x);
		
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
/* 			#IF (%'@type'% = 'utf')
   			#SET (doCleanFieldText, 'SELF.' + %'@name'%)
   				#APPEND (doCleanFieldText, ':= ' + %'myCleanFunctionUTF'% + '(le.')
   			#APPEND (doCleanFieldText, %'@name'%)
   			#APPEND (doCleanFieldText, ');\n')
   			%doCleanFieldText%;
   			#END
*/
		 #END
		#END
			SELF := le;
END;

outputFile := PROJECT(inputFile, %tra%(LEFT));

ENDMACRO;