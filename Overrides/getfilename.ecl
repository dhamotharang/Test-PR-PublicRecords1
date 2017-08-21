EXPORT getfilename(string datasetname,string environment = '',string suffix = '',boolean legacy = false) := module
	shared mode(string inmode) := map(inmode = 'in' => 'in',
																	  inmode = 'base' => 'base',
																		inmode = 'key' => 'key',
																		'na');
	shared prefix(string inmode) := if (environment = 'fcra',
																		if(legacy = false,
																			'~thor_data400::'+trim(mode(inmode),left,right)+'::override::'+environment+'::',
																			'~thor_data400::'+trim(mode(inmode),left,right)+'::'+environment+'::override::'),
																'~thor_data400::'+trim(mode(inmode),left,right)+'::override::');
	
	export infile := prefix('in') + '@version@::' + datasetname;
	export basefile := prefix('base') + '@version@::' + datasetname;
	export keyfile := prefix('key') + datasetname + '::@version@::' + suffix;
	
	
end;