Import STD;

// Add base file to this Superfile for use by Joe Prichard and Dave Bayliss development automatically
Export AddtoReseachSF := FUNCTION

currfile := STD.File.GetSuperFileSubName('~thor_data400::base::advo::built::data',1) ;

return SEQUENTIAL(
 STD.File.StartSuperFileTransaction(),
 STD.File.AddSuperFile('~thor_data400::advo::save::for::data::analytics','~'+currfile),
 STD.File.FinishSuperFileTransaction()
 );

 END;