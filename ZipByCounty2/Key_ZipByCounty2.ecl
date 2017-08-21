
import doxie, data_services;

ds := ZipByCounty2.File_out_ZipByCounty2;

export Key_ZipByCounty2 := index(ds,{county_name,state_code},{ds},
	'~thor_data400::key::zipbycounty_'+doxie.Version_SuperKey);