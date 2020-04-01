//AddSuperFile

IMPORT STD, orbit;
fileservices := STD.File;

EXPORT AddSuperFile(STRING SuperFile, STRING SubFile) := SEQUENTIAL(FileServices.StartSuperFileTransaction(),
																									                  FileServices.AddSuperFile(SuperFile, SubFile),
																									                  FileServices.FinishSuperFileTransaction());