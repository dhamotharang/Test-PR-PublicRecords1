export DOCKeys := macro
output(choosen(doxie_files.key_offenders,10));
output(choosen(doxie_files.key_offenders_docnum,10));
output(choosen(doxie_files.key_offenders_OffenderKey(),10));
output(choosen(doxie_files.key_offenders_fdid,10));
output(choosen(doxie_files.key_offenses,10));
output(choosen(doxie_files.key_activity(),10));
output(choosen(doxie_files.Key_Court_Offenses(),10));
output(choosen(doxie_files.key_punishment,10));
output(choosen(doxie_files.Key_BocaShell_Crim,10));
output(choosen(AutoKey.Key_Address('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Address('~thor_data400::key::corrections::autokey::qa::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::corrections::autokey::qa::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::corrections::autokey::qa::'),10));
// output(choosen(AutoKey.Key_Phone('~thor_data400::key::corrections::autokey::qa::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::key::corrections::autokey::qa::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::corrections::autokey::qa::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::corrections::autokey::qa::'),10));
output(choosen(doxie_files.Key_Offenders_Risk,10));
output(choosen(doxie_files.Key_BocaShell_Crim2,10));
output(choosen(Criminal_Records.Key_Payload,10));

endmacro;