IMPORT ut, emerges;

EXPORT fBuild_Key_Hunters_DID(BOOLEAN  IsFCRA = FALSE) := FUNCTION

		dBase_temp    := emerges.file_hunters_keybuild((integer)did_out != 0);
    
     // DF-21635 - Blank out fields in FCRA file thor_Data400::key::hunters_doxie_did_fcra_*
     fields_to_clear  := eMerges._Constants.Deprecated_Fields;
                      
     ut.MAC_CLEAR_FIELDS(dBase_temp, dBase_FilterFCRA, fields_to_clear);
     dBase		:= IF(isFCRA,
                    DEDUP(SORT(DISTRIBUTE(dBase_FilterFCRA,HASH64(did_out)), RECORD, LOCAL), RECORD, LOCAL),
                    dBase_temp);
     
		RETURN(dBase); 

END;		