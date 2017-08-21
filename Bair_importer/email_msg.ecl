EXPORT email_msg(string wuid, INTEGER last_recordID_RAIDS) := MODULE

EXPORT RecordID_RAIDS_MSG
	:=
	'** Current Value for Last recordID_RAIDS is '+(string)last_recordID_RAIDS+' **\n\n'

	+'WUID: '+wuid+'\n\n'
	
	+'If recordID_RAIDS is less than 50000000000 please fix the sequence to prevent udf corruption.\n\n'
	
	+'Use the following function to set the MO and Person sequences accordingly\n\n'
	
	+'bair_importer.Validate_Input.fn_SetRecordID_RAIDS\r'
	+'\t(\r'
	+'\t\t unsigned5 moLastSequence,\r' 
	+'\t\t unsigned5 personLastSequence,\r' 
	+'\t\t string pVersion,\r' 
	+'\t\t boolean pUseProd = false\r'
	+'\t);\n\n'

	+'If issues persist/repeat outside the Sunday maintenance window,\n'
	+'please contact Debendra.Kumar@lexisnexis.com and Jose.Bello@lexisnexis.com for assistance.\n'
	;

END;