EXPORT Layouts := module

  shared max_size := _Dataset().max_record_size;

	export CorpAgentsLayoutIn 					 := record, maxlength(max_size)

		 string100  agen_business_id;
		 string255  agen_name;
		 string200  agen_address_line1;
		 string200  agen_address_line2;
		 string100  agen_city;
		 string2    agen_state;  
		 string5    agen_zip_code;
		 string4    agen_zip_extension;
		 string19   agen_creation_date;
		 
	end;

	export CorpAgentsLayoutBase 				 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpAgentsLayoutIn;
		
	end;
	
	export CorpCorporationsLayoutIn 		 := record, maxlength(max_size)	

		 string100  corp_business_id;
		 string255  corp_name;
		 string2    corp_entity_type;
		 string2    corp_status_code;
		 string2    corp_filing_act;
		 string19   corp_creation_date;
		 string19   corp_expiration_date;
		 string19   corp_inactive_date;
		 string200  corp_address_line1;
		 string200  corp_address_line2;
		 string100  corp_city;
		 string2    corp_state;
		 string5    corp_zip_code;
		 string4    corp_zip_extension;
		 string3    corp_orig_inc_state;
		 string19   corp_orig_inc_date;
		 string255  corp_fictions_name;
		 string5    corp_managers;
		 string100  corp_owner_name;
		 string200  corp_for_orig_name;
		 
	end;

	export CorpCorporationsLayoutBase 	 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpCorporationsLayoutIn;
		
	end;
		
	export CorpFilingsLayoutIn 					 := record, maxlength(max_size)

		 string20   fili_filing_num;
		 string100  fili_business_id;
		 string5    fili_filing_type;
		 string19   fili_entry_date;
		 string19   fili_filing_date;
		 string19   fili_effective_date;
		 string255  fili_comment;
		 
	end;

	export CorpFilingsLayoutBase 				 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpFilingsLayoutIn;
		
	end;

	export CorpMergersLayoutIn					 := record, maxlength(max_size)

		 string16  merg_non_surv_business_id;
		 string16  merg_surv_business_id;
		 string19  merg_creation_date;
		 
	end;

	export CorpMergersLayoutBase 				 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpMergersLayoutIn;
		
	end;

	export CorpNamesLayoutIn 					 	 := record, maxlength(max_size)

		 string100  name_business_id;
		 string2    name_name_type;
		 string200  name_name;
		 string19   name_creation_date;
		 string50   name_county;
		 
	end;

	export CorpNamesLayoutBase 				 	 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpNamesLayoutIn;
		
	end;

	export CorpOfficersLayoutIn 				 := record, maxlength(max_size)

		 string100 offi_business_id;
		 string3   offi_position_type;
		 string200 offi_name;
		 string200 offi_address_line1;
		 string200 offi_address_line2;
		 string200 offi_city;
		 string2   offi_state;
		 string5   offi_zip_code;
		 string4   offi_zip_extension;
		 string19  offi_creation_date;
		 
	end;

	export CorpOfficersLayoutBase 			 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpOfficersLayoutIn;
		
	end;


	export Temp_CorpAgentsLayoutIn 			 := record

		 CorpAgentsLayoutIn;
		 CorpCorporationsLayoutIn;
		 
	end;
	 
	export Temp_CorpOfficersLayoutIn 		 := record

		 CorpOfficersLayoutIn;
		 CorpCorporationsLayoutIn;
		 
	end;

	export  Temp_CorpNamesMergersLayoutIn := record
      CorpNamesLayoutIn;
      string16   merg_surv_business_id := '';
	    string200  merg_surv_business_name := '';
	    string16   merg_non_surv_business_id := '';
	    string200  merg_non_surv_business_name := '';
	    string19   merg_creation_date;
  end;
	
	export	Temp_CorpAgentMergersNamesLayoutIn 	:= record

			Temp_CorpAgentsLayoutIn;
			Temp_CorpNamesMergersLayoutIn;
			
	end;
	
	export Temp_CorpNamesCorpsLayoutIn 			 := record

		 CorpNamesLayoutIn;
		 string19   corp_creation_date;
 		 string3    corp_orig_inc_state;
		 
	end;
	
	export Temp_CorpFilingsLayoutIn 		 := record
	
     CorpFilingsLayoutIn;
		 string2    corp_entity_type;

  end;
end;	