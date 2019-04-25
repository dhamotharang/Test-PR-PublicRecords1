//Code to apply normalize on the parent file before Key Validation
//Parameters: 
//ParentFile: File to be normalized
//OutputFields: Fields that appear in the output file after the normalize function
//CorrespondingInputFields: Fields from the parent file that are normalized 
//																					into the output fields
//fieldsToIgnore: There is no project, but once the input fields 
//												are normalized into the output fields, this parameter is used to generate the output layout
//numberOfTimes: Number of times the normalize should be applied, translates to the max
//													number of fields that are being normalized at a field level
//isDev: for debugging
//Author: Vikram Pareddy
EXPORT applyNormalize(parentFile, outputFields, correspondingInputFields, 
																				fieldsToIgnore, numberOfTimes, isDev = true):= functionmacro
import Vikram, KeyValidation;
  parentLayout := {recordOf(parentFile), string qa_defined_empty};
	resultLayout := parentLayout - #expand('[' + Vikram.mergeArray(fieldsToIgnore) + ']');
	transformLogic := KeyValidation.getTransformLogic(outputFields, correspondingInputFields);
	
	
	resultLayout transformForNormalize(parentFile l, integer c) := 	#expand(transformLogic);
	
	
	return normalize(parentFile, numberOfTimes, transformForNormalize(left, counter));

endmacro;

