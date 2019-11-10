IMPORT Suppress, data_services;

EXPORT Suppress_ReturnOldLayout(ds_in, mod_access, old_layout, data_environment = data_services.data_env.iNonFCRA) := FUNCTIONMACRO
    suppressed_ds := Suppress.MAC_SuppressSource(ds_in, mod_access, data_env := data_environment);
    ds_old_layout := PROJECT(suppressed_ds, TRANSFORM(old_layout,
                                                  SELF := LEFT));
RETURN ds_old_layout;

ENDMACRO;