import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::ia_sales_tax');

ut.MAC_SK_BuildProcess_v2(govdata.Key_IA_SalesTax_BDID,'~thor_data400::key::ia_sales_tax_bdid',do1,2);
ut.MAC_SK_Move_v2('~thor_data400::key::ia_sales_tax_bdid','Q',do2,2);

post := ut.SF_MaintBuilt('~thor_data400::base::ia_sales_tax');

export proc_build_ia_salestax_key := sequential(pre,do1,do2,post);
