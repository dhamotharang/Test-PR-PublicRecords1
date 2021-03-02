import dx_Cortera, iesp;
export ContactSection_Layouts := module

	export rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
		string1 businessReportFetchLevel;
		boolean IncludeCriminalIndicators := false;
		boolean restrictexperian := false;           
		
	end;
	
	export rec_Input := record
		string25 acctno;
		iesp.share.t_BusinessIdentity;
	end;
	
	export rec_layout_contacts_common := record			  
		 string50 source_docid;
		 iesp.share.t_BusinessIdentity;
		 string2  source;
		 unsigned4 date_first_seen;
		 unsigned4 date_last_seen;
		 string9  ssn;
		 unsigned6 did;
		 unsigned2 score;
		 string5  name_prefix;
		 string20 Nickname;
		 string20 name_first;
		 string20 name_middle;
		 string20 name_last;
		 string5  name_suffix;
		 string10 prim_range;
		 string2  predir;
		 string28 prim_name;
		 string4  addr_suffix;
		 string2  postdir;
		 string10 unit_desig;
		 string8  sec_range;
		 string25 city_name;
		 string2  state;
		 string5  zip;
		 string4  zip4;
		 string40 position_title;
		 string1  position_type;				
		 string10 phone;
		 string50 email; 		
		 boolean isExecutive;
		 boolean isCurrent;
		 dataset(iesp.topbusiness_share.t_TopBusinessSourceDocInfo) ContactSourceDocs {MAXCOUNT(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
	end;
	
	export rec_Final := record
		string25 acctno;		
		iesp.TopBusinessReport.t_TopBusinessContactSection;
	end;
  
  export cortera_contacts_temp := record
    dx_Cortera.Layouts.Layout_ExecLinkID.link_id;
    dx_Cortera.Layouts.Layout_ExecLinkID.persistent_record_id;
    dataset(iesp.topbusinessOtherSources.t_OtherContact) CorteraContacts;
  end;  
  
end;
