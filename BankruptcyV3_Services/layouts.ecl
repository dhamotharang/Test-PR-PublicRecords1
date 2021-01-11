IMPORT bankruptcyv3, doxie, doxie_cbrs, address, dx_banko, BIPV2, FFD;
EXPORT layouts :=
  MODULE
  
    // EXT REF LAYOUTS
    EXPORT layout_tmsid_ext :=
      RECORD
        STRING50 tmsid;
        BOOLEAN isdeepdive;
        STRING30 acctno := '';
        STRING30 matchcode := '';
      END;
    
    EXPORT layout_did_ext :=
      RECORD
        doxie.layout_references;
        BOOLEAN isdeepdive;
      END;
  
    EXPORT layout_bdid_ext :=
      RECORD
        doxie_cbrs.layout_references;
        BOOLEAN isdeepdive;
    END;
    
    EXPORT layout_bip_ext :=
      RECORD
        STRING50 tmsid;
        BIPV2.IDlayouts.l_key_ids_bare;
    END;
      
    EXPORT layout_casenumber_ext :=
      RECORD
        bankruptcyv3.key_bankruptcyv3_main_full().orig_case_number;
        bankruptcyv3.key_bankruptcyv3_main_full().filing_jurisdiction;
        BOOLEAN isdeepdive;
      END;
  
    // KEY TO ROLL UP RECORDS
    EXPORT layout_rollup_key :=
      RECORD
        bankruptcyv3.key_bankruptcyv3_search_full_bip().tmsid;
      END;
    // KEY TO IDENTIFY SINGLE PARTIES
    EXPORT layout_party_subkey :=
      RECORD
        STRING1 debtor_type_1;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().did;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().bdid;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().app_ssn;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().ssn;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().app_tax_id;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().tax_id;
      END;
    EXPORT layout_debtor_addl :=
      RECORD
        bankruptcyv3.key_bankruptcyv3_search_full_bip().chapter;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().corp_flag;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().disposition;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().pro_se_ind;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().converted_date;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().caseID;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().recID;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().filing_type;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().business_flag;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().discharged;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_county;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().ssnSrc;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().srcDesc;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().ssnMatch;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().srcMtchDesc;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().ssnMSrc;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().screen;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().screenDesc;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().dCode;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().dCodeDesc;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().dispType;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().dispTypeDesc;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().dispReason;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().statusDate;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().holdCase;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().dateVacated;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().dateTransferred;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().activityReceipt;
        STRING person_filter_id := '';
        STRING2 debtor_type := '';
      END;
    // LAYOUT FOR ADDRESSES
    EXPORT layout_address :=
      RECORD
        bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_addr1;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_addr2;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_city;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_st;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_zip5;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_zip4;
        
        bankruptcyv3.key_bankruptcyv3_search_full_bip().prim_range;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().predir;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().prim_name;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().addr_suffix;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().postdir;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().unit_desig;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().sec_range;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().p_city_name;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().v_city_name;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().st;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().zip;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().zip4;
      END;
      // LAYOUT TO HOLD KEYS AND ADDRESS DATA
      EXPORT layout_address_ext :=
        RECORD
          layout_rollup_key;
          layout_party_subkey;
          layout_address;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
        END;
      // LAYOUT TO ROLL UP ADDRESSES ON KEYS
      EXPORT layout_address_roll :=
        RECORD
          layout_rollup_key;
          layout_party_subkey;
          DATASET(layout_address) addresses{MAXCOUNT(consts.ADDRESSES_PER_PARTY)};
          bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
        END;
    // LAYOUT FOR PHONES
    EXPORT layout_phone :=
      RECORD
        bankruptcyv3.key_bankruptcyv3_search_full_bip().phone;
        bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_fax;
        STRING4 timezone :='';
      END;
      // LAYOUT TO HOLD KEYS AND PHONE DATA
      EXPORT layout_phone_ext :=
        RECORD
          layout_rollup_key;
          layout_party_subkey;
          layout_phone;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
        END;
      // LAYOUT TO ROLL UP PHONES ON KEYS
      EXPORT layout_phone_roll :=
        RECORD
          layout_rollup_key;
          layout_party_subkey;
          DATASET(layout_phone) phones{MAXCOUNT(consts.PHONES_PER_PARTY)};
          bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
        END;
      // LAYOUT FOR NAMES
      EXPORT layout_name :=
        RECORD
          bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_name;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_lname;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_fname;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_mname;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_name_suffix;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().cname;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().lname;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().fname;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().mname;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().name_suffix;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().did;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().bdid;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().app_ssn;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().ssn;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().app_tax_id;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().tax_id;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().debtor_type;
        END;
      // LAYOUT TO HOLD KEYS AND NAME DATA
      EXPORT layout_name_ext :=
        RECORD
          layout_rollup_key OR layout_party_subkey OR layout_name;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
        END;
      // LAYOUT TO ROLL UP NAMES ON KEYS
      EXPORT layout_name_roll :=
        RECORD
          layout_rollup_key;
          layout_party_subkey;
          DATASET(layout_name) names{MAXCOUNT(consts.NAMES_PER_PARTY)};
          bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
        END;
      // LAYOUT FOR EMAILS
      EXPORT layout_email :=
        RECORD
          bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_email;
        END;
    // LAYOUT TO HOLD KEYS AND EMAIL DATA
      EXPORT layout_email_ext :=
        RECORD
          layout_rollup_key;
          layout_party_subkey;
          layout_email;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
        END;
      // LAYOUT TO ROLL UP EMAILS ON KEYS
      EXPORT layout_email_roll :=
        RECORD
          layout_rollup_key;
          layout_party_subkey;
          DATASET(layout_email) emails{MAXCOUNT(consts.EMAILS_PER_PARTY)};
          bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
        END;

      EXPORT withdrawn_status_rec := RECORD
        STRING10 withdrawnid := '';
        STRING8 withdrawndate := '';
        STRING35 withdrawndisposition := '';
        STRING8 withdrawndispositiondate := '';
      END;
      // LAYOUT FOR PARTIES
      EXPORT layout_party :=
        RECORD
          layout_party_subkey;
          layout_debtor_addl;
          DATASET(layout_name) names{MAXCOUNT(consts.NAMES_PER_PARTY)};
          DATASET(layout_address) addresses{MAXCOUNT(consts.ADDRESSES_PER_PARTY)};
          DATASET(layout_phone) phones{MAXCOUNT(consts.PHONES_PER_PARTY)};
          DATASET(layout_email) emails{MAXCOUNT(consts.EMAILS_PER_PARTY)};
          withdrawn_status_rec WithdrawnStatus;
          FFD.Layouts.CommonRawRecordElements; // FCRA FFD
        END;
      EXPORT layout_party_slim :=
        RECORD
          layout_party_subkey;
          DATASET(layout_name) names{MAXCOUNT(consts.NAMES_PER_PARTY)};
          DATASET(layout_address) addresses{MAXCOUNT(consts.ADDRESSES_PER_PARTY)};
          DATASET(layout_phone) phones{MAXCOUNT(consts.PHONES_PER_PARTY)};
          DATASET(layout_email) emails{MAXCOUNT(consts.EMAILS_PER_PARTY)};
        END;
      // LAYOUT TO HOLD KEY AND PARTY DATA AND TO JOIN NAME, ADDR, PHONE
      EXPORT layout_party_ext :=
        RECORD
          layout_rollup_key;
          layout_party;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
        END;
      // LAYOUT TO ROLL UP PARTIES ON TMSID
      EXPORT layout_party_roll :=
        RECORD
          layout_rollup_key;
          DATASET(layout_party) parties{MAXCOUNT(consts.PARTIES_PER_ROLLUP)};
          bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
        END;
      // LAYOUT FOR STATUSES
      EXPORT layout_status :=
        RECORD
          bankruptcyv3.key_bankruptcyv3_main_full().status.status_date;
          bankruptcyv3.key_bankruptcyv3_main_full().status.status_type;
        END;
      // LAYOUT TO HOLD KEY AND STATUS DATA
      EXPORT layout_status_ext :=
        RECORD
          bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
          layout_status;
        END;
      // LAYOUT TO ROLL UP STATUSES ON TMSID
      EXPORT layout_status_roll :=
        RECORD
          bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
          DATASET(layout_status) statuses{MAXCOUNT(consts.STATUSES_PER_ROLLUP)};
        END;
      // LAYOUT FOR COMMENTS
      EXPORT layout_comment :=
        RECORD
          bankruptcyv3.key_bankruptcyv3_main_full().comments.filing_date;
          bankruptcyv3.key_bankruptcyv3_main_full().comments.description;
        END;
      // LAYOUT TO HOLD KEY AND COMMENT DATA
      EXPORT layout_comment_ext :=
        RECORD
          bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
          layout_comment;
        END;
      // LAYOUT TO ROLL UP COMMENTS ON TMSID
      EXPORT layout_comment_roll :=
        RECORD
          bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
          DATASET(layout_comment) comments{MAXCOUNT(consts.COMMENTS_PER_ROLLUP)};
        END;
      // LAYOUT TO HOLD DOCKET DATA
      EXPORT layout_docket :=
        RECORD
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.DocketText;
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.FiledDate;
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.Pacer_EnteredDate;
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.PacerCaseID;
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.AttachmentURL;
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.EntryNumber;
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.DocketEntryID;
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.DRCategoryEventID;
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.EnteredDate;
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.CatEvent_Description;
          dx_banko.layouts.i_Layout_Key_Banko_CourtCode_CaseNumber.CatEvent_Category;
        END;
      EXPORT layout_docket_ext :=
        RECORD
          bankruptcyv3.key_bankruptcyV3_main_full().tmsid;
          layout_docket;
        END;
      // LAYOUT TO ROLL UP DOCKET TEXT ON TMSID
      EXPORT layout_docket_roll :=
        RECORD
          bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
          DATASET(layout_docket) dockets{MAXCOUNT(consts.DOCKETS_PER_ROLLUP)};
        END;
        
      EXPORT matched_party_name_rec := RECORD
          bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_name;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().cname;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().lname;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().fname;
          bankruptcyv3.key_bankruptcyv3_search_full_bip().mname;
      END;
      
      EXPORT Matched_party_rec := RECORD
          STRING1 party_type;
          STRING14 did;
          matched_party_name_rec parsed_party;
          layout_address address;
      END;
      
      EXPORT layout_trustee := RECORD
          bankruptcyv3.key_bankruptcyv3_main_full().DID;
          bankruptcyv3.key_bankruptcyv3_main_full().trusteeID;
          bankruptcyv3.key_bankruptcyv3_main_full().app_SSN;
          TYPEOF(bankruptcyv3.key_bankruptcyv3_main_full().trusteeName) orig_name;
          address.Layout_Clean_Name;
          TYPEOF(bankruptcyv3.key_bankruptcyv3_main_full().trusteeAddress) orig_address;
          TYPEOF(bankruptcyv3.key_bankruptcyv3_main_full().trusteeCity) orig_city;
          TYPEOF(bankruptcyv3.key_bankruptcyv3_main_full().trusteeState) orig_st;
          TYPEOF(bankruptcyv3.key_bankruptcyv3_main_full().trusteeZip) orig_zip;
          TYPEOF(bankruptcyv3.key_bankruptcyv3_main_full().trusteeZip4) orig_zip4;
          address.Layout_Clean182;
          TYPEOF(bankruptcyv3.key_bankruptcyv3_main_full().trusteePhone) phone;
      END;
      
      
      // FINAL FULL OUTPUT LAYOUT
      EXPORT layout_rollup :=
        RECORD
          bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
          BOOLEAN isDeepDive;
          UNSIGNED2 penalt;
          Matched_party_rec matched_party;
          DATASET(layout_party) debtors{MAXCOUNT(consts.PARTIES_PER_ROLLUP)};
          DATASET(layout_party_slim) attorneys{MAXCOUNT(consts.PARTIES_PER_ROLLUP)};
          DATASET(layout_status) status_history{MAXCOUNT(consts.STATUSES_PER_ROLLUP)};
          DATASET(layout_comment) comment_history{MAXCOUNT(consts.COMMENTS_PER_ROLLUP)};
          DATASET(layout_docket) docket_history{MAXCOUNT(consts.DOCKETS_PER_ROLLUP)};
          bankruptcyv3.key_bankruptcyv3_main_full().case_number;
          STRING24 full_case_number;
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
          bankruptcyv3.key_bankruptcyv3_main_full().reopen_date;
          bankruptcyv3.key_bankruptcyv3_main_full().case_closing_date;
          bankruptcyv3.key_bankruptcyv3_main_full().filer_type;
          STRING10 filer_type_ex;
          bankruptcyv3.key_bankruptcyv3_main_full().filing_status;
          bankruptcyv3.key_bankruptcyv3_main_full().orig_filing_date;
          bankruptcyv3.key_bankruptcyv3_main_full().orig_chapter;
          // new in V3
          bankruptcyv3.key_bankruptcyv3_main_full().SplitCase;
          bankruptcyv3.key_bankruptcyv3_main_full().FiledInError;
          bankruptcyv3.key_bankruptcyv3_main_full().dateReclosed;
          bankruptcyv3.key_bankruptcyv3_main_full().caseID;
          bankruptcyv3.key_bankruptcyv3_main_full().barDate;
          bankruptcyv3.key_bankruptcyv3_main_full().transferIn;
          bankruptcyv3.key_bankruptcyV3_main_full().AssocCode;
          layout_trustee trustee;
          BOOLEAN has_docket_info := FALSE;
          BIPV2.IDlayouts.l_header_ids;
          FFD.Layouts.CommonRawRecordElements; // FCRA FFD
        END;
  END;
  
