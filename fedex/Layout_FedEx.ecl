export	Layout_FedEx	:=
module

	export	Raw	:=
	record
		string	file_date			{xpath('file_date')};
		string	record_id			{xpath('record_id')};
		string	record_type		{xpath('record_type')};
		string	first_name		{xpath('name/firstname')};
		string	middle_initial{xpath('name/middleinitial')};
		string	last_name			{xpath('name/lastname')};
		string	full_name			{xpath('name/fullname')};
		string	company_name	{xpath('name/companyname')};
		string	address_line1	{xpath('address/addressline1')};
		string	address_line2	{xpath('address/addressline2')};
		string	city					{xpath('address/city')};
		string	state					{xpath('address/state')};
		string	zip						{xpath('address/postalcode')};
		string	country				{xpath('address/countrycode')};
		string	phone					{xpath('phone/phone10')};
	end;
	
	shared	rName_layout	:=
	record
		string	first_name			{xpath('firstname')};
		string	middle_initial	{xpath('middleinitial')};
		string	last_name				{xpath('lastname')};
		string	full_name				{xpath('fullname')};
		string	company_name		{xpath('companyname')};
	end;

	shared	rAddress_layout	:=
	record
		string	address_line1	{xpath('addressline1')};
		string	address_line2	{xpath('addressline2')};
		string	city					{xpath('city')};
		string	state					{xpath('state')};
		string	zip						{xpath('postalcode')};
		string	country				{xpath('countrycode')};
	end;

	shared	rPhone_layout	:=
	record
		string	phone{xpath('phone10')};
	end;
	
	export	PreppedOut	:=
	record
		string	file_date;
		string	record_id;
		string	record_type;
		recordof(rName_layout)		name		{xpath('name')};
		recordof(rAddress_layout)	address	{xpath('address')};
		recordof(rPhone_layout)		phone		{xpath('phone')};
		string73									clean_name;
		string182									clean_address;
	end;
	
	export	Prepped	:=
	record
		string		file_date			{xpath('file_date')};
		string		record_id			{xpath('record_id')};
		string		record_type		{xpath('record_type')};
		string		first_name		{xpath('name/firstname')};
		string		middle_initial{xpath('name/middleinitial')};
		string		last_name			{xpath('name/lastname')};
		string		full_name			{xpath('name/fullname')};
		string		company_name	{xpath('name/companyname')};
		string		address_line1	{xpath('address/addressline1')};
		string		address_line2	{xpath('address/addressline2')};
		string		city					{xpath('address/city')};
		string		state					{xpath('address/state')};
		string		zip						{xpath('address/postalcode')};
		string		country				{xpath('address/countrycode')};
		string		phone					{xpath('phone/phone10')};
		string73	clean_name		{xpath('clean_name')};
		string182	clean_address	{xpath('clean_address')};
	end;
	
	export	Base	:=
	record(Raw)
		string1		business_indicator	:=	'';
		string10  prim_range;
		string2   predir;
		string28  prim_name;
		string4   addr_suffix;
		string2   postdir;
		string10  unit_desig;
		string8   sec_range;
		string25  p_city_name;
		string25  v_city_name;
		string2   st;
		string5   zip5;
		string6   zip6;
		string4   zip4;
		string4   cart;
		string1   cr_sort_sz;
		string4   lot;
		string1   lot_order;
		string2   dbpc;
		string1   chk_digit;
		string2   rec_type;
		string5   county;
		string10  geo_lat;
		string11  geo_long;
		string4   msa;
		string7   geo_blk;
		string1   geo_match;
		string4   err_stat;
	end;
	
end;