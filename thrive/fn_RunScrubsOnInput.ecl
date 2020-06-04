IMPORT Thrive, Scrubs, Scrubs_Thrive;

EXPORT fn_RunScrubsOnInput(string source, string pversion) := FUNCTION

runScrubs :=	map(trim(source,left,right) = 'LT' => Scrubs.ScrubsPlus('Thrive','Scrubs_Thrive','Scrubs_Thrive_Input_LT', 'Input_LT', pversion,Email_Notification_Lists.BuildFailure,false),		
								  trim(source,left,right) = 'PD' => Scrubs.ScrubsPlus('Thrive','Scrubs_Thrive','Scrubs_Thrive_Input_PD', 'Input_PD', pversion,Email_Notification_Lists.BuildFailure,false));	
																 
return runScrubs;																 
																 
END;