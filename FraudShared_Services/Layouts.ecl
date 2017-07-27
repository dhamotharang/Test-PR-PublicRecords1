IMPORT FraudShared, iesp;

EXPORT Layouts := MODULE

  EXPORT FilterBy_rec := RECORD
    string8   filterby_StartingReportedDate;
    string8   filterby_EndingReportedDate;
    string8   filterby_StartingEventDate;
    string8   filterby_EndingEventDate;
    string25  filterby_Disposition;
    string3   filterby_Mitigated;
    string10  filterby_NameType;
    string2   filterby_State;
    string10  filterby_PhoneNumber;
    string1   filterby_InService;
    string50  filterby_ProfessionType;
    string2   filterby_LicensedPrState;
    unsigned2 filterby_SourceTypeId;
    unsigned2 filterby_PrimarySourceEntityId;
    unsigned2 filterby_ExpectationOfVictimEntitiesId;
    string100 filterby_IndustrySegment;
    unsigned2 filterby_SuspectedDiscrepancyId;
    unsigned2 filterby_ConfidenceThatActivityWasDeceitfulId;
    unsigned2 filterby_WorkflowStageCommittedId;
    unsigned2 filterby_WorkflowStageDetectedId;
    unsigned2 filterby_ChannelsId;
    string50  filterby_CategoryOrFraudType;
    unsigned2 filterby_ThreatId;
    unsigned2 filterby_AlertLevelId;
    unsigned2 filterby_EntityTypeId;
    unsigned2 filterby_EntitySubTypeId;
    unsigned2 filterby_RoleId;
    unsigned2 filterby_EvidenceId;
    unsigned3 filterby_FileType;
    unsigned6 filterby_Did;
  END;

  EXPORT Recid_rec := RECORD
    string25  acctno;
    unsigned8 record_id;
    unsigned2 entity_type_id := 0;
    unsigned2 entity_sub_type_id := 0;
    FilterBy_rec;
  END;

  EXPORT Raw_Payload_rec := RECORD
    string25 acctno; 
    RECORDOF(FraudShared.Layouts_Key.Main);
    FilterBy_rec;
  END;
    
  EXPORT batch_search_rec := RECORD
    unsigned3 seq;
    string10  prim_range;
    string2   predir;
    string28  prim_name;
    string4   addr_suffix;
    string2   postdir;
    string10  unit_desig;
    string8   sec_range;
    string25  v_city_name;
    string2   st;
    string5   zip5;
    string4   zip4;
    unsigned6 did; 
    string9   ssn;
    string10  phone10;
    unsigned6 ultid;
    unsigned6 orgid;
    unsigned6 seleid;
    unsigned6 appendedproviderid;
    unsigned6 lnpid;
    string10  tin;
    string10  npi;
    string50  emailaddress;
    string25  ipaddress;
    string50  deviceid;
    string12  professionalid;
    FilterBy_rec;
  END; 
            
  EXPORT batch_search_flags_rec := RECORD
    batch_search_rec;
    boolean isValidSearchInput := false;
    boolean isAddress          := false;
    boolean isSSN              := false;
    boolean isPhone            := false;
    boolean isPerson           := false;
    boolean isBusiness         := false;
    boolean isEmailAddress     := false;
    boolean isDevice           := false;
    boolean isIpAddress        := false;
    boolean isProfessionalid   := false;
    boolean isProvider         := false;
    boolean isTin              := false;
  END;

  EXPORT batch_response_rec := RECORD
    batch_search_rec;
    FraudShared.Layouts_Key.Main;
    string9   fdn_idkey_ssn;
    unsigned6 fdn_idkey_did; 
  END;

  EXPORT SetOfFdnMasterId_rec := RECORD
    unsigned6     gc_id; 
    data16        FdnMasterId;
    SET OF data16 setFdnMasterIds := [];
  END;

  //=================================================================
  // DELTABASE SOAPCALL
  //=================================================================
  EXPORT t_DeltaBaseSelectRequest := RECORD             
    string Select {xpath('Select'), maxlength(3000)};
  END;

  EXPORT t_DeltaBaseSelectRequest into_in(t_DeltaBaseSelectRequest L) := TRANSFORM
    SELF := L;
  END; 
    
  EXPORT deltabase_layout := RECORD
    string    transaction_id    {XPATH('transaction_id')};
    integer   fdn_file_info_id  {XPATH('fdn_file_info_id')};
    real      file_type         {XPATH('file_type')};
    integer   gc_id             {XPATH('gc_id')};
    integer   company_id        {XPATH('company_id')};
    unsigned6 LexID             {XPATH('lexid')};
    integer   phone             {XPATH('phone')};
    integer   SSN               {XPATH('ssn')};
    integer   ip_addr           {XPATH('ip_addr')};
    string    date_added        {XPATH('date_added')};  
    integer   product_include   {XPATH('product_include')};
  END;
    
  EXPORT response_deltabase_layout := RECORD                         
    DATASET(deltabase_layout) deltaFields {XPATH('Records/Rec'), MAXCOUNT(FraudShared_Services.Constants.maxRecs)};
    string  RecsReturned                  {XPATH('RecsReturned'),MAXLENGTH(5)};
    integer responsetime                  {XPATH('_call_latency_ms')};
  END;

END;
