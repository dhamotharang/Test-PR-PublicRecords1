IMPORT Watchdog_V2,dx_BestRecords,PromoteSupers;

EXPORT fn_Watchdog_Slim(STRING pversion) := MODULE

slim:=table(dx_BestRecords.key_watchdog(),{did,cnt:=sum(group,permissions)},did,merge);
										 
SortedDS := SORT(slim, did);			

EXPORT Watchdog_Slim_Sorted := PROJECT(SortedDS,TRANSFORM(Watchdog_V2.Layout_Universal_Slim,SELF.Permissions:= LEFT.cnt,SELF :=LEFT));
																													
PromoteSupers.MAC_SF_BuildProcess(Watchdog_Slim_Sorted,'~thor_data400::base::watchdog_universal_slim',seq_name,2,,true,pVersion);

EXPORT full_build	:= 
                 SEQUENTIAL(
								 Watchdog_V2.Create_Universal_Slim_Superfiles;
                 seq_name
	               );

END;


