import ut;
//really just going for what looks best
Business_Header.doxie_MAC_Field_Declare()

string120 inp_cname :=	company_name_value;
string20 inp_prange := prange_value;
string50 inp_pname := doxie.StripOrdinal(clean_address[13..40]);
string10 inp_sec_range := sec_range_value;
string25 inp_city := city_value;
string10 inp_phone := phone_value;
string9 inp_fein := fein_val;

diffscore(string s1, string s2, unsigned2 importance = 0) :=
	map(s1 <> '' and s1 = s2 => 0,
		  s1 = '' or s2 = '' => 5,
	    ut.StringSimilar(s1,s2));

export compute_ProfileSearchScore
	(string cname,
	 string prange,
	 string pname,
	 string sec_range,
	 string city,
	 //string phone,
	 //string fein,
	 integer zipdist) :=
	 200
	 -(ut.CompanySimilar100(cname, inp_cname) div 2)
	 -(ut.StringSimilar100(cname, inp_cname) div 4)
	 -diffscore(prange, inp_prange)
	 -diffscore(pname, inp_pname)
	 -diffscore(sec_range, inp_sec_range)
	 -diffscore(city, inp_city)
	 //-diffscore(phone, inp_phone)
	 //-diffscore(fein, inp_fein)
	 -zipdist;
