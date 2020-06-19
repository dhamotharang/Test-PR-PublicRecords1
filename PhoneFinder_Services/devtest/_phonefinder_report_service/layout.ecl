IMPORT iesp;
EXPORT layout := MODULE
  
  EXPORT request := RECORD
    DATASET(iesp.phonefinder.t_PhoneFinderSearchRequest) PhoneFinderSearchRequest;
  END;

  EXPORT response := iesp.phonefinder.t_PhoneFinderSearchResponse;
  
END;
