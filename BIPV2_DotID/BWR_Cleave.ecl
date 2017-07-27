//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_DOTID.BWR_Cleave - Cleaves - SALT V3.3.0');
IMPORT BIPV2_DOTID,SALT33;
//Cleave runs automatically as part of ProcIterate; use this window to run cleaves independently
BIPV2_DOTID.Cleave(BIPV2_DOTID.In_DOT).BuildAll;
// If you want to test some examples - you may wish to use the CleaveService - then you don't need to to the BuildAll
// rather - build the keys below - and the cleave service will run 'live' for any DOTid you ask.
// BIPV2_DOTID.Keys(BIPV2_DOTID.In_DOT).BuildData;
