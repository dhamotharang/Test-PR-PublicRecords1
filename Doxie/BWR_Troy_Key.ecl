import ut;

ut.MAC_SK_BuildProcess(doxie.Key_Troy_Prep,'~thor_data400::key::troy','~thor_data400::key::troy',build_troy);
ut.MAC_SK_BuildProcess(doxie.Key_Troy_Vehicle_Prep,'~thor_data400::key::troy_vehicle','~thor_data400::key::troy_vehicle',build_troy_vehicle);

ut.MAC_SK_Move('~thor_data400::key::troy','Q',move_troy) 
ut.MAC_SK_Move('~thor_data400::key::troy_vehicle','Q',move_troy_vehicle)

export BWR_Troy_Key := sequential(parallel(build_troy, build_troy_vehicle),
                                  parallel(move_troy, move_troy_vehicle));