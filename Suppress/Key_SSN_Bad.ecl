import header, doxie, watchdog;

r :=
RECORD
	watchdog.File_Best.did;
	watchdog.File_Best.ssn;
END;
h := TABLE(watchdog.File_Best((INTEGER)ssn<>0), r);

ssn_cnt_rec :=
RECORD
	STRING9 ssn := h.ssn;
	UNSIGNED cnt := COUNT(GROUP);
END;
ssn_ddp := DEDUP(SORT(DISTRIBUTE(h,HASH(ssn)),ssn,did,LOCAL),ssn,did,LOCAL);
ssn_cnt := TABLE(ssn_ddp,ssn_cnt_rec,ssn,LOCAL);
ssn_bad := ssn_cnt(cnt > 3);

i := INDEX(ssn_bad,{s_ssn := ssn,cnt},'~thor_data400::key::ssn_bads_'+doxie.Version_SuperKey);

export Key_SSN_Bad := i;