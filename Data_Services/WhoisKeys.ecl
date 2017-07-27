export WhoisKeys := macro
output(choosen(domains.Key_Whois_Bdid,10));
output(choosen(domains.Key_Whois_Did,10));
output(choosen(domains.key_whois_domain,10));
output(choosen(domains.key_bdid,10));
output(choosen(domains.key_did,10));
output(choosen(domains.key_id,10));
output(choosen(Domains.key_domain,10));
output(choosen(domains.key_internetservices_AutoKeyPayload,10));

output(choosen(Autokey.Key_Address('~thor_data400::key::internetservices::qa::autokey::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::internetservices::qa::autokey::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::internetservices::qa::autokey::'),10));
output(choosen(AutoKey.Key_SSN2('~thor_data400::key::internetservices::qa::autokey::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::internetservices::qa::autokey::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::internetservices::qa::autokey::'),10));

output(choosen(AutokeyB2.Key_Address('~thor_data400::key::internetservices::qa::autokey::'),10));
output(choosen(AutoKeyB2.Key_CityStName('~thor_data400::key::internetservices::qa::autokey::'),10));
output(choosen(AutoKeyB2.key_name('~thor_data400::key::internetservices::qa::autokey::'),10));
output(choosen(AutoKeyB2.Key_NameWords('~thor_data400::key::internetservices::qa::autokey::'),10));
output(choosen(AutoKeyB2.Key_StName('~thor_data400::key::internetservices::qa::autokey::'),10));
output(choosen(AutoKeyB2.Key_Zip('~thor_data400::key::internetservices::qa::autokey::'),10));
endmacro;