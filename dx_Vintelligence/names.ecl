IMPORT data_services, doxie, STD;

string prefix := data_services.data_location.Prefix('Vintelligence') + 'thor_data400::key::Vintelligence::';


EXPORT names(string file_version = doxie.Version_SuperKey) := module
		SHARED string postfix := IF (file_version != '', '_' + file_version, '');

		export i_VintelligenceKey1:=prefix+'Vin::Key1'+postfix;
		export i_VintelligenceKey2:=prefix+'Vin::Key2'+postfix;
		
end;