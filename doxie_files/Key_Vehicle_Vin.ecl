import doxie_build, doxie;

f := File_VehicleVehicles;

export Key_Vehicle_vin := INDEX(f, {svin := orig_vin}, {f.seq_no}, '~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin_'+doxie.Version_SuperKey);