EXPORT MAC_Eliminate_Child_Datasets(inData, childDatasetOutputName) := FUNCTIONMACRO
	LOADXML('<xml/>');
	#EXPORTXML(records, RECORDOF(inData))
	
	#DECLARE(eclProjectCode) // Track the TRANSFORM code
	#DECLARE(childDatasetNames) // Track the names of the Child Datasets
	#DECLARE(recLevel); // Track the depth of the attribute within the record
	#DECLARE(fieldCount);
	#DECLARE(childDatasetCount);
	#SET(recLevel, 0);
	#SET(eclProjectCode, '');
	#SET(childDatasetNames, '');
	#SET(fieldCount, 0);
	#SET(childDatasetCount, 0);
	
	#FOR(records)
		#FOR(Field)
			#IF(%@isDataset%=1 AND %recLevel% = 0)
				// Child Dataset at top level - remove it
				#APPEND(eclProjectCode, '-' + %'{@name}'%);
				#APPEND(childDatasetNames, %'{@name}'% + ', ');
				#SET(recLevel, %recLevel% + 1);
				#SET(fieldCount, %fieldCount% + 1);
				#SET(childDatasetCount, %childDatasetCount% + 1);
			#ELSEIF(%recLevel% = 0)
				// Normal field at top level - count it
				#SET(fieldCount, %fieldCount% + 1);
			#ELSEIF(%{@isEnd}% = 1)
				// We are at the end of the Child Dataset RECORD structure, popping back up to top level
				#SET(recLevel, %recLevel% - 1);
			#ELSE
				// We are inside the Child Dataset
			#END
		#END
	#END
	#IF(%fieldCount% > %childDatasetCount%) // Not all fields are child datasets, therefore there is something to output
		outData := PROJECT(inData, TRANSFORM({RECORDOF(LEFT) #EXPAND(%'eclProjectCode'%)}, SELF := LEFT));
		#IF(%childDatasetCount% > 0 AND childDatasetOutputName != '') // We have one or more Child Datasets - display them
			OUTPUT(%'childDatasetNames'%, NAMED('Child_Datasets_For_' + childDatasetOutputName));
		#END
	#ELSE // All fields are child datasets, need to return a blank dataset
		outData := DATASET([0], {INTEGER1 No_Fields_Found});
		#IF(%childDatasetCount% > 0 AND childDatasetOutputName != '') // We have one or more Child Datasets - display them
			OUTPUT(%'childDatasetNames'%, NAMED('Child_Datasets_For_' + childDatasetOutputName));
		#END
	#END
	RETURN outData;
ENDMACRO;