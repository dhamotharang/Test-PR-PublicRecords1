/*USAGE GUIDE//////////////////////////////////////////////////////////////////

See W20170310-142037 in Alpha Dev for an example use.

This functionmacro is designed to compare two versions of a header file and denote change, per source.

REQUIRED:
------------------------------------------
in_base				:		Current version of the file. 
in_father			:		Previous version of the file.
rec_id				:		Record identifier field.

OPTIONAL:
------------------------------------------
src_field			:		Source field. If blank, the result will only have one row, which is 'TOTAL'.	
inFields			:		Set of fields to compare. If blank, the result will only have 5 columns (unless dtFields are specified): src, cnt, cntNew, cntDeleted, cntUnchanged, cntUpdated.
src_rid_field	:		Source rid field. For use across SALT Ingest and similar processes where one source rid may spawn multiple rec_id rows when a field is changed. If blank, the result will only compare using the rec_id field.
dtFields			:		Set of date fields to compare. If blank, the result will not include the date comparison columns.
inPersist			:		Infix to be applied to persists. If blank, no persists will be generated. Use persists if you are expecting to run this macro with at least one of the same files, with the same fields, multiple times against other file versions.
debug					:		For development. Setting this flag to TRUE outputs the ECL generated as a string instead.

/////////////////////////////////////////////////////////////////////////////*/


EXPORT SourceStats(in_base,in_father,rec_id,src_field = '',inFields = '',inPersist = '',debug = FALSE) := functionmacro

	#DECLARE(fieldCnt)
	#IF(#TEXT(inFields) <> '')
		#SET(fieldCnt, 'local cnt_fields := COUNT(' + #TEXT(inFields) + ');\n\t');
	#ELSE
		#SET(fieldCnt, 'local cnt_fields := 0;\n\t');
	#END
	
	%fieldCnt%
	
	#DECLARE (field)
	#DECLARE (fieldtype)
	#DECLARE (finalTables)
	
	#IF(#TEXT(src_field) <> '')
		#SET(field, #TEXT(in_base) +'.'+#TEXT(src_field));
		#SET(fieldtype, #GETDATATYPE(%field%));
	#ELSE
		#SET(fieldtype, 'string9');
	#END

	#UNIQUENAME(slimInputLayout);
	
	#SET(finalTables, %'slimInputLayout'% + ' := RECORD \n\t unsigned ' + #TEXT(rec_id) + ';\n\t '+%'fieldtype'% +' src;');
	
	#DECLARE (Ndx)
	#SET (Ndx,1);
	
	#DECLARE (currentField)
	
	#LOOP
		#IF (%Ndx% > cnt_fields)
			#BREAK
		#ELSE
			#SET(field, #TEXT(in_base) +'.'+inFields[%Ndx%]);
			#SET(fieldtype, #GETDATATYPE(%field%));
			#SET(currentField, inFields[%Ndx%]);
			#APPEND(finalTables, ' \n\t'+%'fieldtype'% + ' ' + %'currentField'% + ';');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#APPEND(finalTables,'\n\t END;\n\t');
	
	#UNIQUENAME(base);

	#IF(#TEXT(src_field) <> '') #APPEND(finalTables,%'base'% + ' := PROJECT('+#TEXT(in_base)+',TRANSFORM('+%'slimInputLayout'%+',self.src:=left.'+#TEXT(src_field)+',self:=left));\n\t'); #ELSE #APPEND(finalTables,%'base'%+' := PROJECT('+#TEXT(in_base)+',TRANSFORM('+%'slimInputLayout'%+',self.src:=\'TOTAL\',self:=left));\n\t'); #END
	
	#UNIQUENAME(father);
	
	#IF(#TEXT(src_field) <> '') #APPEND(finalTables,%'father'%+' := PROJECT('+#TEXT(in_father)+',TRANSFORM('+%'slimInputLayout'%+',self.src:=left.'+#TEXT(src_field)+',self:=left)); \n\t');#ELSE #APPEND(finalTables,%'father'%+' := PROJECT('+#TEXT(in_father)+',TRANSFORM('+%'slimInputLayout'%+',self.src:=\'TOTAL\',self:=left));\n\t'); #END
	
	#UNIQUENAME(base_ded);
	#UNIQUENAME(father_ded);
	
	#APPEND(finalTables,%'base_ded'%+' := DEDUP(SORT(DISTRIBUTE('+%'base'%+','+#TEXT(rec_id)+'),'+#TEXT(rec_id)+',LOCAL),'+#TEXT(rec_id)+',LOCAL)');
	#IF(#TEXT(inPersist) <> '') #APPEND(finalTables,': PERSIST(\'~thor::linkingTools::sourceStats::'+#TEXT(inPersist)+'::base_ded\',EXPIRE(30));\n\t '); #ELSE #APPEND(finalTables,';\n\t '); #END
	#APPEND(finalTables,%'father_ded'%+' := DEDUP(SORT(DISTRIBUTE('+%'father'%+','+#TEXT(rec_id)+'),'+#TEXT(rec_id)+',LOCAL),'+#TEXT(rec_id)+',LOCAL)');	
	#IF(#TEXT(inPersist) <> '') #APPEND(finalTables,': PERSIST(\'~thor::linkingTools::sourceStats::'+#TEXT(inPersist)+'::father_ded\',EXPIRE(30));\n\t'); #ELSE #APPEND(finalTables,';\n\t'); #END
	
	#UNIQUENAME(recordDataRec);
	
	#APPEND(finalTables,%'recordDataRec'%+' := RECORD \n\t unsigned recId_father; \n\t unsigned recId_base; \n\t '+%'slimInputLayout'%+'.src;');
	
	#SET (Ndx,1);	
	#LOOP
		#IF (%Ndx% > cnt_fields)
			#BREAK
		#ELSE
			#SET(field, #TEXT(in_base) + '.'+inFields[%Ndx%]);
			#SET(fieldtype, #GETDATATYPE(%field%));
			#SET(currentField, inFields[%Ndx%]);
			#APPEND(finalTables, ' \n\t'+%'fieldtype'% + ' ' + 'father_'+%'currentField'% + '; \n\t'
																		+%'fieldtype'% + ' ' + 'base_'+%'currentField'% + '; \n\t'
																		+'boolean '+%'currentField'%+'_added; \n\t'
																		+'boolean '+%'currentField'%+'_removed; \n\t'
																		+'boolean '+%'currentField'%+'_modified; \n\t'
																		+'boolean '+%'currentField'%+'_newlyadded; \n\t'
																		+'boolean '+%'currentField'%+'_base_populated;');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#APPEND(finalTables,'\n\t END;\n\t');
	
	#DECLARE (nullValue)
	
	#UNIQUENAME(total_recs);

	#APPEND (finalTables,%'total_recs'%+' := JOIN('+%'base_ded'%+','+%'father_ded'%+',LEFT.'+#TEXT(rec_id)+' = RIGHT.'+#TEXT(rec_id)+',TRANSFORM('+%'recordDataRec'%+',SELF.recId_father := RIGHT.'+#TEXT(rec_id)+';\n\tSELF.recId_base := LEFT.'+#TEXT(rec_id)+';\n\tSELF.src := IF(RIGHT.src<>\'\',RIGHT.src,LEFT.src);\n\t ');
	
	#SET (Ndx,1);
	#LOOP
		#IF (%Ndx% > cnt_fields)
			#BREAK
		#ELSE
			#SET(field, #TEXT(in_base) + '.'+inFields[%Ndx%]);
			#SET(currentField, inFields[%Ndx%]);
			#SET(fieldtype, #GETDATATYPE(%field%));
			#IF (STD.str.find(%'fieldtype'%,'string',1) > 0)
				#SET(nullValue,'\'\'');
			#ELSE
				#SET(nullValue,0);
			#END
			#APPEND(finalTables,'SELF.'+'father_'+ %'currentField'% + ' := RIGHT.' + %'currentField'% + ';\n\t');
			#APPEND(finalTables,'SELF.'+'base_'+ %'currentField'% + ' := LEFT.' + %'currentField'% + ';\n\t');
			#APPEND(finalTables,'SELF.' + %'currentField'% + '_added := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND RIGHT.' + %'currentField'% + ' = ' + %'nullValue'% + ' AND RIGHT.'+#TEXT(rec_id)+' <> 0,TRUE,FALSE);\n\t');
			#APPEND(finalTables,'SELF.' + %'currentField'% + '_removed := IF(LEFT.' + %'currentField'% + ' = ' + %'nullValue'% + ' AND RIGHT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND LEFT.'+#TEXT(rec_id)+' <> 0,TRUE,FALSE);\n\t');
			#APPEND(finalTables,'SELF.' + %'currentField'% + '_modified := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND RIGHT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND LEFT.' + %'currentField'% + ' <> RIGHT.' + %'currentField'% + ',TRUE,FALSE);\n\t');
			#APPEND(finalTables,'SELF.' + %'currentField'% + '_newlyadded := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ' AND RIGHT.'+#TEXT(rec_id)+' = 0,TRUE,FALSE);\n\t');
			#APPEND(finalTables,'SELF.' + %'currentField'% + '_base_populated := IF(LEFT.' + %'currentField'% + ' <> ' + %'nullValue'% + ',TRUE,FALSE);\n\t');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#APPEND(finalTables,'),LOCAL,FULL OUTER);\n\t');
	
	#UNIQUENAME(finalSrcRec);
	#APPEND(finalTables,%'finalSrcRec'%+' := RECORD \n\t '+%'total_recs'%+'.src; \n\t unsigned cnt := COUNT(GROUP,'+%'total_recs'%+'.recId_base <> 0); \n\t unsigned cntNew := COUNT(GROUP,'+%'total_recs'%+'.recId_father = 0); \n\t unsigned cntDeleted := COUNT(GROUP,'+%'total_recs'%+'.recId_base = 0); \n\t unsigned cntUnchanged := COUNT(GROUP,'+%'total_recs'%+'.recId_base <> 0 AND '+%'total_recs'%+'.recId_father <> 0');
	
	#SET (Ndx,1);
	
	#LOOP
		#IF (%Ndx% > cnt_fields)
			#BREAK
		#ELSE
			#SET(currentField, inFields[%Ndx%]);
			#APPEND(finalTables,' AND NOT('+%'total_recs'%+'.' + %'currentField'% + '_added OR ' + %'total_recs'%+'.' + %'currentField'% + '_removed OR ' + %'total_recs'%+'.' + %'currentField'% + '_modified OR ' + %'total_recs'%+'.' + %'currentField'% + '_newlyadded)');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#IF (cnt_fields > 0)
		#APPEND(finalTables,'); \n\t unsigned cntUpdated := COUNT(GROUP,'+%'total_recs'%+'.recId_base <> 0 AND '+%'total_recs'%+'.recId_father <> 0');
	#ELSE
		#APPEND(finalTables,'); \n\t unsigned cntUpdated := 0');
	#END
	
	#SET (Ndx,1);
	
	#LOOP
		#IF (%Ndx% > cnt_fields)
			#BREAK
		#ELSE
			#SET(currentField, inFields[%Ndx%]);
			#IF(%Ndx% = 1)
				#APPEND(finalTables,' AND(');
			#ELSE
				#APPEND(finalTables,' OR');
			#END
			#APPEND(finalTables,' ('+%'total_recs'%+'.' + %'currentField'% + '_added OR ' + %'total_recs'%+'.' + %'currentField'% + '_removed OR ' + %'total_recs'%+'.' + %'currentField'% + '_modified OR ' + %'total_recs'%+'.' + %'currentField'% + '_newlyadded)');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#IF(cnt_fields > 0)
		#APPEND(finalTables,'));');
	#ELSE
		#APPEND(finalTables,';');
	#END
	
	#SET (Ndx,1);
	
	#LOOP
		#IF (%Ndx% > cnt_fields)
			#BREAK
		#ELSE
			#SET(currentField, inFields[%Ndx%]);
			#APPEND(finalTables,' \n\t unsigned ' + %'currentField'% + '_added := COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_added);');
			#APPEND(finalTables,' \n\t unsigned ' + %'currentField'% + '_removed := COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_removed);');
			#APPEND(finalTables,' \n\t unsigned ' + %'currentField'% + '_modified := COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_modified);');
			#APPEND(finalTables,' \n\t unsigned ' + %'currentField'% + '_newlyadded := COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_newlyadded);');
			#APPEND(finalTables,' \n\t real4 ' + %'currentField'% + '_base_population := ROUND((COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_base_populated) / COUNT(GROUP,'+%'total_recs'%+'.recId_base <> 0))*100,2);');
			#APPEND(finalTables,' \n\t real4 ' + %'currentField'% + '_new_population := ROUND((COUNT(GROUP,'+%'total_recs'%+'.' + %'currentField'% + '_newlyadded) / COUNT(GROUP,'+%'total_recs'%+'.recId_father = 0))*100,2);');
			#SET(Ndx,%Ndx%+1);
		#END
	#END
	
	#APPEND(finalTables,' \n\t END;\n\t');
	
	#UNIQUENAME(tab_src);
	
	#APPEND(finalTables, %'tab_src'%+' := TABLE('+%'total_recs'%+','+%'finalSrcRec'%+',src,few);\n\t')
	
	#UNIQUENAME(tab_total);
	
	#IF(#TEXT(src_field) <> '') #APPEND(finalTables, %'tab_total'%+' := PROJECT(TABLE('+%'total_recs'%+','+%'finalSrcRec'%+'),TRANSFORM(recordof(left),self.src:=\'TOTAL\',self:=left));\n\t'); #ELSE #APPEND(finalTables, %'tab_total'%+' := DATASET([],'+%'finalSrcRec'%+');\n\t'); #END
	
	#UNIQUENAME(tab_overall);
	
	#APPEND(finalTables,%'tab_overall'%+' := '+%'tab_src'%+' + '+%'tab_total'%+';\n\t return '+%'tab_overall'%+';');
	
	#IF(debug = FALSE) %finalTables% #ELSE return %'finalTables'%; #END

ENDMACRO;