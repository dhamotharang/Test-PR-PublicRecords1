import STD,ut,tools;

export Build_CoverageDates_Base (
            string pversion
        , dataset(FraudGovPlatform.Layouts.Base.Main) pBaseFile = $.Files().Base.Main_Orig.Built 
        ) := 
module 

    /************************       Documentation        ***********************
    https://confluence.rsi.lexisnexis.com/display/GTG/Data+Source+Identification
    ****************************************************************************/
    dBaseFile := distribute(pBaseFile, hash32(classification_Permissible_use_access.gc_id,	classification_source.customer_state, 	classification_Permissible_use_access.ind_type,  	source) );
;
    slim_rec := RECORD
            Layouts.CoverageDates;
            unsigned8 	Record_ID;
            unsigned3   file_type;	
            unsigned2	Confidence_that_activity_was_deceitful_id;
            string250	reason_description;
            unsigned1   RIN_Source;
    END;


    nac_data_reasons := [ 'SEARCH IN NATIONAL ACCURACY CLEARINGHOUSE'
                         ,'IDENTITY ASSOCIATED TO NAC LEVEL 1 COLLISION'
                         ,'IDENTITY ASSOCIATED TO NAC LEVEL 2 COLLISION' ] ;


    rdp_data_reasons := [ 'APPLICANT ACTIVITY VIA LEXISNEXIS' ] ;


    slim_rec slim_rec_t(dBaseFile L) := TRANSFORM
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
                                                                        
    slim_file:= project( dBaseFile, slim_rec_t(LEFT), LOCAL);

        
    slim_rec find_nac_data(slim_rec L) := TRANSFORM
        SELF.source := MAP(   L.Rin_Source = 8 => 'NAC'
                            , L.Rin_Source = 10=> 'NAC'
                            , L.Rin_Source = 11=> 'NAC'
                            , L.Rin_Source = 9 => 'RDP'
                            , L.Rin_Source = 4 => 'IDENTITY'
                            , L.Rin_Source = 5 => 'KNOWNRISK'
                            , L.Rin_Source = 6 => 'STATUS UPDATE'
                            , L.Rin_Source = 7 => 'SAFELIST'
                            , L.Rin_Source = 3 => 'SAFELIST'
                            , L.Rin_Source = 2 => 'KNOWNRISK'
                            , L.Rin_Source = 1 => 'IDENTITY'
                            , L.source );

        SELF.source_group := MAP(   
                              L.Rin_Source = 8 => 'SUPPLEMENTAL'
                            , L.Rin_Source = 10=> 'SUPPLEMENTAL'
                            , L.Rin_Source = 11=> 'SUPPLEMENTAL'                              
                            , L.Rin_Source = 9 => 'SUPPLEMENTAL'
                            , L.Rin_Source = 4 => 'AGENCYACTIVITY'
                            , L.Rin_Source = 5 => 'AGENCYACTIVITY'
                            , L.Rin_Source = 6 => 'AGENCYACTIVITY'
                            , L.Rin_Source = 7 => 'AGENCYACTIVITY'
                            , L.Rin_Source = 3 => 'SAFELIST'
                            , L.Rin_Source = 2 => 'KNOWNRISK'
                            , L.Rin_Source = 1 => 'IDENTITY'
                            , L.source );                            
        SELF := L;
    end;
                                                                        
    source_data:= project( slim_file, find_nac_data(LEFT), LOCAL);
    
    pDataset_sort := sort(source_data , Customer_ID, Customer_State, Customer_Program, contribution_code, source, source_group, -max_reported_date, LOCAL);
            
    pDataset_sort RollupBase(pDataset_sort l, pDataset_sort r) := 
    transform
        self.max_reported_date := max(l.max_reported_date, r.max_reported_date); 
        self := l;

    end;

    pDataset_rollup := rollup( pDataset_sort
            ,RollupBase(left, right)
            ,Customer_ID,	Customer_State, 	Customer_Program, 	contribution_code, 	source, source_group,
            LOCAL);

    pDataset_sort2 := sort(source_data , Customer_ID,	Customer_State, Customer_Program, contribution_code, source, source_group, -max_process_date, LOCAL);
            
    pDataset_sort2 RollupBase2(pDataset_sort2 l, pDataset_sort2 r) := 
    transform
        self.max_process_date := max(l.max_process_date, r.max_process_date); 
        self := l;

    end;

    pDataset_rollup2 := rollup( pDataset_sort2
        ,RollupBase2(left, right)
        ,Customer_ID,	Customer_State, Customer_program, contribution_code, 	source, source_group
        ,LOCAL); 
    

    my_table2:= table(
        source_data
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
    ,LOCAL);

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
                        ,LOCAL);

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
                        ,LOCAL);

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
