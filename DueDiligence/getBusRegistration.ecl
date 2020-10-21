IMPORT Business_Risk_BIP, DueDiligence;


EXPORT getBusRegistration(DATASET(DueDiligence.Layouts.Busn_Internal) inData,
													Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
													BOOLEAN includeAllBusDetails) := FUNCTION

    //get filtered data
    filteredBusRegData := DueDiligence.getBusRegistrationImpl.getFilteredData(inData, options);
    
    //if we are processing from a business perspective, we want all data
    //if we are processing from a person perspective, we only need certain information about the business
    regBusDataOptions := MODULE(DueDiligence.DataInterface.iRegisteredBusiness)
                                EXPORT BOOLEAN includeRegisteredBusinessHit := FALSE;
                                EXPORT BOOLEAN includeRegisteredAgents := TRUE;
                                EXPORT BOOLEAN includeAll := includeAllBusDetails;
                         END;
    
    
    //if requesting registered business hit
    addRegBusHit := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeRegisteredBusinessHit, DueDiligence.getBusRegistrationImpl.getRegisteredBusinessHit(inData, filteredBusRegData), inData);


    //if requesting registered agents data
    addAgents := IF(regBusDataOptions.includeAll OR regBusDataOptions.includeRegisteredAgents, DueDiligence.getBusRegistrationImpl.getRegisteredAgents(addRegBusHit, filteredBusRegData), addRegBusHit);


	
	// OUTPUT(addRegBusHit, NAMED('addRegBusHit'));	
	// OUTPUT(addAgents, NAMED('addAgentsReg'));	

	
	RETURN addAgents;
END;