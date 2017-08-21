IMPORT watchdog;

dWatchdog:=DISTRIBUTE(watchdog.File_Best_nonglb,HASH(did));
dAdults:=DISTRIBUTE(reunion.adults,HASH(did));

dJoined:=JOIN(dWatchdog,dAdults,LEFT.did=RIGHT.did,TRANSFORM(RECORDOF(watchdog.File_Best_nonglb),SELF:=LEFT;),LOCAL)
  :PERSIST('~thor::persist::mylife::watchdog');

EXPORT watchdog_for_reunion:=dJoined;