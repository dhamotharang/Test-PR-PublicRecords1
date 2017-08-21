import demo_data;
import ln_propertyv2;

file_in:= dataset('~thor::base::demo_data_file_ln_propertyv2_file_addl_fares_deed_prodcopy',LN_PropertyV2.layout_addl_fares_deed,flat);

// not sure if needed, null for now

null_ds := dataset([],ln_propertyv2.layout_addl_fares_deed);

export scramble_ln_propertyv2_file_addl_fares_deed := null_ds;
