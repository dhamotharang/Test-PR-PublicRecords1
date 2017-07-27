// This module defines the input interface for the penalty calculations contained
// in the LIB_ attributes.
Import AutoStandardI;
EXPORT LIBIN := MODULE

	// This module defines the input interface for the address penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_Addr := MODULE
		EXPORT base := INTERFACE(
			AutoStandardI.InterfaceTranslator.city_value.params,
			AutoStandardI.InterfaceTranslator.other_city_value.params,
			AutoStandardI.InterfaceTranslator.input_city_value.params,
			AutoStandardI.InterfaceTranslator.zipradius_value.params,
			AutoStandardI.InterfaceTranslator.state_value.params,
			AutoStandardI.InterfaceTranslator.prev_state_val1l.params,
			AutoStandardI.InterfaceTranslator.prev_state_val2l.params,
			AutoStandardI.InterfaceTranslator.zip_value.params,
			AutoStandardI.InterfaceTranslator.zip_val.params,
			AutoStandardI.InterfaceTranslator.city_zip_value.params,
			AutoStandardI.InterfaceTranslator.zip_value_cleaned.params,
			AutoStandardI.InterfaceTranslator.predir_value.params,
			AutoStandardI.InterfaceTranslator.postdir_value.params,
			AutoStandardI.InterfaceTranslator.addr_suffix_value.params,
			AutoStandardI.InterfaceTranslator.pname_wild.params,
			AutoStandardI.InterfaceTranslator.pname_wild_val.params,
			AutoStandardI.InterfaceTranslator.pname_value.params,
			AutoStandardI.InterfaceTranslator.prange_value.params,
			AutoStandardI.InterfaceTranslator.sec_range_value.params,
			AutoStandardI.InterfaceTranslator.addr_range.params,
			AutoStandardI.InterfaceTranslator.prange_beg_value.params,
			AutoStandardI.InterfaceTranslator.prange_end_value.params,
			AutoStandardI.InterfaceTranslator.addr_wild.params,
			AutoStandardI.InterfaceTranslator.prange_wild_value.params,
			AutoStandardI.InterfaceTranslator.county_value.params)
		END;
		EXPORT full := INTERFACE(base)
			export boolean useGlobalScope;
			export boolean allow_wildcard;
			export string prange_field;
			export string sec_range_field := '';
			export string predir_field;
			export string pname_field;
			export string suffix_field;
			export string postdir_field;
			export string city_field;
			export string city2_field;
			export string state_field;
			export string zip_field;
		END;
	END;

	// This module defines the input interface for the BDID penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_BDID := MODULE
		EXPORT base := INTERFACE(AutoStandardI.InterfaceTranslator.bdid_value.params)
		END;
		EXPORT full := INTERFACE(base)
			EXPORT STRING bdid_field;
		END;
	END;

	EXPORT PenaltyI_BusinessIds := MODULE
		EXPORT base := INTERFACE(
				AutoStandardI.InterfaceTranslator.ultid_value.params,
				AutoStandardI.InterfaceTranslator.orgid_value.params,
				AutoStandardI.InterfaceTranslator.seleid_value.params,
				AutoStandardI.InterfaceTranslator.proxid_value.params,
				AutoStandardI.InterfaceTranslator.powid_value.params,
				AutoStandardI.InterfaceTranslator.empid_value.params,
				AutoStandardI.InterfaceTranslator.dotid_value.params)
		END;
		EXPORT full := INTERFACE(base)
			EXPORT UNSIGNED6 ultid_field;
			EXPORT UNSIGNED6 orgid_field;
			EXPORT UNSIGNED6 seleid_field;
			EXPORT UNSIGNED6 proxid_field;
			EXPORT UNSIGNED6 powid_field;
			EXPORT UNSIGNED6 empid_field;
			EXPORT UNSIGNED6 dotid_field;
		END;
	END;
	
	// This module defines the input interface for the business name penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_Biz_Name := MODULE
		EXPORT base := INTERFACE(AutoStandardI.InterfaceTranslator.comp_name_value.params)
		END;
		EXPORT full := INTERFACE(base)
			EXPORT STRING cname_field;
		END;
	END;

	// This module defines the input interface for the county penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_County := MODULE
		EXPORT base := INTERFACE(AutoStandardI.InterfaceTranslator.county_value.params)
		END;
		EXPORT full := INTERFACE(base)
			EXPORT STRING county_field;
		END;
	END;

	// This module defines the input interface for the DID penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_DID := MODULE
		EXPORT base := INTERFACE(AutoStandardI.InterfaceTranslator.did_value.params)
		END;
		EXPORT full := INTERFACE(base)
			EXPORT STRING did_field;
		END;
	END;

	// This module defines the input interface for the date of birth penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_DOB := MODULE
		EXPORT base := INTERFACE(
			AutoStandardI.InterfaceTranslator.dob_val.params,
			AutoStandardI.InterfaceTranslator.agelow_val.params,
			AutoStandardI.InterfaceTranslator.agehigh_val.params)
		END;
		EXPORT full := INTERFACE(base)
			export string dob_field;
		END;
	END;

	// This module defines the input interface for the date of death penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_DOD := MODULE
		EXPORT base := INTERFACE(
			AutoStandardI.InterfaceTranslator.dod_value.params,
			AutoStandardI.InterfaceTranslator.agelow_val.params,
			AutoStandardI.InterfaceTranslator.agehigh_val.params)
		END;
		EXPORT full := INTERFACE(base)
			export string dod_field;
		END;
	END;

	// This module defines the input interface for the FEIN penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_FEIN := MODULE
		EXPORT base := INTERFACE(
			AutoStandardI.InterfaceTranslator.fein_val.params,
			AutoStandardI.InterfaceTranslator.score_threshold_value.params)
		END;
		EXPORT full := INTERFACE(base)
			EXPORT STRING fein_field;
		END;
	END;

	// This module defines the input interface for the individual name penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_Indv_Name := MODULE
		EXPORT base := INTERFACE(
			AutoStandardI.InterfaceTranslator.lname_value.params,
			AutoStandardI.InterfaceTranslator.lname_set_value.params,
			AutoStandardI.InterfaceTranslator.fname_value.params,
			AutoStandardI.InterfaceTranslator.fname_set_value.params,
			AutoStandardI.InterfaceTranslator.mname_value.params,
			AutoStandardI.InterfaceTranslator.lname4_value.params,
			AutoStandardI.InterfaceTranslator.fname3_value.params,
			AutoStandardI.InterfaceTranslator.lname_wild.params,
			AutoStandardI.InterfaceTranslator.fname_wild.params,
			AutoStandardI.InterfaceTranslator.lname_wild_val.params,
			AutoStandardI.InterfaceTranslator.fname_wild_val.params,
			AutoStandardI.InterfaceTranslator.phonetics.params,
			AutoStandardI.InterfaceTranslator.usePhoneticDistance.params,
			AutoStandardI.InterfaceTranslator.non_exclusion_value.params,
			AutoStandardI.InterfaceTranslator.BpsLeadingNameMatch_value.params,
			AutoStandardI.InterfaceTranslator.lname_trailing_value.params,
			AutoStandardI.InterfaceTranslator.fname_trailing_value.params)
		END;
		EXPORT full := INTERFACE(base)
			export boolean allow_wildcard;
			export string fname_field;
			export string mname_field;
			export string lname_field;
		END;
	END;

	// This module defines the input interface for the phone penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_Phone := MODULE
		EXPORT base := INTERFACE(
			AutoStandardI.InterfaceTranslator.phone_value.params,
			AutoStandardI.InterfaceTranslator.score_threshold_value.params)
		END;
		EXPORT full := INTERFACE(base)
			EXPORT STRING phone_field;
		END;
	END;

	// This module defines the input interface for the SSN penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_SSN := MODULE
		EXPORT base := INTERFACE(
			AutoStandardI.InterfaceTranslator.ssn_value.params,
			AutoStandardI.InterfaceTranslator.score_threshold_value.params,
			AutoStandardI.InterfaceTranslator.ssnfallback_value.params)
		END;
		EXPORT full := INTERFACE(base)
			EXPORT STRING ssn_field;
		END;
	END;

	// This module defines the input interface for the business penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_Biz := MODULE
		EXPORT base := INTERFACE(
			PenaltyI_Biz_Name.base,
			PenaltyI_Addr.base,
			PenaltyI_FEIN.base,
			PenaltyI_BDID.base,
			PenaltyI_County.base,
			PenaltyI_Phone.base)
		END;
		EXPORT full := INTERFACE(
			PenaltyI_Biz_Name.full,
			PenaltyI_Addr.full,
			PenaltyI_FEIN.full,
			PenaltyI_BDID.full,
			PenaltyI_County.full,
			PenaltyI_Phone.full)
		END;
	END;

	// This module defines the input interface for the individual penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI_Indv := MODULE
		EXPORT base := INTERFACE(
			PenaltyI_Indv_Name.base,
			PenaltyI_Addr.base,
			PenaltyI_SSN.base,
			PenaltyI_DID.base,
			PenaltyI_DOB.base,
			PenaltyI_County.base,
			PenaltyI_Phone.base)
		END;
		EXPORT full := INTERFACE(
			PenaltyI_Indv_Name.full,
			PenaltyI_Addr.full,
			PenaltyI_SSN.full,
			PenaltyI_DID.full,
			PenaltyI_DOB.full,
			PenaltyI_County.full,
			PenaltyI_Phone.full)
		END;
	END;

	// This module defines the input interface for the penalty calculation.
	// The base interface is designed to contain search criteria input by the user
	// or values derived therefrom.  The full interface is designed to contain that
	// same information, plus data from our data store.
	EXPORT PenaltyI := MODULE
		EXPORT base := INTERFACE(
			PenaltyI_Biz_Name.base,
			PenaltyI_Indv_Name.base,
			PenaltyI_Addr.base,
			PenaltyI_FEIN.base,
			PenaltyI_SSN.base,
			PenaltyI_BDID.base,
			PenaltyI_DID.base,
			PenaltyI_DOB.base,
			PenaltyI_County.base,
			PenaltyI_Phone.base)
		END;
		EXPORT full := INTERFACE(
			PenaltyI_Biz_Name.full,
			PenaltyI_Indv_Name.full,
			PenaltyI_Addr.full,
			PenaltyI_FEIN.full,
			PenaltyI_SSN.full,
			PenaltyI_BDID.full,
			PenaltyI_DID.full,
			PenaltyI_DOB.full,
			PenaltyI_County.full,
			PenaltyI_Phone.full)
		END;
	END;
END;
