import faa,doxie;

df := faa.file_airmen_certificate_out;

export Key_Airmen_Certs := index(df,{uid := df.unique_id},{df},'~thor_data400::key::faa_airmen_certs_' + doxie.Version_SuperKey);