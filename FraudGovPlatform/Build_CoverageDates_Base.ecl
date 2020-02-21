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


    supplement_data_reasons := [ 'SEARCH IN NATIONAL ACCURACY CLEARINGHOUSE'
                                ,'IDENTITY ASSOCIATED TO NAC LEVEL 1 COLLISION'
                                ,'IDENTITY ASSOCIATED TO NAC LEVEL 2 COLLISION'
                                ,'APPLICANT ACTIVITY VIA LEXISNEXIS'] ;
                                                                                    

    slim_rec slim_rec_t(pBaseFile L) := TRANSFORM
        SELF.gc_id := L.classification_Permissible_use_access.gc_id;
        SELF.customer_state := L.classification_source.customer_state;
        SELF.ind_type := L.classification_Permissible_use_access.ind_type;
        SELF.file_type := L.classification_Permissible_use_access.file_type;
        SELF.fdn_file_code := L.classification_Permissible_use_access.fdn_file_code;
        SELF.Confidence_that_activity_was_deceitful_id := L.classification_Activity.Confidence_that_activity_was_deceitful_id;
        SELF.reported_date := (unsigned4)L.reported_date;
        SELF.reason_description := L.reason_description;
        SELF := L;
    end;
                                                                        
    slim_file:= project( pBaseFile, slim_rec_t(LEFT));

        
    slim_rec find_supplement_data(slim_rec L) := TRANSFORM
        SELF.clean_source := if(ut.CleanSpacesAndUpper(L.Reason_Description) in supplement_data_reasons and L.clean_source = '', 'SUPPLEMENTAL DATA', L.clean_source );
        SELF := L;
    end;
                                                                        
    supplement_data:= project( slim_file, find_supplement_data(LEFT));
    

    slim_rec find_agency_activity(slim_rec L) := transform
        SELF.clean_source := if(STD.Str.Contains ( L.fdn_file_code, 'DELTABASE' ,true) and L.clean_source = '', 'AGENCY ACTIVITY', L.clean_source );
        SELF := L;
    end;
                                                                        
    agency_activity:= project( supplement_data, find_agency_activity(LEFT));


    slim_rec find_safelist_file(slim_rec L) := transform
        SELF.clean_source := if(L.Confidence_that_activity_was_deceitful_id = 3 and L.clean_source = '', 'SAFE LIST FILE', L.clean_source );
        SELF := L;
    end;
                                                                        
    safelist_file := project( agency_activity, find_safelist_file(LEFT));

    slim_rec find_identity_file(slim_rec L) := transform
        SELF.clean_source := if(L.file_type = 3 and L.clean_source = '', 'IDENTITY FILE', L.clean_source );
        SELF := L;
    end;
                                                                        
    identity_file := project( safelist_file, find_identity_file(LEFT));

    slim_rec find_knownrisk_file(slim_rec L) := transform
        SELF.clean_source := if(L.file_type = 1 and L.clean_source = '', 'KNOWN RISK FILE', L.clean_source );
        SELF := L;
    end;
                                                                        
    knownrisk_file := project( identity_file, find_knownrisk_file(LEFT));


        pDataset_sort := sort(knownrisk_file , gc_id, Customer_State, ind_type, fdn_file_code, clean_source, -reported_date);
                
        pDataset_sort RollupBase(pDataset_sort l, pDataset_sort r) := 
        transform
            self.reported_date := max(l.reported_date, r.reported_date); 
            self := l;

        end;

        pDataset_rollup := rollup( pDataset_sort
                ,RollupBase(left, right)
                ,gc_id,	Customer_State, 	ind_type, 	fdn_file_code, 	clean_source
                );
    
    
        pDataset_sort2 := sort(knownrisk_file , gc_id,	Customer_State, ind_type, fdn_file_code, clean_source, -process_date);
                
        pDataset_sort2 RollupBase2(pDataset_sort2 l, pDataset_sort2 r) := 
        transform
            self.process_date := max(l.process_date, r.process_date); 
            self := l;

        end;

        pDataset_rollup2 := rollup( pDataset_sort2
            ,RollupBase2(left, right)
            ,gc_id,	Customer_State, ind_type, fdn_file_code, 	clean_source
            ); 
    

    my_table2:= table(
        knownrisk_file
        ,{ gc_id
            ,Customer_State
            ,ind_type
            ,fdn_file_code
            ,clean_source
            ,unsigned3 row_count := count(group)
        }
            ,gc_id
            ,ind_type		
            ,fdn_file_code
            ,Customer_State
            ,clean_source
    );

    j1 := join (my_table2,pDataset_rollup,
                            left.gc_id = right.gc_id
                        and left.ind_type	= right.ind_type
                        and left.fdn_file_code = right.fdn_file_code
                        and left.Customer_State = right.Customer_State
                        and left.clean_source = right.clean_source, 
                        transform(Layouts.CoverageDates,
                                self.reported_date := right.reported_date;
                                self := left;
                            )
                        );

    final_rec := join (j1,pDataset_rollup2,
                            left.gc_id = right.gc_id
                        and left.ind_type	= right.ind_type
                        and left.fdn_file_code = right.fdn_file_code
                        and left.Customer_State = right.Customer_State
                        and left.clean_source = right.clean_source, 
                        transform(Layouts.CoverageDates,
                                self.process_date := right.process_date;
                                self := left;
                            )
                        );

    tools.mac_WriteFile(FraudGovPlatform.Filenames(pversion).Base.CoverageDates.New,final_rec,Build_Base_File_CoverageDates);

    

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				Build_Base_File_CoverageDates
				//,Promote(pversion).buildfiles.New2Built
                )
		,output('No Valid version parameter passed, skipping Build_Base_Anonymized atribute')
	);
end;
