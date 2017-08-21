import _control;
pversion						:= '20110401'																						;
pDirectory					:= '/prod_data_build_13/eval_data/bell_thrive/20110902'	;
pServerIP						:= _control.IPAddress.edata10														;
pFilename						:= 'PD*csv'																							;
#workunit('name', bell_thrive._Constants().Name + ' Build ' + pversion);
bell_thrive.Build_All(
	 pversion					
	,pDirectory				
	,pServerIP					
	,pFilename					
);
