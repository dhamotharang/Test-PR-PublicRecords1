IMPORT Watchdog_V2,dx_BestRecords,PromoteSupers;

EXPORT fn_Watchdog_Slim(STRING pversion) := MODULE

NewDistributedFile := DISTRIBUTE(Watchdog_V2.fn_build_merged, HASH(did));

Slim := PROJECT(NewDistributedFile, TRANSFORM(Watchdog_V2.Layout_Universal_Slim,SELF:=LEFT));

EXPORT Watchdog_Slim_Sorted := SORT(Slim, did);

PromoteSupers.MAC_SF_BuildProcess(Watchdog_Slim_Sorted,'~thor_data400::base::watchdog_universal_slim',seq_name,2,,true,pVersion);

EXPORT full_build	:= 
                 SEQUENTIAL(
								 Watchdog_V2.Create_Universal_Slim_Superfiles;
                 seq_name
	               );

END;