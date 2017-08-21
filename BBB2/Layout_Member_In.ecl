export Layout_Member_In := 
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
