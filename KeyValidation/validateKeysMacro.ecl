export validateKeysMacro(dsName, keyName, keyType, parentType, buildVersion,  
																					 parentFile, keyFile, joinCondition) := functionmacro
 import KeyValidation.layouts;  

  parentDS := parentFile;
	keyDS := keyFile;
	
  joinedRecords := keyValidation.getUnmatchedFields(keyDS, parentDS, joinCondition);
  unmatchedRecords := joinedRecords(trim(unmatchedFields, left, right) <> '');
	  unmatchedRecordCount := count(unmatchedRecords);

    // if(unmatchedRecordCount <> 0, 
			// buildindex(unmatchedRecords, {unmatchedFields}, {unmatchedRecords}, '~qa::'+dsName+'::key::' +buildVersion+'::' + keyName , overwrite, expire(10)),
			// output('no unmatched records')); 	
  
	parentDSCount := count(parentDS);
  keyDSCount := count(keyDS); 
  joinedCount := count(joinedRecords);
	
	 summaryRecord := dataset([{keyName, keyType, parentType,parentDSCount, keyDSCount, joinedCount, 0, 0,
														// parentDSCount - joinedCount, keyDSCount - joinedCount,
														unmatchedRecordCount, if(unmatchedRecordCount <> 0, 'FAIL', 'PASS'),
														if(unmatchedRecordCount <> 0, '~qa::'+dsName+'::key::' +buildVersion+'::' + keyName, '')}],KeyValidation.layouts.summaryLayout);
	
   // return output(summaryRecord,,'~qa::' + dsName + '::' + keyName + '::summaryRecord::' + buildVersion, csv, overwrite);
	 return summaryRecord;
 
endmacro;