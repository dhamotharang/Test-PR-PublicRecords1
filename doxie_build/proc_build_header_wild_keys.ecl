import ut, autokey, doxie, Roxiekeybuild;

export proc_build_header_wild_keys(string filedate) := function

//ssn key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_header_wild_ssn,
                          '~thor_data400::key::header.wild.ssn.did',
					 '~thor_data400::key::header_wild::'+filedate + '::ssn.did',
                          bld_ssn_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.ssn.did', 
                                      '~thor_data400::key::header_wild::'+filedate + '::ssn.did', 
							   mv_ssn_key);

//ssn en key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_SSN_EN,
                          '~thor_data400::key::header.wild.ssn.did.en',
					 '~thor_data400::key::header_wild::'+filedate + '::ssn.did.en',
                          bld_ssn_en_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.ssn.did.en', 
                                      '~thor_data400::key::header_wild::'+filedate + '::ssn.did.en', 
							   mv_ssn_en_key);

//st flname key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_StFnameLname,
                          '~thor_data400::key::header.wild.st.fname.lname',
					 '~thor_data400::key::header_wild::'+filedate + '::st.fname.lname',
                          bld_st_flname_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.st.fname.lname', 
                                      '~thor_data400::key::header_wild::'+filedate + '::st.fname.lname',
							   mv_st_flname_key);

//street zip name key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_StreetZipName,
                          '~thor_data400::key::header.wild.pname.zip.name.range',
					 '~thor_data400::key::header_wild::'+filedate + '::pname.zip.name.range',
                          bld_street_zip_name_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.pname.zip.name.range', 
                                      '~thor_data400::key::header_wild::'+filedate + '::pname.zip.name.range',
							   mv_street_zip_name_key);
							   
//name key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Name,
                          '~thor_data400::key::header.wild.lname.fname',
					 '~thor_data400::key::header_wild::'+filedate + '::lname.fname',
                          bld_name_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.lname.fname',
                                      '~thor_data400::key::header_wild::'+filedate + '::lname.fname',
							   mv_name_key);							   

//phone key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Phone,
                          '~thor_data400::key::header.wild.phone',
					 '~thor_data400::key::header_wild::'+filedate + '::phone',
                          bld_phone_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.phone',
                                      '~thor_data400::key::header_wild::'+filedate + '::phone',
							   mv_phone_key);							   

//address key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Address,
                          '~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname',
					 '~thor_data400::key::header_wild::'+filedate + '::pname.prange.st.city.sec_range.lname',
                          bld_address_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname',
                                      '~thor_data400::key::header_wild::'+filedate + '::pname.prange.st.city.sec_range.lname',
							   mv_address_key);		

//address en key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Address_EN,
                          '~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname.en',
					 '~thor_data400::key::header_wild::'+filedate + '::pname.prange.st.city.sec_range.lname.en',
                          bld_address_en_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname.en',
                                      '~thor_data400::key::header_wild::'+filedate + '::pname.prange.st.city.sec_range.lname.en',
							   mv_address_en_key);		

							   
//address loose key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Address_Loose,
                          '~thor_data400::key::header.wild.lname.fname.st.city.z5.pname.prange.sec_range',
					 '~thor_data400::key::header_wild::'+filedate + '::lname.fname.st.city.z5.pname.prange.sec_range',
                          bld_address_loose_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.lname.fname.st.city.z5.pname.prange.sec_range',
                                      '~thor_data400::key::header_wild::'+filedate + '::lname.fname.st.city.z5.pname.prange.sec_range',
							   mv_address_loose_key);									   

//zip key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Zip,
                          '~thor_data400::key::header.wild.zip.lname.fname',
					 '~thor_data400::key::header_wild::'+filedate + '::zip.lname.fname',
                          bld_zip_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.zip.lname.fname',
                                      '~thor_data400::key::header_wild::'+filedate + '::zip.lname.fname',
							   mv_zip_key);							   

//fname small key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_FnameSmall,
                          '~thor_data400::key::header.wild.fname_small',
					 '~thor_data400::key::header_wild::'+filedate + '::fname_small',
                          bld_fname_small_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.fname_small',
                                      '~thor_data400::key::header_wild::'+filedate + '::fname_small',
							   mv_fname_small_key);
							   

//st city lfname key
Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_StCityLFName,
                          '~thor_data400::key::header.wild.st.city.fname.lname',
					 '~thor_data400::key::header_wild::'+filedate + '::st.city.fname.lname',
                          bld_st_city_lfname_key);
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.wild.st.city.fname.lname',
                                      '~thor_data400::key::header_wild::'+filedate + '::st.city.fname.lname',
							   mv_st_city_lfname_key);							   

build_header_wild_keys := 
       sequential(parallel(bld_ssn_key, bld_ssn_en_key, bld_st_flname_key, bld_street_zip_name_key,
	                      bld_name_key,  bld_phone_key, bld_address_key, bld_address_loose_key,
					  bld_address_en_key, 
					  bld_zip_key, bld_fname_small_key, bld_st_city_lfname_key),
                  parallel(mv_ssn_key, mv_ssn_en_key, mv_st_flname_key, mv_street_zip_name_key,
			            mv_name_key, mv_phone_key, mv_address_key, mv_address_loose_key,
					  mv_address_en_key,
					  mv_zip_key, mv_fname_small_key, mv_st_city_lfname_key));
					  					  
return build_header_wild_keys;

end;