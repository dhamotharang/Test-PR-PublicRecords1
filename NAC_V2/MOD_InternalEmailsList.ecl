 

IMPORT PromoteSupers, NAC_V2, STD, ut;


EXPORT MOD_InternalEmailsList := MODULE


EXPORT fn_GetInternalRecipients
(
	STRING50    pEventType,
	STRING100   pGroupID = ''
)  
:= FUNCTION	

	 dsFilteredInternalEmailsList := 
		DATASET(Nac_V2.Constants.SuperFileName_Internal, NAC_V2.Layouts.rlInternalEmailFile, THOR, OPT) 
					(IsRecipientInactive = 'N', EventType = pEventType, GroupID = STD.Str.ToUpperCase(pGroupID)); 
	 
	FilteredRecordset := PROJECT(dsFilteredInternalEmailsList, {LEFT.EmailAddress});

	{STRING	EmailAddress} xcat(FilteredRecordset L, FilteredRecordset R) :=  
	TRANSFORM
		SELF.EmailAddress := TRIM(L.EmailAddress) + ';' + TRIM(R.EmailAddress); 
	END;

	Default_Address := 	PROJECT(DATASET(Nac_V2.Constants.SuperFileName_Internal, NAC_V2.Layouts.rlInternalEmailFile, THOR, OPT)(EventType = 'Default'), {LEFT.EmailAddress});
	dsList := ROLLUP(FilteredRecordset, true, xcat(LEFT, RIGHT)); 
	ds := IF(EXISTS(dsList), dsList, Default_Address);

	RETURN ds[1].EmailAddress;

END;




EXPORT dsInternalAllEmailsList := 
	DATASET(Nac_V2.Constants.SuperFileName_Internal, NAC_V2.Layouts.rlInternalEmailFile, THOR, OPT); 




EXPORT fn_InsertRecipients
(   
	DATASET(NAC_V2.Layouts.rlInternalEmailFile) dsInsert  
) := 
FUNCTION  		 	
	Layouts.rlEmailValidation dsEmailValidation := PROJECT(dsInsert, {LEFT.EmailAddress}); 
	fn_IsEmailAddressFormatValid(dsEmailValidation);  
	dsRecordsToProcess := SORT(DEDUP((dsInternalAllEmailsList + dsInsert)) , EventType, GroupID, EmailAddress); 
	
	
	
	 ut.MAC_Sequence_Records(dsRecordsToProcess, RecordID, dsSequencedRecords); 
	
	
	
	PromoteSupers.MAC_SF_BuildProcess(dsSequencedRecords, Nac_V2.Constants.SuperFileName_Internal, dsResult,,, true);
	OUTPUT(dsInsert, NAMED('records_to_be_inserted'));		  
	RETURN dsResult;
 END; 





EXPORT fn_DeleteRecipients  
(  
	DATASET(NAC_V2.Layouts.rlInternalEmailFile) dsDelete  
) := 
FUNCTION
	dsRecordsToProcess := SORT(DEDUP((dsInternalAllEmailsList - dsDelete)), EventType, GroupID, EmailAddress); 	
	PromoteSupers.MAC_SF_BuildProcess(dsRecordsToProcess, Nac_V2.Constants.SuperFileName_Internal, dsResult,,, true);
	OUTPUT(dsDelete, NAMED('records_to_be_deleted'));
	RETURN dsResult;
END;


END;



