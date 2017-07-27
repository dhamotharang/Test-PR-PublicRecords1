//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_mj6.BWR_Cleave - Cleaves - SALT V2.8 Gold SR1');
IMPORT BIPV2_ProxID_mj6,SALT28;
//Cleave runs automatically as part of ProcIterate; use this window to run cleaves independently
BIPV2_ProxID_mj6.Cleave(BIPV2_ProxID_mj6.In_DOT_Base).BuildAll;
// If you want to test some examples - you may wish to use the CleaveService - then you don't need to to the BuildAll
// rather - build the keys below - and the cleave service will run 'live' for any Proxid you ask.
// BIPV2_ProxID_mj6.Keys(BIPV2_ProxID_mj6.In_DOT_Base).BuildData;
