import data_services;

df := file_airmen_certificate_bldg;

export key_prep_certifications := index(df,
                                        {uid := df.unique_id},
                                        {df},
                                        data_services.data_location.prefix() + 'thor_data400::key::airmen_certs' + thorlib.wuid());