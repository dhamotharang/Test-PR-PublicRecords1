export dkc_files := function   

  import LN_Property;
  
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_assessor.fpos.data_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT + 'property_assessor.fpos.data.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_assessor.ln_fares_id_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_assessor.ln_fares_id.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_assessor.parcel_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_assessor.parcel.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds.fpos.data_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_deeds.fpos.data.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds.ln_fares_id_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_deeds.ln_fares_id.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds.parcel_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_deeds.parcel.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.fpos.data_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_2 + 'property_search.fpos.data.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.cn.fid_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_search.cn.fid.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.did_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_search.did.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.fid.source_code.street_name.predir.postdir.prim_range.suffix.sec_range.unit_desig.city2.st.z5.z4.county_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_search.fid.source_code.street_name.predir.postdir.prim_range.suffix.sec_range.unit_desig.cty2.st.z5.z4.county.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.fid_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_search.fid.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.lfmname_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_search.lfmname.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.nameasis_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_search.nameasis.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.st.city.cn.fid_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_search.st.city.cn.fid.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.st.city.lfmname_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_search.st.city.lfmname.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.st.city.nameasis_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_2 + 'property_search.st.city.nameasis.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.st.cn.fid_' + ln_property.version_build, LN_property.MOXIE_DKC_Server,  LN_property.MOXIE_MOUNT + 'property_search.st.cn.fid.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.st.lfmname_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT + 'property_search.st.lfmname.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.st.nameasis_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT + 'property_search.st.nameasis.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.z5.lfmname_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT + 'property_search.z5.lfmname.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.z5.prim_name.prim_range.lfmname_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT + 'property_search.z5.prim_name.prim_range.lfmname.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.z5.street_name.predir.postdir.prim_range.suffix.lname.sec_range.fid.source_code.lfmname_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_2 + 'property_search.z5.street_name.predir.postdir.prim_range.suffix.lname.sec_range.fid.source_code.lfmname.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_search.process_date.st.lfmname_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT_1 + 'property_search.process_date.st.lfmname.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds_supplemental.fpos.data_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT + 'property_deeds_supplemental.fpos.data.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds_supplemental.ln_fares_id_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT + 'property_deeds_supplemental.ln_fares_id.key');
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds_supplemental.parcel_' + ln_property.version_build, LN_property.MOXIE_DKC_Server, LN_property.MOXIE_MOUNT + 'property_deeds_supplemental.parcel.key');
	
	fileServices.sendemail('kimberly.rolston@lexisnexis.com', 'LN Property Build Completed', 'LN Property Build version ' + ln_property.version_build + ' put in development for QA testing');

return 'Built DKC files';

end;