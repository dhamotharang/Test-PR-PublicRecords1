export Layouts_Stats :=
module
	export Input :=
	module
	
		shared lMemberIn		:= Files.Input.Member.Used;
		shared lNonMemberIn		:= Files.Input.NonMember.Used;
		export Tables :=
		module
			export Member :=
			record
				STRING8		Build_Version						:= version;
				STRING8		BBB_Type							:= 'Member';
				string5		File_Type							:= 'Input';
				unsigned4	Total_records						:= count(group);
				unsigned4	bbb_id								:= count(group, lMemberIn.bbb_id			!= '');
				unsigned4	Unique_bbb_ids						:= 0;
				unsigned4	company_name 						:= count(group, lMemberIn.company_name 		!= '');
				unsigned4	address								:= count(group, lMemberIn.address			!= '');
				unsigned4	country								:= count(group, lMemberIn.country			!= '');
				unsigned4	phone								:= count(group, lMemberIn.phone				!= '');
				unsigned4	phone_type							:= count(group, lMemberIn.phone_type		!= '');
				unsigned4	listing_month						:= count(group, lMemberIn.listing_month		!= '');
				unsigned4	listing_day							:= count(group, lMemberIn.listing_day		!= '');
				unsigned4	listing_year						:= count(group, lMemberIn.listing_year		!= '');
				unsigned4	http_link							:= count(group, lMemberIn.http_link			!= '');
				unsigned4	member_title						:= count(group, lMemberIn.member_title		!= '');
				unsigned4	member_attr_name1					:= count(group, lMemberIn.member_attr_name1	!= '');
				unsigned4	member_attr1						:= count(group, lMemberIn.member_attr1		!= '');
				unsigned4	member_attr_name2					:= count(group, lMemberIn.member_attr_name2	!= '');
				unsigned4	member_attr2						:= count(group, lMemberIn.member_attr2		!= '');
			END;           

			export MemberUniqueBBBId :=
			record
				STRING8		Build_Version						:= version;
				STRING8		BBB_Type							:= 'Member';
				string5		File_Type							:= 'Input';
				lMemberIn.bbb_id;
			END;           

			export NonMemberInputTable :=
			record
				STRING8		Build_Version						:= version;
				STRING9		BBB_Type							:= 'NonMember';
				string5		File_Type							:= 'Input';
				unsigned4	Total_records						:= count(group);
				unsigned4	bbb_id								:= count(group, lNonMemberIn.bbb_id					!= '');
				unsigned4	Unique_bbb_ids						:= 0;
				unsigned4	company_name 						:= count(group, lNonMemberIn.company_name 			!= '');
				unsigned4	address								:= count(group, lNonMemberIn.address				!= '');
				unsigned4	country								:= count(group, lNonMemberIn.country				!= '');
				unsigned4	phone								:= count(group, lNonMemberIn.phone					!= '');
				unsigned4	phone_type							:= count(group, lNonMemberIn.phone_type				!= '');
				unsigned4	listing_month						:= count(group, lNonMemberIn.listing_month			!= '');
				unsigned4	listing_day							:= count(group, lNonMemberIn.listing_day			!= '');
				unsigned4	listing_year						:= count(group, lNonMemberIn.listing_year			!= '');
				unsigned4	http_link							:= count(group, lNonMemberIn.http_link				!= '');
				unsigned4	non_member_title					:= count(group, lNonMemberIn.non_member_title		!= '');
				unsigned4	non_member_category					:= count(group, lNonMemberIn.non_member_category	!= '');
			end;

			export NonMemberInputTableUniqueBBBId :=
			record
				STRING8		Build_Version						:= version;
				STRING9		BBB_Type							:= 'NonMember';
				string5		File_Type							:= 'Input';
				lNonMemberIn.bbb_id;
			END;           
		end;
	end;
	
	shared lMemberBase		:= Files.Base.Member.QA;
	shared lNonMemberBase	:= Files.Base.NonMember.QA;
	export MemberBaseTable :=                               
	record
		STRING8 	Build_Version						:= version;
		STRING8 	BBB_Type							:= 'Member';
		string5		File_Type							:= 'Base';
		unsigned4	Total_records						:= count(group);
		unsigned4	bbb_id								:= COUNT(GROUP, lMemberBase.bbb_id != '');
		unsigned4	Unique_bbb_ids						:= 0;
		unsigned4	with_bdid							:= COUNT(GROUP, lMemberBase.bdid != 0);
		unsigned4	Unique_bdids						:= 0;
		unsigned4 	record_type_C						:= COUNT(GROUP, lMemberBase.record_type = 'C');
		unsigned4 	record_type_H						:= COUNT(GROUP, lMemberBase.record_type = 'H');
		unsigned4 	with_date_first_seen				:= COUNT(GROUP, lMemberBase.date_first_seen != 0);
		unsigned4 	earliest_date_first_seen			:= MIN(GROUP, 	lMemberBase.date_first_seen);
		unsigned4 	with_date_last_seen					:= COUNT(GROUP, lMemberBase.date_last_seen != 0);
		unsigned4 	latest_date_last_seen				:= MAX(GROUP, 	lMemberBase.date_last_seen);
		unsigned4 	with_dt_vendor_first_reported		:= COUNT(GROUP, lMemberBase.dt_vendor_first_reported != 0);
		unsigned4 	earliest_dt_vendor_first_reported	:= MIN(GROUP, 	lMemberBase.dt_vendor_first_reported);
		unsigned4 	with_dt_vendor_last_reported		:= COUNT(GROUP, lMemberBase.dt_vendor_last_reported != 0);
		unsigned4 	latest_dt_vendor_last_reported		:= MAX(GROUP, 	lMemberBase.dt_vendor_last_reported);
		unsigned4	with_process_date_first_seen		:= COUNT(GROUP, lMemberBase.process_date_first_seen != 0);
		unsigned4	earliest_process_date_first_seen	:= MIN(GROUP, 	lMemberBase.process_date_first_seen);
		unsigned4	with_process_date_last_seen			:= COUNT(GROUP, lMemberBase.process_date_last_seen != 0);
		unsigned4	latest_process_date_last_seen		:= MAX(GROUP, 	lMemberBase.process_date_last_seen);
		unsigned4 	with_record_type					:= COUNT(GROUP, lMemberBase.record_type != '');
		unsigned4	company_name						:= COUNT(GROUP, lMemberBase.company_name != '');
		unsigned4	address								:= COUNT(GROUP, lMemberBase.address != '');
		unsigned4	country								:= COUNT(GROUP, lMemberBase.country != '');
		unsigned4	phone								:= COUNT(GROUP, lMemberBase.phone != '');
		unsigned4	phone_type							:= COUNT(GROUP, lMemberBase.phone_type != '');
		unsigned4	report_date							:= COUNT(GROUP, lMemberBase.report_date != '');
		unsigned4	earliest_report_date				:= MIN(GROUP, (integer)lMemberBase.report_date);
		unsigned4	latest_report_date					:= MAX(GROUP, (integer)lMemberBase.report_date);
		unsigned4	http_link							:= COUNT(GROUP, lMemberBase.http_link != '');
		unsigned4	member_title						:= COUNT(GROUP, lMemberBase.member_title != '');
		unsigned4	member_since_date					:= COUNT(GROUP, lMemberBase.member_since_date != '');
		unsigned4	earliest_member_since_date			:= MIN(GROUP, (integer)lMemberBase.member_since_date);
		unsigned4	latest_member_since_date			:= MAX(GROUP, (integer)lMemberBase.member_since_date);
		unsigned4	member_category						:= COUNT(GROUP, lMemberBase.member_category != '');
		unsigned4	prim_name							:= COUNT(GROUP, lMemberBase.prim_name != '');
		unsigned4	zip									:= COUNT(GROUP, lMemberBase.zip != '');
		unsigned4	phone10								:= COUNT(GROUP, lMemberBase.phone10 != '');
	end;

	export MemberBaseTableUniqueBBBId :=
	record
		STRING8		Build_Version						:= version;
		STRING8		BBB_Type							:= 'Member';
		string5		File_Type							:= 'Base';
		lMemberBase.bbb_id;
	END;           

	export MemberBaseTableUniqueBDID :=
	record
		STRING8		Build_Version						:= version;
		STRING8		BBB_Type							:= 'Member';
		string5		File_Type							:= 'Base';
		lMemberBase.bdid;
	END;           

	export NonMemberBaseTable := 
	record
		STRING8 	Build_Version						:= version;
		STRING9 	BBB_Type							:= 'NonMember';
		string5		File_Type							:= 'Base';
		unsigned4	Total_records						:= count(group);
		unsigned4	bbb_id								:= COUNT(GROUP, lNonMemberBase.bbb_id != '');
		unsigned4	Unique_bbb_ids						:= 0;
		unsigned4	with_bdid							:= COUNT(GROUP, lNonMemberBase.bdid != 0);
		unsigned4	Unique_bdids						:= 0;
		unsigned4 	record_type_C						:= COUNT(GROUP, lNonMemberBase.record_type = 'C');
		unsigned4 	record_type_H						:= COUNT(GROUP, lNonMemberBase.record_type = 'H');
		unsigned4 	with_date_first_seen				:= COUNT(GROUP, lNonMemberBase.date_first_seen != 0);
		unsigned4 	earliest_date_first_seen			:= MIN(GROUP,	lNonMemberBase.date_first_seen);
		unsigned4 	with_date_last_seen					:= COUNT(GROUP, lNonMemberBase.date_last_seen != 0);
		unsigned4 	latest_date_last_seen				:= MAX(GROUP,	lNonMemberBase.date_last_seen);
		unsigned4 	with_dt_vendor_first_reported		:= COUNT(GROUP, lNonMemberBase.dt_vendor_first_reported != 0);
		unsigned4 	earliest_dt_vendor_first_reported	:= MIN(GROUP,	lNonMemberBase.dt_vendor_first_reported);
		unsigned4 	with_dt_vendor_last_reported		:= COUNT(GROUP, lNonMemberBase.dt_vendor_last_reported != 0);
		unsigned4 	latest_dt_vendor_last_reported		:= MAX(GROUP,	lNonMemberBase.dt_vendor_last_reported);
		unsigned4	with_process_date_first_seen		:= COUNT(GROUP, lNonMemberBase.process_date_first_seen != 0);
		unsigned4	earliest_process_date_first_seen	:= MIN(GROUP,	lNonMemberBase.process_date_first_seen);
		unsigned4	with_process_date_last_seen			:= COUNT(GROUP, lNonMemberBase.process_date_last_seen != 0);
		unsigned4	latest_process_date_last_seen		:= MAX(GROUP,	lNonMemberBase.process_date_last_seen);
		unsigned4 	with_record_type					:= COUNT(GROUP, lNonMemberBase.record_type != '');
		unsigned4	company_name						:= COUNT(GROUP, lNonMemberBase.company_name != '');
		unsigned4	address								:= COUNT(GROUP, lNonMemberBase.address != '');
		unsigned4	country								:= COUNT(GROUP, lNonMemberBase.country != '');
		unsigned4	phone								:= COUNT(GROUP, lNonMemberBase.phone != '');
		unsigned4	phone_type							:= COUNT(GROUP, lNonMemberBase.phone_type != '');
		unsigned4	report_date							:= COUNT(GROUP, lNonMemberBase.report_date != '');
		unsigned4	earliest_report_date				:= MIN(GROUP, (integer)lNonMemberBase.report_date);
		unsigned4	latest_report_date					:= MAX(GROUP, (integer)lNonMemberBase.report_date);
		unsigned4	http_link							:= COUNT(GROUP, lNonMemberBase.http_link != '');
		unsigned4	non_member_title					:= COUNT(GROUP, lNonMemberBase.non_member_title != '');
		unsigned4	non_member_category					:= COUNT(GROUP, lNonMemberBase.non_member_category != '');
		unsigned4	prim_name							:= COUNT(GROUP, lNonMemberBase.prim_name != '');
		unsigned4	zip									:= COUNT(GROUP, lNonMemberBase.zip != '');
		unsigned4	phone10								:= COUNT(GROUP, lNonMemberBase.phone10 != '');
	end;

	export NonMemberBaseTableUniqueBBBId :=
	record
		STRING8		Build_Version						:= version;
		STRING9		BBB_Type							:= 'NonMember';
		string5		File_Type							:= 'Base';
		lNonMemberBase.bbb_id;
	END;           

	export NonMemberBaseTableUniqueBDID :=
	record
		STRING8		Build_Version						:= version;
		STRING9		BBB_Type							:= 'NonMember';
		string5		File_Type							:= 'Base';
		lNonMemberBase.bdid;
	END;           
end;