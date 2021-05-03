
EXPORT mod_SendEmail(STRING BuildName, STRING BuildDate)	:= MODULE

// ###########################################################################
//                       Email Constants
//      @SUCCESS : 0
//      @FAILURE : 1
//      @BILLING : 2
// ###########################################################################
	SHARED EmailTypeSuccess := Constants_MBSAgency.EMAIL_TYPE_SUCCESS;
	SHARED EmailTypeFailure := Constants_MBSAgency.EMAIL_TYPE_FAILURE;
	SHARED EmailTypeBilling := Constants_MBSAgency.EMAIL_TYPE_BILLING;

// ###########################################################################
//                       Email Targets
// ###########################################################################
  SHARED EmailTarget := Constants_MBSAgency.BuildEmailTarget;

// #######################################################################################
//                       Email for respective Actions
//      @NoInputFileEmail           :  Email for Non availability of contributed file
//      @EmptyInputFileEmail        :  Email for Empty contributed file
//      @BuildFailureEmail          :  Email for WORK UNIT Failure
//      @BuildSuccessEmail          :  Email for Build Success
// #######################################################################################
	SHARED ProductName := Constants_MBSAgency.ProdID;
	
	SHARED BuildNoInputFileStatus := BuildName + ' ' + Constants_MBSAgency.BUILD_STATUS_NO_INPUT_FILE;
	SHARED BuildEmptyFileStatus := BuildName + ' ' + Constants_MBSAgency.BUILD_STATUS_EMPTY_INPUT_FILE;			
	SHARED BuildFailureStatus := BuildName + ' ' + Constants_MBSAgency.BUILD_STATUS_FAILURE;
	SHARED BuildSuccessStatus := BuildName + ' ' + Constants_MBSAgency.BUILD_STATUS_SUCCESS;

		
  EXPORT NoInputFileEmail := fn_SendEmail(BuildName, BuildNoInputFileStatus, EmailTarget, BuildDate, EmailTypeFailure);
  EXPORT EmptyInputFileEmail := fn_SendEmail(BuildName, BuildEmptyFileStatus, EmailTarget, BuildDate, EmailTypeFailure);
  EXPORT BuildSuccessEmail := fn_SendEmail(BuildName, BuildSuccessStatus, EmailTarget, BuildDate, EmailTypeSuccess);
  EXPORT BuildFailureEmail := fn_SendEmail(BuildName, BuildFailureStatus, EmailTarget, BuildDate, EmailTypeFailure);

END;
