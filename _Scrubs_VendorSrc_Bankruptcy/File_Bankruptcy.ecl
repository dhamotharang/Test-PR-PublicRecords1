IMPORT _VendorSrc2;

export File_Bankruptcy := dataset('~	thor_data400::in::vendorsrc::bankruptcy20190220', _VendorSrc2.layouts.Bank_Court, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));





