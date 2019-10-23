//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_ProxID.BWR_Cleave - Cleaves - SALT V3.11.3');
IMPORT BIPV2_ProxID,SALT311;
//Cleave runs automatically as part of ProcIterate; use this window to run cleaves independently
BIPV2_ProxID.Cleave(BIPV2_ProxID.In_DOT_Base).BuildAll;
// If you want to test some examples - you may wish to use the CleaveService - then you don't need to to the BuildAll
// rather - build the keys below - and the cleave service will run 'live' for any Proxid you ask.
// BIPV2_ProxID.Keys(BIPV2_ProxID.In_DOT_Base).BuildData;
