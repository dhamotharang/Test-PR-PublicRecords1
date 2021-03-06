// Note: string literals should be limited to <= 20 chars (as defined by "file_id" in fcra/Layout_override_flag)

EXPORT FILE_ID := MODULE
  export string VEHICLE := 'mv';
  export string BANKRUPTCY := 'bk';
  // export string BANKRUPTCY_SEARCH := 'bk_search';  Deprecated (194120)  BANKRUPTCY should be used instead.
  export string LIEN := 'lien';
  export string CRIM := 'crim';
	export string OFFENDERS := 'offenders';
	export string OFFENDERS_PLUS := 'offenders_plus';
	export string OFFENSES := 'offenses';
	export string COURT_OFFENSES := 'court_offenses';
	export string PUNISHMENT := 'punishment';
	export string ACTIVITY := 'activity';
	export string ATF := 'atf';
	export string CCW	:= 'concealed_weapons';
	export string HUNTING_FISHING := 'hunting_fishing';
  // export string PROP_DEED   := 'property';
  // export string PROP_ASSESS := 'property';
  // export string PROP_SEARCH := 'property';
  // exact type of property record (assess./deed/mort.) can be identified by ln_fare_id, if needed.
  export string PILOT_REGISTRATION := 'pilot_registration';
  export string PILOT_CERTIFICATE := 'pilot_certificate';
  export string PROPERTY := 'property';
  export string SEARCH := 'property_search';
  export string DEED := 'deed';
  export string ASSESSMENT := 'assessment';
  export string WATERCRAFT := 'watercraft';
  export string WATERCRAFT_COASTGUARD := 'watercraft_cguard';
  export string WATERCRAFT_DETAILS := 'watercraft_details';
  export string AIRCRAFT := 'aircraft';
  export string AIRCRAFT_DETAILS := 'aircraft_details';
  export string AIRCRAFT_ENGINE := 'aircraft_engine';
  export string MARRIAGE := 'marriage_main';
  export string MARRIAGE_SEARCH := 'marriage_search';
  export string PROFLIC:= 'professional_license';
  export string STUDENT := 'student';
  export string STUDENT_ALLOY := 'student_alloy';
  export STRING AVM := 'avm';
	export string GONG := 'gong';
	export string IMPULSE := 'impulse';
	export string INFUTOR := 'infutor';
	export string ADVO := 'advo';
	export string PAW := 'paw';
	export string Email_Data := 'email_data';
	export string Inquiries := 'inquiries';
	export string SSN := 'ssn';
	export string HDR := 'header';
	export string UCC_PARTY := 'ucc_party';
	export string UCC := 'ucc_main';
	export string IBEHAVIOR_CONSUMER := 'ibehavior_consumer';
	export string IBEHAVIOR_PURCHASE := 'ibehavior_purchase';
	export string SO_MAIN := 'so_main';
	export string SO_OFFENSES := 'so_offenses';
	export string AVM_MEDIANS := 'avm_medians';
	export string MARI := 'proflic_mari';
	export string THRIVE := 'thrive';
	export string DID_DEATH := 'did_death';
	export string ADDRESSES := 'address_data';
END;
