EXPORT Layouts := module

	export CountyDBExtractLayoutIn 					:= Record
			string10 	entity_rsn;
			string10 	tran_rsn;
			string10 	county_rsn;
			string300	county_name;
	end;
	
	export CountyDBExtractLayoutBase 				:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			CountyDBExtractLayoutIn;
	end;
	
	export EntityDBExtractLayoutIn 					:= Record
			string10 	entity_rsn;
			string11 	registry;
			string10 	registration_date;
			string50 	bus_status;
			string10 	notice_date;
			string100	notice_reason;
			string9 	fed_tax_id;
			string1  	non_disclosure;
			string10 	renewal_due_date;
			string10 	duration_date;
			string1  	more_on_microfilm;
			string50 	bus_type;
			string250	bus_group;
			string250	non_profit_type;
			string250	jurisdiction;
	end;

	export EntityDBExtractLayoutBase 				:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			EntityDBExtractLayoutIn;
	end;
	
	export MergerShareDBExtractLayoutIn 		:= Record
			string10 	entity_rsn;
			string10 	tran_rsn;
			string10 	merger_share_rsn;
			string10 	parent_rsn;
			string1  	share_exchange;
			string300	not_of_record_name;
			string300	not_of_record_jurisdiction;
	end;
	
	export MergerShareDBExtractLayoutBase 	:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			MergerShareDBExtractLayoutIn;
	end;
	
	export NameDBExtractLayoutIn 						:= Record
			string10  entity_rsn;
			string7   tran_rsn;
			string17  name_rsn;
			string300 bus_name;
			string1  	filed_with_affidavit;
			string50  name_type;
			string50  name_status;
			string10  start_date;
			string10  end_date;
	end;
	
	export NameDBExtractLayoutBase 					:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			NameDBExtractLayoutIn;
	end;
	
	export RelAssocNameDBExtractLayoutIn 		:= Record
			string10 	entity_rsn;
			string10 	tran_rsn;
			string10 	associated_name_rsn; 
			string10 	agent_resign_date;
			string50 	associated_name_type;
			string300 individual_name;
			string50 	individual_suffix;
			string10 	business_of_record_rsn;
			string300	not_of_record_business_name;
			string100	mail_address1;
			string100	mail_address2;
			string12 	zip_code5;
			string4 	zip_code4;
			string300 city;
			string300	state;
			string300	country;
	end;
	
	export RelAssocNameDBExtractLayoutBase 	:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			RelAssocNameDBExtractLayoutIn;
	end;
	
	export TranDBExtractLayoutIn 						:= Record
			string10 	entity_rsn;
			string10 	tran_rsn;
			string50 	tran_type;
			string10 	tran_date;
			string10 	eff_date;
			string10 	unfile_date;
			string1  	included_name_change; 
			string1  	included_agent_change;
			string50 	terminated_by;
			string100 tran_status;
	end;
	
	export TranDBExtractLayoutBase 					:= Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			TranDBExtractLayoutIn;
	end;
	
	export TempEntityTranDBExtractLayoutIn	:= Record
			EntityDBExtractLayoutIn;
			TranDBExtractLayoutIn;						
	end;
	
	//Note: There are 36 counties in OR
	export TempCountyDBExtractLayoutIn 			:= Record
			CountyDBExtractLayoutIn;
			integer total_counties_by_entity_rsn;
			string300	county_name1;
			string300	county_name2;
			string300	county_name3;
			string300	county_name4;
			string300	county_name5;
			string300	county_name6;
			string300	county_name7;
			string300	county_name8;
			string300	county_name9;
			string300	county_name10;
			string300	county_name11;
			string300	county_name12;
			string300	county_name13;
			string300	county_name14;
			string300	county_name15;
			string300	county_name16;
			string300	county_name17;
			string300	county_name18;
			string300	county_name19;
			string300	county_name20;
			string300	county_name21;
			string300	county_name22;
			string300	county_name23;
			string300	county_name24;
			string300	county_name25;
			string300	county_name26;
			string300	county_name27;
			string300	county_name28;
			string300	county_name29;
			string300	county_name30;
			string300	county_name31;
			string300	county_name32;
			string300	county_name33;
			string300	county_name34;
			string300	county_name35;
			string300	county_name36;
	end;
	
	export TempEntityNameRelAssocLayoutIn		:= Record
			EntityDBExtractLayoutIn;
			NameDBExtractLayoutIn;			
			RelAssocNameDBExtractLayoutIn;
			MergerShareDBExtractLayoutIn;
			TempCountyDBExtractLayoutIn;			
	end;
	
end;