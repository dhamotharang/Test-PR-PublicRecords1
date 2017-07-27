import ut;

pre := ut.sf_maintbuilding('~thor_data400::base::ca_sales_tax_bdid');

ut.MAC_SK_BuildProcess_v2(govdata.key_ca_sales_tax_bdid,'~thor_data400::key::ca_sales_tax_bdid',do1);
ut.mac_sk_move_v2('~thor_data400::key::ca_sales_tax_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_data400::base::ca_sales_tax_bdid');

export proc_build_ca_sales_tax_key := sequential(pre,do1,do2,post);
