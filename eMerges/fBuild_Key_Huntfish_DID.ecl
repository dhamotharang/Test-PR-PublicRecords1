IMPORT ut;

EXPORT fBuild_Key_Huntfish_DID(BOOLEAN  IsFCRA = FALSE) := FUNCTION

		dBase_temp    := eMerges.huntfish_searchfile(did_out!='');
    
     // DF-21635 - Blank out fields in FCRA file thor_data400::key::hunting_fishing::fcra::qa::did
     fields_to_clear  := eMerges._Constants.Deprecated_Fields;
                      
     ut.MAC_CLEAR_FIELDS(dBase_temp, dBase_FilterFCRA, fields_to_clear);
     dBase		:= IF(isFCRA, DEDUP(dBase_FilterFCRA), dBase_temp);
     
		RETURN(dBase); 

END;		