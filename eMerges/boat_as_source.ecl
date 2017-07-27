import header;
d := dataset('~thor_data400::Base::BoatHeader_Building',layout_boats_in,flat);

src_rec := record
 header.Layout_Source_ID;
 layout_boats_in;
end;

header.Mac_Set_Header_Source(d,layout_boats_in,src_rec,'EB',withUID)

export boat_as_source := withUID : persist('persist::headerbuild_boat_src');