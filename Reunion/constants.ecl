import _Control;
EXPORT constants := MODULE

  EXPORT sVersion:='20170816';

  EXPORT threshold_ := 166000000;
 
  EXPORT sCluster:='~thor::';
  EXPORT sSubName:='mylife::';
 
  EXPORT sLocationIn:=sCluster+'in::'+sSubname;
  EXPORT sLocationBase:=sCluster+'base::'+sSubname;
  EXPORT sLocationPersist:=sCluster+'persist::'+sSubname;

  EXPORT sRemoteIPAddress:='bctlpedata11.risk.regn.net';
  //EXPORT sRemoteIPAddress := _Control.IPAddress.edata12;
  EXPORT sRemoteLocation:='/data/data_lib_2_hus2/mylife/';
	EXPORT sOutputLocation:=sRemoteLocation+sVersion+'/OUTPUT/';

END;