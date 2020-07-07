IMPORT Suppress, data_services;

EXPORT Suppress_ReturnOldLayout(ds_in, mod_access, old_layout, data_environment = data_services.data_env.iNonFCRA, didfield = 'did', gsidfield = 'global_sid') := FUNCTIONMACRO
    suppressed_ds := Suppress.MAC_SuppressSource(ds_in, mod_access, did_field := didfield, gsid_field := gsidfield, data_env := data_environment);
    ds_old_layout := PROJECT(suppressed_ds, old_layout);
RETURN ds_old_layout;

ENDMACRO;