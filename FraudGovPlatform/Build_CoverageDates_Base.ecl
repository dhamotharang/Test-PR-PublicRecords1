import STD,ut,FraudShared,tools;

export Build_CoverageDates_Base (
            string pversion
        , dataset(FraudShared.Layouts.Base.Main) pBaseFile = FraudShared.Files().Base.Main.Built 
        ) := 
module 

    slim_rec := RECORD
            Layouts.CoverageDates;
            unsigned8 	Record_ID;
            unsigned3   file_type;	
            unsigned2	Confidence_that_activity_was_deceitful_id;
            string250	reason_description;
    END;


    nac_data_reasons := [ 'SEARCH IN NATIONAL ACCURACY CLEARINGHOUSE'
                         ,'IDENTITY ASSOCIATED TO NAC LEVEL 1 COLLISION'
                         ,'IDENTITY ASSOCIATED TO NAC LEVEL 2 COLLISION' ] ;


    rdp_data_reasons := [ 'APPLICANT ACTIVITY VIA LEXISNEXIS' ] ;


    slim_rec slim_rec_t(pBaseFile L) := TRANSFORM
        SELF.customer_id := L.classification_Permissible_use_access.gc_id;
        SELF.customer_state := L.classification_source.customer_state;
        SELF.customer_program := functions.customer_program_fn(L.classification_Permissible_use_access.ind_type);
        SELF.file_type := L.classification_Permissible_use_access.file_type;
        SELF.contribution_code := L.classification_Permissible_use_access.fdn_file_code;
        SELF.Confidence_that_activity_was_deceitful_id := L.classification_Activity.Confidence_that_activity_was_deceitful_id;
        SELF.max_reported_date := (unsigned4)L.reported_date;
        SELF.max_process_date := L.process_date;
        SELF.reason_description := L.reason_description;
        SELF.source := '';
        SELF := L;
    end;
                                                                        
    slim_file:= project( pBaseFile, slim_rec_t(LEFT));

        
    slim_rec find_nac_data(slim_rec L) := TRANSFORM
        SELF.source := MAP( ut.CleanSpacesAndUpper(L.Reason_Description) in nac_data_reasons and L.source = '' => 'NAC'
                            , ut.CleanSpacesAndUpper(L.Reason_Description) in rdp_data_reasons and L.source = '' => 'RDP'
                            , L.source );
        SELF.source_group := if(ut.CleanSpacesAndUpper(L.Reason_Description) in (nac_data_reasons + rdp_data_reasons) and L.source_group = '', 'SUPPLEMENTAL', L.source_group );
        SELF := L;
    end;
                                                                        
    supplemental_data:= project( slim_file, find_nac_data(LEFT));
    

    slim_rec find_agency_activity(slim_rec L) := transform
        SELF.source := MAP(
                              STD.Str.Contains ( L.contribution_code, 'DELTABASE' ,true) and L.source = '' AND L.Confidence_that_activity_was_deceitful_id != 3 AND L.file_type = 3=> 'IDENTITY'
                            , STD.Str.Contains ( L.contribution_code, 'DELTABASE' ,true) and L.source = '' AND L.Confidence_that_activity_was_deceitful_id != 3 AND L.file_type = 1=> 'KNOWNRISK'
                            , STD.Str.Contains ( L.contribution_code, 'DELTABASE' ,true) and L.source = '' AND L.file_type = 5 => 'STATUS UPDATE'
                            , STD.Str.Contains ( L.contribution_code, 'DELTABASE' ,true) and L.source = '' AND L.Confidence_that_activity_was_deceitful_id = 3 => 'SAFELIST'
                            , L.source 
                        );
        SELF.source_group := if(STD.Str.Contains ( L.contribution_code, 'DELTABASE' ,true) and L.source_group = '', 'DELTABASE', L.source_group );
        SELF := L;
    end;
                                                                        
    agency_activity:= project( supplemental_data, find_agency_activity(LEFT));


    slim_rec find_safelist_file(slim_rec L) := transform
        SELF.source := if(L.Confidence_that_activity_was_deceitful_id = 3 and L.source = '', 'SAFELIST', L.source );
        SELF.source_group := if(L.Confidence_that_activity_was_deceitful_id = 3 and L.source_group = '', 'SAFELIST', L.source_group );
        SELF := L;
    end;
                                                                        
    safelist_file := project( agency_activity, find_safelist_file(LEFT));

    slim_rec find_identity_file(slim_rec L) := transform
        SELF.source := if(L.file_type = 3 and L.source = '', 'IDENTITY', L.source );
        SELF.source_group := if(L.file_type = 3 and L.source_group = '', 'IDENTITY', L.source_group );
        SELF := L;
    end;
                                                                        
    identity_file := project( safelist_file, find_identity_file(LEFT));

    slim_rec find_knownrisk_file(slim_rec L) := transform
        SELF.source := if(L.file_type = 1 and L.source = '', 'KNOWNRISK', L.source );
        SELF.source_group := if(L.file_type = 1 and L.source_group = '', 'KNOWNRISK', L.source_group );
        SELF := L;
    end;
                                                                        
    knownrisk_file := project( identity_file, find_knownrisk_file(LEFT));


        pDataset_sort := sort(knownrisk_file , Customer_ID, Customer_State, Customer_Program, contribution_code, source, source_group, -max_reported_date);
                
        pDataset_sort RollupBase(pDataset_sort l, pDataset_sort r) := 
        transform
            self.max_reported_date := max(l.max_reported_date, r.max_reported_date); 
            self := l;

        end;
         

        pDataset_rollup := rollup( pDataset_sort
                ,RollupBase(left, right)
                ,Customer_ID,	Customer_State, 	Customer_Program, 	contribution_code, 	source, source_group
                );
    
    
        pDataset_sort2 := sort(knownrisk_file , Customer_ID,	Customer_State, Customer_Program, contribution_code, source, source_group, -max_process_date);
                
        pDataset_sort2 RollupBase2(pDataset_sort2 l, pDataset_sort2 r) := 
        transform
            self.max_process_date := max(l.max_process_date, r.max_process_date); 
            self := l;

        end;

        pDataset_rollup2 := rollup( pDataset_sort2
            ,RollupBase2(left, right)
            ,Customer_ID,	Customer_State, Customer_program, contribution_code, 	source, source_group
            ); 
    

    my_table2:= table(
        knownrisk_file
        ,{ Customer_ID
            ,Customer_State
            ,Customer_Program
            ,contribution_code
            ,source
            ,source_group
            ,unsigned3 record_count := count(group)
        }
            ,Customer_ID
            ,Customer_Program		
            ,contribution_code
            ,Customer_State
            ,source
            ,source_group
    );

    j1 := join (my_table2,pDataset_rollup,
                            left.Customer_ID = right.Customer_ID
                        and left.Customer_Program	= right.Customer_Program
                        and left.contribution_code = right.contribution_code
                        and left.Customer_State = right.Customer_State
                        and left.source = right.source
                        and left.source_group = right.source_group, 
                        transform(Layouts.CoverageDates,
                                self.max_reported_date := right.max_reported_date;
                                self := left;
                            )
                        );

    final_rec := join (j1,pDataset_rollup2,
                            left.Customer_ID = right.Customer_ID
                        and left.Customer_Program	= right.Customer_Program
                        and left.contribution_code = right.contribution_code
                        and left.Customer_State = right.Customer_State
                        and left.source = right.source
                        and left.source_group = right.source_group, 
                        transform(Layouts.CoverageDates,
                                self.max_process_date := right.max_process_date;
                                self := left;
                            )
                        );

    tools.mac_WriteFile(FraudGovPlatform.Filenames(pversion).Base.CoverageDates.New,final_rec,Build_Base_File_CoverageDates);

    

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				  Build_Base_File_CoverageDates
				, Promote(pversion).buildfiles.New2Built
                )
		,output('No Valid version parameter passed, skipping Build_Base_Anonymized atribute')
	);
end;
