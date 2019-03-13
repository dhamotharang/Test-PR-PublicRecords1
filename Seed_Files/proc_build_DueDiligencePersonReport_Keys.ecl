IMPORT RoxiekeyBuild;


EXPORT proc_build_DueDiligencePersonReport_Keys(STRING filedate) := MODULE

	SHARED mac_build_key(key, keyname) := FUNCTIONMACRO
	
		flfile := '~thor_data400::key::testseed::'+filedate+'::DueDiligencePersonReport::'+keyname;
		fsfile := '~thor_data400::key::testseed::@version@::DueDiligencePersonReport::'+keyname;
    
		RoxiekeyBuild.Mac_SK_Buildprocess_V2_Local(Seed_Files.keys_DueDiligencePersonReport.#EXPAND(key), fsfile, flfile, a1);
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
			mac_build_key('BestSection', 'BestInfo'),
			mac_build_key('PersonInformationSection', 'PersonInfo'),
			mac_build_key('AttributesSection', 'Attributes'),
			mac_build_key('LegalSection', 'Legal'),
			mac_build_key('EconomicIncomeSection', 'EconomicIncome'),
			mac_build_key('EconomicPropertySection', 'EconomicProperty'),
			mac_build_key('EconomicVehicleSection', 'EconomicVehicle'),
			mac_build_key('EconomicWatercraftSection', 'EconomicWatercraft'),
			mac_build_key('EconomicAircraftSection', 'EconomicAircraft'),
			mac_build_key('ProfessionalNetworkSection', 'ProfessionalNetwork'),
			mac_build_key('BusinessAssociationSection', 'BusinessAssociation'),
			mac_build_key('IdentityAgeSection', 'IdentityAge')
			);
	END;
  
  
  

	SHARED mac_build_prte_key(keyname, section) := FUNCTIONMACRO

		flfile := '~prte::key::testseed::' + filedate + '::duediligencepersonreport::' + keyname;
		seed := Seed_Files.files_DueDiligencePersonReport.#EXPAND(section);
    
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
			mac_build_prte_key('BestInfo', 'Section_Best'),
			mac_build_prte_key('PersonInfo', 'Section_PersonInfo'),
			mac_build_prte_key('Attributes', 'Section_Attributes'),
			mac_build_prte_key('Legal', 'Section_Legal'),
			mac_build_prte_key('EconomicIncome', 'Section_EconomicIncome'),
			mac_build_prte_key('EconomicProperty', 'Section_EconomicProperty'),
			mac_build_prte_key('EconomicVehicle', 'Section_EconomicVehicle'),
			mac_build_prte_key('EconomicWatercraft', 'Section_EconomicWatercraft'),
			mac_build_prte_key('EconomicAircraft', 'Section_EconomicAircraft'),
			mac_build_prte_key('ProfessionalNetwork', 'Section_ProfessionalNetwork'),
			mac_build_prte_key('BusinessAssociation', 'Section_BusinessAssociation'),
			mac_build_prte_key('IdentityAge', 'Section_IdentityAge')			
			);
	END;

END;