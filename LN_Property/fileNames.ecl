export fileNames := module

  export  cluster           := '~thor_data400';

  // export inSprayedAssessor  := '::in::ln_fares::sprayed::assessor'; 
  // export inSprayedDeeds     := '::in::ln_fares::sprayed::deed';	
	// export inSprayedSearch    := '::in::ln_fares::sprayed::search';
  // export inSprayedAddlNames := '::in::ln_fares::sprayed::addl_names';	 	
	
	export inAssessor         := cluster + '::in::ln_property::assessor';	
	export inDeeds            := cluster + '::in::ln_property::deed';
	export inSearch           := cluster + '::in::ln_property::search';
	export inAddlNames        := cluster + '::in::ln_property::addl_names';
	export inAssessorRepl     := cluster + '::in::ln_property::assessor_repl';	
	export inDeedsRepl        := cluster + '::in::ln_property::deed_repl';
	export inSearchRepl       := cluster + '::in::ln_property::search_repl';
	export inAddlNamesRepl    := cluster + '::in::ln_property::addl_names_repl';	
	
	export versionedKeyAssessor_fid       := cluster + '::key::ln_property::@version@::assessor.fid'; 
	export versionedKeySearch_did         := cluster + '::key::ln_property::@version@::search_did'; 
	export versionedKeyAddlnames_fid      := cluster + '::key::ln_property::@version@::addlnames.fid'; 
	export versionedKeyAssessor_parcelnum := cluster + '::key::ln_property::@version@::assessor_parcelnum'; 
	export versionedKeyBdid               := cluster + '::key::ln_property::@version@::bdid'; 
	export versionedKeyDeed_fid           := cluster + '::key::ln_property::@version@::deed.fid'; 
	export versionedKeydeed_parcelnum     := cluster + '::key::ln_property::@version@::deed_parcelnum'; 
	export versionedKeySearch_fid_county  := cluster + '::key::ln_property::@version@::search.fid_county'; 
	export versionedKeyAddr_search_fid    := cluster + '::key::ln_property::@version@::addr_search.fid'; 
	export versionedKeySearch_fid         := cluster + '::key::ln_property::@version@::search.fid'; 
	export versionedKey_Prop_Address      := cluster + '::key::ln_property::@version@::addr.full'; 
	export versionedKey_Prop_Ownership    := cluster + '::key::ln_property::@version@::did.ownership'; 

  //FCRA keys
	export versionedKeyAssessor_fid_fcra       := cluster + '::key::ln_property::fcra::@version@::assessor.fid'; 
	export versionedKeySearch_did_fcra         := cluster + '::key::ln_property::fcra::@version@::search_did'; 
	export versionedKeySearch_fid_county_fcra  := cluster + '::key::ln_property::fcra::@version@::search.fid_county';
	export versionedKeySearch_bdid_fcra		   := cluster + '::key::ln_property::fcra::@version@::bdid';
	export versionedKeyDeed_fid_fcra           := cluster + '::key::ln_property::fcra::@version@::deed.fid';
	export versionedKeyAddlNames_fid_fcra 	   := cluster + '::key::ln_property::fcra::@version@::addlnames.fid';
	export versionedKeyAddr_search_fid_fcra    := cluster + '::key::ln_property::fcra::@version@::addr_search.fid'; 
	export versionedKeySearch_fid_fcra         := cluster + '::key::ln_property::fcra::@version@::search.fid'; 
	export versionedKey_Prop_Address_fcra      := cluster + '::key::ln_property::fcra::@version@::addr.full'; 
	export versionedKey_Prop_Ownership_fcra    := cluster + '::key::ln_property::fcra::@version@::did.ownership';

	export versionedBaseAssessor    := cluster + '::base::ln_property::@version@::assessor'; 
	export versionedBaseDeed        := cluster + '::base::ln_property::@version@::deed'; 
	export versionedBaseSearch      := cluster + '::base::ln_property::@version@::search'; 
	export versionedBaseAddlNames   := cluster + '::base::ln_property::@version@::addl_names'; 
	export versionedBasePropertyDID := cluster + '::base::ln_property::@version@::property_did'; 
	
	export versionedOutAssessor     := cluster + '::out::ln_property::@version@::assessor'; 
	export versionedOutDeed         := cluster + '::out::ln_property::@version@::deed'; 
	export versionedOutAddlNames    := cluster + '::out::ln_property::@version@::addl_names'; 	
	export versionedOutSearch       := cluster + '::out::ln_property::@version@::search'; 
		
	export builtAssessor    := cluster + '::base::ln_property::built::assessor';
	export builtDeeds       := cluster + '::base::ln_property::built::deed';
	export builtSearch      := cluster + '::base::ln_property::built::search';
	export builtAddlNames   := cluster + '::base::ln_property::built::addl_names';
	export builtPropertyDID := cluster + '::base::ln_property::built::property_did';			
	
	export qaAssessor    := cluster + '::base::ln_property::qa::assessor';
	export qaDeeds       := cluster + '::base::ln_property::qa::deed';
	export qaSearch      := cluster + '::base::ln_property::qa::search';
	export qaAddlNames   := cluster + '::base::ln_property::qa::addl_names';
	export qaPropertyDID := cluster + '::base::ln_property::qa::property_did';	
	
	export prodAssessor    := cluster + '::base::ln_property::prod::assessor';
	export prodDeeds       := cluster + '::base::ln_property::prod::deed';
	export prodSearch      := cluster + '::base::ln_property::prod::search';
	export prodAddlNames   := cluster + '::base::ln_property::prod::addl_names';	
	export prodPropertyDID := cluster + '::base::ln_property::prod::property_did';	
	
	export outAssessor    := cluster + '::out::ln_property::built::assessor';
	export outDeeds       := cluster + '::out::ln_property::built::deed';
	export outSearch      := cluster + '::out::ln_property::built::search';
	export outAddlNames   := cluster + '::out::ln_property::built::addl_names';	
	
export moxieKey_assessor_fpos_data 
  := cluster + '::key::built::moxie.property_assessor.fpos.data';
export moxieKey_assessor_ln_fares_id 
  := cluster + '::key::built::moxie.property_assessor.ln_fares_id';
export moxieKey_assessor_parcel 
  := cluster + '::key::built::moxie.property_assessor.parcel';
export moxieKey_deeds_fpos_data 
  := cluster + '::key::built::moxie.property_deeds.fpos.data';
export moxieKey_deeds_ln_fares_id 
  := cluster + '::key::built::moxie.property_deeds.ln_fares_id';
export moxieKey_deeds_parcel 
  := cluster + '::key::built::moxie.property_deeds.parcel';
export moxieKey_deeds_supplemental_fpos_data 
  := cluster + '::key::built::moxie.property_deeds_supplemental.fpos.data';
export moxieKey_deeds_supplemental_ln_fares_id 
  := cluster + '::key::built::moxie.property_deeds_supplemental.ln_fares_id';
export moxieKey_deeds_supplemental_parcel 
  := cluster + '::key::built::moxie.property_deeds_supplemental.parcel';
export moxieKey_search_cn_fid 
  := cluster + '::key::built::moxie.property_search.cn.fid';
export moxieKey_search_did 
  := cluster + '::key::built::moxie.property_search.did';
export moxieKey_search_fid_sourceCode_streetName_predir_postdir_primRrange_suffix_secRange_unitDesig_city2_st_z5_z4_county 
  := cluster + '::key::built::moxie.property_search.fid.source_code.street_name.predir.postdir.prim_range.suffix.sec_range.unit_desig.city2.st.z5.z4.county';
export moxieKey_search_fid 
  := cluster + '::key::built::moxie.property_search.fid';
export moxieKey_search_fpos_data 
  := cluster + '::key::built::moxie.property_search.fpos.data';
export moxieKey_search_lfmname 
  := cluster + '::key::built::moxie.property_search.lfmname';
export moxieKey_search_nameasis 
  := cluster + '::key::built::moxie.property_search.nameasis';
export moxieKey_search_st_city_cn_fid 
  := cluster + '::key::built::moxie.property_search.st.city.cn.fid';
export moxieKey_search_st_city_lfmname 
  := cluster + '::key::built::moxie.property_search.st.city.lfmname';
export moxieKey_search_st_city_nameasis 
  := cluster + '::key::built::moxie.property_search.st.city.nameasis';
export moxieKey_search_st_cn_fid 
  := cluster + '::key::built::moxie.property_search.st.cn.fid';
export moxieKey_search_st_lfmname 
  := cluster + '::key::built::moxie.property_search.st.lfmname';
export moxieKey_search_st_nameasis 
  := cluster + '::key::built::moxie.property_search.st.nameasis';
export moxieKey_search_z5_lfmname 
  := cluster + '::key::built::moxie.property_search.z5.lfmname';
export moxieKey_search_z5_primName_primRange_lfmname 
  := cluster + '::key::built::moxie.property_search.z5.prim_name.prim_range.lfmname';
export moxieKey_search_z5_streetName_predir_postdir_primRange_suffix_lname_secRange_fid_sourceCode_lfmname 
  := cluster + '::key::built::moxie.property_search.z5.street_name.predir.postdir.prim_range.suffix.lname.sec_range.fid.source_code.lfmname';
export moxieKey_search_processDate_st_lfmname 
  := cluster + '::key::built::moxie.property_search.process_date.st.lfmname';

end;