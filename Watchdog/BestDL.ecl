import Drivers;

Layout_DL_Slim := RECORD
unsigned6 did;
STRING15  dl_number;
unsigned3 dt_first_seen;
unsigned3 dt_last_seen;
string1   history :='';
END;

Layout_DL_Slim SlimDLs(Drivers.Layout_DL L) := TRANSFORM
SELF := L;
END;

DL_Slim := PROJECT(Drivers.File_Dl(did<>0), SlimDLs(LEFT));
DL_Slim_Dist := DISTRIBUTE(DL_Slim, HASH(did));
DL_Slim_Dist_Sort := SORT(DL_Slim_Dist, did, history, -dt_last_seen, -dt_first_seen, LOCAL);
DL_Slim_Dist_Dedup := DEDUP(DL_Slim_Dist_Sort, did, LOCAL);

export BestDL := DL_Slim_Dist_Dedup : persist('persist::Watchdog_DL');