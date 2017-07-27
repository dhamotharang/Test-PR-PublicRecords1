/*--SOAP--
<message name="ProfLic">
</message>
*/

export ProfLicKeys := MACRO

output(choosen(doxie_files.key_proflic_did,10));
output(choosen(doxie_files.key_proflic_licensenum,10));
output(choosen(doxie_files.key_proflic_bdid,10));
//output(choosen(doxie_cbrs.key_addr_proflic,10));
output(choosen(Autokey.Key_Address(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKey.Key_CityStName(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKey.Key_Name(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKey.Key_SSN2(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKey.Key_StName(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKey.Key_Zip(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutokeyB2.Key_Address(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKeyB2.Key_CityStName(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKeyB2.key_name(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKeyB2.Key_NameWords(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKeyB2.key_phone(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKeyB2.Key_StName(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(AutoKeyB2.Key_Zip(Prof_LicenseV2.Constants.autokey_qa_name),10));
output(choosen(Prof_LicenseV2.Key_ProfLic_Payload, 10));
output(choosen(Prof_LicenseV2.Key_ProfLic_Id,10));
output(choosen(Prof_LicenseV2.Key_Proflic_Licensenum,10));
output(choosen(Prof_LicenseV2.Key_Proflic_Bdid,10));
output(choosen(Prof_LicenseV2.Key_Proflic_Did(),10));
output(choosen(Prof_LicenseV2.Key_Addr_Proflic,10));

ENDMACRO;