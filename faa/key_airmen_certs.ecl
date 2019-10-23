Import Data_Services, doxie,faa, ut;
export key_airmen_certs(boolean isFCRA = false) := function

df := faa.file_airmen_certificate_bldg;

file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::airmen_certs_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa_airmen_certs_');

//DF-21779 Clear specified fields in thor_data400::key::faa::fcra::airmen_certs_qa
ut.MAC_CLEAR_FIELDS(df, df_cleared, faa.Constants.fields_to_clear_pilot_certificate);

df_new := if (IsFCRA, df_cleared, df);
										
return index(df_new,{uid := df_new.unique_id},{df_new},file_prefix + doxie.Version_SuperKey);

end; 