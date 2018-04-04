EXPORT getfilename(string datasetname,string environment = '',string suffix = '',boolean legacy = false, boolean isprte = false) := module
	shared mode(string inmode) := map(inmode = 'in' => 'in',
																	  inmode = 'base' => 'base',
																		inmode = 'key' => 'key',
																		'na');
	shared thorclustername := if (~isprte
																	,'~thor_data400::'
																	,'~prte::'
																);
	shared prefix(string inmode) := if (environment = 'fcra',
																		if(legacy = false,
																			thorclustername+trim(mode(inmode),left,right)+'::override::'+environment+'::',
																			thorclustername+trim(mode(inmode),left,right)+'::'+environment+'::override::'),
																thorclustername+trim(mode(inmode),left,right)+'::override::');
	
	export infile := prefix('in') + '@version@::' + datasetname;
	export basefile := prefix('base') + '@version@::' + datasetname;
	export keyfile := prefix('key') + datasetname + '::@version@::' + suffix;
	
	
end;