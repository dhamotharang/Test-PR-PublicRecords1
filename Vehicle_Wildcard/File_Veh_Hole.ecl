import doxie_build, doxie_files;

export File_Veh_Hole := dataset('~thor_data400::hole::wildcard_' + doxie_build.buildstate, layout_hole_veh, THOR, preload(0));