import iesp;

EXPORT VerificationOfOccupancy_report_layouts := MODULE

export in_key := RECORD
  unsigned4 Seq;
		string20 dataset_name;
		string30 acctNo;
		string15 fname;
		string20 lname;
		string9  zip;
		string9  in_ssn;
		string10 hphone;
	END;
	
export VOOReportOutLayout:= RECORD
			unsigned4 Seq;
			string20 dataset_name;
		 data16 hashkey;
			iesp.verificationofoccupancy.t_VOOReport Report;
	END;


	//Summary
	export Summary := record	
		in_key;
//*Layout Full Name :	iesp.verificationofoccupancy.t_VOOSummary
//*Total # of Fields:	182
//*Layout Generated :	On 12/06/17 At 11:15:02 AM
//*******************	*****************************************
//*** BEGIN_LAYOUT ***	 
			string12 	uniqueid;
		/*  BEGIN_RECORD	name (t_name) */
			string62 	summary_full;
			string20 	summary_first;
			string20 	summary_middle;
			string20 	summary_last;
			string5  	summary_suffix;
			string3  	summary_prefix;
/*  END___RECORD	name */
/*  BEGIN_RECORD	currentaddress (t_vooaddress) */
	/*  BEGIN_RECORD	address (t_address) */
		string10 	summary_CurrentAddress_streetnumber;
		string2  	summary_CurrentAddress_streetpredirection;
		string28 	summary_CurrentAddress_streetname;
		string4  	summary_CurrentAddress_streetsuffix;
		string2  	summary_CurrentAddress_streetpostdirection;
		string10 	summary_CurrentAddress_unitdesignation;
		string8  	summary_CurrentAddress_unitnumber;
		string60 	summary_CurrentAddress_streetaddress1;
		string60 	summary_CurrentAddress_streetaddress2;
		string25 	summary_CurrentAddress_city;
		string2  	summary_CurrentAddress_state;
		string5  	summary_CurrentAddress_zip5;
		string4  	summary_CurrentAddress_zip4;
		string18 	summary_CurrentAddress_county;
		string9  	summary_CurrentAddress_postalcode;
		string50 	summary_CurrentAddress_statecityzip;
	/*  END___RECORD	address */
		string32 	summary_CurrentAddress_residentialorbusiness;
		string32 	summary_CurrentAddress_type;
		string128	summary_CurrentAddress_mixeduse;
	/** BEGIN_DATASET	highriskindicators */
		string4  	summary_CurrentAddress_highriskindicators1_riskcode;
		string150	summary_CurrentAddress_highriskindicators1_description;
		string4  	summary_CurrentAddress_highriskindicators2_riskcode;
		string150	summary_CurrentAddress_highriskindicators2_description;
	/** END___DATASET	highriskindicators */
/*  END___RECORD	currentaddress */
/*  BEGIN_RECORD	ssn (t_ssninfoex) */
		string9  	summary_ssn_ssn;
		string5  	summary_ssn_valid;
		string32 	summary_ssn_issuedlocation;
	/*  BEGIN_RECORD	issuedstartdate (t_date) */
		integer2 	summary_ssn_issuedstartdate_year;
		integer2 	summary_ssn_issuedstartdate_month;
		integer2 	summary_ssn_issuedstartdate_day;
	/*  END___RECORD	issuedstartdate */
	/*  BEGIN_RECORD	issuedenddate (t_date) */
		integer2 	summary_ssn_issuedenddate_year;
		integer2 	summary_ssn_issuedenddate_month;
		integer2 	summary_ssn_issuedenddate_day;
	/*  END___RECORD	issuedenddate */
	/** BEGIN_DATASET	highriskindicators */
		string4  	summary_ssn_highriskindicators1_riskcode;
		string150	summary_ssn_highriskindicators1_description;
		string4  	summary_ssn_highriskindicators2_riskcode;
		string150	summary_ssn_highriskindicators2_description;
	/** END___DATASET	highriskindicators */
/*  END___RECORD	ssn */
/** BEGIN_DATASET	phones1 */
		boolean  	summary_phones1_alsofound;
		boolean  	summary_phones1_telcordiaonly;
		string   	summary_phones1_typeflag;
		string   	summary_phones1_uniqueid;
	/*  BEGIN_RECORD	name (t_name) */
		string62 	summary_phones1_name_full;
		string20 	summary_phones1_name_first;
		string20 	summary_phones1_name_middle;
		string20 	summary_phones1_name_last;
		string5  	summary_phones1_name_suffix;
		string3  	summary_phones1_name_prefix;
	/*  END___RECORD	name */
	/*  BEGIN_RECORD	address (t_address) */
		string10 	summary_phones1_Address_streetnumber;
		string2  	summary_phones1_Address_streetpredirection;
		string28 	summary_phones1_Address_streetname;
		string4  	summary_phones1_Address_streetsuffix;
		string2  	summary_phones1_Address_streetpostdirection;
		string10 	summary_phones1_Address_unitdesignation;
		string8  	summary_phones1_Address_unitnumber;
		string60 	summary_phones1_Address_streetaddress1;
		string60 	summary_phones1_Address_streetaddress2;
		string25 	summary_phones1_Address_city;
		string2  	summary_phones1_Address_state;
		string5  	summary_phones1_Address_zip5;
		string4  	summary_phones1_Address_zip4;
		string18 	summary_phones1_Address_county;
		string9  	summary_phones1_Address_postalcode;
		string50 	summary_phones1_Address_statecityzip;
	/*  END___RECORD	address */
		string   	summary_phones1_companyname;
		string   	summary_phones1_listedname;
		string   	summary_phones1_phone10;
		string   	summary_phones1_timezone;
	/** BEGIN_DATASET	listingtypes */
		string   	summary_phones1_listingtypes1_value;
		string   	summary_phones1_listingtypes2_value;
	/** END___DATASET	listingtypes */
		string   	summary_phones1_captiontext;
	/*  BEGIN_RECORD	centralofficecode (t_centralofficecode) */
			string   	summary_phones1_centralofficecode_code;
		/** BEGIN_DATASET	descriptions */
			string   	summary_phones1_centralofficecode_descriptions1_value;
			string   	summary_phones1_centralofficecode_descriptions2_value;
		/** END___DATASET	descriptions */
	/*  END___RECORD	centralofficecode */
	/*  BEGIN_RECORD	specialservicecode (t_specialservicecode) */
		string   	summary_phones1_specialservicecode_code;
		/** BEGIN_DATASET	descriptions */
			string   	summary_phones1_specialservicecode_descriptions1_value;
			string   	summary_phones1_specialservicecode_descriptions2_value;
		/** END___DATASET	descriptions */
	/*  END___RECORD	specialservicecode */
		boolean  	summary_phones1_dialindicator;
	/*  BEGIN_RECORD	phoneregion (t_phoneregion) */
		string   	summary_phones1_phoneregion_city;
		string   	summary_phones1_phoneregion_state;
	/*  END___RECORD	phoneregion */
		string   	summary_phones1_carriername;
		boolean  	summary_phones1_isconfirmed;
		string   	summary_phones1_listednameverified;
		string   	summary_phones1_newtype;
		string   	summary_phones1_vendorid;
	/*  BEGIN_RECORD	datefirstseen (t_date) */
		integer2 	summary_phones1_datefirstseen_year;
		integer2 	summary_phones1_datefirstseen_month;
		integer2 	summary_phones1_datefirstseen_day;
	/*  END___RECORD	datefirstseen */
	/*  BEGIN_RECORD	datelastseen (t_date) */
		integer2 	summary_phones1_datelastseen_year;
		integer2 	summary_phones1_datelastseen_month;
		integer2 	summary_phones1_datelastseen_day;
	/*  END___RECORD	datelastseen */
	/*  BEGIN_RECORD	phonefeedback (t_phonesfeedback) */
		integer8 	summary_phones1_phonefeedback_feedbackcount;
		string128	summary_phones1_phonefeedback_lastfeedbackresult;
		string8  	summary_phones1_phonefeedback_lastfeedbackresultprovided;
	/*  END___RECORD	phonefeedback */
	/*  BEGIN_RECORD	addressfeedback (t_addressfeedback) */
		integer8 	summary_phones1_addressfeedback_feedbackcount;
		string   	summary_phones1_addressfeedback_lastfeedbackresult;
		string   	summary_phones1_addressfeedback_lastfeedbackresultprovided;
	/*  END___RECORD	addressfeedback */
	/*  BEGIN_RECORD	realtimephoneinfo (t_dawrealtimephoneinfo) */
		string   	summary_phones1_realtimephoneinfo_callerid;
		/*  BEGIN_RECORD	status (t_ocstatus) */
			string   	summary_phones1_realtimephoneinfo_status_code;
			string   	summary_phones1_realtimephoneinfo_status_description;
		/*  END___RECORD	status */
		/*  BEGIN_RECORD	porting (t_ocporting) */
			string   	summary_phones1_realtimephoneinfo_porting_code;
			string   	summary_phones1_realtimephoneinfo_porting_description;
		/*  END___RECORD	porting */
		/*  BEGIN_RECORD	operatingcompany (t_operatingcompanyinfo) */
			string   	summary_phones1_realtimephoneinfo_operatingcompany_number;
			string   	summary_phones1_realtimephoneinfo_operatingcompany_name;
			string   	summary_phones1_realtimephoneinfo_operatingcompany_affiliatedto;
			/*  BEGIN_RECORD	address (t_address) */
				string10 	summary_phones1_realtimephoneinfo_operatingcompany_address_streetnumber;
				string2  	summary_phones1_realtimephoneinfo_operatingcompany_address_streetpredirection;
				string28 	summary_phones1_realtimephoneinfo_operatingcompany_address_streetname;
				string4  	summary_phones1_realtimephoneinfo_operatingcompany_address_streetsuffix;
				string2  	summary_phones1_realtimephoneinfo_operatingcompany_address_streetpostdirection;
				string10 	summary_phones1_realtimephoneinfo_operatingcompany_address_unitdesignation;
				string8  	summary_phones1_realtimephoneinfo_operatingcompany_address_unitnumber;
				string60 	summary_phones1_realtimephoneinfo_operatingcompany_address_streetaddress1;
				string60 	summary_phones1_realtimephoneinfo_operatingcompany_address_streetaddress2;
				string25 	summary_phones1_realtimephoneinfo_operatingcompany_address_city;
				string2  	summary_phones1_realtimephoneinfo_operatingcompany_address_state;
				string5  	summary_phones1_realtimephoneinfo_operatingcompany_address_zip5;
				string4  	summary_phones1_realtimephoneinfo_operatingcompany_address_zip4;
				string18 	summary_phones1_realtimephoneinfo_operatingcompany_address_county;
				string9  	summary_phones1_realtimephoneinfo_operatingcompany_address_postalcode;
				string50 	summary_phones1_realtimephoneinfo_operatingcompany_address_statecityzip;
			/*  END___RECORD	address */
			/*  BEGIN_RECORD	phone (t_ocphoneinfo) */
				string   	summary_phones1_realtimephoneinfo_operatingcompany_phone_phonenpa;
				string   	summary_phones1_realtimephoneinfo_operatingcompany_phone_phonenxx;
				string   	summary_phones1_realtimephoneinfo_operatingcompany_phone_phoneline;
				string   	summary_phones1_realtimephoneinfo_operatingcompany_phone_phoneext;
				string   	summary_phones1_realtimephoneinfo_operatingcompany_phone_faxnpa;
				string   	summary_phones1_realtimephoneinfo_operatingcompany_phone_faxnxx;
				string   	summary_phones1_realtimephoneinfo_operatingcompany_phone_faxline;
			/*  END___RECORD	phone */
			/*  BEGIN_RECORD	contact (t_occontactinfo) */
				string   	summary_phones1_realtimephoneinfo_operatingcompany_contact_email;
				/*  BEGIN_RECORD	name (t_name) */
					string62 	summary_phones1_realtimephoneinfo_operatingcompany_contact_name_full;
					string20 	summary_phones1_realtimephoneinfo_operatingcompany_contact_name_first;
					string20 	summary_phones1_realtimephoneinfo_operatingcompany_contact_name_middle;
					string20 	summary_phones1_realtimephoneinfo_operatingcompany_contact_name_last;
					string5  	summary_phones1_realtimephoneinfo_operatingcompany_contact_name_suffix;
					string3  	summary_phones1_realtimephoneinfo_operatingcompany_contact_name_prefix;
				/*  END___RECORD	name */
				/*  BEGIN_RECORD	address (t_address) */
					string10 	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetnumber;
					string2  	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetpredirection;
					string28 	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetname;
					string4  	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetsuffix;
					string2  	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetpostdirection;
					string10 	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_unitdesignation;
					string8  	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_unitnumber;
					string60 	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetaddress1;
					string60 	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_streetaddress2;
					string25 	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_city;
					string2  	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_state;
					string5  	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_zip5;
					string4  	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_zip4;
					string18 	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_county;
					string9  	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_postalcode;
					string50 	summary_phones1_realtimephoneinfo_operatingcompany_contact_address_statecityzip;
				/*  END___RECORD	address */
			/*  END___RECORD	contact */
		/*  END___RECORD	operatingcompany */
		/*  BEGIN_RECORD	listingcreationdate (t_date) */
				integer2 	summary_phones1_realtimephoneinfo_listingcreationdate_year;
				integer2 	summary_phones1_realtimephoneinfo_listingcreationdate_month;
				integer2 	summary_phones1_realtimephoneinfo_listingcreationdate_day;
		/*  END___RECORD	listingcreationdate */
		/*  BEGIN_RECORD	listingtransactiondate (t_date) */
			integer2 	summary_phones1_realtimephoneinfo_listingtransactiondate_year;
			integer2 	summary_phones1_realtimephoneinfo_listingtransactiondate_month;
			integer2 	summary_phones1_realtimephoneinfo_listingtransactiondate_day;
		/*  END___RECORD	listingtransactiondate */
		/*  BEGIN_RECORD	statusflag (t_ocstatus) */
			string   	summary_phones1_realtimephoneinfo_statusflag_code;
			string   	summary_phones1_realtimephoneinfo_statusflag_description;
		/*  END___RECORD	statusflag */
			string    summary_phones1_realtimephoneinfo_privacyindicator;
			string   	summary_phones1_realtimephoneinfo_datasource;
			string   	summary_phones1_realtimephoneinfo_latitude;
			string   	summary_phones1_realtimephoneinfo_longitude;
			string   	summary_phones1_realtimephoneinfo_fips;
			string   	summary_phones1_realtimephoneinfo_listingtype;
	/*  END___RECORD	realtimephoneinfo */
	string   	summary_phones1_ssn;
	string   	summary_phones1_ssnmatch;
	/*  BEGIN_RECORD	dod (t_date) */
		integer2 	summary_phones1_dod_year;
		integer2 	summary_phones1_dod_month;
		integer2 	summary_phones1_dod_day;
	/*  END___RECORD	dod */
		string1  	summary_phones1_deceased;
		boolean  	summary_phones1_yellowflag;
		string   	summary_phones1_probablecurrentaddress;
	/** BEGIN_DATASET	hriaddress */
		string4  	summary_phones1_hriaddress1_code;
		string150	summary_phones1_hriaddress1_description;
		// string4  	summary_phones1_hriaddress2_code;
		// string150	summary_phones1_hriaddress2_description;
	/** END___DATASET	hriaddress */
	/** BEGIN_DATASET	hriphone */
		string4  	summary_phones1_hriphone1_code;
		string150	summary_phones1_hriphone1_description;
		// string4  	summary_phones1_hriphone2_code;
		// string150	summary_phones1_hriphone2_description;
	/** END___DATASET	hriphone */
	/** BEGIN_DATASET	highriskindicators */
		string4  	summary_phones1_highriskindicators1_riskcode;
		string150	summary_phones1_highriskindicators1_description;
		string4  	summary_phones1_highriskindicators2_riskcode;
		string150	summary_phones1_highriskindicators2_description;
	/** END___DATASET	highriskindicators */
	
/** BEGIN_DATASET	phones2 */	
		boolean  	summary_phones2_alsofound;
		boolean  	summary_phones2_telcordiaonly;
		string   	summary_phones2_typeflag;
		string   	summary_phones2_uniqueid;
	/*  BEGIN_RECORD	name (t_name) */
		string62 	summary_phones2_name_full;
		string20 	summary_phones2_name_first;
		string20 	summary_phones2_name_middle;
		string20 	summary_phones2_name_last;
		string5  	summary_phones2_name_suffix;
		string3  	summary_phones2_name_prefix;
	/*  END___RECORD	name */
	/*  BEGIN_RECORD	address (t_address) */
		string10 	summary_phones2_Address_streetnumber;
		string2  	summary_phones2_Address_streetpredirection;
		string28 	summary_phones2_Address_streetname;
		string4  	summary_phones2_Address_streetsuffix;
		string2  	summary_phones2_Address_streetpostdirection;
		string10 	summary_phones2_Address_unitdesignation;
		string8  	summary_phones2_Address_unitnumber;
		string60 	summary_phones2_Address_streetaddress1;
		string60 	summary_phones2_Address_streetaddress2;
		string25 	summary_phones2_Address_city;
		string2  	summary_phones2_Address_state;
		string5  	summary_phones2_Address_zip5;
		string4  	summary_phones2_Address_zip4;
		string18 	summary_phones2_Address_county;
		string9  	summary_phones2_Address_postalcode;
		string50 	summary_phones2_Address_statecityzip;
	/*  END___RECORD	address */
		string   	summary_phones2_companyname;
		string   	summary_phones2_listedname;
		string   	summary_phones2_phone10;
		string   	summary_phones2_timezone;
	/** BEGIN_DATASET	listingtypes */
		string   	summary_phones2_listingtypes1_value;
		string   	summary_phones2_listingtypes2_value;
	/** END___DATASET	listingtypes */
	string   	summary_phones2_captiontext;
	/*  BEGIN_RECORD	centralofficecode (t_centralofficecode) */
		string   	summary_phones2_centralofficecode_code;
		/** BEGIN_DATASET	descriptions */
			string   	summary_phones2_centralofficecode_descriptions1_value;
			string   	summary_phones2_centralofficecode_descriptions2_value;
		/** END___DATASET	descriptions */
	/*  END___RECORD	centralofficecode */
	/*  BEGIN_RECORD	specialservicecode (t_specialservicecode) */
		string   	summary_phones2_specialservicecode_code;
		/** BEGIN_DATASET	descriptions */
			string   	summary_phones2_specialservicecode_descriptions1_value;
			string   	summary_phones2_specialservicecode_descriptions2_value;
		/** END___DATASET	descriptions */
	/*  END___RECORD	specialservicecode */
	boolean  	summary_phones2_dialindicator;
	/*  BEGIN_RECORD	phoneregion (t_phoneregion) */
		string   	summary_phones2_phoneregion_city;
		string   	summary_phones2_phoneregion_state;
	/*  END___RECORD	phoneregion */
		string   	summary_phones2_carriername;
		boolean  	summary_phones2_isconfirmed;
		string   	summary_phones2_listednameverified;
		string   	summary_phones2_newtype;
		string   	summary_phones2_vendorid;
	/*  BEGIN_RECORD	datefirstseen (t_date) */
		integer2 	summary_phones2_datefirstseen_year;
		integer2 	summary_phones2_datefirstseen_month;
		integer2 	summary_phones2_datefirstseen_day;
	/*  END___RECORD	datefirstseen */
	/*  BEGIN_RECORD	datelastseen (t_date) */
		integer2 	summary_phones2_datelastseen_year;
		integer2 	summary_phones2_datelastseen_month;
		integer2 	summary_phones2_datelastseen_day;
	/*  END___RECORD	datelastseen */
	/*  BEGIN_RECORD	phonefeedback (t_phonesfeedback) */
		integer8 	summary_phones2_phonefeedback_feedbackcount;
		string128	summary_phones2_phonefeedback_lastfeedbackresult;
		string8  	summary_phones2_phonefeedback_lastfeedbackresultprovided;
	/*  END___RECORD	phonefeedback */
	/*  BEGIN_RECORD	addressfeedback (t_addressfeedback) */
		integer8 	summary_phones2_addressfeedback_feedbackcount;
		string   	summary_phones2_addressfeedback_lastfeedbackresult;
		string   	summary_phones2_addressfeedback_lastfeedbackresultprovided;
	/*  END___RECORD	addressfeedback */
	/*  BEGIN_RECORD	realtimephoneinfo (t_dawrealtimephoneinfo) */
		string   	summary_phones2_realtimephoneinfo_callerid;
		/*  BEGIN_RECORD	status (t_ocstatus) */
			string   	summary_phones2_realtimephoneinfo_status_code;
			string   	summary_phones2_realtimephoneinfo_status_description;
		/*  END___RECORD	status */
		/*  BEGIN_RECORD	porting (t_ocporting) */
			string   	summary_phones2_realtimephoneinfo_porting_code;
			string   	summary_phones2_realtimephoneinfo_porting_description;
		/*  END___RECORD	porting */
		/*  BEGIN_RECORD	operatingcompany (t_operatingcompanyinfo) */
			string   	summary_phones2_realtimephoneinfo_operatingcompany_number;
			string   	summary_phones2_realtimephoneinfo_operatingcompany_name;
			string   	summary_phones2_realtimephoneinfo_operatingcompany_affiliatedto;
			/*  BEGIN_RECORD	address (t_address) */
				string10 	summary_phones2_realtimephoneinfo_operatingcompany_address_streetnumber;
				string2  	summary_phones2_realtimephoneinfo_operatingcompany_address_streetpredirection;
				string28 	summary_phones2_realtimephoneinfo_operatingcompany_address_streetname;
				string4  	summary_phones2_realtimephoneinfo_operatingcompany_address_streetsuffix;
				string2  	summary_phones2_realtimephoneinfo_operatingcompany_address_streetpostdirection;
				string10 	summary_phones2_realtimephoneinfo_operatingcompany_address_unitdesignation;
				string8  	summary_phones2_realtimephoneinfo_operatingcompany_address_unitnumber;
				string60 	summary_phones2_realtimephoneinfo_operatingcompany_address_streetaddress1;
				string60 	summary_phones2_realtimephoneinfo_operatingcompany_address_streetaddress2;
				string25 	summary_phones2_realtimephoneinfo_operatingcompany_address_city;
				string2  	summary_phones2_realtimephoneinfo_operatingcompany_address_state;
				string5  	summary_phones2_realtimephoneinfo_operatingcompany_address_zip5;
				string4  	summary_phones2_realtimephoneinfo_operatingcompany_address_zip4;
				string18 	summary_phones2_realtimephoneinfo_operatingcompany_address_county;
				string9  	summary_phones2_realtimephoneinfo_operatingcompany_address_postalcode;
				string50 	summary_phones2_realtimephoneinfo_operatingcompany_address_statecityzip;
			/*  END___RECORD	address */
			/*  BEGIN_RECORD	phone (t_ocphoneinfo) */
				string   	summary_phones2_realtimephoneinfo_operatingcompany_phone_phonenpa;
				string   	summary_phones2_realtimephoneinfo_operatingcompany_phone_phonenxx;
				string   	summary_phones2_realtimephoneinfo_operatingcompany_phone_phoneline;
				string   	summary_phones2_realtimephoneinfo_operatingcompany_phone_phoneext;
				string   	summary_phones2_realtimephoneinfo_operatingcompany_phone_faxnpa;
				string   	summary_phones2_realtimephoneinfo_operatingcompany_phone_faxnxx;
				string   	summary_phones2_realtimephoneinfo_operatingcompany_phone_faxline;
			/*  END___RECORD	phone */
			/*  BEGIN_RECORD	contact (t_occontactinfo) */
				string   	summary_phones2_realtimephoneinfo_operatingcompany_contact_email;
				/*  BEGIN_RECORD	name (t_name) */
					string62 	summary_phones2_realtimephoneinfo_operatingcompany_contact_name_full;
					string20 	summary_phones2_realtimephoneinfo_operatingcompany_contact_name_first;
					string20 	summary_phones2_realtimephoneinfo_operatingcompany_contact_name_middle;
					string20 	summary_phones2_realtimephoneinfo_operatingcompany_contact_name_last;
					string5  	summary_phones2_realtimephoneinfo_operatingcompany_contact_name_suffix;
					string3  	summary_phones2_realtimephoneinfo_operatingcompany_contact_name_prefix;
				/*  END___RECORD	name */
				/*  BEGIN_RECORD	address (t_address) */
					string10 	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetnumber;
					string2  	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetpredirection;
					string28 	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetname;
					string4  	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetsuffix;
					string2  	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetpostdirection;
					string10 	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_unitdesignation;
					string8  	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_unitnumber;
					string60 	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetaddress1;
					string60 	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_streetaddress2;
					string25 	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_city;
					string2  	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_state;
					string5  	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_zip5;
					string4  	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_zip4;
					string18 	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_county;
					string9  	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_postalcode;
					string50 	summary_phones2_realtimephoneinfo_operatingcompany_contact_address_statecityzip;
				/*  END___RECORD	address */
			/*  END___RECORD	contact */
		/*  END___RECORD	operatingcompany */
		/*  BEGIN_RECORD	listingcreationdate (t_date) */
			integer2 	summary_phones2_realtimephoneinfo_listingcreationdate_year;
			integer2 	summary_phones2_realtimephoneinfo_listingcreationdate_month;
			integer2 	summary_phones2_realtimephoneinfo_listingcreationdate_day;
		/*  END___RECORD	listingcreationdate */
		/*  BEGIN_RECORD	listingtransactiondate (t_date) */
			integer2 	summary_phones2_realtimephoneinfo_listingtransactiondate_year;
			integer2 	summary_phones2_realtimephoneinfo_listingtransactiondate_month;
			integer2 	summary_phones2_realtimephoneinfo_listingtransactiondate_day;
		/*  END___RECORD	listingtransactiondate */
		/*  BEGIN_RECORD	statusflag (t_ocstatus) */
			string   	summary_phones2_realtimephoneinfo_statusflag_code;
			string   	summary_phones2_realtimephoneinfo_statusflag_description;
		/*  END___RECORD	statusflag */
			string    summary_phones2_realtimephoneinfo_privacyindicator;
			string   	summary_phones2_realtimephoneinfo_datasource;
			string   	summary_phones2_realtimephoneinfo_latitude;
			string   	summary_phones2_realtimephoneinfo_longitude;
			string   	summary_phones2_realtimephoneinfo_fips;
			string   	summary_phones2_realtimephoneinfo_listingtype;
	/*  END___RECORD	realtimephoneinfo */
		string   	summary_phones2_ssn;
		string   	summary_phones2_ssnmatch;
	/*  BEGIN_RECORD	dod (t_date) */
		integer2 	summary_phones2_dod_year;
		integer2 	summary_phones2_dod_month;
		integer2 	summary_phones2_dod_day;
	/*  END___RECORD	dod */
		string1  	summary_phones2_deceased;
		boolean  	summary_phones2_yellowflag;
		string   	summary_phones2_probablecurrentaddress;
	/** BEGIN_DATASET	hriaddress */
		string4  	summary_phones2_hriaddress1_code;
		string150	summary_phones2_hriaddress1_description;
		string4  	summary_phones2_hriaddress2_code;
		string150	summary_phones2_hriaddress2_description;
	/** END___DATASET	hriaddress */
	/** BEGIN_DATASET	hriphone */
		string4  	summary_phones2_hriphone1_code;
		string150	summary_phones2_hriphone1_description;
		string4  	summary_phones2_hriphone2_code;
		string150	summary_phones2_hriphone2_description;
	/** END___DATASET	hriphone */
	/** BEGIN_DATASET	highriskindicators */
		string4  	summary_phones2_highriskindicators1_riskcode;
		string150	summary_phones2_highriskindicators1_description;
		string4  	summary_phones2_highriskindicators2_riskcode;
		string150	summary_phones2_highriskindicators2_description;
	/** END___DATASET	highriskindicators */
/** END___DATASET	phones */
/*  BEGIN_RECORD	dob (t_date) */
		integer2 	summary_dob_year;
		integer2 	summary_dob_month;
		integer2 	summary_dob_day;
/*  END___RECORD	dob */
		string3  	summary_age;
/** BEGIN_DATASET	emails */
		string128	summary_emails1_address;
		string128	summary_emails2_address;
/** END___DATASET	emails */
//*** END___LAYOUT ***	 
	END;
	
	
			
	//'TargetSummary'		
	
	export TargetSummary := record	
		in_key;
	//*******************	***********************************************
//*Layout Full Name :	iesp.verificationofoccupancy.t_VOOAddressTarget
//*Total # of Fields:	23
//*Layout Generated :	On 12/06/17 At 11:44:05 AM
//*******************	***********************************************
//*** BEGIN_LAYOUT ***	 
/*  BEGIN_RECORD	address (t_address) */
	string10 	TargetSummary_address_streetnumber;
	string2  	TargetSummary_address_streetpredirection;
	string28 	TargetSummary_address_streetname;
	string4  	TargetSummary_address_streetsuffix;
	string2  	TargetSummary_address_streetpostdirection;
	string10 	TargetSummary_address_unitdesignation;
	string8  	TargetSummary_address_unitnumber;
	string60 	TargetSummary_address_streetaddress1;
	string60 	TargetSummary_address_streetaddress2;
	string25 	TargetSummary_address_city;
	string2  	TargetSummary_address_state;
	string5  	TargetSummary_address_zip5;
	string4  	TargetSummary_address_zip4;
	string18 	TargetSummary_address_county;
	string9  	TargetSummary_address_postalcode;
	string50 	TargetSummary_address_statecityzip;
/*  END___RECORD	address */
string32 	TargetSummary_residentialorbusiness;
string32 	TargetSummary_type;
string128	TargetSummary_mixeduse;
/** BEGIN_DATASET	highriskindicators */
	string4  	TargetSummary_highriskindicators_riskcode1;
	string150	TargetSummary_highriskindicators_description1;
	string4  	TargetSummary_highriskindicators_riskcode2;
	string150	TargetSummary_highriskindicators_description2;
/** END___DATASET	highriskindicators */
string32 	TargetSummary_propertytype;
string32 	TargetSummary_propertycharacteristics;
//*** END___LAYOUT ***	 


end;
		
	
	
	
	
	
	
	
	
	
	//'Sources'		
	
		export Sources := record	
		in_key;

	//*******************	**************************************************
//*Layout Full Name :	iesp.verificationofoccupancy.t_VOOConfirmingSource
//*Total # of Fields:	8
//*Layout Generated :	On 12/06/17 At 11:53:52 AM
//*******************	**************************************************
//*** BEGIN_LAYOUT ***	 
string32 	source1;
/*  BEGIN_RECORD	from (t_date) */
	integer2 	source1_from_year;
	integer2 	source1_from_month;
	integer2 	source1_from_day;
/*  END___RECORD	from */
/*  BEGIN_RECORD	to (t_date) */
	integer2 	source1_to_year;
	integer2 	source1_to_month;
	integer2 	source1_to_day;
	integer2 	source1_count;
	
/*  END___RECORD	to */
string32 	source2;
integer2 	source2_from_year;
	integer2 	source2_from_month;
	integer2 	source2_from_day;
/*  END___RECORD	from */
/*  BEGIN_RECORD	to (t_date) */
	integer2 	source2_to_year;
	integer2 	source2_to_month;
	integer2 	source2_to_day;

integer2 	source2_count;
//*** END___LAYOUT ***	 

end;
	
	
	
	
	
	
	//'OwnedProperties'  
		export OwnedProperties := record	
		in_key;
	//*Layout Full Name :	iesp.verificationofoccupancy.t_VOOOtherOwnedProperty
//*Total # of Fields:	21
//*Layout Generated :	On 12/06/17 At 12:04:09 PM
//*******************	****************************************************
//*** BEGIN_LAYOUT ***	 
/*  BEGIN_RECORD	address (t_address) */
	string10 	OwnedProperties1_Address_streetnumber;
	string2  	OwnedProperties1_Address_streetpredirection;
	string28 	OwnedProperties1_Address_streetname;
	string4  	OwnedProperties1_Address_streetsuffix;
	string2  	OwnedProperties1_Address_streetpostdirection;
	string10 	OwnedProperties1_Address_unitdesignation;
	string8  	OwnedProperties1_Address_unitnumber;
	string60 	OwnedProperties1_Address_streetaddress1;
	string60 	OwnedProperties1_Address_streetaddress2;
	string25 	OwnedProperties1_Address_city;
	string2  	OwnedProperties1_Address_state;
	string5  	OwnedProperties1_Address_zip5;
	string4  	OwnedProperties1_Address_zip4;
	string18 	OwnedProperties1_Address_county;
	string9  	OwnedProperties1_Address_postalcode;
	string50  OwnedProperties1_Address_statecityzip;
/*  END___RECORD	address */
string16 	OwnedProperties1_status;
/*  BEGIN_RECORD	purchasedate (t_date) */
	integer2 	OwnedProperties1_purchasedate_year;
	integer2 	OwnedProperties1_purchasedate_month;
	integer2 	OwnedProperties1_purchasedate_day;
/*  END___RECORD	purchasedate */
string32 	OwnedProperties1_proximity;
//*** END___LAYOUT ***	 

string10 	OwnedProperties2_Address_streetnumber;
	string2  	OwnedProperties2_Address_streetpredirection;
	string28 	OwnedProperties2_Address_streetname;
	string4  	OwnedProperties2_Address_streetsuffix;
	string2  	OwnedProperties2_Address_streetpostdirection;
	string10 	OwnedProperties2_Address_unitdesignation;
	string8  	OwnedProperties2_Address_unitnumber;
	string60 	OwnedProperties2_Address_streetaddress1;
	string60 	OwnedProperties2_Address_streetaddress2;
	string25 	OwnedProperties2_Address_city;
	string2  	OwnedProperties2_Address_state;
	string5  	OwnedProperties2_Address_zip5;
	string4  	OwnedProperties2_Address_zip4;
	string18 	OwnedProperties2_Address_county;
	string9  	OwnedProperties2_Address_postalcode;
	string50  OwnedProperties2_Address_statecityzip;
/*  END___RECORD	address */
string16 	OwnedProperties2_status;
/*  BEGIN_RECORD	purchasedate (t_date) */
	integer2 	OwnedProperties2_purchasedate_year;
	integer2 	OwnedProperties2_purchasedate_month;
	integer2 	OwnedProperties2_purchasedate_day;
/*  END___RECORD	purchasedate */
string32 	OwnedProperties2_proximity;


	end;
	
	
	
	
	
//	'OwnedPropertiesAsOf' 
 		export OwnedPropertiesAsOf := record	
		in_key;
//*Layout Full Name :	iesp.verificationofoccupancy.t_VOOOtherOwnedProperty
//*Total # of Fields:	21
//*Layout Generated :	On 12/06/17 At 12:09:55 PM
//*******************	****************************************************
//*** BEGIN_LAYOUT ***	 
/*  BEGIN_RECORD	address (t_address) */
	string10 	OwnedPropertiesAsOf1_Address_streetnumber;
	string2  	OwnedPropertiesAsOf1_Address_streetpredirection;
	string28 	OwnedPropertiesAsOf1_Address_streetname;
	string4  	OwnedPropertiesAsOf1_Address_streetsuffix;
	string2  	OwnedPropertiesAsOf1_Address_streetpostdirection;
	string10 	OwnedPropertiesAsOf1_Address_unitdesignation;
	string8  	OwnedPropertiesAsOf1_Address_unitnumber;
	string60 	OwnedPropertiesAsOf1_Address_streetaddress1;
	string60 	OwnedPropertiesAsOf1_Address_streetaddress2;
	string25 	OwnedPropertiesAsOf1_Address_city;
	string2  	OwnedPropertiesAsOf1_Address_state;
	string5  	OwnedPropertiesAsOf1_Address_zip5;
	string4  	OwnedPropertiesAsOf1_Address_zip4;
	string18 	OwnedPropertiesAsOf1_Address_county;
	string9  	OwnedPropertiesAsOf1_Address_postalcode;
	string50 	OwnedPropertiesAsOf1_Address_statecityzip;
/*  END___RECORD	address */
string16 	OwnedPropertiesAsOf1_status;
/*  BEGIN_RECORD	purchasedate (t_date) */
	integer2 	OwnedPropertiesAsOf1_purchasedate_year;
	integer2 	OwnedPropertiesAsOf1_purchasedate_month;
	integer2 	OwnedPropertiesAsOf1_purchasedate_day;
/*  END___RECORD	purchasedate */
string32 	OwnedPropertiesAsOf1_proximity;
//*** END___LAYOUT ***	 

string10 	OwnedPropertiesAsOf2_Address_streetnumber;
	string2  	OwnedPropertiesAsOf2_Address_streetpredirection;
	string28 	OwnedPropertiesAsOf2_Address_streetname;
	string4  	OwnedPropertiesAsOf2_Address_streetsuffix;
	string2  	OwnedPropertiesAsOf2_Address_streetpostdirection;
	string10 	OwnedPropertiesAsOf2_Address_unitdesignation;
	string8  	OwnedPropertiesAsOf2_Address_unitnumber;
	string60 	OwnedPropertiesAsOf2_Address_streetaddress1;
	string60 	OwnedPropertiesAsOf2_Address_streetaddress2;
	string25 	OwnedPropertiesAsOf2_Address_city;
	string2  	OwnedPropertiesAsOf2_Address_state;
	string5  	OwnedPropertiesAsOf2_Address_zip5;
	string4  	OwnedPropertiesAsOf2_Address_zip4;
	string18 	OwnedPropertiesAsOf2_Address_county;
	string9  	OwnedPropertiesAsOf2_Address_postalcode;
	string50 	OwnedPropertiesAsOf2_Address_statecityzip;
/*  END___RECORD	address */
string16 	OwnedPropertiesAsOf2_status;
/*  BEGIN_RECORD	purchasedate (t_date) */
	integer2 	OwnedPropertiesAsOf2_purchasedate_year;
	integer2 	OwnedPropertiesAsOf2_purchasedate_month;
	integer2 	OwnedPropertiesAsOf2_purchasedate_day;
/*  END___RECORD	purchasedate */
string32 	OwnedPropertiesAsOf2_proximity;


	end;  

	
//	'PhoneAndUtility' 
	export PhoneAndUtility := record	
		in_key;
		//*Layout Full Name :	iesp.verificationofoccupancy.t_VOOPhoneAndUtility
//*Total # of Fields:	37
//*Layout Generated :	On 12/06/17 At 12:12:50 PM
//*******************	*************************************************
//*** BEGIN_LAYOUT ***	 
/** BEGIN_DATASET	targetrecords1 */
	string16 	PhoneAndUtility_targetrecords1_servicetype;
	/*  BEGIN_RECORD	name (t_name) */
		string62 	PhoneAndUtility_targetrecords1_name_full;
		string20 	PhoneAndUtility_targetrecords1_name_first;
		string20 	PhoneAndUtility_targetrecords1_name_middle;
		string20 	PhoneAndUtility_targetrecords1_name_last;
		string5  	PhoneAndUtility_targetrecords1_name_suffix;
		string3  	PhoneAndUtility_targetrecords1_name_prefix;
	/*  END___RECORD	name */
	/*  BEGIN_RECORD	from (t_date) */
		integer2 	PhoneAndUtility_targetrecords1_from_year;
		integer2 	PhoneAndUtility_targetrecords1_from_month;
		integer2 	PhoneAndUtility_targetrecords1_from_day;
	/*  END___RECORD	from */
	/*  BEGIN_RECORD	to (t_date) */
		integer2 	PhoneAndUtility_targetrecords1_to_year;
		integer2 	PhoneAndUtility_targetrecords1_to_month;
		integer2 	PhoneAndUtility_targetrecords1_to_day;
	/*  END___RECORD	to */
	string12 	PhoneAndUtility_targetrecords1_uniqueid;
	
	
	
	/** BEGIN_DATASET	targetrecords2 */
	string16 	PhoneAndUtility_targetrecords2_servicetype;
	/*  BEGIN_RECORD	name (t_name) */
		string62 	PhoneAndUtility_targetrecords2_name_full;
		string20 	PhoneAndUtility_targetrecords2_name_first;
		string20 	PhoneAndUtility_targetrecords2_name_middle;
		string20 	PhoneAndUtility_targetrecords2_name_last;
		string5  	PhoneAndUtility_targetrecords2_name_suffix;
		string3  	PhoneAndUtility_targetrecords2_name_prefix;
	/*  END___RECORD	name */
	/*  BEGIN_RECORD	from (t_date) */
		integer2 	PhoneAndUtility_targetrecords2_from_year;
		integer2 	PhoneAndUtility_targetrecords2_from_month;
		integer2 	PhoneAndUtility_targetrecords2_from_day;
	/*  END___RECORD	from */
	/*  BEGIN_RECORD	to (t_date) */
		integer2 	PhoneAndUtility_targetrecords2_to_year;
		integer2 	PhoneAndUtility_targetrecords2_to_month;
		integer2 	PhoneAndUtility_targetrecords2_to_day;
	/*  END___RECORD	to */
	string12 	PhoneAndUtility_targetrecords2_uniqueid;
/** END___DATASET	targetrecords */
/** BEGIN_DATASET	subjectrecords1 */
	string16 	PhoneAndUtility_subjectrecords1_servicetype;
	/*  BEGIN_RECORD	address (t_address) */
		string10 	PhoneAndUtility_subjectrecords1_Address_streetnumber;
		string2  	PhoneAndUtility_subjectrecords1_Address_streetpredirection;
		string28 	PhoneAndUtility_subjectrecords1_Address_streetname;
		string4  	PhoneAndUtility_subjectrecords1_Address_streetsuffix;
		string2  	PhoneAndUtility_subjectrecords1_Address_streetpostdirection;
		string10 	PhoneAndUtility_subjectrecords1_Address_unitdesignation;
		string8  	PhoneAndUtility_subjectrecords1_Address_unitnumber;
		string60 	PhoneAndUtility_subjectrecords1_Address_streetaddress1;
		string60 	PhoneAndUtility_subjectrecords1_Address_streetaddress2;
		string25 	PhoneAndUtility_subjectrecords1_Address_city;
		string2  	PhoneAndUtility_subjectrecords1_Address_state;
		string5  	PhoneAndUtility_subjectrecords1_Address_zip5;
		string4  	PhoneAndUtility_subjectrecords1_Address_zip4;
		string18 	PhoneAndUtility_subjectrecords1_Address_county;
		string9  	PhoneAndUtility_subjectrecords1_Address_postalcode;
		string50 	PhoneAndUtility_subjectrecords1_Address_statecityzip;
	/*  END___RECORD	address */
	/*  BEGIN_RECORD	from (t_date) */
		integer2 	PhoneAndUtility_subjectrecords1_from_year;
		integer2 	PhoneAndUtility_subjectrecords1_from_month;
		integer2 	PhoneAndUtility_subjectrecords1_from_day;
	/*  END___RECORD	from */
	/*  BEGIN_RECORD	to (t_date) */
		integer2 	PhoneAndUtility_subjectrecords1_to_year;
		integer2 	PhoneAndUtility_subjectrecords1_to_month;
		integer2 	PhoneAndUtility_subjectrecords1_to_day;
	/*  END___RECORD	to */
	/** BEGIN_DATASET	subjectrecords2 */
	string16 	PhoneAndUtility_subjectrecords2_servicetype;
	/*  BEGIN_RECORD	address (t_address) */
		string10 	PhoneAndUtility_subjectrecords2_Address_streetnumber;
		string2  	PhoneAndUtility_subjectrecords2_Address_streetpredirection;
		string28 	PhoneAndUtility_subjectrecords2_Address_streetname;
		string4  	PhoneAndUtility_subjectrecords2_Address_streetsuffix;
		string2  	PhoneAndUtility_subjectrecords2_Address_streetpostdirection;
		string10 	PhoneAndUtility_subjectrecords2_Address_unitdesignation;
		string8  	PhoneAndUtility_subjectrecords2_Address_unitnumber;
		string60 	PhoneAndUtility_subjectrecords2_Address_streetaddress1;
		string60 	PhoneAndUtility_subjectrecords2_Address_streetaddress2;
		string25 	PhoneAndUtility_subjectrecords2_Address_city;
		string2  	PhoneAndUtility_subjectrecords2_Address_state;
		string5  	PhoneAndUtility_subjectrecords2_Address_zip5;
		string4  	PhoneAndUtility_subjectrecords2_Address_zip4;
		string18 	PhoneAndUtility_subjectrecords2_Address_county;
		string9  	PhoneAndUtility_subjectrecords2_Address_postalcode;
		string50 	PhoneAndUtility_subjectrecords2_Address_statecityzip;
	/*  END___RECORD	address */
	/*  BEGIN_RECORD	from (t_date) */
		integer2 	PhoneAndUtility_subjectrecords2_from_year;
		integer2 	PhoneAndUtility_subjectrecords2_from_month;
		integer2 	PhoneAndUtility_subjectrecords2_from_day;
	/*  END___RECORD	from */
	/*  BEGIN_RECORD	to (t_date) */
		integer2 	PhoneAndUtility_subjectrecords2_to_year;
		integer2 	PhoneAndUtility_subjectrecords2_to_month;
		integer2 	PhoneAndUtility_subjectrecords2_to_day;
	/*  END___RECORD	to */
/** END___DATASET	subjectrecords */
//*** END___LAYOUT ***	 

	end;
	
	
//	'AssociatedIdentities'		
	export AssociatedIdentities := record	
	in_key;
	//*Layout Full Name :	iesp.verificationofoccupancy.t_VOOIdentity
//*Total # of Fields:	14
//*Layout Generated :	On 12/06/17 At 12:21:18 PM
//*******************	******************************************
//*** BEGIN_LAYOUT ***	 
string12 	AssociatedIdentities1_uniqueid;
/*  BEGIN_RECORD	name (t_name) */
	string62 	AssociatedIdentities1_name_full;
	string20 	AssociatedIdentities1_name_first;
	string20 	AssociatedIdentities1_name_middle;
	string20 	AssociatedIdentities1_name_last;
	string5  	AssociatedIdentities1_name_suffix;
	string3  	AssociatedIdentities1_name_prefix;
/*  END___RECORD	name */
/*  BEGIN_RECORD	from (t_date) */
	integer2 	AssociatedIdentities1_from_year;
	integer2 	AssociatedIdentities1_from_month;
	integer2 	AssociatedIdentities1_from_day;
/*  END___RECORD	from */
/*  BEGIN_RECORD	to (t_date) */
	integer2 	AssociatedIdentities1_to_year;
	integer2 	AssociatedIdentities1_to_month;
	integer2 	AssociatedIdentities1_to_day;
/*  END___RECORD	to */
string32 	AssociatedIdentities1_association;
//*** END___LAYOUT ***	 


string12 	AssociatedIdentities2_uniqueid;
/*  BEGIN_RECORD	name (t_name) */
	string62 	AssociatedIdentities2_name_full;
	string20 	AssociatedIdentities2_name_first;
	string20 	AssociatedIdentities2_name_middle;
	string20 	AssociatedIdentities2_name_last;
	string5  	AssociatedIdentities2_name_suffix;
	string3  	AssociatedIdentities2_name_prefix;
/*  END___RECORD	name */
/*  BEGIN_RECORD	from (t_date) */
	integer2 	AssociatedIdentities2_from_year;
	integer2 	AssociatedIdentities2_from_month;
	integer2 	AssociatedIdentities2_from_day;
/*  END___RECORD	from */
/*  BEGIN_RECORD	to (t_date) */
	integer2 	AssociatedIdentities2_to_year;
	integer2 	AssociatedIdentities2_to_month;
	integer2 	AssociatedIdentities2_to_day;
/*  END___RECORD	to */
string32 	AssociatedIdentities2_association;
//*** END___LAYOUT ***	 
		end;
		
		END;