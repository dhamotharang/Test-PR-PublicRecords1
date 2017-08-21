
import DriversV2;

file_dl_searchv2 := dataset('~thor_data400::base::DL2::DLSearch_PUBLIC', DriversV2.Layout_Drivers, flat);

Layout_DL_Slim := RECORD
unsigned6 did;
string2	   dl_state;
STRING15  dl_number;
unsigned3 dt_first_seen;
unsigned3 dt_last_seen;
string1   history :='';
END;

Layout_DL_Slim SlimDLs(Driversv2.Layout_Drivers L) := TRANSFORM
self.dl_state := l.orig_state;
SELF := L;
END;

DL_Slim := PROJECT(file_dl_searchv2(did<>0), SlimDLs(LEFT));
DL_Slim_Dist := DISTRIBUTE(DL_Slim, HASH(did));
DL_Slim_Dist_Sort := SORT(DL_Slim_Dist, did, history, -dt_last_seen, -dt_first_seen, LOCAL);
res := DEDUP(DL_Slim_Dist_Sort, did, LOCAL);


export get_best_dl := res	: persist('thor::persist::fbi_cjr1:get_best_dl');
