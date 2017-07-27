IMPORT STD;

EXPORT createUpdateSuperFile := MODULE

	EXPORT createSuperFiles() := FUNCTION

		RETURN SEQUENTIAL(
						STD.File.createsuperfile(FileNames.Baseseleprox,, allowExist := TRUE),					
						STD.File.createsuperfile(FileNames.Baseseleproxfather, , allowExist := TRUE),	
						STD.File.createsuperfile(FileNames.Keyseleprox ,, allowExist := TRUE),		
						STD.File.createsuperfile(FileNames.Keyseleproxfather , ,allowExist := TRUE));
	END;
	
	/*-------------------- updateSuperFiles ----------------------------------------------------*/
	EXPORT updateSuperFile(STRING baseSuperFile, STRING fatherSuperFile, STRING inFile) := FUNCTION
  
		action := STD.File.PromoteSuperFileList([baseSuperFile, fatherSuperFile], inFile, true);
    
		RETURN action;
	END;
	
END;