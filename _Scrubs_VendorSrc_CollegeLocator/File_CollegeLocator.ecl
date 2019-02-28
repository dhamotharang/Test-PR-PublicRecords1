IMPORT _VendorSrc2;

export File_CollegeLocator := dataset('~thor_data400::in::vendorsrc::collegelocator20190220', _VendorSrc2.layouts.MasterList, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));





