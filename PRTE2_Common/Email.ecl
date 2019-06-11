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
		SHARED is_running_in_prod	:= Constants.is_running_in_prod;

		// use as follows:   #CONSTANT('SubstituteEmail','Bruce.Petro@lexisnexisrisk.com');
		SHARED substituteEmail 		:= '':STORED('SubstituteEmail');
		
		// e-mail notifications							
		EXPORT CT_AlphaAll			:= 'RiskInsuranceCustomerTest@lexisnexisrisk.com';
		SHARED CT_BocaAll				:= 'RiskBusinessServicesCustomerTest@lexisnexisrisk.com';
		EXPORT AlpharettaTeamPRCT	:= IF(substituteEmail<>'',substituteEmail,CT_AlphaAll);
		EXPORT BocaTechTeamPRCT		:= IF(substituteEmail<>'',substituteEmail,CT_BocaAll);	
		EXPORT AllTechEmails			:= IF(substituteEmail<>'',substituteEmail,AlpharettaTeamPRCT+CommaValueIf(BocaTechTeamPRCT));

		// use as follows - in BWR add: #CONSTANT('AdditionalDOPSEmail','john.smith@lexisnexis.com');
		SHARED STRING AdditionalDOPSEmail   := '':STORED('AdditionalDOPSEmail');
		EXPORT STRING DOPSInterestEmails		:= AllTechEmails + CommaValueIf(AdditionalDOPSEmail);	
		
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
																					EmailTargetSuccessPlus(addName),
																					modName+'- PRCT base or key build SUCCESS',
																					EmailDetailedMessage(modName+' - PRCT base or key build successful') );

		EXPORT sendFail(STRING modName, STRING addName='') := Email_Notify(
																					EmailTargetFailPlus(addName),
																					modName+'- PRCT base or key build FAILED',
																					EmailDetailedMessage(modName+' - PRCT base or key build FAILED')
																					+ '\n' + '\n' + FAILMESSAGE);

		EXPORT sendGenericToSuccessGroup(STRING subject, STRING body) := Email_Notify(
																					AllTechEmails,
																					subject,
																					EmailDetailedMessage(body) );
																																	
END;