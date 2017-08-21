//Ingenix Stats by John J. Bulten 20070524-20070808
// W20070716-171409, W20070717-125532-125559-130131-144714-163502, W20070718-115437, W20070720-095642-152535
// W20070808-155507

IMPORT Ingenix_NatlProf;

/*output(table(Ingenix_NatlProf.Basefile_Group_BDID,{dt_first_seen,count(group)},dt_first_seen));
output(table(Ingenix_NatlProf.Basefile_Group_BDID,{dt_last_seen,count(group)},dt_last_seen));
output(table(Ingenix_NatlProf.Basefile_Group_BDID,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(Ingenix_NatlProf.Basefile_Group_BDID,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
*/output(table(Ingenix_NatlProf.Basefile_Group_BDID,{ProcessDate,count(group)},ProcessDate));
/*
output(table(Ingenix_NatlProf.Basefile_Hospital_BDID,{dt_first_seen,count(group)},dt_first_seen));
output(table(Ingenix_NatlProf.Basefile_Hospital_BDID,{dt_last_seen,count(group)},dt_last_seen));
output(table(Ingenix_NatlProf.Basefile_Hospital_BDID,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(Ingenix_NatlProf.Basefile_Hospital_BDID,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
output(table(Ingenix_NatlProf.Basefile_Hospital_BDID,{ProcessDate,count(group)},ProcessDate));

output(table(Ingenix_NatlProf.Basefile_Medschool_BDID,{dt_first_seen,count(group)},dt_first_seen));
output(table(Ingenix_NatlProf.Basefile_Medschool_BDID,{dt_last_seen,count(group)},dt_last_seen));
output(table(Ingenix_NatlProf.Basefile_Medschool_BDID,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(Ingenix_NatlProf.Basefile_Medschool_BDID,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
output(table(Ingenix_NatlProf.Basefile_Medschool_BDID,{ProcessDate,count(group)},ProcessDate));
*/output(table(Ingenix_NatlProf.Basefile_Medschool_BDID,{GraduationYear,count(group)},GraduationYear));
/*
output(table(distribute(Ingenix_NatlProf.Basefile_Provider_Did,hash64(dt_first_seen)),{dt_first_seen,count(group)},dt_first_seen));
output(table(distribute(Ingenix_NatlProf.Basefile_Provider_Did,hash64(dt_last_seen)),{dt_last_seen,count(group)},dt_last_seen));
output(table(distribute(Ingenix_NatlProf.Basefile_Provider_Did,hash64(dt_vendor_first_reported)),{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(distribute(Ingenix_NatlProf.Basefile_Provider_Did,hash64(dt_vendor_last_reported)),{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
output(table(distribute(Ingenix_NatlProf.Basefile_Provider_Did,hash64(ProcessDate)),{ProcessDate,count(group)},ProcessDate));
*/output(table(distribute(Ingenix_NatlProf.Basefile_Provider_Did,hash64(BirthDate)),{BirthDate,count(group)},BirthDate));
/*
output(table(Ingenix_NatlProf.Basefile_ProviderAddressDEANumber,{dt_first_seen,count(group)},dt_first_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderAddressDEANumber,{dt_last_seen,count(group)},dt_last_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderAddressDEANumber,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderAddressDEANumber,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderAddressDEANumber,{ProcessDate,count(group)},ProcessDate));

output(table(Ingenix_NatlProf.Basefile_ProviderDegree,{dt_first_seen,count(group)},dt_first_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderDegree,{dt_last_seen,count(group)},dt_last_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderDegree,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderDegree,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderDegree,{ProcessDate,count(group)},ProcessDate));

output(table(Ingenix_NatlProf.Basefile_ProviderLanguage,{dt_first_seen,count(group)},dt_first_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderLanguage,{dt_last_seen,count(group)},dt_last_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderLanguage,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderLanguage,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderLanguage,{ProcessDate,count(group)},ProcessDate));

output(table(Ingenix_NatlProf.Basefile_ProviderLicense,{dt_first_seen,count(group)},dt_first_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderLicense,{dt_last_seen,count(group)},dt_last_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderLicense,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderLicense,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderLicense,{ProcessDate,count(group)},ProcessDate));
*/output(table(Ingenix_NatlProf.Basefile_ProviderLicense,{effective_date,count(group)},effective_date));
output(table(Ingenix_NatlProf.Basefile_ProviderLicense,{termination_date,count(group)},termination_date));
/*
output(table(Ingenix_NatlProf.Basefile_ProviderSpeciality,{dt_first_seen,count(group)},dt_first_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderSpeciality,{dt_last_seen,count(group)},dt_last_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderSpeciality,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderSpeciality,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderSpeciality,{ProcessDate,count(group)},ProcessDate));

output(table(Ingenix_NatlProf.Basefile_ProviderUPIN,{dt_first_seen,count(group)},dt_first_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderUPIN,{dt_last_seen,count(group)},dt_last_seen));
output(table(Ingenix_NatlProf.Basefile_ProviderUPIN,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderUPIN,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
output(table(Ingenix_NatlProf.Basefile_ProviderUPIN,{ProcessDate,count(group)},ProcessDate));

output(table(Ingenix_NatlProf.Basefile_Residency_BDID,{dt_first_seen,count(group)},dt_first_seen));
output(table(Ingenix_NatlProf.Basefile_Residency_BDID,{dt_last_seen,count(group)},dt_last_seen));
output(table(Ingenix_NatlProf.Basefile_Residency_BDID,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported));
output(table(Ingenix_NatlProf.Basefile_Residency_BDID,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported));
output(table(Ingenix_NatlProf.Basefile_Residency_BDID,{ProcessDate,count(group)},ProcessDate));

*/output(table(Ingenix_NatlProf.Basefile_Sanctions,{date_first_seen,count(group)},date_first_seen));
output(table(Ingenix_NatlProf.Basefile_Sanctions,{date_last_seen,count(group)},date_last_seen));
output(table(Ingenix_NatlProf.Basefile_Sanctions,{date_first_reported,count(group)},date_first_reported));
/*output(table(Ingenix_NatlProf.Basefile_Sanctions,{date_last_reported,count(group)},date_last_reported));
output(table(Ingenix_NatlProf.Basefile_Sanctions,{process_date,count(group)},process_date));
*/output(table(Ingenix_NatlProf.Basefile_Sanctions,{sanc_dob,count(group)},sanc_dob));
output(table(Ingenix_NatlProf.Basefile_Sanctions,{sanc_sancdte_form,count(group)},sanc_sancdte_form));
/*output(table(Ingenix_NatlProf.Basefile_Sanctions,{sanc_sancdte,count(group)},sanc_sancdte));
output(table(Ingenix_NatlProf.Basefile_Sanctions,{sanc_updte_form,count(group)},sanc_updte_form));
*/output(table(Ingenix_NatlProf.Basefile_Sanctions,{sanc_updte,count(group)},sanc_updte));
output(table(Ingenix_NatlProf.Basefile_Sanctions,{sanc_reindte_form,count(group)},sanc_reindte_form));
/*output(table(Ingenix_NatlProf.Basefile_Sanctions,{sanc_reindte,count(group)},sanc_reindte));
*/
output(table(Ingenix_NatlProf.Basefile_Group_BDID,{
 sum(group,(integer)(BDID<>'')),
 sum(group,(integer)(BDID_SCORE<>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(ProcessDate<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(GroupName<>'')),
 sum(group,(integer)(GroupNameCompanyCount<>'')),
 sum(group,(integer)(GroupNameTierTypeID<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_Hospital_BDID,{
 sum(group,(integer)(BDID<>'')),
 sum(group,(integer)(BDID_SCORE<>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(ProcessDate<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(HospitalName<>'')),
 sum(group,(integer)(HospitalNameCompanyCount<>'')),
 sum(group,(integer)(HospitalNameTierTypeID<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_Medschool_BDID,{
 sum(group,(integer)(BDID<>'')),
 sum(group,(integer)(BDID_SCORE<>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(ProcessDate<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(MedSchoolName<>'')),
 sum(group,(integer)(GraduationYear<>'')),
 sum(group,(integer)(MedSchoolCompanyCount<>'')),
 sum(group,(integer)(MedSchoolTierTypeID<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_Provider_Did,{
 sum(group,(integer)(DID<>'')),
 sum(group,(integer)(DID_SCORE<>'')),
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(PROCESSDATE<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(AddressID<>'')),
 sum(group,(integer)(LastName<>'')),
 sum(group,(integer)(FirstName<>'')),
 sum(group,(integer)(MiddleName<>'')),
 sum(group,(integer)(Suffix<>'')),
 sum(group,(integer)(Gender<>'')),
 sum(group,(integer)(ProviderNameCompanyCount<>'')),
 sum(group,(integer)(ProviderNameTierID<>'')),
 sum(group,(integer)(Address<>'')),
 sum(group,(integer)(Address2<>'')),
 sum(group,(integer)(City<>'')),
 sum(group,(integer)(State<>'')),
 sum(group,(integer)(County<>'')),
 sum(group,(integer)(ZIP<>'')),
 sum(group,(integer)(ExtZip<>'')),
 sum(group,(integer)(Latitude<>'')),
 sum(group,(integer)(Longitute<>'')),
 sum(group,(integer)(GeoReturn<>'')),
 sum(group,(integer)(HighRisk<>'')),
 sum(group,(integer)(ProviderAddressCompanyCount<>'')),
 sum(group,(integer)(ProviderAddressTierTypeID<>'')),
 sum(group,(integer)(ProviderAddressTypeCode<>'')),
 sum(group,(integer)(ProviderAddressVerificationStatusCode<>'')),
 sum(group,(integer)(ProviderAddressVerificationDate<>'')),
 sum(group,(integer)(BirthDate<>'')),
 sum(group,(integer)(BirthDateCompanyCount<>'')),
 sum(group,(integer)(BirthDateTierTypeID<>'')),
 sum(group,(integer)(TaxID<>'')),
 sum(group,(integer)(TaxIDCompanyCount<>'')),
 sum(group,(integer)(TaxIDTierTypeID<>'')),
 sum(group,(integer)(PhoneNumber<>'')),
 sum(group,(integer)(PhoneType<>'')),
 sum(group,(integer)(PhoneNumberCompanyCount<>'')),
 sum(group,(integer)(PhoneNumberTierTypeID<>'')),
 sum(group,(integer)(Prov_Clean_title <>'')),
 sum(group,(integer)(Prov_Clean_fname <>'')),
 sum(group,(integer)(Prov_Clean_mname <>'')),
 sum(group,(integer)(Prov_Clean_lname <>'')),
 sum(group,(integer)(Prov_Clean_name_suffix <>'')),
 sum(group,(integer)(Prov_Clean_cleaning_score <>'')),
 sum(group,(integer)(prov_Clean_prim_range <>'')),
 sum(group,(integer)(prov_Clean_predir <>'')),
 sum(group,(integer)(prov_Clean_prim_name <>'')),
 sum(group,(integer)(prov_Clean_addr_suffix <>'')),
 sum(group,(integer)(prov_Clean_postdir <>'')),
 sum(group,(integer)(prov_Clean_unit_desig <>'')),
 sum(group,(integer)(prov_Clean_sec_range <>'')),
 sum(group,(integer)(prov_Clean_p_city_name <>'')),
 sum(group,(integer)(prov_Clean_v_city_name <>'')),
 sum(group,(integer)(prov_Clean_st <>'')),
 sum(group,(integer)(prov_Clean_zip <>'')),
 sum(group,(integer)(prov_Clean_zip4 <>'')),
 sum(group,(integer)(prov_Clean_cart <>'')),
 sum(group,(integer)(prov_Clean_cr_sort_sz <>'')),
 sum(group,(integer)(prov_Clean_lot <>'')),
 sum(group,(integer)(prov_Clean_lot_order <>'')),
 sum(group,(integer)(prov_Clean_dpbc <>'')),
 sum(group,(integer)(prov_Clean_chk_digit <>'')),
 sum(group,(integer)(prov_Clean_record_type <>'')),
 sum(group,(integer)(prov_Clean_ace_fips_st <>'')),
 sum(group,(integer)(prov_Clean_fipscounty <>'')),
 sum(group,(integer)(prov_Clean_geo_lat <>'')),
 sum(group,(integer)(prov_Clean_geo_long <>'')),
 sum(group,(integer)(prov_Clean_msa <>'')),
 sum(group,(integer)(prov_Clean_geo_match <>'')),
 sum(group,(integer)(prov_Clean_err_stat <>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_ProviderAddressDEANumber,{
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(ProcessDate<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(AddressID<>'')),
 sum(group,(integer)(DEANumber<>'')),
 sum(group,(integer)(DEANumberCompanyCount<>'')),
 sum(group,(integer)(DEANumberTierTypeID<>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_ProviderDegree,{
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(ProcessDate<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(Degree<>'')),
 sum(group,(integer)(DegreeCompanyCount<>'')),
 sum(group,(integer)(DegreeTierTypeID<>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_ProviderLanguage,{
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(ProcessDate<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(Language<>'')),
 sum(group,(integer)(LanguageCompanyCount<>'')),
 sum(group,(integer)(LanguageTierTypeID<>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_ProviderLicense,{
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(ProcessDate<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(LicenseNumber<>'')),
 sum(group,(integer)(licenseState<>'')),
 sum(group,(integer)(Effective_Date<>'')),
 sum(group,(integer)(Termination_Date<>'')),
 sum(group,(integer)(LicenseNumberCompanyCount<>'')),
 sum(group,(integer)(LicenseNumberTierTypeID<>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_ProviderSpeciality,{
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(ProcessDate<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(SpecialityID<>'')),
 sum(group,(integer)(SpecialtyCompanyCount<>'')),
 sum(group,(integer)(SpecialtyTierTypeID<>'')),
 sum(group,(integer)(SpecialityName<>'')),
 sum(group,(integer)(SpecialityGroupID<>'')),
 sum(group,(integer)(SpecialityGroupName<>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_ProviderUPIN,{
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(ProcessDate<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(UPIN<>'')),
 sum(group,(integer)(UPINCompanyCount<>'')),
 sum(group,(integer)(UPINTierTypeID<>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_Residency_BDID,{
 sum(group,(integer)(BDID<>'')),
 sum(group,(integer)(BDID_SCORE<>'')),
 sum(group,(integer)(dt_first_seen<>'')),
 sum(group,(integer)(dt_last_seen<>'')),
 sum(group,(integer)(dt_vendor_first_reported<>'')),
 sum(group,(integer)(dt_vendor_last_reported<>'')),
 sum(group,(integer)(FILETYP<>'')),
 sum(group,(integer)(PROCESSDATE<>'')),
 sum(group,(integer)(ProviderID<>'')),
 sum(group,(integer)(Residency<>'')),
 sum(group,(integer)(ResidencyCompanyCount<>'')),
 sum(group,(integer)(ResidencyTierTypeID<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_Sanctions,{
 sum(group,(integer)(process_date<>'')),
 sum(group,(integer)(date_first_seen<>'')),
 sum(group,(integer)(date_last_seen<>'')),
 sum(group,(integer)(date_first_reported<>'')),
 sum(group,(integer)(date_last_reported<>'')),
 sum(group,(integer)(did <>'')),
 sum(group,(integer)(filetyp<>'')),
 sum(group,(integer)(SANC_ID<>'')),
 sum(group,(integer)(SANC_LNME<>'')),
 sum(group,(integer)(SANC_FNME<>'')),
 sum(group,(integer)(SANC_MID_I_NM <>'')),
 sum(group,(integer)(SANC_BUSNME <>'')),
 sum(group,(integer)(SANC_DOB <>'')),
 sum(group,(integer)(SANC_STREET <>'')), 
 sum(group,(integer)(SANC_CITY <>'')),
 sum(group,(integer)(SANC_ZIP <>'')),
 sum(group,(integer)(SANC_STATE <>'')),
 sum(group,(integer)(SANC_CNTRY <>'')),
 sum(group,(integer)(SANC_TIN <>'')),
 sum(group,(integer)(SANC_UPIN <>'')),
 sum(group,(integer)(SANC_PROVTYPE <>'')),
 sum(group,(integer)(SANC_SANCDTE_form<>'')),
 sum(group,(integer)(SANC_SANCDTE <>'')),
 sum(group,(integer)(SANC_SANCST <>'')),
 sum(group,(integer)(SANC_LICNBR <>'')),
 sum(group,(integer)(SANC_BRDTYPE <>'')),
 sum(group,(integer)(SANC_SRC_DESC <>'')),
 sum(group,(integer)(SANC_TYPE <>'')),
 sum(group,(integer)(SANC_REAS <>'')),
 sum(group,(integer)(SANC_TERMS <>'')),
 sum(group,(integer)(SANC_COND <>'')),
 sum(group,(integer)(SANC_FINES <>'')),
 sum(group,(integer)(SANC_FAB <>'')),
 sum(group,(integer)(SANC_UPDTE_form<>'')),
 sum(group,(integer)(SANC_UPDTE <>'')),
 sum(group,(integer)(SANC_REINDTE_form<>'')),
 sum(group,(integer)(SANC_REINDTE <>'')),
 sum(group,(integer)(SANC_UNAMB_IND <>'')),
 sum(group,(integer)(Prov_Clean_title<>'')),
 sum(group,(integer)(Prov_Clean_fname<>'')),
 sum(group,(integer)(Prov_Clean_mname<>'')),
 sum(group,(integer)(Prov_Clean_lname<>'')),
 sum(group,(integer)(Prov_Clean_name_suffix<>'')),
 sum(group,(integer)(Prov_Clean_cleaning_score<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_prim_range<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_predir<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_prim_name<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_addr_suffix<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_postdir<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_unit_desig<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_sec_range<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_p_city_name<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_v_city_name<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_st<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_zip<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_zip4<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_cart<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_cr_sort_sz<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_lot<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_lot_order<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_dpbc<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_chk_digit<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_record_type<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_ace_fips_st<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_fipscounty<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_geo_lat<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_geo_long<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_msa<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_geo_match<>'')),
 sum(group,(integer)(ProvCo_Address_Clean_err_stat<>'')),
count(group)}));

output(table(Ingenix_NatlProf.Basefile_Group_BDID,{FILETYP,count(group)},FILETYP));
output(table(Ingenix_NatlProf.Basefile_Hospital_BDID,{FILETYP,count(group)},FILETYP));
output(table(Ingenix_NatlProf.Basefile_Medschool_BDID,{FILETYP,count(group)},FILETYP));
output(table(distribute(Ingenix_NatlProf.Basefile_Provider_Did,hash64(FILETYP)),{FILETYP,count(group)},FILETYP));
output(table(distribute(Ingenix_NatlProf.Basefile_Provider_Did,hash64(prov_Clean_record_type)),{prov_Clean_record_type,count(group)},prov_Clean_record_type));
output(table(Ingenix_NatlProf.Basefile_ProviderAddressDEANumber,{FILETYP,count(group)},FILETYP));
output(table(Ingenix_NatlProf.Basefile_ProviderDegree,{FILETYP,count(group)},FILETYP));
output(table(Ingenix_NatlProf.Basefile_ProviderLanguage,{FILETYP,count(group)},FILETYP));
output(table(Ingenix_NatlProf.Basefile_ProviderLicense,{FILETYP,count(group)},FILETYP));
output(table(Ingenix_NatlProf.Basefile_ProviderSpeciality,{FILETYP,count(group)},FILETYP));
output(table(Ingenix_NatlProf.Basefile_ProviderUPIN,{FILETYP,count(group)},FILETYP));
output(table(Ingenix_NatlProf.Basefile_Residency_BDID,{FILETYP,count(group)},FILETYP));
output(table(Ingenix_NatlProf.Basefile_Sanctions,{filetyp,count(group)},filetyp));
output(table(Ingenix_NatlProf.Basefile_Sanctions,{SANC_PROVTYPE,count(group)},SANC_PROVTYPE));
output(table(Ingenix_NatlProf.Basefile_Sanctions,{ProvCo_Address_Clean_record_type,count(group)},ProvCo_Address_Clean_record_type));

output(table(Ingenix_NatlProf.Basefile_ProviderLicense,{filetyp,licensestate,
  min(group,(string8)effective_date),max(group,(string8)effective_date),
  min(group,(string8)termination_date),max(group,(string8)termination_date),count(group)},
  filetyp,licensestate),all);