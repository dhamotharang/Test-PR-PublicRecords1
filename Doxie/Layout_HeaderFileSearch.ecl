import Risk_Indicators, advo;

//Replace maxlength with maxcount...this is a big one b/c of the variable strings

export Layout_HeaderFileSearch :=
RECORD
  STRING30 rid;
  string2   src;	
  unsigned2 penalt;
	unsigned1 num_compares;	
	unsigned2 group_min_penalt:=99;	
  STRING12 did;
  STRING1 tnt;
  boolean glb;
  boolean dppa;
  unsigned4 first_seen;
  unsigned4 last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  // Indicative info
	STRING5 title;
  STRING20 fname;
  STRING20 mname;
  STRING20 lname;
  string5  name_suffix;
  integer4 dob;
  unsigned1 age;
  unsigned4 dod;
	string1 deceased := 'U';
  unsigned1 dead_age;
  STRING1 death_code;
  STRING9 ssn;
  STRING1 valid_ssn;
  unsigned3 ssn_issue_early;
  unsigned3 ssn_issue_last;
  string2  ssn_issue_place;
  STRING10 prim_range;
  STRING2 predir;
  STRING28 prim_name;
  STRING4 suffix;
  STRING2 postdir;
  STRING10 unit_desig;
  STRING8 sec_range;
  STRING25 city_name;
  STRING2 st;
  STRING5 zip;
  STRING4 zip4;
	STRING3 county;
	STRING7	geo_blk;
  STRING18 county_name;
  STRING10 phone;
	STRING4	 timezone;
  
  // gong appends
  STRING10 listed_phone;
	STRING4	 listed_timezone;
  STRING120 listed_name;
	STRING1   listing_type_res;
	STRING1   listing_type_bus;
	STRING1   listing_type_gov;
	STRING1   listing_type_cell;
	STRING30  new_type;
	STRING30 carrier;
	STRING25 carrier_city;
	STRING2 carrier_state;
	STRING12 PhoneType; 
	unsigned3 phone_first_seen;
	unsigned3 phone_last_seen;
	STRING254 caption_text;
  UNSIGNED6	bdid;
	DATASET(doxie.Layout_Phones) phones {maxcount(rollup_limits.phones)};
	doxie.Layout_DLStateInfo dlRecs;

  doxie.layout_lookups.xcount;
  // HRI codes

  DATASET(Risk_Indicators.Layout_Desc) hri_address {maxcount(rollup_limits.address_hris)};
  DATASET(Risk_Indicators.Layout_Desc) hri_ssn {maxcount(rollup_limits.ssn_hris)};
  DATASET(Risk_Indicators.Layout_Desc) hri_Phone {maxcount(rollup_limits.phone_hris)};
  
	unsigned6 linked_did;
  boolean includedByHHID := false;
	string1 publish_code := '';
	string5 listed_name_prefix:= '';
  string20 listed_name_first:= '';
  string20 listed_name_middle:= '';
  string20 listed_name_last:= '';
  string5 listed_name_suffix:= '';

  // crim indicators
  boolean hasCriminalConviction := false;
  boolean isSexualOffender := false;
	boolean hasCriminalImages := false;
	boolean hasSexualOffenderImages := false;		
	// adding here for IRB project
	
	// added for IRB customization project to
	// signify to GUI to display 'current'
	// as the date last seen value
	// instead of using the value in 'dt_last_seen' field
  BOOLEAN IsCurrent := false;												
END;

