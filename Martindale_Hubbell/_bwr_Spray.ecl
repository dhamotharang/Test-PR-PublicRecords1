import _control;
#workunit('name', 'Spray ' + Martindale_Hubbell._Dataset.name + ' Files')

martindale_hubbell.fSprayFiles(
	 pversion			:=	'20100617'
	,pDirectory		:= '/prod_data_build_10/production_data/business_headers/martindale_hubbell/data/20100524'
	,pServerIP		:= _control.IPAddress.edata10
	,pFilename		:= '2*xml'
	,pGroupName		:= martindale_hubbell._dataset().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false		
);                                                                                  
