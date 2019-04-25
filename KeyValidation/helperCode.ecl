EXPORT helperCode := module

		export setUpFileForJoin(file, distributionFields, isDev=true) := functionmacro
				if(isDev=true, output('In search key file setup'));
				distributedFile := distribute(file, hash32(#expand(distributionFields)));
				sortedDedupedFile := dedup(sort(distributedFile, #expand(distributionFields), local), #expand(distributionFields), local);
				return sortedDedupedFile;
		endmacro;
		
		export setUpFileForJoinForPayloadKeys(file, isDev=true) := functionmacro
				if(isDev=true, output('In payload key file setup'));
				distributedFile := distribute(file);
				sortedDedupedFile := dedup(sort(distributedFile, whole record, local), whole record, local);
				return sortedDedupedFile;
		endmacro;
		
		export filterKnownIssues(unmatchedRecords, knownIssuesDSName, joinCondition, isDev=true) := functionmacro
								
				filteredRecords := catch(join(unmatchedRecords, dataset(knownIssuesDSName, recordof(unmatchedRecords), thor), 
																										#expand(joinCondition), left only), skip);
				return if(nothor(std.file.fileExists(knownIssuesDSName))=true, filteredRecords, unmatchedRecords);
				// return filteredRecords;
				
		endmacro;

end;