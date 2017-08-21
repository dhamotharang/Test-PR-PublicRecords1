import std,_control;

EXPORT Generate_CfsAndCrimeTypeFiles(string version, boolean pUseProd = false, boolean pUseDelta = false) := module

	path 			:= '/data/bair/outgoing/';
	pServerIP	:= _control.IPAddress.bair_batchlz01;
	
  Unspray(string logicalname, string filename, string subdir = '') :=
			STD.File.Despray(logicalname,
				pServerIP,
				path + if(subdir <> '', subdir + '/', '') + filename,
				allowoverwrite := true);
				
	CrimeLookupType := '~thor_data400::base::bair::event::dbo::AgencyCrimeTypeLookup.csv';
	CfsLookupType 	:= '~thor_data400::base::bair::cfs::dbo::AgencyCfstypeLookup.csv';
	
	CrimeLookupTypeFileName := 'AgencyCrimeTypelookup_' + version + '.csv';
	CfsLookupTypeFileName 	:= 'AgencyCfsTypelookup_' + version + '.csv';
	
	export create_all := sequential(	
		OUTPUT(bair.files('', pUseProd, pUseDelta).AgencyCrimeLookup_Base.built,,CrimeLookupType,CSV(HEADING(SINGLE),SEPARATOR('|'),QUOTE(''),TERMINATOR('\r\n')),OVERWRITE, COMPRESSED),
		OUTPUT(bair.files('', pUseProd, pUseDelta).AgencyCfsLookup_Base.built,,CfsLookupType,CSV(HEADING(SINGLE),SEPARATOR('|'),QUOTE(''),TERMINATOR('\r\n')),OVERWRITE, COMPRESSED),
		Unspray(CrimeLookupType, CrimeLookupTypeFileName, ''),
		Unspray(CfsLookupType, CfsLookupTypeFileName, '')
	);

END;