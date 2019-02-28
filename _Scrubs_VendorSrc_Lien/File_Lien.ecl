IMPORT _VendorSrc2;

export File_Lien := dataset('~thor_data400::in::vendorsrc::lien20190220', _Scrubs_VendorSrc_Lien.layout_lien, CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));





