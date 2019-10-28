IMPORT data_services, doxie, STD;

string prefix := data_services.data_location.Prefix('FirstData') + 'thor_data400::key::FirstData::FCRA::';


EXPORT names(string file_version = doxie.Version_SuperKey) := module
		SHARED string postfix := IF (file_version != '', '_' + file_version, '');

		export i_did_FCRA:=prefix+'did'+postfix;
		
end;