IMPORT iesp;

EXPORT Layouts := MODULE

  EXPORT InquiryHistoryDeltabaseRequest := RECORD (iesp.fcrainquiryhistory.t_FCRAInquiryHistoryDeltabaseRequest)
  END;

  EXPORT InquiryHistoryDeltabaseResponseEx := RECORD(iesp.fcrainquiryhistory.t_FCRAInquiryHistoryDeltabaseResponseEx) 
  END;
  
  EXPORT inquiry_history_per_transaction := RECORD(iesp.fcrainquiryhistory.t_FCRAInquiryHistoryRecord) 
  END;
  

  EXPORT inquiry_history_rec := RECORD
    inquiry_history_per_transaction;
    UNSIGNED6 UniqueId;
    BOOLEAN isDeltabaseSource := FALSE;
  END;
  
  EXPORT inquiry_history_out := RECORD
    UNSIGNED6 UniqueId;
    UNSIGNED  SearchStatus;
    STRING256 Message;
    DATASET(iesp.share.t_WsException)        SearchExceptions;
    DATASET(inquiry_history_per_transaction) IndividualResults;    
  END;
END;