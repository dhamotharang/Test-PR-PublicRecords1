Import Data_Services, liensv2, Doxie, ut;

get_recs := LiensV2.file_liens_fcra_main;
dist_id := distribute(get_recs, hash(TMSID,RMSID));
sort_id := sort(dist_id, TMSID, RMSID,local);
dFillbCBFlag	:=	JOIN(
										sort_id,
										DEDUP(SORT(DISTRIBUTE(LiensV2.file_Hogan_party,
											HASH(	TMSID,RMSID)),
														TMSID,RMSID,bCBFlag,LOCAL), // We want any FALSE records at the top
														TMSID,RMSID,LOCAL),
											LEFT.tmsid	=	RIGHT.tmsid	AND
											LEFT.rmsid	=	RIGHT.rmsid,
										TRANSFORM(
											RECORDOF(LEFT),
											SELF.bCBFlag	:=	IF(RIGHT.tmsid<>'',RIGHT.bCBFlag,FALSE);
											SELF					:=	LEFT;
										),
										LEFT OUTER,
										LOCAL
									);

export 	key_liens_main_ID_FCRA := index(dFillbCBFlag,{tmsid,RMSID},{dFillbCBFlag},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::main::TMSID.RMSID_' + doxie.Version_SuperKey);