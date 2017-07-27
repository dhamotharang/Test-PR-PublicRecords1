import _control;

#workunit('name',Martindale_Hubbell._Dataset().Name + ' Build & Despray Extracts');

pversion				:= '20101020b';
pOrgFile				:= Martindale_Hubbell.files().base.Organizations.qa						;
pAffIndivFile		:= Martindale_Hubbell.files().base.Affiliated_Individuals.qa	;
pUnaffIndivFile := Martindale_Hubbell.files().base.Unaffiliated_Individuals.qa;
pServer					:= _control.IPAddress.edata10;
pMount					:= '/prod_data_build_10/production_data/business_headers/martindale_hubbell/extracts/';
pOverwrite			:= true;

sequential(
	 Martindale_Hubbell.Extract_Files2(pversion,pOrgFile,pAffIndivFile,pUnaffIndivFile,,pOverwrite)
	,Martindale_Hubbell.Despray_Extracts(pversion,pServer,pMount,pOverwrite)
);