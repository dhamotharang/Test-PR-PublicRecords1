IMPORT data_services, doxie, STD;

string prefix := data_services.data_location.Prefix('') + 'thor_data400::key::demo_watchlist_screening::' + doxie.Version_SuperKey;


EXPORT names(string file_version = doxie.Version_SuperKey) := module
		SHARED string postfix := IF (file_version != '', '_' + file_version, '');

		export i_match_name :=prefix+'::matches_entity_name';
		
end;