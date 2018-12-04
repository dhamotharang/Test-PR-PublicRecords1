EXPORT Layouts := MODULE
  EXPORT BocashellBankruptcyLayout := RECORD
    unsigned6 did;
    boolean bankrupt;
    unsigned4 date_last_seen;
    string1 filing_type;
    string35 disposition;
    unsigned1 filing_count;
    unsigned1 bk_recent_count;
    unsigned1 bk_disposed_recent_count;
    unsigned1 bk_disposed_historical_count;
    unsigned1 bk_count30;
    unsigned1 bk_count90;
    unsigned1 bk_count180;
    unsigned1 bk_count12;
    unsigned1 bk_count24;
    unsigned1 bk_count36;
    unsigned1 bk_count60;
  END;
END;