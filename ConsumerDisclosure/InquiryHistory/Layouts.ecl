IMPORT iesp;

EXPORT Layouts := MODULE

  EXPORT InquiryHistoryDeltabaseRequest := iesp.fcrainquiryhistory.t_FCRAInquiryHistoryDeltabaseRequest;

  EXPORT InquiryHistoryDeltabaseResponseEx := iesp.fcrainquiryhistory.t_FCRAInquiryHistoryDeltabaseResponseEx;

  EXPORT inquiry_history_per_transaction := iesp.fcrainquiryhistory.t_FCRAInquiryHistoryRecord;

  EXPORT EncryptionKeyRequest := iesp.ws_securelogaccess.t_KeyDecryptionEncryptionKey;

  EXPORT DecryptionEncryptionKeyResponse := iesp.ws_securelogaccess.t_KeyDecryptionEncryptionKeyResponse;

  EXPORT inquiry_history_rec := RECORD
    inquiry_history_per_transaction;
    UNSIGNED6 UniqueId;
    UNSIGNED8 group_rid;
    BOOLEAN isDeltabaseSource := FALSE;
  END;

  EXPORT inquiry_history_out := RECORD
    UNSIGNED6 UniqueId;
    UNSIGNED  SearchStatus;
    STRING256 Message;
    DATASET(iesp.share.t_WsException)        SearchExceptions;
    DATASET(inquiry_history_per_transaction) IndividualResults;
  END;

  EXPORT decrypted_keys := RECORD
    string key_group;
    unsigned1 key_version;
    string key_encrypted;
    string key_decrypted;
  END;

  EXPORT decrypted_xml_rec := RECORD
    UNSIGNED8 group_rid;
    STRING report_options;
    STRING9 ssn;
    STRING25 drivers_license_number;
    STRING2 drivers_license_state;
    STRING20 name_first;
    STRING20 name_last;
    STRING20 name_middle;
    STRING20 name_suffix;
    STRING90 addr_street;
    STRING25 addr_city;
    STRING2 addr_state;
    STRING5 addr_zip5;
    STRING4 addr_zip4;
    STRING8 dob;
    STRING state_id_number;
    STRING state_id_state;
    STRING phone_nbr;
    STRING email_addr;
    STRING120 eu_company_name;
    STRING90 eu_addr_street;
    STRING25 eu_addr_city;
    STRING2 eu_addr_state;
    STRING5 eu_addr_zip5;
    STRING10 eu_phone_nbr;
  END;

END;
