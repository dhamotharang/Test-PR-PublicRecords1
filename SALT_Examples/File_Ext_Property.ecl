IMPORT SALT_Examples;
Layout_Ext_Property := RECORD
string12 ln_fares_id;
SALT_Examples.Layout_Sample;
end;
EXPORT File_Ext_Property := dataset('~salt_demo::sample_ext_property',Layout_Ext_Property,THOR);
