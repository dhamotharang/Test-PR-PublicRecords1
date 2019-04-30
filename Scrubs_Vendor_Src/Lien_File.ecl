IMPORT Vendor_Src;

EXPORT Lien_File := DATASET('~thor_data400::in::vendor_src::lien', Vendor_Src.Layouts.Lien_Court,CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));