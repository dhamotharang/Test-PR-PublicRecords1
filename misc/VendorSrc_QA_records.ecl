import lib_stringlib;

export VendorSrc_QA_records := module

    // This is the superfile that holds the contents of the merged base files
    export BaseSuperFileName   := '~thor_data400::base::vendor_src_info';
    export FatherSuperFileName := '~thor_data400::base::vendor_src_info_father';

    export SourceCodeSet := ['PL','DS','LI','L2','EN'];
    export SecondarySourceCodeSet := 
        ['W@', '6X', 'DF', 'CH', 'U2', 'IT', 'Y', 'UF', '%W', 'DS', 'LI', 'L2', 'C4'];
                
    // The following grouping is designed to construct a log message (taking a description and
    // a count) that continually appends to the output result. In this case it is used for the
    // grouping of dataset counts.
    export CountLoggingRecord := record
        string      _logDescription;
        integer     _count;
    end;

    export outputCountLogMsg(string _logDescription, integer _count, string LogName) := 
        output(dataset([{_logDescription, _count}], CountLoggingRecord), named (LogName), extend);

    export FieldLoggingRecord := record
        string      _logDescription;
        string      _Field1;
        string      _Field2;
        string      _Source;
    end;

    export outputFieldLogMsg(string    _logDescription, 
                             string    _NewField,    
                             string    _PrevField,
                             string    _Source,
                             string     LogName) := 
        output(dataset([{_logDescription, _NewField, _PrevField, _Source}], FieldLoggingRecord), named (LogName), extend);

    // This is a function to log the differences in the files
    export logFieldDifference(string description, string leftField, string rightField, string source, string tableName) := function
        
        outputFieldLogMsg(description ,leftField, rightField, source, tableName);

        return leftField;
        
    end;

    // !!! Function to match the requirements of the if statement - can delete
    export outputUnavailableMessage := function

        output('There are not enough files available for comparison');
       
        return 'There are not enough files available for comparison';
        
    end;
         
    // This is the function that does the heavy lifting for the various file comparisons    
    export processFileComparison() := function
  
        // Get the foreign filename in the point of last entry
        newBaseName  := '~' + nothor(fileservices.superfilecontents(BaseSuperFileName)[1].name);
        prevBaseName := '~' + nothor(fileservices.superfilecontents(FatherSuperFileName)[1].name);

        // Temporary output to see what is going on
        output(newBaseName, named('newBaseName'));
        output(prevBaseName, named('prevBaseName'));
        
        // return newBaseName;
   
        // Get the files themselves
        newBaseFile  := dataset(newBaseName, misc.layout_vendorsrc.mergedsrc_base, thor, __compressed__);
        output(choosen(newBaseFile, 100), named('newBaseFile'));

        prevBaseFile := dataset(prevBaseName, misc.layout_vendorsrc.mergedsrc_base, thor, __compressed__);
        output(choosen(prevBaseFile, 100), named('prevBaseFile'));

        newBaseFileSort  := sort(newBaseFile(source_code in SourceCodeSet), source_code);
        output(newBaseFileSort, named('NewSourceCodeRecords'));

        prevBaseFileSort := sort(prevBaseFile(source_code in SourceCodeSet), source_code);
        output(prevBaseFileSort, named('PrevSourceCodeRecords'));

        // Temporary output to see what is going on
        // output(newBaseName,, '~thor_data400::temp::vendor_src::newBaseName', compressed, overwrite);
        // output(prevBaseName,, '~thor_data400::temp::vendor_src::prevBaseName', compressed, overwrite);
  
        // New_base    := misc.Files_VendorSrc('').combined_base;
        // Prev_base    := misc.Files_VendorSrc('').combined_base_prev;
        

        // get new records for QA
        // new_for_compare   := dedup(distribute(project(newBaseFile,  misc.layout_vendorsrc.mergedsrc_base - [date_added]),hash(item_source)),all);
        // prev_for_compare  := dedup(distribute(project(prevBaseFile, misc.layout_vendorsrc.mergedsrc_base - [date_added]),hash(item_source)),all);

        // DedupBase            :=dedup(distribute(SortOldAndNew, hash(item_source, source_code)), item_source, source_code, all, local);
        // Sort the two files
        new_for_compare   := sort(distribute(newBaseFile, hash(item_source, source_code)), item_source, source_code, local);
        output(choosen(new_for_compare, 100), named('new_for_compare'));

        prev_for_compare  := sort(distribute(prevBaseFile, hash(item_source, source_code)), item_source, source_code, local);
        output(choosen(prev_for_compare, 100), named('prev_for_compare'));
       // RolledBase := ROLLUP(SortOldAndNew,
                             // left.item_source    =    right.item_source and
                             // left.source_code    =    right.source_code and
                             // left.input_file_id  =    right.input_file_id,
                             // t_rollup(LEFT,RIGHT),LOCAL);    

   
        // new_for_compare    JoinBase(new_for_compare L, prev_for_compare R)    := TRANSFORM
            // SELF    := L;
        // END;
        // onNewNotOnOld t_leftonly () := transform
            // left.description := if (trim(left.description)  =  ''      and 
                                    // trim(right.description) <> '', 
                                        // right.description,
                                        // left.description);
        // end;
        
        onNewNotOnOld := join(new_for_compare, prev_for_compare, 
                             left.item_source          =  right.item_source          and                                
                             left.source_code          =  right.source_code          and       
                             left.display_name         =  right.display_name         and          
//                           left.description          =  right.description          and           
//                           left.status               =  right.status               and    
                             left.data_notes           =  right.data_notes           and 
                             left.coverage_1           =  right.coverage_1           and
                             left.coverage_2           =  right.coverage_2           and
//                           left.orbit_item_name      =  right.orbit_item_name      and
//                           left.orbit_source         =  right.orbit_source         and
//                           left.orbit_number         =  right.orbit_number         and
                             left.website              =  right.website              and
                             left.notes                =  right.notes                and
//                           left.date_added           =  right.date_added           and
                             left.input_file_id        =  right.input_file_id        and  
                             left.market_restrict_flag =  right.market_restrict_flag and      
                             left.clean_phone          =  right.clean_phone          and  
                             left.clean_fax            =  right.clean_fax            and
                             left.Prepped_addr1        =  right.Prepped_addr1        and
                             left.Prepped_addr2        =  right.Prepped_addr2        and         
                             left.v_prim_name          =  right.v_prim_name          and         
                             left.v_zip                =  right.v_zip                and
                             left.v_zip4               =  right.v_zip4               and
                             left.prim_range           =  right.prim_range           and
                             left.predir               =  right.predir               and
                             left.prim_name            =  right.prim_name            and
                             left.addr_suffix          =  right.addr_suffix          and
                             left.postdir              =  right.postdir              and
                             left.unit_desig           =  right.unit_desig           and
                             left.sec_range            =  right.sec_range            and
                             left.p_city_name          =  right.p_city_name          and
                             left.v_city_name          =  right.v_city_name          and
                             left.st                   =  right.st                   and
                             left.zip                  =  right.zip                  and
                             left.zip4                 =  right.zip4                 and
                             left.cart                 =  right.cart                 and
                             left.cr_sort_sz           =  right.cr_sort_sz           and
                             left.lot                  =  right.lot                  and
                             left.lot_order            =  right.lot_order            and
                             left.dbpc                 =  right.dbpc                 and
                             left.chk_digit            =  right.chk_digit            and
                             left.rec_type             =  right.rec_type             and
                             left.county               =  right.county               and       
                             left.geo_lat              =  right.geo_lat              and       
                             left.geo_long             =  right.geo_long             and       
                             left.msa                  =  right.msa                  and       
                             left.geo_blk              =  right.geo_blk              and       
                             left.geo_match            =  right.geo_match            and       
                             left.err_stat             =  right.err_stat,                   
                             // left = right,
                             // JoinBase(left, right),
                             transform(misc.Layout_VendorSrc.MergedSrc_Base,
                                 // self.description := if (trim(left.description)  =  ''      and 
                                                         // trim(right.description) <> '', 
                                                             // right.description,
                                                             // left.description),
                                 self.description     := if (trim(left.description) <> trim(right.description),
                                                             logFieldDifference('Description', left.description, right.description, left.item_source, 'onNewNotOnOld Difference'),
                                                             left.description),
                                 self.status          := if (trim(left.status) <> trim(right.status),
                                                             logFieldDifference('Status', left.status, right.status, left.item_source, 'onNewNotOnOld Difference'),
                                                             left.status),
                                 self.orbit_item_name := if (trim(left.orbit_item_name) <> trim(right.orbit_item_name),
                                                             logFieldDifference('Orbit Item Name', left.orbit_item_name, right.orbit_item_name, left.item_source, 'onNewNotOnOld Difference'),
                                                             left.orbit_item_name),
                                 self.orbit_number    := if (trim(left.orbit_number) <> trim(right.orbit_number),
                                                             logFieldDifference('Orbit Number', left.orbit_number, right.orbit_number, left.item_source, 'onNewNotOnOld Difference'),
                                                             left.orbit_number),
                                 self.orbit_source    := if (trim(left.orbit_source) <> trim(right.orbit_source),
                                                             logFieldDifference('Orbit Source', left.orbit_source, right.orbit_source, left.item_source, 'onNewNotOnOld Difference'),
                                                             left.orbit_source),
                                 self.date_added      := if (trim(left.date_added) <> trim(right.date_added),
                                                             logFieldDifference('Date Added', left.date_added, right.date_added, left.item_source, 'onNewNotOnOld Difference'),
                                                             left.date_added),
                                 self                 := left),
                             left only); 

         onOldNotOnNew := join(new_for_compare, prev_for_compare, 
                             left.item_source          =  right.item_source          and                                
                             left.source_code          =  right.source_code          and       
                             left.display_name         =  right.display_name         and          
//                           left.description          =  right.description          and           
//                           left.status               =  right.status               and    
                             left.data_notes           =  right.data_notes           and 
                             left.coverage_1           =  right.coverage_1           and
                             left.coverage_2           =  right.coverage_2           and
//                           left.orbit_item_name      =  right.orbit_item_name      and
//                           left.orbit_source         =  right.orbit_source         and
//                           left.orbit_number         =  right.orbit_number         and
                             left.website              =  right.website              and
                             left.notes                =  right.notes                and
//                           left.date_added           =  right.date_added           and
                             left.input_file_id        =  right.input_file_id        and  
                             left.market_restrict_flag =  right.market_restrict_flag and      
                             left.clean_phone          =  right.clean_phone          and  
                             left.clean_fax            =  right.clean_fax            and
                             left.Prepped_addr1        =  right.Prepped_addr1        and
                             left.Prepped_addr2        =  right.Prepped_addr2        and         
                             left.v_prim_name          =  right.v_prim_name          and         
                             left.v_zip                =  right.v_zip                and
                             left.v_zip4               =  right.v_zip4               and
                             left.prim_range           =  right.prim_range           and
                             left.predir               =  right.predir               and
                             left.prim_name            =  right.prim_name            and
                             left.addr_suffix          =  right.addr_suffix          and
                             left.postdir              =  right.postdir              and
                             left.unit_desig           =  right.unit_desig           and
                             left.sec_range            =  right.sec_range            and
                             left.p_city_name          =  right.p_city_name          and
                             left.v_city_name          =  right.v_city_name          and
                             left.st                   =  right.st                   and
                             left.zip                  =  right.zip                  and
                             left.zip4                 =  right.zip4                 and
                             left.cart                 =  right.cart                 and
                             left.cr_sort_sz           =  right.cr_sort_sz           and
                             left.lot                  =  right.lot                  and
                             left.lot_order            =  right.lot_order            and
                             left.dbpc                 =  right.dbpc                 and
                             left.chk_digit            =  right.chk_digit            and
                             left.rec_type             =  right.rec_type             and
                             left.county               =  right.county               and       
                             left.geo_lat              =  right.geo_lat              and       
                             left.geo_long             =  right.geo_long             and       
                             left.msa                  =  right.msa                  and       
                             left.geo_blk              =  right.geo_blk              and       
                             left.geo_match            =  right.geo_match            and       
                             left.err_stat             =  right.err_stat,                   
                             // left = right,
                             transform(misc.Layout_VendorSrc.MergedSrc_Base,
                                 self.description     := if (trim(left.description) <> trim(right.description),
                                                             logFieldDifference('Description', left.description, right.description, right.item_source, 'onOldNotOnNew Difference'),
                                                             right.description),
                                 self.status          := if (trim(left.status) <> trim(right.status),
                                                             logFieldDifference('Status', left.status, right.status, right.item_source, 'onOldNotOnNew Difference'),
                                                             right.status),
                                 self.orbit_item_name := if (trim(left.orbit_item_name) <> trim(right.orbit_item_name),
                                                             logFieldDifference('Orbit Item Name', left.orbit_item_name, right.orbit_item_name, right.item_source, 'onOldNotOnNew Difference'),
                                                             right.orbit_item_name),
                                 self.orbit_number    := if (trim(left.orbit_number) <> trim(right.orbit_number),
                                                             logFieldDifference('Orbit Number', left.orbit_number, right.orbit_number, right.item_source, 'onOldNotOnNew Difference'),
                                                             right.orbit_number),
                                 self.orbit_source    := if (trim(left.orbit_source) <> trim(right.orbit_source),
                                                             logFieldDifference('Orbit Source', left.orbit_source, right.orbit_source, right.item_source, 'onOldNotOnNew Difference'),
                                                             right.orbit_source),
                                 self.date_added      := if (trim(left.date_added) <> trim(right.date_added),
                                                             logFieldDifference('Date Added', left.date_added, right.date_added, right.item_source, 'onOldNotOnNew Difference'),
                                                             right.date_added),
                                 self                 := right),
                             right only); 

        onBothFiles := join(new_for_compare, prev_for_compare, 
                             left.item_source          =  right.item_source          and                                
                             left.source_code          =  right.source_code          and       
                             left.display_name         =  right.display_name         and          
//                           left.description          =  right.description          and           
//                           left.status               =  right.status               and    
                             left.data_notes           =  right.data_notes           and 
                             left.coverage_1           =  right.coverage_1           and
                             left.coverage_2           =  right.coverage_2           and
//                           left.orbit_item_name      =  right.orbit_item_name      and
//                           left.orbit_source         =  right.orbit_source         and
//                           left.orbit_number         =  right.orbit_number         and
                             left.website              =  right.website              and
                             left.notes                =  right.notes                and
//                           left.date_added           =  right.date_added           and
                             left.input_file_id        =  right.input_file_id        and  
                             left.market_restrict_flag =  right.market_restrict_flag and      
                             left.clean_phone          =  right.clean_phone          and  
                             left.clean_fax            =  right.clean_fax            and
                             left.Prepped_addr1        =  right.Prepped_addr1        and
                             left.Prepped_addr2        =  right.Prepped_addr2        and         
                             left.v_prim_name          =  right.v_prim_name          and         
                             left.v_zip                =  right.v_zip                and
                             left.v_zip4               =  right.v_zip4               and
                             left.prim_range           =  right.prim_range           and
                             left.predir               =  right.predir               and
                             left.prim_name            =  right.prim_name            and
                             left.addr_suffix          =  right.addr_suffix          and
                             left.postdir              =  right.postdir              and
                             left.unit_desig           =  right.unit_desig           and
                             left.sec_range            =  right.sec_range            and
                             left.p_city_name          =  right.p_city_name          and
                             left.v_city_name          =  right.v_city_name          and
                             left.st                   =  right.st                   and
                             left.zip                  =  right.zip                  and
                             left.zip4                 =  right.zip4                 and
                             left.cart                 =  right.cart                 and
                             left.cr_sort_sz           =  right.cr_sort_sz           and
                             left.lot                  =  right.lot                  and
                             left.lot_order            =  right.lot_order            and
                             left.dbpc                 =  right.dbpc                 and
                             left.chk_digit            =  right.chk_digit            and
                             left.rec_type             =  right.rec_type             and
                             left.county               =  right.county               and       
                             left.geo_lat              =  right.geo_lat              and       
                             left.geo_long             =  right.geo_long             and       
                             left.msa                  =  right.msa                  and       
                             left.geo_blk              =  right.geo_blk              and       
                             left.geo_match            =  right.geo_match            and       
                             left.err_stat             =  right.err_stat,                   
                             // left = right,
                             // JoinBase(left, right),
                             transform(misc.Layout_VendorSrc.MergedSrc_Base,
                                 // self.description := if (trim(left.description)  =  ''      and 
                                                         // trim(right.description) <> '', 
                                                             // right.description,
                                                             // left.description),
                                 self.description     := if (trim(left.description) <> trim(right.description),
                                                             logFieldDifference('Description', left.description, right.description, left.item_source, 'onBothFiles Difference'),
                                                             left.description),
                                 self.status          := if (trim(left.status) <> trim(right.status),
                                                             logFieldDifference('Status', left.status, right.status, left.item_source, 'onBothFiles Difference'),
                                                             left.status),
                                 self.orbit_item_name := if (trim(left.orbit_item_name) <> trim(right.orbit_item_name),
                                                             logFieldDifference('Orbit Item Name', left.orbit_item_name, right.orbit_item_name, left.item_source, 'onBothFiles Difference'),
                                                             left.orbit_item_name),
                                 self.orbit_number    := if (trim(left.orbit_number) <> trim(right.orbit_number),
                                                             logFieldDifference('Orbit Number', left.orbit_number, right.orbit_number, left.item_source, 'onBothFiles Difference'),
                                                             left.orbit_number),
                                 self.orbit_source    := if (trim(left.orbit_source) <> trim(right.orbit_source),
                                                             logFieldDifference('Orbit Source', left.orbit_source, right.orbit_source, left.item_source, 'onBothFiles Difference'),
                                                             left.orbit_source),
                                 self                 := left),
                             inner); 

        onNewNotOnOldPartial := choosen(onNewNotOnOld, 100);
        output(onNewNotOnOldPartial, named('onNewNotOnOld'));

        onOldNotOnNewPartial := choosen(onOldNotOnNew, 100);
        output(onOldNotOnNewPartial, named('onOldNotOnNew'));

        onBothFilesPartial := choosen(onBothFiles, 1000);
        output(onBothFilesPartial, named('onBothFiles'));

        recordForAnalysis := sort(newBaseFile(source_code in SecondarySourceCodeSet), source_code);
        output(recordForAnalysis, named('recordForAnalysis'));

        SampleFileLiens := TOPN(onNewNotOnOld(input_file_id = 'LIENS'),        100, -date_added);
        output(SampleFileLiens, named('SampleFileLiensForQA'));

        SampleFileBank  := TOPN(onNewNotOnOld(input_file_id = 'BANKRUPTCY'),   100, -date_added);
        output(SampleFileBank, named('SampleFileBankForQA'));

        SampleFileRisk  := TOPN(onNewNotOnOld(input_file_id = 'PERSONHEADER'), 100, -date_added);
        output(SampleFileRisk, named('SampleFileRiskForQA'));
/*
        // SampleRecs := SampleFileLiens + SampleFileBank + SampleFileRisk;
        
           SampleRecs    := joinThem;
        
        // OUTPUT(SampleFileLiens, NAMED('SampleLiensRecordsForQA'));
        // OUTPUT(SampleFileBank,    NAMED('SampleBankruptcyRecordsForQA'));
        // OUTPUT(SampleFileRisk,    NAMED('SampleOrbitRiskviewRecordsForQA'));
*/
       
        return 'processFileComparison complete';
    end;

    // Entry function to determine if there are files available to actually do the
    // file comparison. 
    // ---------------------------------- !!!Caution!!! ------------------------------------
    // ECL has a known "quirk" - in evaluating a scalar if/then/else, the processing evaluates 
    // BOTH legs of the conditional. Thus, even when the proper path may have no output results, 
    // the alternate path output results are shown - although empty.
    export vendorSourceFileComparison := function
        // Verify thet the base SuperFile and the father SuperFile have one and only one wrapped
        // file to do the comparison.
        returnValue := iff(nothor(fileservices.GetSuperFileSubCount(BaseSuperFileName))   = 1    and
                           nothor(fileservices.GetSuperFileSubCount(FatherSuperFileName)) = 1,
                           sequential(
                               processFileComparison(),
                               output('Procssing the File Comparison Complete')),
                           output('There are not enough files available for comparison'));
        return returnValue;
      
    end;

end;