import header;
d := dataset('~thor_data400::base::emergesHeader_Building',layout_emerge_in,flat);

src_rec := record
 header.Layout_Source_ID;
 layout_emerge_in;
end;

header.Mac_Set_Header_Source(d,layout_emerge_in,src_rec,'EM',withUID)

export Master_as_Source := withUID : persist('persist::headerbuild_emerges_src');