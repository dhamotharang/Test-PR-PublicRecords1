IMPORT Data_Services, liensv2, Doxie, vault, _control;

dFCRAMain				:=	LiensV2.file_liens_fcra_main;
dFCRAMainDist		:=	SORT(DISTRIBUTE(dFCRAMain,
											HASH(	TMSID,RMSID)),
																	TMSID,RMSID,LOCAL);
														
#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
EXPORT	key_liens_main_ID_FCRA	:=	vault.LiensV2.key_liens_main_ID_FCRA;
#ELSE
EXPORT	key_liens_main_ID_FCRA	:=	INDEX(dFCRAMainDist,{TMSID,RMSID},{dFCRAMainDist},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::main::TMSID.RMSID_' + doxie.Version_SuperKey);

#END;


