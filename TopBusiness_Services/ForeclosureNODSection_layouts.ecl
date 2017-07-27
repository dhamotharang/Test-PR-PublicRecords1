import iesp;
export ForeclosureNODSection_layouts := module

	export OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
	end;
	
	export rec_input := record
		string25 acctno;
		iesp.share.t_businessIdentity;
	end;	
	

	
	
	export linkids_plus_t_Biz_Foreclosure_rec := record
			string12 ln_fares_id;
	    iesp.share.t_businessIdentity;
			string1 deed_category;
			string45 apn;
			string25 countyName;
			boolean IsForeclosure;
      boolean isNod;	
	 	  string100 sourceDocID;
			string2 source;
			iesp.topbusinessReport.t_TopBusinessPropertyForeclosure;
	end;
	export slim_NODForeRec := record
	   linkids_plus_t_Biz_Foreclosure_rec - FSourceDocs;
		 string45 parcel_number_unmatched_id;
		 string2 property_State_1;
		 string3 county;
		 string40 document_desc;
	end;
	export t_biz_PropertyForeclosureExtra := record	  
	   boolean IsForeclosure;
     boolean isNod;
		 string12 ln_fares_id;
	   iesp.topbusinessReport.t_topBusinessPropertyForeclosure;
	end;	
	export t_Biz_foreclosureNOD_rec_plus_linkids := record
	  string25 acctno;
		string12 ln_fares_id;
		
	  iesp.share.t_businessIdentity;		
		dataset(t_biz_PropertyForeclosureExtra) Foreclosures {MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FORECLOSURE_NODS)};
	  dataset(t_biz_PropertyForeclosureExtra) NoticeOfDefaults {MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FORECLOSURE_NODS)};
		//dataset(iesp.topbusinessReport.t_TopBusinessReportItemInfo) SourceDocs {xpath('PSourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
		//dataset(iesp.topBusiness_share.t_TopBusinessSourceDocInfo) SourceDocs {xpath('PSourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
  end;		
		 
	export final := record
	   string25 acctno;     		 	 
		 t_Biz_foreclosureNOD_rec_plus_linkids ForeclosureNODRecords {maxcount(10)};		 
	end;

end;

