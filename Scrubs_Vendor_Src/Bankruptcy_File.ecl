IMPORT Vendor_Src;

EXPORT Bankruptcy_File := dataset('~thor_data400::in::vendor_src::bankruptcy', Vendor_Src.layouts.Bank_Court, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));





