/*2019-10-28T19:26:59Z (Hennigar, Jennifer (RIS-BCT))
CCPA-773
*/
IMPORT Address,BIPV2;

EXPORT Layouts := MODULE

  EXPORT Input := MODULE
	
		EXPORT raw_input	:= RECORD
			STRING2		record_type;
			STRING10	abms_id;
			STRING25	client_id;
			STRING4		board_code; // aka member_board_id
			STRING50	last_name;
			STRING50	first_name;
			STRING50	middle_name;
			STRING10	name_suffix;
			STRING1		gender;
			STRING1		birth_date_suppress_ind; // 0 - public, 1 - private
			UNSIGNED6	address_id;
			STRING100	org1; // aka address_line_1
			STRING100	line1; // aka address_line_2
			STRING100	line2; // aka address_line_3
			STRING100	line3; // aka address_line_4
			STRING30	city;
			STRING2		state;
			STRING20	full_zip;
			STRING50	country;
			STRING1		address_type; // H - home, P - professional, or blank
			STRING10	address_update_date;
			STRING1		address_suppress_ind; // 0 - public, 2 - street only, 3 - private
			STRING8		degree_id;
			STRING6		degree_code;
			STRING4		degree_year;
			STRING4		birth_year;
			STRING2		birth_month;
			STRING2		birth_day;
			STRING10	dod;
			STRING1		deceased_suppress_ind; // 0 - public, 1 - private
			STRING8		moc_cert_id;
			STRING1		cert_type_ind; // G - general, S - subspecialty
			STRING10	biog_cert_id;
			STRING1		recert_ind; // I - initial, R - recertification, D - designation
			STRING2		duration_type; // TL - time limited, L - lifetime, M - MOC
			STRING2		cert_month;
			STRING2		cert_day;
			STRING4		cert_year;
			STRING2		expiration_month;
			STRING2		expiration_day;
			STRING4		expiration_year;
			STRING10	reverification_date;
			STRING3		participation; // Y - yes, N - no, NR - not required - aka meetingMOCrequirements
			STRING8		MOCpathway_id;
			STRING2		cert_status_id;	
			STRING2		occupation_status;
			STRING4		occupation_status_notify_date;
			STRING10	npi;
		END;

		EXPORT Address := RECORD
			STRING8   biog_number;                  // Biography number.
			UNSIGNED6 address_id;                   // Identifies distinct address within a biog number, can
			                                        //   have multiple addresses for one biog_nbr (individual).
			UNSIGNED6 occurrence_number;            // not really needed.
			STRING2   state;                        // US State, Territory, Military if Country is null,
			                                        //   otherwise foreign state/province.
			STRING9   full_zip;                     // US Zip code.
			STRING60  org1;                         // First line of address. (Org) (Mainly Organization 1)
			STRING40  line1;                        // Second line of address. (Mainly Organization 2)
			STRING40  line2;                        // Third line of address.
			STRING40  line3;                        // Fourth line of address.
			STRING40  city;                         // US city, if Country field is empty it is a foreign city.
			STRING40  country;                      // Not used in all extracts, Country if foreign,
			                                        //   NULL (empty) if US address.
			STRING1   address_type;                 // P = Professional, S = Secondary,
			                                        //   C = Combination(Professional/home), H = Home
			STRING1   address_suppress_ind          // Y/N field.
		END;

		EXPORT BIOG := RECORD
			STRING8   biog_number;                  // Biography number.  Only one record per person.
			STRING2   birth_day;                    // Day of birth.
			STRING2   birth_month;                  // Month of birth.
			STRING4   birth_year;                   // Year of birth.
			STRING1   birth_date_suppress_ind;      // If value is set to "Y" birth day, month, and year shall
			                                        //   not be displayed anywhere and be only used for internal
																						  //   matching. (Suppressed data only included in special
																						  //   approved cases)
			STRING67  birth_city;                   // Birth city. (Where not suppressed, unless otherwise approved)
			STRING67  birth_state;                  // US birth state/Canadian province. (Where not suppressed,
			                                        //   unless otherwise approved)
			STRING67  birth_nation;                 // Birth nation, for United States entries value will be null
			                                        //   in most cases. (Where not suppressed, unless otherwise
																						  //   approved)
			STRING1   birth_location_suppress_ind;  // If value is set to "Y" birth city, state/province, and
			                                        //   nation shall not be displayed anywhere and be only used
																						  //   for internal matching. (Suppressed data only included in
																						  //   special approved cases)
			STRING40  first_name;                   // First name.
			STRING30  middle_name;                  // Middle name.
			STRING40  last_name;                    // Last name.
			STRING15  name_suffix;                  // Name suffix. (Jr, Sr, etc)
			STRING4   placement_cert;               // Used to sort, group and place diplomates in Elsevier
			                                        //   print book.
			STRING100 placement_city;               // Used to place person in Elsevier print book section,
			                                        //   chosen by diplomat, default is last chosen address
																						  //   city/state.
			STRING2   placement_state;              // Used to place person in Elsevier print book section,
			                                        //   chosen by diplomat, default is last chosen address
																						  //   city/state.
			STRING1   gender;                       // F=Female, M=Male, U=Gender unknown.
			                                        //   (For internal matching use only)
			STRING1   board_certified;              // Only applies when customer desires non-certified records
			                                        //   in data.  Those records with a value of Y are currently
																						  //   ABMS Board Certified, those with an N are not.
			STRING10  npi;                          // CMS Individual National Provider Identifier.  (Only
			                                        //   provided if specified in contract)
		END;

		EXPORT Career := RECORD
			STRING8   biog_number;                  // Biography number.
			UNSIGNED6 occurrence_number;            // Denotes distinct career records for a given biography
			                                        //   number.  Can have multiple Career records for biog_nbr.
			STRING100 specialty;                    // Specialty long name.
			STRING150 position;                     // Position descriptor. Examples: Res = Resident,
			                                        //   Fell = Fellowship, etc.
			STRING230 organization;                 // Hospital, school, or other organization.
			STRING70  city;                         // City (foreign or US).
			STRING70  state;                        // State or Foreign State/Province.
			STRING70  nation;                       // Nation.
			STRING4   from_year;                    // Start year of position.
			STRING4   to_year;                      // End year of position.
			STRING3   career_type;                  // AAP = Academic Appoinment, HAP = Hospital Appoinment,
			                                        //   TRA = Training
		END;

		EXPORT Cert := RECORD
			STRING8   biog_number;                  // Biography number.
			STRING3   biog_cert_id;                 // Unique indicator for certs in a given biog_nbr.  Can have
			                                        //   multiple certs for given biog_nbr.
			STRING100 cert_name;                    // Name of this Certificate/Subcertificate.
			STRING1   cert_type_ind;                // G = General Certificate, S = Subcertificate
			STRING1   recert_ind;                   // I = Initial Certification, R = Recertification
			STRING1   board_certified;              // Y = Cert./Subcert. is valid, N = Is not valid
			STRING4   cert_year;                    // Year certificate issued.
			STRING2   cert_month;                   // Month certificate issued.
			STRING2   cert_day;                     // Day certificate issued.
			STRING4   expiration_year;              // Year certificate expires.
			STRING2   expiration_month;             // Month certificate expires.
			STRING2   expiration_day;               // Day certificate expires.
			STRING4   reverification_year;          // Reverification year.
			STRING2   reverification_month;         // Reverification month.
			STRING2   reverification_day;           // Reverification day.
			STRING2   duration_type;                // L = Lifetime Certificate (never expires), TL = Time
			                                        //   Limited Certificate, M = Maintenance of Certification
			STRING100 board_web_desc;               // Board that granted certificate.
			STRING8   cert_id;                      // ABMS Certificate ID, corresponds with CERTIFICATE_NAME.
			STRING8   mocpathway_id;                // MOC Pathway ID.  Present when record is a MOC Pathway.
			STRING200 mocpathway_name;              // MOC Pathway name, corresponds with MOCPATHWAY_ID.
		END;

		EXPORT Contact := RECORD
			STRING8   biog_number;                  // Biography number.
			UNSIGNED6 address_id;                   // Used to link to a corresponding address with ADDR_ID
			                                        //   in Address table.  Can have multiple contact records
																						  //   per biog/address.
			UNSIGNED6 occurrence_number;            // Distinct within a given biog_nbr/addr_id in Contact.
			STRING6   contact_type;                 // PH = Phone, WS = Website
			STRING250 description;                  // If Type = 'WS' then DESCR holds website.  If Area_code,
			                                        //   Exchange, and Phone_last_four are NULL(empty) DESCR
																						  //   holds a foreign phone number.
			STRING3   area_code;                    // Phone area code.
			STRING3   exchange;                     // Phone Exchange.
			STRING4   phone_last_four;              // Phone last four digits.
		END;

    // NOTE: The existence of someone in this file means they're dead, even if the dod is NULL.
		EXPORT Deceased := RECORD
			STRING8   biog_number;                  // Biography number.
			STRING10  dod;                          // Date of death received from the ABMS if available.
		END;

		EXPORT Education := RECORD
			STRING8   biog_number;                  // Biography number.
			UNSIGNED6 occurrence_number;            // Designates distinct education records for given biog_nbr,
			                                        //   can have multiple education records for a biog_nbr.
			STRING150 degree;                       // Diplomat degree/s, typically one degree, can have
			                                        //   multiple, not always medical degree.
			STRING5   abms_school_code;             // School code for school attended, use Zschool table for
			                                        //   lookup.
			STRING150 school;                       // Name of school if school code is not provided, typically
			                                        //   medical school.
			STRING75  years;                        // Year degree obtained.
			STRING25  city;                         // City.
			STRING67  state;                        // State.
			STRING40  country;                      // Country.
		END;

		EXPORT Membership := RECORD
			STRING8   biog_number;                  // Biography number.
			STRING125 member_of;                    // Organization the person is a member of, usually an
			                                        //   acronym, can be the full organization name.
			STRING125 position_held_years;          // Optional, name of position and/or years,
			                                        //   Examples: "Pres 93-95" "Member 90, VP 93, Pres 95".
		END;

		EXPORT MOCParticipation := RECORD
			STRING8   biog_number;                  // Biography number.
			STRING4   board_code;                   // Board code we assign, part of Primary Key.
			STRING100 board_name;                   // Board that granted MOC.
			STRING1   participation;                // Y indicates participation in MOC; N indicates given record
			                                        //   not participating; If a given record is not present then
																						  //   status is not reported;  NR indicates given record is
																						  //   not required to participate in MOC.  For Pediatrics and
																						  //   a small number of Internal Medicine records the MOC
																						  //   information is reported in the Certification data as
																						  //   has been done previously.
			STRING8   moc_cert_id;                  // ABMS CERTIFICATE_ID this MOC Participation applies to.
			STRING100 moc_cert_name;                // Name of the Certificate/Subcertificate that this MOC
			                                        //   Participation record applies to.
		END;

		EXPORT TypeOfPractice := RECORD
			STRING8   biog_number;                  // Biography number.
			STRING60  type_of_practice;             // Can have more than one career type for a biog_nbr (person).
			                                        //   Describes the type of position the individual holds.
																						  //   Cannot have more than one of the same type per person.
			STRING100 other_text;
		END;

		EXPORT Schools := RECORD
			STRING5   abms_school_code;             // School code (used to match with education records), code 99999
			                                        //   is unknown school.
			STRING150 school_name;                  // School name. (can include location also such as city)
			// NO ABBREVIATION IN EVAL DATA, BUT EXISTS IN REAL DATA
			STRING100 school_name_abbrev;           // School name abbreviation.
			STRING40  city;                         // City.
			STRING67  state;                        // State or Foreign State/Province.
			STRING70  country;                      // Country.
		END;

    EXPORT Specialty := RECORD
		  STRING11  code;                         // Specialty code.
			STRING25  description;                  // Specialty short name.
			STRING100 long_desc;                    // Specialty long name.
		END;

	END;

	EXPORT Miscellaneous := MODULE
	
		EXPORT Cleaned_Phone := RECORD
			STRING10 phone;
		END;
		
	END;

	EXPORT Lookups := MODULE
	
		EXPORT Specialty := RECORD
			STRING100 specialty := '';
			STRING8   sub_specialty_id := '';
			STRING100 sub_specialty := '';
		END;
		
	END;

  EXPORT Base := MODULE

    EXPORT Main := RECORD
			Input.BIOG;
			Input.Deceased - [biog_number];
			Input.MOCParticipation - [biog_number];
			Input.Address - [biog_number, occurrence_number];
			Input.Contact - [biog_number, address_id, occurrence_number];
			UNSIGNED6 address_occurrence_number;
			UNSIGNED6 contact_occurrence_number;
      STRING8   dob;
      STRING1   dead_ind;                     // Y/N
			STRING60  org_name;                     // Mirror image of org1
			STRING40  additional_org_text;          // Mirror image of line1
			STRING40  address1;                     // Mirror image of line2
			STRING40  address2;                     // Mirror image of line3
			STRING10  phone_number;
			STRING    website;
			UNSIGNED4 dt_vendor_first_reported;
			UNSIGNED4 dt_vendor_last_reported;
			STRING1   record_type;
			STRING    board_source;
			UNSIGNED8 raw_aid;
			UNSIGNED8 ace_aid;
			UNSIGNED6 did;
			UNSIGNED6 bdid;
			UNSIGNED1 bdid_score;
			UNSIGNED8 lnpid;
			UNSIGNED8 source_rec_id;
			Address.Layout_Clean182_fips clean_company_address;
			Address.Layout_Clean_Name    clean_name;
			Miscellaneous.Cleaned_Phone  clean_phone;
			STRING    address_type_desc;
			BIPV2.IDlayouts.l_xlink_ids ;
			unsigned4 								global_sid					:= 23941; // Source ID for ABMS - CCPA project 20190910  
			unsigned8 								record_sid; 
		END;

    EXPORT Career := RECORD
			Input.Career;
			UNSIGNED4 dt_vendor_first_reported;
			UNSIGNED4 dt_vendor_last_reported;
			STRING1   record_type;
      STRING    career_type_desc;             // AAP = Academic Appoinment, HAP = Hospital Appoinment,
			                                        //   TRA=Training		
		END;

    EXPORT Cert := RECORD
			Input.Cert;
      STRING8   cert_date;
			STRING8   expiration_date;
			STRING8   reverification_date;
			UNSIGNED4 dt_vendor_first_reported;
			UNSIGNED4 dt_vendor_last_reported;
			STRING1   record_type;
      STRING    cert_type_ind_desc;           // G = General Certificate, S = Subcertificate
      STRING    recert_ind_desc;              // I = Initial Certification, R = Recertification
      STRING    duration_type_desc;           // L = Lifetime Certificate (never expires), TL = Time
			                                        //   Limited Certificate, M = Maintenance of Certification
		END;

    EXPORT Education := RECORD
      Input.Education;		
			UNSIGNED4 dt_vendor_first_reported;
			UNSIGNED4 dt_vendor_last_reported;
			STRING1   record_type;
			STRING    abms_school_code_desc;        // Comes from zschools lookup (Schools input).
			STRING    abms_school_code_desc_abbrev; // Comes from zschools lookup (Schools input).
		END;

    EXPORT Membership := RECORD
		  Input.Membership;
			UNSIGNED4 dt_vendor_first_reported;
			UNSIGNED4 dt_vendor_last_reported;
			STRING1   record_type;
		END;

    EXPORT TypeOfPractice := RECORD
			Input.TypeOfPractice;
			UNSIGNED4 dt_vendor_first_reported;
			UNSIGNED4 dt_vendor_last_reported;
			STRING1   record_type;
		END;

  END;

	EXPORT KeyBuild := MODULE

	  EXPORT Main := RECORD
		  Base.Main - source_rec_id -BIPV2.IDlayouts.l_xlink_ids;
		END;

		EXPORT Main_Specialty := RECORD
			Main;
		  Input.Career.specialty;
		END;

		EXPORT Main_Cert := RECORD
			Main;
		  Input.Cert.cert_name;
		  Input.Cert.cert_type_ind;
		END;
    
		EXPORT Main_Lnpid := record
      unsigned8 lnpid;		  
			STRING8   biog_number;
		end;
	END;

END;
