import LN_Property,LN_mortgage,ut;

export bwr_moxie_property(string filedate) := function

// *************** Change LN_Property.version_build ******************** //
DestinationIP := 'edata12-bld.br.seisint.com';
DestinationVolume := '/thor_back5/local_data/demo/property/';

propertydeeds := dataset([],LN_Mortgage.Layout_Moxie_Deed_Mortgage_Common_Model_BASE);
propertysuppl := 	dataset([],LN_Mortgage.Layout_Moxie_Addl_Names);

deeds := output(propertydeeds,,ln_property.fileNames.outDeeds,overwrite);

suppl := output(propertysuppl,,ln_property.fileNames.outAddlNames,overwrite);

BuildMoxiePropertyKeys := sequential(
deeds,
suppl,
// LN_Property.Out_MoxiePropertyAssessorKeys,

LN_Property.Out_MoxiePropertyDeedsKeys,

// LN_Property.Out_MoxiePropertySearchkeys_Fpos,

// LN_Property.Out_MoxiePropertySearchKeys_Part1,

// LN_Property.Out_MoxiePropertySearchKeys_Part2,

LN_Property.Out_MoxiePropertySupplementalKeys

// LN_Property.Out_MoxiePropertySearchKeys_Part3

);

Keys_DKC :=  sequential(fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds.fpos.data_' + LN_Property.version_build, DestinationIP, DestinationVolume + 'property_deeds.fpos.data.key'),
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds.ln_fares_id_' + LN_Property.version_build, DestinationIP, DestinationVolume + 'property_deeds.ln_fares_id.key'),
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds.parcel_' + LN_Property.version_build, DestinationIP, DestinationVolume + 'property_deeds.parcel.key'),
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds_supplemental.fpos.data_' + LN_Property.version_build, DestinationIP, DestinationVolume + 'property_deeds_supplemental.fpos.data.key'),
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds_supplemental.ln_fares_id_' + LN_Property.version_build, DestinationIP, DestinationVolume + 'property_deeds_supplemental.ln_fares_id.key'),
  fileservices.dkc(LN_Property.Cluster_thor + 'key::moxie.property_deeds_supplemental.parcel_' + LN_Property.version_build, DestinationIP, DestinationVolume + 'property_deeds_supplemental.parcel.key'));
	


result := sequential(
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_fpos_data, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_ln_fares_id, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_parcel, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_supplemental_fpos_data, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_supplemental_ln_fares_id, 1),
fileservices.clearsuperfile(ln_property.filenames.moxieKey_deeds_supplemental_parcel, 1),
BuildMoxiePropertyKeys,
Keys_DKC
);

return result;

end;
