import header;
in_file := dataset('~thor_data400::BASE::PropDeedHeader_Building',property.Layout_Fares_Deeds,flat);

src_rec := record 
 header.Layout_Source_ID;
 property.Layout_Fares_Deeds;
end;

header.Mac_Set_Header_Source(in_file,property.Layout_Fares_Deeds,src_rec,'FP',withUID)

export Deed_as_Source := withUID : persist('persist::headerbuild_deed_src');