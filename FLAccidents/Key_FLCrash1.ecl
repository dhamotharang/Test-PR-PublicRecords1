import doxie;

flc1 := basefile_flcrash1;

export key_flcrash1 := index(flc1
                            ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{flc1}
							,'~thor_data400::key::flcrash1_' + doxie.Version_SuperKey);