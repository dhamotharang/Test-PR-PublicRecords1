IMPORT PRTE2_PhonesPlus, Phonesplus_v2, Phonesplus, PRTE2_Common, PRTE_CSV;

EXPORT Layouts := MODULE

//EXPORT Alpha_CSV_Layout := PRTE_CSV.Phonesplus.rthor_data400__key__phonesplus__did; // Layout of the CSV files for Phonesplusv2
EXPORT Alpha_CSV_Layout := RECORD
	UNSIGNED INTEGER6 l_did;
	UNSIGNED INTEGER3 datevendorfirstreported;
	UNSIGNED INTEGER3 datevendorlastreported;
	UNSIGNED INTEGER3 datefirstseen;
	UNSIGNED INTEGER3 datelastseen;
	UNSIGNED INTEGER3 dt_nonglb_last_seen;
	STRING1 glb_dppa_flag;
	STRING1 activeflag;
	STRING32 cellphoneidkey;
	UNSIGNED INTEGER2 confidencescore;
	STRING60 recordkey;
	STRING2 vendor;
	STRING2 stateorigin;
	STRING20 sourcefile;
	STRING2 src;
	STRING90 origname;
	STRING1 nameformat;
	STRING25 address1;
	STRING25 address2;
	STRING25 address3;
	STRING20 origcity;
	STRING2 origstate;
	STRING9 origzip;
	STRING35 country;
	STRING8 dob;
	STRING10 agegroup;
	STRING8 gender;
	STRING50 email;
	STRING10 homephone;
	STRING10 cellphone;
	STRING2 listingtype;
	STRING2 publishcode;
	STRING80 company;
	STRING25 origtitle;
	UNSIGNED INTEGER3 registrationdate;
	STRING20 phonemodel;
	STRING20 ipaddress;
	STRING20 carriercode;
	STRING15 countrycode;
	STRING15 keycode;
	STRING15 globalkeycode;
	STRING10 prim_range;
	STRING2 predir;
	STRING28 prim_name;
	STRING4 addr_suffix;
	STRING2 postdir;
	STRING10 unit_desig;
	STRING8 sec_range;
	STRING25 p_city_name;
	STRING25 v_city_name;
	STRING2 state;
	STRING5 zip5;
	STRING4 zip4;
	STRING4 cart;
	STRING1 cr_sort_sz;
	STRING4 lot;
	STRING1 lot_order;
	STRING2 dpbc;
	STRING1 chk_digit;
	STRING2 rec_type;
	STRING2 ace_fips_st;
	STRING3 ace_fips_county;
	STRING10 geo_lat;
	STRING11 geo_long;
	STRING4 msa;
	STRING7 geo_blk;
	STRING1 geo_match;
	STRING4 err_stat;
	STRING5 title;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5 name_suffix;
	STRING3 name_score;
	UNSIGNED INTEGER6 did;
	STRING3 did_score;
	UNSIGNED INTEGER8 __internal_fpos__;
END;

//Boca's input file
EXPORT Base_in	:= RECORD
	UNSIGNED6	l_did := 0;
	Phonesplus.layoutCommonKeys;
	UNSIGNED8	__internal_fpos__;
	STRING20	cust_name;
	STRING10	bug_num;
	STRING9		link_ssn;
	STRING8		link_dob;
	STRING9		cust_ssn;
	STRING3		append_row_id;
	string60 orig_carrier_name;
END;

//Common to both Boca and Alpharetta's input file
EXPORT Base_common	:= RECORD
	UNSIGNED6	l_did := 0;
	Phonesplus.layoutCommonKeys;
	UNSIGNED8	__internal_fpos__;
	STRING20	cust_name	:= '';
	STRING10	bug_num		:= '';
END;

//PhonePlus base file with extended fields added for Data Insight
EXPORT Base_ext	:= RECORD	
	Phonesplus_v2.Layout_Phonesplus_Base;
	STRING20	cust_name;
	STRING10	bug_num;
	STRING9		link_ssn;
	STRING8		link_dob;
	STRING9		cust_ssn; //used for header only
END;

//Used for Royalty keys
EXPORT DSphonesplus_slim := RECORD
	UNSIGNED6 fdid;
	Phonesplus_v2.Layout_Phonesplus_Base;
END;

END;