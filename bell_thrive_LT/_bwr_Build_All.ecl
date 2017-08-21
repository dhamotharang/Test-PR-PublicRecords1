import _control;
pversion						:= '20111116'																									;
pDirectory					:= '/prod_data_build_13/eval_data/bell_thrive/20111108'				;
pServerIP						:= _control.IPAddress.edata10																	;
pFilename						:= 'Sample*csv'																								;
#workunit('name', bell_thrive_LT._Constants().Name + ' Build ' + pversion);
bell_thrive_LT.Build_All(
	 pversion					
	,pDirectory				
	,pServerIP					
	,pFilename					
);
