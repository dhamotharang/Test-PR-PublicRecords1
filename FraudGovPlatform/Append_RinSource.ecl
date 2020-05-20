import STD,ut,FraudShared,tools;

export Append_RinSource (
        dataset(FraudShared.Layouts.Base.Main) pBaseFile = FraudShared.Files().Base.Main.Built 
) := 
FUNCTION 

    /************************       Documentation        ***********************
    https://confluence.rsi.lexisnexis.com/display/GTG/Data+Source+Identification
    ****************************************************************************/
    nac_data_reasons := [ 'SEARCH IN NATIONAL ACCURACY CLEARINGHOUSE'
                         ,'IDENTITY ASSOCIATED TO NAC LEVEL 1 COLLISION'
                         ,'IDENTITY ASSOCIATED TO NAC LEVEL 2 COLLISION' ] ;


    rdp_data_reasons := [ 'APPLICANT ACTIVITY VIA LEXISNEXIS' ] ;


        
    FraudShared.Layouts.Base.Main find_nac_data(FraudShared.Layouts.Base.Main L) := TRANSFORM
        SELF.RIN_Source := MAP( ut.CleanSpacesAndUpper(L.Reason_Description) in nac_data_reasons and L.RIN_Source = 0 => 8
                            , ut.CleanSpacesAndUpper(L.Reason_Description) in rdp_data_reasons and L.RIN_Source = 0 => 9
                            , L.RIN_Source
                        );
        SELF := L;
    end;
                                                                        
    supplemental_data:= project( pBaseFile, find_nac_data(LEFT));
    

    FraudShared.Layouts.Base.Main find_agency_activity(FraudShared.Layouts.Base.Main L) := transform
        SELF.RIN_Source := MAP(
                              STD.Str.Contains ( L.classification_Permissible_use_access.fdn_file_code, 'DELTABASE' ,true) and L.RIN_Source = 0 AND L.classification_Activity.Confidence_that_activity_was_deceitful_id != 3 AND L.classification_Permissible_use_access.file_type = 3=> 4
                            , STD.Str.Contains ( L.classification_Permissible_use_access.fdn_file_code, 'DELTABASE' ,true) and L.RIN_Source = 0 AND L.classification_Activity.Confidence_that_activity_was_deceitful_id != 3 AND L.classification_Permissible_use_access.file_type = 1=> 5
                            , STD.Str.Contains ( L.classification_Permissible_use_access.fdn_file_code, 'DELTABASE' ,true) and L.RIN_Source = 0 AND L.classification_Permissible_use_access.file_type = 5 => 6
                            , STD.Str.Contains ( L.classification_Permissible_use_access.fdn_file_code, 'DELTABASE' ,true) and L.RIN_Source = 0 AND L.classification_Activity.Confidence_that_activity_was_deceitful_id = 3 => 7
                            , L.RIN_Source
                        );
        SELF := L;
    end;
                                                                        
    agency_activity:= project( supplemental_data, find_agency_activity(LEFT));


    FraudShared.Layouts.Base.Main find_safelist_file(FraudShared.Layouts.Base.Main L) := transform
        SELF.RIN_Source := if(L.classification_Activity.Confidence_that_activity_was_deceitful_id = 3 and L.RIN_Source = 0, 3, L.RIN_Source );
        SELF := L;
    end;
                                                                        
    safelist_file := project( agency_activity, find_safelist_file(LEFT));

    FraudShared.Layouts.Base.Main find_identity_file(FraudShared.Layouts.Base.Main L) := transform
        SELF.RIN_Source := if(L.classification_Permissible_use_access.file_type = 3 and L.RIN_Source = 0, 1, L.RIN_Source );
        SELF := L;
    end;
                                                                        
    identity_file := project( safelist_file, find_identity_file(LEFT));

    FraudShared.Layouts.Base.Main find_knownrisk_file(FraudShared.Layouts.Base.Main L) := transform
        SELF.RIN_Source := if(L.classification_Permissible_use_access.file_type = 1 and L.RIN_Source = 0, 2, L.RIN_Source );
        SELF := L;
    end;
                                                                        
    knownrisk_file := project( identity_file, find_knownrisk_file(LEFT)); 

	return knownrisk_file;

end;
