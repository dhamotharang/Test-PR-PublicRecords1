
EXPORT interfaces := MODULE

	EXPORT layout_entity := RECORD
		STRING30  firstname;
		STRING30  middlename;
		STRING30  lastname;
		STRING120 unparsedfullname;
		BOOLEAN   allownicknames;
		BOOLEAN   phoneticmatch;
		STRING120 companyname;
		STRING200 addr;
		STRING10  sec_range;
		STRING25  city;
		STRING2   state;
		STRING6   zip;
		UNSIGNED2 zipradius;
		STRING30  county;
		STRING15  phone;
		STRING11  fein;
		STRING    bdid;
		STRING14  did;
		STRING11  ssn;
	END;
	
	EXPORT Iinput_report := INTERFACE
	
		// Search fields
		EXPORT STRING12 faresID;
		
		// Data restrictions
		EXPORT SET OF STRING1 srcRestrict;
		EXPORT SET OF STRING2 set_AddressFilters;
		EXPORT STRING  data_restriction_mask;
		EXPORT BOOLEAN currentVend;
		EXPORT BOOLEAN currentOnly;
		EXPORT BOOLEAN robustnessScoreSorting;
		EXPORT STRING  ssn_mask_value;
		EXPORT STRING  application_type_value;	
		EXPORT BOOLEAN paSearch;
		
		// Tuning
		EXPORT BOOLEAN   DisplayMatchedParty_val;
		EXPORT UNSIGNED2 pThresh;
		EXPORT STRING10  lookupVal;
		EXPORT STRING10  partyType;
		EXPORT BOOLEAN   incDetails;
		EXPORT BOOLEAN   TwoPartySearch;
		EXPORT UNSIGNED2 xadl2_weight_threshold_value;
		
		// For penalization
		EXPORT layout_entity entity1;
		EXPORT layout_entity entity2;
	END;
	
END;