Import Data_Services, doxie, ut;
file := Experian_Phones.Files.base(is_current and did > 0);
EXPORT Key_Did := index(file,
              {did},
						    {file},
								Data_Services.Data_location.Prefix('Gong') + 'thor_data400::key::experian_phones::' + doxie.Version_SuperKey + '::did');
								
								
	
								
	