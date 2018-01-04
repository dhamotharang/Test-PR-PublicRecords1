Import Data_Services, doxie;

file := Experian_Phones.Files.base(is_current and did > 0);

EXPORT Key_Did := index(file,
              {did},
					    {file},
							data_services.data_location.prefix() + 'thor_data400::key::experian_phones::' + doxie.Version_SuperKey + '::did');