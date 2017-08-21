IMPORT PRTE2_Common;

export PhonesPlus := module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20081114';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
export rthor_data400__key__phonesplus__did	:=
record
	unsigned integer6 l_did;
	unsigned integer3 datevendorfirstreported;
	unsigned integer3 datevendorlastreported;
	unsigned integer3 datefirstseen;
	unsigned integer3 datelastseen;
	unsigned integer3 dt_nonglb_last_seen;
	string1 glb_dppa_flag;
	string1 activeflag;
	string32 cellphoneidkey;
	unsigned integer2 confidencescore;
	string60 recordkey;
	string2 vendor;
	string2 stateorigin;
	string20 sourcefile;
	string2 src;
	string90 origname;
	string1 nameformat;
	string25 address1;
	string25 address2;
	string25 address3;
	string20 origcity;
	string2 origstate;
	string9 origzip;
	string35 country;
	string8 dob;
	string10 agegroup;
	string8 gender;
	string50 email;
	string10 homephone;
	string10 cellphone;
	string2 listingtype;
	string2 publishcode;
	string80 company;
	string25 origtitle;
	unsigned integer3 registrationdate;
	string20 phonemodel;
	string20 ipaddress;
	string20 carriercode;
	string15 countrycode;
	string15 keycode;
	string15 globalkeycode;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 state;
	string5 zip5;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 ace_fips_st;
	string3 ace_fips_county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	unsigned integer6 did;
	string3 did_score;
	unsigned integer8 __internal_fpos__;
end;

EXPORT dthor_data400__key__phonesplus__did := dataset(lCSVFileNamePrefix + 'thor_data400__key__phonesplus__' + lCSVVersion + '__did_from_archive.csv', rthor_data400__key__phonesplus__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
EXPORT dthor_data400__key__phonesplus__did_ge := dataset(lCSVFileNamePrefix + 'thor_data400_key_phonesplus_ge_did.csv', rthor_data400__key__phonesplus__did, csv(separator('\t'), terminator('\r\n'), quote('')));

alpha_name	:= PRTE2_Common.Cross_Module_Files.PhonesPlus_Base_SF_Name;
EXPORT Alpharetta_phonesplus_did		:= DATASET(alpha_name, rthor_data400__key__phonesplus__did, THOR);

end;