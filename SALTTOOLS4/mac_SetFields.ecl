/*
	Get Fieldnames in Set -- returns set of fields from layout
	Example:
	doesbdidexist := SALTTOOLS4.mac_SetFields(DCAV2.Layouts.base.companies	,'rid');
	output(doesbdidexist	,named('doesbdidexist'));
	Similar to SALTTOOLS4.mac_GetFieldType, but that returns the type if the field exists, this returns the fields that don't exist
*/
export mac_SetFields(
	 pLayout										// input layout(if using in macro, this will be meta data from #exportxml)
	,pFilterRegex			= '\'\''	// Set of Fields to search for in the above layout
	,pForUseInMacro		= 'false'	// is output going to be used in a macro(then use set command), otherwise, just :=
	,pForceLoadXml		= 'false'	// force use loadxml
	
) :=
functionmacro
	/////////////////////////////////////////////
	// -- Start XML
	/////////////////////////////////////////////
	#IF(pForUseInMacro	= false or pForceLoadXml = true)
		LOADXML('<xml/>');
		#EXPORTXML(pLayout_MetaInfo							,pLayout)
	#END
	#uniquename(name								)
	#uniquename(named_layout				)
	#uniquename(moutput							)
	#uniquename(lsize								)
	#uniquename(lSetFieldsDontExist	)
	#uniquename(lcountSetFields			)
	#uniquename(lcounter						)
	#uniquename(lFoundField					)
	#uniquename(lFirstField					)
	#uniquename(lcomma							)
	#uniquename(lItem								)
	#uniquename(lSetFields					)
	#IF(pForUseInMacro = true)
		#uniquename(pOutput)
	#END
	#SET(lcounter		,1);
	
	#SET(moutput	,'[')
	#SET(named_layout	, '')
	#SET(name					, '')
	#SET(lSetFieldsDontExist	, '[')
	#SET(lFirstField	, true)
	#SET(lcomma	,' ')
	#IF(pForUseInMacro	= true and pForceLoadXml = false)
		#FOR (pLayout)
			#FOR (Field)
				#IF(%'@isRecord'% = '1')
					#SET(named_layout, %'@name'%)
				#ELSE
					#IF(%'named_layout'% = %'@name'% and %'@type'% = '')
						#SET(named_layout, '')
					#ELSE
						#IF(%'named_layout'% != '')
							#SET(name, %'named_layout'% + '.' + %'@name'%)
						#ELSE
							#SET(name			, %'@name'%)
						#END
						
						#IF(pFilterRegex = '' or regexfind(pFilterRegex,trim(%'name'%,left,right),nocase))		
							#SET(lItem	,%'name'%)
						#ELSE
							#SET(lItem	,'')
						#END
						#IF(%'lItem'% != '')
							#IF(%lFirstField%	= true) #SET(lcomma	,' ') #SET(lFirstField	,false) #ELSE #SET(lcomma	,',')	#END
							#APPEND(moutput	,%'lcomma'% + '\'' + %'lItem'%+ '\'')
							#SET(lcounter	,%lcounter% + 1)
						#END
					#END
				#END
			#END	//for field loop
		#END	// for playout loop
	#ELSE	
		#FOR (pLayout_MetaInfo)
			#FOR (Field)
				#IF(%'@isRecord'% = '1')
					#SET(named_layout, %'@name'%)
				#ELSE
					#IF(%'named_layout'% = %'@name'% and %'@type'% = '')
						#SET(named_layout, '')
					#ELSE
						#IF(%'named_layout'% != '')
							#SET(name, %'named_layout'% + '.' + %'@name'%)
						#ELSE
							#SET(name			, %'@name'%)
						#END
						
						#IF(pFilterRegex = '' or regexfind(pFilterRegex,trim(%'name'%,left,right),nocase))		
							#SET(lItem	,%'name'%)
						#ELSE
							#SET(lItem	,'')
						#END
						#IF(%'lItem'% != '')
							#IF(%lFirstField%	= true) #SET(lcomma	,' ') #SET(lFirstField	,false) #ELSE #SET(lcomma	,',')	#END
							#APPEND(moutput	,%'lcomma'% + '\'' + %'lItem'%+ '\'')
							#SET(lcounter	,%lcounter% + 1)
						#END
					#END
				#END
			#END	// for field loop
		#END	// for pLayout_MetaInfo loop
	#END	// if pForUseInMacro
	#APPEND(moutput	,']')
	
	#IF(pForUseInMacro = true)
		return %'moutput'%;
	#ELSE
		return %moutput%;
	#END
endmacro;
