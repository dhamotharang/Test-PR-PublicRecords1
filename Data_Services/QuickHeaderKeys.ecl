export QuickHeaderKeys := macro
output(choosen(Autokey.Key_Address(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_CityStName(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_Name(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_Phone(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_SSN(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_StName(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_Zip(header_quick.str_AutokeyName),10));
output(choosen(header_quick.key_DID,10));
output(choosen(header_quick.key_AutokeyPayload,10));
output(choosen(AutoKey.Key_ZipPRLName('~thor_data400::key::' + header_quick.str_SegmentName + '_autokey'),10));
output(choosen(header_quick.key_ssn_suppression,10));
output(choosen(header_quick.key_ssn_validity,10));
output(choosen(header.key_nlr_payload,10));
endmacro;