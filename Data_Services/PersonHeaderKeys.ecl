/*--SOAP--
	<part name="DataRestrictionMask" type="xsd:string"/>
<message name="PersonHeaderKeys">
</message>
*/

export PersonHeaderKeys := macro


output(choosen(doxie.Key_Zip_Did,10));
output(choosen(doxie.key_zip_did_full,10));
output(choosen(doxie.key_Header_SSN,10));
// output(choosen(doxie.key_Header_rid(),10));
output(choosen(doxie.key_header_phone,10));
output(choosen(doxie.key_Header_StFnameLname,10));
output(choosen(doxie.key_Header_StCityLFName,10));
output(choosen(doxie.Key_Header_Name,10));
output(choosen(doxie.Key_Header_Zip,10));
output(choosen(doxie.key_Header_DA,10));
output(choosen(doxie.key_address,10));
output(choosen(doxie.Key_Header_StreetZipName,10));
output(choosen(doxie.key_header,10));
output(choosen(doxie.key_did_lookups,10));
output(choosen(header.Key_Nbr_Address,10));
output(choosen(doxie.Key_Did_Rid,10));
output(choosen(doxie.Key_Did_Rid2,10));
output(choosen(doxie.Key_DID_SSN_Date,10));
output(choosen(doxie.Key_Header_CountyName,10));
output(choosen(Doxie.Key_Header_FnameSmall,10));
output(choosen(header.Key_AptBuildings,10));
output(choosen(business_risk.Key_SSN_Address,10));
//output(choosen(doxie.Key_Relatives,10)); -- Added to RelativeKeys
output(choosen(doxie.Key_Troy,10));
//output(choosen(doxie.Key_Troy_Vehicle,10));
/*output(choosen(header_slimsort.key_probationary_dids,10));
output(choosen(header_slimsort.Key_Household,10));
output(choosen(header_slimsort.Key_Name_Address,10));
output(choosen(header_slimsort.key_name_addr_St,10));
output(choosen(header_slimsort.Key_Name_Address_NN,10));
output(choosen(header_slimsort.Key_Name_Zip,10));
output(choosen(header_slimsort.Key_Name_SSN,10));
output(choosen(header_slimsort.Key_Name_Phone,10));
output(choosen(header_slimsort.Key_Name_DayOB,10));
output(choosen(header_slimsort.Key_Name_Dob,10));
output(choosen(header_slimsort.key_nazs4_age,10));
output(choosen(header_slimsort.key_nazs4_ssn4,10));
output(choosen(header_slimsort.key_nazs4_zip,10));*/
output(choosen(lssi.Key_Determiner,10));
output(choosen(doxie.Key_Did_HDid,10));
output(choosen(doxie.Key_HHID_Did,10));
output(choosen(doxie.key_header_address_research,10));
output(choosen(doxie.key_nbr_headers,10));
output(choosen(doxie.key_nbr_headers_uid,10));
output(choosen(doxie.key_header_wild_ssn,10));
output(choosen(doxie.Key_Header_Wild_StFnameLname,10));
output(choosen(doxie.Key_Header_Wild_StreetZipName,10));
output(choosen(doxie.Key_Header_Wild_Name,10));
output(choosen(doxie.Key_Header_Wild_Phone,10));
output(choosen(doxie.Key_Header_Wild_Address,10));
output(choosen(doxie.Key_Header_Wild_Zip,10));
output(choosen(doxie.Key_Header_Wild_FnameSmall,10));
output(choosen(doxie.Key_Header_Wild_StCityLFName,10));
output(choosen(doxie.key_header_name_alt,10));
output(choosen(doxie.Key_Header_Wild_SSN_EN,10));
output(choosen(doxie.Key_Header_Wild_Address_EN,10));
output(choosen(doxie.Key_Header_Wild_Address_Loose,10));
output(choosen(header.key_phonetic_lname,10));
output(choosen(doxie.key_header_ssn4,10));
output(choosen(doxie.key_header_ssn5,10));
output(choosen(Doxie.Key_Header_DTS_FnameSmall,10));
output(choosen(Doxie.Key_Header_DTS_Address,10));
output(choosen(Doxie.Key_Header_DTS_StreetZipName,10));
output(choosen(doxie.key_ParentLnames,10));
output(choosen(Doxie.Key_Header_Dob,10));
//output(choosen(Doxie.key_header_with_tu,10));
output(choosen(doxie.Key_Header_Address,10));
output(choosen(doxie.Key_Header_ZipPRLName,10));
output(choosen(address_file.key_address_type,10));
output(choosen(doxie_files.key_minors,10));
output(choosen(doxie.Key_Header_DOBName,10));
output(choosen(Address.Key_CityStChance,10));
output(choosen(AddrFraud.Key_AddrFraud_GeoLink,10));
output(choosen(doxie.key_max_dt_last_seen,10));
output(choosen(doxie.Key_Header_SSN4_V2,10));
output(choosen(aid_build.Key_AID_Base,10));
// output(choosen(Infutor.Key_Header_Infutor_Knowx,10));
//output(choosen(Doxie.Key_Did_Lookups_v2,10));
output(choosen(doxie.Key_Header_Dob_Fname,10));
output(choosen(doxie.Key_Header_Dob_PFname,10));
output(choosen(doxie.Key_Header_Piz,10));
output(choosen(doxie_files.key_minors_hash,10));
//output(choosen(Header.Key_Teaser_cnsmr_did,10));
//output(choosen(Header.Key_Teaser_cnsmr_search,10));
output(choosen(doxie.Key_legacy_ssn,10));
output(choosen(doxie.Key_TUCH_dob,10));
output(choosen(idl_adl_mapping.keys.key_rid,10));


endmacro;