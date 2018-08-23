// superfile management utilities
IMPORT STD;
EXPORT mod_Superfiles := MODULE
	EXPORT mac_makeFiles(nameMaker, includeCurrent = TRUE, includeFather = TRUE, includeGrandfather = TRUE, includeArchive = FALSE) := FUNCTIONMACRO
		IMPORT STD;
		
		RETURN SEQUENTIAL(IF( NOT STD.File.SuperFileExists(nameMaker.current),
												STD.File.CreateSuperFile(nameMaker.current)),
											IF( NOT STD.File.SuperFileExists(nameMaker.father),
												STD.File.CreateSuperFile(nameMaker.father)),
											IF( NOT STD.File.SuperFileExists(nameMaker.grandfather),
												STD.File.CreateSuperFile(nameMaker.grandfather)),
											IF(includeArchive,IF( NOT STD.File.SuperFileExists(nameMaker.archive),
												STD.File.CreateSuperFile(nameMaker.archive))));
	ENDMACRO;
	
	EXPORT mac_updateSuperFiles(newLogicalFile, nameMaker, deleteOld = TRUE) := FUNCTIONMACRO
		IMPORT STD;
		
		action := SEQUENTIAL(
												 STD.File.ClearSuperFile(nameMaker.grandfather, deleteOld),
												 STD.File.SwapSuperFile(nameMaker.father, nameMaker.grandfather),
												 STD.File.SwapSuperFile(nameMaker.current, nameMaker.father),
												 STD.File.AddSuperfile(nameMaker.current, newLogicalFile)
												);
		RETURN action;
	ENDMACRO;
	
	EXPORT addToSF(STRING sfNameParent, STRING sfNameChild) := FUNCTION
		sfContents := STD.File.SuperfileContents(sfNameParent);
		hasChild := COUNT(sfContents(('~' + STD.Str.ToUpperCase(name)) = STD.Str.ToUpperCase(sfNameChild))) > 0;
		
		RETURN IFF(~hasChild, STD.File.AddSuperfile(sfNameParent, sfNameChild));
	END;
	
	EXPORT moveAllSuperfile(STRING superfileFrom, STRING superfileTo) := FUNCTION
		sfContents := STD.File.SuperfileContents(superfileFrom);
		removeFromSuper := STD.File.ClearSuperfile(superfileFrom);
		addToSuper			:= NOTHOR(APPLY(sfContents, addToSF(superfileTo, '~' + name)));
		
		RETURN SEQUENTIAL(removeFromSuper, addToSuper);
	END;
END;
