import LN_property,LN_Mortgage,Lib_KeyLib;
#workunit ('name', 'Build Property Deeds Supplemental Keys');

string_rec := record
	LN_Mortgage.Layout_Moxie_Addl_Names;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(ln_property.fileNames.outAddlNames, string_rec, THOR,__compressed__);

//filter out DAYTON data
h_filter := h(ln_fares_id[3] <> 'D');
h_dist := distribute(h_filter, random());

MyFields := record		
  h.ln_fares_id;
  h.apnt_or_pin_number;
  h.__filepos;
end;

t := table(h_dist,MyFields);


DFaresID			:= INDEX(t(ln_fares_id <> ''),{ln_fares_id,(big_endian unsigned8 )__filepos},
									LN_Property.base_key_name + 'property_deeds_supplemental.ln_fares_id_'+ LN_Property.version_build);

kFaresID			:= BUILDINDEX(DFaresID, MOXIE, overwrite);

DParcel				:= INDEX(t(apnt_or_pin_number <> ''),{apnt_or_pin_number,(big_endian unsigned8 )__filepos},
									LN_Property.base_key_name + 'property_deeds_supplemental.parcel_'+ LN_Property.version_build);

kParcel				:= BUILDINDEX(DParcel, MOXIE, overwrite);
									
unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(LN_Mortgage.Layout_Addl_Names) * count(h) : global;
headersize := if (sizeof(LN_Mortgage.Layout_Addl_Names)>215, sizeof(LN_Mortgage.Layout_Addl_Names), error('too bad')) : global;

dfile := INDEX(h_dist,{f:= moxietransform(__filepos, rawsize, headersize)},{h_dist},LN_Property.base_key_name + 'property_deeds_supplemental.fpos.data_' + LN_Property.version_build);
kFPos				:= BUILDINDEX(dfile, moxie, overwrite);

export Out_MoxiePropertySupplementalKeys
 :=
  parallel
	(
	 kFaresID
	,kParcel
	,kFPos
	)
  ;