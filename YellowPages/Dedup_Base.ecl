export Dedup_Base(

	dataset(Layout_YellowPages_Base_v2_BIP)	pYpBase

) :=
function

	// added dedup in case there is more than one file for this build
	return  dedup(sort(distribute(pYpBase, hash(orig_state, business_name, orig_zip,orig_phone10,orig_street)) 
	//,primary_key
	,business_name
	,orig_street
	,orig_city
	,orig_state
	,orig_zip
	//,orig_latitude
	//,orig_longitude
	,orig_phone10
	//,phone10
	,heading_string
	,sic_code
	,toll_free_indicator
	,fax_indicator
	,pub_date
	,index_value
	,naics_code
	,web_address
	,email_address
	,employee_code
	,executive_title
	,executive_name
	,derog_legal_indicator
	, local)
	//,primary_key
	,business_name
	,orig_street
	,orig_city
	,orig_state
	,orig_zip
	//,orig_latitude
	//,orig_longitude
	,orig_phone10
	//,phone10
	,heading_string
	,sic_code
	,toll_free_indicator
	,fax_indicator
	,pub_date
	,index_value
	,naics_code
	,web_address
	,email_address
	,employee_code
	,executive_title
	,executive_name
	,derog_legal_indicator
	, local);


end;