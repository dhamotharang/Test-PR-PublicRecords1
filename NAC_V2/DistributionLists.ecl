
 
 

EXPORT DistributionLists := MODULE



	EXPORT ValidationList := NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('PPA', 'Validation');
	EXPORT AlertList := NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('PPA', 'Alert');
	EXPORT FailureList := NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('PPA', 'Failure');
	EXPORT SuccessList := NAC_V2.MOD_InternalEmailsList.fn_GetInternalRecipients('PPA', 'Success');										
 



END;









