IMPORT data_services,tris_lnssi_build;

keyname := data_services.Data_location.prefix('tris_lnssi')+
                  'thor_data400::key::tris_lnssi::qa::field_value';

key_ds := dataset([],tris_lnssi_build.layout_key_field_value);

EXPORT key_field_value := INDEX(

    key_ds,
    {Contrib_Risk_field,Contrib_Risk_Value}, 
    {key_ds},
    keyname
    
);

