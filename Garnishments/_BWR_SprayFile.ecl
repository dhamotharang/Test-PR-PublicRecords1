import _control;

Garnishments.fSprayFiles(
	 '20100901'                       																		//,string		pversion
	,'/prod_data_build_10/production_data/business_headers/garnishments/' //,string		pDirectory
	,_control.IPAddress.edata10																						//
	,'*ADD'                                 															//,string		pFilename
	,Garnishments._dataset().groupname			  														//,string		pGroupName	= 'thor_dell400'
	,false                            																		//,boolean	pIsTesting	= false
	,false		
	,Garnishments._Dataset().max_record_size        
);
