import doxie,ut,Data_Services;

export Key_Aircraft_Reg_NNum (boolean isFCRA = false) := function

df := faa.searchFile(n_number != '');

file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::aircraft_reg_nnum_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::aircraft_reg_nnum_');
										
	return index (df, {n_number,aircraft_id},{df},
                file_prefix + doxie.Version_SuperKey);
end;
