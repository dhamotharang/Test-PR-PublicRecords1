Import Data_Services, doxie,faa;
export key_airmen_certs(boolean isFCRA = false) := function

df := faa.file_airmen_certificate_bldg;

file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::airmen_certs_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa_airmen_certs_');

return index(df,{uid := df.unique_id},{df},file_prefix + doxie.Version_SuperKey);

end; 