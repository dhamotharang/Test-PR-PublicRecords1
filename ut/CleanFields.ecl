export	CleanFields(inputFile,outputFile)	:=
macro
	LOADXML('<xml/>');

	#EXPORTXML(doCleanFieldMetaInfo,recordof(inputFile))

	#uniquename(myCleanFunction)
	string	%myCleanFunction%(string	x)	:=	stringlib.stringcleanspaces(regexreplace('[^ -~]+',x,' '));

	#uniquename(tra)
	inputFile	%tra%(inputFile	le)	:=
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
	
	outputFile	:=	PROJECT(inputFile,%tra%(LEFT));
endmacro;