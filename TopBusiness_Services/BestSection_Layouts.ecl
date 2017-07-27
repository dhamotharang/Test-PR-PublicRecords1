import iesp, BIPV2;

export BestSection_Layouts := module

	export rec_OptionsLayout := record
		boolean lnbranded;
		boolean return_only_best;
		boolean internal_testing;
		boolean IncludeNameVariations;
		string1 businessReportFetchLevel;
	end;
	
	export input := record
		string25 acctno;
		iesp.share.t_BusinessIdentity;		
	end;

	export CompanyName := record
		string120 companyName;
	end;
	
	export Address := record
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 city_name;
		string2 state;
		string5 zip;
	end;
	
	// higher than final constant to allow more variations.
	export MAX_TIN_ROWS := 200;
	export MAX_CNAME_ROWS := 200;
	
export layout_other_cnames := record
     string120 cnp_name;	   
	string120 CompanyName;
	iesp.share.t_Date DateFirstSeen;
	iesp.share.t_Date DateLastSeen;
	boolean Status;
	dataset(iesp.topbusiness_share.t_TopBusinessSourceDocInfo) SourceDocs {xpath('SourceDocs/SourceDoc'), 
	     MAXCOUNT(TopBusiness_Services.Constants.OtherCompanyNamesVariationsMax)};
  end;

	export layout_other_tins := record
	   unsigned4 dt_last_seen;
		 string2 source;
		 boolean digitsSame;
		 string9 Tin;
		 string120 CompanyName; // {MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_OTHER_COMPANIES)};
		 string120 cnp_name;
		 dataset(iesp.topbusiness_share.t_TopBusinessSourceDocInfo) SourceDocs {MAXCOUNT(MAX_TIN_ROWS)}; 
		 //{MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
	end;	
	
	export layout_Best_other_Tins := record
		string2 source;
		iesp.topbusinessReport.t_TopBusinessBestOtherTins;
	end;
		
	export final  := record
	  string20 acctno;	 	
		iesp.TopBusinessReport.t_topBusinessBestSection;
  end;
	
end;
