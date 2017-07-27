import property,Lib_KeyLib;
#workunit ('name', 'Build Fares Search fpos key');

string_rec := record
	property.Layout_prop_out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(property.Filename_Fares_DID_Out, string_rec, THOR);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(property.Layout_prop_out) * count(h) : global;
headersize := if (sizeof(property.Layout_prop_out)>215, sizeof(property.Layout_prop_out), error('too bad')) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},'key::moxie.fares_search.fpos.data.key');

export Out_MoxieFaresSearchKeys_Fpos	:= buildindex(dfile,moxie,overwrite);