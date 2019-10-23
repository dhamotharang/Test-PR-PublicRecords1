EXPORT mod_Delta := MODULE
	// functionmacro to generate a summary of differences between two input datasets ("old" and "new") by comparing the list of fields in in_fieldList
	// result will indicate which combinations of fields are in "old" dataset but not in "new" (Deleted) and vice versa (Added)
	// usage example:  SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, ['FNAME','MNAME','LNAME']);
	// Note that setting the final parameter to TRUE will generate ECL as a text string for inspection/debug purposes
	EXPORT mac_DifferencesByFieldList(in_DSOld, in_DSNew, in_fieldList, returnECLText = FALSE) := FUNCTIONMACRO
		#DECLARE(outECL);
		#DECLARE(fieldCheckOldECL);
		#DECLARE(fieldCheckNewECL);
		#DECLARE(fieldJoinECL);
		#DECLARE(nField);
		
		#SET(outECL, '');
		#SET(fieldCheckOldECL, '');
		#SET(fieldCheckNewECL, '');
		#SET(fieldJoinECL, '');
		#SET(nField, 1);
		
		#LOOP
			#IF (%nField% > COUNT(in_fieldList))
				#BREAK
			#ELSE
				#APPEND(fieldCheckOldECL, IF(%nField% > 1, ' AND ', '') + 'le.' + TRIM(in_fieldList[%nField%]) + ' = (TYPEOF(le.' + TRIM(in_fieldList[%nField%]) + '))\'\'');
				#APPEND(fieldCheckNewECL, IF(%nField% > 1, ' AND ', '') + 'ri.' + TRIM(in_fieldList[%nField%]) +  ' = (TYPEOF(ri.' + TRIM(in_fieldList[%nField%]) + '))\'\'');
				#APPEND(fieldJoinECL, IF(%nField% > 1, ' AND ', '') + 'LEFT.' + TRIM(in_fieldList[%nField%]) + ' = RIGHT.' + TRIM(in_fieldList[%nField%]));
			#END
		  #SET(nField, %nField% + 1);
		#END
		
		#APPEND(outECL, '  Diff_Layout := RECORD\n');
		#APPEND(outECL, '    RECORDOF(' + TRIM(#TEXT(in_DSOld)) + ') old_rec;\n');
		#APPEND(outECL, '    RECORDOF(' + TRIM(#TEXT(in_DSNew)) + ') new_rec;\n');
		#APPEND(outECL, '    BOOLEAN Added;\n');
		#APPEND(outECL, '    BOOLEAN Deleted;\n');
		#APPEND(outECL, '  END;\n');
		#APPEND(outECL, '  Diff_Layout Take_Record(' + TRIM(#TEXT(in_DSOld)) + ' le, ' + TRIM(#TEXT(in_DSNew)) + ' ri) := TRANSFORM\n');
		#APPEND(outECL, '    old_isnull := ');
		#APPEND(outECL, %'fieldCheckOldECL'%);
		#APPEND(outECL, ';\n');
		#APPEND(outECL, '    new_isnull := ');
		#APPEND(outECL, %'fieldCheckNewECL'%);
		#APPEND(outECL, ';\n');
		#APPEND(outECL, '    addOrDelete := old_isnull OR new_isnull;\n');
		#APPEND(outECL, '    SELF.Added := IF(addOrDelete, old_isnull, SKIP);\n');
    #APPEND(outECL, '    SELF.Deleted := IF(addOrDelete, new_isnull, SKIP);\n');
		#APPEND(outECL, '    SELF.old_rec := le;\n');
    #APPEND(outECL, '    SELF.new_rec := ri;\n');
		#APPEND(outECL, '  END;\n');
		#APPEND(outECL, '  internal_Differences := JOIN(' + TRIM(#TEXT(in_DSOld)) + ', ' + TRIM(#TEXT(in_DSNew)) + ',\n');
		#APPEND(outECL, '                               ' + %'fieldJoinECL'% + ',\n');
		#APPEND(outECL, '                               Take_Record(LEFT,RIGHT), HASH, FULL OUTER);\n');
		#IF(returnECLText)
			RETURN OUTPUT(%'outECL'%);
		#ELSE
			%outECL%
			RETURN internal_Differences;
		#END
	ENDMACRO;
	
	// functionmacro to generate a summary of differences between two input datasets ("old" and "new") by comparing rids
	// result will indicate which rids are in "old" only (Deleted), "new" only (Added), or have changes to one or more
	//   fields in the provided field list (Changed); also, for each field in the field list, BOOLEAN fields will be
	//   created in the result to indicate whether a record experienced an addition ("new" has a value, "old" did not), 
	//   removal ("old" had a value, "new" does not), or modification (non-empty to non-empty) in that field
	// usage example:  SALT311.mod_Delta.mac_DifferencesByRIDField(old_s, new_s, ['FNAME','MNAME','LNAME'], RID);
	// Note that setting the final parameter to TRUE will generate ECL as a text string for inspection/debug purposes
	EXPORT mac_DifferencesByRIDField(in_DSOld, in_DSNew, in_fieldList, in_ridField, returnECLText = FALSE) := FUNCTIONMACRO
		#DECLARE(outECL);
		#DECLARE(compareFieldsECL);
		#DECLARE(setCompareFieldsECL);
		#DECLARE(nField);
		
		#SET(outECL, '');
		#SET(compareFieldsECL, '');
		#SET(setCompareFieldsECL, '');
		#SET(nField, 1);
		#APPEND(outECL, '  Diff_Layout := RECORD\n');
		#APPEND(outECL, '    RECORDOF(' + TRIM(#TEXT(in_DSOld)) + ') old_rec;\n');
		#APPEND(outECL, '    RECORDOF(' + TRIM(#TEXT(in_DSNew)) + ') new_rec;\n');
		#APPEND(outECL, '    BOOLEAN Added;\n');
		#APPEND(outECL, '    BOOLEAN Deleted;\n');
		#APPEND(outECL, '    BOOLEAN Changed;\n');
		#LOOP
			#IF (%nField% > COUNT(in_fieldList))
				#BREAK
			#ELSE
				#APPEND(outECL, '    BOOLEAN ' + TRIM(in_fieldList[%nField%]) + '_added;\n');
				#APPEND(outECL, '    BOOLEAN ' + TRIM(in_fieldList[%nField%]) + '_removed;\n');
				#APPEND(outECL, '    BOOLEAN ' + TRIM(in_fieldList[%nField%]) + '_modified;\n');
				#APPEND(compareFieldsECL, IF(%nField% > 1, ' OR ', '') + 'le.' + TRIM(in_fieldList[%nField%]) + ' <> ri.' + TRIM(in_fieldList[%nField%]));
				#APPEND(setCompareFieldsECL, '    SELF.' + TRIM(in_fieldList[%nField%]) + '_added := le.' + TRIM(in_fieldList[%nField%]) + ' = (TYPEOF(le.' + TRIM(in_fieldList[%nField%]) + '))\'\' AND ri.' + TRIM(in_fieldList[%nField%]) + ' > (TYPEOF(le.' + TRIM(in_fieldList[%nField%]) + '))\'\';\n');
				#APPEND(setCompareFieldsECL, '    SELF.' + TRIM(in_fieldList[%nField%]) + '_removed := le.' + TRIM(in_fieldList[%nField%]) + ' > (TYPEOF(le.' + TRIM(in_fieldList[%nField%]) + '))\'\' AND ri.' + TRIM(in_fieldList[%nField%]) + ' = (TYPEOF(le.' + TRIM(in_fieldList[%nField%]) + '))\'\';\n');
				#APPEND(setCompareFieldsECL, '    SELF.' + TRIM(in_fieldList[%nField%]) + '_modified := le.' + TRIM(in_fieldList[%nField%]) + ' > (TYPEOF(le.' + TRIM(in_fieldList[%nField%]) + '))\'\' AND ri.' + TRIM(in_fieldList[%nField%]) + ' > (TYPEOF(le.' + TRIM(in_fieldList[%nField%]) + '))\'\' AND le.' + TRIM(in_fieldList[%nField%]) + ' <> ri.' + TRIM(in_fieldList[%nField%]) + ';\n');
			#END
		  #SET(nField, %nField% + 1);
		#END
		#APPEND(outECL, '  END;\n');
		#APPEND(outECL, '  Diff_Layout Take_Record(' + TRIM(#TEXT(in_DSOld)) + ' le, ' + TRIM(#TEXT(in_DSNew)) + ' ri) := TRANSFORM\n');
		#APPEND(outECL, '    SELF.Added := le.' + TRIM(#TEXT(in_ridField)) + ' = (TYPEOF(le.' + TRIM(#TEXT(in_ridField)) + '))\'\';\n');
		#APPEND(outECL, '    SELF.Deleted := ri.' + TRIM(#TEXT(in_ridField)) + ' = (TYPEOF(ri.' + TRIM(#TEXT(in_ridField)) + '))\'\';\n');
		#APPEND(outECL, '    SELF.Changed := MAP ( le.' + TRIM(#TEXT(in_ridField)) + ' = (TYPEOF(le.' + TRIM(#TEXT(in_ridField)) + '))\'\' OR ri.' + TRIM(#TEXT(in_ridField)) + ' = (TYPEOF(ri.' + TRIM(#TEXT(in_ridField)) + '))\'\' => FALSE,\n');
		#IF (COUNT(in_fieldList) > 0)
			#APPEND(outECL, '                          ' + %'compareFieldsECL'% + ' => TRUE,\n');
		#END
    #APPEND(outECL, '                          SKIP );\n');
    #APPEND(outECL, %'setCompareFieldsECL'%);
		#APPEND(outECL, '    SELF.old_rec := le;\n');
    #APPEND(outECL, '    SELF.new_rec := ri;\n');
		#APPEND(outECL, '  END;\n');
		#APPEND(outECL, '  internal_Differences := JOIN(' + TRIM(#TEXT(in_DSOld)) + ',' + TRIM(#TEXT(in_DSNew)) + ',left.' + TRIM(#TEXT(in_ridField)) + '=right.' + TRIM(#TEXT(in_ridField)) + ',Take_Record(LEFT,RIGHT),HASH,FULL OUTER);\n');
		#IF(returnECLText)
			RETURN OUTPUT(%'outECL'%);
		#ELSE
			%outECL%
			RETURN internal_Differences;
		#END
	ENDMACRO;
	
	// functionmacro to take a dataset of differences (produced by mac_DifferencesByRIDField above) and generate statistics summarizing
	//   changes by field (how many records experienced an addition/removal/modification in each field in the list provided)
	// can be per source (if in_srcField is non-empty) or global (i.e. over the entire dataset- if in_srcField is empty)
	// usage example:  SALT311.mod_Delta.mac_DifferencesByRIDFieldChangeStats(diffChanged, ['FNAME','MNAME','LNAME'], src)
	// Note that setting the final parameter to TRUE will generate ECL as a text string for inspection/debug purposes
	EXPORT mac_DifferencesByRIDFieldChangeStats(dsDifferences, in_fieldList, in_srcField = '', returnECLText = FALSE) := FUNCTIONMACRO
		#DECLARE(outECL);
		#DECLARE(summaryFieldsECL);
		#DECLARE(nField);
		
		#SET(outECL, '');
		#SET(summaryFieldsECL, '');
		#SET(nField, 1);
		
		#LOOP
			#IF (%nField% > COUNT(in_fieldList))
				#BREAK
			#ELSE
				#APPEND(summaryFieldsECL, '    cnt_' + TRIM(in_fieldList[%nField%]) + '_added := COUNT(GROUP, ' + TRIM(#TEXT(dsDifferences)) + '.' + TRIM(in_fieldList[%nField%]) + '_added);\n');
				#APPEND(summaryFieldsECL, '    cnt_' + TRIM(in_fieldList[%nField%]) + '_removed := COUNT(GROUP, ' + TRIM(#TEXT(dsDifferences)) + '.' + TRIM(in_fieldList[%nField%]) + '_removed);\n');
				#APPEND(summaryFieldsECL, '    cnt_' + TRIM(in_fieldList[%nField%]) + '_modified := COUNT(GROUP, ' + TRIM(#TEXT(dsDifferences)) + '.' + TRIM(in_fieldList[%nField%]) + '_modified);\n');
			#END
		  #SET(nField, %nField% + 1);
		#END
		#APPEND(outECL, '  FieldChanges_Layout := RECORD\n');
		#IF(TRIM(#TEXT(in_srcField)) <> '')
			#APPEND(outECL, '    STRING20 srcField := ' + TRIM(#TEXT(dsDifferences)) + '.old_rec.' + TRIM(#TEXT(in_srcField)) + ';\n');
		#ELSE
			#APPEND(outECL, '    STRING20 srcField := \'\';\n');
		#END
		#APPEND(outECL, %'summaryFieldsECL'%);
		#APPEND(outECL, '  END;\n');
		#IF(TRIM(#TEXT(in_srcField)) <> '')
			#APPEND(outECL, '  internal_DifferencesFieldChanges := TABLE(' + TRIM(#TEXT(dsDifferences)) + ', FieldChanges_Layout, ' + TRIM(#TEXT(dsDifferences)) + '.old_rec.' + TRIM(#TEXT(in_srcField)) + ', MERGE);\n');
		#ELSE
			#APPEND(outECL, '  internal_DifferencesFieldChanges := TABLE(' + TRIM(#TEXT(dsDifferences)) + ', FieldChanges_Layout, MERGE);\n');
		#END
		#IF(returnECLText)
			RETURN OUTPUT(%'outECL'%);
		#ELSE
			%outECL%
			RETURN internal_DifferencesFieldChanges;
		#END
	ENDMACRO;
	
	// functionmacro to take a dataset of differences (produced by mac_DifferencesByRIDField or mac_DifferencesByFieldList above) and generate statistics summarizing
	//   changes by field (how many source_rids experienced an addition/removal in each field in the list provided)
	// usage example:  SALT311.mod_Delta.mac_DifferencesBySOURCERIDFieldChangeStats(diffChanged, ['FNAME','MNAME','LNAME'], src, srcRID)
	// Note that setting the final parameter to TRUE will generate ECL as a text string for inspection/debug purposes
	EXPORT mac_SOURCERIDFieldChangeStats(in_DSOld, in_DSNew, in_fieldList, srcField, srcRIDField, returnECLText = FALSE) := FUNCTIONMACRO
		
		#DECLARE(outECL);
		#DECLARE(fieldSummaryECL);
		#DECLARE(combineFieldSummaryECL);
		#DECLARE(summaryRecECL);
		#DECLARE(rollFieldECL);
		#DECLARE(srcRIDUnchangedECL);
		#DECLARE(srcRIDChangedECL);
		#DECLARE(srcRIDChangedECLStats);
		#DECLARE(nField);
		
		#SET(outECL, '');
		#SET(fieldSummaryECL, '');
		#SET(combineFieldSummaryECL, '');
		#SET(summaryRecECL, '');
		#SET(rollFieldECL, '');
		#SET(nField, 1);
		
		#LOOP
			#IF (%nField% > COUNT(in_fieldList))
				#BREAK
			#ELSE
			  #IF (STD.Str.ToUpperCase(TRIM(in_fieldList[%nField%])) <> STD.Str.ToUpperCase(TRIM(#TEXT(srcField))) AND STD.Str.ToUpperCase(TRIM(in_fieldList[%nField%])) <> STD.Str.ToUpperCase(TRIM(#TEXT(srcRIDField))))
					#APPEND(fieldSummaryECL, '  summary' + TRIM(in_fieldList[%nField%]) + ' := mac_summaryForField(dsOld_Dist, dsNew_Dist, ' + TRIM(in_fieldList[%nField%]) + ');\n');
					#APPEND(combineFieldSummaryECL, ' & ' + ' summary' + TRIM(in_fieldList[%nField%]));
					#APPEND(summaryRecECL, '    UNSIGNED ' + TRIM(in_fieldList[%nField%]) + '_added;\n    UNSIGNED ' + TRIM(in_fieldList[%nField%]) + '_removed;\n');
					#APPEND(rollFieldECL,  '                                     SELF.' + TRIM(in_fieldList[%nField%]) + '_added := IF(LEFT.' + TRIM(in_fieldList[%nField%]) + '_added > 0, LEFT.' + TRIM(in_fieldList[%nField%]) + '_added, RIGHT.' + TRIM(in_fieldList[%nField%]) + '_added);\n');
					#APPEND(rollFieldECL,  '                                     SELF.' + TRIM(in_fieldList[%nField%]) + '_removed := IF(LEFT.' + TRIM(in_fieldList[%nField%]) + '_removed > 0, LEFT.' + TRIM(in_fieldList[%nField%]) + '_removed, RIGHT.' + TRIM(in_fieldList[%nField%]) + '_removed);\n');				
					#APPEND(srcRIDUnchangedECL, ' AND summaryCombine.' + TRIM(in_fieldList[%nField%]) + '_added = 0 AND summaryCombine.' + TRIM(in_fieldList[%nField%]) + '_removed = 0');
				  #APPEND(srcRIDChangedECL, ' OR summaryCombine.' + TRIM(in_fieldList[%nField%]) + '_added > 0 OR summaryCombine.' + TRIM(in_fieldList[%nField%]) + '_removed > 0');
				  #APPEND(srcRIDChangedECLStats, '    cntExistsSourceRID_' + TRIM(in_fieldList[%nField%]) + '_added := COUNT(GROUP, summaryCombine.inNew AND summaryCombine.inOld AND summaryCombine.' + TRIM(in_fieldList[%nField%]) + '_added > 0);\n');
				  #APPEND(srcRIDChangedECLStats, '    cntExistsSourceRID_' + TRIM(in_fieldList[%nField%]) + '_removed := COUNT(GROUP, summaryCombine.inNew AND summaryCombine.inOld AND summaryCombine.' + TRIM(in_fieldList[%nField%]) + '_removed > 0);\n');
				#END			
			#END
		  #SET(nField, %nField% + 1);
		#END
		
		#APPEND(outECL, '  dsOld_Dist := DISTRIBUTE(' + TRIM(#TEXT(in_DSOld)) + '(' + TRIM(#TEXT(srcField)) + ' > (TYPEOF(' + TRIM(#TEXT(srcField)) + '))\'\' AND ' + TRIM(#TEXT(srcRIDField)) + ' > (TYPEOF(' + TRIM(#TEXT(srcRIDField)) + '))\'\'), HASH(' + TRIM(#TEXT(srcField)) + ', ' + TRIM(#TEXT(srcRIDField)) + ')) : INDEPENDENT;\n');
		#APPEND(outECL, '  dsNew_Dist := DISTRIBUTE(' + TRIM(#TEXT(in_DSNew)) + '(' + TRIM(#TEXT(srcField)) + ' > (TYPEOF(' + TRIM(#TEXT(srcField)) + '))\'\' AND ' + TRIM(#TEXT(srcRIDField)) + ' > (TYPEOF(' + TRIM(#TEXT(srcRIDField)) + '))\'\'), HASH(' + TRIM(#TEXT(srcField)) + ', ' + TRIM(#TEXT(srcRIDField)) + ')) : INDEPENDENT;\n');
		#APPEND(outECL, '  Layout_summaryRec := RECORD\n');
		#APPEND(outECL, '    dsOld_Dist.' + TRIM(#TEXT(srcField)) + ';\n');
		#APPEND(outECL, '    dsOld_Dist.' + TRIM(#TEXT(srcRIDField)) + ';\n');
		#APPEND(outECL, '    BOOLEAN inOld;\n    BOOLEAN inNew;\n');
		#APPEND(outECL, %'summaryRecECL'%);
		#APPEND(outECL, '  END;\n');
		#APPEND(outECL, '  mac_summaryforField(inDSOld, inDSNew, fieldName) := FUNCTIONMACRO\n');
		#APPEND(outECL, '    tOld := TABLE(inDSOld, {' + TRIM(#TEXT(srcField)) + ', ' + TRIM(#TEXT(srcRIDField)) + ', fieldName}, ' + TRIM(#TEXT(srcField)) + ', ' + TRIM(#TEXT(srcRIDField)) + ', fieldName, LOCAL);\n');
		#APPEND(outECL, '    tNew := TABLE(inDSNew, {' + TRIM(#TEXT(srcField)) + ', ' + TRIM(#TEXT(srcRIDField)) + ', fieldName}, ' + TRIM(#TEXT(srcField)) + ', ' + TRIM(#TEXT(srcRIDField)) + ', fieldName, LOCAL);\n');
		#APPEND(outECL, '    Layout_Compare := RECORD\n');
		#APPEND(outECL, '      tOld;\n');
		#APPEND(outECL, '      BOOLEAN inOldDS;\n');
		#APPEND(outECL, '      BOOLEAN inNewDS;\n');
		#APPEND(outECL, '    END;\n');
		#APPEND(outECL, '    joinCompare := JOIN(tOld, tNew, LEFT.' + TRIM(#TEXT(srcField)) + ' = RIGHT.' + TRIM(#TEXT(srcField)) + ' AND LEFT.' + TRIM(#TEXT(srcRIDField)) + ' = RIGHT.' + TRIM(#TEXT(srcRIDField)) + ' AND LEFT.fieldName = RIGHT.fieldName,\n');
		#APPEND(outECL, '                        TRANSFORM(Layout_compare,\n');
		#APPEND(outECL, '                                  SELF.inOldDS := TRIM(LEFT.' + TRIM(#TEXT(srcField)) + ') > \'\';\n');
		#APPEND(outECL, '                                  SELF.inNewDS := TRIM(RIGHT.' + TRIM(#TEXT(srcField)) + ') > \'\';\n');
		#APPEND(outECL, '                                  SELF.' + TRIM(#TEXT(srcField)) + ' := IF(SELF.inOldDS, LEFT.' + TRIM(#TEXT(srcField)) + ', RIGHT.' + TRIM(#TEXT(srcField)) + ');\n');
		#APPEND(outECL, '                                  SELF.' + TRIM(#TEXT(srcRIDField)) + ' := IF(SELF.inOldDS, LEFT.' + TRIM(#TEXT(srcRIDField)) + ', RIGHT.' + TRIM(#TEXT(srcRIDField)) + ');\n');
		#APPEND(outECL, '                                  SELF.fieldName := IF(SELF.inOldDS, LEFT.fieldName, RIGHT.fieldName)),\n');
		#APPEND(outECL, '                        FULL OUTER, LOCAL);\n');
		#APPEND(outECL, '    summaryResult := TABLE(joinCompare, {' +  TRIM(#TEXT(srcField)) + ', ' + TRIM(#TEXT(srcRIDField)) + ', inOld := COUNT(GROUP, inOldDS) > 0, inNew := COUNT(GROUP, inNewDS) > 0, #EXPAND(TRIM(#TEXT(fieldName)) + \'_added\') := COUNT(GROUP, inNewDS AND ~inOldDS), #EXPAND(TRIM(#TEXT(fieldName)) + \'_removed\') := COUNT(GROUP, inOldDS AND ~inNewDS)}, ' + TRIM(#TEXT(srcField)) + ', ' + TRIM(#TEXT(srcRIDField)) + ', LOCAL);\n');
		#APPEND(outECL, '    RETURN PROJECT(summaryResult, TRANSFORM(Layout_summaryrec, SELF := LEFT, SELF := []));\n');
		#APPEND(outECL, '  ENDMACRO;\n');
		#APPEND(outECL, %'fieldSummaryECL'%);
		#APPEND(outECL, '  summaryCombine0 := DATASET([], Layout_summaryrec)');
		#APPEND(outECL, %'combineFieldSummaryECL'%);
		#APPEND(outECL, ';\n');
		#APPEND(outECL, '  summaryCombine := ROLLUP(GROUP(SORT(summaryCombine0, ' + TRIM(#TEXT(srcField)) + ', ' + TRIM(#TEXT(srcRIDField)) + ', LOCAL), ' + TRIM(#TEXT(srcField)) + ', ' + TRIM(#TEXT(srcRIDField)) + ', LOCAL), TRUE,\n');
		#APPEND(outECL, '                           TRANSFORM(Layout_summaryrec,\n');
		#APPEND(outECL, '                                     SELF.' + TRIM(#TEXT(srcField)) + ' := LEFT.' + TRIM(#TEXT(srcField)) + ';\n');
		#APPEND(outECL, '                                     SELF.' + TRIM(#TEXT(srcRIDField)) + ' := LEFT.' + TRIM(#TEXT(srcRIDField)) + ';\n');
		#APPEND(outECL, '                                     SELF.inOld := LEFT.inOld OR RIGHT.inOld;\n');
		#APPEND(outECL, '                                     SELF.inNew := LEFT.inNew OR RIGHT.inNew;\n');
		#APPEND(outECL, %'rollFieldECL'%);
		#APPEND(outECL, '                           ));\n');
		#APPEND(outECL, '  recSrcRid := RECORD\n');
		#APPEND(outECL, '    summaryCombine.' + TRIM(#TEXT(srcField)) + ';\n');
		#APPEND(outECL, '    cntNewSourceRIDs := COUNT(GROUP, summaryCombine.inNew AND ~summaryCombine.inOld);\n');
		#APPEND(outECL, '    cntOldSourceRIDs := COUNT(GROUP, summaryCombine.inOld AND ~summaryCombine.inNew);\n');
		#APPEND(outECL, '    cntUnchangedSourceRIDs := COUNT(GROUP, summaryCombine.inNew AND summaryCombine.inOld');
		#APPEND(outECL, %'srcRIDUnchangedECL'% + ');\n');
		#APPEND(outECL, '    cntChangedSourceRIDs := COUNT(GROUP, summaryCombine.inNew AND summaryCombine.inOld AND (FALSE ');
		#APPEND(outECL, %'srcRIDChangedECL'% + '));\n');
		#APPEND(outECL, %'srcRIDChangedECLStats'%);
		#APPEND(outECL, '  END;\n');
		#APPEND(outECL, '  internal_SrcRidStats := TABLE(summaryCombine, recSrcRid, ' + TRIM(#TEXT(srcField)) + ', MERGE);\n');
		#IF(returnECLText)
			RETURN OUTPUT(%'outECL'%);
		#ELSE
			%outECL%
			RETURN internal_SrcRidStats;
		#END
	ENDMACRO;
END;
