import ut, lib_fileservices, lib_stringlib, pfs;

export Process_Files(string pversion, boolean pUseProd = false) := function

    // Get the old dataset from the contents of the superfile in the repository - currently this is
    // just year 2013 - Section 6.2.10
    pfsOld := dataset('~thor::base::qa::proccd_minutes_reference_data', pfs.layouts.layout_final_record, thor); 

    // Get our composite file as sprayed to the repository
    pfsComposite := Files(pversion, pUseProd).pfsComposite;

    // Run through the file and prepare it for further processing
    pfsComposite_marked := project(pfsComposite, transform(pfs.layouts.layout_marked_record,
        zero_str           := '00000';    
        code_length        := length(trim(left.Cpt_code, left, right));
        // The markings are: 
        //     invalid cpt length                                    => L
        //     minutes calculate to zero but other times have values => E
        //     minutes calculates to zero and other times also zero  => A
        //     valid record                                          => G
        other_times_present := (real)left._99204 <> 0                              or
                               (real)left._99211 <> 0                              or                          
                               (real)left._99212 <> 0                              or
                               (real)left._99213 <> 0                              or
                               (real)left._99214 <> 0                              or
                               (real)left._99215 <> 0                              or
                               (real)left._99231 <> 0                              or
                               (real)left._99232 <> 0                              or
                               (real)left._99233 <> 0                              or
                               (real)left._99238 <> 0                              or
                               (real)left._99239 <> 0                              or
                               (real)left._99291 <> 0                              or
                               (real)left._99292 <> 0;

        minutes_calc       := if((real)left.Pre_Evaluation_Time  = 0 and                    
                                 (real)left.Pre_Positioning_time = 0               and                  
                                 (real)left.Pre_Service_Scrub_Dress_Wait_time = 0  and        
                                 (real)left.Median_Intra_Service_Time = 0          and            
                                 (real)left.Immediate_post_Service_time = 0        and          
                                 (real)left._99204 = 0                             and
                                 (real)left._99211 = 0                             and
                                 (real)left._99212 = 0                             and
                                 (real)left._99213 = 0                             and
                                 (real)left._99214 = 0                             and
                                 (real)left._99215 = 0                             and
                                 (real)left._99231 = 0                             and
                                 (real)left._99232 = 0                             and
                                 (real)left._99233 = 0                             and
                                 (real)left._99238 = 0                             and
                                 (real)left._99239 = 0                             and
                                 (real)left._99291 = 0                             and
                                 (real)left._99292 = 0, 
                                 // Then
                                 (real)left.Total_time,
                                 // Else
                                 (real)left.Pre_Evaluation_Time               +                   
                                 (real)left.Pre_Positioning_time              +                 
                                 (real)left.Pre_Service_Scrub_Dress_Wait_time +   	
                                 (real)left.Median_Intra_Service_Time         +           
                                 (real)left.Immediate_post_Service_time);
        self.calculated_minutes := (DECIMAL10_5)minutes_calc;
        self.exclusion_ind := map(code_length > 5                                  => 'L',
                                 minutes_calc = 0 and other_times_present          => 'E', 
                                 minutes_calc = 0                                  => 'A', 
                                                                                      'G');
        self.Cpt_code      := if(code_length >= 5, 
                                 left.Cpt_code,
                                 zero_str[1..5 - code_length] + left.Cpt_code);
        self               := left));
                    
    // Create exclusion datasets by filtering the marked dataset based on the exclusion indicator
    // Good now includes records marked for bad times but NOT marked for length
    pfsGood           := pfsComposite_marked(exclusion_ind <> 'L'); 
    pfsTimeBadAllZero := pfsComposite_marked(exclusion_ind = 'A');
    pfsTimeBadEMZero  := pfsComposite_marked(exclusion_ind = 'E');
    pfsLengthBad      := pfsComposite_marked(exclusion_ind = 'L');

    // Project the good results to the marked record layout
    pfsFinal := project(pfsGood, transform(pfs.layouts.layout_marked_record,
                        self.Cpt_code           := left.Cpt_code;
                        self.effective_year     := left.effective_year;
                        self.calculated_minutes := left.calculated_minutes;
                        self                    := left));

    // Determine the records that have an extended code (i.e. a suffix) but no base code 
    pfsNoBaseCode := join(pfsGood, pfsLengthBad,
                          left.Cpt_code[1..5] = right.Cpt_code[1..5],
                          transform(right),
                          right only);

    // Determine the new vs. old differences - layout of the result is the left - layout_marked_record
    psfOnNewNotOnOld  := join(pfsGood, pfsOld, 
                              left.Cpt_Code       = right.proc_cd_1           and 
                              left.effective_year = right.effective_year,
                              transform(left), left only);

     // Determine the old vs. new differences - layout of the result is the right - layout_final_record 
    psfOnOldNotOnNew  := join(pfsGood, pfsOld, 
                               left.Cpt_Code        = right.proc_cd_1           and  
                               left.effective_year  = right.effective_year,
                               transform(right), right only);    

    // Determine the minute mismatches - the transform puts it into the desired final layout
    psfMinuteMismatches := join(pfsGood, pfsOld, 
                                left.Cpt_Code            = right.proc_cd_1               and 
                                left.effective_year      = right.effective_year          and
                                left.calculated_minutes <> (DECIMAL10_5)right.minutes,
                                transform(pfs.layouts.layout_minutes_mismatch_record, 
                                    self.old_minutes := right.minutes;    
                                    self.new_minutes := left.calculated_minutes;    
                                    self             := left));

    output_all := sequential(
        // Output the sequence of counts for the various files
        output(count(pfsOld), named('PROC_CD_cnt_old')),
        output(count(pfsComposite), named('PROC_CD_cnt_new')),
        output(count(pfsLengthBad), named('PROC_CD_cnt_codes_excluded_length_gt5')),
        output(count(pfsNoBaseCode), named('PROC_CD_cnt_codes_excluded_nobase')),
        output(count(pfsTimeBadAllZero), named('PROC_CD_cnt_codes_time_all_zero')),
        output(count(pfsTimeBadEMZero), named('PROC_CD_cnt_codes_time_em_zero')),
        output(count(psfOnNewNotOnOld), named('PROC_CD_cnt_codes_added_on_New_Not_On_Old')),
        output(count(psfOnOldNotOnNew), named('PROC_CD_cnt_codes_deleted_on_Old_Not_On_New')),
        output(count(psfMinuteMismatches), named('PROC_CD_cnt_codes_changed_minutes_mismatches')),

        // Write the files to Thor - this just shows "Result" to the IDE
        output(sort(pfsLengthBad, cpt_code, -effective_year),, '~thor::referencecompare::pfs_codes_excluded_length_d' + pversion, compressed, overwrite);
        output(sort(pfsNoBaseCode, cpt_code, -effective_year),, '~thor::referencecompare::pfs_codes_excluded_length_nobase_d' + pversion, compressed, overwrite);
        output(sort(pfsTimeBadAllZero, cpt_code, -effective_year),, '~thor::referencecompare::pfs_codes_time_all_zero_d' + pversion, compressed, overwrite);
        output(sort(pfsTimeBadEMZero, cpt_code, -effective_year),, '~thor::referencecompare::pfs_codes_time_em_zero_d' + pversion, compressed, overwrite);
        output(sort(psfOnNewNotOnOld, cpt_code, -effective_year),, '~thor::referencecompare::pfs_codes_added_on_new_not_on_old_d' + pversion, compressed, overwrite);
        output(sort(psfOnOldNotOnNew, proc_cd_1, -effective_year),, '~thor::referencecompare::pfs_codes_deleted_on_old_not_on_new_d' + pversion, compressed, overwrite);
        output(sort(psfMinuteMismatches, cpt_code, -effective_year),, '~thor::referencecompare::pfs_codes_changed_minutes_mismatches_d' + pversion, compressed, overwrite);
        output(sort(pfsFinal, cpt_code, effective_year),, '~thor::base::hcfwa::proccd_minutes_reference_data', compressed, overwrite);

        // Output to the composite log record file to accumulate counts
        pfs.Compute_Statistics.reportLogMsg('PROC_CD_cnt_old', count(pfsOld), 'LogResult'),
        pfs.Compute_Statistics.reportLogMsg('PROC_CD_cnt_new', count(pfsComposite), 'LogResult'),
        pfs.Compute_Statistics.reportLogMsg('PROC_CD_cnt_codes_excluded_length_gt5', count(pfsLengthBad), 'LogResult'),
        pfs.Compute_Statistics.reportLogMsg('PROC_CD_cnt_codes_excluded_nobase', count(pfsNoBaseCode), 'LogResult'),
        pfs.Compute_Statistics.reportLogMsg('PROC_CD_cnt_codes_time_all_zero', count(pfsTimeBadAllZero), 'LogResult'),
        pfs.Compute_Statistics.reportLogMsg('PROC_CD_cnt_codes_time_em_zero', count(pfsTimeBadEMZero), 'LogResult'),
        pfs.Compute_Statistics.reportLogMsg('PROC_CD_cnt_codes_added_on_New_Not_On_Old', count(psfOnNewNotOnOld), 'LogResult'),
        pfs.Compute_Statistics.reportLogMsg('PROC_CD_cnt_codes_deleted_on_Old_Not_On_New', count(psfOnOldNotOnNew), 'LogResult'),
        pfs.Compute_Statistics.reportLogMsg('PROC_CD_cnt_codes_changed_minutes_mismatches', count(psfMinuteMismatches), 'LogResult'),

        // Output the debug datasets to the IDE
        output(pfsComposite, named('pfs_codes')),
        output(pfsOld, named('pfsOldYearDataFromThor')));

    return output_all;
end;