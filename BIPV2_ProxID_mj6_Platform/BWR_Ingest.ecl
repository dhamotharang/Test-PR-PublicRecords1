﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_ProxID_mj6_PlatForm.BWR_Ingest - Ingest - SALT V3.0 Beta 2');
IMPORT BIPV2_ProxID_mj6_PlatForm,SALT30;
//If you are not ingesting as part of a header build you can use the below
O := OUTPUT(BIPV2_ProxID_mj6_PlatForm.Ingest.AllRecords_Notag,,'<your_filename_goes_here>'); // Remove _Notag to keep 'what happened' byte
BIPV2_ProxID_mj6_PlatForm.Ingest.DoStats;
O;
