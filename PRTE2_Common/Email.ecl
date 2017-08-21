IMPORT lib_FileServices,STD;

EXPORT Email := MODULE
		// My assumption is nothing below that calls this would ever have the left side empty so we always need ",something" appended
		// however, a blank can be sent into this so only do the ', '+aValue IF the value sent in is not blank.
		SHARED STRING CommaValueIf(STRING aValue) := IF(TRIM(aValue) = '', TRIM(aValue), ', '+TRIM(aValue));
		SHARED STRING DefaultString(STRING S1, STRING S2) := IF(S1='',S2,S1);

		// ------- GLOBAL -----------------------------------------------------------------------------------------------------------
		// Next 3 lines, should not be needed but in Boca dataland these GETENV are returning '' half the time
		SHARED Email_Server	:= DefaultString(GETENV('SMTPserver'), 'mailout.br.seisint.com');
		SHARED Email_From 		:= DefaultString(GETENV('emailSenderAddress'),'eclsystem@seisint.com');
		SHARED Email_Port 		:= (INTEGER) DefaultString(GETENV('SMTPport'), '25');
		EXPORT Email_Notify(STRING sendTo, STRING subject, STRING body) := 
																lib_FileServices.FileServices.SendEmail(sendTo,subject,body,Email_Server,Email_Port,Email_From);
		// --------------------------------------------------------------------------------------------------------------------------
		SHARED is_running_in_prod		:= Constants.is_running_in_prod;
		
		// e-mail notifications							
		SHARED STRING CT_Group 							:= 'alp-cust.test.tech@risk.lexisnexis.com';		// ALPHA GROUP! IF WE WANT TO USE IT.
		SHARED STRING DEV_TestingEmail			:= 'Bruce.Petro@lexisnexis.com';
		SHARED STRING AlpharettaTeamPRCT		:= IF(is_running_in_prod,CT_Group,DEV_TestingEmail);
		SHARED STRING BocaTechTeamPRCT			:= '';
		SHARED STRING AllTechEmails					:= AlpharettaTeamPRCT+CommaValueIf(BocaTechTeamPRCT);
		SHARED STRING BocaDataTeamEmails 		:= 'jennifer.stewart@lexisnexis.com,aaron.neidert@lexisnexis.com';
		SHARED STRING BocaAllEmails					:= BocaDataTeamEmails+CommaValueIf(BocaTechTeamPRCT);

		// use as follows - in BWR add: #CONSTANT('AdditionalDOPSEmail','john.smith@lexisnexis.com');
		SHARED STRING AdditionalDOPSEmail   := '':STORED('AdditionalDOPSEmail');
		EXPORT STRING DOPSInterestEmails		:= AllTechEmails + CommaValueIf(BocaDataTeamEmails) + CommaValueIf(AdditionalDOPSEmail);	
		
		SHARED STRING AdditionalBuildEmail   := '':STORED('AdditionalBuildEmail');
		EXPORT STRING EmailTargetFailPlus(STRING addName='') := AllTechEmails + CommaValueIf(addName) + CommaValueIf(AdditionalBuildEmail);
		EXPORT STRING EmailTargetSuccessPlus(STRING addName='') := AllTechEmails + CommaValueIf(addName) + CommaValueIf(AdditionalBuildEmail);

		// Obsolete but has references that need to be removed
		EXPORT EmailTargetFail				:= EmailTargetFailPlus('');	 
		EXPORT EmailTargetSuccess			:= EmailTargetSuccessPlus('');	 
		
		EXPORT EmailDetailedMessage(STRING MAINSTRING) := MAINSTRING 
																											+'\n'+' USER:     '+STD.System.Job.User()
																											+'\n'+' CLUSTER:  '+ThorLib.Cluster()
																											+'\n'+' ENV:      '+ Constants.thisEnvironmentName
																											+'\n'+' WU:       '+WORKUNIT
																											+'\n'+' WU NAME:  '+STD.System.Job.Name();

		EXPORT sendSuccess(STRING modName, STRING addName='') := Email_Notify(
																					EmailTargetFailPlus(addName),
																					modName+' Customer Test data/key build SUCCESS',
																					EmailDetailedMessage(modName+' Customer Test data/key build successful') );

		EXPORT sendFail(STRING modName, STRING addName='') := Email_Notify(
																					EmailTargetFailPlus(addName),
																					modName+' Customer Test data/key build FAILED',
																					EmailDetailedMessage(modName+' Customer Test data/key build FAILED')
																					+ '\n' + '\n' + FAILMESSAGE);

		EXPORT sendGenericToSuccessGroup(STRING subject, STRING body) := Email_Notify(
																					AllTechEmails,
																					subject,
																					EmailDetailedMessage(body) );
																																	
END;