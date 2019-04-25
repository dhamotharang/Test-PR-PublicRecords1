//Code that 1. sets up the key and parent files for comparison
//2. Runs the comparison using the function macro 'getUnmatchedFields' based on a join condition
//3. builds index of the unmatched fields to make it searchable
//4. retuns a summary file containing the stats about the unmatched records
//Author: Vikram Pareddy
export validateKeysMacrov2(dsName, keyName, keyType, parentType, buildVersion,  
																					 parentFile, keyFile, keyFields, correspondingParentFields, 
																					 fieldsToIgnore, joinFields, isDev=true) := functionmacro
 import KeyValidation.layouts, std;  
 
	
	projectedParentFile := KeyValidation.applyProject(parentFile, recordof(keyFile), keyFields, 
																																				correspondingParentFields, fieldsToIgnore, isDev);
																// output(projectedParentFile);
  projectedKeyFile := KeyValidation.applyProject(keyFile, recordof(keyFile), ['self'], ['left'], fieldsToIgnore, isDev);

  summaryRecord := KeyValidation.applyValidationJoins(dsName, keyName, keyType, parentType, buildVersion, 
																																projectedParentFile, projectedKeyFile, keyFields, joinFields, isDev);
																													
	 return summaryRecord;
 
endmacro;