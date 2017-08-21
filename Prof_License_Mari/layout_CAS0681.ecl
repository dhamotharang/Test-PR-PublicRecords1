// CAS0681 / California Dept of Real Estate/ Mortgage Lenders //

/* export layout_CAS0681 := RECORD
   	string1    multiple_license_indicator                                                      ;
   	string1    record_type;
   	string80   name_1;
   	string80   name_2;
   	string50   address_1;
   	string50   address_2;
   	string40   city;
   	string2    state;
   	string9    zip_code;
   	string30   foreign_nation;
   	string20   foreign_postal_info;
   	string20   license_number;
   	string1    license_type;
   	string1    license_status;
   	string1    restricted_flag;
   	string8    license_effective_date;
   	string8    license_expiration_date;
   	string2    county_code;
   	string1    misc_indicator;
   	string20   secondary_id_number;
   	string1    ethics_and_agency_ind;
   END;
*/

//New Layout
EXPORT layout_CAS0681 := RECORD
	STRING1 		multiple_license_ind;			//multiple_license_ind. N = first record for this licensee. Y = otherwise
	STRING80		lastname_primary;					//lastname_primary. Last name of a licensee if license type is "Person", or primary
																				//name of a corporation if license type is corporation
	STRING80		firstname_secondary;			//firstname_secondary. First name of a licensee if license type is Person, or secondary
																				//name of a cororation if license type is corporation
	STRING10		name_suffix;							//name_suffix
	STRING20		license_number;						//lic_number. Licensee's license number.
	STRING20		license_type;							//lic_type. It can be Broker, Corporation, Officer, or Salesperson
	STRING20		license_status;						//lic_status. It can be licensed, or licensed NBA.
																				//licensed - salesperson in the employ of a broker, or broker/corp business address on file, or officer affiliated with a corp.
																				//licensed nba - salesperson w/o broker affil; or broker/corp w/o business addr on file
	STRING8			license_effective_date;		//lic_effective_date
	STRING8			license_expiration_date;	//lic_expiration_date
	STRING20		rel_lic_number;						//rel_lic_number. For salesperson = employing broker's license number
																				//								For officer			= affiliated corporation license number
																				//								For corporation = designated officer license number
	STRING80		empl_lastname_primary;		//empl_lastname_primary. For salesperson, employer's last/primary name.
	STRING80		empl_firstname_secondary;	//empl_firstname_secondary. For salesperson, employer's first/secondary name.
	STRING10		empl_name_suffix;					//empl_name_suffix. For salesperson, employer's suffix
	STRING80		officer_lastname;					//officerlastname.  For corporattion	= designated officer's last name
																				//								  For officer				= the primary name of the affiliated corporation
	STRING80		officer_firstname;				//officerfirstname. For corporattion	= designated officer's first name
																				//								  For officer				= the secondary name of the affiliated corporation
	STRING10		officer_suffix;						//officersuffixname. For corporation	= designated officer's suffix
	STRING20		rel_license_type;					//rel_lic_type; For salesperson = Employing broker's license type
																				//							For officer		  = Affiliated corporation license type
																				//							For corporation = Designated officer license type
	STRING50		address_1;								//address_1.
	STRING50		address_2;								//address_2.
	STRING40		city;											//city
	STRING2			state;										//state
	STRING9			zip_code;									//zip_code
	STRING30		foreign_nation;						//foreign_nation
  STRING20		foreign_postal_info;			//foreign_postal_info
  STRING2    	county_code;							//county_code. 2 digit county code
	STRING50		county_name;							//county_name
  STRING1    	restricted_flag;					//restricted_flag. Y = license is restricted.
  STRING1    	misc_indicator;						//misc_indicator. C = 18 month Conditional license.
  STRING1   	ethics_and_agency_ind;		//ethics_and_agency_ind. Y = Requires only Ethics,Agency, Trust Fund, & Fair Housing continuing education on next renewal
END;
