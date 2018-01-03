import doxie,doxie_build, data_services;

f := File_VehicleVehicles;

export Key_Vehicle_tag := INDEX(f, 
                                {stag := LICENSE_PLATE_NUMBERxBG4,orig_state}, 
                                {f.seq_no}, 
                                data_services.data_location.prefix() + 'thor_data400::key::'+doxie_build.buildstate+'vehicle_tag_'+doxie.Version_SuperKey);