IMPORT Vendor_Src;

EXPORT MasterList_File := DATASET('~thor_data400::in::vendor_src::masterlist', Vendor_Src.Layouts.MasterList, CSV(SEPARATOR([',']), TERMINATOR(['\n','\r\n']), QUOTE(['"']),HEADING(1)));