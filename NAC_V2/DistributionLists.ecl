
 
 

EXPORT DistributionLists := MODULE



	EXPORT ValidationList := NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('Validation', '');
	EXPORT AlertList := NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('Alert', '');
	EXPORT FailureList := NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('Failure', '');
	EXPORT SuccessList := NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('Success', '');										
 



END;









