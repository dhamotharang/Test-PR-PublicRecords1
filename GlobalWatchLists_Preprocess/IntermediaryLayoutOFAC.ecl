EXPORT IntermediaryLayoutOFAC := MODULE

EXPORT rPrimary := RECORD
  string10 		orig_sdn_id;
  string100 	orig_first_name;
  string150 	orig_last_name;
  string150 	orig_title;
  string10 		orig_aka_id;
  string10 		orig_aka_type;
  string10 		orig_aka_category;
  string1 		orig_giv_designator;
  string20 		orig_entity_type;
  string1000 	orig_remarks;
  string10 		orig_call_sign;
  string30 		orig_vessel_type;
  string10 		orig_tonnage;
  string10 		orig_gross_registered_tonnage;
  string60 		orig_vessel_flag;
  string100 	orig_vessel_owner;
	string			orig_raw_name;
END;

EXPORT rProgramChild := RECORD
  string20 		orig_program;
END;

EXPORT rProgram := RECORD
  string10 		orig_sdn_id;
  DATASET(rProgramChild) PrgChild;
END;

EXPORT rAddress := RECORD
  string10 	orig_sdn_id;
  string10 	orig_address_id;
  string150 orig_address_line_1;
  string150 orig_address_line_2;
  string150 orig_address_line_3;
  string75 	orig_address_city;
  string25 	orig_address_state_province;
  string20 	orig_address_postal_code;
  string60 	orig_address_country;
END;

EXPORT rIDChild := RECORD
	string150 orig_id_id;
	string600 orig_id_type;
	string450 orig_id_number;
	string900 orig_id_country;
	string300 orig_id_issue_date;
	string300 orig_id_expiration_date;
END;
		 
EXPORT rID := RECORD
	string10 	orig_sdn_id;
	DATASET(rIDChild) IDChild;
END;

EXPORT rNationalityChild := RECORD
	string100 orig_nationality_id;
  string600 orig_nationality;
  string10 	orig_primary_nationality_flag;
END;

EXPORT rNationality := RECORD
  string10 	orig_sdn_id;
  DATASET(rNationalityChild) NationalityChild;
END;

EXPORT rCitizenshipChild := RECORD
	string100 orig_Citizenship_id;
  string600 orig_Citizenship;
  string10 	orig_primary_Citizenship_flag;
END;

EXPORT rCitizenship := RECORD
  string10 	orig_sdn_id;
  DATASET(rCitizenshipChild) CitizenshipChild;
END;

EXPORT rDOBChild := RECORD
	string100 orig_dob_ID;
  string200 orig_dob;
  string10 	orig_primary_DOB_flag;
END;

EXPORT rDOB := RECORD
  string10 	orig_sdn_id;
  DATASET(rDOBChild) DOBChild;
END;

EXPORT rPOBChild := RECORD
	string100 orig_pob_id;
  string800 orig_pob;
  string10 	orig_primary_pob_flag;
END;

EXPORT rPOB := RECORD
  string10 	orig_sdn_id;
	DATASET(rPOBChild) POBChild;
end;

END;