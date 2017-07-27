import	Header,ut;

// Remove credit bureau (experian and transunion) records since they are not in production yet
export	File_DeathMaster_Building_ssa	:=	Header.File_DID_Death_MasterV3_ssa;//(src	not	in	['EN','TN'])	:	independent;