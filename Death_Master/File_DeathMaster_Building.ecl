import	Header,ut;

// Remove credit bureau (experian and transunion) records since they are not in production yet
export	File_DeathMaster_Building	:=	Header.File_DID_Death_MasterV3;//(src	not	in	['EN','TN'])	:	independent;