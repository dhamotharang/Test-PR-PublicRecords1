Import Data_Services, liensv2, Doxie, ut;

dFCRAMain				:=	LiensV2.file_liens_fcra_main;
dFCRAMainDist		:=	SORT(DISTRIBUTE(dFCRAMain,HASH(	TMSID,RMSID)),
															TMSID,RMSID,LOCAL);

//DF-22188 - Deprecate speicified in thor_data400::key::liensv2::fcra::main::tmsid.rmsid_qa
ut.MAC_CLEAR_FIELDS(dFCRAMainDist, dFCRAMainDist_cleared, LiensV2.Constants.fields_to_clear_main_id_fcra);
														
EXPORT	key_liens_main_ID_FCRA	:=	INDEX(dFCRAMainDist_cleared,{TMSID,RMSID},{dFCRAMainDist_cleared},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::main::TMSID.RMSID_' + doxie.Version_SuperKey);
