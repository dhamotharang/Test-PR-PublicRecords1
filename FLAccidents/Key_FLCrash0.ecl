import doxie;

flc0 := basefile_flcrash0;

export key_flcrash0 := index(flc0
                            ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{flc0}
							,'~thor_data400::key::flcrash0_' + doxie.Version_SuperKey);
						 	 