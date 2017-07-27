export Layout_Stat_Layouts := 
module

	export MemberInput :=
	record
		STRING8		Build_Version						:= '';
		STRING8		BBB_Type							:= '';
		string5		File_Type							:= '';
		unsigned4	Total_records						:= 0;
		unsigned4	bbb_id								:= 0;
		unsigned4	Unique_bbb_ids						:= 0;
		unsigned4	company_name 						:= 0;
		unsigned4	address								:= 0;
		unsigned4	country								:= 0;
		unsigned4	phone								:= 0;
		unsigned4	phone_type							:= 0;
		unsigned4	listing_month						:= 0;
		unsigned4	listing_day							:= 0;
		unsigned4	listing_year						:= 0;
		unsigned4	http_link							:= 0;
		unsigned4	member_title						:= 0;
		unsigned4	member_attr_name1					:= 0;
		unsigned4	member_attr1						:= 0;
		unsigned4	member_attr_name2					:= 0;
		unsigned4	member_attr2						:= 0;
	END;           


	export NonMemberInput :=
	record
		STRING8		Build_Version						:= '';
		STRING9		BBB_Type							:= '';
		string5		File_Type							:= '';
		unsigned4	Total_records						:= 0;
		unsigned4	bbb_id								:= 0;
		unsigned4	Unique_bbb_ids						:= 0;
		unsigned4	company_name 						:= 0;
		unsigned4	address								:= 0;
		unsigned4	country								:= 0;
		unsigned4	phone								:= 0;
		unsigned4	phone_type							:= 0;
		unsigned4	listing_month						:= 0;
		unsigned4	listing_day							:= 0;
		unsigned4	listing_year						:= 0;
		unsigned4	http_link							:= 0;
		unsigned4	non_member_title					:= 0;
		unsigned4	non_member_category					:= 0;
	end;
														 

	export MemberBase :=                               
	record
		STRING8 	Build_Version						:= '';
		STRING8 	BBB_Type							:= '';
		string5		File_Type							:= '';
		unsigned4	Total_records						:= 0;
		unsigned4	bbb_id								:= 0;
		unsigned4	Unique_bbb_ids						:= 0;
		unsigned4	with_bdid							:= 0;
		unsigned4	Unique_bdids						:= 0;
		unsigned4 	record_type_C						:= 0;
		unsigned4 	record_type_H						:= 0;
		unsigned4 	with_date_first_seen				:= 0;
		unsigned4 	earliest_date_first_seen			:= 0;
		unsigned4 	with_date_last_seen					:= 0;
		unsigned4 	latest_date_last_seen				:= 0;
		unsigned4 	with_dt_vendor_first_reported		:= 0;
		unsigned4 	earliest_dt_vendor_first_reported	:= 0;
		unsigned4 	with_dt_vendor_last_reported		:= 0;
		unsigned4 	latest_dt_vendor_last_reported		:= 0;
		unsigned4	with_process_date_first_seen		:= 0;
		unsigned4	earliest_process_date_first_seen	:= 0;
		unsigned4	with_process_date_last_seen			:= 0;
		unsigned4	latest_process_date_last_seen		:= 0;
		unsigned4 	with_record_type					:= 0;
		unsigned4	company_name						:= 0;
		unsigned4	address								:= 0;
		unsigned4	country								:= 0;
		unsigned4	phone								:= 0;
		unsigned4	phone_type							:= 0;
		unsigned4	report_date							:= 0;
		unsigned4	earliest_report_date				:= 0;
		unsigned4	latest_report_date					:= 0;
		unsigned4	http_link							:= 0;
		unsigned4	member_title						:= 0;
		unsigned4	member_since_date					:= 0;
		unsigned4	earliest_member_since_date			:= 0;
		unsigned4	latest_member_since_date			:= 0;
		unsigned4	member_category						:= 0;
		unsigned4	prim_name							:= 0;
		unsigned4	zip									:= 0;
		unsigned4	phone10								:= 0;
	end;



	export NonMemberBase := 
	record
		STRING8 	Build_Version						:= '';
		STRING8 	BBB_Type							:= '';
		string5		File_Type							:= '';
		unsigned4	Total_records						:= 0;
		unsigned4	bbb_id								:= 0;
		unsigned4	Unique_bbb_ids						:= 0;
		unsigned4	with_bdid							:= 0;
		unsigned4	Unique_bdids						:= 0;
		unsigned4 	record_type_C						:= 0;
		unsigned4 	record_type_H						:= 0;
		unsigned4 	with_date_first_seen				:= 0;
		unsigned4 	earliest_date_first_seen			:= 0;
		unsigned4 	with_date_last_seen					:= 0;
		unsigned4 	latest_date_last_seen				:= 0;
		unsigned4 	with_dt_vendor_first_reported		:= 0;
		unsigned4 	earliest_dt_vendor_first_reported	:= 0;
		unsigned4 	with_dt_vendor_last_reported		:= 0;
		unsigned4 	latest_dt_vendor_last_reported		:= 0;
		unsigned4	with_process_date_first_seen		:= 0;
		unsigned4	earliest_process_date_first_seen	:= 0;
		unsigned4	with_process_date_last_seen			:= 0;
		unsigned4	latest_process_date_last_seen		:= 0;
		unsigned4 	with_record_type					:= 0;
		unsigned4	company_name						:= 0;
		unsigned4	address								:= 0;
		unsigned4	country								:= 0;
		unsigned4	phone								:= 0;
		unsigned4	phone_type							:= 0;
		unsigned4	report_date							:= 0;
		unsigned4	earliest_report_date				:= 0;
		unsigned4	latest_report_date					:= 0;
		unsigned4	http_link							:= 0;
		unsigned4	non_member_title					:= 0;
		unsigned4	non_member_category					:= 0;
		unsigned4	prim_name							:= 0;
		unsigned4	zip									:= 0;
		unsigned4	phone10								:= 0;
	end;
end;
