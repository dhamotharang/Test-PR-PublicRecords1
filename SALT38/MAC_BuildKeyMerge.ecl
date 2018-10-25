EXPORT MAC_BuildKeyMerge(dsName, fileNameField, maxCnt, csvSortFields, baseKeyDef) := FUNCTIONMACRO
	#DECLARE (eclText)
	#DECLARE (mergeText)
	#DECLARE (loopCounter)
	#SET (eclText, '');
	#SET (mergeText, '');
	#SET (loopCounter, 2);
	
	#APPEND (eclText, 'dsForMerge1 := INDEX(' + baseKeyDef + ', \'~\' + ' + dsName + '[1].' + fileNameField + ',SORTED);\n');
	#APPEND (mergeText, 'mergeResult := MERGE(dsForMerge1');
	#LOOP
		#IF (%loopCounter% > maxCnt)
			#BREAK
		#ELSE
			#APPEND (mergeText, ', dsForMerge' + %'loopCounter'%);
			#APPEND (eclText, 'dsForMerge' + %'loopCounter'% + ' := IF(COUNT(' + dsName + ') >= ' + %'loopCounter'% + ', INDEX(' + baseKeyDef + ', \'~\' + ' + dsName + '[' + %'loopCounter'% + '].' + fileNameField + ',SORTED));\n');
			#SET (loopCounter, %loopCounter% + 1)
		#END
	#END
	
	#APPEND (mergeText, ', SORTED(' + csvSortFields + '));\n');
	#APPEND (eclText, %'mergeText'%);
	#APPEND (eclText, 'RETURN mergeResult;\n');
	
	%eclText%
ENDMACRO;
