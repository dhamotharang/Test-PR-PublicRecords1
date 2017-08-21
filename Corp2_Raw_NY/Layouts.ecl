EXPORT Layouts := module 

	export MasterLayoutIn := RECORD              
				string8    corp_id_no;
				string12   microfilm_no;
				string2    record_type;
				string240  blob;				
   end; 
	 
	export MasterLayoutIn252 := RECORD              
				string8    corp_id_no;
				string12   microfilm_no;
				string2    record_type;
				string230  blob;				
   end; 
	 
  export MasterLayout := Record 	// 01 Recs  
			 string8   corpidno;
			 string12  microfilmno;
			 string2   recordtype;
			 string8   datefiled;
			 
			 //doccode string6 split into separate fields:
			 string2   doccode_CertCd;   // doccode[1..2]
			 string1   doccode_AuthTyp;  // doccode[3]
			 string1   doccode_BusTyp;   // doccode[4]
			 string1   doccode_filler;   // doccode[5]
			 string1   doccode_FictTyp;  // doccode[6]
			 
			 string1   adminnameflag;
			 string1   principalofficeflag;
			 string1   corpnameflag;
			 string1   durationdateflag;
			 string1   ficticiousnameflag;
			 string1   foreignincflag;
			 string1   foreignjurisdictionflag; 
			 string1   notforprofitflag;
			 string1   processinfoflag;
			 string1   provisionflag;
			 string1   purposeflag;
			 string1   registeredagentflag;
			 string1   stockflag;
			 string1   restatedcertificateflag;
			 string1   deadfileflag;
			 string1   constituentindicator;
			 string150 corpname;
			 string2   countyofficecode;
			 string8   doceffectivedate;
			 string8   durationdate;
			 string8   dissolutiondate;
			 string1   notforprofittype;
			 string8   foreignincdate;
			 string2   foreignjurisdictioncode;
			 string2   constituenttype;
			 string1   amendchairmanaddress;
			 string1   amendlocationaddress;
			 string1   admitpartner;
			 string1   withdrawpartner;
			 string17  filler;        
    end;
		
	export MasterLayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		MasterLayout;
	end;	
	
  export ProcAddrLayout := RECORD	// 02 Recs
			 string8   Process_corpidno;
			 string12  Process_microfilmno;
			 string2   Process_recordtype;
			 string60  Process_corpname;
			 string30  Process_addr1;
			 string30  Process_addr2;
			 string23  Process_city;
			 string3   Process_state;
			 string9   Process_zip;
			 string84  Process_filler;  
    end;
  
  export ProcAddrLayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		ProcAddrLayout;
	end;	
	
  export RegAgentLayout := RECORD    // 03 Recs  
			 string8   register_corpidno;
			 string12  register_microfilmno;
			 string2   register_recordtype;
			 string60  register_corpname;
			 string30  register_addr1;
			 string30  register_addr2;
			 string23  register_city;
			 string3   register_state;
			 string9   register_zip;
			 string84  register_filler;        
    end;
    
  export RegAgentLayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		RegAgentLayout;
	end;	
	
	export FictNameLayout := RECORD    // 04 Recs
			 string8   fictname_corpidno;
			 string12  fictname_microfilmno;
			 string2   fictname_recordtype;
			 string150 fictname_corpname;
			 string89  fictname_filler;    
   end; 
     
  export FictNameLayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		FictNameLayout;
	end;
	
  export StockLayout := Record     // 05 Recs
			 string8  stock_corpidno;
			 string12 stock_microfilmno;
			 string2  stock_recordtype;
			 string10 sharecount1;
			 string3  stocktype1;
			 string15 valuepershare1;
			 string10 sharecount2;
			 string3  stocktype2;
			 string15 valuepershare2;
			 string10 sharecount3;
			 string3  stocktype3;
			 string15 valuepershare3;
			 string10 sharecount4;
			 string3  stocktype4;
			 string15 valuepershare4;
			 string10 sharecount5;
			 string3  stocktype5;
			 string15 valuepershare5;
			 string10 sharecount6;
			 string3  stocktype6;
			 string15 valuepershare6;
			 string10 sharecount7;
			 string3  stocktype7;
			 string15 valuepershare7;
			 string10 sharecount8;
			 string3  stocktype8;
			 string15 valuepershare8;
			 string15 stock_filler;        
    end;
       
  export StockLayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		StockLayout;
	end;
	
  export ChairmanLayout := RECORD     // 06 Recs
			 string8  Chairman_corpidno;
			 string12 Chairman_microfilmno;
			 string2  Chairman_recordtype;
			 string60 Chairman_corpname;
			 string30 Chairman_addr1;
			 string30 Chairman_addr2;
			 string23 Chairman_city;
			 string3  Chairman_state;
			 string9  Chairman_zip;
			 string84 Chairman_filler;    
    end;
	       
  export ChairmanLayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		ChairmanLayout;
	end;
	
	export ExecOffLayout := RECORD     // 07 Recs
			 string8   Executive_corpidno;
			 string12  Executive_microfilmno;
			 string2   Executive_recordtype;
			 string60  Executive_corpname;
			 string30  Executive_addr1;
			 string30  Executive_addr2;
			 string23  Executive_city;
			 string3   Executive_state;
			 string9   Executive_zip;
			 string84  Executive_filler;    
    end;
  	       
  export ExecOffLayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		ExecOffLayout;
	end;
	
  export OrigPartLayout := RECORD     // 08 Recs
			 string8   origpart_corpidno;
			 string12  origpart_microfilmno;
			 string2   origpart_recordtype;
			 string150 origpart_corpname;
			 string89  origpart_filler;
    end; 
    	       
  export OrigPartLayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		OrigPartLayout;
	end;
	
	export CurrPartLayout := RECORD     // 09 Recs
			 string8   currpart_corpidno;
			 string12  currpart_microfilmno;
			 string2   currpart_recordtype;
			 string150 currpart_corpname;
			 string89  currpart_filler;
   end; 
	    	       
  export CurrPartLayoutBase	:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;	
		CurrPartLayout;
	end;
	
	export MergerLayoutIn := RECORD
			 string8    merger_corp_id_no;
			 string12   merger_microfilm_no;
			 string2    merger_record_type;
			 string8    merger_date_filed;
			 string6    merger_doc_code;
			 string1    merger_admin_name_flag;
			 string1    merger_principal_office_flag;
			 string1    merger_corp_name_flag;
			 string1    merger_duration_date_flag;
			 string1    merger_ficticious_name_flag;
			 string1    merger_foreign_inc_flag;
			 string1    merger_foreign_jurisdiction_flag; 
			 string1    merger_not_for_profit_flag;
			 string1    merger_process_info_flag;
			 string1    merger_provision_flag;
			 string1    merger_purpose_flag;
			 string1    merger_registered_agent_flag;
			 string1    merger_stock_flag;
			 string1    merger_restated_certificate_flag;
			 string1    merger_dead_file_flag;
			 string1    merger_constituent_indicator;
			 string150  merger_corp_name;
			 string2    merger_county_office_code;
			 string8    merger_doc_effective_date;												
			 string8    merger_duration_date;
			 string8    merger_dissolution_date;
			 string1    merger_not_for_profit_type;
			 string8    merger_foreign_inc_date;
			 string2    merger_foreign_jurisdiction_code;
			 string2    merger_constituent_type;
			 string1    merger_amend_chairman_address;
			 string1    merger_amend_location_address;
			 string1    merger_admit_partner;
			 string1    merger_withdraw_partner;
			 string7    merger_filler;        
   end;
	          
  export MergerLayoutBase	:= RECORD
				string1		action_flag;
				unsigned4	dt_first_received;
				unsigned4	dt_last_received;	
				MergerLayoutIn;
	 end;
	 
  //Temporary Layouts
	
	export master_incdate_tempLay := record
					MasterLayout;
				  string1 init_subseq_flag := '';
				  string8 corp_status_desc := '';					
					string8 IncDate	:= '';
	end;
	
	export master_ra_tempLay := record
         master_incdate_tempLay;
				 RegAgentLayout;
  end;
	
	export master_fictname_tempLay := record
				 FictNameLayout;
				 MasterLayout.datefiled;
				 MasterLayout.foreignjurisdictioncode;
	end;
	
	export master_exec_tempLay := Record    
				 ExecOffLayout;
				 master_ra_tempLay;
	end;
	
	export master_chairman_tempLay := Record    
         ChairmanLayout;        
				 MasterLayout;
	end;
   
	export master_process_tempLay := Record    
				 ProcAddrLayout;  
				 string8   corpidno;
				 string150 corpname;
	end; 
	
	export norm_event_tempLay := record
				MasterLayout;
				string8 norm_event_filing_date;
	end;
	
	export master_stock_tempLay := Record 
				 MasterLayout;
				 StockLayout;
	end;
	
	export norm_stock_tempLay := record
				master_stock_tempLay;
				string10 norm_sharecount;
				string3  norm_stocktype;
				string15 norm_valuepershare;
			end;
	
	export OrigPart_tempLay := record
				OrigPartLayout;
				MasterLayout.foreignjurisdictioncode;
				MasterLayout.datefiled;
	end;
	
	export CurrPart_tempLay := record
				CurrPartLayout;
				MasterLayout.foreignjurisdictioncode;
				MasterLayout.datefiled;
	end;	
	
end;	 