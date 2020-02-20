Import Data_Services, doxie,ut, vault, _control;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_aircraft_id(boolean isFCRA = false) := vault.faa.key_aircraft_id(isFCRA);
#ELSE
export key_aircraft_id(boolean isFCRA = false) := function

df := faa.searchFile_Linkids;

  file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::aircraft_id_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_Data400::key::aircraft_id_');
										 
  return index(df,{aircraft_id},{df},
                file_prefix + doxie.Version_SuperKey);
end;
#END;


 	


