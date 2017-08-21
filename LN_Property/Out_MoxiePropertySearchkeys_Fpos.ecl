import LN_property,Lib_KeyLib;
#workunit ('name', 'Build Property Search fpos key');

string_rec := record
	LN_property.Layout_Moxie_Deed_Mortgage_Property_Search;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(ln_property.filenames.outSearch, string_rec, THOR, __compressed__);

//filter out DAYTON data
h_filter := h(ln_fares_id[3] <> 'D');
h_dist := distribute(h_filter, random());

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(LN_property.Layout_Moxie_Deed_Mortgage_Property_Search) * count(h) : global;
headersize := if (sizeof(LN_property.Layout_Moxie_Deed_Mortgage_Property_Search)>215, sizeof(LN_property.Layout_Moxie_Deed_Mortgage_Property_Search), error('too bad')) : global;

dfile := INDEX(h_dist,{f:= moxietransform(__filepos, rawsize, headersize)},{h_dist},LN_Property.base_key_name + 'property_search.fpos.data_' + LN_Property.version_build);



export Out_MoxiePropertySearchKeys_Fpos	:= buildindex(dfile, moxie, overwrite);