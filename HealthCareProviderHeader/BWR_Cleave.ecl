//This is the code to execute in a builder window
#workunit('name','HealthCareProviderHeader.BWR_Cleave - Cleaves - SALT V2.9 Gold');
IMPORT HealthCareProviderHeader,SALT29;
//Cleave runs automatically as part of ProcIterate; use this window to run cleaves independently
HealthCareProviderHeader.Cleave(HealthCareProviderHeader.In_HealthProvider).BuildAll;
// If you want to test some examples - you may wish to use the CleaveService - then you don't need to to the BuildAll
// rather - build the keys below - and the cleave service will run 'live' for any LNPID you ask.
// HealthCareProviderHeader.Keys(HealthCareProviderHeader.In_HealthProvider).BuildData;
