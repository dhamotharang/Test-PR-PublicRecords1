IMPORT bankruptcyv3, BIPV2, iesp;

EXPORT layouts :=
  MODULE
    // LAYOUT ROLLUP CONSTANTS
    EXPORT NAMES_PER_PARTY := iesp.Constants.BANKRPT.MaxPersonNames;
    EXPORT ADDRESSES_PER_PARTY := iesp.Constants.BANKRPT.MaxPersonAddresses;
    EXPORT PHONES_PER_PARTY := iesp.Constants.BANKRPT.MaxPersonPhones;
    EXPORT EMAILS_PER_PARTY := iesp.Constants.BANKRPT.MaxPersonEmails;
    EXPORT PARTIES_PER_ROLLUP := iesp.Constants.BANKRPT.MaxDebtors; // separate LIMIT for each party would be better
    EXPORT STATUSES_PER_ROLLUP := iesp.Constants.BANKRPT.MaxStatusHistory;
    EXPORT COMMENTS_PER_ROLLUP := iesp.Constants.BANKRPT.MaxComments;

    // KEY TO ROLL UP RECORDS
    EXPORT layout_rollup_key :=
      RECORD
        bankruptcyv3.key_bankruptcyV3_search_full_bip().tmsid;
      END;
    // KEY TO IDENTIFY SINGLE PARTIES
    EXPORT layout_party_subkey :=
      RECORD
        STRING1 debtor_type_1;
        bankruptcyv3.key_bankruptcyV3_search_full_bip().did;
        bankruptcyv3.key_bankruptcyV3_search_full_bip().bdid;
        BIPV2.IDlayouts.l_header_ids;
        bankruptcyv3.key_bankruptcyV3_search_full_bip().app_ssn;
        bankruptcyv3.key_bankruptcyV3_search_full_bip().ssn;
        bankruptcyv3.key_bankruptcyV3_search_full_bip().app_tax_id;
        bankruptcyv3.key_bankruptcyV3_search_full_bip().tax_id;
        BOOLEAN HasCriminalConviction;
        BOOLEAN IsSexualOffender;
      END;
    EXPORT layout_debtor_addl := RECORD
      // bankruptcyv3.key_bankruptcyV3_search_full_bip().chapter;
      // bankruptcyv3.key_bankruptcyV3_search_full_bip().corp_flag;
      // bankruptcyv3.key_bankruptcyV3_search_full_bip().disposition;
      // bankruptcyv3.key_bankruptcyV3_search_full_bip().pro_se_ind;
      // bankruptcyv3.key_bankruptcyV3_search_full_bip().converted_date;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().caseID;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().defendantID;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().recID;
      // bankruptcyv3.key_bankruptcyV3_search_full_bip().filing_type;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().business_flag;
      // bankruptcyv3.key_bankruptcyV3_search_full_bip().discharged;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_county;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().ssnSrc;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().srcDesc;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().ssnMatch;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().srcMtchDesc;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().ssnMSrc;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().screen;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().screenDesc;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().dCode;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().dCodeDesc;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().dispType;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().dispTypeDesc;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().dispReason;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().statusDate;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().holdCase;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().dateVacated;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().dateTransferred;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().activityReceipt;
    END;
    // LAYOUT FOR ADDRESSES
    EXPORT layout_address := RECORD
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_addr1;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_addr2;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_city;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_st;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_zip5;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_zip4;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_county;
    
      bankruptcyv3.key_bankruptcyV3_search_full_bip().prim_range;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().predir;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().prim_name;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().addr_suffix;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().postdir;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().unit_desig;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().sec_range;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().p_city_name;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().v_city_name;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().st;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().zip;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().zip4;
    END;
    // LAYOUT TO HOLD KEYS AND ADDRESS DATA
    EXPORT layout_address_ext := RECORD
      layout_rollup_key;
      layout_party_subkey;
      layout_address;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
    END;
    // LAYOUT TO ROLL UP ADDRESSES ON KEYS
    EXPORT layout_address_roll := RECORD
      layout_rollup_key;
      layout_party_subkey;
      DATASET(layout_address) addresses{MAXCOUNT(ADDRESSES_PER_PARTY)};
      bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
    END;
    // LAYOUT FOR PHONES
    EXPORT layout_phone := RECORD
      bankruptcyv3.key_bankruptcyV3_search_full_bip().phone;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_fax;
      STRING4 timezone :='';
    END;
    // LAYOUT TO HOLD KEYS AND PHONE DATA
    EXPORT layout_phone_ext := RECORD
      layout_rollup_key;
      layout_party_subkey;
      layout_phone;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
    END;
    // LAYOUT TO ROLL UP PHONES ON KEYS
    EXPORT layout_phone_roll := RECORD
      layout_rollup_key;
      layout_party_subkey;
      DATASET(layout_phone) phones{MAXCOUNT(PHONES_PER_PARTY)};
      bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
    END;
      // LAYOUT FOR NAMES
    EXPORT layout_name := RECORD
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_name;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().cname;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().lname;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().fname;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().mname;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().name_suffix;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().did;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().bdid;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().app_ssn;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().ssn;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().app_tax_id;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().tax_id;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().debtor_type;
    END;
    // LAYOUT TO HOLD KEYS AND NAME DATA
    EXPORT layout_name_ext := RECORD
      layout_rollup_key OR layout_party_subkey OR layout_name;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
    END;
    // LAYOUT TO ROLL UP NAMES ON KEYS
    EXPORT layout_name_roll := RECORD
      layout_rollup_key;
      layout_party_subkey;
      DATASET(layout_name) names{MAXCOUNT(NAMES_PER_PARTY)};
      bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
    END;
    //LAYOUT FOR EMAILS
    EXPORT layout_email := RECORD
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_email;
    END;
    // LAYOUT TO HOLD KEYS AND EMAIL DATA
    EXPORT layout_email_ext := RECORD
      layout_rollup_key;
      layout_party_subkey;
      layout_email;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
    END;
    // LAYOUT TO ROLL UP EMAILS ON KEYS
    EXPORT layout_email_roll := RECORD
      layout_rollup_key;
      layout_party_subkey;
      DATASET(layout_email) emails{MAXCOUNT(EMAILS_PER_PARTY)};
      bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
    END;
    // LAYOUT FOR PARTIES
    EXPORT layout_party := RECORD
      layout_party_subkey;
      layout_debtor_addl;
      DATASET(layout_name) names{MAXCOUNT(NAMES_PER_PARTY)};
      DATASET(layout_address) addresses{MAXCOUNT(ADDRESSES_PER_PARTY)};
      DATASET(layout_phone) phones{MAXCOUNT(PHONES_PER_PARTY)};
      DATASET(layout_email) emails{MAXCOUNT(EMAILS_PER_PARTY)};
    END;
    EXPORT layout_party_slim := RECORD
      layout_party AND NOT layout_debtor_addl;
    END;
        
    // LAYOUT TO HOLD KEY AND PARTY DATA AND TO JOIN NAME, ADDR, PHONE
    EXPORT layout_party_ext := RECORD
      layout_rollup_key;
      layout_party;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
    END;
    // LAYOUT TO ROLL UP PARTIES ON TMSID
    EXPORT layout_party_roll := RECORD
      layout_rollup_key;
      DATASET(layout_party) parties{MAXCOUNT(PARTIES_PER_ROLLUP)};
      bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
    END;
    // LAYOUT FOR STATUSES
    EXPORT layout_status := RECORD
      bankruptcyv3.key_bankruptcyv3_main_full().status.status_date;
      bankruptcyv3.key_bankruptcyv3_main_full().status.status_type;
    END;
    // LAYOUT TO HOLD KEY AND STATUS DATA
    EXPORT layout_status_ext := RECORD
      bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
      layout_status;
    END;
    // LAYOUT TO ROLL UP STATUSES ON TMSID
    EXPORT layout_status_roll := RECORD
      bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
      DATASET(layout_status) statuses{MAXCOUNT(STATUSES_PER_ROLLUP)};
    END;
    // LAYOUT FOR COMMENTS
    EXPORT layout_comment := RECORD
      bankruptcyv3.key_bankruptcyv3_main_full().comments.filing_date;
      bankruptcyv3.key_bankruptcyv3_main_full().comments.description;
    END;
    // LAYOUT TO HOLD KEY AND COMMENT DATA
    EXPORT layout_comment_ext := RECORD
      bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
      layout_comment;
    END;
    // LAYOUT TO ROLL UP COMMENTS ON TMSID
    EXPORT layout_comment_roll := RECORD
      bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
      DATASET(layout_comment) comments{MAXCOUNT(COMMENTS_PER_ROLLUP)};
    END;
      
    EXPORT matched_party_name_rec := RECORD
      bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_name;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().cname;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().lname;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().fname;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().mname;
    END;
      
    EXPORT Matched_party_rec := RECORD
      STRING1 party_type;
      matched_party_name_rec parsed_party;
      layout_address address;
    END;
    // FINAL FULL OUTPUT LAYOUT
    EXPORT layout_rollup := RECORD
      bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
      BOOLEAN isDeepDive;
      UNSIGNED2 penalt;
      Matched_party_rec matched_party;
      DATASET(layout_party) debtors{MAXCOUNT(PARTIES_PER_ROLLUP)};
      DATASET(layout_party_slim) attorneys{MAXCOUNT(PARTIES_PER_ROLLUP)};
      DATASET(layout_party_slim) trustees{MAXCOUNT(PARTIES_PER_ROLLUP)};
      DATASET(layout_status) status_history{MAXCOUNT(STATUSES_PER_ROLLUP)};
      DATASET(layout_comment) comment_history{MAXCOUNT(COMMENTS_PER_ROLLUP)};
      bankruptcyv3.key_bankruptcyv3_main_full().case_number;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().chapter; //was in the BKv2 main key
      bankruptcyv3.key_bankruptcyv3_main_full().date_filed;
      bankruptcyv3.key_bankruptcyv3_main_full().court_code;
      bankruptcyv3.key_bankruptcyv3_main_full().court_name;
      bankruptcyv3.key_bankruptcyv3_main_full().court_location;
      bankruptcyv3.key_bankruptcyv3_main_full().casetype;
      bankruptcyv3.key_bankruptcyv3_main_full().filing_jurisdiction;
      bankruptcyv3.key_bankruptcyv3_main_full().judge_name;
      bankruptcyv3.key_bankruptcyv3_main_full().judges_identification;
      bankruptcyv3.key_bankruptcyv3_main_full().meeting_date;
      bankruptcyv3.key_bankruptcyv3_main_full().meeting_time;
      bankruptcyv3.key_bankruptcyv3_main_full().address_341;
      bankruptcyv3.key_bankruptcyv3_main_full().assets_no_asset_indicator;
      bankruptcyv3.key_bankruptcyv3_main_full().assets;
      bankruptcyv3.key_bankruptcyv3_main_full().liabilities;
      bankruptcyv3.key_bankruptcyv3_main_full().claims_deadline;
      bankruptcyv3.key_bankruptcyv3_main_full().complaint_deadline;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().pro_se_ind; //was in the BKv2 main key
      bankruptcyv3.key_bankruptcyv3_main_full().reopen_date;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().converted_date; //was in the BKv2 main key
      STRING8 disposed_date; //in SearchV3 key, renamed discharged
      bankruptcyv3.key_bankruptcyv3_main_full().case_closing_date;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().disposition; //was in the BKv2 main key
      STRING10 orig_filing_type; //in SearchV3 key, renamed filing_type
      STRING10 orig_filing_type_ex;
      bankruptcyv3.key_bankruptcyv3_main_full().filer_type;
      STRING10 filer_type_ex;
      bankruptcyv3.key_bankruptcyV3_search_full_bip().corp_flag; //was in the BKv2 main key
      bankruptcyv3.key_bankruptcyv3_main_full().filing_status;
      bankruptcyv3.key_bankruptcyv3_main_full().orig_filing_date;
      bankruptcyv3.key_bankruptcyv3_main_full().orig_chapter;
      //addtl fields from Bkv3 main key
      bankruptcyv3.key_bankruptcyv3_main_full().method_dismiss;
      bankruptcyv3.key_bankruptcyv3_main_full().case_status;
      bankruptcyv3.key_bankruptcyv3_main_full().SplitCase;
      bankruptcyv3.key_bankruptcyv3_main_full().FiledInError;
      bankruptcyv3.key_bankruptcyv3_main_full().dateReclosed;
      bankruptcyv3.key_bankruptcyv3_main_full().trusteeID;
      bankruptcyv3.key_bankruptcyv3_main_full().caseID;
      bankruptcyv3.key_bankruptcyv3_main_full().barDate;
      bankruptcyv3.key_bankruptcyv3_main_full().transferIn;
      bankruptcyv3.key_bankruptcyv3_main_full().planConfDate;
      bankruptcyv3.key_bankruptcyv3_main_full().confHearDate;
      bankruptcyv3.key_bankruptcyv3_main_full().delete_flag;
      //all these fields are used to fill trustees
      // bankruptcyv3.key_bankruptcyv3_main_full().trusteeName;
      // bankruptcyv3.key_bankruptcyv3_main_full().trusteeAddress;
      // bankruptcyv3.key_bankruptcyv3_main_full().trusteeCity;
      // bankruptcyv3.key_bankruptcyv3_main_full().trusteeState;
      // bankruptcyv3.key_bankruptcyv3_main_full().trusteeZip;
      // bankruptcyv3.key_bankruptcyv3_main_full().trusteeZip4;
      // bankruptcyv3.key_bankruptcyv3_main_full().trusteePhone;
      // bankruptcyv3.key_bankruptcyv3_main_full().trusteeEmail;
      // bankruptcyv3.key_bankruptcyv3_main_full().DID;
      // bankruptcyv3.key_bankruptcyv3_main_full().app_SSN;
    END;
  END;
  
