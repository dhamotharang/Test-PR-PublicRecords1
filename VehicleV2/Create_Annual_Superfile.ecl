IMPORT STD;

EXPORT Create_Annual_Superfile(STRING4 file_year) := FUNCTION
	create_superfile := IF(
		STD.File.FileExists('~thor_data400::in::vehreg_experian::' + file_year + '::annual_updates'),
		OUTPUT('Vehicle ' + file_year + ' superfile already exists'),
		STD.File.CreateSuperFile('~thor_data400::in::vehreg_experian::' + file_year + '::annual_updates')
	);

	RETURN create_superfile;
END;
