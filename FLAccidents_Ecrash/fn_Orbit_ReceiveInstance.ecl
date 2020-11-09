IMPORT Orbit3, STD;

EXPORT fn_Orbit_ReceiveInstance(STRING ProductName, STRING inDate = '') := FUNCTION

	// Get Process Date of the DL build
	STRING pdate := IF(inDate <> '', inDate, mod_Utilities.CurrentDateTimeStamp):INDEPENDENT;

	// Get token for orbit user (generic) - authorization purpose.
	tokenval := Orbit3.GetToken():INDEPENDENT;

	// Receive item																					 
	ReceiveItem := Orbit3.CreateReceive(TRIM(Orbit3IConstants(ProductName).updatetype, LEFT, RIGHT),
																			TRIM(Orbit3IConstants(ProductName).datasetname, LEFT, RIGHT),
																			tokenval,
																			TRIM(Orbit3IConstants(ProductName).sourcename, LEFT, RIGHT),
																			TRIM(Orbit3IConstants(ProductName).orbitreceivedatetime(pdate))).retcode:INDEPENDENT;																						 


	// Load the received item
	STRING lItemInstanceID := IF(ReceiveItem.ReceiveInstanceID <> '0',
																ReceiveItem.ReceiveInstanceID,
																''
															);
															
	lAddReceiveFile	  := Orbit3.AddReceiveFile(tokenval,
										                         lItemInstanceID,
																					   TRIM(Orbit3IConstants(ProductName).componentfilename(pdate), LEFT, RIGHT)
									                           ).retcode;

	lUpdateReceive := Orbit3.UpdateReceive(TRIM(Orbit3IConstants(ProductName).updatetype, LEFT, RIGHT),
																				 TRIM(Orbit3IConstants(ProductName).datasetname, LEFT, RIGHT),
																				 tokenval,
																				 TRIM(Orbit3IConstants(ProductName).sourcename, LEFT, RIGHT),
																				 lItemInstanceID,
																				 TRIM(Orbit3IConstants(ProductName).orbitreceivedatetime(pdate))).retcode;																							 
																							
																					 
	// Creating Receive and Load Item instance
  createReceiveBuildErr := FileServices.SendEmail(Orbit3IConstants(ProductName).orbit_recload_err_email,
                                                  ProductName + ' Orbit Receive Item: '+ pdate + ' :FAILED',
                                                  'Orbit Load Receive Failed. Reason: ' + ReceiveItem.Message);	
  createLoadBuildSuc := FileServices.SendEmail(Orbit3IConstants(ProductName).orbit_receiveload_email, 
                                               ProductName + ' Orbit Receive and Load: ' + pdate + ' :SUCCESS',
                                               'Orbit Receive and Load Successful on '+ pdate);
  createLoadBuildErr := FileServices.SendEmail(Orbit3IConstants(ProductName).orbit_recload_err_email, 
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