import property,Lib_KeyLib;
#workunit ('name', 'Build Fares 1080 Keys');

string_rec := record
	property.Layout_Fares_Deeds;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(property.Filename_Fares_Deeds, string_rec, THOR);

MyFields := record		
  h.fares_id;
  h.apn_parcel_number_unformatted;
  h.__filepos;
end;

t := table(h,MyFields);

kFaresID			:= BUILDINDEX(t,{fares_id,(big_endian unsigned8 )__filepos},
									'key::moxie.fares_1080.fares_id.key', MOXIE, overwrite);
kParcel				:= BUILDINDEX(t,{apn_parcel_number_unformatted,(big_endian unsigned8 )__filepos},
									'key::moxie.fares_1080.parcel.key', MOXIE, overwrite);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(property.Layout_Fares_Deeds) * count(h) : global;
headersize := if (sizeof(property.Layout_Fares_Deeds)>215, sizeof(property.Layout_Fares_Deeds), error('too bad')) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},'key::moxie.fares_1080.fpos.data.key');
kFPos				:= BUILDINDEX(dfile,moxie,overwrite);

export Out_MoxieFares1080Keys
 :=
  parallel
	(
	 kFaresID
	,kParcel
	,kFPos
	)
  ;