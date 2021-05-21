IMPORT dx_Header, header, Roxiekeybuild,STD;

dsname := dx_Header.Constants.DataSetName;

EXPORT proc_build_header_wild_keys_dx (string filedate) := FUNCTION

// common prefix for logical file names
//prefix := '~thor_data400::key::' + dsname + '::header_wild::' + filedate + '::';
prefix := '~thor_data400::key::header_wild::' + filedate + '::';

//ssn key
name_ssn := prefix + 'ssn.did';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_ssn(), header.data_key_wild_SSN(),
                                            dx_Header.names('').i_wild_ssn, name_ssn, create_key1);
bld_ssn_key:=if(~STD.File.FileExists(name_ssn),create_key1,OUTPUT('ALREADY BUILT:'+name_ssn));


Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_ssn, name_ssn, mv_ssn_key);

//ssn en key
name_ssn_en := prefix + 'ssn.did.en';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_SSN_EN(), header.data_key_wild_SSN_EN,
                                            dx_Header.names('').i_wild_ssn_en, name_ssn_en, create_key2);
bld_ssn_en_key:=if(~STD.File.FileExists(name_ssn_en),create_key2,OUTPUT('ALREADY BUILT:'+name_ssn_en));
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_ssn_en, name_ssn_en, mv_ssn_en_key);

//st flname key
name_StFnameLname := prefix + 'st.fname.lname';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_StFnameLname(), header.data_key_wild_StFnameLname,
                                            dx_Header.names('').i_wild_StFnameLname, name_StFnameLname, create_key3);
bld_st_flname_key:=if(~STD.File.FileExists(name_StFnameLname),create_key3,OUTPUT('ALREADY BUILT:'+name_StFnameLname));


Roxiekeybuild.Mac_SK_Move_to_Built_v2(dx_Header.names('').i_wild_StFnameLname, name_StFnameLname, mv_st_flname_key);

//street zip name key
name_StreetZipName := prefix + 'pname.zip.name.range';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_StreetZipName(), header.data_key_wild_StreetZipName,
                                            dx_Header.names('').i_wild_StreetZipName, name_StreetZipName, create_key4);
bld_street_zip_name_key:=if(~STD.File.FileExists(name_StreetZipName),create_key4,OUTPUT('ALREADY BUILT:'+name_StreetZipName));

Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_StreetZipName, name_StreetZipName, mv_street_zip_name_key);
							   
//name key
name_name := prefix + 'lname.fname';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_name(), header.data_key_wild_name,
                                            dx_Header.names('').i_wild_name, name_name, create_key5);
bld_name_key:=if(~STD.File.FileExists(name_name),create_key5,OUTPUT('ALREADY BUILT:'+name_name));
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_name, name_name, mv_name_key);							   

//phone key
name_phone := prefix + 'phone';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_phone(), header.data_key_wild_phone,
                                            dx_Header.names('').i_wild_phone, name_phone, create_key6);
bld_phone_key:=if(~STD.File.FileExists(name_phone),create_key6,OUTPUT('ALREADY BUILT:'+name_phone));
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_phone, name_phone, mv_phone_key);							   

//address key
name_address := prefix + 'pname.prange.st.city.sec_range.lname';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_address(), header.data_key_wild_address,
                                            dx_Header.names('').i_wild_address, name_address, create_key7);
bld_address_key:=if(~STD.File.FileExists(name_address),create_key7,OUTPUT('ALREADY BUILT:'+name_address));
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_address, name_address, mv_address_key);		

//address en key
name_address_EN := prefix + 'pname.prange.st.city.sec_range.lname.en';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_address_EN(), header.data_key_wild_address_EN,
                                            dx_Header.names('').i_wild_address_EN, name_address_EN, create_key8);
bld_address_en_key:=if(~STD.File.FileExists(name_address_EN),create_key8,OUTPUT('ALREADY BUILT:'+name_address_EN));
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_address_EN, name_address_EN, mv_address_en_key);		

							   
//address loose key
name_address_loose := prefix + 'lname.fname.st.city.z5.pname.prange.sec_range';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_address_loose(), header.data_key_wild_address_loose,
                                            dx_Header.names('').i_wild_address_loose, name_address_loose, create_key9);
bld_address_loose_key:=if(~STD.File.FileExists(name_address_loose),create_key9,OUTPUT('ALREADY BUILT:'+name_address_loose));
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_address_loose, name_address_loose, mv_address_loose_key);									   

//zip key
name_zip := prefix + 'zip.lname.fname';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_zip(), header.data_key_wild_zip,
                                            dx_Header.names('').i_wild_zip, name_zip, create_key10);
bld_zip_key:=if(~STD.File.FileExists(name_zip),create_key10,OUTPUT('ALREADY BUILT:'+name_zip));
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_zip, name_zip, mv_zip_key);							   

//fname small key
name_FnameSmall := prefix + 'fname_small';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_FnameSmall(), header.data_key_wild_FnameSmall,
                                            dx_Header.names('').i_wild_FnameSmall, name_FnameSmall, create_key11);
bld_fname_small_key:=if(~STD.File.FileExists(name_FnameSmall),create_key11,OUTPUT('ALREADY BUILT:'+name_FnameSmall));
			
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_wild_FnameSmall, name_FnameSmall, mv_fname_small_key);
							   

//st city lfname key
name_StCityLFName := prefix + 'st.city.fname.lname';
Roxiekeybuild.MAC_build_logical (dx_Header.key_wild_StCityLFName(), header.data_key_wild_StCityLFName,
                                            dx_Header.names('').i_wild_StCityLFName, name_StCityLFName, create_key12);
bld_st_city_lfname_key:=if(~STD.File.FileExists(name_StCityLFName),create_key12,OUTPUT('ALREADY BUILT:'+name_StCityLFName));
			
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
