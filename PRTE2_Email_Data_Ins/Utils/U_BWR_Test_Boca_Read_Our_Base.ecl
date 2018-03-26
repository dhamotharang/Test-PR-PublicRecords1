IMPORT PRTE2_Email_Data, email_data, PRTE2_Email_Data_Ins;

/* 	*********** Files in our Files attribute to be checked ******************
	EXPORT emailData_Base_SF			:= BASE_PREFIX_NAME + qaVersion + EMAIL_ALP_BASE_NAME;	
	EXPORT Email_Base_DS     			:= DATASET ( emailData_Base_SF, Layouts.Spreadsheet_base, THOR);

	// Production file used for desprays
	EXPORT email_Base_SF_PROD			:= Add_Foreign_prod(emailData_Base_SF);	
	EXPORT Email_Base_DS_PROD			:= DATASET ( email_Base_SF_PROD, Layouts.Spreadsheet_base, THOR);

	EXPORT email_Compat_SF					:= BASE_PREFIX_NAME + qaVersion + EMAIL_BASE_NAME;	
	EXPORT Email_Compat_DS					:= DATASET ( email_Compat_SF, Layouts.Boca_Compatible, THOR);

	// Production file used for desprays
	EXPORT email_Compat_SF_PROD	:= Add_Foreign_prod(email_Compat_SF);	
	EXPORT Email_Compat_DS_PROD	:= DATASET ( email_Compat_SF_PROD, Layouts.Boca_Compatible, THOR);
*/

// Local files (Dev)
PRTE2_Email_Data_Ins.Files.Email_Base_DS;
PRTE2_Email_Data_Ins.Files.Email_Compat_DS;		// s/b the same as below
PRTE2_Email_Data.Files.INCOMING_ALPHA_DEV;		// s/b the same as above

// Prod files not create yet... migration pending.
// Prod files 
// PRTE2_Email_Data_Ins.Files.Email_Base_DS_PROD;
// PRTE2_Email_Data_Ins.Files.Email_Compat_DS_PROD;	// s/b the same as below
// PRTE2_Email_Data.Files.INCOMING_ALPHA;								// s/b the same as above
