IMPORT Data_Services,doxie,WatchDog;

file_in 			:=	WatchDog.File_Best_Supplemental;
dst_did_base	:=	DISTRIBUTE(file_in((UNSIGNED)did<>0), HASH(did));
srt_did_base	:=	SORT(dst_did_base, did, LOCAL);

EXPORT Key_Supplemental := INDEX(srt_did_base
									,{UNSIGNED6 l_did := (INTEGER)did}
									,{srt_did_base}
							    ,Data_Services.Data_location.Prefix('Watchdog_Best')+'thor_data400::key::watchdog_best_supplemental::did_'+doxie.Version_SuperKey);
