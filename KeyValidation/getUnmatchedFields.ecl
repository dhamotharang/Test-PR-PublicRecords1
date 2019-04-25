//Description: Get records for which the field names match but the data in them doesn't
//the two datasets are joined based on the joinCondition. 
//Key file and base file are not required to be in the same layout
//Base file is projected into the key layout for comparison
//Author: Vikram Pareddy
EXPORT getUnmatchedFields(keyfile, basefile, joinCondition, isDev=true) := functionmacro

	//This is the layout the comparison datasets will be shown in
	comparisonDSLayout := record
		string50 fileType;
		recordof(keyfile);
  end;

  //projecting the key and parent files to include the file type i.e. key file or parent file
  keyFileProjected := project(keyFile, transform(comparisonDSLayout, self.fileType:='keyFile', self:= left));
  baseFileProjected := project(baseFile, transform(comparisonDSLayout,self.fileType:='parentFile', self := left));
 
 //layout and transform function of the actual output
	outputLayout := RECORD
		STRING100 unmatchedFields;
		dataset(comparisonDSLayout) comparison;
	END;
	outputLayout unmatchedFieldsTransformFunc(keyFileProjected L, baseFileProjected R) := TRANSFORM
		SELF.unmatchedFields := trim(if(ROWDIFF(L,R) = 'fileType', skip, rowdiff(l,r)), left, right)[10.. ];
		self.comparison := l + r;
	END;
	
	//main join between the projectedkey and projected parent file using unique field
	keyValResult := JOIN(keyFileProjected, baseFileProjected, #expand(joinCondition), unmatchedFieldsTransformFunc(LEFT,RIGHT), local);
	
  //if the unique field itself does not exist in the base file	
	leftOverValues := JOIN(keyFileProjected, baseFileProjected, #expand(joinCondition), left only, local);
	
	fileTypeAddedToLeftOverValues := project(leftOverValues, 
																			transform(comparisonDSLayout, self.fileType := 'KeyFile', self := left));
	finalLeftOverValues := project(fileTypeAddedToLeftOverValues, 
																			transform(outputLayout, self.unmatchedFields := 'No unique field match', 
																											self.comparison := left));
  
 return keyValResult(unmatchedFields <> '') + finalLeftOverValues;
endmacro;