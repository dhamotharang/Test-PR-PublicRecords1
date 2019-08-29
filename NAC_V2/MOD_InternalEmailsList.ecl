﻿
 
  
 

EXPORT MOD_InternalEmailsList := MODULE



IMPORT $, PromoteSupers, NAC_V2, STD;





SHARED SuperFileName_Internal := '~NAC::internal_email_distribution';



EXPORT fn_GetInternalRecipients
(
	STRING50    pEventType,
	STRING100   pGroupID = ''
)  
:= FUNCTION	

	 dsFilteredInternalEmailsList := 
		DATASET(SuperFileName_Internal, NAC_V2.Layouts.rlInternalEmailFile, THOR, OPT) 
					(IsRecipientInactive = 'N', EventType = pEventType, GroupID = pGroupID); 
	 
	
	
	OUTPUT(PROJECT(dsFilteredInternalEmailsList, {LEFT.EventType,  LEFT.GroupID, LEFT.EmailAddress}), NAMED('partial_result'),OVERWRITE);
	FilteredRecordset := PROJECT(dsFilteredInternalEmailsList, {LEFT.EmailAddress});


	
	rlEmail := 
	RECORD
		STRING	EmailAddress;
	END;


	rlEmail xcat(FilteredRecordset L, FilteredRecordset R) :=  
	TRANSFORM
		SELF.EmailAddress := TRIM(L.EmailAddress) + ';' + TRIM(R.EmailAddress); 
	END;
	dsList := ROLLUP(FilteredRecordset, true, xcat(LEFT, RIGHT)); 

	RETURN dsList[1].EmailAddress;



END;




EXPORT dsInternalAllEmailsList := 
	DATASET(SuperFileName_Internal, NAC_V2.Layouts.rlInternalEmailFile, THOR, OPT); 




EXPORT fn_InsertRecipients
(   
	DATASET(NAC_V2.Layouts.rlInternalEmailFile) dsInsert  
) := 
FUNCTION  		 	
	Layouts.rlEmailValidation dsEmailValidation := PROJECT(dsInsert, {LEFT.EmailAddress}); 
	fn_IsEmailAddressFormatValid(dsEmailValidation);  
	dsRecordsToProcess := SORT(DEDUP((dsInternalAllEmailsList + dsInsert)) , EventType, GroupID, EmailAddress); 	
	PromoteSupers.MAC_SF_BuildProcess(dsRecordsToProcess, SuperFileName_Internal, dsResult,,, true);
	OUTPUT(dsInsert, NAMED('records_to_be_inserted'));		  
	RETURN dsResult;
 END; 





EXPORT fn_DeleteRecipients  
(  
	DATASET(NAC_V2.Layouts.rlInternalEmailFile) dsDelete  
) := 
FUNCTION
	dsRecordsToProcess := SORT(DEDUP((dsInternalAllEmailsList - dsDelete)), EventType, GroupID, EmailAddress); 	
	PromoteSupers.MAC_SF_BuildProcess(dsRecordsToProcess, SuperFileName_Internal, dsResult,,, true);
	OUTPUT(dsDelete, NAMED('records_to_be_deleted'));
	RETURN dsResult;
END;





END;






