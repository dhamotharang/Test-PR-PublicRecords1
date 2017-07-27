EXPORT IID_SummaryReport := Module



Export IIDRecord := record
	string30  acctno;
	string12  did;
	string12  seq;
	string5  title;
	string20  fname;
	string20  mname;
	string20  lname;
	string5  suffix;
	string120  in_streetaddress;
	string25  in_city;
	string2  in_state;
	string5  in_zipcode;
	string25  in_country;
	string10  prim_range;
	string2  predir;
	string28  prim_name;
	string4  addr_suffix;
	string2  postdir;
	string10  unit_desig;
	string8  sec_range;
	string25  p_city_name;
	string2  st;
	string5  z5;
	string4  zip4;
	string10  lat;
	string11  long;
	string3  county;
	string7  geo_blk;
	string1  addr_type;
	string4  addr_status;
	string25  country;
	string9  ssn;
	string8  dob;
	string3  age;
	string20  dl_number;
	string2  dl_state;
	string50  email_address;
	string45  ip_address;
	string10  phone10;
	string10  wphone10;
	string100  employer_name;
	string20  lname_prev;
	string12  transaction_id;
	string20  verfirst;
	string20  verlast;
	string65  veraddr;
	string25  vercity;
	string2  verstate;
	string5  verzip;
	string4  verzip4;
	string12  verdpbc;
	string9  verssn;
	string8  verdob;
	string10  verhphone;
	string1  verify_addr;
	string1  verify_dob;
	string1  valid_ssn;
	string3  nas_summary;
	string3  nap_summary;
	string1  nap_type;
	string1  nap_status;
	string3  cvi;
	string3  additional_score1;
	string3  additional_score2;
	string4  hri_1;
	string100  hri_desc_1;
	string4  hri_2;
	string100  hri_desc_2;
	string4  hri_3;
	string100  hri_desc_3;
	string4  hri_4;
	string100  hri_desc_4;
	string4  hri_5;
	string100  hri_desc_5;
	string4  hri_6;
	string100  hri_desc_6;
	string4  fua_1;
	string150  fua_desc_1;
	string4  fua_2;
	string150  fua_desc_2;
	string4  fua_3;
	string150  fua_desc_3;
	string4  fua_4;
	string150  fua_desc_4;
	string20  corrected_lname;
	string8  corrected_dob;
	string10  corrected_phone;
	string9  corrected_ssn;
	string65  corrected_address;
	string3  area_code_split;
	string8  area_code_split_date;
	string20  phone_fname;
	string20  phone_lname;
	string65  phone_address;
	string25  phone_city;
	string2  phone_st;
	string5  phone_zip;
	string10  name_addr_phone;
	string6  ssa_date_first;
	string6  ssa_date_last;
	string2  ssa_state;
	string20  ssa_state_name;
	string20  current_fname;
	string20  current_lname;
	string65  chron_address_1;
	string25  chron_city_1;
	string2  chron_st_1;
	string5  chron_zip_1;
	string4  chron_zip4_1;
	string12  chron_dpbc_1;
	string50  chron_phone_1;
	string6  chron_dt_first_seen_1;
	string6  chron_dt_last_seen_1;
	string65  chron_address_2;
	string25  chron_city_2;
	string2  chron_st_2;
	string5  chron_zip_2;
	string4  chron_zip4_2;
	string12  chron_dpbc_2;
	string50  chron_phone_2;
	string6  chron_dt_first_seen_2;
	string6  chron_dt_last_seen_2;
	string65  chron_address_3;
	string25  chron_city_3;
	string2  chron_st_3;
	string5  chron_zip_3;
	string4  chron_zip4_3;
	string12  chron_dpbc_3;
	string50  chron_phone_3;
	string6  chron_dt_first_seen_3;
	string6  chron_dt_last_seen_3;
	string20  additional_fname_1;
	string20  additional_lname_1;
	string8  additional_lname_date_last_1;
	string20  additional_fname_2;
	string20  additional_lname_2;
	string8  additional_lname_date_last_2;
	string20  additional_fname_3;
	string20  additional_lname_3;
	string8  additional_lname_date_last_3;
	string60  watchlist_table;
	string120  watchlist_program;
	string10  watchlist_record_number;
	string20  watchlist_fname;
	string20  watchlist_lname;
	string65  watchlist_address;
	string25  watchlist_city;
	string2  watchlist_state;
	string5  watchlist_zip;
	string30  watchlist_contry;
	string200  watchlist_entity_name;
	string3  fd_score1;
	string3  fd_score2;
	string3  fd_score3;
	string4  fd_reason1;
	string100  fd_desc1;
	string4  fd_reason2;
	string100  fd_desc2;
	string4  fd_reason3;
	string100  fd_desc3;
	string4  fd_reason4;
	string100  fd_desc4;
	string1  address_discrepancy;
	string2  address_discrepancy_rc1;
	string2  address_discrepancy_rc2;
	string2  address_discrepancy_rc3;
	string2  address_discrepancy_rc4;
	string1  suspicious_documents;
	string2  suspicious_documents_rc1;
	string2  suspicious_documents_rc2;
	string2  suspicious_documents_rc3;
	string2  suspicious_documents_rc4;
	string1  suspicious_address;
	string2  suspicious_address_rc1;
	string2  suspicious_address_rc2;
	string2  suspicious_address_rc3;
	string2  suspicious_address_rc4;
	string1  suspicious_ssn;
	string2  suspicious_ssn_rc1;
	string2  suspicious_ssn_rc2;
	string2  suspicious_ssn_rc3;
	string2  suspicious_ssn_rc4;
	string1  suspicious_dob;
	string2  suspicious_dob_rc1;
	string2  suspicious_dob_rc2;
	string2  suspicious_dob_rc3;
	string2  suspicious_dob_rc4;
	string1  high_risk_address;
	string2  high_risk_address_rc1;
	string2  high_risk_address_rc2;
	string2  high_risk_address_rc3;
	string2  high_risk_address_rc4;
	string1  suspicious_phone;
	string2  suspicious_phone_rc1;
	string2  suspicious_phone_rc2;
	string2  suspicious_phone_rc3;
	string2  suspicious_phone_rc4;
	string1  ssn_multiple_last;
	string2  ssn_multiple_last_rc1;
	string2  ssn_multiple_last_rc2;
	string2  ssn_multiple_last_rc3;
	string2  ssn_multiple_last_rc4;
	string1  missing_input;
	string2  missing_input_rc1;
	string2  missing_input_rc2;
	string2  missing_input_rc3;
	string2  missing_input_rc4;
	string1  fraud_alert;
	string2  fraud_alert_rc1;
	string2  fraud_alert_rc2;
	string2  fraud_alert_rc3;
	string2  fraud_alert_rc4;
	string1  credit_freeze;
	string2  credit_freeze_rc1;
	string2  credit_freeze_rc2;
	string2  credit_freeze_rc3;
	string2  credit_freeze_rc4;
	string1  identity_theft;
	string2  identity_theft_rc1;
	string2  identity_theft_rc2;
	string2  identity_theft_rc3;
	string2  identity_theft_rc4;
	string1  placeholder1;
	string2  placeholder1_rc1;
	string2  placeholder1_rc2;
	string2  placeholder1_rc3;
	string2  placeholder1_rc4;
	string1  placeholder2;
	string2  placeholder2_rc1;
	string2  placeholder2_rc2;
	string2  placeholder2_rc3;
	string2  placeholder2_rc4;
	string1  placeholder3;
	string2  placeholder3_rc1;
	string2  placeholder3_rc2;
	string2  placeholder3_rc3;
	string2  placeholder3_rc4;
	string1  placeholder4;
	string2  placeholder4_rc1;
	string2  placeholder4_rc2;
	string2  placeholder4_rc3;
	string2  placeholder4_rc4;
	string1  placeholder5;
	string2  placeholder5_rc1;
	string2  placeholder5_rc2;
	string2  placeholder5_rc3;
	string2  placeholder5_rc4;
	string20  vercounty;
	string1  chron_addr_1_isbest;
	string1  chron_addr_2_isbest;
	string1  chron_addr_3_isbest;
	string3  subjectssncount;
	string20  verdl;
	string8  deceaseddate;
	string8  deceaseddob;
	string15  deceasedfirst;
	string20  deceasedlast;
	string60  watchlist_table_2;
	string120  watchlist_program_2;
	string10  watchlist_record_number_2;
	string20  watchlist_fname_2;
	string20  watchlist_lname_2;
	string65  watchlist_address_2;
	string25  watchlist_city_2;
	string2  watchlist_state_2;
	string5  watchlist_zip_2;
	string30  watchlist_contry_2;
	string200  watchlist_entity_name_2;
	string60  watchlist_table_3;
	string120  watchlist_program_3;
	string10  watchlist_record_number_3;
	string20  watchlist_fname_3;
	string20  watchlist_lname_3;
	string65  watchlist_address_3;
	string25  watchlist_city_3;
	string2  watchlist_state_3;
	string5  watchlist_zip_3;
	string30  watchlist_contry_3;
	string200  watchlist_entity_name_3;
	string60  watchlist_table_4;
	string120  watchlist_program_4;
	string10  watchlist_record_number_4;
	string20  watchlist_fname_4;
	string20  watchlist_lname_4;
	string65  watchlist_address_4;
	string25  watchlist_city_4;
	string2  watchlist_state_4;
	string5  watchlist_zip_4;
	string30  watchlist_contry_4;
	string200  watchlist_entity_name_4;
	string60  watchlist_table_5;
	string120  watchlist_program_5;
	string10  watchlist_record_number_5;
	string20  watchlist_fname_5;
	string20  watchlist_lname_5;
	string65  watchlist_address_5;
	string25  watchlist_city_5;
	string2  watchlist_state_5;
	string5  watchlist_zip_5;
	string30  watchlist_contry_5;
	string200  watchlist_entity_name_5;
	string60  watchlist_table_6;
	string120  watchlist_program_6;
	string10  watchlist_record_number_6;
	string20  watchlist_fname_6;
	string20  watchlist_lname_6;
	string65  watchlist_address_6;
	string25  watchlist_city_6;
	string2  watchlist_state_6;
	string5  watchlist_zip_6;
	string30  watchlist_contry_6;
	string200  watchlist_entity_name_6;
	string60  watchlist_table_7;
	string120  watchlist_program_7;
	string10  watchlist_record_number_7;
	string20  watchlist_fname_7;
	string20  watchlist_lname_7;
	string65  watchlist_address_7;
	string25  watchlist_city_7;
	string2  watchlist_state_7;
	string5  watchlist_zip_7;
	string30  watchlist_contry_7;
	string200  watchlist_entity_name_7;
	string1  dobmatchlevel;
	string4  hri_7;
	string100  hri_desc_7;
	string4  hri_8;
	string100  hri_desc_8;
	string4  hri_9;
	string100  hri_desc_9;
	string4  hri_10;
	string100  hri_desc_10;
	string4  hri_11;
	string100  hri_desc_11;
	string4  hri_12;
	string100  hri_desc_12;
	string4  hri_13;
	string100  hri_desc_13;
	string4  hri_14;
	string100  hri_desc_14;
	string4  hri_15;
	string100  hri_desc_15;
	string4  hri_16;
	string100  hri_desc_16;
	string4  hri_17;
	string100  hri_desc_17;
	string4  hri_18;
	string100  hri_desc_18;
	string4  hri_19;
	string100  hri_desc_19;
	string4  hri_20;
	string100  hri_desc_20;
	string10  verprimrange;
	string2  verpredir;
	string28  verprimname;
	string4  veraddrsuffix;
	string2  verpostdir;
	string10  verunitdesignation;
	string8  versecrange;
	string10  correctedprimrange;
	string2  correctedpredir;
	string28  correctedprimname;
	string4  correctedaddrsuffix;
	string2  correctedpostdir;
	string10  correctedunitdesignation;
	string8  correctedsecrange;
	string10  phoneprimrange;
	string2  phonepredir;
	string28  phoneprimname;
	string4  phoneaddrsuffix;
	string2  phonepostdir;
	string10  phoneunitdesignation;
	string8  phonesecrange;
	string10  chronprimrange1;
	string2  chronpredir1;
	string28  chronprimname1;
	string4  chronaddrsuffix1;
	string2  chronpostdir1;
	string10  chronunitdesignation1;
	string8  chronsecrange1;
	string10  chronprimrange2;
	string2  chronpredir2;
	string28  chronprimname2;
	string4  chronaddrsuffix2;
	string2  chronpostdir2;
	string10  chronunitdesignation2;
	string8  chronsecrange2;
	string10  chronprimrange3;
	string2  chronpredir3;
	string28  chronprimname3;
	string4  chronaddrsuffix3;
	string2  chronpostdir3;
	string10  chronunitdesignation3;
	string8  chronsecrange3;
	string10  watchlistprimrange;
	string2  watchlistpredir;
	string28  watchlistprimname;
	string4  watchlistaddrsuffix;
	string2  watchlistpostdir;
	string10  watchlistunitdesignation;
	string8  watchlistsecrange;
	string10  watchlistprimrange2;
	string2  watchlistpredir2;
	string28  watchlistprimname2;
	string4  watchlistaddrsuffix2;
	string2  watchlistpostdir2;
	string10  watchlistunitdesignation2;
	string8  watchlistsecrange2;
	string10  watchlistprimrange3;
	string2  watchlistpredir3;
	string28  watchlistprimname3;
	string4  watchlistaddrsuffix3;
	string2  watchlistpostdir3;
	string10  watchlistunitdesignation3;
	string8  watchlistsecrange3;
	string10  watchlistprimrange4;
	string2  watchlistpredir4;
	string28  watchlistprimname4;
	string4  watchlistaddrsuffix4;
	string2  watchlistpostdir4;
	string10  watchlistunitdesignation4;
	string8  watchlistsecrange4;
	string10  watchlistprimrange5;
	string2  watchlistpredir5;
	string28  watchlistprimname5;
	string4  watchlistaddrsuffix5;
	string2  watchlistpostdir5;
	string10  watchlistunitdesignation5;
	string8  watchlistsecrange5;
	string10  watchlistprimrange6;
	string2  watchlistpredir6;
	string28  watchlistprimname6;
	string4  watchlistaddrsuffix6;
	string2  watchlistpostdir6;
	string10  watchlistunitdesignation6;
	string8  watchlistsecrange6;
	string10  watchlistprimrange7;
	string2  watchlistpredir7;
	string28  watchlistprimname7;
	string4  watchlistaddrsuffix7;
	string2  watchlistpostdir7;
	string10  watchlistunitdesignation7;
	string8  watchlistsecrange7;
	string1  stolenidentityindex;
	string1  syntheticidentityindex;
	string1  manipulatedidentityindex;
	string1  vulnerablevictimindex;
	string1  friendlyfraudindex;
	string1  suspiciousactivityindex;
	string4  fd_reason5;
	string100  fd_desc5;
	string4  fd_reason6;
	string100  fd_desc6;
	boolean  ssnfoundforlexid;
	boolean  addresspobox;
	boolean  addresscmra;
	string3  cvicustomscore;
	string1  instantidversion;
	string  errorcode;
end;


EXPORT IID_Report_Function(string filename, string output_base_location, string jobid_in = ''):= function


eyeball := 50;

string jobid := if(jobid_in = '', thorlib.wuid(), jobid_in);







// myIIDRecords := DATASET('~mseubert::out::iid_test_file',IIDRecord,csv(heading(single), quote('"')));
// myIIDRecords := DATASET('~mseubert::out::iid_test_file',IIDRecord,thor);


// myIIDRecords :=  DATASET('~mseubert::out::iid_test_file', IIDRecord, thor);
//myIIDRecords :=  DATASET(filename, IIDRecord, thor);
// myIIDRecords :=  DATASET(filename, IIDRecord,csv(heading(single), quote('"')));
myIIDRecords :=  DATASET(filename, IIDRecord,csv(separator('|'), heading(1), quote('"')));
output(choosen(myIIDrecords, 5),  named('iid_file_sample'));


//////////////////////////////////////////////////////////////////////////////////Report 1 - NAP-NAS Crosstab

t :=  table
(myIIDRecords, {nas_summary, nap_summary, total := count(group)}, nas_summary, nap_summary);

//output(t,  named('nas_nap_crosstab'));


TotalRecords :=  COUNT(myIIDRecords);

NAP_NAS_Summary :=  SORT
(TABLE(myIIDRecords, 
	{
	STRING2 NAP := NAP_summary,
	UNSIGNED Total := COUNT(GROUP),
	REAL Total_Percent := (COUNT(GROUP) / TotalRecords) * 100,
	REAL NAS_0 := (COUNT(GROUP, (INTEGER)nas_summary = 0) / TotalRecords) * 100, 
	REAL NAS_1 := (COUNT(GROUP, (INTEGER)nas_summary = 1) / TotalRecords) * 100, 
	REAL NAS_2 := (COUNT(GROUP, (INTEGER)nas_summary = 2) / TotalRecords) * 100, 
	REAL NAS_3 := (COUNT(GROUP, (INTEGER)nas_summary = 3) / TotalRecords) * 100, 
	REAL NAS_4 := (COUNT(GROUP, (INTEGER)nas_summary = 4) / TotalRecords) * 100,
	REAL NAS_5 := (COUNT(GROUP, (INTEGER)nas_summary = 5) / TotalRecords) * 100,
	REAL NAS_6 := (COUNT(GROUP, (INTEGER)nas_summary = 6) / TotalRecords) * 100, 
	REAL NAS_7 := (COUNT(GROUP, (INTEGER)nas_summary = 7) / TotalRecords) * 100, 
	REAL NAS_8 := (COUNT(GROUP, (INTEGER)nas_summary = 8) / TotalRecords) * 100, 
	REAL NAS_9 := (COUNT(GROUP, (INTEGER)nas_summary = 9) / TotalRecords) * 100, 
	REAL NAS_10 := (COUNT(GROUP, (INTEGER)nas_summary = 10) / TotalRecords) * 100, 
	REAL NAS_11 := (COUNT(GROUP, (INTEGER)nas_summary = 11) / TotalRecords) * 100, 
	REAL NAS_12 := (COUNT(GROUP, (INTEGER)nas_summary = 12) / TotalRecords) * 100	
		
	},
 NAP_summary), (INTEGER)NAP);


Condensedlayout := record
	string2  NAP;
	string  Description;
	real8  Total;
	real8  Total_Percent;
	real8  NAS_0;
	real8  NAS_1;
	real8  NAS_2;
	real8  NAS_3;
	real8  NAS_4;
	real8  NAS_5;
	real8  NAS_6;
	real8  NAS_7;
	real8  NAS_8;
	real8  NAS_9;
	real8  NAS_10;
	real8  NAS_11;
	real8  NAS_12;

end;
CondensedLayout CondenseList(NAP_NAS_Summary l, Integer2 c):= Transform
	Self.NAP := l.NAP;
self.Total :=   l.Total;
self.Total_Percent :=    l.Total_Percent;
self.Description := 
			 map
( l.NAP = '0' => 'Nothing Found for input criteria',
					  l.NAP = '1' => 'Input phone is associated with a different name and address',
					  l.NAP = '2' => 'Input First Name and Last Name matched',
					  l.NAP = '3' => 'Input First Name and Address matched',
					  l.NAP = '4' => 'Input First Name and Phone matched',
					  l.NAP = '5' => 'Input Last Name and Address matched',
					  l.NAP = '6' => 'Input Address and Phone matched',
					  l.NAP = '7' => 'Input Last Name and Phone matched',
					  l.NAP = '8' => 'Input First Name, Last Name and Address matched',
					  l.NAP = '9' => 'Input First Name, Last Name and Phone matched',
					  l.NAP = '10' => 'Input First Name, Address and Phone matched',
					  l.NAP = '11' => 'Input Last Name, Address and Phone matched',
					  l.NAP = '12' => 'Input First Name, Last Name, Address and Phone matched',
					 'not given');
self.NAS_0 :=   l.NAS_0;
self.NAS_1 :=   l.NAS_1;
self.NAS_2 :=   l.NAS_2;
self.NAS_3 :=   l.NAS_3;
self.NAS_4 :=   l.NAS_4;
self.NAS_5 :=   l.NAS_5;
self.NAS_6 :=   l.NAS_6;
self.NAS_7 :=   l.NAS_7;
self.NAS_8 :=   l.NAS_8;
self.NAS_9 :=   l.NAS_9;
self.NAS_10 :=  l.NAS_10;
self.NAS_11 :=  l.NAS_11;
self.NAS_12 :=  l.NAS_12;


  Self :=  l;
end;


MyList :=  project(NAP_NAS_Summary,  CondenseList(left,  counter));

//output(MyList,  named('NAP_NAS_Crosstab'));
OUTPUT(MyList,, output_base_location + 'NAP_NAS_Crosstab_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));


Summary_Row :=  table
(MyList,
{
	//NAP,
	//Description,
	Total,
	Total_Percent,
	nas_0_count := sum(group, NAS_0),
	NAS_1_count := sum(group, NAS_1),
	NAS_2_count := sum(group, NAS_2),
	NAS_3_count := sum(group, NAS_3),
	NAS_4_count := sum(group, NAS_4),
	NAS_5_count := sum(group, NAS_5),
	NAS_6_count := sum(group, NAS_6),
	NAS_7_count := sum(group, NAS_7),
	NAS_8_count := sum(group, NAS_8),
	NAS_9_count := sum(group, NAS_9),
	NAS_10_count := sum(group, NAS_10),
	NAS_11_count := sum(group, NAS_11),
	NAS_12_count := sum(group, NAS_12),
});

 
 
//output(Summary_Row,  named('Summary_Row'));
OUTPUT(Summary_Row,, output_base_location + 'Summary_Row_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));



///////////////////////////////////////////////////////////////////////////////REPORT 2 - Red Flags Summary



Red_Flags_Detailed_Summary :=  
TABLE
(myIIDRecords, 
	{ 
	CVI, 
	UNSIGNED Total := COUNT(GROUP),
	REAL Total_Percent := (COUNT(GROUP) / TotalRecords) * 100,
	
//Fraud Alert
	real RC_93 := (COUNT(GROUP, fraud_alert_rc1 = '93' or fraud_alert_rc2 = '93' or fraud_alert_rc3 = '93' or fraud_alert_rc4 = '93'))/ COUNT(GROUP) * 100,
	
//Credit Freeze	
	real RC_91 := (COUNT(GROUP, credit_freeze_rc1 = '91' or credit_freeze_rc2 = '91' or credit_freeze_rc3 = '91' or credit_freeze_rc4 = '91'))/ COUNT(GROUP) * 100,
	
//Address Discrepancy	
	real RC_PA := (COUNT(GROUP, address_discrepancy_rc1 = 'PA' or address_discrepancy_rc2 = 'PA' or address_discrepancy_rc3 = 'PA' or address_discrepancy_rc4 = 'PA'))/ COUNT(GROUP) * 100,
	real RC_25 := (COUNT(GROUP, address_discrepancy_rc1 = '25' or address_discrepancy_rc2 = '25' or address_discrepancy_rc3 = '25' or address_discrepancy_rc4 = '25'))/ COUNT(GROUP) * 100,
	real RC_11 := (COUNT(GROUP, address_discrepancy_rc1 = '11' or address_discrepancy_rc2 = '11' or address_discrepancy_rc3 = '11' or address_discrepancy_rc4 = '11'))/ COUNT(GROUP) * 100,
	real RC_SR := (COUNT(GROUP, address_discrepancy_rc1 = 'SR' or address_discrepancy_rc2 = 'SR' or address_discrepancy_rc3 = 'SR' or address_discrepancy_rc4 = 'SR'))/ COUNT(GROUP) * 100,
	real RC_30 := (COUNT(GROUP, address_discrepancy_rc1 = '30' or address_discrepancy_rc2 = '30' or address_discrepancy_rc3 = '30' or address_discrepancy_rc4 = '30'))/ COUNT(GROUP) * 100,
	real RC_04 := (COUNT(GROUP, address_discrepancy_rc1 = '04' or address_discrepancy_rc2 = '04' or address_discrepancy_rc3 = '04' or address_discrepancy_rc4 = '04'))/ COUNT(GROUP) * 100,
//Suspicious Documents
	real RC_41 := (COUNT(GROUP, suspicious_documents_rc1 = '41' or suspicious_documents_rc2 = '41' or suspicious_documents_rc3 = '41' or suspicious_documents_rc4 = '41'))/ COUNT(GROUP) * 100,
	real RC_06 := (COUNT(GROUP, suspicious_documents_rc1 = '06' or suspicious_documents_rc2 = '06' or suspicious_documents_rc3 = '06' or suspicious_documents_rc4 = '06'))/ COUNT(GROUP) * 100,
//Suspicious Address	
	real RC_PA_2 := (COUNT(GROUP, suspicious_address_rc1 = 'PA' or suspicious_address_rc2 = 'PA' or suspicious_address_rc3 = 'PA' or suspicious_address_rc4 = 'PA'))/ COUNT(GROUP) * 100,
	real RC_25_2 := (COUNT(GROUP, suspicious_address_rc1 = '25' or suspicious_address_rc2 = '25' or suspicious_address_rc3 = '25' or suspicious_address_rc4 = '25'))/ COUNT(GROUP) * 100,
	real RC_SR_2 := (COUNT(GROUP, suspicious_address_rc1 = 'SR' or suspicious_address_rc2 = 'SR' or suspicious_address_rc3 = 'SR' or suspicious_address_rc4 = 'SR'))/ COUNT(GROUP) * 100,
	real RC_30_2 := (COUNT(GROUP, suspicious_address_rc1 = '30' or suspicious_address_rc2 = '30' or suspicious_address_rc3 = '30' or suspicious_address_rc4 = '30'))/ COUNT(GROUP) * 100,
	real RC_19 := ((COUNT(GROUP, suspicious_address_rc1 = '19' or suspicious_address_rc2 = '19' or suspicious_address_rc3 = '19' or suspicious_address_rc4 = '19'))/ COUNT(GROUP)) * 100,
	real RC_04_2 := (COUNT(GROUP, suspicious_address_rc1 = '04' or suspicious_address_rc2 = '04' or suspicious_address_rc3 = '04' or suspicious_address_rc4 = '04'))/ COUNT(GROUP) * 100,
//Suspicious SSN	
	real RC_02 := (COUNT(GROUP, suspicious_ssn_rc1 = '02' or suspicious_ssn_rc2 = '02' or suspicious_ssn_rc3 = '02' or suspicious_ssn_rc4 = '02'))/ COUNT(GROUP) * 100,
	real RC_29 := (COUNT(GROUP, suspicious_ssn_rc1 = '29' or suspicious_ssn_rc2 = '29' or suspicious_ssn_rc3 = '29' or suspicious_ssn_rc4 = '29'))/ COUNT(GROUP) * 100,
	real RC_89 := (COUNT(GROUP, suspicious_ssn_rc1 = '89' or suspicious_ssn_rc2 = '89' or suspicious_ssn_rc3 = '89' or suspicious_ssn_rc4 = '89'))/ COUNT(GROUP) * 100,
	real RC_90 := (COUNT(GROUP, suspicious_ssn_rc1 = '90' or suspicious_ssn_rc2 = '90' or suspicious_ssn_rc3 = '90' or suspicious_ssn_rc4 = '90'))/ COUNT(GROUP) * 100,
	real RC_39 := (COUNT(GROUP, suspicious_ssn_rc1 = '39' or suspicious_ssn_rc2 = '39' or suspicious_ssn_rc3 = '39' or suspicious_ssn_rc4 = '39'))/ COUNT(GROUP) * 100,
	real RC_06_2 := (COUNT(GROUP, suspicious_ssn_rc1 = '06' or suspicious_ssn_rc2 = '06' or suspicious_ssn_rc3 = '06' or suspicious_ssn_rc4 = '06'))/ COUNT(GROUP) * 100,
	real RC_IT := (COUNT(GROUP, suspicious_ssn_rc1 = 'IT' or suspicious_ssn_rc2 = 'IT' or suspicious_ssn_rc3 = 'IT' or suspicious_ssn_rc4 = 'IT'))/ COUNT(GROUP) * 100,
//Suspicious DOB
	real RC_28 := (COUNT(GROUP, suspicious_dob_rc1 = '28' or suspicious_dob_rc2 = '28' or suspicious_dob_rc3 = '28' or suspicious_dob_rc4 = '28'))/ COUNT(GROUP) * 100,
	real RC_83 := (COUNT(GROUP, suspicious_dob_rc1 = '83' or suspicious_dob_rc2 = '83' or suspicious_dob_rc3 = '83' or suspicious_dob_rc4 = '83'))/ COUNT(GROUP) * 100,
	real RC_03 := (COUNT(GROUP, suspicious_dob_rc1 = '03' or suspicious_dob_rc2 = '03' or suspicious_dob_rc3 = '03' or suspicious_dob_rc4 = '03'))/ COUNT(GROUP) * 100,
//High Risk Address
	real RC_PO := (COUNT(GROUP, high_risk_address_rc1 = 'PO' or high_risk_address_rc2 = 'PO' or high_risk_address_rc3 = 'PO' or high_risk_address_rc4 = 'PO'))/ COUNT(GROUP) * 100,
	real RC_12 := (COUNT(GROUP, high_risk_address_rc1 = '12' or high_risk_address_rc2 = '12' or high_risk_address_rc3 = '12' or high_risk_address_rc4 = '12'))/ COUNT(GROUP) * 100,
	real RC_11_2 := (COUNT(GROUP, high_risk_address_rc1 = '11' or high_risk_address_rc2 = '11' or high_risk_address_rc3 = '11' or high_risk_address_rc4 = '11'))/ COUNT(GROUP) * 100,
	real RC_14 := (COUNT(GROUP, high_risk_address_rc1 = '14' or high_risk_address_rc2 = '14' or high_risk_address_rc3 = '14' or high_risk_address_rc4 = '14'))/ COUNT(GROUP) * 100,
	real RC_50 := (COUNT(GROUP, high_risk_address_rc1 = '50' or high_risk_address_rc2 = '50' or high_risk_address_rc3 = '50' or high_risk_address_rc4 = '50'))/ COUNT(GROUP) * 100,
	real RC_40 := (COUNT(GROUP, high_risk_address_rc1 = '40' or high_risk_address_rc2 = '40' or high_risk_address_rc3 = '40' or high_risk_address_rc4 = '40'))/ COUNT(GROUP) * 100,
//Suspicious Phone
	real RC_10 := (COUNT(GROUP, suspicious_phone_rc1 = '10' or suspicious_phone_rc2 = '10' or suspicious_phone_rc3 = '10' or suspicious_phone_rc4 = '10'))/ COUNT(GROUP) * 100,
	real RC_27 := (COUNT(GROUP, suspicious_phone_rc1 = '27' or suspicious_phone_rc2 = '27' or suspicious_phone_rc3 = '27' or suspicious_phone_rc4 = '27'))/ COUNT(GROUP) * 100,
	real RC_15 := (COUNT(GROUP, suspicious_phone_rc1 = '15' or suspicious_phone_rc2 = '15' or suspicious_phone_rc3 = '15' or suspicious_phone_rc4 = '15'))/ COUNT(GROUP) * 100,
	real RC_07 := (COUNT(GROUP, suspicious_phone_rc1 = '07' or suspicious_phone_rc2 = '07' or suspicious_phone_rc3 = '07' or suspicious_phone_rc4 = '07'))/ COUNT(GROUP) * 100,
	real RC_16 := (COUNT(GROUP, suspicious_phone_rc1 = '16' or suspicious_phone_rc2 = '16' or suspicious_phone_rc3 = '16' or suspicious_phone_rc4 = '16'))/ COUNT(GROUP) * 100,
	real RC_08 := (COUNT(GROUP, suspicious_phone_rc1 = '08' or suspicious_phone_rc2 = '08' or suspicious_phone_rc3 = '08' or suspicious_phone_rc4 = '08'))/ COUNT(GROUP) * 100,
	real RC_09 := (COUNT(GROUP, suspicious_phone_rc1 = '09' or suspicious_phone_rc2 = '09' or suspicious_phone_rc3 = '09' or suspicious_phone_rc4 = '09'))/ COUNT(GROUP) * 100,
	real RC_74 := (COUNT(GROUP, suspicious_phone_rc1 = '74' or suspicious_phone_rc2 = '74' or suspicious_phone_rc3 = '74' or suspicious_phone_rc4 = '74'))/ COUNT(GROUP) * 100,
	real RC_73 := (COUNT(GROUP, suspicious_phone_rc1 = '73' or suspicious_phone_rc2 = '73' or suspicious_phone_rc3 = '73' or suspicious_phone_rc4 = '73'))/ COUNT(GROUP) * 100,
	real RC_49 := (COUNT(GROUP, suspicious_phone_rc1 = '49' or suspicious_phone_rc2 = '49' or suspicious_phone_rc3 = '49' or suspicious_phone_rc4 = '49'))/ COUNT(GROUP) * 100,
	real RC_31 := (COUNT(GROUP, suspicious_phone_rc1 = '31' or suspicious_phone_rc2 = '31' or suspicious_phone_rc3 = '31' or suspicious_phone_rc4 = '31'))/ COUNT(GROUP) * 100,
//SSN Multiple Last	
	real RC_38 := (COUNT(GROUP, ssn_multiple_last_rc1 = '38' or ssn_multiple_last_rc2 = '38' or ssn_multiple_last_rc3 = '38' or ssn_multiple_last_rc4 = '38'))/ COUNT(GROUP) * 100,
	real RC_MI := (COUNT(GROUP, ssn_multiple_last_rc1 = 'MI' or ssn_multiple_last_rc2 = 'MI' or ssn_multiple_last_rc3 = 'MI' or ssn_multiple_last_rc4 = 'MI'))/ COUNT(GROUP) * 100,
	real RC_72 := (COUNT(GROUP, ssn_multiple_last_rc1 = '72' or ssn_multiple_last_rc2 = '72' or ssn_multiple_last_rc3 = '72' or ssn_multiple_last_rc4 = '72'))/ COUNT(GROUP) * 100,
	real RC_66 := (COUNT(GROUP, ssn_multiple_last_rc1 = '66' or ssn_multiple_last_rc2 = '66' or ssn_multiple_last_rc3 = '66' or ssn_multiple_last_rc4 = '66'))/ COUNT(GROUP) * 100,
//Missing Input
	real RC_80 := (COUNT(GROUP, missing_input_rc1 = '80' or missing_input_rc2 = '80' or missing_input_rc3 = '80' or missing_input_rc4 = '80'))/ COUNT(GROUP) * 100,
	real RC_79 := (COUNT(GROUP, missing_input_rc1 = '79' or missing_input_rc2 = '79' or missing_input_rc3 = '79' or missing_input_rc4 = '79'))/ COUNT(GROUP) * 100,
	real RC_81 := (COUNT(GROUP, missing_input_rc1 = '81' or missing_input_rc2 = '81' or missing_input_rc3 = '81' or missing_input_rc4 = '81'))/ COUNT(GROUP) * 100,
	real RC_77 := (COUNT(GROUP, missing_input_rc1 = '77' or missing_input_rc2 = '77' or missing_input_rc3 = '77' or missing_input_rc4 = '77'))/ COUNT(GROUP) * 100,
	real RC_78 := (COUNT(GROUP, missing_input_rc1 = '78' or missing_input_rc2 = '78' or missing_input_rc3 = '78' or missing_input_rc4 = '78'))/ COUNT(GROUP) * 100,
//Identity Theft
  real RC_93_2 := (COUNT(GROUP, identity_theft_rc1 = '93' or identity_theft_rc2 = '93' or identity_theft_rc3 = '93' or identity_theft_rc4 = '93'))/ COUNT(GROUP) * 100
		
	}
	, cvi
	);

 
//OUTPUT(Red_Flags_Detailed_Summary,  NAMED('Red_Flags_Detailed_Summary'));
OUTPUT(Red_Flags_Detailed_Summary,, output_base_location + 'Red_Flags_Detailed_Summary_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));



Red_Flags_Overall_Summary :=  
TABLE
(myIIDRecords, 
	{ 
	CVI, 
	UNSIGNED Total := COUNT(GROUP),
	REAL Total_Percent := (COUNT(GROUP) / TotalRecords) * 100,
	real Fraud_Alert := (COUNT(GROUP, fraud_alert_rc1 = '93' or fraud_alert_rc2 = '93' or fraud_alert_rc3 = '93' or fraud_alert_rc4 = '93'))/ COUNT(GROUP) * 100,
	real Credit_Freeze := (COUNT(GROUP, credit_freeze_rc1 = '91' or credit_freeze_rc2 = '91' or credit_freeze_rc3 = '91' or credit_freeze_rc4 = '91'))/ COUNT(GROUP) * 100,
	real Address_Discrepancy := (COUNT(GROUP, address_discrepancy_rc1 = 'PA' or address_discrepancy_rc2 = 'PA' or address_discrepancy_rc3 = 'PA' or address_discrepancy_rc4 = 'PA'or
			address_discrepancy_rc1 = '25' or address_discrepancy_rc2 = '25' or address_discrepancy_rc3 = '25' or address_discrepancy_rc4 = '25'or
			address_discrepancy_rc1 = '11' or address_discrepancy_rc2 = '11' or address_discrepancy_rc3 = '11' or address_discrepancy_rc4 = '11'or
			address_discrepancy_rc1 = 'SR' or address_discrepancy_rc2 = 'SR' or address_discrepancy_rc3 = 'SR' or address_discrepancy_rc4 = 'SR'or
			address_discrepancy_rc1 = '30' or address_discrepancy_rc2 = '30' or address_discrepancy_rc3 = '30' or address_discrepancy_rc4 = '30'or
			address_discrepancy_rc1 = '04' or address_discrepancy_rc2 = '04' or address_discrepancy_rc3 = '04' or address_discrepancy_rc4 = '04'))/ COUNT(GROUP) * 100,
	real Suspicious_Documents := (COUNT(GROUP, suspicious_documents_rc1 = '41' or suspicious_documents_rc2 = '41' or suspicious_documents_rc3 = '41' or suspicious_documents_rc4 = '41' or
			suspicious_documents_rc1 = '06' or suspicious_documents_rc2 = '06' or suspicious_documents_rc3 = '06' or suspicious_documents_rc4 = '06'))/ COUNT(GROUP) * 100,	
	real Suspicious_Address := (COUNT(GROUP, suspicious_address_rc1 = 'PA' or suspicious_address_rc2 = 'PA' or suspicious_address_rc3 = 'PA' or suspicious_address_rc4 = 'PA'or
			suspicious_address_rc1 = '25' or suspicious_address_rc2 = '25' or suspicious_address_rc3 = '25' or suspicious_address_rc4 = '25'or
			suspicious_address_rc1 = 'SR' or suspicious_address_rc2 = 'SR' or suspicious_address_rc3 = 'SR' or suspicious_address_rc4 = 'SR'or
			suspicious_address_rc1 = '30' or suspicious_address_rc2 = '30' or suspicious_address_rc3 = '30' or suspicious_address_rc4 = '30'or
			suspicious_address_rc1 = '19' or suspicious_address_rc2 = '19' or suspicious_address_rc3 = '19' or suspicious_address_rc4 = '19'or
			suspicious_address_rc1 = '04' or suspicious_address_rc2 = '04' or suspicious_address_rc3 = '04' or suspicious_address_rc4 = '04'))/ COUNT(GROUP) * 100,	
	real Suspicious_SSN := (COUNT(GROUP, suspicious_ssn_rc1 = '02' or suspicious_ssn_rc2 = '02' or suspicious_ssn_rc3 = '02' or suspicious_ssn_rc4 = '02'or
			suspicious_ssn_rc1 = '29' or suspicious_ssn_rc2 = '29' or suspicious_ssn_rc3 = '29' or suspicious_ssn_rc4 = '29'or
			suspicious_ssn_rc1 = '89' or suspicious_ssn_rc2 = '89' or suspicious_ssn_rc3 = '89' or suspicious_ssn_rc4 = '89'or
			suspicious_ssn_rc1 = '90' or suspicious_ssn_rc2 = '90' or suspicious_ssn_rc3 = '90' or suspicious_ssn_rc4 = '90'or
			suspicious_ssn_rc1 = '39' or suspicious_ssn_rc2 = '39' or suspicious_ssn_rc3 = '39' or suspicious_ssn_rc4 = '39'or
			suspicious_ssn_rc1 = '06' or suspicious_ssn_rc2 = '06' or suspicious_ssn_rc3 = '06' or suspicious_ssn_rc4 = '06'or
			suspicious_ssn_rc1 = 'IT' or suspicious_ssn_rc2 = 'IT' or suspicious_ssn_rc3 = 'IT' or suspicious_ssn_rc4 = 'IT'))/ COUNT(GROUP) * 100,
	real Suspicious_DOB := (COUNT(GROUP, suspicious_dob_rc1 = '28' or suspicious_dob_rc2 = '28' or suspicious_dob_rc3 = '28' or suspicious_dob_rc4 = '28'or
			suspicious_dob_rc1 = '83' or suspicious_dob_rc2 = '83' or suspicious_dob_rc3 = '83' or suspicious_dob_rc4 = '83'or
			suspicious_dob_rc1 = '03' or suspicious_dob_rc2 = '03' or suspicious_dob_rc3 = '03' or suspicious_dob_rc4 = '03'))/ COUNT(GROUP) * 100,
	real High_Risk_Address := (COUNT(GROUP, high_risk_address_rc1 = 'PO' or high_risk_address_rc2 = 'PO' or high_risk_address_rc3 = 'PO' or high_risk_address_rc4 = 'PO'or
			high_risk_address_rc1 = '12' or high_risk_address_rc2 = '12' or high_risk_address_rc3 = '12' or high_risk_address_rc4 = '12'or
			high_risk_address_rc1 = '11' or high_risk_address_rc2 = '11' or high_risk_address_rc3 = '11' or high_risk_address_rc4 = '11'or
			high_risk_address_rc1 = '14' or high_risk_address_rc2 = '14' or high_risk_address_rc3 = '14' or high_risk_address_rc4 = '14'or
			high_risk_address_rc1 = '50' or high_risk_address_rc2 = '50' or high_risk_address_rc3 = '50' or high_risk_address_rc4 = '50'or
			high_risk_address_rc1 = '40' or high_risk_address_rc2 = '40' or high_risk_address_rc3 = '40' or high_risk_address_rc4 = '40'))/ COUNT(GROUP) * 100,
	real Suspicious_Phone := (COUNT(GROUP, suspicious_phone_rc1 = '10' or suspicious_phone_rc2 = '10' or suspicious_phone_rc3 = '10' or suspicious_phone_rc4 = '10'or
			suspicious_phone_rc1 = '27' or suspicious_phone_rc2 = '27' or suspicious_phone_rc3 = '27' or suspicious_phone_rc4 = '27'or
			suspicious_phone_rc1 = '15' or suspicious_phone_rc2 = '15' or suspicious_phone_rc3 = '15' or suspicious_phone_rc4 = '15'or
			suspicious_phone_rc1 = '07' or suspicious_phone_rc2 = '07' or suspicious_phone_rc3 = '07' or suspicious_phone_rc4 = '07'or
			suspicious_phone_rc1 = '16' or suspicious_phone_rc2 = '16' or suspicious_phone_rc3 = '16' or suspicious_phone_rc4 = '16'or
			suspicious_phone_rc1 = '08' or suspicious_phone_rc2 = '08' or suspicious_phone_rc3 = '08' or suspicious_phone_rc4 = '08'or
			suspicious_phone_rc1 = '09' or suspicious_phone_rc2 = '09' or suspicious_phone_rc3 = '09' or suspicious_phone_rc4 = '09'or
			suspicious_phone_rc1 = '74' or suspicious_phone_rc2 = '74' or suspicious_phone_rc3 = '74' or suspicious_phone_rc4 = '74'or
			suspicious_phone_rc1 = '73' or suspicious_phone_rc2 = '73' or suspicious_phone_rc3 = '73' or suspicious_phone_rc4 = '73'or
			suspicious_phone_rc1 = '49' or suspicious_phone_rc2 = '49' or suspicious_phone_rc3 = '49' or suspicious_phone_rc4 = '49'or
			suspicious_phone_rc1 = '31' or suspicious_phone_rc2 = '31' or suspicious_phone_rc3 = '31' or suspicious_phone_rc4 = '31'))/ COUNT(GROUP) * 100,
	real SSN_Multiple_Last := (COUNT(GROUP, ssn_multiple_last_rc1 = '38' or ssn_multiple_last_rc2 = '38' or ssn_multiple_last_rc3 = '38' or ssn_multiple_last_rc4 = '38'or
			ssn_multiple_last_rc1 = 'MI' or ssn_multiple_last_rc2 = 'MI' or ssn_multiple_last_rc3 = 'MI' or ssn_multiple_last_rc4 = 'MI'or
			ssn_multiple_last_rc1 = '72' or ssn_multiple_last_rc2 = '72' or ssn_multiple_last_rc3 = '72' or ssn_multiple_last_rc4 = '72'or
			ssn_multiple_last_rc1 = '66' or ssn_multiple_last_rc2 = '66' or ssn_multiple_last_rc3 = '66' or ssn_multiple_last_rc4 = '66'))/ COUNT(GROUP) * 100,
	real Missing_Input := (COUNT(GROUP, missing_input_rc1 = '80' or missing_input_rc2 = '80' or missing_input_rc3 = '80' or missing_input_rc4 = '80'or
			missing_input_rc1 = '79' or missing_input_rc2 = '79' or missing_input_rc3 = '79' or missing_input_rc4 = '79'or
			missing_input_rc1 = '81' or missing_input_rc2 = '81' or missing_input_rc3 = '81' or missing_input_rc4 = '81'or
			missing_input_rc1 = '77' or missing_input_rc2 = '77' or missing_input_rc3 = '77' or missing_input_rc4 = '77'or
			missing_input_rc1 = '78' or missing_input_rc2 = '78' or missing_input_rc3 = '78' or missing_input_rc4 = '78'))/ COUNT(GROUP) * 100,
	real Identity_Theft := (COUNT(GROUP, identity_theft_rc1 = '93' or identity_theft_rc2 = '93' or identity_theft_rc3 = '93' or identity_theft_rc4 = '93'))/ COUNT(GROUP) * 100
	}
	, cvi
	);

//OUTPUT(Red_Flags_Overall_Summary,  NAMED('Red_Flags_Overall_Summary'));
OUTPUT(Red_Flags_Overall_Summary,, output_base_location + 'Red_Flags_Overall_Summary_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));


//////////////////////////////////////////////////////////////////////////////REPORT 3 - Risk Indicators



	
Potential_Risk_Indicators :=  
TABLE
(myIIDRecords, 
	{ 
	CVI, 
	UNSIGNED Total := COUNT(GROUP),
REAL Total_Percent := (COUNT(GROUP) / TotalRecords) * 100,

	real RC_02_PRI := (COUNT(GROUP, HRI_1 = '02' or HRI_2 = '02' or HRI_3 = '02' or HRI_4 = '02' or HRI_5 = '02' or HRI_6 = '02' or HRI_7 = '02' or HRI_8 = '02' or HRI_9 = '02' or HRI_10 = '02' or HRI_11 = '02' or HRI_12 = '02' or HRI_13 = '02' or HRI_14 = '02' or HRI_15 = '02' or HRI_16 = '02' or HRI_17 = '02' or HRI_18 = '02' or HRI_19 = '02' or HRI_20 = '02'))/ COUNT(GROUP) * 100,
real RC_03_PRI := (COUNT(GROUP, HRI_1 = '03' or HRI_2 = '03' or HRI_3 = '03' or HRI_4 = '03' or HRI_5 = '03' or HRI_6 = '03' or HRI_7 = '03' or HRI_8 = '03' or HRI_9 = '03' or HRI_10 = '03' or HRI_11 = '03' or HRI_12 = '03' or HRI_13 = '03' or HRI_14 = '03' or HRI_15 = '03' or HRI_16 = '03' or HRI_17 = '03' or HRI_18 = '03' or HRI_19 = '03' or HRI_20 = '03'))/ COUNT(GROUP) * 100,
real RC_04_PRI := (COUNT(GROUP, HRI_1 = '04' or HRI_2 = '04' or HRI_3 = '04' or HRI_4 = '04' or HRI_5 = '04' or HRI_6 = '04' or HRI_7 = '04' or HRI_8 = '04' or HRI_9 = '04' or HRI_10 = '04' or HRI_11 = '04' or HRI_12 = '04' or HRI_13 = '04' or HRI_14 = '04' or HRI_15 = '04' or HRI_16 = '04' or HRI_17 = '04' or HRI_18 = '04' or HRI_19 = '04' or HRI_20 = '04'))/ COUNT(GROUP) * 100,
real RC_06_PRI := (COUNT(GROUP, HRI_1 = '06' or HRI_2 = '06' or HRI_3 = '06' or HRI_4 = '06' or HRI_5 = '06' or HRI_6 = '06' or HRI_7 = '06' or HRI_8 = '06' or HRI_9 = '06' or HRI_10 = '06' or HRI_11 = '06' or HRI_12 = '06' or HRI_13 = '06' or HRI_14 = '06' or HRI_15 = '06' or HRI_16 = '06' or HRI_17 = '06' or HRI_18 = '06' or HRI_19 = '06' or HRI_20 = '06'))/ COUNT(GROUP) * 100,
real RC_07_PRI := (COUNT(GROUP, HRI_1 = '07' or HRI_2 = '07' or HRI_3 = '07' or HRI_4 = '07' or HRI_5 = '07' or HRI_6 = '07' or HRI_7 = '07' or HRI_8 = '07' or HRI_9 = '07' or HRI_10 = '07' or HRI_11 = '07' or HRI_12 = '07' or HRI_13 = '07' or HRI_14 = '07' or HRI_15 = '07' or HRI_16 = '07' or HRI_17 = '07' or HRI_18 = '07' or HRI_19 = '07' or HRI_20 = '07'))/ COUNT(GROUP) * 100,
real RC_08_PRI := (COUNT(GROUP, HRI_1 = '08' or HRI_2 = '08' or HRI_3 = '08' or HRI_4 = '08' or HRI_5 = '08' or HRI_6 = '08' or HRI_7 = '08' or HRI_8 = '08' or HRI_9 = '08' or HRI_10 = '08' or HRI_11 = '08' or HRI_12 = '08' or HRI_13 = '08' or HRI_14 = '08' or HRI_15 = '08' or HRI_16 = '08' or HRI_17 = '08' or HRI_18 = '08' or HRI_19 = '08' or HRI_20 = '08'))/ COUNT(GROUP) * 100,
real RC_09_PRI := (COUNT(GROUP, HRI_1 = '09' or HRI_2 = '09' or HRI_3 = '09' or HRI_4 = '09' or HRI_5 = '09' or HRI_6 = '09' or HRI_7 = '09' or HRI_8 = '09' or HRI_9 = '09' or HRI_10 = '09' or HRI_11 = '09' or HRI_12 = '09' or HRI_13 = '09' or HRI_14 = '09' or HRI_15 = '09' or HRI_16 = '09' or HRI_17 = '09' or HRI_18 = '09' or HRI_19 = '09' or HRI_20 = '09'))/ COUNT(GROUP) * 100,
real RC_10_PRI := (COUNT(GROUP, HRI_1 = '10' or HRI_2 = '10' or HRI_3 = '10' or HRI_4 = '10' or HRI_5 = '10' or HRI_6 = '10' or HRI_7 = '10' or HRI_8 = '10' or HRI_9 = '10' or HRI_10 = '10' or HRI_11 = '10' or HRI_12 = '10' or HRI_13 = '10' or HRI_14 = '10' or HRI_15 = '10' or HRI_16 = '10' or HRI_17 = '10' or HRI_18 = '10' or HRI_19 = '10' or HRI_20 = '10'))/ COUNT(GROUP) * 100,
real RC_11_PRI := (COUNT(GROUP, HRI_1 = '11' or HRI_2 = '11' or HRI_3 = '11' or HRI_4 = '11' or HRI_5 = '11' or HRI_6 = '11' or HRI_7 = '11' or HRI_8 = '11' or HRI_9 = '11' or HRI_10 = '11' or HRI_11 = '11' or HRI_12 = '11' or HRI_13 = '11' or HRI_14 = '11' or HRI_15 = '11' or HRI_16 = '11' or HRI_17 = '11' or HRI_18 = '11' or HRI_19 = '11' or HRI_20 = '11'))/ COUNT(GROUP) * 100,
real RC_12_PRI := (COUNT(GROUP, HRI_1 = '12' or HRI_2 = '12' or HRI_3 = '12' or HRI_4 = '12' or HRI_5 = '12' or HRI_6 = '12' or HRI_7 = '12' or HRI_8 = '12' or HRI_9 = '12' or HRI_10 = '12' or HRI_11 = '12' or HRI_12 = '12' or HRI_13 = '12' or HRI_14 = '12' or HRI_15 = '12' or HRI_16 = '12' or HRI_17 = '12' or HRI_18 = '12' or HRI_19 = '12' or HRI_20 = '12'))/ COUNT(GROUP) * 100,
real RC_14_PRI := (COUNT(GROUP, HRI_1 = '14' or HRI_2 = '14' or HRI_3 = '14' or HRI_4 = '14' or HRI_5 = '14' or HRI_6 = '14' or HRI_7 = '14' or HRI_8 = '14' or HRI_9 = '14' or HRI_10 = '14' or HRI_11 = '14' or HRI_12 = '14' or HRI_13 = '14' or HRI_14 = '14' or HRI_15 = '14' or HRI_16 = '14' or HRI_17 = '14' or HRI_18 = '14' or HRI_19 = '14' or HRI_20 = '14'))/ COUNT(GROUP) * 100,
real RC_15_PRI := (COUNT(GROUP, HRI_1 = '15' or HRI_2 = '15' or HRI_3 = '15' or HRI_4 = '15' or HRI_5 = '15' or HRI_6 = '15' or HRI_7 = '15' or HRI_8 = '15' or HRI_9 = '15' or HRI_10 = '15' or HRI_11 = '15' or HRI_12 = '15' or HRI_13 = '15' or HRI_14 = '15' or HRI_15 = '15' or HRI_16 = '15' or HRI_17 = '15' or HRI_18 = '15' or HRI_19 = '15' or HRI_20 = '15'))/ COUNT(GROUP) * 100,
real RC_16_PRI := (COUNT(GROUP, HRI_1 = '16' or HRI_2 = '16' or HRI_3 = '16' or HRI_4 = '16' or HRI_5 = '16' or HRI_6 = '16' or HRI_7 = '16' or HRI_8 = '16' or HRI_9 = '16' or HRI_10 = '16' or HRI_11 = '16' or HRI_12 = '16' or HRI_13 = '16' or HRI_14 = '16' or HRI_15 = '16' or HRI_16 = '16' or HRI_17 = '16' or HRI_18 = '16' or HRI_19 = '16' or HRI_20 = '16'))/ COUNT(GROUP) * 100,
real RC_19_PRI := (COUNT(GROUP, HRI_1 = '19' or HRI_2 = '19' or HRI_3 = '19' or HRI_4 = '19' or HRI_5 = '19' or HRI_6 = '19' or HRI_7 = '19' or HRI_8 = '19' or HRI_9 = '19' or HRI_10 = '19' or HRI_11 = '19' or HRI_12 = '19' or HRI_13 = '19' or HRI_14 = '19' or HRI_15 = '19' or HRI_16 = '19' or HRI_17 = '19' or HRI_18 = '19' or HRI_19 = '19' or HRI_20 = '19'))/ COUNT(GROUP) * 100,
real RC_25_PRI := (COUNT(GROUP, HRI_1 = '25' or HRI_2 = '25' or HRI_3 = '25' or HRI_4 = '25' or HRI_5 = '25' or HRI_6 = '25' or HRI_7 = '25' or HRI_8 = '25' or HRI_9 = '25' or HRI_10 = '25' or HRI_11 = '25' or HRI_12 = '25' or HRI_13 = '25' or HRI_14 = '25' or HRI_15 = '25' or HRI_16 = '25' or HRI_17 = '25' or HRI_18 = '25' or HRI_19 = '25' or HRI_20 = '25'))/ COUNT(GROUP) * 100,
real RC_26_PRI := (COUNT(GROUP, HRI_1 = '26' or HRI_2 = '26' or HRI_3 = '26' or HRI_4 = '26' or HRI_5 = '26' or HRI_6 = '26' or HRI_7 = '26' or HRI_8 = '26' or HRI_9 = '26' or HRI_10 = '26' or HRI_11 = '26' or HRI_12 = '26' or HRI_13 = '26' or HRI_14 = '26' or HRI_15 = '26' or HRI_16 = '26' or HRI_17 = '26' or HRI_18 = '26' or HRI_19 = '26' or HRI_20 = '26'))/ COUNT(GROUP) * 100,
real RC_27_PRI := (COUNT(GROUP, HRI_1 = '27' or HRI_2 = '27' or HRI_3 = '27' or HRI_4 = '27' or HRI_5 = '27' or HRI_6 = '27' or HRI_7 = '27' or HRI_8 = '27' or HRI_9 = '27' or HRI_10 = '27' or HRI_11 = '27' or HRI_12 = '27' or HRI_13 = '27' or HRI_14 = '27' or HRI_15 = '27' or HRI_16 = '27' or HRI_17 = '27' or HRI_18 = '27' or HRI_19 = '27' or HRI_20 = '27'))/ COUNT(GROUP) * 100,
real RC_28_PRI := (COUNT(GROUP, HRI_1 = '28' or HRI_2 = '28' or HRI_3 = '28' or HRI_4 = '28' or HRI_5 = '28' or HRI_6 = '28' or HRI_7 = '28' or HRI_8 = '28' or HRI_9 = '28' or HRI_10 = '28' or HRI_11 = '28' or HRI_12 = '28' or HRI_13 = '28' or HRI_14 = '28' or HRI_15 = '28' or HRI_16 = '28' or HRI_17 = '28' or HRI_18 = '28' or HRI_19 = '28' or HRI_20 = '28'))/ COUNT(GROUP) * 100,
real RC_29_PRI := (COUNT(GROUP, HRI_1 = '29' or HRI_2 = '29' or HRI_3 = '29' or HRI_4 = '29' or HRI_5 = '29' or HRI_6 = '29' or HRI_7 = '29' or HRI_8 = '29' or HRI_9 = '29' or HRI_10 = '29' or HRI_11 = '29' or HRI_12 = '29' or HRI_13 = '29' or HRI_14 = '29' or HRI_15 = '29' or HRI_16 = '29' or HRI_17 = '29' or HRI_18 = '29' or HRI_19 = '29' or HRI_20 = '29'))/ COUNT(GROUP) * 100,
real RC_30_PRI := (COUNT(GROUP, HRI_1 = '30' or HRI_2 = '30' or HRI_3 = '30' or HRI_4 = '30' or HRI_5 = '30' or HRI_6 = '30' or HRI_7 = '30' or HRI_8 = '30' or HRI_9 = '30' or HRI_10 = '30' or HRI_11 = '30' or HRI_12 = '30' or HRI_13 = '30' or HRI_14 = '30' or HRI_15 = '30' or HRI_16 = '30' or HRI_17 = '30' or HRI_18 = '30' or HRI_19 = '30' or HRI_20 = '30'))/ COUNT(GROUP) * 100,
real RC_31_PRI := (COUNT(GROUP, HRI_1 = '31' or HRI_2 = '31' or HRI_3 = '31' or HRI_4 = '31' or HRI_5 = '31' or HRI_6 = '31' or HRI_7 = '31' or HRI_8 = '31' or HRI_9 = '31' or HRI_10 = '31' or HRI_11 = '31' or HRI_12 = '31' or HRI_13 = '31' or HRI_14 = '31' or HRI_15 = '31' or HRI_16 = '31' or HRI_17 = '31' or HRI_18 = '31' or HRI_19 = '31' or HRI_20 = '31'))/ COUNT(GROUP) * 100,
real RC_32_PRI := (COUNT(GROUP, HRI_1 = '32' or HRI_2 = '32' or HRI_3 = '32' or HRI_4 = '32' or HRI_5 = '32' or HRI_6 = '32' or HRI_7 = '32' or HRI_8 = '32' or HRI_9 = '32' or HRI_10 = '32' or HRI_11 = '32' or HRI_12 = '32' or HRI_13 = '32' or HRI_14 = '32' or HRI_15 = '32' or HRI_16 = '32' or HRI_17 = '32' or HRI_18 = '32' or HRI_19 = '32' or HRI_20 = '32'))/ COUNT(GROUP) * 100,
real RC_37_PRI := (COUNT(GROUP, HRI_1 = '37' or HRI_2 = '37' or HRI_3 = '37' or HRI_4 = '37' or HRI_5 = '37' or HRI_6 = '37' or HRI_7 = '37' or HRI_8 = '37' or HRI_9 = '37' or HRI_10 = '37' or HRI_11 = '37' or HRI_12 = '37' or HRI_13 = '37' or HRI_14 = '37' or HRI_15 = '37' or HRI_16 = '37' or HRI_17 = '37' or HRI_18 = '37' or HRI_19 = '37' or HRI_20 = '37'))/ COUNT(GROUP) * 100,
real RC_38_PRI := (COUNT(GROUP, HRI_1 = '38' or HRI_2 = '38' or HRI_3 = '38' or HRI_4 = '38' or HRI_5 = '38' or HRI_6 = '38' or HRI_7 = '38' or HRI_8 = '38' or HRI_9 = '38' or HRI_10 = '38' or HRI_11 = '38' or HRI_12 = '38' or HRI_13 = '38' or HRI_14 = '38' or HRI_15 = '38' or HRI_16 = '38' or HRI_17 = '38' or HRI_18 = '38' or HRI_19 = '38' or HRI_20 = '38'))/ COUNT(GROUP) * 100,
real RC_39_PRI := (COUNT(GROUP, HRI_1 = '39' or HRI_2 = '39' or HRI_3 = '39' or HRI_4 = '39' or HRI_5 = '39' or HRI_6 = '39' or HRI_7 = '39' or HRI_8 = '39' or HRI_9 = '39' or HRI_10 = '39' or HRI_11 = '39' or HRI_12 = '39' or HRI_13 = '39' or HRI_14 = '39' or HRI_15 = '39' or HRI_16 = '39' or HRI_17 = '39' or HRI_18 = '39' or HRI_19 = '39' or HRI_20 = '39'))/ COUNT(GROUP) * 100,
real RC_40_PRI := (COUNT(GROUP, HRI_1 = '40' or HRI_2 = '40' or HRI_3 = '40' or HRI_4 = '40' or HRI_5 = '40' or HRI_6 = '40' or HRI_7 = '40' or HRI_8 = '40' or HRI_9 = '40' or HRI_10 = '40' or HRI_11 = '40' or HRI_12 = '40' or HRI_13 = '40' or HRI_14 = '40' or HRI_15 = '40' or HRI_16 = '40' or HRI_17 = '40' or HRI_18 = '40' or HRI_19 = '40' or HRI_20 = '40'))/ COUNT(GROUP) * 100,
real RC_41_PRI := (COUNT(GROUP, HRI_1 = '41' or HRI_2 = '41' or HRI_3 = '41' or HRI_4 = '41' or HRI_5 = '41' or HRI_6 = '41' or HRI_7 = '41' or HRI_8 = '41' or HRI_9 = '41' or HRI_10 = '41' or HRI_11 = '41' or HRI_12 = '41' or HRI_13 = '41' or HRI_14 = '41' or HRI_15 = '41' or HRI_16 = '41' or HRI_17 = '41' or HRI_18 = '41' or HRI_19 = '41' or HRI_20 = '41'))/ COUNT(GROUP) * 100,
real RC_44_PRI := (COUNT(GROUP, HRI_1 = '44' or HRI_2 = '44' or HRI_3 = '44' or HRI_4 = '44' or HRI_5 = '44' or HRI_6 = '44' or HRI_7 = '44' or HRI_8 = '44' or HRI_9 = '44' or HRI_10 = '44' or HRI_11 = '44' or HRI_12 = '44' or HRI_13 = '44' or HRI_14 = '44' or HRI_15 = '44' or HRI_16 = '44' or HRI_17 = '44' or HRI_18 = '44' or HRI_19 = '44' or HRI_20 = '44'))/ COUNT(GROUP) * 100,
real RC_46_PRI := (COUNT(GROUP, HRI_1 = '46' or HRI_2 = '46' or HRI_3 = '46' or HRI_4 = '46' or HRI_5 = '46' or HRI_6 = '46' or HRI_7 = '46' or HRI_8 = '46' or HRI_9 = '46' or HRI_10 = '46' or HRI_11 = '46' or HRI_12 = '46' or HRI_13 = '46' or HRI_14 = '46' or HRI_15 = '46' or HRI_16 = '46' or HRI_17 = '46' or HRI_18 = '46' or HRI_19 = '46' or HRI_20 = '46'))/ COUNT(GROUP) * 100,
real RC_48_PRI := (COUNT(GROUP, HRI_1 = '48' or HRI_2 = '48' or HRI_3 = '48' or HRI_4 = '48' or HRI_5 = '48' or HRI_6 = '48' or HRI_7 = '48' or HRI_8 = '48' or HRI_9 = '48' or HRI_10 = '48' or HRI_11 = '48' or HRI_12 = '48' or HRI_13 = '48' or HRI_14 = '48' or HRI_15 = '48' or HRI_16 = '48' or HRI_17 = '48' or HRI_18 = '48' or HRI_19 = '48' or HRI_20 = '48'))/ COUNT(GROUP) * 100,
real RC_49_PRI := (COUNT(GROUP, HRI_1 = '49' or HRI_2 = '49' or HRI_3 = '49' or HRI_4 = '49' or HRI_5 = '49' or HRI_6 = '49' or HRI_7 = '49' or HRI_8 = '49' or HRI_9 = '49' or HRI_10 = '49' or HRI_11 = '49' or HRI_12 = '49' or HRI_13 = '49' or HRI_14 = '49' or HRI_15 = '49' or HRI_16 = '49' or HRI_17 = '49' or HRI_18 = '49' or HRI_19 = '49' or HRI_20 = '49'))/ COUNT(GROUP) * 100,
real RC_50_PRI := (COUNT(GROUP, HRI_1 = '50' or HRI_2 = '50' or HRI_3 = '50' or HRI_4 = '50' or HRI_5 = '50' or HRI_6 = '50' or HRI_7 = '50' or HRI_8 = '50' or HRI_9 = '50' or HRI_10 = '50' or HRI_11 = '50' or HRI_12 = '50' or HRI_13 = '50' or HRI_14 = '50' or HRI_15 = '50' or HRI_16 = '50' or HRI_17 = '50' or HRI_18 = '50' or HRI_19 = '50' or HRI_20 = '50'))/ COUNT(GROUP) * 100,
real RC_51_PRI := (COUNT(GROUP, HRI_1 = '51' or HRI_2 = '51' or HRI_3 = '51' or HRI_4 = '51' or HRI_5 = '51' or HRI_6 = '51' or HRI_7 = '51' or HRI_8 = '51' or HRI_9 = '51' or HRI_10 = '51' or HRI_11 = '51' or HRI_12 = '51' or HRI_13 = '51' or HRI_14 = '51' or HRI_15 = '51' or HRI_16 = '51' or HRI_17 = '51' or HRI_18 = '51' or HRI_19 = '51' or HRI_20 = '51'))/ COUNT(GROUP) * 100,
real RC_52_PRI := (COUNT(GROUP, HRI_1 = '52' or HRI_2 = '52' or HRI_3 = '52' or HRI_4 = '52' or HRI_5 = '52' or HRI_6 = '52' or HRI_7 = '52' or HRI_8 = '52' or HRI_9 = '52' or HRI_10 = '52' or HRI_11 = '52' or HRI_12 = '52' or HRI_13 = '52' or HRI_14 = '52' or HRI_15 = '52' or HRI_16 = '52' or HRI_17 = '52' or HRI_18 = '52' or HRI_19 = '52' or HRI_20 = '52'))/ COUNT(GROUP) * 100,
real RC_53_PRI := (COUNT(GROUP, HRI_1 = '53' or HRI_2 = '53' or HRI_3 = '53' or HRI_4 = '53' or HRI_5 = '53' or HRI_6 = '53' or HRI_7 = '53' or HRI_8 = '53' or HRI_9 = '53' or HRI_10 = '53' or HRI_11 = '53' or HRI_12 = '53' or HRI_13 = '53' or HRI_14 = '53' or HRI_15 = '53' or HRI_16 = '53' or HRI_17 = '53' or HRI_18 = '53' or HRI_19 = '53' or HRI_20 = '53'))/ COUNT(GROUP) * 100,
real RC_55_PRI := (COUNT(GROUP, HRI_1 = '55' or HRI_2 = '55' or HRI_3 = '55' or HRI_4 = '55' or HRI_5 = '55' or HRI_6 = '55' or HRI_7 = '55' or HRI_8 = '55' or HRI_9 = '55' or HRI_10 = '55' or HRI_11 = '55' or HRI_12 = '55' or HRI_13 = '55' or HRI_14 = '55' or HRI_15 = '55' or HRI_16 = '55' or HRI_17 = '55' or HRI_18 = '55' or HRI_19 = '55' or HRI_20 = '55'))/ COUNT(GROUP) * 100,
real RC_56_PRI := (COUNT(GROUP, HRI_1 = '56' or HRI_2 = '56' or HRI_3 = '56' or HRI_4 = '56' or HRI_5 = '56' or HRI_6 = '56' or HRI_7 = '56' or HRI_8 = '56' or HRI_9 = '56' or HRI_10 = '56' or HRI_11 = '56' or HRI_12 = '56' or HRI_13 = '56' or HRI_14 = '56' or HRI_15 = '56' or HRI_16 = '56' or HRI_17 = '56' or HRI_18 = '56' or HRI_19 = '56' or HRI_20 = '56'))/ COUNT(GROUP) * 100,
real RC_57_PRI := (COUNT(GROUP, HRI_1 = '57' or HRI_2 = '57' or HRI_3 = '57' or HRI_4 = '57' or HRI_5 = '57' or HRI_6 = '57' or HRI_7 = '57' or HRI_8 = '57' or HRI_9 = '57' or HRI_10 = '57' or HRI_11 = '57' or HRI_12 = '57' or HRI_13 = '57' or HRI_14 = '57' or HRI_15 = '57' or HRI_16 = '57' or HRI_17 = '57' or HRI_18 = '57' or HRI_19 = '57' or HRI_20 = '57'))/ COUNT(GROUP) * 100,
real RC_64_PRI := (COUNT(GROUP, HRI_1 = '64' or HRI_2 = '64' or HRI_3 = '64' or HRI_4 = '64' or HRI_5 = '64' or HRI_6 = '64' or HRI_7 = '64' or HRI_8 = '64' or HRI_9 = '64' or HRI_10 = '64' or HRI_11 = '64' or HRI_12 = '64' or HRI_13 = '64' or HRI_14 = '64' or HRI_15 = '64' or HRI_16 = '64' or HRI_17 = '64' or HRI_18 = '64' or HRI_19 = '64' or HRI_20 = '64'))/ COUNT(GROUP) * 100,
real RC_66_PRI := (COUNT(GROUP, HRI_1 = '66' or HRI_2 = '66' or HRI_3 = '66' or HRI_4 = '66' or HRI_5 = '66' or HRI_6 = '66' or HRI_7 = '66' or HRI_8 = '66' or HRI_9 = '66' or HRI_10 = '66' or HRI_11 = '66' or HRI_12 = '66' or HRI_13 = '66' or HRI_14 = '66' or HRI_15 = '66' or HRI_16 = '66' or HRI_17 = '66' or HRI_18 = '66' or HRI_19 = '66' or HRI_20 = '66'))/ COUNT(GROUP) * 100,
real RC_71_PRI := (COUNT(GROUP, HRI_1 = '71' or HRI_2 = '71' or HRI_3 = '71' or HRI_4 = '71' or HRI_5 = '71' or HRI_6 = '71' or HRI_7 = '71' or HRI_8 = '71' or HRI_9 = '71' or HRI_10 = '71' or HRI_11 = '71' or HRI_12 = '71' or HRI_13 = '71' or HRI_14 = '71' or HRI_15 = '71' or HRI_16 = '71' or HRI_17 = '71' or HRI_18 = '71' or HRI_19 = '71' or HRI_20 = '71'))/ COUNT(GROUP) * 100,
real RC_72_PRI := (COUNT(GROUP, HRI_1 = '72' or HRI_2 = '72' or HRI_3 = '72' or HRI_4 = '72' or HRI_5 = '72' or HRI_6 = '72' or HRI_7 = '72' or HRI_8 = '72' or HRI_9 = '72' or HRI_10 = '72' or HRI_11 = '72' or HRI_12 = '72' or HRI_13 = '72' or HRI_14 = '72' or HRI_15 = '72' or HRI_16 = '72' or HRI_17 = '72' or HRI_18 = '72' or HRI_19 = '72' or HRI_20 = '72'))/ COUNT(GROUP) * 100,
real RC_74_PRI := (COUNT(GROUP, HRI_1 = '74' or HRI_2 = '74' or HRI_3 = '74' or HRI_4 = '74' or HRI_5 = '74' or HRI_6 = '74' or HRI_7 = '74' or HRI_8 = '74' or HRI_9 = '74' or HRI_10 = '74' or HRI_11 = '74' or HRI_12 = '74' or HRI_13 = '74' or HRI_14 = '74' or HRI_15 = '74' or HRI_16 = '74' or HRI_17 = '74' or HRI_18 = '74' or HRI_19 = '74' or HRI_20 = '74'))/ COUNT(GROUP) * 100,
real RC_75_PRI := (COUNT(GROUP, HRI_1 = '75' or HRI_2 = '75' or HRI_3 = '75' or HRI_4 = '75' or HRI_5 = '75' or HRI_6 = '75' or HRI_7 = '75' or HRI_8 = '75' or HRI_9 = '75' or HRI_10 = '75' or HRI_11 = '75' or HRI_12 = '75' or HRI_13 = '75' or HRI_14 = '75' or HRI_15 = '75' or HRI_16 = '75' or HRI_17 = '75' or HRI_18 = '75' or HRI_19 = '75' or HRI_20 = '75'))/ COUNT(GROUP) * 100,
real RC_76_PRI := (COUNT(GROUP, HRI_1 = '76' or HRI_2 = '76' or HRI_3 = '76' or HRI_4 = '76' or HRI_5 = '76' or HRI_6 = '76' or HRI_7 = '76' or HRI_8 = '76' or HRI_9 = '76' or HRI_10 = '76' or HRI_11 = '76' or HRI_12 = '76' or HRI_13 = '76' or HRI_14 = '76' or HRI_15 = '76' or HRI_16 = '76' or HRI_17 = '76' or HRI_18 = '76' or HRI_19 = '76' or HRI_20 = '76'))/ COUNT(GROUP) * 100,
real RC_77_PRI := (COUNT(GROUP, HRI_1 = '77' or HRI_2 = '77' or HRI_3 = '77' or HRI_4 = '77' or HRI_5 = '77' or HRI_6 = '77' or HRI_7 = '77' or HRI_8 = '77' or HRI_9 = '77' or HRI_10 = '77' or HRI_11 = '77' or HRI_12 = '77' or HRI_13 = '77' or HRI_14 = '77' or HRI_15 = '77' or HRI_16 = '77' or HRI_17 = '77' or HRI_18 = '77' or HRI_19 = '77' or HRI_20 = '77'))/ COUNT(GROUP) * 100,
real RC_78_PRI := (COUNT(GROUP, HRI_1 = '78' or HRI_2 = '78' or HRI_3 = '78' or HRI_4 = '78' or HRI_5 = '78' or HRI_6 = '78' or HRI_7 = '78' or HRI_8 = '78' or HRI_9 = '78' or HRI_10 = '78' or HRI_11 = '78' or HRI_12 = '78' or HRI_13 = '78' or HRI_14 = '78' or HRI_15 = '78' or HRI_16 = '78' or HRI_17 = '78' or HRI_18 = '78' or HRI_19 = '78' or HRI_20 = '78'))/ COUNT(GROUP) * 100,
real RC_79_PRI := (COUNT(GROUP, HRI_1 = '79' or HRI_2 = '79' or HRI_3 = '79' or HRI_4 = '79' or HRI_5 = '79' or HRI_6 = '79' or HRI_7 = '79' or HRI_8 = '79' or HRI_9 = '79' or HRI_10 = '79' or HRI_11 = '79' or HRI_12 = '79' or HRI_13 = '79' or HRI_14 = '79' or HRI_15 = '79' or HRI_16 = '79' or HRI_17 = '79' or HRI_18 = '79' or HRI_19 = '79' or HRI_20 = '79'))/ COUNT(GROUP) * 100,
real RC_80_PRI := (COUNT(GROUP, HRI_1 = '80' or HRI_2 = '80' or HRI_3 = '80' or HRI_4 = '80' or HRI_5 = '80' or HRI_6 = '80' or HRI_7 = '80' or HRI_8 = '80' or HRI_9 = '80' or HRI_10 = '80' or HRI_11 = '80' or HRI_12 = '80' or HRI_13 = '80' or HRI_14 = '80' or HRI_15 = '80' or HRI_16 = '80' or HRI_17 = '80' or HRI_18 = '80' or HRI_19 = '80' or HRI_20 = '80'))/ COUNT(GROUP) * 100,
real RC_81_PRI := (COUNT(GROUP, HRI_1 = '81' or HRI_2 = '81' or HRI_3 = '81' or HRI_4 = '81' or HRI_5 = '81' or HRI_6 = '81' or HRI_7 = '81' or HRI_8 = '81' or HRI_9 = '81' or HRI_10 = '81' or HRI_11 = '81' or HRI_12 = '81' or HRI_13 = '81' or HRI_14 = '81' or HRI_15 = '81' or HRI_16 = '81' or HRI_17 = '81' or HRI_18 = '81' or HRI_19 = '81' or HRI_20 = '81'))/ COUNT(GROUP) * 100,
real RC_82_PRI := (COUNT(GROUP, HRI_1 = '82' or HRI_2 = '82' or HRI_3 = '82' or HRI_4 = '82' or HRI_5 = '82' or HRI_6 = '82' or HRI_7 = '82' or HRI_8 = '82' or HRI_9 = '82' or HRI_10 = '82' or HRI_11 = '82' or HRI_12 = '82' or HRI_13 = '82' or HRI_14 = '82' or HRI_15 = '82' or HRI_16 = '82' or HRI_17 = '82' or HRI_18 = '82' or HRI_19 = '82' or HRI_20 = '82'))/ COUNT(GROUP) * 100,
real RC_83_PRI := (COUNT(GROUP, HRI_1 = '83' or HRI_2 = '83' or HRI_3 = '83' or HRI_4 = '83' or HRI_5 = '83' or HRI_6 = '83' or HRI_7 = '83' or HRI_8 = '83' or HRI_9 = '83' or HRI_10 = '83' or HRI_11 = '83' or HRI_12 = '83' or HRI_13 = '83' or HRI_14 = '83' or HRI_15 = '83' or HRI_16 = '83' or HRI_17 = '83' or HRI_18 = '83' or HRI_19 = '83' or HRI_20 = '83'))/ COUNT(GROUP) * 100,
real RC_85_PRI := (COUNT(GROUP, HRI_1 = '85' or HRI_2 = '85' or HRI_3 = '85' or HRI_4 = '85' or HRI_5 = '85' or HRI_6 = '85' or HRI_7 = '85' or HRI_8 = '85' or HRI_9 = '85' or HRI_10 = '85' or HRI_11 = '85' or HRI_12 = '85' or HRI_13 = '85' or HRI_14 = '85' or HRI_15 = '85' or HRI_16 = '85' or HRI_17 = '85' or HRI_18 = '85' or HRI_19 = '85' or HRI_20 = '85'))/ COUNT(GROUP) * 100,
real RC_89_PRI := (COUNT(GROUP, HRI_1 = '89' or HRI_2 = '89' or HRI_3 = '89' or HRI_4 = '89' or HRI_5 = '89' or HRI_6 = '89' or HRI_7 = '89' or HRI_8 = '89' or HRI_9 = '89' or HRI_10 = '89' or HRI_11 = '89' or HRI_12 = '89' or HRI_13 = '89' or HRI_14 = '89' or HRI_15 = '89' or HRI_16 = '89' or HRI_17 = '89' or HRI_18 = '89' or HRI_19 = '89' or HRI_20 = '89'))/ COUNT(GROUP) * 100,
real RC_90_PRI := (COUNT(GROUP, HRI_1 = '90' or HRI_2 = '90' or HRI_3 = '90' or HRI_4 = '90' or HRI_5 = '90' or HRI_6 = '90' or HRI_7 = '90' or HRI_8 = '90' or HRI_9 = '90' or HRI_10 = '90' or HRI_11 = '90' or HRI_12 = '90' or HRI_13 = '90' or HRI_14 = '90' or HRI_15 = '90' or HRI_16 = '90' or HRI_17 = '90' or HRI_18 = '90' or HRI_19 = '90' or HRI_20 = '90'))/ COUNT(GROUP) * 100,
real RC_CA_PRI := (COUNT(GROUP, HRI_1 = 'CA' or HRI_2 = 'CA' or HRI_3 = 'CA' or HRI_4 = 'CA' or HRI_5 = 'CA' or HRI_6 = 'CA' or HRI_7 = 'CA' or HRI_8 = 'CA' or HRI_9 = 'CA' or HRI_10 = 'CA' or HRI_11 = 'CA' or HRI_12 = 'CA' or HRI_13 = 'CA' or HRI_14 = 'CA' or HRI_15 = 'CA' or HRI_16 = 'CA' or HRI_17 = 'CA' or HRI_18 = 'CA' or HRI_19 = 'CA' or HRI_20 = 'CA'))/ COUNT(GROUP) * 100,
real RC_CL_PRI := (COUNT(GROUP, HRI_1 = 'CL' or HRI_2 = 'CL' or HRI_3 = 'CL' or HRI_4 = 'CL' or HRI_5 = 'CL' or HRI_6 = 'CL' or HRI_7 = 'CL' or HRI_8 = 'CL' or HRI_9 = 'CL' or HRI_10 = 'CL' or HRI_11 = 'CL' or HRI_12 = 'CL' or HRI_13 = 'CL' or HRI_14 = 'CL' or HRI_15 = 'CL' or HRI_16 = 'CL' or HRI_17 = 'CL' or HRI_18 = 'CL' or HRI_19 = 'CL' or HRI_20 = 'CL'))/ COUNT(GROUP) * 100,
real RC_CO_PRI := (COUNT(GROUP, HRI_1 = 'CO' or HRI_2 = 'CO' or HRI_3 = 'CO' or HRI_4 = 'CO' or HRI_5 = 'CO' or HRI_6 = 'CO' or HRI_7 = 'CO' or HRI_8 = 'CO' or HRI_9 = 'CO' or HRI_10 = 'CO' or HRI_11 = 'CO' or HRI_12 = 'CO' or HRI_13 = 'CO' or HRI_14 = 'CO' or HRI_15 = 'CO' or HRI_16 = 'CO' or HRI_17 = 'CO' or HRI_18 = 'CO' or HRI_19 = 'CO' or HRI_20 = 'CO'))/ COUNT(GROUP) * 100,
real RC_CZ_PRI := (COUNT(GROUP, HRI_1 = 'CZ' or HRI_2 = 'CZ' or HRI_3 = 'CZ' or HRI_4 = 'CZ' or HRI_5 = 'CZ' or HRI_6 = 'CZ' or HRI_7 = 'CZ' or HRI_8 = 'CZ' or HRI_9 = 'CZ' or HRI_10 = 'CZ' or HRI_11 = 'CZ' or HRI_12 = 'CZ' or HRI_13 = 'CZ' or HRI_14 = 'CZ' or HRI_15 = 'CZ' or HRI_16 = 'CZ' or HRI_17 = 'CZ' or HRI_18 = 'CZ' or HRI_19 = 'CZ' or HRI_20 = 'CZ'))/ COUNT(GROUP) * 100,
real RC_DD_PRI := (COUNT(GROUP, HRI_1 = 'DD' or HRI_2 = 'DD' or HRI_3 = 'DD' or HRI_4 = 'DD' or HRI_5 = 'DD' or HRI_6 = 'DD' or HRI_7 = 'DD' or HRI_8 = 'DD' or HRI_9 = 'DD' or HRI_10 = 'DD' or HRI_11 = 'DD' or HRI_12 = 'DD' or HRI_13 = 'DD' or HRI_14 = 'DD' or HRI_15 = 'DD' or HRI_16 = 'DD' or HRI_17 = 'DD' or HRI_18 = 'DD' or HRI_19 = 'DD' or HRI_20 = 'DD'))/ COUNT(GROUP) * 100,
real RC_DF_PRI := (COUNT(GROUP, HRI_1 = 'DF' or HRI_2 = 'DF' or HRI_3 = 'DF' or HRI_4 = 'DF' or HRI_5 = 'DF' or HRI_6 = 'DF' or HRI_7 = 'DF' or HRI_8 = 'DF' or HRI_9 = 'DF' or HRI_10 = 'DF' or HRI_11 = 'DF' or HRI_12 = 'DF' or HRI_13 = 'DF' or HRI_14 = 'DF' or HRI_15 = 'DF' or HRI_16 = 'DF' or HRI_17 = 'DF' or HRI_18 = 'DF' or HRI_19 = 'DF' or HRI_20 = 'DF'))/ COUNT(GROUP) * 100,
real RC_DI_PRI := (COUNT(GROUP, HRI_1 = 'DI' or HRI_2 = 'DI' or HRI_3 = 'DI' or HRI_4 = 'DI' or HRI_5 = 'DI' or HRI_6 = 'DI' or HRI_7 = 'DI' or HRI_8 = 'DI' or HRI_9 = 'DI' or HRI_10 = 'DI' or HRI_11 = 'DI' or HRI_12 = 'DI' or HRI_13 = 'DI' or HRI_14 = 'DI' or HRI_15 = 'DI' or HRI_16 = 'DI' or HRI_17 = 'DI' or HRI_18 = 'DI' or HRI_19 = 'DI' or HRI_20 = 'DI'))/ COUNT(GROUP) * 100,
real RC_DM_PRI := (COUNT(GROUP, HRI_1 = 'DM' or HRI_2 = 'DM' or HRI_3 = 'DM' or HRI_4 = 'DM' or HRI_5 = 'DM' or HRI_6 = 'DM' or HRI_7 = 'DM' or HRI_8 = 'DM' or HRI_9 = 'DM' or HRI_10 = 'DM' or HRI_11 = 'DM' or HRI_12 = 'DM' or HRI_13 = 'DM' or HRI_14 = 'DM' or HRI_15 = 'DM' or HRI_16 = 'DM' or HRI_17 = 'DM' or HRI_18 = 'DM' or HRI_19 = 'DM' or HRI_20 = 'DM'))/ COUNT(GROUP) * 100,
real RC_DV_PRI := (COUNT(GROUP, HRI_1 = 'DV' or HRI_2 = 'DV' or HRI_3 = 'DV' or HRI_4 = 'DV' or HRI_5 = 'DV' or HRI_6 = 'DV' or HRI_7 = 'DV' or HRI_8 = 'DV' or HRI_9 = 'DV' or HRI_10 = 'DV' or HRI_11 = 'DV' or HRI_12 = 'DV' or HRI_13 = 'DV' or HRI_14 = 'DV' or HRI_15 = 'DV' or HRI_16 = 'DV' or HRI_17 = 'DV' or HRI_18 = 'DV' or HRI_19 = 'DV' or HRI_20 = 'DV'))/ COUNT(GROUP) * 100,
real RC_EI_PRI := (COUNT(GROUP, HRI_1 = 'EI' or HRI_2 = 'EI' or HRI_3 = 'EI' or HRI_4 = 'EI' or HRI_5 = 'EI' or HRI_6 = 'EI' or HRI_7 = 'EI' or HRI_8 = 'EI' or HRI_9 = 'EI' or HRI_10 = 'EI' or HRI_11 = 'EI' or HRI_12 = 'EI' or HRI_13 = 'EI' or HRI_14 = 'EI' or HRI_15 = 'EI' or HRI_16 = 'EI' or HRI_17 = 'EI' or HRI_18 = 'EI' or HRI_19 = 'EI' or HRI_20 = 'EI'))/ COUNT(GROUP) * 100,
real RC_IS_PRI := (COUNT(GROUP, HRI_1 = 'IS' or HRI_2 = 'IS' or HRI_3 = 'IS' or HRI_4 = 'IS' or HRI_5 = 'IS' or HRI_6 = 'IS' or HRI_7 = 'IS' or HRI_8 = 'IS' or HRI_9 = 'IS' or HRI_10 = 'IS' or HRI_11 = 'IS' or HRI_12 = 'IS' or HRI_13 = 'IS' or HRI_14 = 'IS' or HRI_15 = 'IS' or HRI_16 = 'IS' or HRI_17 = 'IS' or HRI_18 = 'IS' or HRI_19 = 'IS' or HRI_20 = 'IS'))/ COUNT(GROUP) * 100,
real RC_IT_PRI := (COUNT(GROUP, HRI_1 = 'IT' or HRI_2 = 'IT' or HRI_3 = 'IT' or HRI_4 = 'IT' or HRI_5 = 'IT' or HRI_6 = 'IT' or HRI_7 = 'IT' or HRI_8 = 'IT' or HRI_9 = 'IT' or HRI_10 = 'IT' or HRI_11 = 'IT' or HRI_12 = 'IT' or HRI_13 = 'IT' or HRI_14 = 'IT' or HRI_15 = 'IT' or HRI_16 = 'IT' or HRI_17 = 'IT' or HRI_18 = 'IT' or HRI_19 = 'IT' or HRI_20 = 'IT'))/ COUNT(GROUP) * 100,
real RC_MI_PRI := (COUNT(GROUP, HRI_1 = 'MI' or HRI_2 = 'MI' or HRI_3 = 'MI' or HRI_4 = 'MI' or HRI_5 = 'MI' or HRI_6 = 'MI' or HRI_7 = 'MI' or HRI_8 = 'MI' or HRI_9 = 'MI' or HRI_10 = 'MI' or HRI_11 = 'MI' or HRI_12 = 'MI' or HRI_13 = 'MI' or HRI_14 = 'MI' or HRI_15 = 'MI' or HRI_16 = 'MI' or HRI_17 = 'MI' or HRI_18 = 'MI' or HRI_19 = 'MI' or HRI_20 = 'MI'))/ COUNT(GROUP) * 100,
real RC_MO_PRI := (COUNT(GROUP, HRI_1 = 'MO' or HRI_2 = 'MO' or HRI_3 = 'MO' or HRI_4 = 'MO' or HRI_5 = 'MO' or HRI_6 = 'MO' or HRI_7 = 'MO' or HRI_8 = 'MO' or HRI_9 = 'MO' or HRI_10 = 'MO' or HRI_11 = 'MO' or HRI_12 = 'MO' or HRI_13 = 'MO' or HRI_14 = 'MO' or HRI_15 = 'MO' or HRI_16 = 'MO' or HRI_17 = 'MO' or HRI_18 = 'MO' or HRI_19 = 'MO' or HRI_20 = 'MO'))/ COUNT(GROUP) * 100,
real RC_MS_PRI := (COUNT(GROUP, HRI_1 = 'MS' or HRI_2 = 'MS' or HRI_3 = 'MS' or HRI_4 = 'MS' or HRI_5 = 'MS' or HRI_6 = 'MS' or HRI_7 = 'MS' or HRI_8 = 'MS' or HRI_9 = 'MS' or HRI_10 = 'MS' or HRI_11 = 'MS' or HRI_12 = 'MS' or HRI_13 = 'MS' or HRI_14 = 'MS' or HRI_15 = 'MS' or HRI_16 = 'MS' or HRI_17 = 'MS' or HRI_18 = 'MS' or HRI_19 = 'MS' or HRI_20 = 'MS'))/ COUNT(GROUP) * 100,
real RC_NB_PRI := (COUNT(GROUP, HRI_1 = 'NB' or HRI_2 = 'NB' or HRI_3 = 'NB' or HRI_4 = 'NB' or HRI_5 = 'NB' or HRI_6 = 'NB' or HRI_7 = 'NB' or HRI_8 = 'NB' or HRI_9 = 'NB' or HRI_10 = 'NB' or HRI_11 = 'NB' or HRI_12 = 'NB' or HRI_13 = 'NB' or HRI_14 = 'NB' or HRI_15 = 'NB' or HRI_16 = 'NB' or HRI_17 = 'NB' or HRI_18 = 'NB' or HRI_19 = 'NB' or HRI_20 = 'NB'))/ COUNT(GROUP) * 100,
real RC_NF_PRI := (COUNT(GROUP, HRI_1 = 'NF' or HRI_2 = 'NF' or HRI_3 = 'NF' or HRI_4 = 'NF' or HRI_5 = 'NF' or HRI_6 = 'NF' or HRI_7 = 'NF' or HRI_8 = 'NF' or HRI_9 = 'NF' or HRI_10 = 'NF' or HRI_11 = 'NF' or HRI_12 = 'NF' or HRI_13 = 'NF' or HRI_14 = 'NF' or HRI_15 = 'NF' or HRI_16 = 'NF' or HRI_17 = 'NF' or HRI_18 = 'NF' or HRI_19 = 'NF' or HRI_20 = 'NF'))/ COUNT(GROUP) * 100,
real RC_PA_PRI := (COUNT(GROUP, HRI_1 = 'PA' or HRI_2 = 'PA' or HRI_3 = 'PA' or HRI_4 = 'PA' or HRI_5 = 'PA' or HRI_6 = 'PA' or HRI_7 = 'PA' or HRI_8 = 'PA' or HRI_9 = 'PA' or HRI_10 = 'PA' or HRI_11 = 'PA' or HRI_12 = 'PA' or HRI_13 = 'PA' or HRI_14 = 'PA' or HRI_15 = 'PA' or HRI_16 = 'PA' or HRI_17 = 'PA' or HRI_18 = 'PA' or HRI_19 = 'PA' or HRI_20 = 'PA'))/ COUNT(GROUP) * 100,
real RC_PO_PRI := (COUNT(GROUP, HRI_1 = 'PO' or HRI_2 = 'PO' or HRI_3 = 'PO' or HRI_4 = 'PO' or HRI_5 = 'PO' or HRI_6 = 'PO' or HRI_7 = 'PO' or HRI_8 = 'PO' or HRI_9 = 'PO' or HRI_10 = 'PO' or HRI_11 = 'PO' or HRI_12 = 'PO' or HRI_13 = 'PO' or HRI_14 = 'PO' or HRI_15 = 'PO' or HRI_16 = 'PO' or HRI_17 = 'PO' or HRI_18 = 'PO' or HRI_19 = 'PO' or HRI_20 = 'PO'))/ COUNT(GROUP) * 100,
real RC_RS_PRI := (COUNT(GROUP, HRI_1 = 'RS' or HRI_2 = 'RS' or HRI_3 = 'RS' or HRI_4 = 'RS' or HRI_5 = 'RS' or HRI_6 = 'RS' or HRI_7 = 'RS' or HRI_8 = 'RS' or HRI_9 = 'RS' or HRI_10 = 'RS' or HRI_11 = 'RS' or HRI_12 = 'RS' or HRI_13 = 'RS' or HRI_14 = 'RS' or HRI_15 = 'RS' or HRI_16 = 'RS' or HRI_17 = 'RS' or HRI_18 = 'RS' or HRI_19 = 'RS' or HRI_20 = 'RS'))/ COUNT(GROUP) * 100,
real RC_SD_PRI := (COUNT(GROUP, HRI_1 = 'SD' or HRI_2 = 'SD' or HRI_3 = 'SD' or HRI_4 = 'SD' or HRI_5 = 'SD' or HRI_6 = 'SD' or HRI_7 = 'SD' or HRI_8 = 'SD' or HRI_9 = 'SD' or HRI_10 = 'SD' or HRI_11 = 'SD' or HRI_12 = 'SD' or HRI_13 = 'SD' or HRI_14 = 'SD' or HRI_15 = 'SD' or HRI_16 = 'SD' or HRI_17 = 'SD' or HRI_18 = 'SD' or HRI_19 = 'SD' or HRI_20 = 'SD'))/ COUNT(GROUP) * 100,
real RC_SR_PRI := (COUNT(GROUP, HRI_1 = 'SR' or HRI_2 = 'SR' or HRI_3 = 'SR' or HRI_4 = 'SR' or HRI_5 = 'SR' or HRI_6 = 'SR' or HRI_7 = 'SR' or HRI_8 = 'SR' or HRI_9 = 'SR' or HRI_10 = 'SR' or HRI_11 = 'SR' or HRI_12 = 'SR' or HRI_13 = 'SR' or HRI_14 = 'SR' or HRI_15 = 'SR' or HRI_16 = 'SR' or HRI_17 = 'SR' or HRI_18 = 'SR' or HRI_19 = 'SR' or HRI_20 = 'SR'))/ COUNT(GROUP) * 100,
real RC_VA_PRI := (COUNT(GROUP, HRI_1 = 'VA' or HRI_2 = 'VA' or HRI_3 = 'VA' or HRI_4 = 'VA' or HRI_5 = 'VA' or HRI_6 = 'VA' or HRI_7 = 'VA' or HRI_8 = 'VA' or HRI_9 = 'VA' or HRI_10 = 'VA' or HRI_11 = 'VA' or HRI_12 = 'VA' or HRI_13 = 'VA' or HRI_14 = 'VA' or HRI_15 = 'VA' or HRI_16 = 'VA' or HRI_17 = 'VA' or HRI_18 = 'VA' or HRI_19 = 'VA' or HRI_20 = 'VA'))/ COUNT(GROUP) * 100,
real RC_WL_PRI := (COUNT(GROUP, HRI_1 = 'WL' or HRI_2 = 'WL' or HRI_3 = 'WL' or HRI_4 = 'WL' or HRI_5 = 'WL' or HRI_6 = 'WL' or HRI_7 = 'WL' or HRI_8 = 'WL' or HRI_9 = 'WL' or HRI_10 = 'WL' or HRI_11 = 'WL' or HRI_12 = 'WL' or HRI_13 = 'WL' or HRI_14 = 'WL' or HRI_15 = 'WL' or HRI_16 = 'WL' or HRI_17 = 'WL' or HRI_18 = 'WL' or HRI_19 = 'WL' or HRI_20 = 'WL'))/ COUNT(GROUP) * 100,
real RC_ZI_PRI := (COUNT(GROUP, HRI_1 = 'ZI' or HRI_2 = 'ZI' or HRI_3 = 'ZI' or HRI_4 = 'ZI' or HRI_5 = 'ZI' or HRI_6 = 'ZI' or HRI_7 = 'ZI' or HRI_8 = 'ZI' or HRI_9 = 'ZI' or HRI_10 = 'ZI' or HRI_11 = 'ZI' or HRI_12 = 'ZI' or HRI_13 = 'ZI' or HRI_14 = 'ZI' or HRI_15 = 'ZI' or HRI_16 = 'ZI' or HRI_17 = 'ZI' or HRI_18 = 'ZI' or HRI_19 = 'ZI' or HRI_20 = 'ZI'))/ COUNT(GROUP) * 100,
	
	}
	, cvi
	);


// OUTPUT(Potential_Risk_Indicators,  NAMED('Potential_Risk_Indicators'));
OUTPUT(Potential_Risk_Indicators,, output_base_location + 'Potential_Risk_Indicators_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));



//////////////////////////////////////////////////////////////////////////////REPORT 4 - Search Results

Search_Results1 :=  
TABLE
(myIIDRecords, 
	{ 
	CVI, 
	//STRING2 NAP := NAP_summary,
	UNSIGNED Total := COUNT(GROUP),
	REAL Total_Percent := (COUNT(GROUP) / TotalRecords) * 100,
	REAL NAS_0_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 0) / COUNT(GROUP)) * 100, 
	REAL NAS_1_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 1) / COUNT(GROUP)) * 100, 
	REAL NAS_2_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 2) / COUNT(GROUP)) * 100, 
	REAL NAS_3_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 3) / COUNT(GROUP)) * 100, 
	REAL NAS_4_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 4) / COUNT(GROUP)) * 100,
	REAL NAS_5_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 5) / COUNT(GROUP)) * 100,
	REAL NAS_6_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 6) / COUNT(GROUP)) * 100, 
	REAL NAS_7_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 7) / COUNT(GROUP)) * 100, 
	REAL NAS_8_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 8) / COUNT(GROUP)) * 100, 
	REAL NAS_9_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 9) / COUNT(GROUP)) * 100, 
	REAL NAS_10_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 10) / COUNT(GROUP)) * 100, 
	REAL NAS_11_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 11) / COUNT(GROUP)) * 100, 
	REAL NAS_12_SR1 := (COUNT(GROUP, (INTEGER)nas_summary = 12) / COUNT(GROUP)) * 100,
	REAL total_all_SR1 := 0
		}
	, cvi
	);


// OUTPUT(Search_Results1,  NAMED('Search_Results1'));
OUTPUT(Search_Results1,, output_base_location + 'Search_Results1_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));



Search_Results2 :=  
TABLE
(myIIDRecords, 
	{ 
	CVI, 
	//STRING2 NAP := NAP_summary,
	UNSIGNED Total := COUNT(GROUP),
	REAL Total_Percent := (COUNT(GROUP) / TotalRecords) * 100,
	REAL NAP_0_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 0) / COUNT(GROUP)) * 100, 
	REAL NAP_1_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 1) / COUNT(GROUP)) * 100, 
	REAL NAP_2_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 2) / COUNT(GROUP)) * 100, 
	REAL NAP_3_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 3) / COUNT(GROUP)) * 100, 
	REAL NAP_4_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 4) / COUNT(GROUP)) * 100,
	REAL NAP_5_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 5) / COUNT(GROUP)) * 100,
	REAL NAP_6_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 6) / COUNT(GROUP)) * 100, 
	REAL NAP_7_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 7) / COUNT(GROUP)) * 100, 
	REAL NAP_8_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 8) / COUNT(GROUP)) * 100, 
	REAL NAP_9_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 9) / COUNT(GROUP)) * 100, 
	REAL NAP_10_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 10) / COUNT(GROUP)) * 100, 
	REAL NAP_11_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 11) / COUNT(GROUP)) * 100, 
	REAL NAP_12_SR2 := (COUNT(GROUP, (INTEGER)nap_summary = 12) / COUNT(GROUP)) * 100,
	REAL total_all_SR2 := 0

	}
	, cvi
	);


// OUTPUT(Search_Results2,  NAMED('Search_Results2'));
OUTPUT(Search_Results2,, output_base_location + 'Search_Results2_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));



Search_Results3 :=  
TABLE
(myIIDRecords, 
	{ 
	CVI, 
	//STRING2 NAP := NAP_summary,
	UNSIGNED Total := COUNT(GROUP),
	REAL Total_Percent := (COUNT(GROUP) / TotalRecords) * 100,
	real verify_dob_y := (COUNT(GROUP, (string)verify_dob = 'Y') / COUNT(GROUP)) * 100, 
	real verify_dob_n := (COUNT(GROUP, (string)verify_dob = 'N') / COUNT(GROUP)) * 100 

	}
	, cvi
	);


// OUTPUT(Search_Results3,  NAMED('Search_Results3'));
OUTPUT(Search_Results3,, output_base_location + 'Search_Results3_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));
/*Search_Results4 := 
TABLE(myIIDRecords, 
	{ 
	verify_dob,
	string CVI := COUNT(GROUP),
	UNSIGNED Total := COUNT(GROUP),
	REAL Total_Percent := (COUNT(GROUP) / TotalRecords) * 100,
	string cvi2 := (COUNT(GROUP, (INTEGER)nas_summary = 0) / TotalRecords) * 100 


	}
	, verify_dob
	)
;

OUTPUT(Search_Results4, NAMED('Search_Results4'));
*/



//////////////////////////////////////////////////////////////////////////////REPORT 5 - IID Summary


IID_Summary :=  
TABLE
(myIIDRecords, 
	{ 	
	//STRING2 NAP := NAP_summary,
	UNSIGNED Total := COUNT(GROUP),
	REAL Total_Percent := (COUNT(GROUP) / TotalRecords) * 100,
	REAL Phone_Verified := (COUNT(GROUP, verhphone != '') ) ,
	REAL Phone_Verified_Pct := (COUNT(GROUP, verhphone != '') / TotalRecords) * 100,
	REAL Phone_Not_Verified := (COUNT(GROUP, verhphone = '') ),
	REAL Phone_Not_Verified_Pct := (COUNT(GROUP, verhphone = '') / TotalRecords) * 100,	
	// Phone Missing, Invalid, Mobile or Pager
	REAL Phone_Missing_Invalid_Mobile_Pager := 
									(COUNT(GROUP, 
									hri_1 in ['80', '8', '08', '9', '09', '10'] or
									hri_2 in ['80', '8', '08', '9', '09', '10'] or
									hri_3 in ['80', '8', '08', '9', '09', '10'] or
									hri_4 in ['80', '8', '08', '9', '09', '10'] or
									hri_5 in ['80', '8', '08', '9', '09', '10'] or
									hri_6 in ['80', '8', '08', '9', '09', '10'] )),
		REAL Phone_Missing_Invalid_Mobile_Pager_Pct := 
									(COUNT(GROUP, 
									hri_1 in ['80', '8', '08', '9', '09', '10'] or
									hri_2 in ['80', '8', '08', '9', '09', '10'] or
									hri_3 in ['80', '8', '08', '9', '09', '10'] or
									hri_4 in ['80', '8', '08', '9', '09', '10'] or
									hri_5 in ['80', '8', '08', '9', '09', '10'] or
									hri_6 in ['80', '8', '08', '9', '09', '10'] 
	))	/ TotalRecords * 100,
  REAL Phone_Associated_with_Different_Name_and_Address := (COUNT(GROUP, nap_summary = '1') ) ,	
	REAL Phone_Associated_with_Different_Name_and_Address_Pct := (COUNT(GROUP, nap_summary = '1') )/ TotalRecords * 100,	
	REAL Address_Missing_Invalid_or_PO_Box := 
									(COUNT(GROUP, 
									nap_summary in ['0', '1', '2', '3', '5', '8'] and									
									hri_1 in ['11', '12', '78'] or
									hri_2 in ['11', '12', '78'] or
									hri_3 in ['11', '12', '78'] or
									hri_4 in ['11', '12', '78'] or
									hri_5 in ['11', '12', '78'] or
									hri_6 in ['11', '12', '78'] 									
									)),	
	REAL Address_Missing_Invalid_or_PO_Box_Pct := 
									(COUNT(GROUP, 
									nap_summary in ['0', '1', '2', '3', '5', '8'] and									
									hri_1 in ['11', '12', '78'] or
									hri_2 in ['11', '12', '78'] or
									hri_3 in ['11', '12', '78'] or
									hri_4 in ['11', '12', '78'] or
									hri_5 in ['11', '12', '78'] or
									hri_6 in ['11', '12', '78'] 									
	))	/ TotalRecords * 100,	
	REAL New_Alternate_Phones_Found :=  
	(COUNT(GROUP,									
									(nap_summary not in ['4', '6', '7', '9', '10', '11', '12'] ) and	
									((name_addr_phone != '' and 
									length(name_addr_phone) > 6 )
									or
									(chron_phone_1 != '' or
									chron_phone_2 != '' or
									chron_phone_3 != ''))
									)),	
									
									
	REAL New_Alternate_Phones_Found_Pct :=  
	(COUNT(GROUP,									
									(nap_summary not in ['4', '6', '7', '9', '10', '11', '12'] ) and	
									((name_addr_phone != '' and 
									length(name_addr_phone) > 6 )or
									(chron_phone_1 != '' or
									chron_phone_2 != '' or
									chron_phone_3 != ''))
	))	/ TotalRecords * 100,	
	REAL Address_Verified := (COUNT(GROUP, veraddr != '') ) ,
	REAL Address_Verified_Pct := (COUNT(GROUP, veraddr != '') / TotalRecords) * 100,
	REAL Address_Not_Verified := (COUNT(GROUP, veraddr = '') ) ,
	REAL Address_Not_Verified_Pct := (COUNT(GROUP, veraddr = '') / TotalRecords) * 100,	
//if not(add_ver) and len(rc_set &  set(('11', '78'))) > 0:                                       self.tables_hash[1][1][2][1] += 1	
	REAL Address_Missing_or_Invalid := //OFF
	(COUNT(GROUP,
									((nas_summary not in ['3', '5', '6', '8', '10', '11', '12']   and
									nap_summary not in ['3', '5', '6', '8', '10', '11', '12'] )  
									and
  								(integer)
									(						
									hri_1 in ['11', '78'] or
									hri_2 in ['11', '78'] or
									hri_3 in ['11', '78'] or
									hri_4 in ['11', '78'] or
									hri_5 in ['11', '78'] or
									hri_6 in ['11', '78'])  > 0)
									
	)),	
		REAL Address_Missing_or_Invalid_Pct := //OFF
	(COUNT(GROUP,
									((nas_summary not in ['3', '5', '6', '8', '10', '11', '12']   and
									nap_summary not in ['3', '5', '6', '8', '10', '11', '12'] )  
									and
  								(integer)
									(						
									hri_1 in ['11', '78'] or
									hri_2 in ['11', '78'] or
									hri_3 in ['11', '78'] or
									hri_4 in ['11', '78'] or
									hri_5 in ['11', '78'] or
									hri_6 in ['11', '78'])  > 0)
									
	))	/ TotalRecords * 100,	
		REAL Phone_Missing_Invalid_Mobile_or_Pager := 
	(COUNT(GROUP,
									(nas_summary not in ['3', '5', '6', '8', '10', '11', '12']   and
									nap_summary not in ['3', '5', '6', '8', '10', '11', '12'])  and
									(hri_1 in ['80', '8', '08', '9', '09', '10'] or
									hri_2 in ['80', '8', '08', '9', '09', '10'] or
									hri_3 in ['80', '8', '08', '9', '09', '10'] or
									hri_4 in ['80', '8', '08', '9', '09', '10'] or
									hri_5 in ['80', '8', '08', '9', '09', '10'] or
									hri_6 in ['80', '8', '08', '9', '09', '10'] )	
	)),	
		REAL Phone_Missing_Invalid_Mobile_or_Pager_Pct := 
	(COUNT(GROUP,
									(nas_summary not in ['3', '5', '6', '8', '10', '11', '12']   and
									nap_summary not in ['3', '5', '6', '8', '10', '11', '12'])  and
									(hri_1 in ['80', '8', '08', '9', '09', '10'] or
									hri_2 in ['80', '8', '08', '9', '09', '10'] or
									hri_3 in ['80', '8', '08', '9', '09', '10'] or
									hri_4 in ['80', '8', '08', '9', '09', '10'] or
									hri_5 in ['80', '8', '08', '9', '09', '10'] or
									hri_6 in ['80', '8', '08', '9', '09', '10'] )	
	))	/ TotalRecords * 100,	
		REAL SSN_Missing_or_Invalid := 
	(COUNT(GROUP,
									(nas_summary not in ['3', '5', '6', '8', '10', '11', '12']   and
									nap_summary not in ['3', '5', '6', '8', '10', '11', '12'])  and
									(hri_1 in ['6', '06', '79', '71'] or
									hri_2 in ['6', '06', '79', '71']  or
									hri_3 in ['6', '06', '79', '71']  or
									hri_4 in ['6', '06', '79', '71']  or
									hri_5 in ['6', '06', '79', '71']  or
									hri_6 in ['6', '06', '79', '71'] 	)
	)),
				REAL SSN_Missing_or_Invalid_Pct := 
	(COUNT(GROUP,
									(nas_summary not in ['3', '5', '6', '8', '10', '11', '12']   and
									nap_summary not in ['3', '5', '6', '8', '10', '11', '12'])  and
									(hri_1 in ['6', '06', '79', '71'] or
									hri_2 in ['6', '06', '79', '71']  or
									hri_3 in ['6', '06', '79', '71']  or
									hri_4 in ['6', '06', '79', '71']  or
									hri_5 in ['6', '06', '79', '71']  or
									hri_6 in ['6', '06', '79', '71'] 	)
	))	/ TotalRecords * 100,
		REAL New_Alternate_Addresses_Found := 
	(COUNT(GROUP,
									(nas_summary not in ['3', '5', '6', '8', '10', '11', '12']   and
									nap_summary not in ['3', '5', '6', '8', '10', '11', '12'] ) and
									(Phone_address != '' or
									chron_address_1 != '' or
									chron_address_2 != '' or
									chron_address_3 != '' )	
	)),	
		REAL New_Alternate_Addresses_Found_Pct := 
	(COUNT(GROUP,
									(nas_summary not in ['3', '5', '6', '8', '10', '11', '12']   and
									nap_summary not in ['3', '5', '6', '8', '10', '11', '12'] ) and
									(Phone_address != '' or
									chron_address_1 != '' or
									chron_address_2 != '' or
									chron_address_3 != '' )	
	))	/ TotalRecords * 100,
	REAL SSN_Verified := (COUNT(GROUP, verssn != '') ) ,
	REAL SSN_Verified_Pct := (COUNT(GROUP, verssn != '') / TotalRecords) * 100,
	REAL SSN_Not_Verified := (COUNT(GROUP, verssn = '') ),
	REAL SSN_Not_Verified_Pct := (COUNT(GROUP, verssn = '') / TotalRecords) * 100,
	REAL SSN_Missing_or_Invalid2 := (COUNT(GROUP, 	
									nas_summary not in ['4', '6', '7', '9', '10', '11', '12'] and
									(hri_1 in ['6', '06', '79'] or
									hri_2 in ['6', '06', '79']  or
									hri_3 in ['6', '06', '79']  or
									hri_4 in ['6', '06', '79']  or
									hri_5 in ['6', '06', '79']  or
									hri_6 in ['6', '06', '79'] 	)	
	) ),
	REAL SSN_Missing_or_Invalid2_Pct := (COUNT(GROUP, 	
		nas_summary not in ['4', '6', '7', '9', '10', '11', '12'] and
									(hri_1 in ['6', '06', '79'] or
									hri_2 in ['6', '06', '79']  or
									hri_3 in ['6', '06', '79']  or
									hri_4 in ['6', '06', '79']  or
									hri_5 in ['6', '06', '79']  or
									hri_6 in ['6', '06', '79'] 	)	
	) / TotalRecords) * 100,
	
	REAL SSN_Associated_with_Different_Name_and_Address := (COUNT(GROUP, 	
		nas_summary  in ['1'] 		
	) / TotalRecords) * 100,
	
	REAL SSN_Associated_with_Different_Name_and_Address_Pct := (COUNT(GROUP, 	
		nas_summary  in ['1'] 		
	) / TotalRecords) * 100,
	
	
	
	
	
	}
	);


// OUTPUT(IID_Summary,  NAMED('IID_Summary')); //DEBUG
OUTPUT(IID_Summary,, output_base_location + 'IID_summary_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));

return 'done';

End;
End;
