IMPORT data_services, doxie, STD;

// common for all indices name prefix
//string prefix := data_services.data_location.person_header + 'thor_data400::key::' + $.Constants.DataSetName + '::';
string prefix := data_services.data_location.person_header + 'thor_data400::key::';

// a default version is chosen so that the user of an index won't have to provide any specific value;
// when building keys using existing procedures, an empty string will have to be specified. 
EXPORT names (string file_version = doxie.Version_SuperKey):= MODULE

  // Replaces a place-holder for superfile version -- when version is not a trailing component of a name
  EXPORT string ChangeFileVersion (string name, string version) := STD.Str.FindReplace (name, '@version@', version);

  SHARED string postfix := IF (file_version != '', '_' + file_version, '');

  EXPORT i_rid := prefix + 'header.rid_header';
  EXPORT i_rid_src := prefix + 'header_rid_srid_header'; //TODO: different name pattern 

  // ----------------- wild -----------------
  EXPORT i_wild_ssn           := prefix + 'header.wild.ssn.did' + postfix;
  EXPORT i_wild_ssn_en        := prefix + 'header.wild.ssn.did.en' + postfix;
  EXPORT i_wild_StFnameLname  := prefix + 'header.wild.st.fname.lname' + postfix;
  EXPORT i_wild_StreetZipName := prefix + 'header.wild.pname.zip.name.range' + postfix;
  EXPORT i_wild_name          := prefix + 'header.wild.lname.fname' + postfix;
  EXPORT i_wild_phone         := prefix + 'header.wild.phone' + postfix;
  EXPORT i_wild_address       := prefix + 'header.wild.pname.prange.st.city.sec_range.lname' + postfix;
  EXPORT i_wild_address_en    := prefix + 'header.wild.pname.prange.st.city.sec_range.lname.en' + postfix;
  EXPORT i_wild_address_loose := prefix + 'header.wild.lname.fname.st.city.z5.pname.prange.sec_range' + postfix;
  EXPORT i_wild_zip           := prefix + 'header.wild.zip.lname.fname' + postfix;
  EXPORT i_wild_FnameSmall    := prefix + 'header.wild.fname_small' + postfix;
  EXPORT i_wild_StCityLFName  := prefix + 'header.wild.st.city.fname.lname' + postfix;

  // ----------------- autokeys -----------------
  EXPORT i_auto_SSN          := prefix + 'header.ssn.did' + postfix;
  EXPORT i_auto_phone        := prefix + 'header.phone' + postfix;
  EXPORT i_auto_StFnameLname := prefix + 'header.st.fname.lname' + postfix;
  EXPORT i_auto_StCityLFName := prefix + 'header.st.city.fname.lname' + postfix;
  EXPORT i_auto_name         := prefix + 'header.lname.fname' + postfix;
  EXPORT i_auto_name_alt     := prefix + 'header.lname.fname_alt' + postfix;
  EXPORT i_auto_zip          := prefix + 'header.zip.lname.fname' + postfix;
  EXPORT i_auto_address      := prefix + 'header.pname.prange.st.city.sec_range.lname' + postfix;
  EXPORT i_auto_ZipPRLName   := prefix + 'header.ZipPRLName' + postfix;
  EXPORT i_auto_piz          := prefix + 'header.piz_lname_fname' + postfix;

  //non-standard "autokeys"
  EXPORT i_StreetZipName := prefix + 'header.pname.zip.name.range' + postfix;

  EXPORT i_did_hhid := prefix + 'did_hhid' + postfix;

  EXPORT i_hhid_did := prefix + 'hhid_did' + postfix;

  EXPORT i_zip_did := prefix + 'zip_did' + postfix;

  EXPORT i_zip_did_full := prefix + 'zip_did_full' + postfix;

  EXPORT i_DA := prefix + 'header.da' + postfix;

  EXPORT i_lookups := prefix + 'header_lookups' + postfix;

  //meighbors
  EXPORT i_nbr_address := prefix + 'nbr_address' + postfix;
  EXPORT i_nbr_headers := prefix + 'header_nbr' + postfix;
  EXPORT i_nbr_uid     := prefix + 'header_nbr_uid' + postfix;

  EXPORT i_did_rid  := prefix + 'rid_did' + postfix;
  EXPORT i_did_rid2 := prefix + 'rid_did2' + postfix;

  EXPORT i_aptbuildings := prefix + 'hdr_apt_bldgs' + postfix;

  EXPORT i_did_ssn_date :=      prefix + 'header.did.ssn.date' + postfix;
  EXPORT i_did_ssn_date_fcra := prefix + 'fcra::header.did.ssn.date' + postfix;

  EXPORT i_county := prefix + 'header.county' + postfix;

  EXPORT i_fnamesmall := prefix + 'header.fname_small' + postfix;

  EXPORT i_header_address := prefix + 'header_address' + postfix;
  EXPORT i_DTS_address := prefix + 'header.dts.pname.prange.st.city.sec_range.lname' + postfix;
  EXPORT i_DTS_FnameSmall := prefix + 'header.dts.fname_small' + postfix;
  EXPORT i_DTS_StreetZipName := prefix + 'header.dts.pname.zip.name.range' + postfix;
      sf_phonetic_lname := 'header::@version@::phonetic_lname';    // different superfile name pattern
  EXPORT i_phonetic_lname := prefix + IF (file_version = '', sf_phonetic_lname, ChangeFileVersion (sf_phonetic_lname, file_version));
  EXPORT i_ssn4 := prefix + 'header.ssn4.did' + postfix;
  EXPORT i_ssn4_v2 := prefix + 'header.ssn4_v2.did' + postfix;
  EXPORT i_ssn5 := prefix + 'header.ssn5.did' + postfix;

  EXPORT i_DOBName := prefix + 'header.dobname' + postfix;
  EXPORT i_minors := prefix + 'header::minors' + postfix;
  EXPORT i_minors_hash := prefix + 'header.minors_hash' + postfix;

  EXPORT i_max_date := prefix + 'max_dt_last_seen' + postfix;

  // main payload
  EXPORT i_header := prefix + 'header' + postfix;

  EXPORT i_dob_fname := prefix + 'header.dob_fname' + postfix;

  EXPORT i_dob_pfname := prefix + 'header.dob_pfname' + postfix;

  EXPORT i_did_rid_split := prefix + 'rid_did_split' + postfix;

  EXPORT i_legacy_ssn := prefix + 'header.legacy_ssn' + postfix;

  EXPORT i_tuch_dob := prefix + 'header.TUCH_dob' + postfix;

  EXPORT i_addr_hist      := prefix + 'header::address_rank' + postfix; //TODO: hist vs. rank?
  EXPORT i_addr_hist_fcra := prefix + 'fcra::header::address_rank' + postfix; //TODO: hist vs. rank?

  EXPORT i_DMV_restricted := prefix + 'header::DMV_restricted' + postfix;

  EXPORT i_ParentLnames := prefix + 'header.parentlnames' + postfix;

  EXPORT i_address_research := prefix + 'address_research' + postfix;

  EXPORT i_ssn_address := prefix + 'header_ssn_address' + postfix;

  EXPORT i_CityStChance := prefix + 'hdr_city_name.st.percent_chance' + postfix;

  // do not want to define a name for index which is located in a different folder
  //  EXPORT i_geolink := prefix + 'addrrisk_geolink' + postfix;
END;
