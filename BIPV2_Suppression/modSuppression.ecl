IMPORT lib_thorlib;
EXPORT modSuppression:=MODULE
  EXPORT kSeleProx(STRING sVersion='qa'):=INDEX(Files.dSeleProxData,{seleid,proxid},{Files.dSeleProxData},FileNames.KeyLogicalF(sVersion));
END;