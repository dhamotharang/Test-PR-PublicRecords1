EXPORT SuperFiles := MODULE

	// --------------------------------------------------------------
	EXPORT SimpleCreateIf(STRING name) := 
		NOTHOR(IF( ~FileServices.FileExists(name), FileServices.CreateSuperFile(name) )	);
		
	EXPORT SimpleDeleteIf(STRING name) :=
		NOTHOR(IF( FileServices.FileExists(name), FileServices.DeleteSuperFile(name) )	);

	EXPORT Clear(STRING sfName) := 	
		NOTHOR(SEQUENTIAL(
			FileServices.StartSuperFileTransaction(),
			FileServices.ClearSuperFile(sfName, FALSE),
			FileServices.FinishSuperFileTransaction ()
			));

	EXPORT ProtectedDeleteIf(STRING name) :=
		NOTHOR(SEQUENTIAL (
			IF(FileServices.FileExists(name), Clear(name)),
			SimpleDeleteIf(name)
			));
			
	

	// --------------------------------------------------------------
	EXPORT Create(STRING baseName, STRING suffixName) := 
		NOTHOR(SEQUENTIAL (
			SimpleCreateIf(baseName + '::grandfather::' + suffixName),
			SimpleCreateIf(baseName + '::father::' + suffixName),
			SimpleCreateIf(baseName + '::qa::' + suffixName)
			));
			
	EXPORT Create2(STRING baseName, STRING suffixName) := 
		NOTHOR(SEQUENTIAL (
		  SimpleCreateIf(baseName + '::' + suffixName + '_grandfather'),
			SimpleCreateIf(baseName + '::' + suffixName + '_father'),
			SimpleCreateIf(baseName + '::' + suffixName + '_qa'),
			SimpleCreateIf(baseName + '::' + suffixName + '_built')
			));

	// --------------------------------------------------------------
	EXPORT Delete(STRING baseName, STRING suffixName) := 
		NOTHOR(SEQUENTIAL (
			ProtectedDeleteIf(baseName + '::grandfather::' + suffixName),
			ProtectedDeleteIf(baseName + '::father::' + suffixName),
			ProtectedDeleteIf(baseName + '::qa::' + suffixName)
			));
			
	EXPORT Delete2(STRING baseName, STRING suffixName) := 
		NOTHOR(SEQUENTIAL (
		  ProtectedDeleteIf(baseName + '::' + suffixName + '_grandfather'),
			ProtectedDeleteIf(baseName + '::' + suffixName + '_father'),
			ProtectedDeleteIf(baseName + '::' + suffixName + '_qa'),
			ProtectedDeleteIf(baseName + '::' + suffixName + '_built')
			));
			
	// --------------------------------------------------------------
	EXPORT ClearIF(STRING sfName) := IF(FileServices.FileExists(sfName), Clear(sfName));
	EXPORT ClearOrCreate(STRING sfName) := IF(FileServices.FileExists(sfName), Clear(sfName), SimpleCreateIf(sfName) );
			
END;