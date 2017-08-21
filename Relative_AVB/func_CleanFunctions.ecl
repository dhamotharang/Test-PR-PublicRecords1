EXPORT func_CleanFunctions() := MODULE


export CleanFields(inputFile,outputFile) := macro

		LOADXML('<xml/>');

		#EXPORTXML(doCleanFieldMetaInfo, recordof(inputFile))

		#uniquename(myCleanFunction)

		string %myCleanFunction%(string x) := trim(stringlib.stringcleanspaces(x), left, right);

		#uniquename(tra)
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
			#APPEND (doCleanFieldText, ');\n')
			%doCleanFieldText%;
			#END
		 #END
		#END
			SELF := le;
END;

outputFile := PROJECT(inputFile, %tra%(LEFT));

endmacro;

END;