//************************************************************************************************************************************//
////Applies Validation Joins. Usually called from the key validation macro.
////Input: Parameters:
							//dsName: Name of the dataset. This will be included in all the result names
							//keyName: Name of the key.
							//keyType: Type of the key - Payload key or Search key
							//parentType: Type of the parent file - Eg. SSN filtered BKSearch
							//buildVersion: Current Build Version of the dataset
							//parentFile: Parent dataset
							//keyFile: Key dataset
							//join1Fields: All the fields in the key file 
							//join2Fields: Unique(relatively) field in the key file. 
							//                  This is used to build detailed report after we get the unmatched records
							//isDev: true if it is the dev version, false otherwise
////Output: Summary record for the specified key, also writes the detailed reports onto thor
////Author: Vikram Pareddy
//************************************************************************************************************************************//
EXPORT applyValidationJoinsV2(__dsName, __keyName, __keyType, __parentType, __buildVersion,  
																					 __parentFile,  __keyFile, __join1Fields, __join2Fields,  __isDev=true) := functionmacro
   import KeyValidation, Vikram, KeyValidation.helperCode;
 
  	join1Condition := KeyValidation.getJoinCondition(__join1Fields);
	  distribution1Fields := Vikram.mergeArray(__join1Fields);

	//distributing the parent and key files based on the unique ids - join condition parameter has the unique ids that is used to join
	dedupedKeyFileD1 := helperCode.setUpFileForJoin(__keyFile, distribution1Fields, __isDev);
  dedupedParentFileD1 := helperCode.setUpFileForJoin(__parentFile, distribution1Fields, __isDev);

	//pass the key file and the base file for comparison based on the join condition
	allUnmatchedRecords := join(dedupedKeyFileD1, dedupedParentFileD1, #expand(join1Condition), left only, local);
 	numberOfJoins := count(join(dedupedKeyFileD1, dedupedParentFileD1, #expand(join1Condition), local));
	
	//*******************Handling known issues************************//
	
	knownIssuesFileName := '~qa::keyval::knownIssues::' + __dsName + '::' + __keyName;
		
	knownIssuesJoinCondition := if(__keyType = 'AutoKey' or __keyType = 'FCRA_AutoKey', //nothor(std.str.contains(__keyType,'AutoKey', true))=true, 
																									KeyValidation.getKnownIssuesJoinCondition(__join1Fields, __join2Fields), 
																									join1Condition);
  unmatchedRecords := helperCode.filterKnownIssues(allUnmatchedRecords, 
																																										knownIssuesFileName, 
																																										knownIssuesJoinCondition); 													

	unmatchedRecordCount := count(unmatchedRecords);
  knownIssuesCount :=  count(allUnmatchedRecords) - unmatchedRecordCount;
	
	testResult :=  if(unmatchedRecordCount <> 0, 'FAIL', 'PASS');
	
	
  actualRecordsFileName := if(__isDev,  '~qa::keyval::testing::actual::'+__dsName+'::' +__buildVersion+'::' + __keyName,  
																										 '~qa::keyval::actual::'+__dsName+'::' +__buildVersion+'::' + __keyName);
																										 
		if(testResult = 'FAIL', output(unmatchedRecords, , actualRecordsFileName , thor, overwrite, expire(10)));
		

//**********************************Building Summary Record for this key****************************************//
	
	//generate stats to show in the summary 
	parentDSCount := count(dedupedParentFileD1);
  keyDSCount := count(dedupedKeyFileD1);
  joinedCount := numberOfJoins;
	
	//summary record that is returned with stats for the corresponding key
	 summaryRecord := dataset([{__keyName, __keyType, __parentType,parentDSCount, keyDSCount, joinedCount, 
														unmatchedRecordCount, knownIssuesCount, testResult,
														 if(__isDev, actualRecordsFileName, if(testResult = 'FAIL', actualRecordsFileName, 'No Errors found'))}],
														 KeyValidation.layouts.summaryLayout);
	
   
	 return summaryRecord;																					 
																					 
endmacro;