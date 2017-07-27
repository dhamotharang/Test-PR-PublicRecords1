cleanup(STRING file) := IF(FileServices.FileExists(file),
	FileServices.DeleteLogicalFile(file), OUTPUT('File "' + file + '" does not exist.'));

k := cleanup('~thor_data400::key::moxie.corp_supp.corp_key.key');
k1 := cleanup('~thor_data400::key::moxie.corp_supp.st_orig.sos_charter_nbr.key');
k2 := cleanup('~thor_data400::key::moxie.corp_supp.bdid.key');
k3 := cleanup('~thor_data400::key::moxie.corp_supp.corp_key.supp_type_desc.supp_filing_date.key');
k4 := cleanup('~thor_data400::key::moxie.corp_supp.sos_charter_nbr.key');

export Remove_Corp_Supp_Keys := sequential(k,k1,k2,k3,k4);