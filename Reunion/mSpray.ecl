EXPORT mSpray:=MODULE
  EXPORT actionSprayFiles(STRING sVersion = constants.sVersion):=FUNCTION
    sLocalDirectory:=constants.sLocationIn+sVersion+'::';
	  sRemoteDirectory:=constants.sRemoteLocation+sVersion[1..8]+'/';
    dFilesToSpray:=DATASET([
      {'mylife1.dat'},
      {'mylife2.dat'},
      {'mylife3.dat'},
      {'mylife4.dat'},
      {'mylife5.dat'},
      {'mylife6.dat'}
    ],{STRING filename;});
	
    RETURN NOTHOR(
      APPLY(
  	    dFilesToSpray,
  		  FileServices.SprayVariable(constants.sRemoteIPAddress,sRemoteDirectory+dFilesToSpray.filename,,,,,thorlib.group(),sLocalDirectory+dFilesToSpray.filename,,,,TRUE)
  	  )
    );
  END;

  EXPORT sLocalLocation:=constants.sLocationPersist+'despray::';
  
  EXPORT actionDesprayCustomer:=SEQUENTIAL(
    OUTPUT(Reunion.files.dCustomerDB,,sLocalLocation+'customerdb',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'customerdb',constants.sRemoteIPAddress,constants.sOutputLocation+'customerdb.dat',,,,TRUE)
  );
  
  EXPORT actionDesprayThirdParty:=SEQUENTIAL(
    OUTPUT(Reunion.files.dThirdPartyDB,,sLocalLocation+'thirdpartydb',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'thirdpartydb',constants.sRemoteIPAddress,constants.sOutputLocation+'thirdpartydb.dat',,,,TRUE)
  );
  
  EXPORT actionDesprayMain:=SEQUENTIAL(
    OUTPUT(Reunion.files.dMain,,sLocalLocation+'main',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'main',constants.sRemoteIPAddress,constants.sOutputLocation+'main.dat',,,,TRUE)
  );
  
  EXPORT actionDesprayOldAddresses:=SEQUENTIAL(
    OUTPUT(Reunion.files.dOldAddresses,,sLocalLocation+'oldaddresses',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'oldaddresses',constants.sRemoteIPAddress,constants.sOutputLocation+'oldaddresses.dat',,,,TRUE)
  );
  
  EXPORT actionDesprayRelatives:=SEQUENTIAL(
    OUTPUT(Reunion.files.dRelatives,,sLocalLocation+'relatives',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'relatives',constants.sRemoteIPAddress,constants.sOutputLocation+'relatives.dat',,,,TRUE)
  );
  
  EXPORT actionDesprayAliases:=SEQUENTIAL(
    OUTPUT(Reunion.files.dAliases,,sLocalLocation+'alias',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'alias',constants.sRemoteIPAddress,constants.sOutputLocation+'aliases.dat',,,,TRUE)
  );
	
  EXPORT actionDesprayAdl_Score:=SEQUENTIAL(
    OUTPUT(Reunion.files.dAdlScore,,sLocalLocation+'adl_score',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'adl_score',constants.sRemoteIPAddress,constants.sOutputLocation+'adl_score.dat',,,,TRUE)
  );

  EXPORT actionDesprayCollege:=SEQUENTIAL(
    OUTPUT(Reunion.files.dCollege,,sLocalLocation+'college',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'college',constants.sRemoteIPAddress,constants.sOutputLocation+'college.dat',,,,TRUE)
  );

  EXPORT actionDesprayEmail:=SEQUENTIAL(
    OUTPUT(Reunion.files.dEmail,,sLocalLocation+'email',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'email',constants.sRemoteIPAddress,constants.sOutputLocation+'email.dat',,,,TRUE)
  );

  EXPORT actionDesprayTax:=SEQUENTIAL(
    OUTPUT(Reunion.files.dTax,,sLocalLocation+'tax',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'tax',constants.sRemoteIPAddress,constants.sOutputLocation+'tax.dat',,,,TRUE)
  );

  EXPORT actionDesprayDeed:=SEQUENTIAL(
    OUTPUT(Reunion.files.dDeed,,sLocalLocation+'deeds',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'deeds',constants.sRemoteIPAddress,constants.sOutputLocation+'deeds.dat',,,,TRUE)
  );

  EXPORT actionDesprayFlags:=SEQUENTIAL(
    OUTPUT(Reunion.files.dFlags,,sLocalLocation+'flags',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'flags',constants.sRemoteIPAddress,constants.sOutputLocation+'flags.dat',,,,TRUE)
  );

  EXPORT actionDesprayAll:=PARALLEL(
    actionDesprayRelatives,
    actionDesprayThirdParty,
    actionDesprayOldAddresses,
    actionDesprayAliases,
    actionDesprayMain,
    actionDesprayCustomer,
		actionDesprayAdl_Score,
		actionDesprayCollege,
		actionDesprayEmail,
		actionDesprayTax,
		actionDesprayDeed,
		actionDesprayFlags		
  );
END;