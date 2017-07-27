f := File_VehicleVehicles_KeyBuilding;

export Key_Prep_Vehicle_vin := INDEX(f, {svin := orig_vin}, {f.seq_no}, '~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin'+thorlib.wuid());