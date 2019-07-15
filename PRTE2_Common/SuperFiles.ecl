IMPORT STD;

EXPORT SuperFiles := MODULE

	// --------------------------------------------------------------
	EXPORT SimpleCreateIf(STRING name) := 
		NOTHOR(IF( ~STD.File.FileExists(name), STD.File.CreateSuperFile(name) )	);
		
	EXPORT SimpleDeleteIf(STRING name) :=
		NOTHOR(IF( STD.File.FileExists(name), STD.File.DeleteSuperFile(name) )	);

	EXPORT Clear(STRING sfName) := 	
		NOTHOR(SEQUENTIAL(
			STD.File.StartSuperFileTransaction(),
			STD.File.ClearSuperFile(sfName, FALSE),
			STD.File.FinishSuperFileTransaction ()
			));

	EXPORT ProtectedDeleteIf(STRING name) :=
		NOTHOR(SEQUENTIAL (
			IF(STD.File.FileExists(name), Clear(name)),
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
	EXPORT ClearIF(STRING sfName) := IF(STD.File.FileExists(sfName), Clear(sfName));
	EXPORT ClearOrCreate(STRING sfName) := IF(STD.File.FileExists(sfName), Clear(sfName), SimpleCreateIf(sfName) );
	
	// --------------------------------------------------------------
	SHARED removeTildeFN(STRING fn2)	:= REGEXREPLACE('~',fn2,'', NOCASE);

	EXPORT FileExists(STRING fname) := FUNCTION
		lfname := removeTildeFN('~'+fname);
		RETURN STD.File.fileexists(lfname);
	END;
	EXPORT DeleteLogicalFile(string fname) := FUNCTION
		lfname := removeTildeFN('~'+fname);
		RETURN STD.File.DeleteLogicalFile(lfname);
	END;
	EXPORT removeLogicalFromSFifNeeded(string fname) := FUNCTION
		lfname := removeTildeFN('~'+fname);
		return IF( STD.File.LogicalFileSuperOwners(lfname)[1].name <> '',
									apply( STD.File.LogicalFileSuperOwners(lfname),
										sequential(STD.File.removesuperfile('~'+name,lfname)) )
							);
	END;							
	EXPORT checkSFandDeleteLogical(STRING fname) := FUNCTION
		RETURN IF(FileExists(fname),
									nothor(
											SEQUENTIAL(
														removeLogicalFromSFifNeeded(fname),
														DeleteLogicalFile(fname) )
											));
	END;
	// --------------------------------------------------------------
		
END;