IMPORT BatchShare, FraudShared, iesp, FraudDefenseNetwork_Services;

EXPORT Layouts := MODULE

  EXPORT MailingAddress := RECORD
    // copy of BatchShare.Layouts.ShareAddress, prepending mailing_ to the field names
    string100 mailing_addr          := '';
    string10  mailing_prim_range    := '';
    string2   mailing_predir        := '';
    string28  mailing_prim_name     := '';
    string4   mailing_addr_suffix   := '';
    string2   mailing_postdir       := '';
    string10  mailing_unit_desig    := '';
    string8   mailing_sec_range     := '';
    string25  mailing_p_city_name   := '';
    string2   mailing_st            := '';
    string5   mailing_z5            := '';
    string4   mailing_zip4          := '';
    string18  mailing_county_name   := '';
  END;

  EXPORT BatchIn_rec := RECORD
    unsigned4 seq := 0;
    BatchShare.Layouts.ShareAcct;
    BatchShare.Layouts.SharePII;
    BatchShare.Layouts.ShareDID;
    BatchShare.Layouts.ShareName;    
    BatchShare.Layouts.ShareAddress;  //physical or single address
    MailingAddress;                   //mailing address
    BatchShare.Layouts.SharePhone;
    unsigned6 ultid;
    unsigned6 orgid;
    unsigned6 seleid;
    string10  tin;
    string50  email_address;
    unsigned6 appendedproviderid;
    unsigned6 lnpid;
    string10  npi;
    string25  ip_address;
    string50  device_id;
    string12  professionalid;
    string10  bank_routing_number;
    string30  bank_account_number; 
    string2   dl_state;
    string25  dl_number;
    string10  geo_lat;
    string11  geo_long;
  END;

  EXPORT BatchIn_Valid_rec := RECORD
    BatchIn_rec;
    boolean hasValidInput         := false;
    boolean hasFullName           := false;
    boolean hasPhysicalAddress    := false;
    boolean hasMailingAddress     := false;
    boolean hasSSN                := false;
    boolean hasDOB                := false;
    boolean hasPhone              := false;
    boolean hasPerson             := false;
    boolean hasBusiness           := false;
    boolean hasEmailAddress       := false;
    boolean hasDevice             := false;
    boolean hasIpAddress          := false;
    boolean hasProfessionalid     := false;
    boolean hasLnpid              := false;
    boolean hasNpi                := false;
    boolean hasAppendedproviderid := false;
    boolean hasTin                := false;
    boolean hasGeo                := false;
    boolean hasBankAccount        := false;
    boolean hasDL                 := false;
  END;


  EXPORT Recid_rec := RECORD
    BatchShare.Layouts.ShareAcct;
    unsigned8 record_id;
    unsigned2 entity_type_id := 0;
    unsigned2 entity_sub_type_id := 0;
  END;

  EXPORT Raw_Payload_rec := RECORD
    BatchShare.Layouts.ShareAcct;
    FraudShared.Layouts_Key.Main;
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
	
	SHARED STRING30 fragment;
	SHARED STRING30 contributionType;
	SHARED STRING30 transactionType;

	EXPORT layout_velocity_in :=  RECORD 	//this layout is for the records found for each customer 
																				//based on records they have access to see each record 
																				//found prior to this is broken down into mulitple records 
																				//1 for each fragment type and contribution match type
		BatchShare.Layouts.ShareAcct;
		fragment; // correlates candidate to the incoming request that produced it
		contributionType; // how I can tell which ruleType to apply
		unsigned4	date;
		unsigned2 age := 0;
		unsigned8 record_id;
	END;

	//this layout is for the RULES for each customer read from MBS file (read ahead of this point from KEY)
	EXPORT  layout_rules := RECORD
		fragment;
		contributionType;
		unsigned1		fragment_weight;
		unsigned1		category_weight;
		unsigned1 	ruleNum;
		unsigned2 	numDays;
		unsigned2 	maxCnt;
		string  		description;
	END;	
	
	EXPORT layout_buckets :=  RECORD //the following layout are for TABLES used for counting
																	 //Maybe we can just use layout_rules without creating a 
																	 //separate record layout, but let's see exactly what we 
																	 //get from MBS first.
		BatchShare.Layouts.ShareAcct;
		layout_rules;
		unsigned8 record_id;
	END;
	
	EXPORT layout_buckets_found := RECORD
		layout_buckets - [record_id];
		INTEGER foundCnt;
		DATASET({unsigned8 record_id}) ds_record_ids;
	END;
	
	EXPORT layout_scored_buckets := RECORD
			layout_buckets_found;
			INTEGER velocity_score;
	END;
	
END;