IMPORT FCRA, Risk_indicators;

EXPORT Layouts_Derog_Info := MODULE

	EXPORT layout_derog_process := RECORD
		layouts.layout_derogs_input;
		Layout_Derogs BJL;
		Layouts.Layout_Liens Liens;
	END;
	
  EXPORT layout_bk_chapter := record
    string3 chapter;
  end;
  
	EXPORT 	layout_derog_process_plus := RECORD
		layout_derog_process;
		DATASET(fcra.Layout_Override_bk_filing) bk_corrections {MAXCOUNT(100)};
		DATASET(fcra.layout_override_crim_offender) crim_corrections {MAXCOUNT(100)};
		STRING50 rmsid; // liens extras
		string50 tmsid; // liens extras
		unsigned4 date_first_seen;	// liens extras
		unsigned4 date_last_seen;	// liens extras
		boolean evictionInd;
		string50 bk_tmsid; // bk extras
		string5  court_code; // bk extras
		string7  case_num; // bk extras
		string30 sor_number;  // sex offender extra
		unsigned4 bk_disp_date;
    DATASET(layout_bk_chapter) bk_chapters {MAXCOUNT(50)};
    
	END;
	
	EXPORT layout_extended := RECORD
		layout_derog_process;
		string50 bk_tmsid;
		string5  court_code; // bk extras
		string7  case_num; 
		string35 crim_case_num; // criminal extras
		STRING50 rmsid; // liens extras
		string50 tmsid; // liens extras
		unsigned4 date_first_seen;	// liens extras
		unsigned4 date_last_seen;	// liens extras
		boolean evictionInd;
		string30 sor_number; // sex offender extra
		unsigned4 bk_disp_date;
    string60 offender_key;
    DATASET(layout_bk_chapter) bk_chapters {MAXCOUNT(10)};
	END;	
	
  EXPORT 	layout_extended_plus_ftd := record
		layout_extended;
		string200 ftd;	
		string8 DateFiled ; 
		string8 ReleaseDate ;
	end;
	
	EXPORT Layout_derog_process_plus_ftd := record
		layout_derog_process_plus;	
		string200 ftd;
		string8 DateFiled ; 
		string8 ReleaseDate ;
	end;

	EXPORT 	layout_derog_process_plus_slim_PR := RECORD
		layout_derog_process -BJL -Liens;
		STRING50 rmsid; // liens extras
		string50 tmsid; // liens extras
		unsigned4 date_first_seen;	// liens extras
		unsigned4 date_last_seen;	// liens extras
		boolean evictionInd;
		string name_type;
		string Orig_name;
		string OrigFilingNumber;
		string certificateNumber;
		string irsSerialNumber;
		string CaseNumberL;
		string sort2Date;
		string ProcessDate;
	END;		

	export plaintiff_rec := record
		unsigned6 did;
		string tmsid;
		string rmsid;
		string name_type;
		string plaintiff;
		string DateLastSeen;
	end;

  export LNJ_attrs := RECORD
		integer lnj_recent_unreleased_count;
		integer lnj_historical_unreleased_count;
		integer lnj_unreleased_count12;
		integer lnj_recent_released_count;
		integer lnj_historical_released_count;
		integer lnj_released_count12;
		string8  lnj_last_unreleased_date;
		integer lnj_last_released_date;
		integer lnj_eviction_count;
		integer lnj_eviction_count12;
		integer lnj_last_eviction_date;
		integer lnj_eviction_recent_unreleased_count;
		integer lnj_eviction_historical_unreleased_count;
		integer lnj_eviction_recent_released_count;
		integer lnj_eviction_historical_released_count;
		integer lnj_unreleased_civil_judgment_cnt;   
		integer lnj_unreleased_civil_judgment_amt;     
		integer lnj_released_civil_judgment_cnt;       
		integer lnj_released_civil_judgment_amt;       
		integer lnj_unreleased_federal_tax_cnt;        
		integer lnj_unreleased_federal_tax_amt;        
		integer lnj_released_federal_tax_cnt;          
		integer lnj_released_federal_tax_amt;          
		integer lnj_unreleased_foreclosure_cnt;        
		integer lnj_unreleased_foreclosure_amt;        
		integer lnj_released_foreclosure_cnt;          
		integer lnj_released_foreclosure_amt;          
		integer lnj_unreleased_landlord_tenant_cnt;    
		integer lnj_unreleased_landlord_tenant_amt;    
		integer lnj_released_landlord_tenant_cnt;      
		integer lnj_released_landlord_tenant_amt;      
		integer lnj_unreleased_lispendens_cnt;            
		integer lnj_released_lispendens_cnt;                  
		integer lnj_unreleased_other_lj_cnt;           
		integer lnj_unreleased_other_lj_amt;           
		integer lnj_released_other_lj_cnt;             
		integer lnj_released_other_lj_amt;             
		integer lnj_unreleased_other_tax_cnt;          
		integer lnj_unreleased_other_tax_amt;          
		integer lnj_released_other_tax_cnt;            
		integer lnj_released_other_tax_amt;            
		integer lnj_unreleased_small_claims_cnt;       
		integer lnj_unreleased_small_claims_amt;       
		integer lnj_released_small_claims_cnt;         
		integer lnj_released_small_claims_amt; 
		//new jdgmt attributes	
		integer lnj_lien_cnt;
		integer lnj_lien_total;
		string8 lnj_last_lien_unreleased_date;
		integer lnj_last_lien_released_date;
		integer lnj_liens_unreleased_all_tax_cnt;
		integer lnj_liens_unreleased_all_tax_amt;
		integer lnj_liens_released_all_tax_cnt;
		integer lnj_liens_released_all_tax_amt;
		string8 lnj_last_allTax_unreleased_date;
		integer lnj_last_allTax_released_date;
		integer lnj_liens_unreleased_state_tax_cnt;
		integer lnj_liens_unreleased_state_tax_amt;
		integer lnj_liens_released_state_tax_cnt;
		integer lnj_liens_released_state_tax_amt;
		string8 lnj_last_state_unreleased_date;
		integer lnj_last_state_released_date;
		integer lnj_liens_unreleased_federal_tax_cnt;
		integer lnj_liens_unreleased_federal_tax_amt;
		integer lnj_liens_released_federal_tax_cnt;
		integer lnj_liens_released_federal_tax_amt;
		string8 lnj_last_federal_unreleased_date;
		integer lnj_last_federal_released_date;		
		//new jdgmt attributes
		integer lnj_jgmt_cnt;	
		string8 lnj_last_jgmt_unreleased_date;
		integer lnj_last_jgmt_released_date;
		integer lnj_jgmt_total;
	end;		
	
	EXPORT Liens_Working := RECORD
		string8 DateFiled ;    
		string50 LJType           ;    
		string15 Amount             ;    
		string8 ReleaseDate    ;    
		string120 Defendant;
		string120 Plaintiff ;
		string8 SatisfiedDate      ;           
		string16 FilingDescription;
		String1 Eviction;
		string20 FilingNumber       ;    
		string10 FilingBook         ;    
		string10 FilingPage         ;    
		string60 Agency             ;    
		string35 AgencyCounty       ;    
		string2 AgencyState         ; 
		string FileTypeDesc;
		string8 VendorDateLastSeen   ;  
	END;

	EXPORT 	layout_derog_process_plus_working := RECORD
		layout_derog_process_plus_slim_PR;
		LNJ_attrs;		
		Liens_Working;
		string PersistId;
		unsigned ConsumerStatementId;
  string2 Filing_Type_Id;
  string Party_PersistId;
	END;	
	
	EXPORT layout_derog_process_plus_workingDF := RECORD
		layout_derog_process_plus_working;
		STRING DF;
		STRING DF2;
		STRING DF3;
		STRING DF4;
		boolean isSuits;
	END;
	
	
	EXPORT Liens := RECORD
		string30 Seq                ;
  unsigned6 did;
		string8 DateFiled ;  
  string2 LienTypeID;
		string50 LienType           ;    
		string15 Amount             ;    
		string8 ReleaseDate    ;    
		string8 DateLastSeen   ;    
		string20 FilingNumber       ;    
		string10 FilingBook         ;    
		string10 FilingPage         ;    
		string60 Agency             ;    
		string35 AgencyCounty       ;    
		string2 AgencyState         ;  
		unsigned ConsumerStatementId;
	END;
	
	EXPORT Liens_seq := RECORD
		string30 Seq ;
		unsigned6 did;
		DATASET(Liens) LnJLiens;
	END;

	EXPORT Judgments := RECORD
		string30 Seq ;
		unsigned6 did;
		string8 DateFiled          ;     
  string2 JudgmentTypeID;
		string50 JudgmentType      ;           
		string15 Amount            ;           
		string8 ReleaseDate      ;           
		string16 FilingDescription;           
		string8 DateLastSeen  ;                
		string120 Defendant   ;                
		string120 Plaintiff   ;                
		string20 FilingNumber ;                
		string10 FilingBook   ;                
		string10 FilingPage   ;                
		string1 Eviction      ;                
		string60 Agency       ;                
		string35 AgencyCounty ;                
		string2 AgencyState    ;
		unsigned ConsumerStatementId;
	END;	
	
	EXPORT Judgments_seq := RECORD
		string30 Seq ;
		unsigned6 did;
		DATASET(Judgments) LnJJudgments;
	END;	

	export LNR_AttrIbutes := RECORD 
		string3	LnJEvictionTotalCount                  ;         
		string3 LnJEvictionTotalCount12Month         ;           
		string2 LnjEvictionTimeNewest           ;           
		string3 LnJJudgmentSmallClaimsCount ;           
		string3 LnjJudgmentCourtCount       ;           
		string3 LnjJudgmentForeclosureCount ;           
		string3 LnjLienJudgmentSeverityIndex    ;           
		string3 LnjLienJudgmentCount            ;           
		string3 LnjLienJudgmentCount12Month     ;           
		string3 LnJLienTaxCount         ;           
		string3 LnjLienJudgmentOtherCount       ;           
		string2 LnjLienJudgmentTimeNewest       ;           
		string7 LnjLienJudgmentDollarTotal      ;           
		string3 LnjLienCount                    ;           
		string2 LnjLienTimeNewest               ;           
		string7 LnjLienDollarTotal              ;                 
		string2 LnjLienTaxTimeNewest            ;           
		string7 LnjLienTaxDollarTotal           ;           
		string3 LnjLienTaxStateCount            ;           
		string2 LnjLienTaxStateTimeNewest       ;           
		string7 LnjLienTaxStateDollarTotal      ;           
		string3 LnjLienTaxFederalCount          ;           
		string2 LnjLienTaxFederalTimeNewest     ;           
		string7 LnjLienTaxFederalDollarTotal    ;           
		string3 LnjJudgmentCount                ;           
		string2 LnjJudgmentTimeNewest           ;           
		string7 LnjJudgmentDollarTotal          ; 
	END;
	
	EXPORT LJ_PublicRecords := RECORD
		unsigned4 seq;
		unsigned6 did;
		DATASET(Liens) LnJLiens {MAXCOUNT(99)};
		DATASET(Judgments) LnJJudgments {MAXCOUNT(99)};
	END;	
	
	EXPORT LJ_Attributes := RECORD
		LNJ_attrs;
	END;	
	EXPORT LJ_DataSets := RECORD
		DATASET(Liens) LnJLiens {MAXCOUNT(99)};
		DATASET(Judgments) LnJJudgments {MAXCOUNT(99)};
	END;	
	
	EXPORT LJ_Records := RECORD
		DATASET(Liens) LnJLiens {MAXCOUNT(99)};
		DATASET(Judgments) LnJJudgments {MAXCOUNT(99)};
	END;	
	
	EXPORT layout_derog_process_plus_LJ_PR := RECORD
		layout_derog_process_plus_slim_PR;
		LJ_PublicRecords;
	END;	
	EXPORT layout_derog_process_plus_LJ_withAttrs := RECORD
		layout_derog_process_plus_slim_PR;
		LJ_Records;
		LNJ_attrs;
	END;		

	EXPORT layout_derog_process_plus_LnJ := RECORD
		layout_derog_process_plus;
		LJ_Records;
		LNJ_attrs;
	END;

	EXPORT LJ_Public_Records := RECORD
		LJ_Records;
		LNJ_attrs;
	END;
	
	EXPORT final_LJ_Public_Records := RECORD
		LJ_Records;	
		LNR_AttrIbutes;
	END;
	
EXPORT layout_derog_process_plus_TOGETHER := RECORD
		layout_derog_process_plus;
		string ftd;
		string PersistId;
		string name_type;
		string orig_name;
		string vendordatelastseen;
		string8 DateFiled ;	
	 STRING DF;
		STRING DF2;
		STRING DF3;
		STRING DF4;
		string sort2Date;
		string8 ReleaseDate    ; 
		string ProcessDate;
		string Filingnumber;
		string Filingbook;
		string FilingPage;
		string OrigFilingNumber;
		string certificateNumber;
		string irsSerialNumber;
		string CaseNumberL;
		string AgencyState;
		string AgencyCounty;
		string Amount;
		string FtdDec;
END;	
	

EXPORT layout_extended_plus_TOGETHER := RECORD
		layout_extended_plus_ftd;
		string PersistId;
		string name_type;
		string orig_name;
		string vendordatelastseen;
	 STRING DF;
		STRING DF2;
		STRING DF3;
		STRING DF4;
		string sort2Date;
		string ProcessDate;
		string Filingnumber;
		string Filingbook;
		string FilingPage;
		string OrigFilingNumber;
		string certificateNumber;
		string irsSerialNumber;
		string CaseNumberL;
		string AgencyState;
		string AgencyCounty;
		string Amount;
		string FtdDec;
				boolean isSuits;
END;		

EXPORT layout_export := record
		string30 Seq ;
		unsigned6 did;
		STRING50 rmsid; // liens extras
		string50 tmsid; // liens extras
		unsigned4 date_first_seen;	// liens extras
		unsigned4 date_last_seen;	// liens extras
		boolean evictionInd;
		string8 DateFiled          ;           
		string15 Amount            ;           
		string8 ReleaseDate      ;           
		string16 ftd;           
		string20 FilingNumber ;                
		string10 FilingBook   ;                
		string10 FilingPage   ;                
		string1 Eviction      ;                
		string60 Agency       ;                
		string35 AgencyCounty ;                
		string2 AgencyState    ;
		string8 archive_date_6mo;
		string8 archive_date_12mo;
		string8 archive_date_24mo;
		STRING DF;
		STRING DF2;
		STRING DF3;
		STRING DF4;
		INTEGER   eviction_count12_6mos := 0;
		INTEGER   eviction_count12_12mos := 0;
		INTEGER   eviction_count12_24mos := 0;
		INTEGER   liens_unreleased_count12_6mos := 0;
		INTEGER   liens_unreleased_count12_12mos := 0;
		INTEGER   liens_unreleased_count12_24mos := 0;
		unsigned  historydate;
		string OrigFilingNumber;
		string certificateNumber;
		string irsSerialNumber;
		string CaseNumberL;
		string sort2Date;
		string ProcessDate;
		boolean isSuits;
		string ftdDesc;
end;	
	
END;