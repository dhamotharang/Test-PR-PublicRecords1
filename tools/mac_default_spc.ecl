EXPORT MAC_Default_SPC(inputFile,outputFile) := MACRO
#uniquename(bneg)
%bneg%(STRING S) := IF ((INTEGER)S>0,S,'');
LOADXML('<xml/>');
#EXPORTXML(doCleanFieldMetaInfo, recordof(inputFile))
#uniquename(name							)
#uniquename(named_layout			)
#SET(named_layout	, '')
#SET(name					, '')

outputFile := dataset([{'MODULE:<EnterModuleNameHere>',''},{'FILENAME:<FileName>',''},{'//Uncomment up to NINES for internal or external adl',''},
{'//IDFIELD:EXISTS:<NameOfIDField>',''},{'//RIDFIELD:<NameOfRidField>',''},{'//RECORDS:<NumberOfRecordsInDataFile>',''},{'//POPULATION:<ExpectedNumberOfEntitiesInDataFile>',''},
{'//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>',''},{'//Uncomment Process if doing external adl',''},{'//PROCESS:<ProcessName>',''},
{'//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields',''},
{'//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking',''},
{'//FUZZY can be used to create new types of FUZZY linking',''},
#IF (%'doCleanFieldText'%='')
 #DECLARE(doCleanFieldText)
#END
#SET (doCleanFieldText, false)
#FOR (doCleanFieldMetaInfo)
 #FOR (Field)
			#IF(%'@isRecord'% = '1' or %'@isDataset'% = '1')
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
	#SET (doCleanFieldText, 'FIELD:' + %'name'% + ':TYPE(' + Stringlib.StringToUpperCase(%'@type'%) + %bneg%(%'@size'%) + '):0,0')
//	#SET (doCleanFieldText, 'FIELD:' + %'@name'% + ':0,0')
	{%'doCleanFieldText'%,%'name'%},
 #END
#END
#END
#END
{'//CONCEPT statements should be used to group together interellated fields; such as address',''},
{'//RELATIONSHIP is used to find non-obvious relationships between the clusters',''},
{'//SOURCEFIELD is used if a field of the file denotes a source of the records in that file',''},
{'//LINKPATH is used to define access paths for external linking',''}
],{string s,string fieldname});
endmacro;
