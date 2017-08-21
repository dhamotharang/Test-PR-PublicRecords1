Import Data_Services, doxie;

flc9 := basefile_flcrash9;

export key_flcrash9 := index(flc9,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{flc9}
							,Data_Services.Data_location.Prefix('FLAcc') +'~thor_data400::key::flcrash9_' + doxie.Version_SuperKey);