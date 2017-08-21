import _control;
#workunit('name', 'Spray ' + Liquor_Licenses._Dataset.name + ' Files')


Liquor_Licenses.macSprayFiles(
	 _control.IPAddress.bctlpedata11
	,'/data/prod_data_build_10/production_data/business_headers/wither/updating/liquor/ca/20070215'
	,'m_tape911.SEISINT'
	,CA
	,'20070215'
);

Liquor_Licenses.macSprayFiles(
	 _control.IPAddress.bctlpedata11
	,'/data/prod_data_build_10/production_data/business_headers/wither/updating/liquor/oh/20061013'
	,'oh_20061013.d00'
	,OH
	,'20061013'
);

Liquor_Licenses.macSprayFiles(
	 _control.IPAddress.bctlpedata11
	,'/data/prod_data_build_10/production_data/business_headers/wither/updating/liquor/tx/20070404'
	,'tx_20070404.d00'
	,TX
	,'20070404'
);

Liquor_Licenses.macSprayFiles(
	 _control.IPAddress.bctlpedata11
	,'/data/prod_data_build_10/production_data/business_headers/wither/updating/liquor/pa'
	,'total_20070618.txt'
	,PA
	,'20070618'
);