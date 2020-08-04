IMPORT data_services, doxie, STD;

string FCRAprefix := data_services.data_location.Prefix('FirstData') + 'thor_data400::key::FirstData::FCRA::';
string prefix := data_services.data_location.Prefix('FirstData') + 'thor_data400::key::FirstData::';

EXPORT names(string file_version = doxie.Version_SuperKey) := module
		SHARED string version := IF (file_version != '',file_version, '');

		export i_did_FCRA:=FCRAprefix+version+'::did';
		
		export i_driverslicense:=prefix+version+'::driverslicense';
end;