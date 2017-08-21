EXPORT Layouts := module

	EXPORT	CorpMasterLayoutIN := RECORD
			ebcdic string6 account_number;
			ebcdic string64 legal_name_line1;
			ebcdic string60 legal_name_line2;
			ebcdic string64 search_name;   
			ebcdic string36 principal_misc; 
			ebcdic string36 principal_address;
			ebcdic string21 principal_city;
			ebcdic string2 principal_state;
			decimal5 principal_zip1;
			decimal5 principal_zip2;
			ebcdic string3 type_of_filing;
			decimal3 incorporation_qualification_month;
			decimal3 incorporation_qualification_day;
			decimal5 incorporation_qualification_year;
			ebcdic string2 place_of_incorporation;
			ebcdic string15 authorized_capital;
			ebcdic string15 paid_in_capital;
			ebcdic string1 dissolve_code;
			ebcdic string1 dissolve_sub_code;
			decimal3 dissolve_month;
			decimal3 dissolve_day;
			decimal5 dissolve_year;
			ebcdic string36 registered_agent_name;
			ebcdic string36 registered_agent_misc;
			ebcdic string36 registered_agent_address;
			ebcdic string21 registered_agent_city;
			ebcdic string2 registered_agent_state;
			decimal5 registered_agent_zip1_code;
			decimal5 registered_agent_zip2_code;
			decimal3 agent_resign_month;
			decimal3 agent_resign_day;
			decimal5 agent_resign_year;
			ebcdic string64 nature_of_business;
			decimal3 formed_month;
			decimal3 formed_day;
			decimal5 formed_year;
			ebcdic string6 merge_consolidate_to_account;
			ebcdic string64 account_comments;
			decimal3 last_incorporation_number;
			ebcdic string1 fictitious_registered_name;
			ebcdic string1 office_of_RECORDs;
			ebcdic string1 service_of_process;
			ebcdic string1 file_code;
			decimal5 last_maintenance_year;
			decimal3 last_maintenance_month;
			decimal3 last_maintenance_day;
			decimal7 last_maintenance_time;
			ebcdic string15 last_maintenance_user;
	END;
			
	EXPORT CorpMasterLayoutBase   		:= RECORD
		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpMasterLayoutIN;
	END;
	
	EXPORT OffAddrLayoutIn  :=  RECORD
		ebcdic string6 account_number;
		ebcdic string36 ofc_of_recs_misc;
		ebcdic string36 ofc_of_recs_address;
		ebcdic string21 ofc_of_recs_city;
		ebcdic string2 ofc_of_recs_state;
		decimal5 ofc_of_recs_zip_code_1;
		decimal5 ofc_of_recs_zip_code_2;
		ebcdic string1 file_code;
		decimal5 last_maint_yr;
		decimal3 last_maint_mth;
		decimal3 last_maint_day;
		decimal7 last_maint_time;
		ebcdic string15 last_maint_user;
	END;
		
	EXPORT OffAddrLayoutBase := RECORD
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;		
		OffAddrLayoutIn;
	END;
		
		EXPORT IncorporatorLayoutIn  := RECORD
	 			ebcdic string6 account_number;
   			decimal3 RECORD_sequence;
  			ebcdic string36 incorporator_name;
   			ebcdic string36 incorporator_misc;
   			ebcdic string36 incorporator_address;
   			ebcdic string21 incorporator_city;
   			ebcdic string2 incorporator_state;
   			decimal5 incorporator_zip_code_1;
   			decimal5 incorporator_zip_code_2;
   			ebcdic string1 incorporator_file_code;
   			decimal5 last_maint_yr;
  			decimal3 last_maint_mth;
   			decimal3 last_maint_day;
   			decimal7 last_maint_time;
   			ebcdic string15 last_maint_user;
		END;
		
		EXPORT IncorporatorLayoutBase   		:= RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			IncorporatorLayoutIn;
		END;
		
		EXPORT NameChangeLayoutIn  := RECORD
				ebcdic string6 account_number;
   			decimal5 history_yr;
   			decimal3 history_mth;
   			decimal3 history_day;
  			decimal3 history_type;
   			decimal3 RECORD_sequence;
   			ebcdic string64 legal_name_1;
   			ebcdic string60 legal_name_2;
   			ebcdic string64 search_name;
   			ebcdic string6 simultaneous_merge;
   			ebcdic string1 file_code;
   			decimal5 last_maint_yr;
   			decimal3 last_maint_mth;
   			decimal3 last_maint_day;
   			decimal7 last_maint_time;
   			ebcdic string15 last_maint_user;
		END;
		
		EXPORT NameChangeLayoutBase   		:= RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			NameChangeLayoutIn;
		END;
	
		EXPORT ServiceLayoutIn  := RECORD
  			ebcdic string6 account_number;
  			ebcdic string36 svc_of_proc_name;
   			ebcdic string36 svc_of_proc_misc;
   			ebcdic string36 svc_of_proc_address;
   			ebcdic string21 svc_of_proc_city;
   			ebcdic string2 svc_of_proc_state;
   			decimal5 svc_of_proc_zip_code_1;
   			decimal5 svc_of_proc_zip_code_2;
   			ebcdic string1 file_code;
   			decimal5 last_maint_yr;
   			decimal3 last_maint_mth;
   			decimal3 last_maint_day;
   			decimal7 last_maint_time;
   			ebcdic string15 last_maint_user;
		END;
		
		EXPORT ServiceLayoutBase   		:= RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			ServiceLayoutIn;
		END;		
			
		EXPORT BusinessNameLayoutIn := RECORD 
			  ebcdic string6 account_number;
   			ebcdic string64 legal_name_1;
   			ebcdic string60 legal_name_2;
   			ebcdic string64 search_name;
  		 	ebcdic string1 dissolve_code;
   			ebcdic string1 file_code;
   			decimal5 last_maint_yr;
   			decimal3 last_maint_mth;
   			decimal3 last_maint_day;
   			decimal7 last_maint_time;
   			ebcdic string15 last_maint_user;	
		END;
		
		EXPORT BusinessNameLayoutBase   		:= RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			BusinessNameLayoutIn;
		END;			
	
		EXPORT HistoryLayoutIn := RECORD
	 			ebcdic string6 account_number;
   			decimal5 history_yr;
   			decimal3 history_mth;
  			decimal3 history_day;
   			decimal3 history_type;
   			decimal3 RECORD_sequence;
   			ebcdic string148 legal_name_1;
   			ebcdic string1 file_code;
   			decimal5 last_maint_yr;
   			decimal3 last_maint_mth;
   			decimal3 last_maint_day;
   			decimal7 last_maint_time;
   			ebcdic string15 last_maint_user;	
		END;
		
		EXPORT HistoryLayoutBase   		:= RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			HistoryLayoutIn;
		END;	
		
		EXPORT AnnualReportLayoutIN := RECORD
			ebcdic string6 account_number;
			decimal5 annual_report_yr;
			ebcdic string64 current_name;
			ebcdic string36 current_misc;
			ebcdic string36 current_address;
			ebcdic string21 current_city;
			ebcdic string2 current_state;
			decimal5 current_zip_code5;
			decimal5 current_zip_code4;
			ebcdic string36 agent_name;
			ebcdic string36 agent_misc;
			ebcdic string36 agent_address;
			ebcdic string21 agent_city;
			ebcdic string2 agent_state;
			decimal5 agent_zip_code5;
			decimal5 agent_zip_code4;
			ebcdic string36 president_name;
			ebcdic string36 president_misc;
			ebcdic string36 president_address;
			ebcdic string21 president_city;
			ebcdic string2 president_state;
			decimal5 president_zip_code5;
			decimal5 president_zip_code4;
			ebcdic string36 secretary_name;
			ebcdic string36 secretary_misc;
			ebcdic string36 secretary_address;
			ebcdic string21 secretary_city;
			ebcdic string2 secretary_state;
			decimal5 secretary_zip_code5;
			decimal5 secretary_zip_code4;
			ebcdic string64 business_type;
			ebcdic string36 business_misc;
			ebcdic string36 business_address;
			ebcdic string21 business_city;
			ebcdic string2 business_state;
			decimal5 business_zip_code5;
			decimal5 business_zip_code4;
			ebcdic string64 foreign_type;
			ebcdic string36 foreign_misc;
			ebcdic string36 foreign_address;
			ebcdic string21 foreign_city;
			ebcdic string2 foreign_state;
			decimal5 foreign_zip_code5;
			decimal5 foreign_zip_code4;
			decimal3 tele_area_code;
			decimal3 tele_prefix;
			decimal5 tele_number;
			decimal5 revenue_process_yr;
			decimal3 revenue_process_mth;
			decimal3 revenue_process_day;
			ebcdic string1 file_code;
			decimal5 last_maint_yr;
			decimal3 last_maint_mth;
			decimal3 last_maint_day;
			decimal7 last_maint_time;
			ebcdic string15 last_maint_user;
		END;
		
		EXPORT AnnualReportLayoutBase  := RECORD
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			AnnualReportLayoutIn;
		END;
		
		EXPORT OfficeAddressLayout := RECORD 
			string6  CROACC;
			string36 CRORMC;
			string36 CRORAD;
			string21 CRORCT;
			string2  CRORST;
			string5  CRORZP;
			string4  CRORPL;
			string1  CROFCD;
			string4  CROMYR;
			string2  CROMMO;
			string2  CROMDY;
			string8  CROMTM;
			string15 CROMUR;			
		END;
		
		EXPORT IncorporatorsFileLayout := RECORD
			string6  CRIACC;
			string4  CRISEQ;
			string36 CRIINM;
			string36 CRIIMC;
			string36 CRIIAD;
			string21 CRIICT;
			string2  CRIIST;
			string5  CRIIZP;
			string4  CRIIPL;
			string1  CRIFCD;
			string4  CRIMYR;
			string2  CRIMMO;
			string2  CRIMDY;
			string8  CRIMTM;
			string15 CRIMUR;			
		END;	
		
		EXPORT NameChangesFileLayout := RECORD
			string6  CRNACC;
			string4  CRNHYR;
			string2  CRNHMO;
			string3  CRNHDY;
			string4  CRNTYP;
			string4  CRNSEQ;
			string64 CRNLN1;
			string60 CRNLN2;
			string64 CRNNAM;
			string6  CRNMRG;
			string1  CRNFCD;
			string4  CRNMYR;
			string2  CRNMMO;
			string2  CRNMDY;
			string8  CRNMTM;
			string15 CRNMUR;
		END;

    EXPORT ServiceofProcessFileLayout := RECORD
			string6  CRSACC; 
			string36 CRSPNM;
			string36 CRSPMC;
			string36 CRSPAD;
			string21 CRSPCT;
			string2  CRSPST;
			string5  CRSPZP;
			string4  CRSPPL;
			string1  CRSFCD;
			string4  CRSMYR;
			string2  CRSMMO;
			string2  CRSMDY;
			string8  CRSMTM;
			string15 CRSMUR;
		END;
		
		EXPORT BusinessNameFileLayout := RECORD			
			string6  CRBACC;	
			string64 CRBLN1;	
			string60 CRBLN2;
			string64 CRBNAM;
			string1  CRBDCD;
			string1  CRBFCD;
			string4  CRBMYR;
			string2  CRBMMO;
			string2  CRBMDY;
			string8  CRBMTM;
			string15 CRBMUR;			
		END;
		
		EXPORT HistoryFileLayout := RECORD
			string6   CRHACC;
			string4   CRHHYR;
			string2   CRHHMO;
			string2   CRHHDY;					
			string4   CRHTYP;
			string4   CRHSEQ;
			string148 CRHLIN;	
			string1   CRHFCD;			
			string4   CRHMYR;
			string2   CRHMMO;
			string2   CRHMDY;
			string8   CRHMTM;
			string15  CRHMUR;
		END;
		
		EXPORT AnnualLayout := RECORD
			string6	  CRAACC;
			string6	  CRARYR;
			string64  CRACNM;
			string36  CRACMC;
			string36  CRACAD;
			string21  CRACCT;
			string2	  CRACST;
			string10  CRACZP;
			string10  CRACPL;
			string36  CRAANM;
			string36  CRAAMC;
			string36  CRAAAD;
			string21  CRAACT;
			string2	  CRAAST;
			string10  CRAAZP;
			string10  CRAAPL;
			string36  CRAPNM;
			string36  CRAPMC;
			string36  CRAPAD;
			string21  CRAPCT;
			string2	  CRAPST;
			string10  CRAPZP;
			string10  CRAPPL;
			string36  CRASNM;
			string36  CRASMC;
			string36  CRASAD;
			string21  CRASCT;
			string2	  CRASST;
			string5   CRASZP;
			string4   CRASPL;
			string64  CRABNM;
			string36  CRABMC;
			string36  CRABAD;
			string21  CRABCT;
			string2	  CRABST;
			string10  CRABZP;
			string10  CRABPL;
			string64  CRAFNM;
			string36  CRAFMC;
			string36  CRAFAD;
			string21  CRAFCT;
			string2	  CRAFST;
			string6	  CRAFZP;
			string6	  CRAFPL;
			string3	  CRATL1;
			string3	  CRATL2;
			string4	  CRATL3;
			string4	  CRAPYR;
			string2	  CRAPMO;
			string2	  CRAPDY;
			string1	  CRAFCD;
			string4	  CRAMYR;
			string2	  CRAMMO;
			string2	  CRAMDY;
			string8	  CRAMTM;
			string15  CRAMUR;
		END;
		
		EXPORT CorpMasterLayout := RECORD
			string6  CRMACC;
			string64 CRMLN1;
			string60 CRMLN2;
			string64 CRMNAM;
			string36 CRMPMC;
			string36 CRMPAD;
			string21 CRMPCT;
			string2  CRMPST;
			string10 CRMPZP;
			string10 CRMPPL;
			string3  CRMTYP;
			string2  CRMIMO;
			string2  CRMIDY;
			string4  CRMIYR;
			string2  CRMPLC;
			string15 CRMAUT;
			string15 CRMPIN;
			string1  CRMDCD;
			string1  CRMDSC;
			string4  CRMDMO;
			string4  CRMDDY;
			string6  CRMDYR;
			string36 CRMANM;
			string36 CRMAMC;
			string36 CRMAAD;
			string21 CRMACT;
			string2  CRMAST;
			string10 CRMAZP;
			string10 CRMAPL;
			string4  CRMAMO;
			string4	 CRMADY;
			string6  CRMAYR;
			string64 CRMBUS;
			string2  CRMFMO;
			string2  CRMFDY;
			string4  CRMFYR;
			string6  CRMMRG;
			string64 CRMCOM;
			string4  CRMINC;
			string1  CRMFNF;
			string1  CRMORF;
			string1  CRMSPF;
			string1  CRMFCD;
			string4  CRMMYR;
			string2  CRMMMO;
			string2  CRMMDY;
			string8  CRMMTM;
			string15 CRMMUR;
		END;

		//--------------- Start Layouts for Joins ------------------------------------------------------//
		EXPORT HistOffAddr_TempLay := RECORD
			HistoryFileLayout;
			OfficeAddressLayout;
		END;
		
		EXPORT HistOffAddrCorpMast_TempLay := RECORD
		  HistOffAddr_TempLay;
		  CorpMasterLayout;
		END;
		
		EXPORT CorpMastIncorp_TempLay := RECORD
			CorpMasterLayout;
			IncorporatorsFileLayout;
		END;
		
		EXPORT CorpMastService_TempLay := RECORD
			CorpMasterLayout;
			ServiceofProcessFileLayout;
		END;
			
		EXPORT CorpMastOffAddr_TempLay := RECORD
		  CorpMasterLayout;
	    OfficeAddressLayout;
		END;	
		
		EXPORT CorpMastName_TempLay := RECORD			
			CorpMastOffAddr_TempLay;
			NameChangesFileLayout;
		END; 
		
		EXPORT Business_TempLay := RECORD			
			BusinessNameFileLayout;
			CorpMasterLayout.CRMPLC;
			CorpMasterLayout.CRMIMO;
			CorpMasterLayout.CRMIDY;
			CorpMasterLayout.CRMIYR;
		END;
		
		EXPORT normLayout := RECORD
			AnnualLayout;
			string 	Norm_AD;
			string  Norm_MC;
			string  Norm_CT;
			string  Norm_ST;
			string 	Norm_ZP;
			string  Norm_PL;
			string  Norm_type;
		END;
		
		EXPORT AnnualReport_TempLay := RECORD			
			normLayout;
			CorpMasterLayout.CRMPLC;
			CorpMasterLayout.CRMIMO;
			CorpMasterLayout.CRMIDY;
			CorpMasterLayout.CRMIYR;
		END;
		
		EXPORT History_TempLay := RECORD			
			HistoryFileLayout;
			CorpMasterLayout.CRMPLC;
			CorpMasterLayout.CRMIMO;
			CorpMasterLayout.CRMIDY;
			CorpMasterLayout.CRMIYR;
		END;
				
		EXPORT NameChanges_TempLay := RECORD			
			NameChangesFileLayout;
			CorpMasterLayout.CRMPLC;
			CorpMasterLayout.CRMIMO;
			CorpMasterLayout.CRMIDY;
			CorpMasterLayout.CRMIYR;
		END;
		
END;