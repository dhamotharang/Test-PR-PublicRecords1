import address, AID, BIPV2;

export Layouts_Files :=
module
	/////////////////////////////////////////////////////////////////////////////////////
	// -- Input Layouts
	/////////////////////////////////////////////////////////////////////////////////////
	export Input :=
	module

		/////////////////////////////////////////////////////////////////////////////////////
		// -- Member Layout
		/////////////////////////////////////////////////////////////////////////////////////
		export Member := 
		record
			string bbb_id 				{xpath('id')};
			string company_name 		{xpath('name')};
			string address 				{xpath('address')};
			string country 				{xpath('country')};
			string phone 				{xpath('phone')};
			string phone_type 			{xpath('phone@type')};
			string listing_month 		{xpath('date@month')};
			string listing_day 			{xpath('date@day')};
			string listing_year 		{xpath('date@year')};
			string http_link 			{xpath('content/attributes/link')};
			string member_title 		{xpath('content/attributes/title')};
			string member_attr_name1	{xpath('content/attributes/attr[1]@name')};
			string member_attr1			{xpath('content/attributes/attr[1]')};
			string member_attr_name2	{xpath('content/attributes/attr[2]@name')};
			string member_attr2			{xpath('content/attributes/attr[2]')};
		end;

		/////////////////////////////////////////////////////////////////////////////////////
		// -- Non-Member Layout
		/////////////////////////////////////////////////////////////////////////////////////
		export NonMember := 
		record
			string bbb_id				{xpath('id')};
			string company_name			{xpath('name')};
			string address				{xpath('address')};
			string country				{xpath('country')};
			string phone				{xpath('phone')};
			string phone_type			{xpath('phone@type')};
			string listing_month		{xpath('date@month')};
			string listing_day			{xpath('date@day')};
			string listing_year			{xpath('date@year')};
			string http_link			{xpath('content/attributes/link')};
			string non_member_title 	{xpath('content/attributes/title')};
			string non_member_category	{xpath('content/attributes/category')};
		end;
	end;
	
	/////////////////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	/////////////////////////////////////////////////////////////////////////////////////
	export Base :=
	module

		/////////////////////////////////////////////////////////////////////////////////////
		// -- Common Base Fields
		/////////////////////////////////////////////////////////////////////////////////////
		shared Common := 
		record
			unsigned6	bdid											:= 0;
			unsigned4	date_first_seen						:= 0;
			unsigned4	date_last_seen						:= 0;
			unsigned4	dt_vendor_first_reported	:= 0;
			unsigned4	dt_vendor_last_reported		:= 0;
			unsigned4	process_date_first_seen		:= 0;
			unsigned4	process_date_last_seen		:= 0;
			string1		record_type								:= '';
			// The below 2 fields are added for CCPA (California Consumer Protection Act) project.
			// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
			unsigned4 global_sid 								:= 0;
			unsigned8 record_sid 								:= 0;
		end;

		export Layout_Addr_AID := record
			unsigned8	raw_aid								:= 0;
			unsigned8	ace_aid								:= 0;
			string100	prep_addr_line1				:='';
			string50	prep_addr_line_last		:='';
		end;		
			
		/////////////////////////////////////////////////////////////////////////////////////
		// -- Member Layout
		/////////////////////////////////////////////////////////////////////////////////////
		export Member := 
		record
			Common;
			string7		bbb_id;
			string100	company_name;
			string100	address;
			string12	country;
			string14	phone;
			string8		phone_type;
			string8		report_date;
			string255	http_link;
			string100	member_title;
			string8		member_since_date;
			string100	member_category;
			address.Layout_Clean182_fips;
			string10	phone10;
		end;

		export Member_BIP := record
		  bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
			unsigned8 source_rec_id := 0; //Added for BIP project	
			Member;
			Layout_Addr_AID;
		end;
		/////////////////////////////////////////////////////////////////////////////////////
		// -- Non-Member Layout
		/////////////////////////////////////////////////////////////////////////////////////
		export NonMember := 
		record
			Common;
			string7		bbb_id;
			string100	company_name;
			string100	address;
			string12	country;
			string14	phone;
			string8		phone_type;
			string8		report_date;
			string255 	http_link;
			string100	non_member_title;
			string100	non_member_category;
			address.Layout_Clean182_fips;
			string10	phone10;
		end;
		
		export NonMember_BIP := record
		  bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
			unsigned8 source_rec_id := 0; //Added for BIP project	
			NonMember;
			Layout_Addr_AID;
		end;
	end;
end;