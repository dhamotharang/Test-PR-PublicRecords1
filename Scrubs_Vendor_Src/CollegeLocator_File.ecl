IMPORT Vendor_Src;

EXPORT CollegeLocator_File := DATASET('~thor_data400::in::vendor_src::collegelocator', Vendor_Src.Layouts.MasterList, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));