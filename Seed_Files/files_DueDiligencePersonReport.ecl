IMPORT Data_Services, DueDiligence;

EXPORT files_DueDiligencePersonReport  := MODULE
	SHARED max10k := 10000;
	SHARED max20k := 20000;
	
	SHARED GetFileName(STRING section) := FUNCTION
	
    //===============================================
    // set the prefix and middle name of the
    // super file name of the test seed files
    //===============================================
    filePrefix := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400';		
    middleName := 'dueDiligencePersonReport_testseed_';

	
		fn := CASE(section,      
									'Best'  	              => filePrefix + '::base::' + middleName + 'bestInfo',
									'PersonInformation'		  => filePrefix + '::base::' + middleName + 'personInfo',
									'Attributes'		        => filePrefix + '::base::' + middleName + 'attributes',
									'Legal'			            => filePrefix + '::base::' + middleName + 'legal',
									'EconomicIncome'			  => filePrefix + '::base::' + middleName + 'economicIncome',
									'EconomicProperty'			=> filePrefix + '::base::' + middleName + 'economicProperty',
									'EconomicVehicle'				=> filePrefix + '::base::' + middleName + 'economicVehicle',
									'EconomicWatercraft'		=> filePrefix + '::base::' + middleName + 'economicWatercraft',
									'EconomicAircraft'      => filePrefix + '::base::' + middleName + 'economicAircraft',
									'ProfessionalNetwork'		=> filePrefix + '::base::' + middleName + 'professionalNetwork',
									'BusinessAssociations'  => filePrefix + '::base::' + middleName + 'businessAssociation',
									'ItentityAge'           => filePrefix + '::base::' + middleName + 'identityAge',
									'');
                  
		IF(fn = '', FAIL('Unknown Section'));
    
		RETURN fn;
	END;
	
  
  
  
  
  
  //==========================================================
  // Best Information Section
  //==========================================================	
	EXPORT Section_Best := DATASET(GetFileName('Best'), DueDiligence.TestSeeds.PersonLayouts.BestSection, 
                                      CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));

 				
  //==========================================================
  // Person Information Section
  //==========================================================	
	EXPORT Section_PersonInfo := DATASET(GetFileName('PersonInformation'), DueDiligence.TestSeeds.PersonLayouts.PersonInformationSection, 
                                            CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                            
                                            
  //==========================================================
  // Attributes Section
  //==========================================================	
	EXPORT Section_Attributes := DATASET(GetFileName('Attributes'), DueDiligence.TestSeeds.PersonLayouts.AttributesSection, 
                                            CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));


  //==========================================================
  // Legal Section
  //==========================================================	
	EXPORT Section_Legal := DATASET(GetFileName('Legal'), DueDiligence.TestSeeds.PersonLayouts.LegalSection, 
                                       CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));


  //==========================================================
  // Economic Section - Income
  //==========================================================	
	EXPORT Section_EconomicIncome := DATASET(GetFileName('EconomicIncome'), DueDiligence.TestSeeds.PersonLayouts.EconomicIncomeSection, 
                                                CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                       
                                       
  //==========================================================
  // Economic Section - Property
  //==========================================================	
	EXPORT Section_EconomicProperty := DATASET(GetFileName('EconomicProperty'), DueDiligence.TestSeeds.PersonLayouts.EconomicPropertySection, 
                                                  CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max20k)));
                                       
                                       
  //==========================================================
  // Economic Section - Vehicle
  //==========================================================	
	EXPORT Section_EconomicVehicle := DATASET(GetFileName('EconomicVehicle'), DueDiligence.TestSeeds.PersonLayouts.EconomicVehicleSection, 
                                                 CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                       
                                       
  //==========================================================
  // Economic Section - Watercraft
  //==========================================================	
	EXPORT Section_EconomicWatercraft := DATASET(GetFileName('EconomicWatercraft'), DueDiligence.TestSeeds.PersonLayouts.EconomicWatercraftSection, 
                                                    CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                       
                                       
  //==========================================================
  // Economic Section - Aircraft
  //==========================================================	
	EXPORT Section_EconomicAircraft := DATASET(GetFileName('EconomicAircraft'), DueDiligence.TestSeeds.PersonLayouts.EconomicAircraftSection, 
                                                  CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                       
                                       
  //==========================================================
  // Professional Network Section
  //==========================================================	
	EXPORT Section_ProfessionalNetwork := DATASET(GetFileName('ProfessionalNetwork'), DueDiligence.TestSeeds.PersonLayouts.ProfessionalNetworkSection, 
                                                     CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                       
                                       
  //==========================================================
  // Economic Section - Income
  //==========================================================	
	EXPORT Section_BusinessAssociation := DATASET(GetFileName('BusinessAssociations'), DueDiligence.TestSeeds.PersonLayouts.BusinessAssociationSection, 
                                                     CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                       
                                       
  //==========================================================
  // Identity Section - Age
  //==========================================================	
	EXPORT Section_IdentityAge := DATASET(GetFileName('BusinessAssociations'), DueDiligence.TestSeeds.PersonLayouts.IdentityAgeSection, 
                                             CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));

END;