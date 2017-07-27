export create_superkeys(string100 superkeyname) := 
		map(fileservices.SuperFileExists(trim(superkeyname) + '_FATHER') => output(trim(superkeyname) + ' already exists.'),
				sequential(fileservices.createsuperfile(trim(superkeyname) + '_FATHER')
						,fileservices.createsuperfile(trim(superkeyname) + '_BUILT')
						,fileservices.createsuperfile(trim(superkeyname) + '_QA')
						,fileservices.createsuperfile(trim(superkeyname) + '_PROD')
						,fileservices.createsuperfile(trim(superkeyname) + '_GRANDFATHER')));


