IMPORT PRTE2_Liens, LiensV2;

EXPORT files := MODULE

SprayMain 	:=	DATASET(PRTE2_Liens.Constants.IN_PREFIX + 'main', PRTE2_Liens.Layouts.BaseMain_in,
													CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')))(tmsid != 'tmsid');
SprayStatus	:=	DATASET(PRTE2_Liens.Constants.IN_PREFIX + 'status', PRTE2_Liens.Layouts.BaseStatus_in,
													CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
//Add Status as child to Base
srt_main := SORT(SprayMain,TMSID, RMSID, -PROCESS_DATE);
srt_status := DEDUP(SORT(SprayStatus,TMSID,RMSID,RECORD_CODE,FILING_STATUS,-PROCESS_DATE),ALL);

PRTE2_Liens.Layouts.main_base_ext tBaseStatus(srt_main l, srt_status r) := TRANSFORM
self.TMSID := l.TMSID;
self.RMSID := l.RMSID;
self.process_date 	:= l.PROCESS_DATE;
self.record_code 		:= l.RECORD_CODE;
self.filing_status	:= ROW(r,LiensV2.layout_liens_main_module.layout_filing_status);
self.bug_num				:= l.bug_num;
self.cust_name			:= l.cust_name;
self := l;
END;

EXPORT MainStatus := JOIN(srt_main,
													srt_status,
													left.TMSID = right.TMSID and
													left.RMSID = right.RMSID and
													left.PROCESS_DATE = right.PROCESS_DATE,
													tBaseStatus(left,right),left outer);

EXPORT SprayParty		:=	DATASET(PRTE2_Liens.Constants.IN_PREFIX + 'party', PRTE2_Liens.Layouts.BaseParty_in,
																CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')))(tmsid != 'tmsid');
																
//Base output files
EXPORT Main_out_ext		:= DATASET(PRTE2_Liens.Constants.BASE_PREFIX + 'main', PRTE2_Liens.Layouts.main_base_ext,flat);
EXPORT Main_out := PROJECT(Main_out_ext,PRTE2_Liens.Layouts.main_base);
EXPORT Party_out_ext 	:= DATASET(PRTE2_Liens.Constants.BASE_PREFIX + 'party', PRTE2_Liens.Layouts.party_base_ext,flat); 
EXPORT Party_out:= PROJECT(Party_out_ext, PRTE2_Liens.Layouts.party_base);																
END;