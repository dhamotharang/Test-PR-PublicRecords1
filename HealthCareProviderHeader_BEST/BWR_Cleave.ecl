//This is the code to execute in a builder window
#workunit('name','HealthCareProviderHeader_BEST.BWR_Cleave - Cleaves - SALT V2.9 Beta 2');
IMPORT HealthCareProviderHeader_BEST,SALT29;
//Cleave runs automatically as part of ProcIterate; use this window to run cleaves independently
HealthCareProviderHeader_BEST.Cleave(HealthCareProviderHeader_BEST.In_HealthProvider).BuildAll;
// If you want to test some examples - you may wish to use the CleaveService - then you don't need to to the BuildAll
// rather - build the keys below - and the cleave service will run 'live' for any LNPID you ask.
// HealthCareProviderHeader_BEST.Keys(HealthCareProviderHeader_BEST.In_HealthProvider).BuildData;
