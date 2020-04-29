import STD;

EXPORT mSpray(UNSIGNED1 mode):=MODULE
  EXPORT actionSprayFiles(STRING sVersion = constants.sVersion, STRING buildVersion):=FUNCTION
    sLocalDirectory:=reunion.constants.sLocationIn+buildVersion+'::';
	  sRemoteDirectory:=reunion.constants.sRemoteLocation+sVersion[1..8]+'/';
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
  		  FileServices.SprayVariable(reunion.constants.sRemoteIPAddress,sRemoteDirectory+dFilesToSpray.filename,,,,,thorlib.group(),sLocalDirectory+dFilesToSpray.filename,,,,TRUE)
  	  )
    );
  END;

  EXPORT sLocalLocation:=reunion.constants.sLocationPersist+'despray::';
  
  EXPORT actionDesprayCustomer:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dCustomerDB,,sLocalLocation+'customerdb',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'customerdb',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'customerdb.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'customerdb.dat', reunion.constants.sDesprayMovePath+'customerdb.dat')
  );
  
  EXPORT actionDesprayThirdParty:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dThirdPartyDB,,sLocalLocation+'thirdpartydb',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'thirdpartydb',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'thirdpartydb.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'thirdpartydb.dat', reunion.constants.sDesprayMovePath+'thirdpartydb.dat')
  );
  
  EXPORT actionDesprayMain:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dMain,,sLocalLocation+'main',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'main',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'main.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'main.dat', reunion.constants.sDesprayMovePath+'main.dat')
  );
  
  EXPORT actionDesprayOldAddresses:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dOldAddresses,,sLocalLocation+'oldaddresses',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'oldaddresses',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'oldaddresses.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'oldaddresses.dat', reunion.constants.sDesprayMovePath+'oldaddresses.dat')
  );
  
  EXPORT actionDesprayRelatives:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dRelatives,,sLocalLocation+'relatives',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'relatives',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'relatives.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'relatives.dat', reunion.constants.sDesprayMovePath+'relatives.dat')
  );
  
  EXPORT actionDesprayAliases:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dAliases,,sLocalLocation+'alias',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'alias',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'aliases.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'aliases.dat', reunion.constants.sDesprayMovePath+'aliases.dat')
  );
	
  EXPORT actionDesprayAdl_Score:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dAdlScore,,sLocalLocation+'adl_score',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'adl_score',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'adl_score.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'adl_score.dat', reunion.constants.sDesprayMovePath+'adl_score.dat')
  );

  EXPORT actionDesprayCollege:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dCollege,,sLocalLocation+'college',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'college',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'college.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'college.dat', reunion.constants.sDesprayMovePath+'college.dat')
  );

  EXPORT actionDesprayEmail:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dEmail,,sLocalLocation+'email',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'email',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'email.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'email.dat', reunion.constants.sDesprayMovePath+'email.dat')
  );

  EXPORT actionDesprayTax:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dTax,,sLocalLocation+'tax',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'tax',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'tax.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'tax.dat', reunion.constants.sDesprayMovePath+'tax.dat')
  );

  EXPORT actionDesprayDeed:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dDeed,,sLocalLocation+'deeds',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'deeds',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'deeds.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'deeds.dat', reunion.constants.sDesprayMovePath+'deeds.dat')
  );

  EXPORT actionDesprayFlags:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dFlags,,sLocalLocation+'flags',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'flags',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'flags.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'flags.dat', reunion.constants.sDesprayMovePath+'flags.dat')
  );

  EXPORT actionDesprayAttributes:=SEQUENTIAL(
    OUTPUT(Reunion.files(mode).dAttributes,,sLocalLocation+'attributes',CSV(SEPARATOR('|'),TERMINATOR('')),OVERWRITE,COMPRESSED),
    fileservices.Despray(sLocalLocation+'attributes',reunion.constants.sDesprayIP,reunion.constants.sDesprayLoc+'attributes.dat',,,,TRUE),
    STD.File.MoveExternalFile(reunion.constants.sDesprayIP, reunion.constants.sDesprayLoc+'attributes.dat', reunion.constants.sDesprayMovePath+'attributes.dat')
  );

  EXPORT actionDesprayAll:=PARALLEL(
    if(mode=1, PARALLEL(    
    actionDesprayCustomer,
    actionDesprayThirdParty,
    )),    
    actionDesprayMain,
    actionDesprayRelatives,    
    actionDesprayOldAddresses,
    actionDesprayAliases,
		actionDesprayAdl_Score,
		actionDesprayCollege,
		actionDesprayEmail,
		actionDesprayTax,
		actionDesprayDeed,
		actionDesprayFlags,
    actionDesprayAttributes		
  );

END;