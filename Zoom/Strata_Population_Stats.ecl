import strata, tools;

export Strata_Population_Stats(

	 string		pversion
	,boolean	pIsTesting = false
	,boolean	pOverwrite = false

) :=
module

	strata.mac_Pops(files().base.qa	,dpops	,'Clean_Company_address.st,record_type'	,,,,,,	
		,['rawfields.Job_Function','rawfields.Person_City','rawfields.Person_State','rawfields.Person_Zip','rawfields.Person_Country'
		,'rawfields.Revenue','rawfields.Employees','raw_aid','ace_aid'],,'Clean_Company_address_|rawfields_',,'clean_person_address'
	);
	strata.mac_Pops(fZoom_As_Business_Header	(files().base.qa)	,dasbhpops	,'source,state'											,,,,,,,['vl_id','rawaid'									]);
	strata.mac_Pops(fZoom_As_Business_Contact	(files().base.qa)	,dasbcpops	,'source,state,record_type,from_hdr',,,,,,,['vl_id','rawaid','company_rawaid'	]);

	Strata.mac_CreateXMLStats(dpops			,_Dataset().Name	,'base_v2',pversion, Email_Notification_Lists().Stats	,PopsOut		, 'View'							,'Population',,pIsTesting,pOverwrite,pShouldExport := true);
	Strata.mac_CreateXMLStats(dasbhpops	,_Dataset().Name	,'data',pversion, Email_Notification_Lists().Stats	,AsBHPopsOut, 'AsBusinessHeader'	,'Population',,pIsTesting,pOverwrite,pShouldExport := true);
	Strata.mac_CreateXMLStats(dasbcpops	,_Dataset().Name	,'data',pversion, Email_Notification_Lists().Stats	,AsBCPopsOut, 'AsBusinessContact'	,'Population',,pIsTesting,pOverwrite,pShouldExport := true);

	
	export all := if(tools.fun_IsValidVersion(pversion),
	sequential(
		 PopsOut		
		,AsBHPopsOut
		,AsBCPopsOut
	));

end;