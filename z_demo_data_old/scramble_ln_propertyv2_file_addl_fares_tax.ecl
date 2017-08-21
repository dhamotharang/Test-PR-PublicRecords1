import demo_data;
import ln_propertyv2;

file_in:= dataset('~thor::base::demo_data_file_ln_propertyv2_file_addl_fares_tax_prodcopy',LN_PropertyV2.layout_addl_fares_tax,flat);

// not sure if needed, null for now

null_ds := dataset([],ln_propertyv2.layout_addl_fares_tax);

export scramble_ln_propertyv2_file_addl_fares_tax := null_ds;
