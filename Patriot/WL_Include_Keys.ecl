export WL_Include_Keys() := MODULE

// version 1, 2 and 3
export OFAC_SET := ['OFA','OFC','OSC'];

export ADDITIONAL_WATCHLISTS_SET  := ['BES', 'CFT', 'DTC', 'EUI', 'EUG', 'FBI', 'SPE', 'FAR', 'IMW', 'INT',
																			'OCC', 'OCE', 'OCI', 'PEP', 'SDF', 'SDT', 'DEL', 'DPL', 'UVE', 'AQI', 'AQO', 'TAL', 'WBI'];
							 
export FULL_WATCHLISTS_SET := OFAC_SET + ADDITIONAL_WATCHLISTS_SET;

// version 4
export OFAC_SET_V4 := ['OFAC','OSC'];
export ADDITIONAL_WATCHLISTS_SET_V4 := ['BES', 'CFTC', 'DTC', 'EUDT', 'FAR', 'FBIH', 'FBIM', 'FBIS', 'FBIW', 'IMW', 'OCC', 'OSFIL', 'PEP', 'SDT', 'UNNT', 'WBIF'];
export FULL_WATCHLISTS_SET_V4 := OFAC_SET_V4 + ADDITIONAL_WATCHLISTS_SET_V4;

export getIncludeKeys(SET OF STRING lists) := FUNCTION
	
	r := record
		STRING3 wlKey;
	end;
												
	temp_keys := DATASET([if(Constants.wlBES IN lists, 'BES', ''),
												if(Constants.wlCFTC IN lists, 'CFT', ''),
												if(Constants.wlDTC IN lists, 'DTC', ''),
												if(Constants.wlEUDT IN lists, 'EUI', ''),
												if(Constants.wlEUDT IN lists, 'EUG', ''),
												if(Constants.wlFBI IN lists, 'FBI', ''),
												if(Constants.wlFCEN IN lists, 'SPE', ''),
												if(Constants.wlFAR IN lists, 'FAR', ''),
												if(Constants.wlIMW IN lists, 'IMW', ''),
												if(Constants.wlIMW IN lists, 'INT', ''),
												if(Constants.wlOCC IN lists, 'OCC', ''),
												if(Constants.wlOFAC IN lists, 'OFA', ''),
												if(Constants.wlOFAC IN lists, 'OFC', ''),
												if(Constants.wlOFAC IN lists, 'OSC', ''),
												if(Constants.wlOSFI IN lists, 'OCE', ''),
												if(Constants.wlOSFI IN lists, 'OCI', ''),
												if(Constants.wlPEP IN lists, 'PEP', ''),
												if(Constants.wlSDT IN lists, 'SDF', ''),
												if(Constants.wlSDT IN lists, 'SDT', ''),
												if(Constants.wlBIS IN lists, 'DEL', ''),
												if(Constants.wlBIS IN lists, 'DPL', ''),
												if(Constants.wlBIS IN lists, 'UVE', ''),
												if(Constants.wlUNNT IN lists, 'AQI', ''),
												if(Constants.wlUNNT IN lists, 'AQO', ''),
												if(Constants.wlUNNT IN lists, 'TAL', ''),
												if(Constants.wlWBIF IN lists, 'WBI', '')], r);
										
	include_keys_custom := SET(temp_keys(wlKey <> ''), wlKey);
	
	include_keys := if(constants.wlALL in lists, FULL_WATCHLISTS_SET, include_keys_custom);
	
	return include_keys;
END;

END;