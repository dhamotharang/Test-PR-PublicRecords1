import header,ut;
f := dataset('~thor_data400::BASE::DLHeader_Building',drivers.layout_dl,flat,unsorted);

src_rec := record
 header.Layout_Source_ID;
 drivers.layout_dl;
end;

header.Mac_Set_Header_Source(f,drivers.layout_dl,src_rec,header_src(l.source_code,l.orig_state),withUID)

export DLs_as_Source := withUID : persist('persist::headerbuild_dl_src');