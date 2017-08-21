export CourtLocatorLookup := 
module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20110721';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400_key_courtlocatorlookup_fips	:=
RECORD
  string5 l_fips;
  string8 process_date;
  string fipscode;
  string courtid;
  string masterid;
  string stateofservice;
  string name;
  string courtname;
  string address1;
  string address2;
  string city;
  string zipcode;
  string state;
  string phone;
  string filingamounts;
  string courtcosts;
  string mailaddress1;
  string mailaddress2;
  string mailcity;
  string mailstate;
  string mailzip;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 z5;
  string4 z4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string5 county_code;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string1 nametype;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string5 title2;
  string20 fname2;
  string20 mname2;
  string20 lname2;
  string5 suffix2;
  string3 name_score;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 rawaid;
 END;



export dthor_data400_key_courtlocatorlookup_fips								:= dataset(lCSVFileNamePrefix + 'thor_data400_key_courtlocatorlookup_' + lCSVVersion + '_fips.csv', rthor_data400_key_courtlocatorlookup_fips, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;