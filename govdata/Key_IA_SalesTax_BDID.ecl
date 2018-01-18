import doxie, BIPV2, data_services;

df := project(govdata.File_IA_Sales_Tax_In(bdid != 0),
							transform(govdata.Layout_IA_Sales_Tax_In-BIPV2.IDlayouts.l_xlink_ids,self := left));

export Key_IA_SalesTax_BDID := index(df,{bdid},{df},data_services.data_location.prefix() + 'thor_data400::key::ia_sales_tax_bdid_' + doxie.Version_SuperKey);
