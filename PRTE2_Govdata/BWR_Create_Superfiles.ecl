#workunit('name', 'PRTE BBB Create All Superfiles');

DeleteSupers(string name) := FUNCTION
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'built'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'building'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'prod'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'delete'));
	RETURN 'SUCCESS';
END;


MakeSupers(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'built'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'building'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'prod'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	RETURN 'SUCCESS';
END;



SEQUENTIAL(
	FileServices.DeleteLogicalFile('~prte::base::govdata::fdic'),
	FileServices.DeleteLogicalFile('~prte::base::govdata::irs'),
	FileServices.DeleteLogicalFile('~prte::base::govdata::salestax_ca'),
	FileServices.DeleteLogicalFile('~prte::base::govdata::salestax_ia'),
	FileServices.DeleteLogicalFile('~prte::base::govdata::sec_broker'),
	DeleteSupers('~prte::base::govdata::fdic_@version@'),	
	DeleteSupers('~prte::base::govdata::irs_@version@'),	
	DeleteSupers('~prte::base::govdata::salestax_ca_@version@'),	
	DeleteSupers('~prte::base::govdata::salestax_ia_@version@'),	
	DeleteSupers('~prte::base::govdata::sec_broker_@version@'),	
	DeleteSupers('~prte::base::govdata_@version@'),	
	DeleteSupers('~prte::key::ca_sales_tax_bdid_@version@'),
	DeleteSupers('~prte::key::ca_sales_tax_linkids_@version@'),
	DeleteSupers('~prte::key::govdata_fdic_bdid_@version@'),
	DeleteSupers('~prte::key::govdata_fdic_linkids_@version@'),
	DeleteSupers('~prte::key::ia_sales_tax_bdid_@version@'),
	DeleteSupers('~prte::key::ia_sales_tax_linkids_@version@'),
	DeleteSupers('~prte::key::irs_nonprofit_bdid_@version@'),
	DeleteSupers('~prte::key::irs_nonprofit_linkids_@version@'),
	DeleteSupers('~prte::key::ms_workers_comp_bdid_@version@'),
	DeleteSupers('~prte::key::ms_workers_comp_linkids_@version@'),
	DeleteSupers('~prte::key::or_workers_comp_bdid_@version@'),
	DeleteSupers('~prte::key::or_workers_comp_linkids_@version@'),	
	DeleteSupers('~prte::key::sec_broker_dealer_linkids_@version@'),	
	
	FileServices.CreateSuperFile('~prte::base::govdata::fdic'),
	FileServices.CreateSuperFile('~prte::base::govdata::irs'),
	FileServices.CreateSuperFile('~prte::base::govdata::salestax_ca'),
	FileServices.CreateSuperFile('~prte::base::govdata::salestax_ia'),
	FileServices.CreateSuperFile('~prte::base::govdata::sec_broker'),
	MakeSupers('~prte::base::govdata::fdic_@version@'),	
	MakeSupers('~prte::base::govdata::irs_@version@'),	
	MakeSupers('~prte::base::govdata::salestax_ca_@version@'),	
	MakeSupers('~prte::base::govdata::salestax_ia_@version@'),	
	MakeSupers('~prte::base::govdata::sec_broker_@version@'),	
	MakeSupers('~prte::key::ca_sales_tax_bdid_@version@'),
	MakeSupers('~prte::key::ca_sales_tax_linkids_@version@'),
	MakeSupers('~prte::key::govdata_fdic_bdid_@version@'),
	MakeSupers('~prte::key::govdata_fdic_linkids_@version@'),
	MakeSupers('~prte::key::ia_sales_tax_bdid_@version@'),
	MakeSupers('~prte::key::ia_sales_tax_linkids_@version@'),
	MakeSupers('~prte::key::irs_nonprofit_bdid_@version@'),
	MakeSupers('~prte::key::irs_nonprofit_linkids_@version@'),
	MakeSupers('~prte::key::ms_workers_comp_bdid_@version@'),
	MakeSupers('~prte::key::ms_workers_comp_linkids_@version@'),
	MakeSupers('~prte::key::or_workers_comp_bdid_@version@'),
	MakeSupers('~prte::key::or_workers_comp_linkids_@version@'),	
	MakeSupers('~prte::key::sec_broker_dealer_linkids_@version@'),	
);