import header,ut;
v := dataset('~thor_data400::BASE::VehiclesHeader_Building',layout_vehicles,flat,unsorted)(veh_type!='VS');

src_rec := record
 header.Layout_Source_ID;
 layout_vehicles;
end;

header.Mac_Set_Header_Source(v,layout_vehicles,src_rec,header_src(l.orig_state,l.source_code),withID)

export Vehicles_as_Source := distribute(withID,hash(uid)) : persist('persist::headerbuild_veh_src');