#workunit ('name', 'Banko files and output files cleanup ');


EXPORT BWR_BankoCleanUp(STRING filedate) := FUNCTION

cleanup(STRING file) := IF(FileServices.FileExists(file),
	FileServices.DeleteLogicalFile(file), OUTPUT('File "' + file + '" does not exist.'));
cleanup('~thor_data400::base::Banko::main_temp');
cleanup('~thor_data400::base::FCRA::Banko::main_temp');

		sequential(FileServices.StartSuperFileTransaction(),
FileServices.AddSuperFile('~thor_data400::KEY::Banko::FCRA::courtcode.casenumber.caseId.payload_delete','~thor_data400::KEY::Banko::FCRA::courtcode.casenumber.caseId.payload_father',, true),
FileServices.ClearSuperFile('~thor_data400::KEY::Banko::FCRA::courtcode.casenumber.caseId.payload_father'),
FileServices.AddSuperFile('~thor_data400::KEY::Banko::FCRA::courtcode.casenumber.caseId.payload_father', '~thor_data400::KEY::Banko::FCRA::courtcode.casenumber.caseId.payload',, true),
FileServices.ClearSuperFile('~thor_data400::KEY::Banko::FCRA::courtcode.casenumber.caseId.payload'),
FileServices.AddSuperFile('~thor_data400::KEY::Banko::FCRA::courtcode.casenumber.caseId.payload','~thor_data400::KEY::Banko::FCRA::'+filedate+'::courtcode.casenumber.caseId.payload'), 
FileServices.FinishSuperFileTransaction(),
FileServices.ClearSuperFile('~thor_data400::KEY::Banko::FCRA::courtcode.casenumber.caseId.payload_delete',true));

		sequential(FileServices.StartSuperFileTransaction(),
FileServices.AddSuperFile('~thor_data400::KEY::Banko::courtcode.casenumber.caseId.payload_delete','~thor_data400::KEY::Banko::courtcode.casenumber.caseId.payload_father',, true),
FileServices.ClearSuperFile('~thor_data400::KEY::Banko::courtcode.casenumber.caseId.payload_father'),
FileServices.AddSuperFile('~thor_data400::KEY::Banko::courtcode.casenumber.caseId.payload_father', '~thor_data400::KEY::Banko::courtcode.casenumber.caseId.payload',, true),
FileServices.ClearSuperFile('~thor_data400::KEY::Banko::courtcode.casenumber.caseId.payload'),
FileServices.AddSuperFile('~thor_data400::KEY::Banko::courtcode.casenumber.caseId.payload','~thor_data400::KEY::Banko::'+filedate+'::courtcode.casenumber.caseId.payload'), 
FileServices.FinishSuperFileTransaction(),
FileServices.ClearSuperFile('~thor_data400::KEY::Banko::courtcode.casenumber.caseId.payload_delete',true));

RETURN OUTPUT('Banko file cleanup done');
END;