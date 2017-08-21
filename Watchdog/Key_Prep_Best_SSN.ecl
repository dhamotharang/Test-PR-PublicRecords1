IMPORT Data_Services,PRTE2_Header,PRTE2_Watchdog;
//Create best SSN key
glb := watchdog.File_Best;
non_glb := watchdog.File_Best_nonglb;
non_util := watchdog.File_Best_nonutility;
nonglb_nonutil := watchdog.File_Best_nonglb_nonutility;

//SSNs into permissions layout
watchdog.KeyType_Best_SSN bestSSNs(watchdog.Layout_Best L) := transform 
 self := l;
end;

glb_flags := project(glb,bestSSNs(left));
 
//set bits for other files
watchdog.KeyType_Best_SSN SSNflags(watchdog.KeyType_Best_SSN L, watchdog.Layout_Best R, unsigned1 bit) := transform
 self.permiss := if(l.ssn!=r.ssn,l.permiss,l.permiss | bit);
 self := l;
end;

//Join setting the bits depends on what time of file you are looking at
set_nonglb := join(glb_flags,non_glb,left.did=right.did,SSNflags(left,right,4),local);
set_nonutil := join(set_nonglb,non_util,left.did=right.did,SSNflags(left,right,2),local);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
set_nonglb_nonutil := project(PRTE2_Watchdog.files.file_best,watchdog.KeyType_Best_SSN);
#ELSE
set_nonglb_nonutil := join(set_nonutil,nonglb_nonutil,left.did=right.did,SSNflags(left,right,8),local);
#END
export Key_Prep_Best_SSN := index(set_nonglb_nonutil,{set_nonglb_nonutil},Data_Services.Data_location.Prefix('Watchdog_Best')+'thor_data400::key::watchdog_best.ssn'+thorlib.wuid());