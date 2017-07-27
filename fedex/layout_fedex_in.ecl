export layout_fedex_in := record
	string file_date{xpath('file_date')};
	string first_name{xpath('name/firstname')};
	string middle_initial{xpath('name/middleinitial')};
	string last_name{xpath('name/lastname')};
	string full_name{xpath('name/fullname')};
	string company_name{xpath('name/companyname')};
	string address_line1{xpath('address/addressline1')};
	string address_line2{xpath('address/addressline2')};
	string city{xpath('address/city')};
	string state{xpath('address/state')};
	string zip{xpath('address/postalcode')};
	string country{xpath('address/countrycode')};
	string phone{xpath('phone/phone10')};
end;