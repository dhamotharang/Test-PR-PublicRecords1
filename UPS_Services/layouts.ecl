IMPORT BIPV2;
EXPORT layouts := MODULE

   EXPORT RecBipRecordOut2 := RECORD(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(DATASET([],BIPV2.IDfunctions.rec_SearchInput)).RecordOut2)
    STRING1 powid_status_public;
    STRING1 seleid_status_public;
    STRING1 orgid_status_public;
    STRING1 ultid_status_public;
  END;

END;
