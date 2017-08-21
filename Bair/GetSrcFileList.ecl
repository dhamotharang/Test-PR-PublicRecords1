import _control;

EXPORT GetSrcFileList(string version = '', string subDir = '') := function
	
	pLandingZone 	:= '/data/bair/';
	path    			:= pLandingZone + subDir + '/';
	pServerIP			:= Bair._Constant.bair_batchlz;

  file_list :=	FileServices.RemoteDirectory(pServerIP, path, '*.'+ version[1..8] + '.' + version[10..] + '.*nsv*'):independent;
  return file_list;

end;
