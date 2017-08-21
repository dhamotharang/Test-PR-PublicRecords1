import property,Lib_KeyLib;
#workunit ('name', 'Build Fares 2580 Keys');

string_rec := record
	property.Layout_Fares_Assessor;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(property.Filename_Fares_Assessor, string_rec, THOR);

MyFields := record		
  h.fares_id;
  h.unformatted_apn;
  h.__filepos;
end;

h_dist := distribute(h,random());

t := table(h_dist,MyFields);

kFaresID			:= BUILDINDEX(t,{fares_id,(big_endian unsigned8 )__filepos},
									'key::moxie.fares_2580.fares_id.key', MOXIE, overwrite);
kParcel				:= BUILDINDEX(t,{unformatted_apn,(big_endian unsigned8 )__filepos},
									'key::moxie.fares_2580.parcel.key', MOXIE, overwrite);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(property.Layout_Fares_Assessor) * count(h_dist) : global;
headersize := if (sizeof(property.Layout_Fares_Assessor)>215, sizeof(property.Layout_Fares_Assessor), error('too bad')) : global;

dfile := INDEX(h_dist,{f:= moxietransform(__filepos, rawsize, headersize)},{h_dist},'key::moxie.fares_2580.fpos.data.key');
kFPos				:= BUILDINDEX(dfile,moxie,overwrite);

export Out_MoxieFares2580Keys
 :=
  parallel
	(
	 kFaresID
	,kParcel
	,kFPos
	)
  ;