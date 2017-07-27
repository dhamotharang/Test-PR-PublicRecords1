import sexoffender;

export File_so_Offenses_keybuilding := 
dataset('~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate + '_BUILDING',
		sexoffender.layout_Common_Offense,flat);