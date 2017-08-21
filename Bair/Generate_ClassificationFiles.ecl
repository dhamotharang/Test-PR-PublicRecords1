import std,_control;

EXPORT Generate_ClassificationFiles(string version, boolean pUseProd = false, boolean pUseDelta = false) := module

	path 			:= '/data/bair/outgoing/';
	pServerIP	:= _control.IPAddress.bair_batchlz01;
	
  Unspray(string logicalname, string filename, string subdir = '') :=
			STD.File.Despray(logicalname,
				pServerIP,
				path + if(subdir <> '', subdir + '/', '') + filename,
				allowoverwrite := true);
				
	AgencyClassificationLFN := '~thor_data400::bair::AgencyClassification.csv';
	
	AgencyClassificationFN	:= 'AgencyClassification_' + version + '.csv';
	
	export create_all := sequential(	
		OUTPUT(bair.files('', pUseProd, pUseDelta).Classification_Base.built(ori <> '' and crime <> ''),,AgencyClassificationLFN,CSV(HEADING(SINGLE),SEPARATOR('|'),QUOTE(''),TERMINATOR('\r\n')),OVERWRITE, COMPRESSED),
		Unspray(AgencyClassificationLFN, AgencyClassificationFN, '')
	);

END;