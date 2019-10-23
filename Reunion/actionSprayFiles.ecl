EXPORT actionSprayFiles(STRING sVersion):=FUNCTION
  sLocalDirectory:=constants.sLocationIn+sVersion+'::';
	sRemoteDirectory:=constants.sRemoteLocation+sVersion+'/';
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
