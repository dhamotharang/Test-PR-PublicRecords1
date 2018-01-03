import data_services;

f := File_VehicleVehicles_KeyBuilding;

export Key_prep_Vehicle_id := INDEX(f, 
                                    {svid := f.vid}, 
                                    {f.seq_no}, 
                                    data_services.data_location.prefix() + 'thor_data400::key::'+doxie_build.buildstate+'vehicle_id'+thorlib.wuid());