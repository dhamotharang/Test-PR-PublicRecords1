IMPORT Orbit3, STD;

EXPORT fn_Orbit_ReceiveInstance(STRING ProductName, STRING inDate = '') := FUNCTION

	// Get Process Date of the DL build
	STRING pdate := IF(inDate <> '', inDate, mod_Utilities.CurrentDateTimeStamp):INDEPENDENT;

	// Get token for orbit user (generic) - authorization purpose.
	tokenval := Orbit3.GetToken():INDEPENDENT;

	// Receive item																					 
	ReceiveItem := Orbit3.CreateReceive(TRIM(OrbitConstants(ProductName).updatetype, LEFT, RIGHT),
																			TRIM(OrbitConstants(ProductName).datasetname, LEFT, RIGHT),
																			tokenval,
																			TRIM(OrbitConstants(ProductName).sourcename, LEFT, RIGHT),
																			TRIM(OrbitConstants(ProductName).orbitreceivedatetime(pdate))).retcode:INDEPENDENT;																						 


	// Load the received item
	STRING lItemInstanceID := IF(ReceiveItem.ReceiveInstanceID <> '0',
																ReceiveItem.ReceiveInstanceID,
																''
															);
															
	lAddReceiveFile	  := Orbit3.AddReceiveFile(tokenval,
										                         lItemInstanceID,
																					   TRIM(OrbitConstants(ProductName).componentfilename(pdate), LEFT, RIGHT)
									                           ).retcode;

	lUpdateReceive := Orbit3.UpdateReceive(TRIM(OrbitConstants(ProductName).updatetype, LEFT, RIGHT),
																				 TRIM(OrbitConstants(ProductName).datasetname, LEFT, RIGHT),
																				 tokenval,
																				 TRIM(OrbitConstants(ProductName).sourcename, LEFT, RIGHT),
																				 lItemInstanceID,
																				 TRIM(OrbitConstants(ProductName).orbitreceivedatetime(pdate))).retcode;																							 
																							
																					 
	// Creating Receive and Load Item instance
  createReceiveBuildErr := FileServices.SendEmail(OrbitConstants(ProductName).orbit_recload_err_email,
                                                  ProductName + ' Orbit Receive Item: '+ pdate + ' :FAILED',
                                                  'Orbit Load Receive Failed. Reason: ' + ReceiveItem.Message);	
  createLoadBuildSuc := FileServices.SendEmail(OrbitConstants(ProductName).orbit_receiveload_email, 
                                               ProductName + ' Orbit Receive and Load: ' + pdate + ' :SUCCESS',
                                               'Orbit Receive and Load Successful on '+ pdate);
  createLoadBuildErr := FileServices.SendEmail(OrbitConstants(ProductName).orbit_recload_err_email, 
                                               ProductName + ' Orbit Load Item: '+ pdate + ' :FAILED',
                                               'Orbit Load Item Failed. Reason: ' + lAddReceiveFile.Message);
																								 
  createLoadItem := SEQUENTIAL(OUTPUT(lUpdateReceive, NAMED('UpdateReceive')), createLoadBuildSuc);
																								 
	createReceiveInstance  :=  IF(STD.Str.ToUpperCase(ReceiveItem.Status) = 'SUCCESS',
																IF(STD.Str.ToUpperCase(lAddReceiveFile.Status) = 'SUCCESS', 
																	createLoadItem, createLoadBuildErr
																),
																createReceiveBuildErr
															);

	RETURN createReceiveInstance;
	
END;