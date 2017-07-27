import BIPV2_Files;

EXPORT Files := 
MODULE


export business_header := 
BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL;

export business_header_building := 
BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING;

export layout_business_header := recordof(business_header);

END;