f := File_VehicleVehicles_KeyBuilding;

export Key_prep_Vehicle_id := INDEX(f, {svid := f.vid}, {f.seq_no}, '~thor_data400::key::'+doxie_build.buildstate+'vehicle_id'+thorlib.wuid());