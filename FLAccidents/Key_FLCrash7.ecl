import doxie;

flc7 := basefile_flcrash7;

export key_flcrash7 := index(flc7
                            ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{flc7}
							,'~thor_data400::key::flcrash7_' + doxie.Version_SuperKey);
