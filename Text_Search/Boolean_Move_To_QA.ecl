export Boolean_Move_To_QA(string aName, string fName) := function

// Delete Superfile
dName := regexreplace('::QA::',aName,'::DELETE::',nocase);

retval := sequential(
	// Check if QA superfile exists
	IF(NOT FileServices.SuperFIleExists(aName),
		FileServices.CreateSuperFile(aName)),
	// Check if DELETE superfile exists
	if(not fileservices.superfileexists(dName),
		fileservices.createsuperfile(dName)),
	FileServices.StartSuperFileTransaction(),
	fileservices.addsuperfile(dName,aName,,true),
	FileServices.ClearSuperFile(aName),
	FileServices.AddSuperFIle(aName, fName),
	FileServices.FinishSuperFileTransaction(),
	fileservices.clearsuperfile(dName,true)
	);

return retval;

end;