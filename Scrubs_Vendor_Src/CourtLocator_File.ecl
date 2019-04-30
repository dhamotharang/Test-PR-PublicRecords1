IMPORT Vendor_Src;

EXPORT CourtLocator_File := DATASET('~thor_data400::in::vendor_src::courtlocator', Vendor_Src.Layouts.Court_Locator, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['\"']),HEADING(1)));