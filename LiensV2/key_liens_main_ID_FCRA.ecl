IMPORT Data_Services, liensv2, Doxie;

dFCRAMain				:=	LiensV2.file_liens_fcra_main;
dFCRAMainDist		:=	SORT(DISTRIBUTE(dFCRAMain,
											HASH(	TMSID,RMSID)),
																	TMSID,RMSID,LOCAL);
														
EXPORT	key_liens_main_ID_FCRA	:=	INDEX(dFCRAMainDist,{TMSID,RMSID},{dFCRAMainDist},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::main::TMSID.RMSID_' + doxie.Version_SuperKey);
