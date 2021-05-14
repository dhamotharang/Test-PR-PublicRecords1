IMPORT STD, _control;

EXPORT mod_Utilities := MODULE   
   
  EXPORT EnvName := _control.ThisEnvironment.Name;
	
	EXPORT strCurrentDate := (STRING8)Std.Date.Today();
  EXPORT CurrentDate := Std.Date.Today();
  
  EXPORT CurrentDateTimeStamp := Std.Date.SecondsToString(STD.Date.CurrentSeconds(TRUE), '%Y%m%d%H%M%S');
  
  EXPORT BOOLEAN fn_isFileExists(STRING SuperFile) := FUNCTION
	  RETURN STD.File.FileExists(SuperFile);
	END;
	
	EXPORT fn_CreateSuperFile(STRING SuperFile) := FUNCTION
	  RETURN IF (~fn_isFileExists(SuperFile), STD.File.CreateSuperFile(SuperFile));
  END;
	
END;  

