import header;
d := dataset('~thor_data400::base::LiensHeader_Building',bankrupt.Layout_Liens,flat);

src_rec := record
 header.Layout_Source_ID;
 layout_liens;
end;

header.Mac_Set_Header_Source(d(~(indivbusun='B' or aka_yn = 'B')),bankrupt.Layout_Liens,src_rec,'LI',withUID)

export Liens_as_Source := withUID : persist('persist::headerbuild_liens_src');