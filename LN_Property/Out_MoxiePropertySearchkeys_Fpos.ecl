import LN_property,Lib_KeyLib;
#workunit ('name', 'Build Property Search fpos key');

string_rec := record
	LN_property.Layout_DID_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET('~thor_data400::base::Property_DID', string_rec, THOR);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(LN_property.Layout_DID_Out) * count(h) : global;
headersize := if (sizeof(LN_property.Layout_DID_Out)>215, sizeof(LN_property.Layout_DID_Out), error('too bad')) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},LN_Property.base_key_name + 'property_search.fpos.data_' + LN_Property.version_development);


export Out_MoxiePropertySearchKeys_Fpos	:= buildindex(dfile,moxie);