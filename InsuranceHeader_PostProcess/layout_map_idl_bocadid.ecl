boca_did_layout := RECORD
,maxLength(32000)
   unsigned6 boca_did;
   unsigned4 cnt;
  END;

export layout_map_idl_bocadid := RECORD
,maxLength(32000)
  unsigned8 idl;
  integer8 total_recordcnt;
  integer8 total_pub_recordcnt;
  integer8 total_ins_recordcnt;
  integer8 total_bocadid_cnt;
  DATASET(boca_did_layout) boca_dids;
END;