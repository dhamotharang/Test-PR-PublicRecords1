import LN_property,Lib_KeyLib;
#workunit ('name', 'Build Property Assessor Master Keys');

string_rec := record
	LN_property.Layout_Moxie_Property_Common_Model_BASE;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(ln_property.fileNames.outAssessor, string_rec, THOR,__compressed__);

//filter out DAYTON data
h_filter := h(ln_fares_id[3] <> 'D'); 
h_dist := distribute(h_filter, random());

MyFields := record		
  h.ln_fares_id;
  h.fares_unformatted_apn;
  h.__filepos;
end;

t := table(h_dist,MyFields);

//filter out DAYTON data

kFaresID := BUILDINDEX(t(ln_fares_id <> ''),{ln_fares_id,(big_endian unsigned8 )__filepos},
									LN_Property.base_key_name + 'property_assessor.ln_fares_id_' + LN_Property.version_build, MOXIE, overwrite);
kParcel  := BUILDINDEX(t(fares_unformatted_apn <> ''),{fares_unformatted_apn,(big_endian unsigned8 )__filepos},
									LN_Property.base_key_name + 'property_assessor.parcel_'+ LN_Property.version_build, MOXIE, overwrite);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(LN_property.Layout_Moxie_Property_Common_Model_BASE) * count(h) : global;
headersize := if(sizeof(LN_property.Layout_Moxie_Property_Common_Model_BASE)>215, sizeof(LN_property.Layout_Moxie_Property_Common_Model_BASE), error('too bad')) : global;

dfile := INDEX(h_filter,{f:= moxietransform(__filepos, rawsize, headersize)},{h_filter},LN_Property.base_key_name + 'property_assessor.fpos.data_' + LN_Property.version_build);
kFPos				:= BUILDINDEX(dfile,moxie, overwrite);


export Out_MoxiePropertyAssessorKeys
 :=
  parallel
	(
	 kFaresID
	,kParcel
	,kFPos
	)
  ;