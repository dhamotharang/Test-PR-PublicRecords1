import doxie_build;

rec :=
RECORD
	DriversV2.Layout_Drivers;
END;

export File_DL_KeyBuilding := dataset('~thor_data400::base::DL2::DLSearch_'+doxie_build.buildstate + '_BUILDING', rec, flat);