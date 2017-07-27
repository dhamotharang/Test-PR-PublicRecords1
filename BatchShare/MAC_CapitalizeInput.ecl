// **************************************************
// A Macro to capitalize *ALL* string type fields found
//  in the provided input dataset.
// **************************************************
export	MAC_CapitalizeInput(inf,outf)	:=
macro
	LOADXML('<xml/>');

	#EXPORTXML(doCapitalizeFieldMetaInfo,recordof(inf))

	#uniquename (myCapFunction)
	string %myCapFunction%(string x) := StringLib.StringToUpperCase(trim(x));

	#uniquename(tra)
	inf	%tra%(inf	le)	:=
	TRANSFORM		
		#IF(%'doCapitalizeFieldText'%='')
			#DECLARE(doCapitalizeFieldText)
		#END
		
		#SET(doCapitalizeFieldText, false)
		
		#FOR(doCapitalizeFieldMetaInfo)
			#FOR(Field)
				#IF(%'@type'%	=	'string')
					#SET(doCapitalizeFieldText,'SELF.'	+	%'@name'%)
					#APPEND(doCapitalizeFieldText,'	:=	'	+	%'myCapFunction'% + '(le.')
					#APPEND(doCapitalizeFieldText,%'@name'%)
					#APPEND(doCapitalizeFieldText,')')
					%doCapitalizeFieldText%;
				#END
			#END
		#END
		SELF	:=	le;
	END;

	outf	:=	PROJECT(inf,%tra%(LEFT));
endmacro;

