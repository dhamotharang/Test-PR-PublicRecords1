IMPORT FraudDefenseNetwork, iesp;

EXPORT Layouts := MODULE

		EXPORT search := RECORD
			 UNSIGNED8 	 			Record_ID;
		END;
		
	EXPORT FilterBy := RECORD
			string8  filterby_StartingReportedDate ;
			string8  filterby_EndingReportedDate ;
			string8  filterby_StartingEventDate ;
			string8  filterby_EndingEventDate ;
			string25 filterby_Disposition ;
			string3  filterby_Mitigated ;
			string10 filterby_NameType ;
			string2  filterby_State ;
			string10 filterby_PhoneNumber ;
			string1  filterby_InService ;
			string50 filterby_ProfessionType ;
			string2  filterby_LicensedPrState ;
			unsigned2 filterby_SourceTypeId ;
			unsigned2 filterby_PrimarySourceEntityId ;
			unsigned2 filterby_ExpectationOfVictimEntitiesId ;
			string100 filterby_IndustrySegment;
			unsigned2 filterby_SuspectedDiscrepancyId ;
			unsigned2 filterby_ConfidenceThatActivityWasDeceitfulId ;
			unsigned2 filterby_WorkflowStageCommittedId ;
			unsigned2 filterby_WorkflowStageDetectedId;
			unsigned2 filterby_ChannelsId ;
			string50  filterby_CategoryOrFraudType;
			unsigned2 filterby_ThreatId ;
			unsigned2 filterby_AlertLevelId ;
			unsigned2 filterby_EntityTypeId;
			unsigned2 filterby_EntitySubTypeId;
			unsigned2 filterby_RoleId;
			unsigned2 filterby_EvidenceId;
			unsigned3 filterby_FileType;
			unsigned6 filterby_Did;
	END;

		EXPORT RecidUid_rec := RECORD
			STRING25 acctno;
			UNSIGNED8 record_id;
			UNSIGNED2	entity_type_id := 0;
			UNSIGNED2	entity_sub_type_id := 0;
			FilterBy;
		END;
				
		
		EXPORT raw_rec := RECORD
			 STRING25 acctno; 
			 RECORDOF(FraudDefenseNetwork.Layouts_Key.Main);
			 FilterBy;
		END;
		
		EXPORT batch_search_rec := RECORD
			UNSIGNED3 seq;
			STRING10 prim_range;
			STRING2 predir;
			STRING28 prim_name;
			STRING4 addr_suffix;
			STRING2 postdir;
			STRING10 unit_desig;
			STRING8 sec_range;
			STRING25 v_city_name;
			STRING2 st;
			STRING5 zip5;
			STRING4 zip4;
			UNSIGNED6 did; 
			STRING9 ssn;
			STRING10 phone10;
			UNSIGNED6 ultid;
			UNSIGNED6 orgid;
			UNSIGNED6 seleid;
			UNSIGNED6 appendedproviderid;
			UNSIGNED6 lnpid;
			STRING10 tin;
			STRING10 npi;
			STRING50 emailaddress;
			STRING25 ipaddress;
			STRING50 deviceid;
			STRING12 professionalid;
			FilterBy;
		END; 
	
						
	EXPORT batch_search_rec_flags := RECORD 
		batch_search_rec;
		Boolean isValidSearchInput := false;
		Boolean isAddress		 			 := false;
   	Boolean isSSN		           := false;
    Boolean isPhone	           := false;
    Boolean isPerson	         := false;
    Boolean isBusiness	       := false;
    Boolean isEmailAddress	   := false;
    Boolean isDevice		       := false;
    Boolean isIpAddress	       := false;
    Boolean isProfessionalid	 := false;
    Boolean isProvider		     := false;
    Boolean isTin				       := false;
	END;

	EXPORT batch_response_rec := RECORD
		batch_search_rec;
		frauddefensenetwork.Layouts_Key.Main;
		STRING9   fdn_idkey_ssn;
		UNSIGNED6 fdn_idkey_did; 
	END;

	EXPORT rec_excl_ind_types_in := RECORD
		STRING25 ind_type;
  END;

	EXPORT Count_Recs_Layout := RECORD
		UNSIGNED3   file_type ;
	END;

  EXPORT SetOfFdnMasterId := RECORD
    UNSIGNED6 gc_id; 
    DATA16    FdnMasterId;
    SET OF DATA16 setFdnMasterIds := [];
  END;

		//=================================================================
		// DELTABASE SOAPCALL
		//=================================================================
		EXPORT t_DeltaBaseSelectRequest := RECORD             
			 STRING Select {xpath('Select'), maxlength(3000)};
		END;
		
		EXPORT t_DeltaBaseSelectRequest into_in(t_DeltaBaseSelectRequest L) := TRANSFORM
			 SELF := L;
    END; 
		
		EXPORT deltabase_layout := RECORD
			 STRING     transaction_id				{XPATH('transaction_id')};
			 INTEGER    fdn_file_info_id			{XPATH('fdn_file_info_id')};
			 REAL       file_type							{XPATH('file_type')};
			 INTEGER    gc_id									{XPATH('gc_id')};
			 INTEGER    company_id						{XPATH('company_id')};
			 UNSIGNED6  LexID									{XPATH('lexid')};
			 INTEGER    phone									{XPATH('phone')};
			 INTEGER    SSN										{XPATH('ssn')};
			 INTEGER    ip_addr								{XPATH('ip_addr')};
			 STRING     date_added				  	{XPATH('date_added')};	
			 INTEGER	  product_include				{XPATH('product_include')};
    END;
		
		EXPORT response_deltabase_layout := RECORD                         
	     DATASET(deltabase_layout) deltaFields        {XPATH('Records/Rec'), MAXCOUNT(constants.maxRecs)};
			 STRING  RecsReturned                         {XPATH('RecsReturned'),MAXLENGTH(5)};
	     INTEGER responsetime                         {XPATH('_call_latency_ms')};
    END;

END;
