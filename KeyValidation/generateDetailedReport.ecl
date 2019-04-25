//************************************************************************************************************************************//
//Generates detailed reports for the unmatched records that are passed. The detailed report shows
//a comparison between the records in the unmatchedRecords dataset and the records in the parent.
//This is not a one on one comparison - the records are shown based on the uniqueField.
//There can be more than one record for that uniqueField in both the unmatchedRecords dataset and
//in the parent records.
//Input Parameters:
//		unmatchedRecords: Set of records that do not exist in the parent.
//		parentRecords: Set of all the parent records
//		uniqueField: String containing the unique field
//Output:
//		A detailed report showing the record(s) in unmatchedRecords dataset attached to the corresponding 
// 		record in the parent(estimated based on the uniqueField)
//Author: Vikram Pareddy
//************************************************************************************************************************************//
EXPORT generateDetailedReport(unmatchedRecords, parentRecords, uniqueField) := functionmacro
	
	//adding file type, 'keyFile' for unmatchedRecords and 'parentFile' for the parent records
	resultSubsetLayout := RECORD
			string fileType;
			recordOf(unmatchedRecords);
		END;
		
		unmatchedRecordsD := distribute(unmatchedRecords, hash32(#expand(uniqueField)));
		parentRecordsD := distribute(parentRecords, hash32(#expand(uniqueField)));
				
		keyFile := project(unmatchedRecordsD, transform(resultSubsetLayout, self.fileType := 'Key File', self := left));
		parentFileFull := project(parentRecordsD, transform(resultSubsetLayout, self.fileType := 'Parent File', self := left));
		
		//getting only the fields that (are estimated to) matter from the parent(the other fields are not mapped, they are directly shown)
		parentFileFiltered := join(keyFile, parentFileFull, 
																						left.#expand(uniqueField) = right.#expand(uniqueField), 
																						transform(resultSubsetLayout, self:= right),  local);
		
		resultLayout := RECORD
			integer numberOfRows;
			dataset(resultSubsetLayout) Comparison;
			string uniqueField;
		END;
		
		//projecting unmatchedRecords, this set is used for denormalize
		projectedDS := project(dedup(sort(unmatchedRecords, hash32(#expand(uniqueField))), hash32(#expand(uniqueField))), 
																transform(resultLayout, self.numberOfRows := 0, 
																		self.uniqueField := (string)left.#expand(uniqueField), self.comparison := []));

		resultLayout denormTransformFunc(resultLayout l, dataset(resultSubsetLayout) r) := transform
			self.numberOfRows := count(r);
			self.Comparison := r + parentFileFiltered((string)#expand(uniqueField)=l.uniqueField);
			self := l;
		end;

		return denormalize(projectedDS, keyFile, left.uniqueField = (string)right.#expand(uniqueField), group, denormTransformFunc(left, rows(right)));

endmacro;