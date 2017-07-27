import doxie_build,doxie;

f := File_VehicleVehicles;

export Key_Vehicle_id := INDEX(f, {svid := f.vid}, {f.seq_no}, '~thor_data400::key::'+doxie_build.buildstate+'vehicle_id_'+doxie.Version_SuperKey);