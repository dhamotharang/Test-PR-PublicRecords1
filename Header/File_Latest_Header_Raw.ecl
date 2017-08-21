EXPORT File_Latest_Header_Raw(boolean isIncremental=false) :=

    if (isIncremental
    
        ,dataset('~thor_data400::base::header_raw_incremental',Layout_Header,flat)
        ,dataset(trim(File_Header_Raw_Flag[1].lfn),Layout_Header,flat)
                
       );