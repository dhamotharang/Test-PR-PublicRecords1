IMPORT FileServices, RoxiekeyBuild, Seed_Files;


EXPORT proc_build_DueDiligenceBusinessReport_Keys(STRING filedate) := MODULE

	SHARED mac_build_key(key, keyname) := FUNCTIONMACRO
	
		flfile := '~thor_data400::key::testseed::'+filedate+'::DueDiligenceBusinessReport::'+keyname;
		fsfile := '~thor_data400::key::testseed::@version@::DueDiligenceBusinessReport::'+keyname;
    
		RoxiekeyBuild.Mac_SK_Buildprocess_V2_Local(Seed_Files.keys_DueDiligenceBusinessReport.#EXPAND(key), fsfile, flfile, a1);
 		RoxiekeyBuild.Mac_SK_Move_to_Built_v2(fsfile, flfile, a2);
		RoxiekeyBuild.MAC_SK_Move(fsfile, 'Q' ,a3);
    
		RETURN SEQUENTIAL(
							FileServices.StartSuperFileTransaction(),
							IF(NOT FileServices.FileExists(fsfile),FileServices.CreateSuperFile(fsfile)),
							FileServices.FinishSuperFileTransaction(),
							a1,
							a2,
							a3);

	ENDMACRO;

	EXPORT allkeys := FUNCTION
		RETURN SEQUENTIAL(
			mac_build_key('InputEchoSection', 'InputEcho'),
			mac_build_key('AttributesSection', 'Attributes')
			);
	END;
  
  
  

	SHARED mac_build_prte_key(keyname, section) := FUNCTIONMACRO

		flfile := '~prte::key::testseed::' + filedate + '::duediligencebusinessreport::' + keyname;
		seed := Seed_Files.files_DueDiligenceBusinessReport.#EXPAND(section);
    
		newrec := record
			data16 hashvalue := (data16) 0;
			seed;
		end;
    
		newtable := dataset([], newrec);
		k_prte_key := index(newtable,{inDatasetName, hashvalue}, {newtable}, flfile);
    
		RETURN	BUILD(k_prte_key, update);
	ENDMACRO;
	
	EXPORT prtekeys := FUNCTION
		RETURN SEQUENTIAL(
			mac_build_prte_key('Attributes', 'Section_Attributes'),	
			mac_build_prte_key('InputEcho', 'Section_InputEcho')		
			);
	END;

END;