import _Control;
EXPORT constants := MODULE

  EXPORT sVersion:=Reunion._config.get_sVersion;

  EXPORT threshold_ := 166000000;
 
  EXPORT sCluster:='~thor::';
  EXPORT sSubName:='mylife::';
 
  EXPORT sLocationIn:=sCluster+'in::'+sSubname;
  EXPORT sLocationBase:=sCluster+'base::'+sSubname;
  EXPORT sLocationPersist:=sCluster+'persist::'+sSubname;

  EXPORT sRemoteIPAddress:=_Control.IPAddress.bctlpedata11;
  //EXPORT sRemoteIPAddress := _Control.IPAddress.edata12;
  EXPORT sRemoteLocation:='/data/data_lib_2_hus2/mylife/data/';
	EXPORT sOutputLocation:=sRemoteLocation+sVersion[1..8]+'/OUTPUT/';

END;