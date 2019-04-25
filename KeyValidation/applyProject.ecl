//Code to apply project on the parent file before Key Validation
//Parameters: 
//	ParentFile: File to be projected
//	keyLayout: This layout is used to generate the layout into which the parent file is projected into
//	keyFields: This and the next parameter are sets used to provide the mapping information
//									between the parent and the key. This field contains the key field names.
//	CorrespondingInputFields: As mentioned above, this field contains the set containing the 
//																					corresponding parent field names(corresponding to the above field)
//	fieldsToIgnore: This set contains the field names from the key which are ignored 
//												i.e. not contained in the output layout of the project
//	isDev: for debugging
//Author: Vikram Pareddy	
EXPORT applyProject(parentFile, keyLayout, keyFields, correspondingParentFields, 
																	fieldsToIgnore, isDev=true) := FUNCTIONmacro

	import KeyValidation, Vikram; 
	//qa defined empty is used to address the case when there are no fields to ignore
	keyLayoutWithEmpty := {keyLayout, string qa_defined_empty};
	
	//generating the fieldsToIgnore string - this is passed to the #expand function
	fieldsToIgnoreString := Vikram.mergeArray(fieldsToIgnore);
	fieldsToIgnoreSetToExpand := '[' + fieldsToIgnoreString + ']';
	
	// if(isDev=true, output(fieldsToIgnoreString));
  //generate project logic using the mapping arrays passed as parameters to this function macro
  projectLogic := keyvalidation.getProjectLogic(keyFields, correspondingParentFields);
	
	//project parent file into the key file layout, minus the fields to ignore; using the project logic generated earlier			
  projectedFile:= project(parentFile, transform(keyLayoutWithEmpty - #expand(fieldsToIgnoreSetToExpand), #expand(projectLogic)));
  
	return projectedFile;

endmacro;