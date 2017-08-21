f := File_VehicleVehicles_keybuilding;

export Key_prep_Vehicle_tag := INDEX(f, 
{stag := LICENSE_PLATE_NUMBERxBG4,orig_state}, 
{f.seq_no},  
'~thor_data400::key::'+doxie_build.buildstate+'vehicle_tag'+thorlib.wuid());