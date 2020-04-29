import _Control, riskwise;
EXPORT constants := MODULE

  EXPORT sVersion := Reunion._config.get_sVersion; //'20200212'

  EXPORT sMode(unsigned1 mode) := trim(case(mode, 
            1 => 'full',
            2 => 'core',
            3 => 'derogatory',
            ''));

  EXPORT sFile(unsigned1 record_type) := trim(case(record_type, 
                1 => 'customer_database',
                2 => 'third_party_database',
                3 => 'main',
				        4 => 'old_addresses',
                5 => 'relatives',
                6 => 'alias',
				        7 => 'adl_score',
                8 => 'email',
                9 => 'college',
				        10 => 'deeds',
                11 => 'tax',
                12 => 'flags',
                13 => 'attributes',
				        ''));

  EXPORT threshold_ := 166000000;
 
  EXPORT sCluster:='~thor::';
  EXPORT sSubName:='mylife::';
 
  EXPORT sLocationIn:=sCluster+'in::'+sSubname;
  EXPORT sLocationBase:=sCluster+'base::'+sSubname;
  EXPORT sLocationPersist:=sCluster+'persist::'+sSubname;

  EXPORT sRemoteIPAddress:=_Control.IPAddress.bctlpedata11;
  EXPORT sRemoteLocation:='/data/data_lib_2_hus2/mylife/data/';
	EXPORT sOutputLocation:=sRemoteLocation+sVersion[1..8]+'/OUTPUT/';

  EXPORT sDesprayIP :='bctlpbatchio04.noam.lnrm.net';
  EXPORT sDesprayLoc:='/data/prod_r3/b1058817/dali_files/';
	EXPORT sDesprayMovePath:='/data/prod_r3/b1058817/incoming/';

  EXPORT sRetry    := 3;
  EXPORT sTimeout  := 15;
  EXPORT sThreads  := 2;
  EXPORT sRoxieIP  := riskwise.shortcuts.prod_batch_analytics_roxie;
  EXPORT sGateways := '';
  EXPORT Seg_size := 10000000; //10M

	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax,
  // byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data  
  EXPORT DataRestrictionMask := '0000000000000000000000000';
  // byte 10 restricts SSA Death Master - set to '1' to allow																							
  EXPORT DataPermissionMask := '0000000000000';			
  
  EXPORT DPPA        := 3;
  EXPORT GLB         := 5;
  EXPORT isFCRA      := 'NONFCRA';
  EXPORT HistoryDate := 999999;

  EXPORT LeadInt_Batch_Serv   := 'Models.LeadIntegrity_Batch_Service';
  EXPORT ProfBoost_Batch_Serv := 'ProfileBooster.Batch_Service';
  EXPORT BocaShell_Batch_Serv := 'Risk_Indicators.BocaShell50_Batch_Service';

END;