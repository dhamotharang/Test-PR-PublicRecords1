IMPORT $, STD,_control; 

EXPORT Spray_All(STRING filedate, STRING	pServerIP	= _control.IPAddress.bctlpedata12) := MODULE


//Clear all superfiles. Input files are large so previous logical input files need to be deleted each build
Clear_Supers	:= 
	SEQUENTIAL(
						STD.File.StartSuperFileTransaction(),
						STD.File.ClearSuperFile('~thor_data400::in::BKMortgage::refresh_Assignment', TRUE),
						STD.File.ClearSuperFile('~thor_data400::in::BKMortgage::refresh_Assignment_orphan', TRUE),
						STD.File.ClearSuperFile('~thor_data400::in::BKMortgage::refresh_Release_orphan', TRUE),
						STD.File.ClearSuperFile('~thor_data400::in::BKMortgage::refresh_Release', TRUE),
						STD.File.ClearSuperFile('~thor_data400::in::BKMortgage::Update_Assignment', TRUE),
						STD.File.ClearSuperFile('~thor_data400::in::BKMortgage::Update_Assignment_orphan', TRUE),
						STD.File.ClearSuperFile('~thor_data400::in::BKMortgage::Update_Release', TRUE),
						STD.File.ClearSuperFile('~thor_data400::in::BKMortgage::Update_Release_orphan', TRUE),
						// STD.File.ClearSuperFile('~thor_data400::in::BKMortgage::delete_Assignment'),
						// STD.File.ClearSuperFile('~thor_data400::in::BKMortgage::delete_Release'),
						STD.File.FinishSuperFileTransaction()
						);	

Spray_Files := 
  PARALLEL(
	         BKMortgage.Spray_UpdateFile(filedate,pServerIP).SprayFile,
           //BKMortgage.Spray_deleteFile(filedate).SprayFile, //Property build does not process deletes
           BKMortgage.Spray_RefreshFile(filedate,pServerIP).SprayFile
					 );				 

EXPORT spray_file  := SEQUENTIAL(Clear_Supers, Spray_Files);

END;