export DiversityCertKeys := macro

output(choosen(Diversity_Certification.Key_DiversityCert_BDID,10));
output(choosen(Diversity_Certification.Key_DiversityCert_DID,10));
output(choosen(Diversity_Certification.Key_UniqueID,10));
output(choosen(Diversity_Certification.key_AutokeyPayload,10));
output(choosen(Autokey.Key_Address('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKeyb2.Key_Address('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKeyb2.Key_CityStName('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKeyb2.Key_Name('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKeyb2.Key_NameWords('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKey.Key_Phone2('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKeyB2.key_phone('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKeyB2.Key_StName('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::diversity_certification::qa::autokey::'),10));
output(choosen(AutoKeyB2.Key_Zip('~thor_data400::key::diversity_certification::qa::autokey::'),10));

endmacro; 