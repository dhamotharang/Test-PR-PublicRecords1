IMPORT Suppress;

EXPORT Suppress_ReturnOldLayout(ds_in, mod_access, old_layout) := FUNCTIONMACRO
    suppressed_ds := Suppress.MAC_SuppressSource(ds_in, mod_access);
    ds_old_layout := PROJECT(suppressed_ds, TRANSFORM(old_layout,
                                                  SELF := LEFT));
RETURN ds_old_layout;

ENDMACRO;