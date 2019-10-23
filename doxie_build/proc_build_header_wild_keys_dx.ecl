IMPORT dx_Header, header, Roxiekeybuild;

dsname := dx_Header.Constants.DataSetName;

EXPORT proc_build_header_wild_keys_dx (string filedate) := FUNCTION

// common prefix for logical file names
//prefix := '~thor_data400::key::' + dsname + '::header_wild::' + filedate + '::';
prefix := '~thor_data400::key::header_wild::' + filedate + '::';

//ssn key
name_ssn := prefix + 'ssn.did';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_ssn(), header.data_key_wild_SSN,
                                            dx_Header.names('').i_wild_ssn, name_ssn, bld_ssn_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_ssn, name_ssn, mv_ssn_key);

//ssn en key
name_ssn_en := prefix + 'ssn.did.en';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_SSN_EN(), header.data_key_wild_SSN_EN,
                                            dx_Header.names('').i_wild_ssn_en, name_ssn_en, bld_ssn_en_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_ssn_en, name_ssn_en, mv_ssn_en_key);

//st flname key
name_StFnameLname := prefix + 'st.fname.lname';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_StFnameLname(), header.data_key_wild_StFnameLname,
                                            dx_Header.names('').i_wild_StFnameLname, name_StFnameLname, bld_st_flname_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_wild_StFnameLname, name_StFnameLname, mv_st_flname_key);

//street zip name key
name_StreetZipName := prefix + 'pname.zip.name.range';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_StreetZipName(), header.data_key_wild_StreetZipName,
                                            dx_Header.names('').i_wild_StreetZipName, name_StreetZipName, bld_street_zip_name_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_StreetZipName, name_StreetZipName, mv_street_zip_name_key);
							   
//name key
name_name := prefix + 'lname.fname';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_name(), header.data_key_wild_name,
                                            dx_Header.names('').i_wild_name, name_name, bld_name_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_name, name_name, mv_name_key);							   

//phone key
name_phone := prefix + 'phone';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_phone(), header.data_key_wild_phone,
                                            dx_Header.names('').i_wild_phone, name_phone, bld_phone_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_phone, name_phone, mv_phone_key);							   

//address key
name_address := prefix + 'pname.prange.st.city.sec_range.lname';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_address(), header.data_key_wild_address,
                                            dx_Header.names('').i_wild_address, name_address, bld_address_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_address, name_address, mv_address_key);		

//address en key
name_address_EN := prefix + 'pname.prange.st.city.sec_range.lname.en';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_address_EN(), header.data_key_wild_address_EN,
                                            dx_Header.names('').i_wild_address_EN, name_address_EN, bld_address_en_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_address_EN, name_address_EN, mv_address_en_key);		

							   
//address loose key
name_address_loose := prefix + 'lname.fname.st.city.z5.pname.prange.sec_range';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_address_loose(), header.data_key_wild_address_loose,
                                            dx_Header.names('').i_wild_address_loose, name_address_loose, bld_address_loose_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_address_loose, name_address_loose, mv_address_loose_key);									   

//zip key
name_zip := prefix + 'zip.lname.fname';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_zip(), header.data_key_wild_zip,
                                            dx_Header.names('').i_wild_zip, name_zip, bld_zip_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_zip, name_zip, mv_zip_key);							   

//fname small key
name_FnameSmall := prefix + 'fname_small';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_FnameSmall(), header.data_key_wild_FnameSmall,
                                            dx_Header.names('').i_wild_FnameSmall, name_FnameSmall, bld_fname_small_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_FnameSmall, name_FnameSmall, mv_fname_small_key);
							   

//st city lfname key
name_StCityLFName := prefix + 'st.city.fname.lname';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_StCityLFName(), header.data_key_wild_StCityLFName,
                                            dx_Header.names('').i_wild_StCityLFName, name_StCityLFName, bld_st_city_lfname_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_StCityLFName, name_StCityLFName, mv_st_city_lfname_key);							   

  build_header_wild_keys := SEQUENTIAL (
    PARALLEL (bld_ssn_key, bld_ssn_en_key, bld_st_flname_key, bld_street_zip_name_key,
	            bld_name_key, bld_phone_key, bld_address_key, bld_address_loose_key,
			  		  bld_address_en_key, bld_zip_key, bld_fname_small_key, bld_st_city_lfname_key),
    PARALLEL (mv_ssn_key, mv_ssn_en_key, mv_st_flname_key, mv_street_zip_name_key,
              mv_name_key, mv_phone_key, mv_address_key, mv_address_loose_key,
		          mv_address_en_key, mv_zip_key, mv_fname_small_key, mv_st_city_lfname_key)
  );
					  					  
  RETURN build_header_wild_keys;

END;
