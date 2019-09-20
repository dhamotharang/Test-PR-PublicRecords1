
 
 

EXPORT MOD_ExternalEmailsList := MODULE


IMPORT $, PromoteSupers, NAC_V2, STD, ut;


SHARED dsGroupConfig := NAC_V2.dNAC2Config;   //  points to "~nac::nac2::groups_config_xx"



EXPORT fn_GetExternalRecipients 
( 
	STRING50    pGroupID,
	STRING100   pEventType
)  
:= FUNCTION	





	 dsFilteredExternalEmailsList := 
		DATASET(Constants.SuperFileName_External, Layouts.rlExternalEmail, THOR, OPT) 
					(IsRecipientInactive = 'N', GroupID = pGroupID, EventType = pEventType); 

	
	
	dsStaging01 :=  
	PROJECT( 
			JOIN(dsFilteredExternalEmailsList, dsGroupConfig, 
			STD.Str.ToUpperCase(LEFT.GroupID) = 
			STD.Str.ToUpperCase(RIGHT.GroupID), 
			INNER, LOCAL)    
			, {LEFT.EmailAddress,  LEFT.EventType , LEFT.ProductCode, LEFT.GroupID}
			 ); //  ProductCode values:  n For NAC, p For PPA   

	rlEmail_Adding_ProgDesc := RECORD 
		dsStaging01; 
		STRING5 program ;
	END;
	 
	rlEmail_Adding_ProgDesc dsStaging02(dsStaging01 l) := TRANSFORM
		 SELF.program := CASE(l.ProductCode,  'p' => 'PPA', 'n' => 'NAC', l.ProductCode);
		 SELF := l;  
	END;

	dsResult01 :=  PROJECT(dsStaging01, dsStaging02(LEFT));  //  idkwth..
	
	OUTPUT(PROJECT(dsResult01, {LEFT.GroupID, LEFT.program, LEFT.EventType, LEFT.EmailAddress}), NAMED('group_to_program_match'));
	FilteredRecordset := PROJECT(dsFilteredExternalEmailsList, {LEFT.EmailAddress});
	
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





EXPORT dsExternalAllEmailsList := 
	DATASET(Constants.SuperFileName_External, Layouts.rlExternalEmail, THOR, OPT); 
	
	
	
	
EXPORT fn_InsertRecipients
(   
	DATASET(Layouts.rlExternalEmail) dsInsert //= DATASET([],  rlExternalEmailFile)
):= 
FUNCTION
	Layouts.rlEmailValidation dsEmailValidation := PROJECT(dsInsert, {LEFT.EmailAddress}); 
	fn_IsEmailAddressFormatValid(dsEmailValidation); // for checking email addresses are in correct format
	dsRecordsToProcess := SORT(DEDUP((dsExternalAllEmailsList + dsInsert)), GroupID, EventType, EmailAddress);  	
	
	 ut.MAC_Sequence_Records(dsRecordsToProcess, RecordID, dsSequencedRecords);
	
	
	 
	PromoteSupers.MAC_SF_BuildProcess(dsSequencedRecords, Constants.SuperFileName_External, dsResult,,, true);
	OUTPUT(dsInsert, NAMED('to_be_inserted'));	
	RETURN dsResult;		 
END;




EXPORT fn_DeleteRecipients 
(  
	DATASET(Layouts.rlExternalEmail) dsDelete //= DATASET([],  rlExternalEmailFile)
):= 
FUNCTION
	dsRecordsToProcess := SORT(DEDUP((dsExternalAllEmailsList - dsDelete)), GroupID, EventType, EmailAddress); 
	OUTPUT(dsDelete, NAMED('records_to_be_deleted'));
	PromoteSupers.MAC_SF_BuildProcess(dsRecordsToProcess, Constants.SuperFileName_External, dsResult,,, true);		
	RETURN dsResult;	 
END; 
 





END;






