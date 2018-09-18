﻿import _Control;
EXPORT constants := MODULE

  EXPORT sVersion:='20180901';

  EXPORT threshold_ := 166000000;
 
  EXPORT sCluster:='~thor::';
  EXPORT sSubName:='mylife::';
 
  EXPORT sLocationIn:=sCluster+'in::'+sSubname;
  EXPORT sLocationBase:=sCluster+'base::'+sSubname;
  EXPORT sLocationPersist:=sCluster+'persist::'+sSubname;

  EXPORT sRemoteIPAddress:=_Control.IPAddress.bctlpedata11;
  //EXPORT sRemoteIPAddress := _Control.IPAddress.edata12;
  EXPORT sRemoteLocation:='/data/data_lib_2_hus2/mylife/';
	EXPORT sOutputLocation:=sRemoteLocation+sVersion+'/OUTPUT/';

END;