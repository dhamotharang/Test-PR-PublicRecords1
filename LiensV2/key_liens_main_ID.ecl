import liensv2, Doxie, ut,data_services;

get_recs := LiensV2.fnOverrideFilingStatus(LiensV2.file_liens_main);
get_recs_newLayout	:=	PROJECT(get_recs,
													TRANSFORM(
														RECORDOF(LiensV2.key_liens_main_ID_FCRA),
														SELF.bCBFLag	:=	FALSE;
														SELF:=LEFT
													)
												);
dist_id := distribute(get_recs_newLayout, hash(TMSID,RMSID));
sort_id := sort(dist_id, TMSID, RMSID,local);

export 	Key_liens_main_ID := index(sort_id,{tmsid,RMSID},{sort_id},
Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::main::TMSID.RMSID_' + doxie.Version_SuperKey);
