// Propagate Officer Field
export MAC_POF(field_name) := macro
self.field_name := IF(R.officer1_name <> '' OR R.officer1_city <> '' OR
                      R.officer2_name <> '' OR R.officer2_city <> '' OR
                      R.officer3_name <> '' OR R.officer3_city <> '' OR
                      R.officer4_name <> '' OR R.officer4_city <> '' OR
                      R.officer5_name <> '' OR R.officer5_city <> '',
                      R.field_name, L.field_name);
endmacro;