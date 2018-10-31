import header,address,lssi,doxie_build,RoxieKeyBuild,business_risk,doxie_files,AddrFraud,aid_build,PromoteSupers,InsuranceHeader_xLink;

export Proc_Header_Keys(string filedate, boolean pFastHeader=false) := function

//Build header/fheader shared keys
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_rid(pFastHeader,false),'~thor_data400::key::header.rid_header','~thor_data400::key::header::'+filedate+'::rid_header',rid_only);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header.Key_Rid_SrcID_Prep(pFastHeader,false),'~thor_data400::key::header_rid_srid_header','~thor_data400::key::header::'+filedate+'::rid_srid_header',bld_rid_srid_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.rid_header','~thor_data400::key::header::'+filedate+'::rid_header',mv_rid,,,true);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header_rid_srid_header','~thor_data400::key::header::'+filedate+'::rid_srid_header',mv_rid_srid_key,,,true);


//Build Header Wildcard Keys
bld_wildcard := doxie_build.proc_build_header_wild_keys(filedate);

//Build HHID Keys
hhid_did := doxie_build.Proc_HHID_BuildKeys(filedate);

PromoteSupers.Mac_SF_BuildProcess(doxie.lookups,'~thor_data400::base::doxie_lookups',lookup_pre,2,,pCompress:=true,pVersion:=filedate)

question_key := lssi.Proc_BuildKey(filedate);

//Build keys
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_build.Key_Prep_Zip_Did,'~thor_data400::key::zip_did','~thor_data400::key::header::'+filedate+'::zip_did',zip_did);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_build.key_prep_zip_did_full,'~thor_data400::key::zip_did_full','~thor_data400::key::header::'+filedate+'::zip_did_full',zip_did_full);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_SSN,'~thor_data400::key::header.ssn.did','~thor_data400::key::header::'+filedate+'::ssn.did',ssn_did);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_header_phone,'~thor_data400::key::header.phone','~thor_data400::key::header::'+filedate+'::phone',phone_only);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_StFnameLname,'~thor_data400::key::header.st.fname.lname','~thor_data400::key::header::'+filedate+'::st.fname.lname',st_fname_lname);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_StCityLFName,'~thor_data400::key::header.st.city.fname.lname','~thor_data400::key::header::'+filedate+'::st.city.fname.lname',st_city_fname_lname);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Name,'~thor_data400::key::header.lname.fname','~thor_data400::key::header::'+filedate+'::lname.fname',lname_fname);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Name_alt,'~thor_data400::key::header.lname.fname_alt','~thor_data400::key::header::'+filedate+'::lname.fname_alt',lname_fname_alt);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Zip,'~thor_data400::key::header.zip.lname.fname','~thor_data400::key::header::'+filedate+'::zip.lname.fname',zip_lname_fname);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_DA,'~thor_data400::key::header.da','~thor_data400::key::header::'+filedate+'::da',da_key);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_address,'~thor_data400::key::header.pname.prange.st.city.sec_range.lname','~thor_data400::key::header::'+filedate+'::pname.prange.st.city.sec_range.lname',addr_key);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_StreetZipName,'~thor_data400::key::header.pname.zip.name.range','~thor_data400::key::header::'+filedate+'::pname.zip.name.range',street_key);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_header,'~thor_data400::key::header','~thor_data400::key::header::'+filedate+'::data',head_data);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_did_lookups,'~thor_data400::key::header_lookups','~thor_data400::key::header::'+filedate+'::lookups',lookup_me);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header.Key_Nbr_Address,'~thor_data400::key::nbr_address','~thor_data400::key::header::'+filedate+'::nbr_address',nbours);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Doxie.key_nbr_headers,'~thor_Data400::key::header_nbr','~thor_data400::key::header::'+filedate+'::nbr',nbr);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Doxie.key_nbr_headers_uid,'~thor_Data400::key::header_nbr_uid','~thor_data400::key::header::'+filedate+'::nbr_uid',nbr_uid);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Did_Rid, '~thor_data400::key::rid_did','~thor_data400::key::header::'+filedate+'::rid_did',rid_did);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Did_Rid2, '~thor_data400::key::rid_did2','~thor_data400::key::header::'+filedate+'::rid_did2',rid_did2);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_DID_SSN_Date(), '~thor_data400::key::header.did.ssn.date','~thor_data400::key::header::'+filedate+'::did.ssn.date', ssn_date);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_CountyName, '~thor_data400::key::header.county','~thor_data400::key::header::'+filedate+'::county', county_name);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Doxie.Key_Header_FnameSmall, '~thor_data400::key::header.fname_small','~thor_data400::key::header::'+filedate+'::fname_small', fname_small);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header.Key_AptBuildings, '~thor_data400::key::hdr_apt_bldgs','~thor_data400::key::header::'+filedate+'::apt_bldgs',apt_blg);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_header_address_research, '~thor_data400::key::address_research','~thor_data400::key::header::'+filedate+'::address_research',addr_rsch);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(business_risk.Key_SSN_Address,'~thor_data400::key::header_ssn_address','~thor_data400::key::header::'+filedate+'::ssn_address',ssn_address);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(header.key_phonetic_lname,'~thor_data400::key::header::phonetic_lname','~thor_data400::key::header::'+filedate+'::phonetic_lname',phonetic_lname_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_Header_DTS_Address,'~thor_data400::key::header.dts.pname.prange.st.city.sec_range.lname','~thor_data400::key::header::dts::'+filedate+'::pname.prange.st.city.sec_range.lname',dts_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_Header_DTS_StreetZipName,'~thor_data400::key::header.dts.pname.zip.name.range','~thor_data400::key::header::dts::'+filedate+'::pname.zip.name.range',dts_street);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_Header_DTS_FnameSmall,'~thor_data400::key::header.dts.fname_small','~thor_data400::key::header::dts::'+filedate+'::fname_small',dts_fsmall);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_SSN4,'~thor_data400::key::header.ssn4.did','~thor_data400::key::header::'+filedate+'::ssn4.did',ssn4_did);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_SSN5,'~thor_data400::key::header.ssn5.did','~thor_data400::key::header::'+filedate+'::ssn5.did',ssn5_did);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Address ,'~thor_data400::key::header_address','~thor_data400::key::header::'+filedate+'::address',address_payload);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_ParentLnames ,'~thor_data400::key::header.parentlnames','~thor_data400::key::header::'+filedate+'::parentlnames',parentlnames);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_ZipPRLName,'~thor_data400::key::header.zipprlname','~thor_data400::key::header::'+filedate+'::zipprlname',zipprlname);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_minors,'~thor_data400::key::header::minors','~thor_data400::key::header::'+filedate+'::minors',minors);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_DOBName,'~thor_data400::key::header.dobname','~thor_data400::key::header::'+filedate+'::dobname',dob_name);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Address.Key_CityStChance,'~thor_data400::key::hdr_city_name.st.percent_chance','~thor_data400::key::header::'+filedate+'::city_name.st.percent_chance',bld_percent,true);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(AddrFraud.Key_AddrFraud_GeoLink,'~thor_data400::key::addrrisk_geolink','~thor_data400::key::header::'+filedate+'::addrrisk_geolink',addrrisk_geolink);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_max_dt_last_seen,'~thor_data400::key::max_dt_last_seen','~thor_data400::key::header::'+filedate+'::max_dt_last_seen',max_dt_last_seen);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_SSN4_V2,'~thor_data400::key::header.ssn4_v2.did','~thor_data400::key::header::'+filedate+'::ssn4_v2.did',ssn4_v2);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(aid_build.Key_AID_Base,'~thor_data400::key::aid::RawAID_to_ACECahe','~thor_data400::key::aid::'+filedate+'::RawAID_to_ACECahe',rawaid);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Dob_Fname,'~thor_data400::key::header.dob_fname','~thor_data400::key::header::'+filedate+'::dob_fname',dob_fname);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Dob_PFname,'~thor_data400::key::header.dob_pfname','~thor_data400::key::header::'+filedate+'::dob_pfname',dob_pfname);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Piz,'~thor_data400::key::header.piz_lname_fname','~thor_data400::key::header::'+filedate+'::piz_lname_fname',piz_lname_fname);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_minors_hash,'~thor_data400::key::header.minors_hash','~thor_data400::key::header::'+filedate+'::minors_hash',minors_Hash);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_legacy_ssn,'~thor_data400::key::header.legacy_ssn','~thor_data400::key::header::'+filedate+'::legacy_ssn',legacy_ssn);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_TUCH_dob,'~thor_data400::key::header.TUCH_dob','~thor_data400::key::header::'+filedate+'::TUCH_dob',TUCH_dob);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Did_Rid_Split,'~thor_data400::key::rid_did_split','~thor_data400::key::header::'+filedate+'::rid_did_split',rid_did_split);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header.key_addr_hist(), '~thor_data400::key::header::address_rank', '~thor_data400::key::header::'+filedate+'::address_rank',address_rank);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.Key_DMV_restricted(filedate), '~thor_data400::key::header::DMV_restricted', '~thor_data400::key::header::'+filedate+'::DMV_restricted',DMV_restricted);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(InsuranceHeader_xLink.Key_InsuranceHeader_DID,'~thor_data400::key::insuranceheader_xlink::did','~thor_data400::key::insuranceheader_xlink::'+filedate+'::did',ins_did);

//Move to Built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::zip_did','~thor_data400::key::header::'+filedate+'::zip_did',mv_zip);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::zip_did_full','~thor_data400::key::header::'+filedate+'::zip_did_full',mv_zipf);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.ssn.did','~thor_data400::key::header::'+filedate+'::ssn.did',mv_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.phone','~thor_data400::key::header::'+filedate+'::phone',mv_phone);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.st.fname.lname','~thor_data400::key::header::'+filedate+'::st.fname.lname',mv_st_name);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.st.city.fname.lname','~thor_data400::key::header::'+filedate+'::st.city.fname.lname',mv_st_city);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.lname.fname','~thor_data400::key::header::'+filedate+'::lname.fname',mv_name);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.lname.fname_alt','~thor_data400::key::header::'+filedate+'::lname.fname_alt',mv_name_alt);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.zip.lname.fname','~thor_data400::key::header::'+filedate+'::zip.lname.fname',mv_zip_name);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.da','~thor_data400::key::header::'+filedate+'::da',mv_da);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.pname.prange.st.city.sec_range.lname','~thor_data400::key::header::'+filedate+'::pname.prange.st.city.sec_range.lname',mv_addr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.pname.zip.name.range','~thor_data400::key::header::'+filedate+'::pname.zip.name.range',mv_street);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header','~thor_data400::key::header::'+filedate+'::data',mv_data);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header_lookups','~thor_data400::key::header::'+filedate+'::lookups',mv_lookup);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::nbr_address','~thor_data400::key::header::'+filedate+'::nbr_address',mv_nbr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_Data400::key::header_nbr','~thor_data400::key::header::'+filedate+'::nbr',mv_nbr2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_Data400::key::header_nbr_uid','~thor_data400::key::header::'+filedate+'::nbr_uid',mv_nbr_uid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::rid_did','~thor_data400::key::header::'+filedate+'::rid_did',mv_rid_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::rid_did2','~thor_data400::key::header::'+filedate+'::rid_did2',mv_rid2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.did.ssn.date','~thor_data400::key::header::'+filedate+'::did.ssn.date',mv_did_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.county','~thor_data400::key::header::'+filedate+'::county',mv_cnty);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.fname_small','~thor_data400::key::header::'+filedate+'::fname_small',mv_fname_small);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hdr_apt_bldgs','~thor_data400::key::header::'+filedate+'::apt_bldgs',mv_apt);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::address_research','~thor_data400::key::header::'+filedate+'::address_research',mv_addr_rsch);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header_ssn_address','~thor_data400::key::header::'+filedate+'::ssn_address',mv_ssn_addr);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header::@version@::phonetic_lname', '~thor_data400::key::header::'+filedate+'::phonetic_lname', mv_phonetic_lname_key);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.dts.pname.prange.st.city.sec_range.lname','~thor_data400::key::header::dts::'+filedate+'::pname.prange.st.city.sec_range.lname',mv_dts_addr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.dts.pname.zip.name.range','~thor_data400::key::header::dts::'+filedate+'::pname.zip.name.range',mv_dts_street);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.dts.fname_small','~thor_data400::key::header::dts::'+filedate+'::fname_small',mv_dts_fsmall);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.ssn4.did','~thor_data400::key::header::'+filedate+'::ssn4.did',mv_ssn4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.ssn5.did','~thor_data400::key::header::'+filedate+'::ssn5.did',mv_ssn5);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header_address','~thor_data400::key::header::'+filedate+'::address',mv_address_payload);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.parentlnames','~thor_data400::key::header::'+filedate+'::parentlnames',mv_parentlnames);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.zipprlname','~thor_data400::key::header::'+filedate+'::zipprlname',mv_zipprlname);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header::minors','~thor_data400::key::header::'+filedate+'::minors',mv_minors);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.dobname','~thor_data400::key::header::'+filedate+'::dobname',mv_dobname);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hdr_city_name.st.percent_chance','~thor_data400::key::header::'+filedate+'::city_name.st.percent_chance',mv_percent,true);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::addrrisk_geolink','~thor_data400::key::header::'+filedate+'::addrrisk_geolink',mv_addrrisk_geolink);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::max_dt_last_seen','~thor_data400::key::header::'+filedate+'::max_dt_last_seen',mv_max_dt_last_seen);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.ssn4_v2.did','~thor_data400::key::header::'+filedate+'::ssn4_v2.did',mv_ssn4_v2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::aid::RawAID_to_ACECahe','~thor_data400::key::aid::'+filedate+'::RawAID_to_ACECahe',mv_rawaid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.dob_fname','~thor_data400::key::header::'+filedate+'::dob_fname',mv_dob_fname);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.dob_pfname','~thor_data400::key::header::'+filedate+'::dob_pfname',mv_dob_pfname);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.piz_lname_fname','~thor_data400::key::header::'+filedate+'::piz_lname_fname',mv_piz_lname_fname);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.minors_hash','~thor_data400::key::header::'+filedate+'::minors_hash',mv_minors_hash);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.legacy_ssn','~thor_data400::key::header::'+filedate+'::legacy_ssn',mv_legacy_ssn);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.TUCH_dob','~thor_data400::key::header::'+filedate+'::TUCH_dob',mv_TUCH_dob);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::rid_did_split','~thor_data400::key::header::'+filedate+'::rid_did_split',mv_rid_did_split);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header::address_rank','~thor_data400::key::header::'+filedate+'::address_rank',mv_address_rank);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header::DMV_restricted','~thor_data400::key::header::'+filedate+'::DMV_restricted',mv_DMV_restricted);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::insuranceheader_xlink::did','~thor_data400::key::insuranceheader_xlink::'+filedate+'::did',mv_ins_did);

header_key_builds := sequential(
														lookup_pre
														,parallel(
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
														,mv_ins_did
														,parallel(
																mv_rid
																,mv_rid_srid_key
																,mv_zip
																,mv_zipf
																,mv_ssn
																,mv_phone
																,mv_st_name
																,mv_st_city
																,mv_name
																,mv_name_alt
																,mv_zip_name
																,mv_da
																,mv_addr
																,mv_street
																,mv_data
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
																,mv_address_payload
																,mv_parentlnames
																,mv_zipprlname
																,mv_minors
																,mv_dobname
																,mv_percent
																,mv_addrrisk_geolink
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

return if(~pFastHeader and fileservices.getsuperfilesubname('~thor_data400::Base::HeaderKey_Built',1)=fileservices.getsuperfilesubname('~thor_data400::Base::Header',1)
					,output('No Header keys were built.')
					,header_key_builds);

end;