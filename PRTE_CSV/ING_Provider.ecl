export ING_Provider := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100713a';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;


export rthor_data400__key__ing_provider__did := { unsigned6 l_did, unsigned6 providerid };

export rthor_data400__key__ing_provider__id	:=
record
	unsigned6 l_providerid;
	string12 did;
	string3 did_score;
	string filetyp;
	string processdate;
	string providerid;
	string addressid;
	string lastname;
	string firstname;
	string middlename;
	string suffix;
	string gender;
	string providernamecompanycount;
	string providernametierid;
	string address;
	string address2;
	string city;
	string state;
	string county;
	string zip;
	string extzip;
	string latitude;
	string longitute;
	string georeturn;
	string highrisk;
	string provideraddresscompanycount;
	string provideraddresstiertypeid;
	string provideraddresstypecode;
  string provideraddressverificationstatuscode;
  string provideraddressverificationdate;
	string birthdate;
	string birthdatecompanycount;
	string birthdatetiertypeid;
	string taxid;
	string taxidcompanycount;
	string taxidtiertypeid;
	string phonenumber;
	string phonetype;
	string phonenumbercompanycount;
	string phonenumbertiertypeid;
	string5 prov_clean_title;
	string20 prov_clean_fname;
	string20 prov_clean_mname;
	string20 prov_clean_lname;
	string5 prov_clean_name_suffix;
	string3 prov_clean_cleaning_score;
	string10 prov_clean_prim_range;
	string2 prov_clean_predir;
	string28 prov_clean_prim_name;
	string4 prov_clean_addr_suffix;
	string2 prov_clean_postdir;
	string10 prov_clean_unit_desig;
	string8 prov_clean_sec_range;
	string25 prov_clean_p_city_name;
	string25 prov_clean_v_city_name;
	string2 prov_clean_st;
	string5 prov_clean_zip;
	string4 prov_clean_zip4;
	string4 prov_clean_cart;
	string1 prov_clean_cr_sort_sz;
	string4 prov_clean_lot;
	string1 prov_clean_lot_order;
	string2 prov_clean_dpbc;
	string1 prov_clean_chk_digit;
	string2 prov_clean_record_type;
	string2 prov_clean_ace_fips_st;
	string3 prov_clean_fipscounty;
	string10 prov_clean_geo_lat;
	string11 prov_clean_geo_long;
	string4 prov_clean_msa;
	string7 prov_clean_geo_match;
	string4 prov_clean_err_stat;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
  string optoutsitedescription;
  string affidavitreceiveddate;
  string optouteffectivedate;
  string dateoptoutterminationdate;
  string optoutstatus;
  string lastupdate;
  string deceasedindicator;
  string deceaseddate;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ing_provider__license := { string2 licensestate, string12 licensenumber, unsigned6 providerid };

export dthor_data400__key__ing_provider__did 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ing_provider__' + lCSVVersion + '__did.csv', rthor_data400__key__ing_provider__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ing_provider__id 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ing_provider__' + lCSVVersion + '__id.csv', rthor_data400__key__ing_provider__id, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ing_provider__license 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ing_provider__' + lCSVVersion + '__license.csv', rthor_data400__key__ing_provider__license, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;