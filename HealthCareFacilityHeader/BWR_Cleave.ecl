//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareFacilityHeader.BWR_Cleave - Cleaves - SALT V3.0 Gold');
IMPORT HealthCareFacilityHeader,SALT30;
//Cleave runs automatically as part of ProcIterate; use this window to run cleaves independently
HealthCareFacilityHeader.Cleave(HealthCareFacilityHeader.In_HealthFacility).BuildAll;
// If you want to test some examples - you may wish to use the CleaveService - then you don't need to to the BuildAll
// rather - build the keys below - and the cleave service will run 'live' for any LNPID you ask.
// HealthCareFacilityHeader.Keys(HealthCareFacilityHeader.In_HealthFacility).BuildData;
