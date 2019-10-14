import batchshare, didville, iesp, targus;

export Layouts := module

  // **************************************************************
  // common layouts
  // **************************************************************
  export common_optout := record
    unsigned4 seq;
    unsigned1 section_id := 0;
    unsigned6 did := 0; // provided or appended
    unsigned4 global_sid;
    unsigned8 record_sid;
    didville.layout_did_inbatch; // -[seq]?
    string20 transaction_id; // ???
    batchshare.Layouts.ShareErrors;
    boolean is_suppressed := false;
  end;

  export common_optout_section_rec := record
    unsigned1 section_id;
    unsigned6 did;
    boolean is_suppressed;
  end;

  export common_optout_slim := record
    unsigned4 seq; // transaction?
    dataset(common_optout_section_rec) sections;  
  end;

  export common_did_append_remote := RECORD
    batchshare.Layouts.ShareAcct;
    batchshare.Layouts.ShareDid;
    batchshare.Layouts.ShareName;
    batchshare.Layouts.SharePII;
    batchshare.Layouts.ShareAddress;
    TYPEOF(batchshare.Layouts.ShareAcct.acctno) orig_acctno;
    batchshare.Layouts.ShareErrors;
  end;

Export i_GatewayCollectionlog_DID := record
UNSIGNED6 did;
STRING20  transaction_id;
UNSIGNED4 global_sid;
UNSIGNED8 record_sid;
STRING8   date_added; // YYYYMMDD
STRING6   time_added; // HHMMSS
STRING8   process_date;
STRING    esp_method;
STRING    request_data;
STRING    response_data;

end;

end;
