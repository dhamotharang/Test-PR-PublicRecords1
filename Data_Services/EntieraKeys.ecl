export EntieraKeys := macro
output(choosen(Entiera.key_entiera_did,10));
output(choosen(Entiera.key_entiera_email_addresses,10));
output(choosen(Entiera.key_entiera_household_id,10));
output(choosen(Entiera.key_entiera_individual_id,10));
output(choosen(Entiera.key_Payload,10));
output(choosen(Autokey.Key_Address(entiera.entiera_constants('').ak_qa_keyname),10));
output(choosen(AutoKey.Key_CityStName(entiera.entiera_constants('').ak_qa_keyname),10));
output(choosen(AutoKey.Key_Name(entiera.entiera_constants('').ak_qa_keyname),10));
//output(choosen(AutoKey.Key_Phone2(entiera.entiera_constants('').ak_qa_keyname),10));
output(choosen(AutoKey.Key_SSN2(entiera.entiera_constants('').ak_qa_keyname),10));
output(choosen(AutoKey.Key_StName(entiera.entiera_constants('').ak_qa_keyname),10));
output(choosen(AutoKey.Key_Zip(entiera.entiera_constants('').ak_qa_keyname),10));
endmacro;