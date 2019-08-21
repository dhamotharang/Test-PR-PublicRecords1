

 
 

EXPORT MOD_InternalEmailsList := MODULE



IMPORT $, PromoteSupers, NAC_V2, STD;





SHARED SuperFileName_Internal := '~thor_data400::PPA::internal_email_distribution';



EXPORT fn_GetInternalRecipients
(
	STRING50    pBuildName,
	STRING100   pListName
)  
:= FUNCTION	

	 dsFilteredInternalEmailsList := 
		DATASET(SuperFileName_Internal, NAC_V2.Layouts.rlInternalEmailFile, THOR, OPT) 
					(IsRecipientInactive = 'N', BuildName = pBuildName, ListName = pListName); 
	 
	
	
	OUTPUT(PROJECT(dsFilteredInternalEmailsList, {LEFT.BuildName,  LEFT.ListName, LEFT.EmailAddress}), NAMED('partial_result'),OVERWRITE);
	FilteredRecordset := PROJECT(dsFilteredInternalEmailsList, {LEFT.EmailAddress});


	
	rlEmail := 
	RECORD
		STRING	EmailAddress;
	END;


	rlEmail xcat(FilteredRecordset L, FilteredRecordset R) :=  
	TRANSFORM
		SELF.EmailAddress := TRIM(L.EmailAddress) + ' , ' + TRIM(R.EmailAddress); 
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
	dsRecordsToProcess := SORT(DEDUP((dsInternalAllEmailsList + dsInsert)) , BuildName, ListName, EmailAddress); 	
	PromoteSupers.MAC_SF_BuildProcess(dsRecordsToProcess, SuperFileName_Internal, dsResult,,, true);
	OUTPUT(dsInsert, NAMED('records_to_be_inserted'));		  
	RETURN dsResult;
 END; 





EXPORT fn_DeleteRecipients  
(  
	DATASET(NAC_V2.Layouts.rlInternalEmailFile) dsDelete  
) := 
FUNCTION
	dsRecordsToProcess := SORT(DEDUP((dsInternalAllEmailsList - dsDelete)), BuildName, ListName, EmailAddress); 	
	PromoteSupers.MAC_SF_BuildProcess(dsRecordsToProcess, SuperFileName_Internal, dsResult,,, true);
	OUTPUT(dsDelete, NAMED('records_to_be_deleted'));
	RETURN dsResult;
END;





END;






