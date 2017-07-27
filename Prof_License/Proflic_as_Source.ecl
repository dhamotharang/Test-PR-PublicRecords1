import header;
d := dataset('~thor_data400::Base::ProfLicHeader_Building',layout_proflic_out,flat);

src_rec := record
 header.Layout_Source_ID;
 layout_proflic_out;
end;

header.Mac_Set_Header_Source(d,layout_proflic_out,src_rec,'PL',withUID)

export Proflic_as_Source := withUID : persist('persist::headerbuild_prof_src');