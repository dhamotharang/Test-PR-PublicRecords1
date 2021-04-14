EXPORT mod_SendEmail(STRING BuildName, STRING BuildDate)	:= MODULE

// ###########################################################################
//                       Email Constants
//      @SUCCESS : 0
//      @FAILURE : 1
// ###########################################################################
	SHARED EmailTypeSuccess := Constants().EMAIL_TYPE_SUCCESS;
	SHARED EmailTypeFailure := Constants().EMAIL_TYPE_FAILURE;

// ###########################################################################
//                       Email Targets
// ###########################################################################
  SHARED EmailTarget := Constants().BuildEmailTarget;

// #######################################################################################
//                       Email for respective Actions
//      @BuildFailureEmail          :  Email for WORK UNIT Failure
//      @BuildSuccessEmail          :  Email for Build Success
// #######################################################################################
	SHARED BuildFailureStatus := BuildName + ' ' + Constants().BUILD_STATUS_FAILURE;
	SHARED BuildSuccessStatus := BuildName + ' ' + Constants().BUILD_STATUS_SUCCESS;

  EXPORT BuildSuccessEmail := fn_SendEmail(BuildName, BuildSuccessStatus, EmailTarget, BuildDate, EmailTypeSuccess);
  EXPORT BuildFailureEmail := fn_SendEmail(BuildName, BuildFailureStatus, EmailTarget, BuildDate, EmailTypeFailure);

END;
