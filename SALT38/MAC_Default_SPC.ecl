EXPORT MAC_Default_SPC(inputFile,outputFile) := MACRO
#uniquename(bneg)
%bneg%(STRING S) := IF ((INTEGER)S>0,S,'');
LOADXML('<xml/>');
#EXPORTXML(doCleanFieldMetaInfo, recordof(inputFile))
outputFile := dataset([
'OPTIONS:-gh',
'MODULE:<EnterModuleNameHere>',
'FILENAME:<FileName>',
'',
'// Uncomment up to NINES for internal or external adl',
'// IDFIELD:EXISTS:<NameOfIDField>',
'// RIDFIELD:<NameOfRidField>',
'// RECORDS:<NumberOfRecordsInDataFile>',
'// POPULATION:<ExpectedNumberOfEntitiesInDataFile>',
'// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>',
'',
'// Uncomment Process if doing external adl',
'// PROCESS:<ProcessName>',
'',
'// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields',
'// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking',
'// FUZZY can be used to create new types of FUZZY linking',
'',
'// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.',
'// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running',
'// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.',
'',
#IF (%'doCleanFieldText'%='')
	#DECLARE(doCleanFieldText)
#END
#SET (doCleanFieldText, false)
#FOR (doCleanFieldMetaInfo)
	#DECLARE(thisChild)
	#SET(thisChild,'')
	#DECLARE(thisRec)
	#SET(thisRec,'')
	#FOR (Field)
		#IF(%'@isDataset'%='1')
			#SET(thisChild,%'@name'%)
		#ELSEIF(%'@isRecord'%='1')
			#SET(thisRec,%'@name'%+'.')
		#ELSEIF(%'@isEnd'%='1')
			#SET(thisChild,'')
			#SET(thisRec,'')
		#ELSE
			#DECLARE(thisSize)
			#IF(%@size% > 0 and %'@type'% = 'unicode')
				#SET(thisSize, (INTEGER)(%@size%/2))
			#ELSEIF(%@size% > 0 and %'@type'% = 'varunicode')
				#SET(thisSize, (INTEGER)((%@size%-2)/2))		
			#ELSE
				#SET(thisSize,%@size%)
			#END
			#IF(%'thisChild'%='')
				#SET (doCleanFieldText, 'FIELD:' + %'thisRec'% + %'@name'% + ':TYPE(' + Stringlib.StringToUpperCase(%'@type'%) + %bneg%(%'thisSize'%) + '):0,0')
			#ELSE
				#SET (doCleanFieldText, 'FIELD:' + %'@name'% + ':MULTIPLE(LIST(' + %'thisChild'% + '),ANY):KEEP(2):TYPE(' + Stringlib.StringToUpperCase(%'@type'%) + %bneg%(%'thisSize'%) + '):0,0')
			#END
			%'doCleanFieldText'%,
		#END
	#END
#END
'',
'// CONCEPT statements should be used to group together interellated fields; such as address',
'// RELATIONSHIP is used to find non-obvious relationships between the clusters',
'// SOURCEFIELD is used if a field of the file denotes a source of the records in that file',
'// LINKPATH is used to define access paths for external linking'
],{STRING s});
ENDMACRO;
