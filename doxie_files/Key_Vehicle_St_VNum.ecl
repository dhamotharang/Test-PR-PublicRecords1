import doxie_build, doxie, data_services;

f := File_VehicleVehicles;

export Key_Vehicle_St_VNum := 
       INDEX(f, 
             {o_st := orig_state,v_num := VEHICLE_NUMBERxBG1}, 
	           {f.seq_no}, 
	           data_services.data_location.prefix() + 'thor_data400::key::'+doxie_build.buildstate+'vehicle_st_vnum_'+doxie.Version_SuperKey,OPT);