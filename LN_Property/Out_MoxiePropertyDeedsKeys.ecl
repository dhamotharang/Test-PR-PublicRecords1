
import LN_property,LN_Mortgage,Lib_KeyLib;
#workunit ('name', 'Build Property Deeds master Keys');

string_rec := record
	LN_Mortgage.Layout_Moxie_Deed_Mortgage_Common_Model_BASE;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(ln_property.fileNames.outDeeds, string_rec, THOR, __compressed__);

//filter out DAYTON data
h_filter := h(ln_fares_id[3] <> 'D');
h_dist := distribute(h_filter, random());
 
MyFields := record		
  h.ln_fares_id;
  h.fares_unformatted_apn;
  h.__filepos;
end;

t := table(h_dist,MyFields);

kFaresID			:= BUILDINDEX(t(ln_fares_id <> ''),{ln_fares_id,(big_endian unsigned8 )__filepos},
									LN_Property.base_key_name + 'property_deeds.ln_fares_id_' + LN_property.version_build, MOXIE, overwrite);
kParcel				:= BUILDINDEX(t(fares_unformatted_apn <> '') ,{fares_unformatted_apn,(big_endian unsigned8 )__filepos},
									LN_Property.base_key_name + 'property_deeds.parcel_' + LN_property.version_build, MOXIE, overwrite);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(LN_Mortgage.Layout_Moxie_Deed_Mortgage_Common_Model_BASE) * count(h) : global;
headersize := if (sizeof(LN_Mortgage.Layout_Moxie_Deed_Mortgage_Common_Model_BASE)>215, sizeof(LN_Mortgage.Layout_Moxie_Deed_Mortgage_Common_Model_BASE), error('too bad')) : global;

// h_filterDist := distribute(h_filter, hash(ln_fares_id));
// h_filterSort := sort(h_filterDist, ln_fares_id, local);

dfile := INDEX(h_dist,{f:= moxietransform(__filepos, rawsize, headersize)},{h_dist},LN_Property.base_key_name + 'property_deeds.fpos.data_' + LN_property.version_build);
kFPos				:= BUILDINDEX(dfile, moxie, overwrite);

export Out_MoxiePropertyDeedsKeys
 :=
  parallel
	(
	kFaresID,
	kParcel,
	kFPos
	)
  ;