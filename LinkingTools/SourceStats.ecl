/*USAGE GUIDE//////////////////////////////////////////////////////////////////

See following workunits in Alpha Dev for an example use:

W20170817-163953 - bare minimum inputs
W20170817-165650 - add src_field - results in additional rows
W20170817-170126 - add inFields input - results in additional fields on output
W20170817-170820 - add src_rid_field - results in cntNew_RecDefining field added to output, different results for several fields
W20170817-172948 - add dtFields input - results in additional fields on output

W20171218-175339 - additional test with layered dataset and booleans

This functionmacro is designed to compare two versions of a header file and denote change, per source.

REQUIRED:
------------------------------------------
in_base				:		Current version of the file. 
in_father			:		Previous version of the file.
rec_id				:		Record identifier field.

OPTIONAL:
------------------------------------------
src_field			:		Source field. If blank, the result will only have one row, which is 'TOTAL'. The name for this field is defaulted to 'src' if no source field is provided.	
inFields			:		Set of fields to compare. If blank, the result will only have 5 columns (unless src_rid_field or dtFields are specified): src, cnt, cntNew, cntDeleted, cntUnchanged, cntUpdated. Acceptable data types are integer, real, decimal, string, qstring, and boolean (not recommended due to null values and actual FALSEs being indistinguishable).
src_rid_field	:		Source rid field. For use across SALT Ingest and similar processes where one source rid may spawn multiple rec_id rows when a field is changed. If blank, the result will only compare using the rec_id field. Including source rid generates a new column on the output called cntNewRecDefining, for new record ids from existing source rids.
dtFields			:		Set of date fields to compare. If blank, the result will not include the date comparison columns.
asOfDate			:		Latest valid date to be used for dtField calculations. If blank, will default to today's date.
inPersist			:		Infix to be applied to persists. If blank, no persists will be generated. Use persists if you are expecting to run this macro with at least one of the same files, with the same fields, multiple times against other file versions.
debug					:		For development. Setting this flag to TRUE outputs the ECL generated as a string instead.

/////////////////////////////////////////////////////////////////////////////*/
IMPORT ut;

EXPORT SourceStats(in_base,in_father,rec_id,src_field = '',inFields = '',src_rid_field = '',dtFields = '',asOfDate = '',inPersist = '',debug = FALSE) := functionmacro
	
	//get field counts
	#UNIQUENAME(cnt_fields);
	#DECLARE(fieldCnt)
	#IF(#TEXT(inFields) <> '')
		#SET(fieldCnt, %'cnt_fields'% + ' := COUNT(' + #TEXT(inFields) + ');\n\t');
	#ELSE
		#SET(fieldCnt, %'cnt_fields'% + ' := 0;\n\t');
	#END
	
	//get dtField counts
	#UNIQUENAME(cnt_dtfields);
	#IF(#TEXT(dtFields) <> '')
		#APPEND(fieldCnt, %'cnt_dtfields'% + ' := COUNT(' + #TEXT(dtFields) + ');\n\t');
	#ELSE
		#APPEND(fieldCnt, %'cnt_dtfields'% + ' := 0;\n\t');
	#END
	
	//get asOfDate
	#UNIQUENAME(asOfDateClean);
	#IF(#TEXT(asOfDate) <> '')
		#APPEND(fieldCnt, %'asOfDateClean'% + ' := MAP(length((string)'+ #TEXT(asOfDate) + ') = 4 => (unsigned)((string)'+ #TEXT(asOfDate) + ' + \'0101\'),length((string)'+ #TEXT(asOfDate) + ') = 6 => (unsigned)((string)'+ #TEXT(asOfDate) + ' + \'01\'),length((string)'+ #TEXT(asOfDate) + ') = 8 => (unsigned)((string)'+ #TEXT(asOfDate) + '),length((string)'+ #TEXT(asOfDate) + ') > 8 => (unsigned)(((string)'+ #TEXT(asOfDate) + ')[..8]),(unsigned)(thorlib.wuid()[2..9]));\n\t');
	#ELSE
		#APPEND(fieldCnt, %'asOfDateClean'% + ' := (unsigned)(thorlib.wuid()[2..9]);\n\t');
	#END
	
	%fieldCnt%
	
	#DECLARE (field)
	#DECLARE (fieldtype)
	#DECLARE (finalTables)
	#DECLARE (sourceName)
	
	#IF(#TEXT(src_field) <> '')
		#SET(field, #TEXT(in_base) +'.'+#TEXT(src_field));
		#SET(fieldtype, #GETDATATYPE(%field%));
		#IF(%'fieldtype'%[..6] <> 'string')
			#SET(fieldtype,'string9');
		#ELSE
			#IF((unsigned)(%'fieldtype'%[7]) < 5)
				#SET(fieldtype,'string5');
			#END
		#END
		#SET(sourceName, #TEXT(src_field));
	#ELSE
		#SET(fieldtype, 'string9');
		#SET(sourceName, 'src');
	#END

	#UNIQUENAME(slimInputLayout);
	
	// construct layout... these fields will always be on
	#SET(finalTables, %'slimInputLayout'% + ' := RECORD \n\t unsigned ' + #TEXT(rec_id) + ';\n\t '+%'fieldtype'% +' ' + %'sourceName'% + ';');
	
	//src_rid field only if input is populated
	#IF(#TEXT(src_rid_field) <> '')
		#SET(field, #TEXT(in_base) + '.' + #TEXT(src_rid_field));
		#SET(fieldtype, #GETDATATYPE(%field%));
		#APPEND(finalTables,'\n\t'+%'fieldtype'% + ' ' + #TEXT(src_rid_field) + ';');
	#END
	
	#DECLARE (Ndx)
	#SET (Ndx,1);
	
	#DECLARE (Idx)
	#DECLARE (currentField)
	
	//add fields to layout
	#LOOP
		#IF (%Ndx% > %cnt_fields%)
			#BREAK
		#ELSE
			#SET(field, #TEXT(in_base) +'.'+inFields[%Ndx%]);
			#SET(fieldtype, #GETDATATYPE(%field%));
			#SET (Idx,STD.Str.FindCount(inFields[%Ndx%],'.'));
			#SET(currentField, inFields[%Ndx%][STD.str.find(inFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables, '\n\t'+%'fieldtype'% + ' ' + %'currentField'% + ';');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#SET (Ndx,1);
	
	//add dtFields to layout
	#LOOP
		#IF (%Ndx% > %cnt_dtfields%)
			#BREAK
		#ELSE
			#SET(field, #TEXT(in_base) +'.'+dtFields[%Ndx%]);
			#SET(fieldtype, #GETDATATYPE(%field%));
			#SET (Idx,STD.Str.FindCount(dtFields[%Ndx%],'.'));
			#SET(currentField, dtFields[%Ndx%][STD.str.find(dtFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables, ' \n\t'+%'fieldtype'% + ' ' + %'currentField'% + ';');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#APPEND(finalTables,'\n\t END;\n\t');
	
	#UNIQUENAME(base);
	
	//slim input files to only necessary fields
	#IF(#TEXT(src_field) <> '') #APPEND(finalTables,%'base'% + ' := PROJECT('+#TEXT(in_base)+',TRANSFORM('+%'slimInputLayout'%+',self.'+%'sourceName'%+':=left.'+#TEXT(src_field)+','); #ELSE #APPEND(finalTables,%'base'%+' := PROJECT('+#TEXT(in_base)+',TRANSFORM('+%'slimInputLayout'%+',self.'+%'sourceName'%+':=\'TOTAL\','); #END
	
	#SET (Ndx,1);
	#LOOP
		#IF (%Ndx% > %cnt_fields%)
			#BREAK
		#ELSE
			#SET (Idx,STD.Str.FindCount(inFields[%Ndx%],'.'));
			#SET(currentField, inFields[%Ndx%][STD.str.find(inFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables, ' self.' + %'currentField'% + ' := left.' + inFields[%Ndx%] + ',');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#SET (Ndx,1);
	#LOOP
		#IF (%Ndx% > %cnt_dtfields%)
			#BREAK
		#ELSE
			#SET (Idx,STD.Str.FindCount(dtFields[%Ndx%],'.'));
			#SET(currentField, dtFields[%Ndx%][STD.str.find(dtFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables, ' self.' + %'currentField'% + ' := left.' + dtFields[%Ndx%] + ',');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#APPEND(finalTables,' self:=left));\n\t');
	
	#UNIQUENAME(father);
	
	#IF(#TEXT(src_field) <> '') #APPEND(finalTables,%'father'%+' := PROJECT('+#TEXT(in_father)+',TRANSFORM('+%'slimInputLayout'%+',self.'+%'sourceName'%+':=left.'+#TEXT(src_field)+',');#ELSE #APPEND(finalTables,%'father'%+' := PROJECT('+#TEXT(in_father)+',TRANSFORM('+%'slimInputLayout'%+',self.'+%'sourceName'%+':=\'TOTAL\','); #END
	
	#SET (Ndx,1);
	#LOOP
		#IF (%Ndx% > %cnt_fields%)
			#BREAK
		#ELSE
			#SET (Idx,STD.Str.FindCount(inFields[%Ndx%],'.'));
			#SET(currentField, inFields[%Ndx%][STD.str.find(inFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables, ' self.' + %'currentField'% + ' := left.' + inFields[%Ndx%] + ',');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#SET (Ndx,1);
	#LOOP
		#IF (%Ndx% > %cnt_dtfields%)
			#BREAK
		#ELSE
			#SET (Idx,STD.Str.FindCount(dtFields[%Ndx%],'.'));
			#SET(currentField, dtFields[%Ndx%][STD.str.find(dtFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables, ' self.' + %'currentField'% + ' := left.' + dtFields[%Ndx%] + ',');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#APPEND(finalTables,' self:=left));\n\t');
	
	#UNIQUENAME(base_ded);
	#UNIQUENAME(father_ded);
	
	//dedup by record id - could mask duplicate rid issues. Consider changing
	#APPEND(finalTables,%'base_ded'%+' := DEDUP(SORT(DISTRIBUTE('+%'base'%+','+#TEXT(rec_id)+'),'+#TEXT(rec_id)+',LOCAL),'+#TEXT(rec_id)+',LOCAL)');
	#IF(#TEXT(inPersist) <> '') #APPEND(finalTables,': PERSIST(\'~thor::linkingTools::sourceStats::'+#TEXT(inPersist)+'::base_ded\',EXPIRE(30));\n\t '); #ELSE #APPEND(finalTables,';\n\t '); #END
	#APPEND(finalTables,%'father_ded'%+' := DEDUP(SORT(DISTRIBUTE('+%'father'%+','+#TEXT(rec_id)+'),'+#TEXT(rec_id)+',LOCAL),'+#TEXT(rec_id)+',LOCAL)');	
	#IF(#TEXT(inPersist) <> '') #APPEND(finalTables,': PERSIST(\'~thor::linkingTools::sourceStats::'+#TEXT(inPersist)+'::father_ded\',EXPIRE(30));\n\t'); #ELSE #APPEND(finalTables,';\n\t'); #END
	
	#UNIQUENAME(recordDataRec);
	
	//create boolean layout
	#APPEND(finalTables,%'recordDataRec'%+' := RECORD\n\t unsigned recId_father;\n\t unsigned recId_base;\n\t '+%'slimInputLayout'%+'.'+%'sourceName'%+';');
	#IF(#TEXT(src_rid_field) <> '')
		#SET(field, #TEXT(in_base) + '.' + #TEXT(src_rid_field));
		#SET(fieldtype, #GETDATATYPE(%field%));
		#APPEND(finalTables,'\n\t '+%'fieldtype'%+' src_rid_father;\n\t '+%'fieldtype'%+' src_rid_base;\n\t boolean recId_match;');
	#END
	
	//add fields to boolean layout
	#SET (Ndx,1);	
	#LOOP
		#IF (%Ndx% > %cnt_fields%)
			#BREAK
		#ELSE
			#SET(field, #TEXT(in_base) + '.'+inFields[%Ndx%]);
			#SET(fieldtype, #GETDATATYPE(%field%));
			#SET (Idx,STD.Str.FindCount(inFields[%Ndx%],'.'));
			#SET(currentField, inFields[%Ndx%][STD.str.find(inFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables, '\n\t'+%'fieldtype'% + ' ' + 'father_'+%'currentField'% + ';\n\t'
																		+%'fieldtype'% + ' ' + 'base_'+%'currentField'% + ';\n\t'
																		+'boolean '+%'currentField'%+'_added;\n\t'
																		+'boolean '+%'currentField'%+'_removed;\n\t'
																		+'boolean '+%'currentField'%+'_modified;\n\t'
																		+'boolean '+%'currentField'%+'_newlyadded;\n\t'
																		+'boolean '+%'currentField'%+'_base_populated;');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	//add dtFields to booolean layout
	#SET (Ndx,1);	
	#LOOP
		#IF (%Ndx% > %cnt_dtfields%)
			#BREAK
		#ELSE
			#SET (Idx,STD.Str.FindCount(dtFields[%Ndx%],'.'));
			#SET(currentField, dtFields[%Ndx%][STD.str.find(dtFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables, ' \n\t unsigned father_'+%'currentField'% + '; \n\t'
																		+'unsigned base_'+%'currentField'% + '; \n\t'
																		+'boolean new_'+%'currentField'%+'_future; \n\t'
																		+'boolean new_'+%'currentField'%+'_current; \n\t'
																		+'boolean new_'+%'currentField'%+'_3_months; \n\t'
																		+'boolean new_'+%'currentField'%+'_6_months; \n\t'
																		+'boolean new_'+%'currentField'%+'_12_months; \n\t'
																		+'boolean new_'+%'currentField'%+'_24_months; \n\t'
																		+'boolean new_'+%'currentField'%+'_older; \n\t'
																		+'boolean change_'+%'currentField'%+'_from_zero; \n\t'
																		+'boolean change_'+%'currentField'%+'_to_zero; \n\t'
																		+'boolean change_'+%'currentField'%+'_modified_1_month; \n\t'
																		+'boolean change_'+%'currentField'%+'_modified_3_months; \n\t'
																		+'boolean change_'+%'currentField'%+'_modified_6_months; \n\t'
																		+'boolean change_'+%'currentField'%+'_modified_12_months; \n\t'
																		+'boolean change_'+%'currentField'%+'_modified_24_months; \n\t'
																		+'boolean change_'+%'currentField'%+'_modified_longer;');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#APPEND(finalTables,'\n\t END;\n\t');
	
	#DECLARE (nullValue)
	
	#UNIQUENAME(total_recs_pre);

	//join base and father and populate booleans. If source_rid field populated, use src and src_rid for join. Otherwise use rec_id
	#IF(#TEXT(src_rid_field) <> '')
		#APPEND(finalTables,%'total_recs_pre'%+' := JOIN(DISTRIBUTE('+%'base_ded'%+'(' + #TEXT(src_rid_field) + ' != 0),'+#TEXT(src_rid_field)+'),DISTRIBUTE('+%'father_ded'%+'(' + #TEXT(src_rid_field) + ' != 0),'+#TEXT(src_rid_field)+'),LEFT.'+#TEXT(src_rid_field)+' = RIGHT.'+#TEXT(src_rid_field)+' AND LEFT.'+%'sourceName'%+' = RIGHT.'+%'sourceName'%+',TRANSFORM('+%'recordDataRec'%+',SELF.recId_father := RIGHT.'+#TEXT(rec_id)+';\n\tSELF.recId_base := LEFT.'+#TEXT(rec_id)+';\n\tSELF.'+%'sourceName'%+' := IF(RIGHT.'+%'sourceName'%+'<>\'\',RIGHT.'+%'sourceName'%+',LEFT.'+%'sourceName'%+');\n\tSELF.src_rid_father := RIGHT.'+#TEXT(src_rid_field)+';\n\tSELF.src_rid_base := LEFT.'+#TEXT(src_rid_field)+';\n\tSELF.recId_match := IF(LEFT.'+#TEXT(rec_id)+' = RIGHT.'+#TEXT(rec_id)+',TRUE,FALSE);\n\t ');
	#ELSE
		#APPEND(finalTables,%'total_recs_pre'%+' := JOIN('+%'base_ded'%+','+%'father_ded'%+',LEFT.'+#TEXT(rec_id)+' = RIGHT.'+#TEXT(rec_id)+',TRANSFORM('+%'recordDataRec'%+',SELF.recId_father := RIGHT.'+#TEXT(rec_id)+';\n\tSELF.recId_base := LEFT.'+#TEXT(rec_id)+';\n\tSELF.'+%'sourceName'%+' := IF(RIGHT.'+%'sourceName'%+'<>\'\',RIGHT.'+%'sourceName'%+',LEFT.'+%'sourceName'%+');\n\t ');
	#END
	
	//inFields logic for transform
	#SET (Ndx,1);
	#LOOP
		#IF (%Ndx% > %cnt_fields%)
			#BREAK
		#ELSE
			#SET(field, #TEXT(in_base) + '.'+inFields[%Ndx%]);
			#SET (Idx,STD.Str.FindCount(inFields[%Ndx%],'.'));
			#SET(currentField, inFields[%Ndx%][STD.str.find(inFields[%Ndx%],'.',%Idx%)+1..]);
			#SET(fieldtype, #GETDATATYPE(%field%));
			#IF (STD.str.find(%'fieldtype'%,'string',1) > 0)
				#SET(nullValue,'\'\'');
			#ELSEIF (STD.str.find(%'fieldtype'%,'boolean',1) > 0)
				#SET(nullValue,'FALSE');
			#ELSE
				#SET(nullValue,0);
			#END
			#APPEND(finalTables,'SELF.'+'father_'+ %'currentField'% + ' := RIGHT.' + %'currentField'% + ';\n\t');
			#APPEND(finalTables,'SELF.'+'base_'+ %'currentField'% + ' := LEFT.' + %'currentField'% + ';\n\t');
			#IF(#TEXT(src_rid_field) <> '')
				#APPEND(finalTables,'SELF.' + %'currentField'% + '_added := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND RIGHT.' + %'currentField'% + ' = ' + %'nullValue'% + ' AND RIGHT.'+#TEXT(src_rid_field)+' <> 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.' + %'currentField'% + '_removed := IF(LEFT.' + %'currentField'% + ' = ' + %'nullValue'% + ' AND RIGHT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND LEFT.'+#TEXT(src_rid_field)+' <> 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.' + %'currentField'% + '_modified := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND RIGHT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND LEFT.' + %'currentField'% + ' <> RIGHT.' + %'currentField'% + ',TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.' + %'currentField'% + '_newlyadded := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND RIGHT.'+#TEXT(src_rid_field)+' = 0,TRUE,FALSE);\n\t');
			#ELSE
				#APPEND(finalTables,'SELF.' + %'currentField'% + '_added := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND RIGHT.' + %'currentField'% + ' = ' + %'nullValue'% + ' AND RIGHT.'+#TEXT(rec_id)+' <> 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.' + %'currentField'% + '_removed := IF(LEFT.' + %'currentField'% + ' = ' + %'nullValue'% + ' AND RIGHT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND LEFT.'+#TEXT(rec_id)+' <> 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.' + %'currentField'% + '_modified := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND RIGHT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND LEFT.' + %'currentField'% + ' <> RIGHT.' + %'currentField'% + ',TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.' + %'currentField'% + '_newlyadded := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND RIGHT.'+#TEXT(rec_id)+' = 0,TRUE,FALSE);\n\t');
			#END
			#APPEND(finalTables,'SELF.' + %'currentField'% + '_base_populated := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ',TRUE,FALSE);\n\t');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	//dtFields logic for transform
	#SET (Ndx,1);
	#LOOP
		#IF (%Ndx% > %cnt_dtfields%)
			#BREAK
		#ELSE
			#SET(field, #TEXT(in_base) + '.'+dtFields[%Ndx%]);
			#SET(Idx,STD.Str.FindCount(dtFields[%Ndx%],'.'));
			#SET(currentField, dtFields[%Ndx%][STD.str.find(dtFields[%Ndx%],'.',%Idx%)+1..]);
			#SET(fieldtype, #GETDATATYPE(%field%));
			#APPEND(finalTables,'father_'+ %'currentField'% + ' := MAP(length((string)RIGHT.' + %'currentField'% + ') = 4 => (unsigned)((string)RIGHT.' + %'currentField'% + ' + \'0101\'),length((string)RIGHT.' + %'currentField'% + ') = 6 => (unsigned)((string)RIGHT.' + %'currentField'% + ' + \'01\'),length((string)RIGHT.' + %'currentField'% + ') = 8 => (unsigned)((string)RIGHT.'+ %'currentField'% + '),length((string)RIGHT.'+ %'currentField'% + ') > 8 => (unsigned)(((string)RIGHT.'+ %'currentField'% + ')[..8]),0);\n\tSELF.father_'+ %'currentField'% + ' := father_'+ %'currentField'% + ';\n\t');
			#APPEND(finalTables,'base_'+ %'currentField'% + ' := MAP(length((string)LEFT.' + %'currentField'% + ') = 4 => (unsigned)((string)LEFT.' + %'currentField'% + ' + \'0101\'),length((string)LEFT.' + %'currentField'% + ') = 6 => (unsigned)((string)RIGHT.' + %'currentField'% + ' + \'01\'),length((string)LEFT.' + %'currentField'% + ') = 8 => (unsigned)((string)LEFT.'+ %'currentField'% + '),length((string)LEFT.'+ %'currentField'% + ') > 8 => (unsigned)(((string)LEFT.'+ %'currentField'% + ')[..8]),0);\n\tSELF.base_'+ %'currentField'% + ' := base_'+ %'currentField'% + ';\n\t');
			#IF(#TEXT(src_rid_field) <> '')
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_future := IF(base_' + %'currentField'% + ' > ' + %'asOfDateClean'% + ' AND RIGHT.'+#TEXT(src_rid_field)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_current := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') <= 1 AND RIGHT.'+#TEXT(src_rid_field)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_3_months := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') BETWEEN 2 AND 3 AND RIGHT.'+#TEXT(src_rid_field)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_6_months := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') BETWEEN 4 AND 6 AND RIGHT.'+#TEXT(src_rid_field)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_12_months := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') BETWEEN 7 AND 12 AND RIGHT.'+#TEXT(src_rid_field)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_24_months := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') BETWEEN 13 AND 24 AND RIGHT.'+#TEXT(src_rid_field)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_older := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') > 24 AND RIGHT.'+#TEXT(src_rid_field)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.change_' + %'currentField'% + '_from_zero := IF(base_' + %'currentField'% + ' > 0 AND father_' + %'currentField'% + ' = 0 AND RIGHT.' + #TEXT(src_rid_field) + ' > 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.change_' + %'currentField'% + '_to_zero := IF(base_' + %'currentField'% + ' = 0 AND father_' + %'currentField'% + ' > 0 AND LEFT.' + #TEXT(src_rid_field) + ' > 0,TRUE,FALSE);\n\t');
			#ELSE
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_future := IF(base_' + %'currentField'% + ' > ' + %'asOfDateClean'% + ' AND RIGHT.'+#TEXT(rec_id)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_current := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') <= 1 AND RIGHT.'+#TEXT(rec_id)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_3_months := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') BETWEEN 2 AND 3 AND RIGHT.'+#TEXT(rec_id)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_6_months := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') BETWEEN 4 AND 6 AND RIGHT.'+#TEXT(rec_id)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_12_months := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') BETWEEN 7 AND 12 AND RIGHT.'+#TEXT(rec_id)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_24_months := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') BETWEEN 13 AND 24 AND RIGHT.'+#TEXT(rec_id)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.new_' + %'currentField'% + '_older := IF(base_' + %'currentField'% + ' <= ' + %'asOfDateClean'% + ' AND ut.MonthsApart((string)base_' + %'currentField'% + ',(string)' + %'asOfDateClean'% + ') > 24 AND RIGHT.'+#TEXT(rec_id)+' = 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.change_' + %'currentField'% + '_from_zero := IF(base_' + %'currentField'% + ' > 0 AND father_' + %'currentField'% + ' = 0 AND RIGHT.' + #TEXT(rec_id) + ' > 0,TRUE,FALSE);\n\t');
				#APPEND(finalTables,'SELF.change_' + %'currentField'% + '_to_zero := IF(base_' + %'currentField'% + ' = 0 AND father_' + %'currentField'% + ' > 0 AND LEFT.' + #TEXT(rec_id) + ' > 0,TRUE,FALSE);\n\t');
			#END
			#APPEND(finalTables,'SELF.change_' + %'currentField'% + '_modified_1_month := IF(base_' + %'currentField'% + ' > 0 AND father_' + %'currentField'% + ' > 0 AND ut.MonthsApart((string)father_' + %'currentField'% + ',(string)base_' + %'currentField'% + ') <= 1 AND base_' + %'currentField'% + ' <> father_' + %'currentField'% + ',TRUE,FALSE);\n\t');
			#APPEND(finalTables,'SELF.change_' + %'currentField'% + '_modified_3_months := IF(base_' + %'currentField'% + ' > 0 AND father_' + %'currentField'% + ' > 0 AND ut.MonthsApart((string)father_' + %'currentField'% + ',(string)base_' + %'currentField'% + ') BETWEEN 2 AND 3,TRUE,FALSE);\n\t');
			#APPEND(finalTables,'SELF.change_' + %'currentField'% + '_modified_6_months := IF(base_' + %'currentField'% + ' > 0 AND father_' + %'currentField'% + ' > 0 AND ut.MonthsApart((string)father_' + %'currentField'% + ',(string)base_' + %'currentField'% + ') BETWEEN 4 AND 6,TRUE,FALSE);\n\t');
			#APPEND(finalTables,'SELF.change_' + %'currentField'% + '_modified_12_months := IF(base_' + %'currentField'% + ' > 0 AND father_' + %'currentField'% + ' > 0 AND ut.MonthsApart((string)father_' + %'currentField'% + ',(string)base_' + %'currentField'% + ') BETWEEN 7 AND 12,TRUE,FALSE);\n\t');
			#APPEND(finalTables,'SELF.change_' + %'currentField'% + '_modified_24_months := IF(base_' + %'currentField'% + ' > 0 AND father_' + %'currentField'% + ' > 0 AND ut.MonthsApart((string)father_' + %'currentField'% + ',(string)base_' + %'currentField'% + ') BETWEEN 13 AND 24,TRUE,FALSE);\n\t');
			#APPEND(finalTables,'SELF.change_' + %'currentField'% + '_modified_longer := IF(base_' + %'currentField'% + ' > 0 AND father_' + %'currentField'% + ' > 0 AND ut.MonthsApart((string)father_' + %'currentField'% + ',(string)base_' + %'currentField'% + ') > 24,TRUE,FALSE);\n\t');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#APPEND(finalTables,'),LOCAL,FULL OUTER);\n\t');
	
	/*DEBUG OUTPUT*/
	// #APPEND(finalTables,'OUTPUT('+%'total_recs_pre'%+',ALL,named(\'total_recs_pre\'));\n\t');

	//if src rid was used, need to resolve down to truest form of record changes
	#UNIQUENAME(total_recs);
	#IF(#TEXT(src_rid_field) <> '')
		#APPEND(finalTables,%'total_recs'%+' := '+%'total_recs_pre'%+'(recId_base = 0 OR recId_father = 0) + DEDUP(SORT(DISTRIBUTE('+%'total_recs_pre'%+'(recId_base > 0 AND recId_father > 0),recId_base),recId_base,-recId_match,-recId_father,LOCAL),recId_base,LOCAL);\n\t');
	#ELSE
		#APPEND(finalTables,%'total_recs'%+' := '+%'total_recs_pre'%+';\n\t');
	#END
	
	//record structure for final table by src
	#UNIQUENAME(finalSrcRec);
	#IF(#TEXT(src_rid_field) <> '')
		#APPEND(finalTables,%'finalSrcRec'%+' := RECORD \n\t '+%'total_recs'%+'.'+%'sourceName'%+'; \n\t unsigned cnt := COUNT(GROUP,'+%'total_recs'%+'.recId_base <> 0); \n\t unsigned cntNew := COUNT(GROUP,'+%'total_recs'%+'.src_rid_father = 0);  \n\t unsigned cntDeleted := COUNT(GROUP,'+%'total_recs'%+'.src_rid_base = 0); \n\t unsigned cntUnchanged := COUNT(GROUP,'+%'total_recs'%+'.src_rid_base <> 0 AND '+%'total_recs'%+'.src_rid_father <> 0');
	#ELSE
		#APPEND(finalTables,%'finalSrcRec'%+' := RECORD \n\t '+%'total_recs'%+'.'+%'sourceName'%+'; \n\t unsigned cnt := COUNT(GROUP,'+%'total_recs'%+'.recId_base <> 0); \n\t unsigned cntNew := COUNT(GROUP,'+%'total_recs'%+'.recId_father = 0); \n\t unsigned cntDeleted := COUNT(GROUP,'+%'total_recs'%+'.recId_base = 0); \n\t unsigned cntUnchanged := COUNT(GROUP,'+%'total_recs'%+'.recId_base <> 0 AND '+%'total_recs'%+'.recId_father <> 0');
	#END
	
	#SET (Ndx,1);
	//cntUnchanged - look at all fields specified in inFields. This boolean already accounts for source rid above, if specified
	#LOOP
		#IF (%Ndx% > %cnt_fields%)
			#BREAK
		#ELSE
			#SET (Idx,STD.Str.FindCount(inFields[%Ndx%],'.'));
			#SET(currentField, inFields[%Ndx%][STD.str.find(inFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables,' AND NOT('+%'total_recs'%+'.' + %'currentField'% + '_added OR ' + %'total_recs'%+'.' + %'currentField'% + '_removed OR ' + %'total_recs'%+'.' + %'currentField'% + '_modified OR ' + %'total_recs'%+'.' + %'currentField'% + '_newlyadded)');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	//cntUpdated - look at all fields specified in inFields. If no fields specified, cntUpdated is 0.
	#IF (%cnt_fields% > 0)
		#IF (#TEXT(src_rid_field) <> '')
			#APPEND(finalTables,'); \n\t unsigned cntNew_recDefining := COUNT(GROUP,'+%'total_recs'%+'.src_rid_base <> 0 AND '+%'total_recs'%+'.src_rid_father <> 0 AND '+%'total_recs'%+'.recId_base <> '+%'total_recs'%+'.recId_father); \n\t unsigned cntUpdated := COUNT(GROUP,'+%'total_recs'%+'.src_rid_base <> 0 AND '+%'total_recs'%+'.src_rid_father <> 0 AND '+%'total_recs'%+'.recId_base = '+%'total_recs'%+'.recId_father');
		#ELSE
			#APPEND(finalTables,'); \n\t unsigned cntUpdated := COUNT(GROUP,'+%'total_recs'%+'.recId_base <> 0 AND '+%'total_recs'%+'.recId_father <> 0');
		#END
	#ELSE
		#APPEND(finalTables,'); \n\t unsigned cntUpdated := 0');
	#END
	
	#SET (Ndx,1);
	
	#LOOP
		#IF (%Ndx% > %cnt_fields%)
			#BREAK
		#ELSE
			#SET (Idx,STD.Str.FindCount(inFields[%Ndx%],'.'));
			#SET(currentField, inFields[%Ndx%][STD.str.find(inFields[%Ndx%],'.',%Idx%)+1..]);
			#IF(%Ndx% = 1)
				#APPEND(finalTables,' AND(');
			#ELSE
				#APPEND(finalTables,' OR');
			#END
			#APPEND(finalTables,' ('+%'total_recs'%+'.' + %'currentField'% + '_added OR ' + %'total_recs'%+'.' + %'currentField'% + '_removed OR ' + %'total_recs'%+'.' + %'currentField'% + '_modified OR ' + %'total_recs'%+'.' + %'currentField'% + '_newlyadded)');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#IF(%cnt_fields% > 0)
		#APPEND(finalTables,'));');
	#ELSE
		#APPEND(finalTables,';');
	#END
	
	#SET (Ndx,1);
	//count for each field in inFields, added/removed/modified/newlyadded and population counts
	#LOOP
		#IF (%Ndx% > %cnt_fields%)
			#BREAK
		#ELSE
			#SET (Idx,STD.Str.FindCount(inFields[%Ndx%],'.'));
			#SET(currentField, inFields[%Ndx%][STD.str.find(inFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables,' \n\t unsigned ' + %'currentField'% + '_added := COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_added);');
			#APPEND(finalTables,' \n\t unsigned ' + %'currentField'% + '_removed := COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_removed);');
			#APPEND(finalTables,' \n\t unsigned ' + %'currentField'% + '_modified := COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_modified);');
			#APPEND(finalTables,' \n\t unsigned ' + %'currentField'% + '_newlyadded := COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_newlyadded);');
			#APPEND(finalTables,' \n\t real4 ' + %'currentField'% + '_base_population := ROUND((COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_base_populated) / COUNT(GROUP,'+%'total_recs'%+'.recId_base <> 0))*100,2);');
			#APPEND(finalTables,' \n\t real4 ' + %'currentField'% + '_new_population := ROUND((COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_newlyadded) / COUNT(GROUP,'+%'total_recs'%+'.recId_father = 0))*100,2);');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#SET (Ndx,1);
	//count for each field in dtFields
	#LOOP
		#IF (%Ndx% > %cnt_dtfields%)
			#BREAK
		#ELSE
			#SET (Idx,STD.Str.FindCount(dtFields[%Ndx%],'.'));
			#SET(currentField, dtFields[%Ndx%][STD.str.find(dtFields[%Ndx%],'.',%Idx%)+1..]);
			#APPEND(finalTables,' \n\t unsigned new_' + %'currentField'% + '_future := COUNT(GROUP,'+%'total_recs'%+'.new_' + %'currentField'% + '_future);');
			#APPEND(finalTables,' \n\t unsigned new_' + %'currentField'% + '_current := COUNT(GROUP,'+%'total_recs'%+'.new_' + %'currentField'% + '_current);');
			#APPEND(finalTables,' \n\t unsigned new_' + %'currentField'% + '_3_months := COUNT(GROUP,'+%'total_recs'%+'.new_' + %'currentField'% + '_3_months);');
			#APPEND(finalTables,' \n\t unsigned new_' + %'currentField'% + '_6_months := COUNT(GROUP,'+%'total_recs'%+'.new_' + %'currentField'% + '_6_months);');
			#APPEND(finalTables,' \n\t unsigned new_' + %'currentField'% + '_12_months := COUNT(GROUP,'+%'total_recs'%+'.new_' + %'currentField'% + '_12_months);');
			#APPEND(finalTables,' \n\t unsigned new_' + %'currentField'% + '_24_months := COUNT(GROUP,'+%'total_recs'%+'.new_' + %'currentField'% + '_24_months);');
			#APPEND(finalTables,' \n\t unsigned new_' + %'currentField'% + '_older := COUNT(GROUP,'+%'total_recs'%+'.new_' + %'currentField'% + '_older);');
			#APPEND(finalTables,' \n\t unsigned change_' + %'currentField'% + '_from_zero := COUNT(GROUP,'+%'total_recs'%+'.change_' + %'currentField'% + '_from_zero);');
			#APPEND(finalTables,' \n\t unsigned change_' + %'currentField'% + '_to_zero := COUNT(GROUP,'+%'total_recs'%+'.change_' + %'currentField'% + '_to_zero);');
			#APPEND(finalTables,' \n\t unsigned change_' + %'currentField'% + '_modified_1_month := COUNT(GROUP,'+%'total_recs'%+'.change_' + %'currentField'% + '_modified_1_month);');
			#APPEND(finalTables,' \n\t unsigned change_' + %'currentField'% + '_modified_3_months := COUNT(GROUP,'+%'total_recs'%+'.change_' + %'currentField'% + '_modified_3_months);');
			#APPEND(finalTables,' \n\t unsigned change_' + %'currentField'% + '_modified_6_months := COUNT(GROUP,'+%'total_recs'%+'.change_' + %'currentField'% + '_modified_6_months);');
			#APPEND(finalTables,' \n\t unsigned change_' + %'currentField'% + '_modified_12_months := COUNT(GROUP,'+%'total_recs'%+'.change_' + %'currentField'% + '_modified_12_months);');
			#APPEND(finalTables,' \n\t unsigned change_' + %'currentField'% + '_modified_24_months := COUNT(GROUP,'+%'total_recs'%+'.change_' + %'currentField'% + '_modified_24_months);');
			#APPEND(finalTables,' \n\t unsigned change_' + %'currentField'% + '_modified_longer := COUNT(GROUP,'+%'total_recs'%+'.change_' + %'currentField'% + '_modified_longer);');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#APPEND(finalTables,' \n\t END;\n\t');
	
	/*DEBUG OUTPUT*/
	// #APPEND(finalTables,'OUTPUT('+%'total_recs'%+',named(\'total_recs\'));\n\t');
	
	#UNIQUENAME(tab_src);
	
	#APPEND(finalTables, %'tab_src'%+' := TABLE('+%'total_recs'%+','+%'finalSrcRec'%+','+%'sourceName'%+',few);\n\t')
	
	#UNIQUENAME(tab_total);
	//create a src 'TOTAL', for summed values. If an input src field is not specified, the TOTAL row will be the only row produced (see up top where TOTAL was added as src).
	#IF(#TEXT(src_field) <> '') #APPEND(finalTables, %'tab_total'%+' := PROJECT(TABLE('+%'total_recs'%+','+%'finalSrcRec'%+'),TRANSFORM(recordof(left),self.'+%'sourceName'%+':=\'TOTAL\',self:=left));\n\t'); #ELSE #APPEND(finalTables, %'tab_total'%+' := DATASET([],'+%'finalSrcRec'%+');\n\t'); #END
	
	#UNIQUENAME(tab_overall);
	
	#APPEND(finalTables,%'tab_overall'%+' := '+%'tab_src'%+' + '+%'tab_total'%+';\n\t return '+%'tab_overall'%+';');
	
	#IF(debug = FALSE) %finalTables% #ELSE return %'fieldcnt'%+%'finalTables'%; #END

ENDMACRO;