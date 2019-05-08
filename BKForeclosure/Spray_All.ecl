IMPORT BKForeclosure, STD; 

EXPORT Spray_All(STRING filedate) := MODULE


//Clear all superfiles. Input files are large so previous logical input files need to be deleted each build
Clear_Supers	:= 
	SEQUENTIAL(
						STD.File.StartSuperFileTransaction(),
						STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_nod'/*, TRUE*/),
						STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_nod_orphan'/*, TRUE*/),
						STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_reo_orphan'/*, TRUE*/),
						STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_reo'/*, TRUE*/),
						STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::Update_Nod'/*, TRUE*/),
						STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::Update_Reo'/*, TRUE*/),
						STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::delete_nod'),
						STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::delete_reo'),
						STD.File.FinishSuperFileTransaction()
						);	

Spray_Files := 
  PARALLEL(
	         BKForeclosure.Spray_UpdateFile(filedate).SprayFile,
           BKForeclosure.Spray_deleteFile(filedate).SprayFile,
           BKForeclosure.Spray_RefreshFile(filedate).SprayFile
					 );
					 
//Add inputs to combined superfile
dsAll := BKForeclosure.fGetInputFile(filedate).do_all;

EXPORT spray_file  := SEQUENTIAL(Clear_Supers, Spray_Files, dsAll);

END;