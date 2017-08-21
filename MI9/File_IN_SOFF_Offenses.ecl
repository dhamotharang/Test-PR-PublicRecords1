import hygenics_soff;

export File_IN_SOFF_Offenses := 
dataset('~thor_data400::persist::hd::sex_offender_crossoffenses', Hygenics_SOff.Layout_Out_Offense_CROSS, flat);
