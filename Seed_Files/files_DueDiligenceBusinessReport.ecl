IMPORT Data_Services, DueDiligence;

EXPORT files_DueDiligenceBusinessReport  := MODULE
	SHARED max10k := 10000;
	SHARED max20k := 20000;
	
	SHARED GetFileName(STRING section) := FUNCTION
	
    //===============================================
    // set the prefix and middle name of the
    // super file name of the test seed files
    //===============================================
    filePrefix := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400';		
    middleName := 'dueDiligenceBusinessReport_testseed_';

	
		fn := CASE(section,      
									'Attributes' => filePrefix + '::base::' + middleName + 'attributes',
									'InputEcho' => filePrefix + '::base::' + middleName + 'inputEcho',
									'');
                  
		IF(fn = '', FAIL('Unknown Section'));
    
		RETURN fn;
	END;
	
  
  
  
  
                                        
  //==========================================================
  // Attributes Section
  //==========================================================	
	EXPORT Section_Attributes := DATASET(GetFileName('Attributes'), DueDiligence.TestSeeds.BusinessLayouts.AttributesSection, 
                                            CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                            
                                            
  //==========================================================
  // Input Echo Section
  //==========================================================	
	EXPORT Section_InputEcho := DATASET(GetFileName('InputEcho'), DueDiligence.TestSeeds.BusinessLayouts.InputEchoSection, 
                                            CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(max10k)));
                                            
END;                                            