import iesp;
export RegisteredAgentSection_Layouts := MODULE;

	export  rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
		string1 businessReportFetchLevel;
	end;
	
	export rec_input := record
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
		 string120 CompanyName;
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
	end;

	export rec_final := record
	  string25 acctno;
		 iesp.share.t_BusinessIdentity;
		iesp.topbusinessReport.t_TopBusinessRegisteredAgentSection;
	end;	

end;	