IMPORT Prof_LicenseV2;

EXPORT File_Proflic_Category_Table := DATASET('~thor_data400::lookup::prolicv2::category::table::data',
                                              Prof_LicenseV2.Layout_Proflic_Category_Table,
																							CSV(SEPARATOR([',']), QUOTE('"'), TERMINATOR(['\r\n'])));