import header,vehlic,RoxieKeybuild;

export proc_troy_keys(string filedate) := function

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Troy_Prep,'~thor_data400::key::troy','~thor_data400::key::header::'+filedate+'::troy',build_troy);
//RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Troy_Vehicle_Prep,'~thor_data400::key::troy_vehicle','~thor_data400::key::header::'+filedate+'::troy_vehicle',build_troy_vehicle);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::troy','~thor_data400::key::header::'+filedate+'::troy',move_troy) 
//RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::troy_vehicle','~thor_data400::key::header::'+filedate+'::troy_vehicle',move_troy_vehicle)

return sequential(parallel(build_troy/*, build_troy_vehicle*/),
                                    parallel(move_troy/*, move_troy_vehicle*/));
									
end;