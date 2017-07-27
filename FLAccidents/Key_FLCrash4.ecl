import doxie,ut;

flc4 := flc4_Keybuild;

export key_flcrash4 := index(flc4
                            ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{flc4}
							,'~thor_data400::key::flcrash4_'+doxie.Version_SuperKey);
