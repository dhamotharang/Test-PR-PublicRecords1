IMPORT BatchShare, UtilFile;

EXPORT Layouts := MODULE

  EXPORT batch_in:=RECORD
    BatchShare.Layouts.ShareAcct;
    BatchShare.Layouts.ShareDid;
  END;

  EXPORT batch_work:=RECORD
    batch_in;
    TYPEOF(BatchShare.Layouts.ShareAcct.acctno) orig_acctno;
    Batchshare.Layouts.ShareErrors;
  END;

  EXPORT utilRec:=RECORD
    BatchShare.Layouts.ShareAcct;
    BatchShare.Layouts.ShareDid;
    UtilFile.Layout_Utility_In-did;
  END;

  EXPORT utilAddress:=RECORD
    UtilFile.Layout_Utility_In.record_date;
    UtilFile.Layout_Utility_In.addr_type;
    BatchShare.Layouts.ShareAddress-addr;
  END;

  EXPORT batch_out:=RECORD
    BatchShare.Layouts.ShareAcct;
    BatchShare.Layouts.ShareDid;
    BatchShare.Layouts.ShareErrors.error_code;
    UtilFile.Layout_Utility_In.util_type;
    STRING20 util_category;
    STRING20 util_type_desc;
    UtilFile.Layout_Utility_In.connect_date;
    UtilFile.Layout_Utility_In.date_first_seen;
    UtilFile.Layout_Utility_In.record_date;
    BatchShare.Layouts.ShareName;
    BatchShare.Layouts.SharePII;
    UtilFile.Layout_Utility_In.drivers_license_state_code;
    UtilFile.Layout_Utility_In.drivers_license;
    UtilFile.Layout_Utility_In.work_phone;
    UtilFile.Layout_Utility_In.phone;
    UtilFile.Layout_Utility_In.addr_dual;
    // flat service address and billing address
    BatchShare.MAC_ExpandLayout.Generate(utilAddress-record_date,'',2,FALSE,'_');
  END;

  EXPORT util_work:=RECORD
    batch_out;
    UtilFile.Layout_Utility_In.exchange_serial_number; // rollup key
    DATASET(utilAddress) addresses {MAXCOUNT(UtilFile_Services.Constants.MAX_ADDR_RECS)}
  END;

END;
