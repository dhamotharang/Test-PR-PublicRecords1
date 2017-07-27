export Liensv2keys := macro

output(choosen(liensv2.key_liens_main_ID,10));
output(choosen(liensv2.key_liens_party_ID,10));
output(choosen(liensv2.key_liens_case_number,10));
output(choosen(liensv2.key_liens_DID,10));
output(choosen(liensv2.key_liens_BDID,10));
output(choosen(liensv2.key_liens_ssn,10));
output(choosen(liensv2.key_liens_taxID,10));
//output(choosen(liensv2.key_liens_orig_filing,10));
output(choosen(liensv2.key_liens_filing,10));
output(choosen(liensv2.key_liens_RMSID,10));
output(choosen(liensv2.key_liens_irs_serial_number,10));

// AutoKeys

output(choosen(Autokey.Key_Address(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_CityStName(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_Name(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_Phone2(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_SSN2(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_StName(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_Zip(LiensV2.str_AutokeyName),10));
output(choosen(AutokeyB2.Key_Address(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB2.Key_CityStName(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB2.Key_FEIN(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB2.key_name(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB2.Key_NameWords(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB2.key_phone(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB2.Key_StName(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB2.Key_Zip(LiensV2.str_AutokeyName),10));
output(choosen(LiensV2.key_liens_AutokeyPayload, 10));
output(choosen(doxie_files.Key_BocaShell_LiensV2,10));
output(choosen(doxie_files.Key_BocaShell_LiensV3,10));
output(choosen(liensv2.key_liens_certificate_number,10));
output(choosen(doxie_files.Key_Bocashell_Liens_and_Evictions,10));
output(choosen(doxie_files.Key_Bocashell_Liens_and_Evictions_v2,10));



// FCRA Keys

/*output(choosen(doxie_files.Key_BocaShell_LiensV2,10));
output(choosen(doxie_files.Key_BocaShell_LiensV2_FCRA,10));
output(choosen(liensv2.key_liens_DID_FCRA,10));
output(choosen(liensv2.key_liens_main_ID_FCRA,10));
output(choosen(liensv2.key_liens_party_id_FCRA,10));
output(choosen(liensv2.key_liens_RMSID_FCRA,10));*/

endmacro;