IMPORT Std;

EXPORT fn_SendEmail(
       STRING BuildName, // Name of Build
			 STRING BuildStatus, // Email Subject on Build Status
			 STRING EmailTarget, // Targeted Audience
			 STRING BuildDate, // Build Version or Date the Build ran
			 UNSIGNED1 EmailType = Constants().EMAIL_TYPE_SUCCESS // Email Type
			 )	:= FUNCTION

// ###########################################################################
//                       Email Constants
//      @SUCCESS : 0
//      @FAILURE : 1
// ###########################################################################
	EmailTypeSuccess := Constants().EMAIL_TYPE_SUCCESS;
	EmailTypeFailure := Constants().EMAIL_TYPE_FAILURE;
	
// ###########################################################################
//                       Email Message Constants
// ###########################################################################
  msgEnv := mod_Utilities.EnvName;
	msgBuildName := 'Build Name';
	msgName := 'Msg';
	msgBuildDate := 'Build Date';

// ###########################################################################
//                       Email Subject
// ###########################################################################
	EmailSubject := msgEnv       + ' : ' +
	                msgBuildName + ' = ' + BuildName   + '; ' + 
									msgName      + ' = ' + BuildStatus + '; ' + 
									msgBuildDate + ' = ' + BuildDate   + ';';
									
// ###########################################################################
//                       Email Body
// ###########################################################################
  EmailSuccessBody := WORKUNIT;
	EmailFailureBody := WORKUNIT + '\n' + FAILMESSAGE;
	
	EmailBody := TRIM(MAP(EmailType = EmailTypeSuccess => EmailSuccessBody,	                 
									      EmailType = EmailTypeFailure => EmailFailureBody,
									      EmailSuccessBody), LEFT, RIGHT);

// ###########################################################################
//                       Send Email
// ###########################################################################
	SendEmail := STD.System.Email.SendEmail(EmailTarget, EmailSubject, EmailBody);

  RETURN SendEmail;

END;