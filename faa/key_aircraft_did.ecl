import doxie,ut,Data_Services;

export key_aircraft_did (boolean isFCRA = false) := function

df := searchFile((integer)did_out != 0);

   file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::aircraftreg_did_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::aircraft_reg_did_');
										 
  return index (df, {unsigned6 did := (integer)df.did_out},{n_number, aircraft_id,persistent_record_id},
                file_prefix + doxie.Version_SuperKey);
end; 	
