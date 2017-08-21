EXPORT MOD_Profile(inFile,id_field='',src_field='',CorrelateSampleSize=100000000,out_prefix='') := FUNCTIONMACRO
	LOADXML('<xml/>');
	#EXPORTXML(inFileFields, RECORDOF(inFile));
	
	#DECLARE(recLevel);         // Track the depth of the attribute within the record
	#DECLARE(recName);          // Track the name of an embedded recstruct
	#DECLARE(recFlat);          // Track the "flattened" name of an embedded recstruct (i.e. use an _ instead of a .)
	#DECLARE(fieldCount);       // How many fields we have processed
	#DECLARE(transformClauses); // ECL statements that will be used in a TRANSFORM
	#DECLARE(datasetRecords);   // ECL statements that will be used in a DATASET
	#DECLARE(summaryFields);		// ECL defining fields for the summary TABLE
	#DECLARE(fieldNames);				// ECL listing fieldnames within a CHOOSE
	#DECLARE(fieldPop);					// ECL listing population fields within a CHOOSE
	#DECLARE(fieldMax);					// ECL listing maxlength fields within a CHOOSE
	#DECLARE(fieldAve);					// ECL listing avelength fields within a CHOOSE
	#DECLARE(outCondition);			// ECL listing conditional outputs
	
	// For each top-level attribute, build up ECL statements that will be
	// used in a TRANSFORM statement and a DATASET statement
	#SET(recLevel, 0);
	#SET(recName, '');
	#SET(recFlat, '');
	#SET(fieldCount, 0);
	#SET(transformClauses, '');
	#SET(datasetRecords, '');
	#SET(summaryFields, '');
	#SET(fieldNames, '');
	#SET(fieldPop, '');
	#SET(fieldMax, '');
	#SET(fieldAve, '');
	#SET(outCondition, '');
	#FOR(inFileFields)
		#FOR(field)
			#IF(%{@isRecord}% = 1)
				#SET(recLevel, %recLevel% + 1)
				#SET(recName, %'@name'%+'.')
				#SET(recFlat, %'@name'%+'_')
			#ELSEIF(%{@isDataset}% = 1)
				#SET(recLevel, %recLevel% + 1)
			#ELSEIF(%{@isEnd}% = 1)
				#SET(recLevel, %recLevel% - 1)
				#SET(recName, '')
				#SET(recFlat, '')
			#ELSEIF(%recLevel% = 0 OR (%recLevel%=1 AND %'recName'%<>''))
				// This is a top-level attribute, so process it
				#IF(%fieldCount% > 0)
					#APPEND(transformClauses, ',')
					#APPEND(datasetRecords, ',')
					#APPEND(fieldNames, ',')
					#APPEND(fieldPop, ',')
					#APPEND(fieldMax, ',')
					#APPEND(fieldAve, ',')
				#END
				#SET(fieldCount, %fieldCount% + 1)
				#APPEND(transformClauses, 'TRIM((SALT38.StrType)le.' +%'recName'% + %'@name'% + ')')
				#APPEND(datasetRecords, '{' + %'fieldCount'% + ', \'' + %'@name'% + '\'}')
				#APPEND(summaryFields, 'populated_'+%'recFlat'%+%'@name'%+'_pcnt := AVE(GROUP,IF('+#TEXT(inFile)+'.'+%'recName'%+%'@name'%+' = (TYPEOF('+#TEXT(inFile)+'.'+%'recName'%+%'@name'%+'))\'\',0,100));')
				#APPEND(summaryFields, 'maxlength_'+%'recFlat'%+%'@name'%+' := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)'+#TEXT(inFile)+'.'+%'recName'%+%'@name'%+')));')
				#APPEND(summaryFields, 'avelength_'+%'recFlat'%+%'@name'%+' := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)'+#TEXT(inFile)+'.'+%'recName'%+%'@name'%+')),'+#TEXT(inFile)+'.'+%'recName'%+%'@name'%+'<>(typeof('+#TEXT(inFile)+'.'+%'recName'%+%'@name'%+'))\'\');')
				#APPEND(fieldNames, '\'' + %'recName'%+%'@name'% + '\'')
				#APPEND(fieldPop, 'le.populated_'+%'recFlat'%+%'@name'%+'_pcnt')
				#APPEND(fieldMax, 'le.maxlength_'+%'recFlat'%+%'@name'%)
				#APPEND(fieldAve, 'le.avelength_'+%'recFlat'%+%'@name'%)
			#END
		#END
	#END
	
	#UNIQUENAME(M)
	%M% := MODULE
		#IF(#TEXT(out_prefix)<>'')
			SHARED pfx := out_prefix + '_';
		#ELSE
			SHARED pfx := '';
		#END
		
		// Field Summary
		SummaryLayout := RECORD
			#IF(#TEXT(src_field)<>'')
				src_field := MAX(GROUP,inFile.src_field);
			#END
			NumberOfRecords := COUNT(GROUP);
			%summaryFields%
		END;
		#IF(#TEXT(src_field)<>'')
			EXPORT Summary := TABLE(inFile,SummaryLayout,src_field,FEW);
		#ELSE
			EXPORT Summary := TABLE(inFile,SummaryLayout);
		#END
		EXPORT out_Summary := OUTPUT(Summary,NAMED(pfx+'Summary'),ALL);
		
		// Inverted Field Summary
		invRec := RECORD
			#IF(#TEXT(src_field)<>'')
				inFile.src_field;
			#END
			UNSIGNED  FldNo;
			SALT38.StrType FieldName;
			UNSIGNED NumberOfRecords;
			REAL8  populated_pcnt;
			UNSIGNED  maxlength;
			REAL8  avelength;
		END;
		invRec invert(Summary le, INTEGER C) := TRANSFORM
			#IF(#TEXT(src_field)<>'')
				SELF.src_field := le.src_field;
			#END
			SELF.FldNo := C;
			SELF.NumberOfRecords := le.NumberOfRecords;
			SELF.FieldName := CHOOSE(C,%fieldNames%);
			SELF.populated_pcnt := CHOOSE(C,%fieldPop%);
			SELF.maxlength := CHOOSE(C,%fieldMax%);
			SELF.avelength := CHOOSE(C,%fieldAve%);
		END;
		EXPORT invSummary := NORMALIZE(Summary, %fieldCount%, invert(LEFT,COUNTER));
		EXPORT out_invSummary := OUTPUT(invSummary,NAMED(pfx+'invSummary'),ALL);
		
		// Transform for converting the incoming data into a standard structure
		SALT38.MAC_Character_Counts.X_Data_Layout Into(RECORDOF(inFile) le, UNSIGNED c) := TRANSFORM
			SELF.Fld := CHOOSE(c, %transformClauses%);
			SELF.FldNo := c;
			#IF(#TEXT(id_field)<>'')
				SELF.id := le.id_field;
			#END;
			#IF(#TEXT(src_field)<>'')
				SELF.src := le.src_field;
			#END
		END;
		
		// Apply the transform
		SHARED FldInv0 := NORMALIZE(inFile, %fieldCount%, Into(LEFT,COUNTER));
		
		// Create a dataset enumerating the attributes in the incoming data
		SHARED FldIds := DATASET([%datasetRecords%], SALT38.MAC_Character_Counts.Field_Identification);
		
		// Profiling
		EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0, FldIds);
		EXPORT out_AllProfiles := OUTPUT(AllProfiles,NAMED(pfx+'AllProfiles'),ALL);
		
		
		// Field Correlations
		SALT38.MAC_Correlate.Data_Layout IntoP(inFile le, UNSIGNED C) := TRANSFORM
			SELF.FldNo1 := 1 + (C / %fieldCount%);
			SELF.FldNo2 := 1 + (C % %fieldCount%);
			SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,%transformClauses%));
			SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,%transformClauses%));
			END;
		Pairs0 := NORMALIZE(ENTH(inFile,CorrelateSampleSize),%fieldCount%*%fieldCount%,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
		EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
		EXPORT out_Correlations := OUTPUT(Correlations,NAMED(pfx+'Correlations'),ALL);
	
		// Cluster counts
		#IF(#TEXT(id_field)<>'')
			EXPORT ClusterCounts := SALT38.MOD_ClusterStats.Counts(inFile,id_field);
			EXPORT out_ClusterCounts := OUTPUT(ClusterCounts,NAMED(pfx+'ClusterCounts'),ALL);
			#APPEND(outCondition, ',out_ClusterCounts')
			#IF(#TEXT(src_field)<>'')
				EXPORT ClusterSrc := SALT38.MOD_ClusterStats.Sources(inFile,id_field,src_field);
				EXPORT out_ClusterSrc := OUTPUT(ClusterSrc,NAMED(pfx+'ClusterSrc'),ALL);
				EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0, FldIds);
				EXPORT out_SrcProfiles := OUTPUT(SrcProfiles,NAMED(pfx+'SrcProfiles'),ALL);
				#APPEND(outCondition, ',out_ClusterSrc,out_SrcProfiles')
			#END
		#END
		
		// Outputs
		EXPORT out := PARALLEL(
			out_Summary, 
			out_invSummary, 
			out_AllProfiles, 
			out_Correlations
			#IF(#TEXT(id_field)<>'')
				%outCondition%
			#END
		);
	END;
	RETURN %M%;
ENDMACRO;
	
