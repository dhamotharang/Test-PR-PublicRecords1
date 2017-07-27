EXPORT MAC_Default_SPC(inputFile,outputFile) := MACRO
#uniquename(bneg)
%bneg%(STRING S) := IF ((INTEGER)S>0,S,'');
LOADXML('<xml/>');
#EXPORTXML(doCleanFieldMetaInfo, recordof(inputFile))
outputFile := dataset(['MODULE:<EnterModuleNameHere>','FILENAME:<FileName>','//Uncomment up to NINES for internal or external adl',
'//IDFIELD:EXISTS:<NameOfIDField>','//RIDFIELD:<NameOfRidField>','//RECORDS:<NumberOfRecordsInDataFile>','//POPULATION:<ExpectedNumberOfEntitiesInDataFile>',
'//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>','//Uncomment Process if doing external adl','//PROCESS:<ProcessName>',
'//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields',
'//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking',
'//FUZZY can be used to create new types of FUZZY linking',
#IF (%'doCleanFieldText'%='')
 #DECLARE(doCleanFieldText)
#END
#SET (doCleanFieldText, false)
#FOR (doCleanFieldMetaInfo)
 #FOR (Field)
 	#DECLARE(thisSize)
	#IF(%@size% > 0 and %'@type'% = 'unicode')
		#SET(thisSize, (INTEGER)(%@size%/2))
	#ELSEIF(%@size% > 0 and %'@type'% = 'varunicode')
		#SET(thisSize, (INTEGER)((%@size%-2)/2))		
	#ELSE
		#SET(thisSize,%@size%)
	#END 
	#SET (doCleanFieldText, 'FIELD:' + %'@name'% + ':TYPE(' + Stringlib.StringToUpperCase(%'@type'%) + %bneg%(%'thisSize'%) + '):0,0')
//	#SET (doCleanFieldText, 'FIELD:' + %'@name'% + ':0,0')
	%'doCleanFieldText'%,
 #END
#END
'//CONCEPT statements should be used to group together interellated fields; such as address',
'//RELATIONSHIP is used to find non-obvious relationships between the clusters',
'//SOURCEFIELD is used if a field of the file denotes a source of the records in that file',
'//LINKPATH is used to define access paths for external linking'
],{STRING s});
ENDMACRO;
