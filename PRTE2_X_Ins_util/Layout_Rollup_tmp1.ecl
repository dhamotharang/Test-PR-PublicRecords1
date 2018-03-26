// Layout used in Alpharetta RollupPerson simulator.
// Flatened layout doxie.Layout_Rollup.KeyRec_feedback.

EXPORT Layout_Name123 := RECORD
	string12		did;
	unsigned2		penalt;
	unsigned1		num_compares;
	boolean		includedbyhhid;
	unsigned1		bestsrchedaddrtntscore;
	unsigned3		bestsrchedaddrdate;
	unsigned1		besttntscore;
	unsigned1		bestsrchedvalidssnscore;
// DATASET( --------- )   namerecs
	string5		title;
	string20		fname;
	string20		mname;
	string20		lname;
	string5		name_suffix;
//   EndOf    -----    namerecs
	boolean		addrs_suppressed;
// DATASET( --------- )   addrrecs
	string1		tnt;
	unsigned4		first_seen;
	unsigned4		last_seen;
	string2		predir;
	string10		prim_range;
	string28		prim_name;
	string4		suffix;
	string2		postdir;
	string10		unit_desig;
	string8		sec_range;
	string25		city_name;
	string2		st;
	string5		zip;
	string4		zip4;
	string3		county;
	string7		geo_blk;
	string18		county_name;
	string5		census_age;
	string9		census_income;
	string9		census_home_value;
	string5		census_education;
	unsigned4		dt_vendor_first_reported;
	unsigned4		dt_vendor_last_reported;
// DATASET( --------- )   phonerecs
	unsigned1		match_type;
	integer8		gong_score;
	string10		phone;
	string4		timezone;
	boolean		listed;
	unsigned6		bdid;
	unsigned6		did;
	string1		listing_type_res;
	string1		listing_type_bus;
	string1		listing_type_gov;
	string1		listing_type_cell;
	string30		new_type;
	string30		carrier;
	string25		carrier_city;
	string2		carrier_state;
	string12		phonetype;
	unsigned3		phone_first_seen;
	unsigned3		phone_last_seen;
	string120		listed_name;
	string254		caption_text;
// DATASET( --------- )   hri_phone
	string4		hri;
	string150		desc;
//   EndOf    -----    hri_phone
// DATASET( --------- )   feedback
	integer8		feedback_count;
	string		last_feedback_result;
	integer8		last_feedback_result_provided;
//   EndOf    -----    feedback
//   EndOf    -----    phonerecs
// DATASET( --------- )   hri_address
	string4		hri;
	string150		desc;
//   EndOf    -----    hri_address
//  RECORD( layout_cds )   address_cds
	string1		record_type_code;
	string11		record_type_description;
	string4		route_num;
	string16		route_description;
	string9		walk_sequence;
	string1		address_vacancy_indicator;
	string22		address_vacancy_description;
	string1		throw_back_indicator;
	string1		seasonal_delivery_indicator;
	string36		seasonal_delivery_description;
	string5		seasonal_start_suppression_date;
	string5		seasonal_end_suppression_date;
	string1		dnd_indicator;
	string1		college_indicator;
	string10		college_start_suppression_date;
	string10		college_end_suppression_date;
	string1		address_style_flag;
	string1		drop_indicator;
	string1		residential_or_business_ind;
	string58		delivery_type_description;
	string3		county_num;
	string28		county_name;
	string28		city_name;
	string2		state_code;
	string2		state_num;
	string2		congressional_district_number;
	string1		address_type;
	string1		mixed_address_usage;
	boolean		lookedup;
//   EndOf    -----    address_cds
// DATASET( --------- )   address_feedback
	unsigned2		feedback_count;
	string40		last_feedback_result;
	unsigned4		last_feedback_result_provided;
//   EndOf    -----    address_feedback
//   EndOf    -----    addrrecs
// DATASET( --------- )   ssnrecs
	string9		ssn;
	unsigned3		ssn_issue_early;
	unsigned3		ssn_issue_last;
	string2		ssn_issue_place;
	string1		valid_ssn;
// DATASET( --------- )   hri_ssn
	string4		hri;
	string150		desc;
//   EndOf    -----    hri_ssn
//   EndOf    -----    ssnrecs
	unsigned2		ssn_count;
// DATASET( --------- )   dobrecs
	integer4		dob;
	unsigned1		age;
//   EndOf    -----    dobrecs
// DATASET( --------- )   dodrecs
	unsigned4		dod;
	unsigned1		dead_age;
	string1		deceased;
//   EndOf    -----    dodrecs
// DATASET( --------- )   dlrecs
	string24		dl_num;
	string2		dl_st;
	unsigned4		earliest_lic_issue_date;
	unsigned4		latest_expiration_date;
//   EndOf    -----    dlrecs
// DATASET( --------- )   paw
//  RECORD( t_businessidentity )   businessids
	unsigned6		dotid;
	unsigned6		empid;
	unsigned6		powid;
	unsigned6		proxid;
	unsigned6		seleid;
	unsigned6		orgid;
	unsigned6		ultid;
//   EndOf    -----    businessids
	string100		idvalue;
	string1		confidencelevel;
	boolean		verified;
//  RECORD( t_name )   name
	string62		full;
	string20		first;
	string20		middle;
	string20		last;
	string5		suffix;
	string3		prefix;
//   EndOf    -----    name
	string12		uniqueid;
	string35		title;
	string9		ssn;
	string60		email;
	string10		phone10;
	string6		gender;
	string4		timezone;
	string4		companytimezone;
	string120		companyname;
	string35		department;
	string9		fein;
	string12		businessid;
//  RECORD( t_address )   address
	string10		streetnumber;
	string2		streetpredirection;
	string28		streetname;
	string4		streetsuffix;
	string2		streetpostdirection;
	string10		unitdesignation;
	string8		unitnumber;
	string60		streetaddress1;
	string60		streetaddress2;
	string25		city;
	string2		state;
	string5		zip5;
	string4		zip4;
	string18		county;
	string9		postalcode;
	string50		statecityzip;
//   EndOf    -----    address
//  RECORD( t_date )   datefirstseen
	integer2		year;
	integer2		month;
	integer2		day;
//   EndOf    -----    datefirstseen
//  RECORD( t_date )   datelastseen
	integer2		year;
	integer2		month;
	integer2		day;
//   EndOf    -----    datelastseen
//   EndOf    -----    paw
// DATASET( --------- )   paw_v2
	unsigned8		__seq;
	boolean		isdeepdive;
	unsigned2		penalt;
	unsigned6		did;
// DATASET( --------- )   ssns
	string9		ssn;
//   EndOf    -----    ssns
// DATASET( --------- )   names
	string5		title;
	string20		fname;
	string20		mname;
	string20		lname;
	string5		name_suffix;
//   EndOf    -----    names
// DATASET( --------- )   employers
	unsigned6		bdid;
	unsigned6		dotid;
	unsigned6		empid;
	unsigned6		powid;
	unsigned6		proxid;
	unsigned6		seleid;
	unsigned6		orgid;
	unsigned6		ultid;
// DATASET( --------- )   dates
	string8		dt_first_seen;
	string8		dt_last_seen;
//   EndOf    -----    dates
// DATASET( --------- )   feins
	string9		fein;
//   EndOf    -----    feins
// DATASET( --------- )   company_names
	string120		company_name;
//   EndOf    -----    company_names
// DATASET( --------- )   addrs
	string10		prim_range;
	string2		predir;
	string28		prim_name;
	string4		addr_suffix;
	string2		postdir;
	string5		unit_desig;
	string8		sec_range;
	string25		city;
	string2		state;
	string5		zip;
	string4		zip4;
// DATASET( --------- )   phones
	boolean		verified;
	string10		phone10;
	string4		timezone;
//   EndOf    -----    phones
//   EndOf    -----    addrs
// DATASET( --------- )   positions
// DATASET( --------- )   dates
	string8		dt_first_seen;
	string8		dt_last_seen;
//   EndOf    -----    dates
	string35		company_title;
	string35		company_department;
//   EndOf    -----    positions
//   EndOf    -----    employers
	boolean		hascriminalconviction;
	boolean		issexualoffender;
	unsigned2		comp_prop_count;
	unsigned2		veh_cnt;
	unsigned2		dl_cnt;
	unsigned2		rel_count;
	unsigned2		assoc_count;
	unsigned2		prof_count;
	unsigned2		paw_count;
	unsigned2		vess_count;
	unsigned2		email_count;
	unsigned2		accident_count;
	unsigned2		phonesplus_count;
//   EndOf    -----    paw_v2
	unsigned2		veh_cnt;
	unsigned2		dl_cnt;
	unsigned2		head_cnt;
	unsigned2		crim_cnt;
	unsigned2		sex_cnt;
	unsigned2		ccw_cnt;
	unsigned2		rel_count;
	unsigned2		assoc_count;
	unsigned2		fire_count;
	unsigned2		faa_count;
	unsigned2		prof_count;
	unsigned2		vess_count;
	unsigned2		bus_count;
	unsigned2		paw_count;
	unsigned2		bc_count;
	unsigned2		prop_count;
	unsigned2		prop_asses_count;
	unsigned2		prop_deeds_count;
	unsigned2		bk_count;
	unsigned2		sanc_count;
	unsigned2		prov_count;
	unsigned2		corp_affil_count;
	unsigned2		comp_prop_count;
	unsigned2		phonesplus_count;
	unsigned2		email_count;
	unsigned2		accident_count;
	boolean		hascriminalconviction;
	boolean		issexualoffender;
	boolean		hascriminalimages;
	boolean		hassexualoffenderimages;
// DATASET( --------- )   workphones
	unsigned1		match_type;
	integer8		gong_score;
	string10		phone10;
	string4		timezone;
	boolean		listed;
	unsigned6		bdid;
	unsigned6		did;
	string1		listing_type_res;
	string1		listing_type_bus;
	string1		listing_type_gov;
	string1		listing_type_cell;
	string30		new_type;
	string30		carrier;
	string25		carrier_city;
	string2		carrier_state;
	string12		phonetype;
	unsigned3		phone_first_seen;
	unsigned3		phone_last_seen;
	string120		listed_name;
	string254		caption_text;
//   EndOf    -----    workphones
// DATASET( --------- )   relativephones
	unsigned1		match_type;
	integer8		gong_score;
	string10		phone10;
	string4		timezone;
	boolean		listed;
	unsigned6		bdid;
	unsigned6		did;
	string1		listing_type_res;
	string1		listing_type_bus;
	string1		listing_type_gov;
	string1		listing_type_cell;
	string30		new_type;
	string30		carrier;
	string25		carrier_city;
	string2		carrier_state;
	string12		phonetype;
	unsigned3		phone_first_seen;
	unsigned3		phone_last_seen;
	string120		listed_name;
	string254		caption_text;
//   EndOf    -----    relativephones
// DATASET( --------- )   relativenames
	string5		title;
	string20		fname;
	string20		mname;
	string20		lname;
	string5		name_suffix;
	string3		name_score;
//   EndOf    -----    relativenames
// DATASET( --------- )   rids
	string30		rid;
	string2		src;
	unsigned6		doccnt;
//   EndOf    -----    rids
	unsigned2		rid_cnt;
	unsigned2		src_cnt;
	unsigned2		src_doc_cnt;
	unsigned6		maxrid;
	unsigned3		maxdate;
	unsigned2		output_seq_no;
END;
