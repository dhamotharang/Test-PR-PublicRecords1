import business_header_ss;
export proc_build_business_header_keys(

	string pversion

) := 
module

	business_header_keys := Business_Header_SS.proc_build_Business_Header_Keys(pversion).all : success(output('Business Header Keys finished'));
	business_search_keys := Business_Header_SS.proc_build_Business_Search_Keys(pversion).all : success(output('Business Header Search Keys finished'));

	export all := sequential(business_header_keys, business_search_keys);

end;