IMPORT SALT_Examples;
Layout_Ext_Bankruptcy := RECORD
string12 court_case_number;
SALT_Examples.Layout_Sample;
end;
EXPORT File_Ext_Bankruptcy := dataset('~salt_demo::sample_ext_bankruptcy',Layout_Ext_Bankruptcy,THOR);
