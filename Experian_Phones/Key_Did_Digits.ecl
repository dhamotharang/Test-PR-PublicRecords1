Import Data_Services, doxie, ut;
file := Experian_Phones.Files.base(is_current and did > 0);
EXPORT Key_Did_Digits := index(file,
              {did,Phone_digits},
						    {file},
								/*Data_Services.Data_location.Prefix('FileOne') +*/ '~thor_data400::key::experian_phones::' + doxie.Version_SuperKey + '::did_digits');
								
								
	
								
	