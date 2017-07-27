import doxie;

flc3v := basefile_flcrash3v;

export key_flcrash3v := index(flc3v
                             ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							 ,{flc3v}
							 ,'~thor_data400::key::flcrash3v_' + doxie.Version_SuperKey);
