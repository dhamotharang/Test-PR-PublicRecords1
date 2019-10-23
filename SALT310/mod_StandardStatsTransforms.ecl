// functions/transforms to take different types of statistics outputs and convert them to Layout_Stats_Standard
EXPORT mod_StandardStatsTransforms := MODULE
	EXPORT mac_hygieneSummaryTransform(mymod, fieldsAttr, inLayout, hasSourceField, outputECLText = FALSE) := MACRO
		IMPORT mymod;
		#DECLARE(outECL);
		#DECLARE(fieldnameECL);
		#DECLARE(statvalECL);
		#DECLARE(nField);
		#DECLARE(currentField);
		#DECLARE(currentFlat);
		#SET(fieldnameECL, '');
		#SET(outECL, '');
		#SET(statvalECL, '');
		#SET(nField, 1);
		#SET(currentField, '');
		#SET(currentFlat, '');
		#APPEND(outECL, 'SALT310.Layout_Stats_Standard.Main xSummary(' + inLayout + 'le, INTEGER cnt, UNSIGNED useTimestamp, STRING suffix = \'\', STRING statCategoryMore = \'\') := TRANSFORM\n');
		#APPEND(outECL, '  SELF.dateTimeStamp := useTimeStamp;\n');
		#APPEND(outECL, '  SELF.wuid := WORKUNIT;\n');
		#IF(hasSourceField)
			#APPEND(outECL, '  SELF.source := le.source;\n');
		#END
		#APPEND(fieldnameECL, '  SELF.field := CHOOSE(((cnt-1) DIV 6) + 1');
		#APPEND(statvalECL, '  SELF.statValue := CHOOSE(cnt');
		#LOOP
			#SET(currentField, mymod.fieldsAttr.FieldName(%nField%));
			#SET(currentFlat, mymod.fieldsAttr.FlatName(%nField%));
			#IF (%nField% > mymod.fieldsAttr.NumFields)
				#BREAK
			#ELSEIF (mymod.fieldsAttr.InBaseLayout(%nField%))
				#APPEND(fieldnameECL, ', \'' + TRIM(%'currentField'%) + '\'');
				#APPEND(statvalECL, ', le.populated_' + TRIM(%'currentFlat'%) + '_cnt');
				#APPEND(statvalECL, ', le.populated_' + TRIM(%'currentFlat'%) + '_pcnt');
				#APPEND(statvalECL, ', le.NumberOfRecords - le.populated_' + TRIM(%'currentFlat'%) + '_cnt');
				#APPEND(statvalECL, ', 100 - le.populated_' + TRIM(%'currentFlat'%) + '_pcnt');
				#APPEND(statvalECL, ', le.maxlength_' + TRIM(%'currentFlat'%));
				#APPEND(statvalECL, ', le.avelength_' + TRIM(%'currentFlat'%));
			#END
			#SET(nField, %nField% + 1);
		#END
		#APPEND(fieldnameECL, '  , \'UNKNOWN\');\n');
		#APPEND(statvalECL, ', 0);\n');
		#APPEND(outECL, %'fieldnameECL'%);
		#APPEND(outECL, %'statvalECL'%);
		#APPEND(outECL, '  SELF.measureType := CHOOSE(cnt % 6, \'CntRecs\', \'PcntRecs\', \'CntRecs\', \'PcntRecs\', \'MaxLen\', \'AveLen\');\n');
		#APPEND(outECL, '  SELF.statCategory := CHOOSE(cnt % 6, \'FieldPop\', \'FieldPop\', \'FieldEmpty\', \'FieldEmpty\', \'FieldInfo\', \'FieldInfo\');\n');
		#APPEND(outECL, '  SELF.statCategory_More := statCategoryMore;\n');
		#APPEND(outECL, '  useSuffix := IF(TRIM(suffix) > \'\', \'_\' + suffix, \'\');\n');
		#APPEND(outECL, '  SELF.statDesc := CHOOSE(cnt % 6, \'FieldPop:\' + TRIM(SELF.field) + \':CntRecs\' + useSuffix, \'FieldPop:\' + TRIM(SELF.field) + \':PcntRecs\' + useSuffix, \'FieldEmpty:\' + TRIM(SELF.field) + \':CntRecs\' + useSuffix, \'FieldEmpty:\' + TRIM(SELF.field) + \':PcntRecs\' + useSuffix, \'FieldInfo:\' + TRIM(SELF.field) + \':MaxLength\' + useSuffix, \'FieldInfo:\' + TRIM(SELF.field) + \':AveLength\' + useSuffix);\n');
		#APPEND(outECL, '  SELF := [];\n');
		#APPEND(outECL, 'END;\n');
		
		#IF (outputECLText)
			OUTPUT(%'outECL'%);
		#ELSE
			%outECL%;
		#END
	ENDMACRO;
	
	EXPORT mac_hygieneTotalRecs(dsSummaryIn, useTimestamp, statnameSuffixIn, hasSourceField, statCategoryMoreIn) := FUNCTIONMACRO
		SALT310.Layout_Stats_Standard.Main xTotalRecs(dsSummaryIn le) := TRANSFORM
			SELF.dateTimeStamp := useTimestamp;
			SELF.wuid := WORKUNIT;
			SELF.statCategory := 'Summary';
			SELF.statCategory_More := statCategoryMoreIn;
			#IF(hasSourceField)
				SELF.Source := le.Source;
			#END
			SELF.measureType := 'CntRecs';
			SELF.statDesc := 'Summary:CntRecs' + IF(TRIM(statnameSuffixIn) > '', '_' + statnameSuffixIn, '');
			SELF.statValue := le.NumberOfRecords;
			SELF := [];
		END;
		
		dsStandard := PROJECT(dsSummaryIn, xTotalRecs(LEFT));
		
		RETURN dsStandard;
	ENDMACRO;
	
	EXPORT hygieneAllProfiles(DATASET(SALT310.MAC_Character_Counts.ResultLine_Layout) allProfilesIn, UNSIGNED useTimestamp, UNSIGNED1 numExamples, STRING statCategoryMoreIn = '') := FUNCTION
		SALT310.Layout_Stats_Standard.Main xAllProfiles(allProfilesIn le, INTEGER cnt) := TRANSFORM
			SELF.dateTimeStamp := useTimestamp;
			SELF.wuid := WORKUNIT;
			SELF.statCategory := 'FieldInfo';
			SELF.statCategory_More := statCategoryMoreIn;
			SELF.field := le.FieldName;
			SELF.measureType := CHOOSE(cnt, 'CntVals', 'MinVal', 'MaxVal', 'AvgVal', 'VarVal', 'UNKNOWN');
			SELF.statDesc := 'FieldInfo:' + TRIM(SELF.field) + ':' + CHOOSE(cnt, 'Cardinality', 'MinVal', 'MaxVal', 'AvgVal', 'VarVal', 'UNKNOWN');
			SELF.statValue := CHOOSE(cnt, le.cardinality, le.AsNumber_MinVal, le.AsNumber_MaxVal, le.AsNumber_Mean, le.AsNumber_Var, 0);
			SELF.dsExamples := IF(cnt = 1, PROJECT(SORT(le.Frequent_Terms, -cnt)[1..numExamples], TRANSFORM(SALT310.Layout_Stats_Standard.Examples, SELF := LEFT)));
			SELF := [];
		END;
		
		dsStandard := NORMALIZE(allProfilesIn, 5, xAllProfiles(LEFT, COUNTER));
		
		RETURN dsStandard;
	END;
	
	EXPORT mac_scrubsSummaryStatsFieldErrTransform(mymod, fieldsAttr, inLayout, srcField, outputECLText = FALSE) := MACRO
		IMPORT mymod;
		#DECLARE(outECL);
		#DECLARE(fieldnameECL);
		#DECLARE(statvalECL);
		#DECLARE(statdescECL);
		#DECLARE(statdetailECL);
		#DECLARE(ruletypeECL);
		#DECLARE(nField);
		#DECLARE(nRule);
		#DECLARE(currentField);
		#DECLARE(currentRule);
		
		#SET(fieldnameECL, '');
		#SET(outECL, '');
		#SET(statvalECL, '');
		#SET(statdescECL, '');
		#SET(statdetailECL, '');
		#SET(ruletypeECL, '');
		#SET(nField, 1);
		#SET(nRule, 1);
		#SET(currentField, '');
		#SET(currentRule, '');
		
		#APPEND(outECL, 'SALT310.Layout_Stats_Standard.Main xSummaryStats(' + inLayout + 'le, INTEGER cnt, UNSIGNED useTimestamp, STRING suffixIn, STRING statCategoryMoreIn = \'\') := TRANSFORM\n');
		#APPEND(outECL, '  SELF.dateTimeStamp := useTimeStamp;\n');
		#APPEND(outECL, '  SELF.wuid := WORKUNIT;\n');
		#IF(TRIM(srcField) > '')
			#APPEND(outECL, '  SELF.source := le.' + srcField + ';\n');
		#END
		#APPEND(fieldnameECL, '  SELF.field := CHOOSE(cnt');
		#APPEND(statvalECL, '  SELF.statValue := CHOOSE(cnt');
		#APPEND(statdescECL, '  SELF.statDesc := CHOOSE(cnt');
		#APPEND(statdetailECL, '  SELF.statDetail := CHOOSE(cnt');
		#APPEND(ruletypeECL, '  SELF.ruleType := CHOOSE(cnt');
		#LOOP	
			#IF (%nField% > mymod.fieldsAttr.NumFields)
				#BREAK
			#ELSEIF (COUNT(mymod.fieldsAttr.FieldRules(%nField%)) > 0)
			  #SET(currentField, mymod.fieldsAttr.FieldName(%nField%));
				#SET(nRule, 1);
				#LOOP				
					#IF (%nRule% > COUNT(mymod.fieldsAttr.FieldRules(%nField%)))
						#BREAK
					#ELSE
					  #SET(currentRule, mymod.fieldsAttr.FieldRules(%nField%)[%nRule%]);						
						#APPEND(fieldnameECL, ', \'' + TRIM(%'currentField'%) + '\'');
						#APPEND(fieldnameECL, ', \'' + TRIM(%'currentField'%) + '\'');
						#APPEND(fieldnameECL, ', \'' + TRIM(%'currentField'%) + '\'');
						#APPEND(fieldnameECL, ', \'' + TRIM(%'currentField'%) + '\'');
						#APPEND(statvalECL, ', le.' + TRIM(%'currentField'%) + '_' + TRIM(%'currentRule'%) + '_ErrorCount');
						#APPEND(statvalECL, ', IF(le.TotalCnt > 0, le.' + TRIM(%'currentField'%) + '_' + TRIM(%'currentRule'%) + '_ErrorCount/le.TotalCnt * 100, 0)');
						#APPEND(statvalECL, ', le.TotalCnt - le.' + TRIM(%'currentField'%) + '_' + TRIM(%'currentRule'%) + '_ErrorCount');
						#APPEND(statvalECL, ', IF(le.TotalCnt > 0, (le.TotalCnt - le.' + TRIM(%'currentField'%) + '_' + TRIM(%'currentRule'%) + '_ErrorCount)/le.TotalCnt * 100, 0)');
						#APPEND(statdescECL, ',  \'Scrub:' + TRIM(%'currentField'%) + '_' + TRIM(%'currentRule'%) + ':CntRecsErr\' + IF(TRIM(suffixIn) > \'\', \'_\' + suffixIn, \'\')');
						#APPEND(statdescECL, ',  \'Scrub:' + TRIM(%'currentField'%) + '_' + TRIM(%'currentRule'%) + ':PcntRecsErr\' + IF(TRIM(suffixIn) > \'\', \'_\' + suffixIn, \'\')');
						#APPEND(statdescECL, ',  \'Scrub:' + TRIM(%'currentField'%) + '_' + TRIM(%'currentRule'%) + ':CntRecsOk\' + IF(TRIM(suffixIn) > \'\', \'_\' + suffixIn, \'\')');
						#APPEND(statdescECL, ',  \'Scrub:' + TRIM(%'currentField'%) + '_' + TRIM(%'currentRule'%) + ':PcntRecsOk\' + IF(TRIM(suffixIn) > \'\', \'_\' + suffixIn, \'\')');
						#APPEND(statdetailECL, ',' + #TEXT(myMod) + '.' + #TEXT(fieldsAttr) + '.InvalidMessage_' + TRIM(%'currentField'%) + '(' + %'nRule'% + ')');
						#APPEND(statdetailECL, ',' + #TEXT(myMod) + '.' + #TEXT(fieldsAttr) + '.InvalidMessage_' + TRIM(%'currentField'%) + '(' + %'nRule'% + ')');
						#APPEND(statdetailECL, ', \'\'');
						#APPEND(statdetailECL, ', \'\'');
						#APPEND(ruleTypeECL, ', \'' + TRIM(%'currentRule'%) + '\'');
						#APPEND(ruleTypeECL, ', \'' + TRIM(%'currentRule'%) + '\'');
						#APPEND(ruleTypeECL, ', \'' + TRIM(%'currentRule'%) + '\'');
						#APPEND(ruleTypeECL, ', \'' + TRIM(%'currentRule'%) + '\'');
					#END
					#SET(nRule, %nRule% + 1);
				#END
			  #APPEND(fieldnameECL, ', \'' + TRIM(%'currentField'%) + '\'');
				#APPEND(fieldnameECL, ', \'' + TRIM(%'currentField'%) + '\'');
				#APPEND(fieldnameECL, ', \'' + TRIM(%'currentField'%) + '\'');
				#APPEND(fieldnameECL, ', \'' + TRIM(%'currentField'%) + '\'');
				#APPEND(statvalECL, ', le.' + TRIM(%'currentField'%) + '_' + TRIM(IF(COUNT(mymod.fieldsAttr.FieldRules(%nField%)) > 1, 'Total', TRIM(%'currentRule'%))) + '_ErrorCount');
				#APPEND(statvalECL, ', IF(le.TotalCnt > 0, le.' + TRIM(%'currentField'%) + '_' + TRIM(IF(COUNT(mymod.fieldsAttr.FieldRules(%nField%)) > 1, 'Total', TRIM(%'currentRule'%))) + '_ErrorCount/le.TotalCnt * 100, 0)');
				#APPEND(statvalECL, ', le.TotalCnt - le.' + TRIM(%'currentField'%) + '_' + TRIM(IF(COUNT(mymod.fieldsAttr.FieldRules(%nField%)) > 1, 'Total', TRIM(%'currentRule'%))) + '_ErrorCount');
				#APPEND(statvalECL, ', IF(le.TotalCnt > 0, (le.TotalCnt - le.' + TRIM(%'currentField'%) + '_' + TRIM(IF(COUNT(mymod.fieldsAttr.FieldRules(%nField%)) > 1, 'Total', TRIM(%'currentRule'%))) + '_ErrorCount)/le.TotalCnt * 100, 0)');
				#APPEND(statdescECL, ',  \'Scrub:' + TRIM(%'currentField'%) + '_Total:CntRecsErr\' + IF(TRIM(suffixIn) > \'\', \'_\' + suffixIn, \'\')');
				#APPEND(statdescECL, ',  \'Scrub:' + TRIM(%'currentField'%) + '_Total:PcntRecsErr\' + IF(TRIM(suffixIn) > \'\', \'_\' + suffixIn, \'\')');
				#APPEND(statdescECL, ',  \'Scrub:' + TRIM(%'currentField'%) + '_Total:CntRecsOk\' + IF(TRIM(suffixIn) > \'\', \'_\' + suffixIn, \'\')');
				#APPEND(statdescECL, ',  \'Scrub:' + TRIM(%'currentField'%) + '_Total:PcntRecsOk\' + IF(TRIM(suffixIn) > \'\', \'_\' + suffixIn, \'\')');
				#APPEND(statdetailECL, ', \'\'');
				#APPEND(statdetailECL, ', \'\'');
				#APPEND(statdetailECL, ', \'\'');
				#APPEND(statdetailECL, ', \'\'');
				#APPEND(ruleTypeECL, ', \'Total\'');
				#APPEND(ruleTypeECL, ', \'Total\'');
				#APPEND(ruleTypeECL, ', \'Total\'');
				#APPEND(ruleTypeECL, ', \'Total\'');
			#END
			#SET(nField, %nField% + 1);
		#END
		#APPEND(fieldnameECL, '  , \'UNKNOWN\');\n');
		#APPEND(statvalECL, ', 0);\n');
		#APPEND(statdescECL, ', \'UNKNOWN\');\n');
		#APPEND(statdetailECL, ', \'UNKNOWN\');\n');
		#APPEND(ruletypeECL, ', \'UNKNOWN\');\n');
		#APPEND(outECL, %'fieldnameECL'%);
		#APPEND(outECL, %'statvalECL'%);
		#APPEND(outECL, %'statdescECL'%);
		#APPEND(outECL, %'statdetailECL'%);
		#APPEND(outECL, %'ruletypeECL'%);
		#APPEND(outECL, '  SELF.measureType := CHOOSE(cnt % 2, \'CntRecs\', \'PcntRecs\');\n');
		#APPEND(outECL, '  SELF.statCategory := \'Scrub\';\n');
		#APPEND(outECL, '  SELF.statCategory_More := statCategoryMoreIn;\n');
		#APPEND(outECL, '  SELF := [];\n');
		#APPEND(outECL, 'END;\n');
		
		#IF (outputECLText)
			OUTPUT(%'outECL'%);
		#ELSE
			%outECL%;
		#END
	ENDMACRO;
	
	EXPORT scrubsSummaryStatsGeneral(scrubsSummaryIn, srcField = '', useTimeStamp, suffixIn, statCategoryMoreIn) := FUNCTIONMACRO
		SALT310.Layout_Stats_Standard.Main xGeneralStats(scrubsSummaryIn le, INTEGER cnt) := TRANSFORM
			SELF.dateTimeStamp := useTimestamp;
			SELF.wuid := WORKUNIT;
			#IF(TRIM(#TEXT(srcField)) > '')
				SELF.source := le.srcField;
			#END
			SELF.statCategory := 'Scrub';
			SELF.statCategory_More := statCategoryMoreIn;
			SELF.measureType := CHOOSE(cnt, 'CntRecs', 'CntRecs', 'CntFields', 'CntFields', 'CntRules', 'CntRules', 'UNKNOWN');
			SELF.statDesc := 'Scrub:' + TRIM(CHOOSE(cnt, 'AnyRule:CntRecsErr', 'AnyRule:CntRecsOk', 'AnyRule:CntFieldsErr', 'AnyRule:CntFieldsOk', 'AnyRule:CntRulesErr', 'AnyRule:CntRulesOk', 'UNKNOWN')) + IF(TRIM(suffixIn) > '', '_' + suffixIn, '');
			SELF.statValue := CHOOSE(cnt, le.AnyRule_WithErrorsCount, le.TotalCnt - le.AnyRule_WithErrorsCount, le.FieldsChecked_WithErrors, le.FieldsChecked_NoErrors, le.Rules_WithErrors, le.Rules_NoErrors, 0);
			SELF := [];
		END;
		
		dsStandard := NORMALIZE(scrubsSummaryIn, 6, xGeneralStats(LEFT, COUNTER));
		
		RETURN dsStandard;
	ENDMACRO;
	
	EXPORT mac_deltaDifferencesFieldChanges(inLayout, useFields, useTimeStamp, hasSourceField, outputECLText = FALSE) := MACRO
		#DECLARE(outECL);
		#DECLARE(fieldnameECL);
		#DECLARE(statvalECL);
		#DECLARE(nField);
		
		#SET(outECL, '');
		#SET(fieldnameECL, '');
		#SET(statvalECL, '');
		#SET(nField, 1);
		#APPEND(outECL, 'SALT310.Layout_Stats_Standard.Main xByRIDFieldChanges(' + inLayout + 'le, INTEGER cnt, UNSIGNED useTimestamp, STRING suffixIn = \'\', STRING statCategoryMoreIn = \'\') := TRANSFORM\n');
		#APPEND(outECL, '  SELF.dateTimeStamp := useTimeStamp;\n');
		#APPEND(outECL, '  SELF.wuid := WORKUNIT;\n');
		#IF(hasSourceField)
			#APPEND(outECL, '  SELF.source := le.srcField;\n');
		#END
		#APPEND(fieldnameECL, '  SELF.field := CHOOSE(((cnt-1) DIV 3) + 1');
		#APPEND(statvalECL, '  SELF.statValue := CHOOSE(cnt');
		#LOOP
			#IF (%nField% > COUNT(useFields))
				#BREAK
			#ELSE
				#APPEND(fieldnameECL, ', \'' + TRIM(useFields[%nField%]) + '\'');
				#APPEND(statvalECL, ', le.cnt_' + TRIM(useFields[%nField%]) + '_added');
				#APPEND(statvalECL, ', le.cnt_' + TRIM(useFields[%nField%]) + '_removed');
				#APPEND(statvalECL, ', le.cnt_' + TRIM(useFields[%nField%]) + '_modified');
			#END
			#SET(nField, %nField% + 1);
		#END
		#APPEND(fieldnameECL, '  , \'UNKNOWN\');\n');
		#APPEND(statvalECL, ', 0);\n');
		#APPEND(outECL, %'fieldnameECL'%);
		#APPEND(outECL, %'statvalECL'%);
		#APPEND(outECL, '  SELF.measureType := \'CntRecs\';\n');
		#APPEND(outECL, '  SELF.statCategory := \'FieldInfo\';\n');
		#APPEND(outECL, '  SELF.statCategory_More := CHOOSE(cnt % 3, \'added\', \'removed\', \'modified\');\n');
		#APPEND(outECL, '  useSuffix := IF(TRIM(suffixIn) > \'\', \'_\' + suffixIn, \'\');\n');
		#APPEND(outECL, '  SELF.statDesc := CHOOSE(cnt % 3, \'FieldInfo:\' + TRIM(SELF.field) + \':CntRecs_Add\' + useSuffix, \'FieldInfo:\' + TRIM(SELF.field) + \':CntRecs_Remove\' + useSuffix, \'FieldInfo:\' + TRIM(SELF.field) + \':CntRecs_Modify\' + useSuffix);\n');
		#APPEND(outECL, '  SELF := [];\n');
		#APPEND(outECL, 'END;\n');
		#IF (outputECLText)
			OUTPUT(%'outECL'%);
		#ELSE
			%outECL%;
		#END
	ENDMACRO;
	
	EXPORT mac_deltaSourceRidStats(inLayout, useFields, useTimeStamp, srcField, srcRIDField, outputECLText = FALSE) := MACRO
		#DECLARE(outECL);
		#DECLARE(fieldnameECL);
		#DECLARE(statvalECL);
		#DECLARE(nField);
		
		#SET(outECL, '');
		#SET(fieldnameECL, '');
		#SET(statvalECL, '');
		#SET(nField, 1);
		#APPEND(outECL, 'SALT310.Layout_Stats_Standard.Main xBySrcRIDFieldChanges(' + inLayout + 'le, INTEGER cnt, UNSIGNED useTimestamp, STRING suffixIn = \'\', STRING statCategoryMoreIn = \'\') := TRANSFORM\n');
		#APPEND(outECL, '  SELF.dateTimeStamp := useTimeStamp;\n');
		#APPEND(outECL, '  SELF.wuid := WORKUNIT;\n');
		#APPEND(outECL, '  SELF.source := le.' + TRIM(#TEXT(srcField)) + ';\n');
		#APPEND(fieldnameECL, '  SELF.field := IF(cnt < 5, \'\', CHOOSE(((cnt-5) DIV 2) + 1');
		#APPEND(statvalECL, '  SELF.statValue := IF(cnt < 5, CHOOSE(cnt, le.cntnewsourcerids, le.cntoldsourcerids, le.cntchangedsourcerids, le.cntunchangedsourcerids), CHOOSE(cnt-4');
		#LOOP
			#IF (%nField% > COUNT(useFields))
				#BREAK
			#ELSE
			  #IF (STD.Str.ToUpperCase(TRIM(useFields[%nField%])) <> STD.Str.ToUpperCase(TRIM(#TEXT(srcField))) AND STD.Str.ToUpperCase(TRIM(useFields[%nField%])) <> STD.Str.ToUpperCase(TRIM(#TEXT(srcRIDField))))
				  #APPEND(fieldnameECL, ', \'' + TRIM(useFields[%nField%]) + '\'');
				  #APPEND(statvalECL, ', le.cntexistssourcerid_' + TRIM(useFields[%nField%]) + '_added');
				  #APPEND(statvalECL, ', le.cntexistssourcerid_' + TRIM(useFields[%nField%]) + '_removed');
				#END
			#END
			#SET(nField, %nField% + 1);
		#END
		#APPEND(fieldnameECL, '  , \'UNKNOWN\'));\n');
		#APPEND(statvalECL, ', 0));\n');
		#APPEND(outECL, %'fieldnameECL'%);
		#APPEND(outECL, %'statvalECL'%);
		#APPEND(outECL, '  SELF.measureType := \'CntSrcRIDs\';\n');
		#APPEND(outECL, '  SELF.statCategory := IF(cnt < 5, \'Summary\', \'FieldInfo\');\n');
		#APPEND(outECL, '  SELF.statCategory_More := IF(cnt < 5, \'\', CHOOSE(cnt % 2, \'added\', \'removed\'));\n');
		#APPEND(outECL, '  useSuffix := IF(TRIM(suffixIn) > \'\', \'_\' + suffixIn, \'\');\n');
		#APPEND(outECL, '  SELF.statDesc := IF(cnt < 5, CHOOSE(cnt, \'Summary:CntSrcRids_New\', \'Summary:CntSrcRids_Old\', \'Summary:CntSrcRids_Changed\', \'Summary:CntSrcRids_Unchanged\'), CHOOSE(cnt % 2, \'FieldInfo:\' + TRIM(SELF.field) + \':CntSrcRids_Add\' + useSuffix, \'FieldInfo:\' + TRIM(SELF.field) + \':CntSrcRids_Remove\' + useSuffix));\n');
		#APPEND(outECL, '  SELF := [];\n');
		#APPEND(outECL, 'END;\n');
		#IF (outputECLText)
			OUTPUT(%'outECL'%);
		#ELSE
			%outECL%;
		#END
	ENDMACRO;
	
	EXPORT MAC_ingestInfileOverallCount(cntIn, labelIn, useTimeStamp) := FUNCTIONMACRO
		SALT310.Layout_Stats_Standard.Main xCnt() := TRANSFORM
			SELF.dateTimeStamp := useTimestamp;
			SELF.wuid := WORKUNIT;
			SELF.statCategory := 'Ingest';
			SELF.statCategory_More := TRIM(labelIn) + '_All';
			SELF.measureType := 'CntRecs';
			SELF.statDesc := 'Summary:CntRecs_' + TRIM(labelIn) + '_All';
			SELF.statValue := cntIn;
			SELF := [];
		END;
		
		RETURN DATASET([xCnt()]);
	ENDMACRO;
	EXPORT MAC_ingestInfileSourceCounts(ingestSrcCntsIn, srcField, useTimeStamp) := FUNCTIONMACRO
		SALT310.Layout_Stats_Standard.Main xSrcCnts(ingestSrcCntsIn le) := TRANSFORM
			SELF.dateTimeStamp := useTimestamp;
			SELF.wuid := WORKUNIT;
			#IF(TRIM(#TEXT(srcField)) > '')
				SELF.source := le.srcField;
			#END
			SELF.statCategory := 'Ingest';
			SELF.statCategory_More := 'Infile_All';
			SELF.measureType := 'CntRecs';
			SELF.statDesc := 'Summary:CntRecs_Infile_All';
			SELF.statValue := le.cnt;
			SELF := [];
		END;
		
		RETURN PROJECT(ingestSrcCntsIn, xSrcCnts(LEFT));
	ENDMACRO;
	
	EXPORT MAC_ingestStatus(ingestStatusStatsIn, srcField = '', useTimeStamp) := FUNCTIONMACRO
		SALT310.Layout_Stats_Standard.Main xIngestStatus(ingestStatusStatsIn le) := TRANSFORM
			SELF.dateTimeStamp := useTimestamp;
			SELF.wuid := WORKUNIT;
			#IF(TRIM(#TEXT(srcField)) > '')
				SELF.source := le.srcField;
			#END
			SELF.statCategory := 'Ingest';
			SELF.statCategory_More := le.ingeststatus;
			SELF.measureType := 'CntRecs';
			SELF.statDesc := 'Summary:CntRecs_' + TRIM(le.ingeststatus);
			SELF.statValue := le.cnt;
			SELF := [];
		END;
		
		RETURN PROJECT(ingestStatusStatsIn, xIngestStatus(LEFT));
	ENDMACRO;
	
END;
