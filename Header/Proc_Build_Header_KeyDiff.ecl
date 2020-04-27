import lssi,AddrFraud,dx_header,dops;

EXPORT Proc_Build_Header_KeyDiff(string pVersion, string cVersion) := FUNCTION

    pX_Header       := '~thor_data400::key::header::';
    pX_Header_Wild  := '~thor_data400::key::header_wild::';
    pX_Header_Dts   := '~thor_data400::key::header::dts::';
    
    ds := dataset([
    {'dx_header.key_address_research()','~thor_data400::key::address_research_qa',pX_Header + cVersion + '::address_research',pX_Header + pVersion + '::address_research'}
    ,{'AddrFraud.Key_AddrFraud_GeoLink','~thor_data400::key::addrrisk_geolink_qa',pX_Header + cVersion + '::addrrisk_geolink',pX_Header + pVersion + '::addrrisk_geolink'}
    ,{'dx_header.key_did_hhid()','~thor_data400::key::did_hhid_qa','~thor_data400::key::header::hhid::' + cVersion + '::did.ver','~thor_data400::key::header::hhid::' + pVersion + '::did.ver'}
    ,{'dx_header.Key_AptBuildings()','~thor_data400::key::hdr_apt_bldgs_qa',pX_Header + cVersion + '::apt_bldgs',pX_Header + pVersion + '::apt_bldgs'}
    ,{'dx_header.key_CityStChance()','~thor_data400::key::hdr_city_name.st.percent_chance_qa',pX_Header + cVersion + '::city_name.st.percent_chance',pX_Header + pVersion + '::city_name.st.percent_chance'}
    ,{'dx_header.key_CountyName','~thor_data400::key::header.county_qa',pX_Header + cVersion + '::county',pX_Header + pVersion + '::county'}
    ,{'dx_header.key_DA()','~thor_data400::key::header.da_qa',pX_Header + cVersion + '::da',pX_Header + pVersion + '::da'}
    ,{'dx_header.key_DID_SSN_date()','~thor_data400::key::header.did.ssn.date_qa',pX_Header + cVersion + '::did.ssn.date',pX_Header + pVersion + '::did.ssn.date'}
    ,{'dx_header.key_DOBName()','~thor_data400::key::header.dobname_qa',pX_Header + cVersion + '::dobname',pX_Header + pVersion + '::dobname'}
    ,{'dx_header.key_DOB_fname()','~thor_data400::key::header.dob_fname_qa',pX_Header + cVersion + '::dob_fname',pX_Header + pVersion + '::dob_fname'}
    ,{'dx_header.key_DOB_pfname()','~thor_data400::key::header.dob_pfname_qa',pX_Header + cVersion + '::dob_pfname',pX_Header + pVersion + '::dob_pfname'}
    ,{'dx_header.key_DTS_FnameSmall()','~thor_data400::key::header.dts.fname_small_qa',pX_Header_Dts + cVersion + '::fname_small',pX_Header_Dts + pVersion + '::fname_small'}
    ,{'dx_header.key_DTS_address()','~thor_data400::key::header.dts.pname.prange.st.city.sec_range.lname_qa',pX_Header_Dts + cVersion + '::pname.prange.st.city.sec_range.lname',pX_Header_Dts + pVersion + '::pname.prange.st.city.sec_range.lname'}
    ,{'dx_header.key_DTS_StreetZipName()','~thor_data400::key::header.dts.pname.zip.name.range_qa',pX_Header_Dts + cVersion + '::pname.zip.name.range',pX_Header_Dts + pVersion + '::pname.zip.name.range'}
    ,{'dx_header.key_FnameSmall()','~thor_data400::key::header.fname_small_qa',pX_Header + cVersion + '::fname_small',pX_Header + pVersion + '::fname_small'}
    ,{'dx_header.key_SSN()','~thor_data400::key::header.legacy_ssn_qa',pX_Header + cVersion + '::legacy_ssn',pX_Header + pVersion + '::legacy_ssn'}
    ,{'dx_header.key_name_alt()','~thor_data400::key::header.lname.fname_alt_qa',pX_Header + cVersion + '::lname.fname_alt',pX_Header + pVersion + '::lname.fname_alt'}
    ,{'dx_header.key_name()','~thor_data400::key::header.lname.fname_qa',pX_Header + cVersion + '::lname.fname',pX_Header + pVersion + '::lname.fname'}
    ,{'dx_header.key_minors_hash()','~thor_data400::key::header.minors_hash_qa',pX_Header + cVersion + '::minors_hash',pX_Header + pVersion + '::minors_hash'}
    // ,{'dx_header.key_ParentLnames()','~thor_data400::key::header.parentlnames_qa',pX_Header + cVersion + '::parentlnames',pX_Header + pVersion + '::parentlnames'}
    ,{'dx_header.key_phone()','~thor_data400::key::header.phone_qa',pX_Header + cVersion + '::phone',pX_Header + pVersion + '::phone'}
    ,{'dx_header.key_piz()','~thor_data400::key::header.piz_lname_fname_qa',pX_Header + cVersion + '::piz_lname_fname',pX_Header + pVersion + '::piz_lname_fname'}
    ,{'dx_header.key_address()','~thor_data400::key::header.pname.prange.st.city.sec_range.lname_qa',pX_Header + cVersion + '::pname.prange.st.city.sec_range.lname',pX_Header + pVersion + '::pname.prange.st.city.sec_range.lname'}
    ,{'dx_header.key_StreetZipName()','~thor_data400::key::header.pname.zip.name.range_qa',pX_Header + cVersion + '::pname.zip.name.range',pX_Header + pVersion + '::pname.zip.name.range'}
    ,{'dx_header.key_DID_SSN_date()','~thor_data400::key::header.ssn.did_qa',pX_Header + cVersion + '::ssn.did',pX_Header + pVersion + '::ssn.did'}
    ,{'dx_header.key_SSN4()','~thor_data400::key::header.ssn4.did_qa',pX_Header + cVersion + '::ssn4.did',pX_Header + pVersion + '::ssn4.did'}
    ,{'dx_header.key_SSN4_V2()','~thor_data400::key::header.ssn4_v2.did_qa',pX_Header + cVersion + '::ssn4_v2.did',pX_Header + pVersion + '::ssn4_v2.did'}
    ,{'dx_header.key_SSN5()','~thor_data400::key::header.ssn5.did_qa',pX_Header + cVersion + '::ssn5.did',pX_Header + pVersion + '::ssn5.did'}
    ,{'dx_header.key_StCityLFName()','~thor_data400::key::header.st.city.fname.lname_qa',pX_Header + cVersion + '::st.city.fname.lname',pX_Header + pVersion + '::st.city.fname.lname'}
    ,{'dx_header.key_StFnameLname()','~thor_data400::key::header.st.fname.lname_qa',pX_Header + cVersion + '::st.fname.lname',pX_Header + pVersion + '::st.fname.lname'}
    ,{'dx_header.key_TUCH_DOB()','~thor_data400::key::header.tuch_dob_qa',pX_Header + cVersion + '::tuch_dob',pX_Header + pVersion + '::tuch_dob'}
    ,{'dx_header.key_wild_FnameSmall()','~thor_data400::key::header.wild.fname_small_qa',pX_Header_Wild + cVersion + '::fname_small',pX_Header_Wild + pVersion + '::fname_small'}
    ,{'dx_header.key_wild_address_loose()','~thor_data400::key::header.wild.lname.fname.st.city.z5.pname.prange.sec_range_qa',pX_Header_Wild + cVersion + '::lname.fname.st.city.z5.pname.prange.sec_range',pX_Header_Wild + pVersion + '::lname.fname.st.city.z5.pname.prange.sec_range'}
    ,{'dx_header.key_wild_name()','~thor_data400::key::header.wild.lname.fname_qa',pX_Header_Wild + cVersion + '::lname.fname',pX_Header_Wild + pVersion + '::lname.fname'}
    ,{'dx_header.key_wild_phone()','~thor_data400::key::header.wild.phone_qa',pX_Header_Wild + cVersion + '::phone',pX_Header_Wild + pVersion + '::phone'}
    ,{'dx_header.key_wild_address_en()','~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname.en_qa',pX_Header_Wild + cVersion + '::pname.prange.st.city.sec_range.lname.en',pX_Header_Wild + pVersion + '::pname.prange.st.city.sec_range.lname.en'}
    ,{'dx_header.key_wild_address()','~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname_qa',pX_Header_Wild + cVersion + '::pname.prange.st.city.sec_range.lname',pX_Header_Wild + pVersion + '::pname.prange.st.city.sec_range.lname'}
    ,{'dx_header.key_wild_StreetZipName()','~thor_data400::key::header.wild.pname.zip.name.range_qa',pX_Header_Wild + cVersion + '::pname.zip.name.range',pX_Header_Wild + pVersion + '::pname.zip.name.range'}
    ,{'dx_header.key_wild_ssn_en()','~thor_data400::key::header.wild.ssn.did.en_qa',pX_Header_Wild + cVersion + '::ssn.did.en',pX_Header_Wild + pVersion + '::ssn.did.en'}
    ,{'dx_header.key_wild_ssn()','~thor_data400::key::header.wild.ssn.did_qa',pX_Header_Wild + cVersion + '::ssn.did',pX_Header_Wild + pVersion + '::ssn.did'}
    ,{'dx_header.key_wild_StCityLFName()','~thor_data400::key::header.wild.st.city.fname.lname_qa',pX_Header_Wild + cVersion + '::st.city.fname.lname',pX_Header_Wild + pVersion + '::st.city.fname.lname'}
    ,{'dx_header.key_wild_StFnameLname()','~thor_data400::key::header.wild.st.fname.lname_qa',pX_Header_Wild + cVersion + '::st.fname.lname',pX_Header_Wild + pVersion + '::st.fname.lname'}
    ,{'dx_Header.key_wild_zip()','~thor_data400::key::header.wild.zip.lname.fname_qa',pX_Header_Wild + cVersion + '::zip.lname.fname',pX_Header_Wild + pVersion + '::zip.lname.fname'}
    ,{'dx_header.key_zip()','~thor_data400::key::header.zip.lname.fname_qa',pX_Header + cVersion + '::zip.lname.fname',pX_Header + pVersion + '::zip.lname.fname'}
    ,{'dx_header.key_ZipPRLName()','~thor_data400::key::header.zipprlname_qa',pX_Header + cVersion + '::zipprlname',pX_Header + pVersion + '::zipprlname'}
    ,{'dx_header.key_addr_hist()','~thor_data400::key::header::address_rank_qa',pX_Header + cVersion + '::address_rank',pX_Header + pVersion + '::address_rank'}
    ,{'dx_header.key_DMV_restricted()','~thor_data400::key::header::dmv_restricted_qa',pX_Header + cVersion + '::dmv_restricted',pX_Header + pVersion + '::dmv_restricted'}
    ,{'dx_header.key_phonetic_lname()','~thor_data400::key::header::qa::phonetic_lname',pX_Header + cVersion + '::phonetic_lname',pX_Header + pVersion + '::phonetic_lname'}
    ,{'dx_header.key_address()','~thor_data400::key::header_address_qa',pX_Header + cVersion + '::address',pX_Header + pVersion + '::address'}
    ,{'dx_header.key_Did_lookups()','~thor_data400::key::header_lookups_qa',pX_Header + cVersion + '::lookups',pX_Header + pVersion + '::lookups'}
    ,{'dx_header.key_nbr_headers()','~thor_data400::key::header_nbr_qa',pX_Header + cVersion + '::nbr',pX_Header + pVersion + '::nbr'}
    ,{'dx_header.key_nbr_headers_uid()','~thor_data400::key::header_nbr_uid_qa',pX_Header + cVersion + '::nbr_uid',pX_Header + pVersion + '::nbr_uid'}
    ,{'dx_header.key_header()','~thor_data400::key::header_qa',pX_Header + cVersion + '::data',pX_Header + pVersion + '::data'}
    ,{'dx_Header.Key_SSN_Address()','~thor_data400::key::header_ssn_address_qa',pX_Header + cVersion + '::ssn_address',pX_Header + pVersion + '::ssn_address'}
    ,{'dx_header.key_hhid_did()','~thor_data400::key::hhid_did_qa','~thor_data400::key::header::hhid::' + cVersion + '::hhid.ver','~thor_data400::key::header::hhid::' + pVersion + '::hhid.ver'}
    ,{'dx_header.key_did_rid()','~thor_data400::key::lab.did_rid_qa','~thor_data400::key::lab::' + cVersion + '::did_rid','~thor_data400::key::lab::' + pVersion + '::did_rid'}
    // ,{'lssi.Key_Prep_Determiner','~thor_data400::key::lssi.determiner_qa','~thor_data400::key::lssi::' + cVersion + '::determiner','~thor_data400::key::lssi::' + pVersion + '::determiner'}
    ,{'dx_header.key_max_dt_last_seen()','~thor_data400::key::max_dt_last_seen_qa',pX_Header + cVersion + '::max_dt_last_seen',pX_Header + pVersion + '::max_dt_last_seen'}
    ,{'dx_header.key_nbr_address()','~thor_data400::key::nbr_address_qa',pX_Header + cVersion + '::nbr_address',pX_Header + pVersion + '::nbr_address'}
    ,{'dx_header.key_did_rid2()','~thor_data400::key::rid_did2_qa',pX_Header + cVersion + '::rid_did2',pX_Header + pVersion + '::rid_did2'}
    ,{'dx_header.key_did_rid()','~thor_data400::key::rid_did_qa',pX_Header + cVersion + '::rid_did',pX_Header + pVersion + '::rid_did'}
    ,{'dx_header.key_did_rid_split()','~thor_data400::key::rid_did_split_qa',pX_Header + cVersion + '::rid_did_split',pX_Header + pVersion + '::rid_did_split'}
    ,{'doxie.Key_Troy_Prep','~thor_data400::key::troy_qa',pX_Header + cVersion + '::troy',pX_Header + pVersion + '::troy'}
    ,{'dx_header.Key_Zip_Did_Full()','~thor_data400::key::zip_did_full_qa',pX_Header + cVersion + '::zip_did_full',pX_Header + pVersion + '::zip_did_full'}
    ,{'dx_header.Key_Zip_Did()','~thor_data400::key::zip_did_qa',pX_Header + cVersion + '::zip_did',pX_Header + pVersion + '::zip_did'}
    ],dops.modKeydiff().rListToProcess);

    return sequential(
        output(ds, named('PersonHeaderKeys')),
        dops.modKeyDiff().fSpawnKeyDiffWrapper(ds,'PersonHeaderKeys')
        );

END;
