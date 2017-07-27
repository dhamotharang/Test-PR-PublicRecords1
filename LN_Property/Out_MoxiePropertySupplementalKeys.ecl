import LN_property,LN_Mortgage,Lib_KeyLib;
#workunit ('name', 'Build Property Deeds Supplemental Keys');

string_rec := record
	LN_Mortgage.Layout_Addl_Names;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET('~thor_data400::base::property_addl_names', string_rec, THOR);

MyFields := record		
  h.ln_fares_id;
  h.apnt_or_pin_number;
  h.__filepos;
end;

t := table(h,MyFields);

kFaresID			:= BUILDINDEX(t(ln_fares_id <> ''),{ln_fares_id,(big_endian unsigned8 )__filepos},
									LN_Property.base_key_name + 'property_deeds_supplemental.ln_fares_id_'+ LN_Property.version_development, MOXIE);

kParcel				:= BUILDINDEX(t(apnt_or_pin_number <> ''),{apnt_or_pin_number,(big_endian unsigned8 )__filepos},
									LN_Property.base_key_name + 'property_deeds_supplemental.parcel_'+ LN_Property.version_development, MOXIE);
									
unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(LN_Mortgage.Layout_Addl_Names) * count(h) : global;
headersize := if (sizeof(LN_Mortgage.Layout_Addl_Names)>215, sizeof(LN_Mortgage.Layout_Addl_Names), error('too bad')) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},LN_Property.base_key_name + 'property_deeds_supplemental.fpos.data_' + LN_Property.version_development);
kFPos				:= BUILDINDEX(dfile,moxie);

export Out_MoxiePropertySupplementalKeys
 :=
  parallel
	(
	 kFaresID
	,kParcel
	,kFPos
	)
  ;