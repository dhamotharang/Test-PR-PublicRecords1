cleanup(STRING file) := IF(FileServices.FileExists(file),
	FileServices.DeleteLogicalFile(file), OUTPUT('File "' + file + '" does not exist.'));

k := cleanup('~thor_data400::key::moxie.corp_event.bdid.key');
k1 := cleanup('~thor_data400::key::moxie.corp_event.corp_key.event_filing_date.key');
k2 := cleanup('~thor_data400::key::moxie.corp_event.corp_key.key');
k3 := cleanup('~thor_data400::key::moxie.corp_event.sos_charter_nbr.key');
k4 := cleanup('~thor_data400::key::moxie.corp_event.st_orig.sos_charter_nbr.key');

export Remove_Corp_Event_Keys := sequential(k,k1,k2,k3,k4);