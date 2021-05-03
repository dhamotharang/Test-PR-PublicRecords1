IMPORT tools, OneKey;

EXPORT Files(STRING pversion = '', BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
  tools.mac_FilesInput(OneKey.Filenames(pversion, pUseOtherEnvironment).InputA
                      ,OneKey.Layouts.InputA.Sprayed
                      ,InputA
                      ,'CSV'
                      ,
                      ,pTerminator := ['\n','\r\n']
                      ,pSeparator := ','
                      ,pHeading := 1);

  tools.mac_FilesInput(OneKey.Filenames(pversion, pUseOtherEnvironment).InputB
                      ,OneKey.Layouts.InputB.Sprayed
                      ,InputB
                      ,'CSV'
                      ,
                      ,pTerminator := ['\n','\r\n']
                      ,pSeparator := ','
                      ,pHeading := 1);
		
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
  tools.mac_FilesBase(OneKey.Filenames(pversion, pUseOtherEnvironment).Base
                     ,OneKey.Layouts.Base
                     ,Base);
	
END;