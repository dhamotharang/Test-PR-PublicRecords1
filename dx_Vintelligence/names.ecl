IMPORT data_services, doxie, STD;

string base := data_services.data_location.Prefix('Vintelligence') + 'thor_data400::key::Vintelligence::';


EXPORT names(string file_version = doxie.Version_SuperKey) := module
		SHARED string prefix := IF (file_version != '', file_version, '');

		export i_VintelligenceKey1:=base+prefix+'::Vin::Key1';
		export i_VintelligenceKey2:=base+prefix+'::Vin::Key2';
		
end;