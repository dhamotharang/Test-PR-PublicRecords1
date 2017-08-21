export fileProcessI_BuildMoxieKeys := function



sequential(
fileservices.clearsuperfile(ln_property.filenames.moxieKey_assessor_fpos_data, 1), 
fileservices.clearsuperfile(ln_property.filenames.moxieKey_assessor_ln_fares_id, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_assessor_parcel, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_fpos_data, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_ln_fares_id, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_parcel, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_supplemental_fpos_data, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_supplemental_ln_fares_id, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_supplemental_parcel, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_cn_fid, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_did, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_fid_sourceCode_streetName_predir_postdir_primRrange_suffix_secRange_unitDesig_city2_st_z5_z4_county, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_fid, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_fpos_data, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_lfmname, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_nameasis, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_st_city_cn_fid, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_st_city_lfmname, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_st_city_nameasis, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_st_cn_fid, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_st_lfmname, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_st_nameasis, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_z5_lfmname, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_z5_primName_primRange_lfmname, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_z5_streetName_predir_postdir_primRange_suffix_lname_secRange_fid_sourceCode_lfmname, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_search_processDate_st_lfmname, 1),
ln_property.Out_MoxiePropertyPostKeys
);


return 'BuildMoxieKeys complete';
end;