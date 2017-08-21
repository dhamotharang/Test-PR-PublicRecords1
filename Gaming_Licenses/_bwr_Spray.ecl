import _control, versioncontrol;
#workunit('name', 'Spray ' + Gaming_Licenses._Dataset.name + ' Files')


Gaming_Licenses.macSprayFiles(
	 _control.IPAddress.edata10
	,'/prod_data_build_10/production_data/business_headers/gaming_licenses/nj'
	,'*csv'
	,NJ
	,'20080129'
	,nj_spray
);

nj_spray;
