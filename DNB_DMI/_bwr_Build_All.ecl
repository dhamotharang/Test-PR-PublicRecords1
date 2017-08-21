import _control;

pversion						:= '20110401'																									;
pDirectory					:= '/prod_data_build_10/production_data/business_headers/dnb/';
pServerIP						:= _control.IPAddress.edata10																	;
pFilename						:= 'DMI*'																											;

#workunit('name', DNB_DMI._Constants().Name + ' Build ' + pversion);

DNB_DMI.Build_All(
	 pversion					
	,pDirectory				
	,pServerIP					
	,pFilename					
);
