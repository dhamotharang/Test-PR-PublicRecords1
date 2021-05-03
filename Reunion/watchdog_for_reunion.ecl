IMPORT watchdog;

dWatchdog:=DISTRIBUTE(watchdog.File_Best_nonglb,HASH(did)); //1,043,689,475
dAdults:=DISTRIBUTE(reunion.adults,HASH(did));

dJoined:=JOIN(dWatchdog,dAdults,LEFT.did=RIGHT.did,TRANSFORM(RECORDOF(watchdog.File_Best_nonglb),SELF:=LEFT;),LOCAL)
  :PERSIST('~thor::persist::mylife::watchdog'); //456,848,781

EXPORT watchdog_for_reunion:=dJoined;