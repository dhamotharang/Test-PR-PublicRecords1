EXPORT Layout_OptOut_Base := RECORD

	UNSIGNED4						dt_first_seen;
	UNSIGNED4						dt_last_seen;
	UNSIGNED4						dt_vendor_first_reported;
	UNSIGNED4						dt_vendor_last_reported;
	UNSIGNED4						process_date;
	STRING1								history_flag;	//blank: current, H: Historical
	STRING1								src;								//M for Minor file, C for Consumer Center
	STRING30 						ENTRY_TYPE;			//OPTOUT – standard Opt Out Request,DELETE – standard Delete Request,Other types may be defined in the future
	UNSIGNED8 					LEXID;						//LEXID of consumer opting out
	STRING1								PROF_DATA;	
	STRING20							DOMAIN_ID;			//Include Healthcare professional data (Y/N)
	STRING2								STATE_ACT;			//state abbreviation of the act under which this consumer has opted out “CA” for CCPA
	UNSIGNED8 					exemptions;			//Exemption mask used by query
	STRING10 						act_id;
	STRING8 							date_added;
	STRING100						VERIFIED_EMAIL;//DF-28437 - MBS extract adds email address field
	SET OF UNSIGNED4	global_sids;
	UNSIGNED8 					rcid;
	
END;

