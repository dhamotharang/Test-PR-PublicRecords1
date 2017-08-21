export GetUpdateSuperFilename(string updatetype) := 
	map( updatetype = 'CONT'  => '~thor_data400::in::corporate_direct::cont',
		updatetype = 'EVENT' => '~thor_data400::in::corporate_direct::event',
		updatetype = 'SUPP'  => '~thor_data400::in::corporate_direct::supp',
		updatetype = 'CORP'  => '~thor_data400::in::corporate_direct::corp', '');