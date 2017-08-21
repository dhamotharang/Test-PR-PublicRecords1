//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_DOTID_dev.BWR_Cleave - Cleaves - SALT V3.0 Gold');
IMPORT BIPV2_DOTID_dev,SALT30;
//Cleave runs automatically as part of ProcIterate; use this window to run cleaves independently
BIPV2_DOTID_dev.Cleave(BIPV2_DOTID_dev.In_DOT).BuildAll;
// If you want to test some examples - you may wish to use the CleaveService - then you don't need to to the BuildAll
// rather - build the keys below - and the cleave service will run 'live' for any DOTid you ask.
// BIPV2_DOTID_dev.Keys(BIPV2_DOTID_dev.In_DOT).BuildData;
