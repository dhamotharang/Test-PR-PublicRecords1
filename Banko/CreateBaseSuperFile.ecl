

export CreateBaseSuperFile(STRING filedate) := FUNCTION


	sequential(FileServices.StartSuperFileTransaction(),
FileServices.AddSuperFile('~thor_data400::base::FCRA::Banko::main_delete','~thor_data400::base::FCRA::Banko::main_father',, true),
FileServices.ClearSuperFile('~thor_data400::base::FCRA::Banko::main_father'),
FileServices.AddSuperFile('~thor_data400::base::FCRA::Banko::main_father', '~thor_data400::base::FCRA::Banko::main',, true),
FileServices.ClearSuperFile('~thor_data400::base::FCRA::Banko::main'),
FileServices.AddSuperFile('~thor_data400::base::FCRA::Banko::main','~thor_data400::base:FCRA:::Banko::main_'+filedate), 
FileServices.FinishSuperFileTransaction(),
FileServices.ClearSuperFile('~thor_data400::base::FCRA::Banko::main',true));



		sequential(FileServices.StartSuperFileTransaction(),
FileServices.AddSuperFile('~thor_data400::base::Banko::main_delete','~thor_data400::base::Banko::main_father',, true),
FileServices.ClearSuperFile('~thor_data400::base::Banko::main_father'),
FileServices.AddSuperFile('~thor_data400::base::Banko::main_father', '~thor_data400::base::Banko::main',, true),
FileServices.ClearSuperFile('~thor_data400::base::Banko::main'),
FileServices.AddSuperFile('~thor_data400::base::Banko::main','~thor_data400::base::Banko::main_'+filedate), 
FileServices.FinishSuperFileTransaction(),
FileServices.ClearSuperFile('~thor_data400::base::Banko::main',true));

RETURN OUTPUT('Base Superfile Complete');
END;