
EXPORT layout_waterfall_phones_phone_shell := RECORD
	STRING15 	subj_phone_possible_timezone;	//Subject Phone Possible Timezone
	STRING15 	subj_phone_address_zipcode_timezone;	//Subject Phone Possible Timezone of Current Address Zip Code
	STRING15 	subj_timezone_match_flag;			//Flag to show timezone match for phone and zipcode
	STRING8 	subj_phone_ported_date;				//Subject Phone Ported Date: Possible Date phone was ported from landline.
	STRING3 	subj_phone_seen_freq;					//Subject Phone Seen Frequency: Number of times phone seen.
	STRING3 	subj_phone_age;								//Subject Phone Age of Record
	STRING1 	subj_phone_transient_flag;		//Subject Phone Transient Flag: Y-Phone Associated with Transient/Institutional Address; N-No Association
END;