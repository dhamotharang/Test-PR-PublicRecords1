// DF-28945 Create a new key for insurace to suppress all Lexids in thor_data400::key::new_suppression::qa::link_type_link_id
IMPORT doxie,ut,Data_Services;

EXPORT Data_Key_New_Suppression_Did(BOOLEAN isFCRA = FALSE) :=  function

    SetRequireLinkingId := ['DID'];   //Get DID records only
    KeyNamePrefix	    := 'thor_data400::key::suppression::'+IF(isFCRA,'fcra::','');
    KeyNameSuffix       := '::link_type_did';
    key_name            := Data_Services.Data_location.Prefix('NONAMEGIVEN')+ KeyNamePrefix + doxie.Version_SuperKey + KeyNameSuffix;

    get_recs            := if(isFCRA, Suppress.File_New_Suppression_FCRA,Suppress.File_New_Suppression);

    // Trasform to key layout and dedup
    FilteredDS          := get_recs(ut.CleanSpacesAndUpper(linking_type) in ['DID'] and (unsigned8)linking_id<>0);
    $.Layout_New_Suppression_Did tx(FilteredDS L) := TRANSFORM
        SELF.Did        := (UNSIGNED8) L.linking_id;
        SELF            := L; 
    END;

    final               := PROJECT(FilteredDS,tx(LEFT));
    final_dedup         := DEDUP(SORT(DISTRIBUTE(final,did),did,-Date_Added,LOCAL),RECORD,LOCAL);

    key                 := index(final_dedup,{did},{Date_Added,User,Compliance_ID},key_name);

    return key;

end;