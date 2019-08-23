IMPORT RoxiekeyBuild, Seed_Files;


EXPORT proc_build_Citizenship_Keys(STRING filedate) := MODULE

	SHARED mac_build_key(key, keyname) := FUNCTIONMACRO
	
		flfile := '~thor_data400::key::testseed::'+filedate+'::Citizenship::'+keyname;
		fsfile := '~thor_data400::key::testseed::@version@::Citizenship::'+keyname;
    
		RoxiekeyBuild.Mac_SK_Buildprocess_V2_Local(Seed_Files.keys_Citizenship.#EXPAND(key), fsfile, flfile, a1);
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
			mac_build_key('RiskIndicatorsSection', 'RiskIndicators')
			);
	END;
  
  
  

	SHARED mac_build_prte_key(keyname, section) := FUNCTIONMACRO

		flfile := '~prte::key::testseed::' + filedate + '::citizenship::' + keyname;
		seed := Seed_Files.files_Citizenship.#EXPAND(section);
    
		newrec := RECORD
			DATA16 hashvalue := (DATA16) 0;
			seed;
		END;
    
		newtable := DATASET([], newrec);
		k_prte_key := INDEX(newtable,{inDatasetName, hashvalue}, {newtable}, flfile);
    
		RETURN	BUILD(k_prte_key, UPDATE);
	ENDMACRO;
	
	EXPORT prtekeys := FUNCTION
		RETURN SEQUENTIAL(
			mac_build_prte_key('RiskIndicators', 'Section_RiskIndicators'),	
			mac_build_prte_key('InputEcho', 'Section_InputEcho')		
			);
	END;

END;