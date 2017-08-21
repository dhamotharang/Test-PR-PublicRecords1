EXPORT Layouts := module

  shared max_size := _Dataset().max_record_size;

	export CorpAgentsLayoutIn 					 := record, maxlength(max_size)

		 string16  agen_packet_number;
		 string78  agen_name;
		 string64  agen_address_line1;
		 string64  agen_address_line2;
		 string32  agen_city;
		 string2   agen_state;  
		 string8   agen_zip_code;
		 string4   agen_zip_extension;
		 string10  agen_creation_date;
		 string10  agen_expiration_date;
		 string10  agen_inactive_date;
		 string1   agen_lf;
		 
	end;

	export CorpAgentsLayoutBase 				 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpAgentsLayoutIn;
		
	end;
	
	export CorpCorporationsLayoutIn 		 := record, maxlength(max_size)	

		 string16  corp_packet_number;
		 string144 corp_name;
		 string2   corp_entity_type;
		 string2   corp_status_code;
		 string2   corp_filing_act;
		 string10  corp_creation_date;
		 string10  corp_expiration_date;
		 string10  corp_inactive_date;
		 string64  corp_address_line1;
		 string64  corp_address_line2;
		 string45  corp_city;
		 string2   corp_state;
		 string8   corp_zip_code;
		 string4   corp_zip_extension;
		 string2   corp_orig_inc_state;
		 string10  corp_orig_inc_date;
		 string16  corp_federal_id;
		 string128 corp_fictions_name;
		 string1   corp_managers;
		 string64  corp_owner_name;
		 string1   corp_lf;
		 
	end;

	export CorpCorporationsLayoutBase 	 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpCorporationsLayoutIn;
		
	end;
		
	export CorpFilingsLayoutIn 					 := record, maxlength(max_size)

		 string16  fili_dcn;
		 string16  fili_packet_number;
		 string3   fili_filing_type;
		 string10  fili_entry_date;
		 string10  fili_filing_date;
		 string10  fili_effective_date;
		 string200 fili_comment;
		 string1   fili_legacy;
		 string1   fili_lf;
		 
	end;

	export CorpFilingsLayoutBase 				 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpFilingsLayoutIn;
		
	end;

	export CorpMergersLayoutIn					 := record, maxlength(max_size)

		 string16  merg_non_survivor_packet;
		 string16  merg_survivor_packet;
		 string10  merg_creation_date;
		 string1   merg_lf;
		 
	end;

	export CorpMergersLayoutBase 				 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpMergersLayoutIn;
		
	end;

	export CorpNamesLayoutIn 					 	 := record, maxlength(max_size)

		 string16  name_packet_number;
		 string3   name_sequence_number;
		 string1   name_name_type;
		 string115 name_name;
		 string10  name_creation_date;
		 string32  name_county;
		 string1   name_lf;
		 
	end;

	export CorpNamesLayoutBase 				 	 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpNamesLayoutIn;
		
	end;

	export CorpOfficersLayoutIn 				 := record, maxlength(max_size)

		 string16  offi_packet_number;
		 string2   offi_sequence_number;
		 string2   offi_position_type;
		 string75  offi_name;
		 string64  offi_address_line1;
		 string64  offi_address_line2;
		 string45  offi_city;
		 string2   offi_state;
		 string8   offi_zip_code;
		 string11  offi_zip_extension;
		 string10  offi_creation_date;
		 string1   offi_lf;
		 
	end;

	export CorpOfficersLayoutBase 			 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpOfficersLayoutIn;
		
	end;

	export CorpReportsLayoutIn 					 := record, maxlength(max_size)

		 string16  repo_packet_number;
		 string4   repo_year_number;
		 string16  repo_locator;
		 string10  repo_creation_date;
		 string1   repo_lf;
		 
	end;

	export CorpReportsLayoutBase 			 	 := record

		string1			action_flag;
		unsigned4		dt_first_received;
		unsigned4		dt_last_received;		
		CorpReportsLayoutIn;
		
	end;

	export Temp_CorpAgentsLayoutIn 			 := record

		 CorpAgentsLayoutIn;
		 CorpCorporationsLayoutIn;
		 
	end;
	 
	export Temp_CorpOfficersLayoutIn 		 := record

		 CorpOfficersLayoutIn;
		 CorpCorporationsLayoutIn;
		 
	end;

	export	Temp_CorpAgentMergersLayoutIn 	:= record

			Temp_CorpAgentsLayoutIn;
			CorpMergersLayoutIn;
			
	end;
	
end;	