IMPORT _VendorSrc2;

export File_MasterList := dataset('~thor_data400::in::vendorsrc::masterlist20190220', _VendorSrc2.layouts.MasterList, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));





