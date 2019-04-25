KeyValidation for new datasets:

Mapping Validation test

1. Define an attribute with the name: validate(datasetName)Keys where the 'datasetName' is to be replaced with the 
name of the dataset. This attribute will be a functionmacro which takes in one argument: buildversion and returns a summary report
2. Define parents file which contains all the parents referenced in the corresponding key validation
3. Define keys file which contains all the keys referenced in the corresponding key validation
		Note: It is recommended that both the parent file and key file be picked from attributes in dataland. Also, read the parent file 
		as it is defined in the respective key i.e. with the filters applied - this allows us to get to the eligible records in the parent.
		Note2: Please verify that all the files being referenced in key validation are from prod i.e. the parent files and the key files. This
		verification has to be done on all the attributes, even the ones not defined by QA. If some file in an attribute is pointing to dataland,
		copy the code into the parentFiles attribute and change the pointer to prod. If it has too many connections to be copied, it is recommended 
		to sandbox the code, and document it, so that the change is not lost.
4. Define Mappings file which contains all the mapping information between the parent and the key files.
5. Call the validation macro KeyValidation.validateKeysMacrov2 with the following parameters
 Required parameters: 
						dsName – Name of the dataset(string) - write a definition for it in the validate(dataset) attribute
             keyName – Name of the key(string) - defined in Mappings file
             keyType – Type of key(Search key/Payload key)(String) - defined in Mappings file
             parentType – Actually, parent name, preferable no spaces(string) - defined in Mappings file
             buildVersion – version of the build(string)  
						 parentFile – parent dataset(dataset) - defined in (dataset)ParentsFile file
							keyFile – key dataset(index or dataset) - defined in (dataset)KeysFile file
							keyFields – key field array that are required to be validated(set of strings) -- defined in Mappings file                     
							correspondingParentFields – parent records that are supposed to be mapped to the aforementioned keyFields array -- defined in Mappings file
							This is a direct mapping, sequence of fields is important. (set of strings)     
							fieldsToIgnore – fields in key that should be skipped from the validation process. - defined in Mappings file
													A field called 'qa_defined_empty' has to be present in every set of fieldsToIgnore(set of strings)             
							joinFields – Field array upon which the parent and the key file will be joined(set of strings) - defined in Mappings file
							Note: 'joinFields' are just used to make a detailed report. The actual validation join uses all the 'keyFields' in the join condition.

6. The validation macro returns one record which contains the summary of the test for that key. Add these records and 
output it from the function macro.

7. Define an attribute with the name of the dataset.

8. This new attribute will be similar to the existing attributes for FDN or BK - the difference is in the buildVersion part, 
and the parameters passed to DesprayAndEmailSummary function - change those values to the ones for the respective
dataset.



Validation for keys with multiple parents:
1. Instead of calling ValidateKeysMacrov2 directly, call KeyValidation.applyProject on the parents and the key(to make sure fields are ignored). (this gets the parents
and the key into a common layout)
2. Call KeyValidation.applyValidationJoins using these projected parents and key
The parameters into the KeyValidation.applyProject and KeyValidation.applyValidationJoins are same as above.

Handling known issues:
  If the validation is complete and there are failures, but if the failures are acceptable/known, move the failures 
   dataset(the actual failures i.e. the file which does not show the comparison) 
	 into a file with name: '~qa::keyval::knownIssues::' + __dsName + '::' + __keyName
	 Here, __dsName is the name of the dataset (eg. 'Bankruptcy') and __keyName is the name of the key(eg. 'case_number')
	Note: If the key is and autokey(which has fakeid which is generated for every build), specify the key type as 'Autokey'
