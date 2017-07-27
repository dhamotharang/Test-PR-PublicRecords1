Import Data_Services, doxie;
df := file_airmen_certificate_bldg;

export key_Certifications := index(df,{uid := df.unique_id},{df},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::airmen_certs_' + doxie.Version_SuperKey);