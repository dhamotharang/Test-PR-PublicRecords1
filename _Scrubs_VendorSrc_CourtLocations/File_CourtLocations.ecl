IMPORT _VendorSrc2;

export File_CourtLocations := dataset('~thor_data400::in::vendorsrc::courtlocations::father', _VendorSrc2.layouts.Court_Locations, CSV(SEPARATOR(['|']), TERMINATOR(['\n','\r\n']), QUOTE(['\"']),HEADING(1)));





