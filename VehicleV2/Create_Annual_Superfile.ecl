#workunit('name','Create Annual Vehicle Superfile')
export Create_Annual_Superfile(string4 file_year) := function
	create_superfile := if(fileservices.FileExists('~thor_data400::in::vehreg_experian::' + file_year + '::annual_updates'),
													output('Vehicle ' + file_year + ' superfile already exists'),
													fileservices.createsuperfile('~thor_data400::in::vehreg_experian::' + file_year + '::annual_updates')
												);
	return create_superfile;
end;