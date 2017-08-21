export layouts := module
    // Layout of the input csv file
    export layout_pfs_record := record
        string4     effective_year;                         // Year only                               
        string10    Cpt_code;                               // 2008 had 7 digit codes                               
        string15    Pre_Evaluation_Time;                    
        string15    Pre_Positioning_time;                  
        string15    Pre_Service_Scrub_Dress_Wait_time;      // 2009 had 11 digits of data	
        string15    Median_Intra_Service_Time;              // 2009 had 11 digits of data
        string15    Immediate_post_Service_time;            // 2009 had 11 digits of data
        string15    _99204;
        string15    _99211;
        string15    _99212;
        string15    _99213;
        string15    _99214;
        string15    _99215;
        string15    _99231;
        string15    _99232;
        string15    _99233;
        string15    _99238;
        string15    _99239;
        string15    _99291;
        string15    _99292;
        string15    Total_time;                             // Just to match the other times
    end;

    // Layout of the marked record file
    export layout_marked_record := record
        layout_pfs_record;
        string1     exclusion_ind;
        DECIMAL10_5 calculated_minutes;
    end;

    // Layout of the minutes mismatch record to add old an new minutes
    export layout_minutes_mismatch_record := record
        layout_pfs_record;
        string4     old_minutes;
        DECIMAL10_5 new_minutes;
    end;

    // Layout of the input "old" record and for the non minutes mismatch output files
    export layout_final_record := record
        string5     proc_cd_1;
        string4     effective_year;
        string4     minutes;
    end;
end;



