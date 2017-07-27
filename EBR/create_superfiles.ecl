export create_superfiles(string100 superfilename, boolean Isbase = false) := 
		map(fileservices.SuperFileExists(superfilename) => output(trim(superfilename) + ' already exists.'),
			Isbase => sequential(fileservices.createsuperfile(trim(superfilename))
							,fileservices.createsuperfile(trim(superfilename) + '_FATHER')
							,fileservices.createsuperfile(trim(superfilename) + '_GRANDFATHER')
							,fileservices.createsuperfile(trim(superfilename) + '_BUILDING')
							,fileservices.createsuperfile(trim(superfilename) + '_BUILT')),
					sequential(fileservices.createsuperfile(trim(superfilename))
							,fileservices.createsuperfile(trim(superfilename) + '_FATHER')));