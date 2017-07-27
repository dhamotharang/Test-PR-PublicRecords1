import doxie;

flc8 := basefile_flcrash8;

export key_flcrash8 := index(flc8
                            ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{flc8}
							,'~thor_data400::key::flcrash8_' + doxie.Version_SuperKey);
