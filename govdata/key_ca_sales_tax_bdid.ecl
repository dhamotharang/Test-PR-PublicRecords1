Import BIPV2, Data_Services, doxie;

df := project(govdata.File_CA_Sales_Tax_BDID(bdid != 0),
	transform(Layout_CA_Sales_Tax -BIPV2.IDlayouts.l_xlink_ids -source_rec_id,self := left));

export key_ca_sales_tax_bdid := index(df,{bdid},{df},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::ca_sales_tax_bdid_' + doxie.Version_SuperKey);
