IMPORT Data_Services, DueDiligence;

EXPORT files_Citizenship := MODULE
	
  SHARED max10k := 10000;
	
	SHARED GetFileName(STRING section) := FUNCTION
	
    //===============================================
    // set the prefix and middle name of the
    // super file name of the test seed files
    //===============================================
    filePrefix := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400';		
    middleName := 'citizenship_testseed_';

	
		fn := CASE(section,      
									'RiskIndicators' => filePrefix + '::base::' + middleName + 'riskIndicators',
									'InputEcho' => filePrefix + '::base::' + middleName + 'inputEcho',
									'');
                  
		IF(fn = '', FAIL('Unknown Section'));
    
		RETURN fn;
	END;
	
  
  
  
  
                                        
  //==========================================================
  // Attributes Section
  //==========================================================	
	EXPORT Section_RiskIndicators := DATASET(GetFileName('RiskIndicators'), DueDiligence.TestSeeds.CitizenshipLayouts.RiskIndicatorsSection, 
                                            CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                            
                                            
  //==========================================================
  // Input Echo Section
  //==========================================================	
	EXPORT Section_InputEcho := DATASET(GetFileName('InputEcho'), DueDiligence.TestSeeds.CitizenshipLayouts.InputEchoSection, 
                                            CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                            
END;                                            