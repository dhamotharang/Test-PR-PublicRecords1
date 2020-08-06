IMPORT data_services, doxie, STD;

string FCRAprefix := data_services.data_location.Prefix('FirstData') + 'thor_data400::key::FirstData::FCRA::';
string prefix := data_services.data_location.Prefix('FirstData') + 'thor_data400::key::FirstData::';

EXPORT names(string file_version = doxie.Version_SuperKey) := module

		export i_did_FCRA:=FCRAprefix+file_version+'::did';
		
		export i_driverslicense:=prefix+file_version+'::driverslicense';	
end;