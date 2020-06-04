IMPORT dx_header;
EXPORT File_Latest_Header_Raw(boolean isIncremental=false) :=

    if (isIncremental
    
        ,dataset('~thor_data400::base::header_raw_incremental',dx_header.Layout_Header,flat)
        ,dataset(trim(File_Header_Raw_Flag[1].lfn),dx_header.Layout_Header,flat)
                
       );