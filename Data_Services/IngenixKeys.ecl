/*--SOAP--
<message name="IngenixKeys">
</message>
*/


export IngenixKeys := macro

output(choosen(AutoKey.Key_Address('~thor_data400::key::ingenix_providers_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::ingenix_providers_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::ingenix_providers_'),10));
//output(choosen(AutoKey.Key_Phone('~thor_data400::key::ingenix_providers_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::ingenix_providers_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::ingenix_providers_'),10));
output(choosen(AutoKey.Key_Address('~thor_data400::key::ingenix_sanctions_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::ingenix_sanctions_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::ingenix_sanctions_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::ingenix_sanctions_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::ingenix_sanctions_'),10));
output(choosen(doxie_files.key_provider_did,10));
output(choosen(doxie_files.key_provider_id,10));
output(choosen(doxie_files.key_provider_license,10));
output(choosen(ingenix_natlprof.key_license_providerid,10));
output(choosen(ingenix_natlprof.key_language_providerid,10));
output(choosen(ingenix_natlprof.key_UPIN_providerid,10));
output(choosen(ingenix_natlprof.key_DEA_providerid,10));
output(choosen(ingenix_natlprof.key_degree_providerid,10));
output(choosen(ingenix_natlprof.key_speciality_providerid,10));
output(choosen(ingenix_natlprof.key_group_providerid,10));
output(choosen(ingenix_natlprof.key_hospital_providerid,10));
output(choosen(ingenix_natlprof.key_residency_providerid,10));
output(choosen(ingenix_natlprof.key_medschool_providerid,10));
output(choosen(doxie_files.key_provider_taxid,10));
output(choosen(doxie_files.key_sanctions_did,10));
output(choosen(doxie_files.key_sanctions_sancid,10));
output(choosen(doxie_files.key_sanctions_taxid_name,10));
output(choosen(doxie_files.key_upin_sancid,10));
output(choosen(doxie_files.key_license_sancid,10));
output(choosen(doxie_files.key_providers_fdid,10));
output(choosen(doxie_files.key_sanctions_fdid,10));
output(choosen(doxie_files.key_sanctions_taxid,10));
output(choosen(doxie_files.key_provider_search_id,10));
output(choosen(Autokey.Key_Address(Ingenix_NatlProf.Constants.autokey_qa_name_prov),10));
output(choosen(AutoKey.Key_CityStName(Ingenix_NatlProf.Constants.autokey_qa_name_prov),10));
output(choosen(AutoKey.Key_Name(Ingenix_NatlProf.Constants.autokey_qa_name_prov),10));
output(choosen(AutoKey.Key_Phone2(Ingenix_NatlProf.Constants.autokey_qa_name_prov),10));
output(choosen(AutoKey.Key_StName(Ingenix_NatlProf.Constants.autokey_qa_name_prov),10));
output(choosen(AutoKey.Key_Zip(Ingenix_NatlProf.Constants.autokey_qa_name_prov),10));
output(choosen(Autokey.Key_Address(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
output(choosen(AutoKey.Key_CityStName(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
output(choosen(AutoKey.Key_Name(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
output(choosen(AutoKey.Key_StName(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
output(choosen(AutoKey.Key_Zip(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
//output(choosen(AutoKey.Key_SSN2(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
output(choosen(Ingenix_NatlProf.Key_Sanctions_Payload,10));
output(choosen(Ingenix_NatlProf.Key_Provider_Payload,10));
output(choosen(Ingenix_NatlProf.key_NPI_providerid,10));
output(choosen(Ingenix_NatlProf.key_ProviderID_UPIN,10));
output(choosen(Ingenix_NatlProf.Key_sanctions_bdid,10));
output(choosen(Ingenix_NatlProf.key_providerID_NPI,10));
output(choosen(AutokeyB2.Key_Address(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
output(choosen(AutoKeyB2.Key_CityStName(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
output(choosen(AutoKeyB2.Key_Name(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
output(choosen(Autokeyb2.Key_NameWords(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
output(choosen(AutoKeyb2.Key_StName(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));
output(choosen(AutoKeyb2.Key_Zip(Ingenix_NatlProf.Constants.autokey_qa_name_sanc),10));


endmacro;