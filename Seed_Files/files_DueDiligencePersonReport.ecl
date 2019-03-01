IMPORT Data_Services, DueDiligence;

EXPORT files_DueDiligencePersonReport  := MODULE
	SHARED max10k := 10000;
	
	
	SHARED GetFileName(STRING section) := FUNCTION
	
    //===============================================
    // set the prefix and middle name of the
    // super file name of the test seed files
    //===============================================
    filePrefix := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400';		
    middleName := 'testseed::dueDiligencePersonReport';

	
		fn := CASE(section,      
									'Best'  	              => filePrefix + '::in::' + middleName + '::bestInfo',
									'PersonInformation'		  => filePrefix + '::in::' + middleName + '::personInfo',
									'Attributes'		        => filePrefix + '::in::' + middleName + '::attributes',
									'Legal'			            => filePrefix + '::in::' + middleName + '::legal',
									'EconomicIncome'			  => filePrefix + '::in::' + middleName + '::economicIncome',
									'EconomicProperty'			=> filePrefix + '::in::' + middleName + '::economicProperty',
									'EconomicVehicle'				=> filePrefix + '::in::' + middleName + '::economicVehicle',
									'EconomicWatercraft'		=> filePrefix + '::in::' + middleName + '::economicWatercraft',
									'EconomicAircraft'      => filePrefix + '::in::' + middleName + '::economicAircraft',
									'ProfessionalNetwork'		=> filePrefix + '::in::' + middleName + '::professionalNetwork',
									'BusinessAssociations'  => filePrefix + '::in::' + middleName + '::businessAssociation',
									'ItentityAge'           => filePrefix + '::in::' + middleName + '::identityAge',
									'');
                  
		IF(fn = '', FAIL('Unknown Section'));
    
		RETURN fn;
	END;
	
  
  
  
  
  
  //==========================================================
  // Best Information Section
  //==========================================================	
	EXPORT Section_Best := DATASET(GetFileName('Best'), DueDiligence.TestSeeds.PersonLayouts.BestSection, 
                                      CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));

 				
  //==========================================================
  // Person Information Section
  //==========================================================	
	EXPORT Section_PersonInfo := DATASET(GetFileName('PersonInformation'), DueDiligence.TestSeeds.PersonLayouts.PersonInformationSection, 
                                            CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
                                            
                                            
  //==========================================================
  // Attributes Section
  //==========================================================	
	EXPORT Section_Attributes := DATASET(GetFileName('Attributes'), DueDiligence.TestSeeds.PersonLayouts.AttributesSection, 
                                            CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));


  //==========================================================
  // Legal Section
  //==========================================================	
	EXPORT Section_Legal := DATASET(GetFileName('Legal'), DueDiligence.TestSeeds.PersonLayouts.LegalSection, 
                                       CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));


  //==========================================================
  // Economic Section - Income
  //==========================================================	
	EXPORT Section_EconomicIncome := DATASET(GetFileName('EconomicIncome'), DueDiligence.TestSeeds.PersonLayouts.EconomicIncomeSection, 
                                                CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
                                       
                                       
  //==========================================================
  // Economic Section - Property
  //==========================================================	
	EXPORT Section_EconomicProperty := DATASET(GetFileName('EconomicProperty'), DueDiligence.TestSeeds.PersonLayouts.EconomicPropertySection, 
                                                  CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
                                       
                                       
  //==========================================================
  // Economic Section - Vehicle
  //==========================================================	
	EXPORT Section_EconomicVehicle := DATASET(GetFileName('EconomicVehicle'), DueDiligence.TestSeeds.PersonLayouts.EconomicVehicleSection, 
                                                 CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
                                       
                                       
  //==========================================================
  // Economic Section - Watercraft
  //==========================================================	
	EXPORT Section_EconomicWatercraft := DATASET(GetFileName('EconomicWatercraft'), DueDiligence.TestSeeds.PersonLayouts.EconomicWatercraftSection, 
                                                    CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
                                       
                                       
  //==========================================================
  // Economic Section - Aircraft
  //==========================================================	
	EXPORT Section_EconomicAircraft := DATASET(GetFileName('EconomicAircraft'), DueDiligence.TestSeeds.PersonLayouts.EconomicAircraftSection, 
                                                  CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
                                       
                                       
  //==========================================================
  // Professional Network Section
  //==========================================================	
	EXPORT Section_ProfessionalNetwork := DATASET(GetFileName('ProfessionalNetwork'), DueDiligence.TestSeeds.PersonLayouts.ProfessionalNetworkSection, 
                                                     CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
                                       
                                       
  //==========================================================
  // Economic Section - Income
  //==========================================================	
	EXPORT Section_BusinessAssociation := DATASET(GetFileName('BusinessAssociations'), DueDiligence.TestSeeds.PersonLayouts.BusinessAssociationSection, 
                                                     CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
                                       
                                       
  //==========================================================
  // Identity Section - Age
  //==========================================================	
	EXPORT Section_IdentityAge := DATASET(GetFileName('BusinessAssociations'), DueDiligence.TestSeeds.PersonLayouts.IdentityAgeSection, 
                                             CSV(heading(1), separator(','), QUOTE('"'), maxlength (max10k)));

END;