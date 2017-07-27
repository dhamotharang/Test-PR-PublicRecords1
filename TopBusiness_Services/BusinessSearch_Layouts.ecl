import address,iesp,TopBusiness_Search;

export BusinessSearch_Layouts := module

	export OptionsLayout := record				
		boolean lnbranded;		
	  boolean internal_testing;
    boolean IncludeBusinessCredit := false;
	end;

  EXPORT layout_input := record	   		 
		 iesp.TopBusinessSearch.t_TopBusinessSearchBy;		 
  end;
	
	export TopBusinessSearchRecord := record
		iesp.share.t_BusinessIdentity BusinessIds;
		boolean DisplayReportLink;
		boolean DNBDMIrecordOnly;
		iesp.topbusinessSearch.t_TopBusinessBestRecord Best;
		iesp.topbusinessSearch.t_TopBusinessMatchRecord Match;	
		iesp.topbusinessSearch.t_TopBusinessUltimateRecord Ultimate;
		string12 BusinessId;
		dataset(iesp.topbusiness_share.t_TopBusinessSourceDocInfo) SourceDocs  {MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
		boolean IsLAFN;
		boolean IsTruncated;
end;

  export matchRecScored := record
		iesp.topbusinessSearch.t_TopBusinessMatchRecord;
		unsigned2 proxweight;
		integer6 record_score;
		string2 fein_source;		
		string250 cnp_name;
	end;
	
	export tmp_output_layout_full := record	
		TopBusinessSearchRecord - iesp.share.t_BusinessIdentity;
		dataset(matchRecScored) Matches { MAXCOUNT(iesp.constants.topbusiness.MAX_COUNT_SEARCH_MATCH_PRE_ROLLUP_RECORDS)};
	  integer6 record_score;
		string2 Best_fein_source;		
		//in BIP2.0 these dot* fields will probably be 0
	  unsigned6 DotID; 
	  unsigned2	DotScore;
	  unsigned2	DotWeight;
   
	  //in BIP2.0, these EMP* fields will always be 0
	  unsigned6 EmpID; 
	  unsigned2	EmpScore; 
	  unsigned2	EmpWeight; 
	
	  //in BIP2.0, these POW* fields will always be 0
	  unsigned6 POWID; 
	  unsigned2	POWScore; 
	  unsigned2	POWWeight;
	
	  unsigned6 ProxID;
	  unsigned2	ProxScore;
	  unsigned2	ProxWeight;
	
	  unsigned6 OrgID;
	  unsigned2	OrgScore;
	  unsigned2	OrgWeight;
		
		unsigned6 SeleID;
	  unsigned2	SeleScore;
	  unsigned2	SeleWeight;
	
	  unsigned6 UltID;
	  unsigned2	UltScore;
	  unsigned2	UltWeight;
	end;	
	 
	 
	
	// 2 booleans defined in the IESP structure within the structure
	// below applies to the entire search result set as a whole
	// and not to an individual row.
	export Final := record
		string25 acctno;		 
		dataset(iesp.TopBusinessSearch.t_TopBusinessSearchRecord) Records {maxcount(iesp.Constants.TOPBUSINESS.MAX_COUNT_SEARCH_RESPONSE_RECORDS)};
	end;

  
    // Need to add weight to iesp layout for including Business Credit/SBFE records in final sort order
    EXPORT TopBizSearchRecWithWeightRec := 
      RECORD
        iesp.topbusinessSearch.t_TopBusinessSearchRecord;
        UNSIGNED2 weight;
      END;
   
   EXPORT TopBizSearchBizIdsWithWeightRec :=
     RECORD
       UNSIGNED6 OrgID;
       UNSIGNED6 SeleID;
       UNSIGNED6 UltID;
       UNSIGNED2 Weight;
     END;

end;
