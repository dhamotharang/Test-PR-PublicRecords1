import doxie;

flc6 := basefile_flcrash6;

export key_flcrash6 := index(flc6
                            ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{flc6}
							,'~thor_data400::key::flcrash6_' + doxie.Version_SuperKey);
