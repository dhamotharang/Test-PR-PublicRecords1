//Convert all the string fields in a file to Upper case. 
export mac_UpperCase(inputFile, outputFile) := macro

import STD;
                loadxml('<xml/>');

		#exportxml(doCleanFieldMetaInfo, recordof(inputFile))
		
/* 		#uniquename(myCleanFunctionUTF)																							
   		UTF8 %myCleanFunctionUTF%(utf8 x) := STD.Uni.CleanSpaces(STD.Uni.ToUpperCase(x));
*/
		#uniquename(myCleanFunctionSTR)																							
		string %myCleanFunctionSTR%(string x) := STD.Str.CleanSpaces(STD.Str.ToUpperCase(x));
		
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
			#set (doCleanFieldText, 'self.' + %'@name'%)
				#append (doCleanFieldText, ':= ' + %'myCleanFunctionSTR'% + '(le.')
			#append (doCleanFieldText, %'@name'%)
			#append (doCleanFieldText, ');\n')
			%doCleanFieldText%;
			#end
/* 			#if (%'@type'% = 'utf')
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

endmacro;