IMPORT header, address, lssi, doxie_build, RoxieKeyBuild, business_risk, AddrFraud,
  aid_build, PromoteSupers, InsuranceHeader_xLink;
IMPORT dx_Header;

dsname := dx_Header.Constants.DataSetName;

EXPORT proc_Header_keys_dx (string filedate, boolean pFastHeader=FALSE) := FUNCTION

//prefix := '~thor_data400::key::' + dsname + '::header::' + filedate + '::';
prefix := '~thor_data400::key::header::' + filedate + '::';

//Build header/fheader shared keys
name_rid := prefix + 'rid_header';
//TODO: find out if "pFastHeader" and "combo" parameters are needed
RoxieKeybuild.MAC_build_logical (dx_Header.key_rid(0, pFastHeader, FALSE), header.data_key_rid (pFastHeader, FALSE), 
                                 dx_Header.names('').i_rid, name_rid, rid_only);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_rid, name_rid, mv_rid, , , TRUE);

name_rid_src := prefix + 'rid_srid_header';
//TODO: find out if "pFastHeader" and "combo" parameters are needed
RoxieKeybuild.MAC_build_logical (dx_Header.key_Rid_SrcID(0, pFastHeader, FALSE), header.data_key_rid_SrcID (pFastHeader, FALSE),
                                 dx_Header.names('').i_rid_src, name_rid_src, bld_rid_srid_key);
RoxieKeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_rid_src, name_rid_src, mv_rid_srid_key, , , TRUE);


//Build Header Wildcard Keys
bld_wildcard := doxie_build.proc_build_header_wild_keys_dx (filedate);

//Build HHID Keys
hhid_did := doxie_build.Proc_HHID_BuildKeys_dx (filedate);

PromoteSupers.Mac_SF_BuildProcess(doxie.lookups,'~thor_data400::base::doxie_lookups',lookup_pre,2,,pCompress:=true,pVersion:=filedate)

question_key := lssi.Proc_BuildKey(filedate);

//Build keys
name_zip_did := prefix + 'zip_did';
RoxieKeybuild.MAC_build_logical (dx_Header.key_zip_did(), header.data_Key_Prep_Zip_Did, dx_Header.names('').i_zip_did, name_zip_did, zip_did);
name_zip_did_full := prefix + 'zip_did_full';
RoxieKeybuild.MAC_build_logical (dx_Header.key_zip_did_full(), header.data_key_prep_zip_did_full, dx_Header.names('').i_zip_did_full, name_zip_did_full, zip_did_full);
name_ssn := prefix + 'ssn.did';
RoxieKeybuild.MAC_build_logical (dx_Header.key_SSN(), header.data_key_SSN, dx_Header.names('').i_auto_SSN, name_ssn, ssn_did);
name_phone := prefix + 'phone';
RoxieKeybuild.MAC_build_logical (dx_Header.key_phone(), header.data_key_phone, dx_Header.names('').i_auto_phone, name_phone, phone_only);
name_StFnameLname := prefix + 'st.fname.lname';
RoxieKeybuild.MAC_build_logical (dx_Header.key_StFnameLname(), header.data_key_StFnameLname, dx_Header.names('').i_auto_StFnameLname, name_StFnameLname, st_fname_lname);
name_StCityLFName := prefix + 'st.city.fname.lname';
RoxieKeybuild.MAC_build_logical (dx_Header.key_StCityLFName(), header.data_key_StCityLFName, dx_Header.names('').i_auto_StCityLFName, name_StCityLFName, st_city_fname_lname);
name_name := prefix + 'lname.fname';
RoxieKeybuild.MAC_build_logical (dx_Header.key_name(), header.data_key_name, dx_Header.names('').i_auto_name, name_name, lname_fname);
name_name_alt := prefix + 'lname.fname_alt';
RoxieKeybuild.MAC_build_logical (dx_Header.key_name_alt(), header.data_key_name_alt, dx_Header.names('').i_auto_name_alt, name_name_alt, lname_fname_alt);
name_zip := prefix + 'zip.lname.fname';
RoxieKeybuild.MAC_build_logical (dx_Header.key_zip(), header.data_key_zip, dx_Header.names('').i_auto_zip, name_zip, zip_lname_fname);
name_DA := prefix + 'da';
RoxieKeybuild.MAC_build_logical (dx_Header.key_DA(), header.data_key_DA, dx_Header.names('').i_DA, name_DA, da_key);
name_address := prefix + 'pname.prange.st.city.sec_range.lname';
RoxieKeybuild.MAC_build_logical (dx_Header.key_address(), header.data_key_address, dx_Header.names('').i_auto_address, name_address, addr_key);
name_StreetZipName := prefix + 'pname.zip.name.range';
RoxieKeybuild.MAC_build_logical (dx_Header.key_StreetZipName(), header.data_key_StreetZipName, dx_Header.names('').i_StreetZipName, name_StreetZipName, street_key);
name_header := prefix + 'data';
RoxieKeybuild.MAC_build_logical (dx_Header.key_header(), header.data_key_header, dx_Header.names('').i_header, name_header, head_data);
name_lookups := prefix + 'lookups';
RoxieKeybuild.MAC_build_logical (dx_Header.key_did_lookups(), header.data_key_did_lookups, dx_Header.names('').i_lookups, name_lookups, lookup_me);
name_nbr_address := prefix + 'nbr_address';
RoxieKeybuild.MAC_build_logical (dx_Header.key_nbr_address(), header.data_key_nbr_address, dx_Header.names('').i_nbr_address, name_nbr_address, nbours);
name_nbr_headers := prefix + 'nbr';
RoxieKeybuild.MAC_build_logical (dx_Header.key_nbr_headers(), header.data_key_nbr_headers, dx_Header.names('').i_nbr_headers, name_nbr_headers, nbr);
name_nbr_uid := prefix + 'nbr_uid';
RoxieKeybuild.MAC_build_logical (dx_Header.key_nbr_headers_uid(), header.data_key_nbr_headers_uid, dx_Header.names('').i_nbr_uid, name_nbr_uid, nbr_uid);
name_did_rid := prefix + 'rid_did';
RoxieKeybuild.MAC_build_logical (dx_Header.key_did_rid(), header.data_key_did_rid, dx_Header.names('').i_did_rid, name_did_rid, rid_did);
name_did_rid2 := prefix + 'rid_did2';
RoxieKeybuild.MAC_build_logical (dx_Header.key_did_rid2(), header.data_key_did_rid2, dx_Header.names('').i_did_rid2, name_did_rid2, rid_did2);
name_did_ssn := prefix + 'did.ssn.date';
//TODO: header.data_key_DID_SSN_date is the same for FCRA and non-FCRA side, so parameter is not needed.
RoxieKeybuild.MAC_build_logical (dx_Header.key_DID_SSN_Date(), header.data_key_DID_SSN_date(), dx_Header.names('').i_did_ssn_date, name_did_ssn, ssn_date);
name_county := prefix + 'county';
RoxieKeybuild.MAC_build_logical (dx_Header.key_CountyName(), header.data_key_CountyName, dx_Header.names('').i_county, name_county, county_name);
name_fnamesmall := prefix + 'fname_small';
RoxieKeybuild.MAC_build_logical (dx_Header.key_FnameSmall(), header.data_key_FnameSmall, dx_Header.names('').i_fnamesmall, name_fnamesmall, fname_small);
name_aptbuildings := prefix + 'apt_bldgs';
RoxieKeybuild.MAC_build_logical (dx_Header.key_AptBuildings(), header.data_key_AptBuildings, dx_Header.names('').i_aptbuildings, name_aptbuildings, apt_blg);
//cannot test-build it locally, since I don't have ":BASE::Address_Cache::Super"
name_address_research := prefix + 'address_research';        
RoxieKeybuild.MAC_build_logical (dx_Header.key_address_research(), header.data_key_address_research, dx_Header.names('').i_address_research, name_address_research, addr_rsch);
//formely, business_risk.Key_SSN_Address
name_ssn_address := prefix + 'ssn_address';
RoxieKeybuild.MAC_build_logical (dx_Header.key_ssn_address(), header.data_key_SSN_address, dx_Header.names('').i_ssn_address, name_ssn_address, ssn_address);
name_phonetic_lname := prefix + 'phonetic_lname';
RoxieKeyBuild.MAC_build_logical (dx_Header.key_phonetic_lname(), header.data_key_phonetic_lname, dx_Header.names('').i_phonetic_lname, name_phonetic_lname, phonetic_lname_key);
//TODO:	why DTS use different name pattern?
//dts_prefix := '~thor_data400::key::' + dsname + '::header::dts::' + filedate + '::';
dts_prefix := '~thor_data400::key::header::dts::' + filedate + '::';
name_DTS_Address := dts_prefix + 'pname.prange.st.city.sec_range.lname';
RoxieKeyBuild.MAC_build_logical (dx_Header.key_DTS_Address(), header.data_key_DTS_Address, dx_Header.names('').i_DTS_address, name_DTS_Address, dts_addr);
name_DTS_StreetZipName := dts_prefix + 'pname.zip.name.range';
RoxieKeyBuild.MAC_build_logical (dx_Header.key_DTS_StreetZipName(), header.data_key_DTS_StreetZipName, dx_Header.names('').i_DTS_StreetZipName, name_DTS_StreetZipName, dts_street);
name_DTS_FnameSmall := dts_prefix + 'fname_small';
RoxieKeyBuild.MAC_build_logical (dx_Header.key_DTS_FnameSmall(), header.data_key_DTS_FnameSmall, dx_Header.names('').i_DTS_FnameSmall, name_DTS_FnameSmall, dts_fsmall);
name_SSN4 := prefix + 'ssn4.did';
RoxieKeybuild.MAC_build_logical (dx_Header.key_SSN4(), header.data_key_SSN4, dx_Header.names('').i_ssn4, name_SSN4,ssn4_did);
name_SSN5 := prefix + 'ssn5.did';
RoxieKeybuild.MAC_build_logical (dx_Header.key_SSN5(), header.data_key_SSN5, dx_Header.names('').i_ssn5, name_SSN5, ssn5_did);
name_header_address := prefix + 'address';
RoxieKeybuild.MAC_build_logical (dx_Header.key_header_address(), header.data_key_header_address, dx_Header.names('').i_header_address, name_header_address, address_payload);
name_ParentLnames := prefix + 'parentlnames';
RoxieKeybuild.MAC_build_logical (dx_Header.key_ParentLnames(), header.data_key_ParentLnames, dx_Header.names('').i_ParentLnames, name_ParentLnames, parentlnames);
name_ZipPRLName := prefix + 'zipprlname';
RoxieKeybuild.MAC_build_logical (dx_Header.key_ZipPRLName(), header.data_key_ZipPRLName, dx_Header.names('').i_auto_ZipPRLName, name_ZipPRLName, zipprlname);
name_minors := prefix + 'minors';
RoxieKeybuild.MAC_build_logical (dx_Header.key_minors(), header.data_key_minors, dx_Header.names('').i_minors, name_minors, minors);
name_DOBName := prefix + 'dobname';
RoxieKeybuild.MAC_build_logical (dx_Header.key_DOBName(), header.data_key_DOBName, dx_Header.names('').i_DOBName, name_DOBName, dob_name);
//formely, Address/Key_CityStChance
name_percent := prefix + 'city_name.st.percent_chance';
RoxieKeybuild.MAC_build_logical (dx_Header.key_CityStChance(), header.data_key_CityStChance, dx_Header.names('').i_CityStChance, name_percent, bld_percent, TRUE); //one node
        //cannot test-build locally
        name_geolink := prefix + 'addrrisk_geolink';
				RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(AddrFraud.Key_AddrFraud_GeoLink,'~thor_data400::key::addrrisk_geolink',name_geolink,addrrisk_geolink);
name_max_dt_last_seen := prefix + 'max_dt_last_seen';
RoxieKeybuild.MAC_build_logical (dx_Header.key_max_dt_last_seen(), header.data_key_max_dt_last_seen, dx_Header.names('').i_max_date, name_max_dt_last_seen, max_dt_last_seen);
name_SSN4_v2 := prefix + 'ssn4_v2.did';
RoxieKeybuild.MAC_build_logical (dx_Header.key_SSN4_V2(), header.data_key_SSN4_V2, dx_Header.names('').i_ssn4_v2, name_SSN4_v2, ssn4_v2);
        //cannot test-build locally
				RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(aid_build.Key_AID_Base,'~thor_data400::key::aid::RawAID_to_ACECahe','~thor_data400::key::aid::'+filedate+'::RawAID_to_ACECahe',rawaid);
name_DOB_fname := prefix + 'dob_fname';
RoxieKeybuild.MAC_build_logical (dx_Header.key_DOB_fname(), header.data_key_DOB_fname,  dx_Header.names('').i_DOB_fname, name_DOB_fname, dob_fname);
name_DOB_pfname :=  prefix + 'dob_pfname';
RoxieKeybuild.MAC_build_logical (dx_Header.key_DOB_pfname(), header.data_key_DOB_fname, dx_Header.names('').i_DOB_pfname, name_DOB_pfname, dob_pfname);
name_piz := prefix + 'piz_lname_fname';
RoxieKeybuild.MAC_build_logical (dx_Header.key_piz(), header.data_key_piz, dx_Header.names('').i_auto_piz, name_piz, piz_lname_fname);
name_minors_hash :=  prefix + 'minors_hash';
RoxieKeybuild.MAC_build_logical (dx_Header.key_minors_hash(), header.data_key_minors_hash, dx_Header.names('').i_minors_hash, name_minors_hash, minors_Hash);
name_legacy_ssn := prefix + 'legacy_ssn';
RoxieKeyBuild.MAC_build_logical (dx_Header.key_legacy_ssn(), header.data_key_legacy_ssn, dx_Header.names('').i_legacy_ssn, name_legacy_ssn, legacy_ssn);
name_TUCH_DOB := prefix + 'TUCH_dob';
RoxieKeyBuild.MAC_build_logical (dx_Header.key_TUCH_DOB(), header.data_key_TUCH_DOB, dx_Header.names('').i_TUCH_DOB, name_TUCH_DOB, TUCH_dob);
name_did_rid_split := prefix + 'rid_did_split';
RoxieKeybuild.MAC_build_logical (dx_Header.key_did_rid_split(), header.data_key_did_rid_split, dx_Header.names('').i_did_rid_split, name_did_rid_split, rid_did_split);
//TODO: header.data_key_addr_hist is the same for FCRA and non-FCRA side, so parameter is not needed.
name_addr_hist := prefix + 'address_rank';
RoxieKeybuild.MAC_build_logical (dx_Header.key_addr_hist(), header.data_key_addr_hist(), dx_Header.names('').i_addr_hist, name_addr_hist, address_rank);
name_DMV_restricted := prefix + 'DMV_restricted';
RoxieKeybuild.MAC_build_logical (dx_Header.key_DMV_restricted (), header.data_key_DMV_restricted (filedate), dx_Header.names('').i_DMV_restricted, name_DMV_restricted, DMV_restricted);
        //TODO: different name pattern
				RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(InsuranceHeader_xLink.Key_InsuranceHeader_DID,'~thor_data400::key::insuranceheader_xlink::did','~thor_data400::key::insuranceheader_xlink::'+filedate+'::did',ins_did);


//Move to Built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_zip_did, name_zip_did, mv_zip);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_zip_did_full, name_zip_did_full, mv_zipf);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_auto_SSN, name_ssn, mv_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_auto_phone, name_phone, mv_phone);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_auto_StFnameLname, name_StFnameLname, mv_st_name);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_auto_StCityLFName, name_StCityLFName, mv_st_city);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_auto_name, name_name, mv_name);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_auto_name_alt, name_name_alt, mv_name_alt);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_auto_zip, name_zip, mv_zip_name);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_DA, name_DA, mv_da);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_auto_address, name_address, mv_addr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_StreetZipName, name_StreetZipName, mv_street);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_header, name_header, mv_data);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_lookups, name_lookups, mv_lookup);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_nbr_address, name_nbr_address, mv_nbr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_nbr_headers, name_nbr_headers, mv_nbr2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_nbr_uid, name_nbr_uid, mv_nbr_uid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_did_rid, name_did_rid, mv_rid_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_did_rid2, name_did_rid2, mv_rid2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_did_ssn_date, name_did_ssn, mv_did_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_county, name_county, mv_cnty);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_fnamesmall, name_fnamesmall, mv_fname_small);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_aptbuildings, name_aptbuildings, mv_apt);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_address_research, name_address_research, mv_addr_rsch);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_ssn_address, name_ssn_address, mv_ssn_addr);
Roxiekeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_phonetic_lname, name_phonetic_lname, mv_phonetic_lname_key);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_DTS_address, name_DTS_address, mv_dts_addr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_DTS_StreetZipName, name_DTS_StreetZipName, mv_dts_street);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_DTS_FnameSmall, name_DTS_FnameSmall, mv_dts_fsmall);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_ssn4, name_ssn4, mv_ssn4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_ssn5, name_ssn5, mv_ssn5);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_header_address, name_header_address, mv_address_payload);
RoxieKeybuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_ParentLnames, name_ParentLnames, mv_parentlnames);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_auto_ZipPRLName, name_ZipPRLName, mv_zipprlname);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_minors, name_minors, mv_minors);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_DOBName, name_DOBName, mv_dobname);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_CityStChance, name_percent, mv_percent,true);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::addrrisk_geolink',name_geolink,mv_addrrisk_geolink);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_max_date, name_max_dt_last_seen, mv_max_dt_last_seen);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_ssn4_v2, name_SSN4_v2, mv_ssn4_v2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::aid::RawAID_to_ACECahe','~thor_data400::key::aid::'+filedate+'::RawAID_to_ACECahe',mv_rawaid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_DOB_fname, name_DOB_fname, mv_dob_fname);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_DOB_pfname, name_DOB_pfname, mv_dob_pfname);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_auto_piz, name_piz, mv_piz_lname_fname);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_minors_hash, name_minors_hash, mv_minors_hash);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_legacy_ssn, name_legacy_ssn, mv_legacy_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_TUCH_DOB, name_TUCH_DOB, mv_TUCH_dob);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_did_rid_split, name_did_rid_split, mv_rid_did_split);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_addr_hist, name_addr_hist, mv_address_rank);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_DMV_restricted, name_DMV_restricted, mv_DMV_restricted);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::insuranceheader_xlink::did','~thor_data400::key::insuranceheader_xlink::'+filedate+'::did',mv_ins_did);

header_key_builds := sequential(
														lookup_pre,
														parallel(
																rid_only
																,bld_rid_srid_key
																,bld_wildcard
																,hhid_did
																,zip_did
																,zip_did_full
																,ssn_did
																,phone_only
																,zip_lname_fname
																,lname_fname
																,lname_fname_alt
																,st_fname_lname
																,da_key
																,addr_key
																,street_key
																,st_city_fname_lname
   															,question_key
																,lookup_me
																,nbours
																,nbr
																,nbr_uid
																,rid_did
																,rid_did2
																,ssn_date
																,county_name
																,fname_small
																,apt_blg
																,addr_rsch
																,ssn_address
																,phonetic_lname_key
																,dts_addr
																,dts_street
																,dts_fsmall
																,ssn4_did
																,ssn5_did
																,parentlnames
																,zipprlname
																,minors
																,dob_name
			  												,bld_percent
				  											,addrrisk_geolink
																,ins_did
																)
														,head_data
														,address_payload
														,max_dt_last_seen
														,ssn4_v2
									  				,rawaid
														,dob_fname
														,dob_pfname
														,piz_lname_fname
														,minors_Hash
														,legacy_ssn
														,TUCH_dob
														,rid_did_split
														,address_rank
														,DMV_restricted
														,parallel(
																mv_rid
																,mv_rid_srid_key
                                        // place holder: wildcard
                                        // place holder: hhid
																,mv_zip
																,mv_zipf
																,mv_ssn
																,mv_phone
																,mv_zip_name
																,mv_name
																,mv_name_alt
																,mv_st_name
																,mv_da
																,mv_addr
																,mv_street
																,mv_st_city
                                        // place holder: question key
																,mv_lookup
																,mv_nbr
																,mv_nbr2
																,mv_nbr_uid
																,mv_rid_did
																,mv_rid2
																,mv_did_ssn
																,mv_cnty
																,mv_fname_small
																,mv_apt
																,mv_addr_rsch
																,mv_ssn_addr
																,mv_phonetic_lname_key
																,mv_dts_addr
																,mv_dts_street
																,mv_dts_fsmall
																,mv_ssn4
																,mv_ssn5
  															,mv_parentlnames
																,mv_zipprlname
																,mv_minors
																,mv_dobname
																,mv_percent
	  														,mv_addrrisk_geolink
     														,mv_ins_did
																,mv_data
																,mv_address_payload
																,mv_max_dt_last_seen
																,mv_ssn4_v2
																,mv_rawaid
																,mv_dob_fname
																,mv_dob_pfname
																,mv_piz_lname_fname
																,mv_minors_Hash
																,mv_legacy_ssn
																,mv_TUCH_dob
																,mv_rid_did_split
																,mv_address_rank
																,mv_DMV_restricted
																)
														);

  RETURN IF (~pFastHeader AND fileservices.getsuperfilesubname('~thor_data400::Base::HeaderKey_Built',1)=fileservices.getsuperfilesubname('~thor_data400::Base::Header',1),
                                          OUTPUT('No Header keys were built.'),
             header_key_builds);

END;