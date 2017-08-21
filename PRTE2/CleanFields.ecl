/*Similar to ut.CleanFields macro but that function does not perform uppercase on each field */

EXPORT CleanFields(pInputFile,pOutputFile)	:= macro
		LOADXML('<xml/>');

		#EXPORTXML(doCleanFieldMetaInfo,recordof(pInputFile))

		#uniquename(myCleanFunction)
		string	%myCleanFunction%(string	x)	:=	ut.CleanSpacesAndUpper(std.str.CleanSpaces(regexreplace('[^ -~]+',x,' ')));

		#uniquename(tra)
		pInputFile	%tra%(pInputFile	le)	:=
		TRANSFORM
			#IF(%'doCleanFieldText'%='')
				#DECLARE(doCleanField)
				#DECLARE(doCleanFieldText)
			#END
			
			#SET(doCleanField,true)
			#SET(doCleanFieldText,false)
			
			#FOR(doCleanFieldMetaInfo)
				#FOR(Field)
					#IF(regexfind('[0-9]+',%'@isDataset'%))
						#SET(doCleanField,false)
						#APPEND(doCleanFieldText,'')
					#ELSEIF(regexfind('[0-9]+',%'@isEnd'%))
						#SET(doCleanField,true)
						#APPEND(doCleanFieldText,'')
					#ELSEIF(%doCleanField%	and	%'@type'%	=	'string')
						#SET(doCleanFieldText,'SELF.'	+	%'@name'%)
						#APPEND(doCleanFieldText,'	:=	'	+	%'myCleanFunction'%	+	'(le.')
						#APPEND(doCleanFieldText,%'@name'%)
						#APPEND(doCleanFieldText,')')
						%doCleanFieldText%;
					#ELSE
						#APPEND(doCleanFieldText,'')
					#END
				#END
			#END
			SELF	:=	le;
		END;
		
		pOutputFile	:=	PROJECT(pInputFile,%tra%(LEFT));
	endmacro;