IMPORT data_services, doxie, STD;

string prefix := data_services.data_location.Prefix('BancorpRCDList') + 'thor_data400::key::BancorpRCDList::';

EXPORT names(string file_version = doxie.Version_SuperKey) := module

		export i_ssn:=prefix+file_version+'::ssn';

end;