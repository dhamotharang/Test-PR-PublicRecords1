IMPORT iesp;

EXPORT layout := MODULE

  EXPORT request := RECORD
    DATASET(iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocRequest) TopBusinessSourceDocRequest;
  END;

  EXPORT response := RECORD
    iesp.topbusinesssourcedoc.t_TopBusinessSourceDocResponse
  END;

END;
