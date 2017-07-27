IMPORT iesp, Risk_Indicators, Models, header, doxie;

EXPORT Layouts := MODULE

EXPORT Layout_VOOAttributesV1 := RECORD
	String2 	AddressReportingSourceIndex;
	String2 	AddressReportingHistoryIndex;
	String2 	AddressSearchHistoryIndex;
	String2 	AddressUtilityHistoryIndex;
	String2 	AddressOwnershipHistoryIndex;
	String2 	AddressPropertyTypeIndex;
	String2 	AddressValidityIndex; 
	String2 	RelativesConfirmingAddressIndex;
	String2 	AddressOwnerMailingAddressIndex;
	String2 	PriorAddressMoveIndex;
	String2 	PriorResidentMoveIndex;
	String6 	AddressDateFirstSeen;
	String6 	AddressDateLastSeen;
	String2 	OccupancyOverride;
	String2 	InferredOwnershipTypeIndex;
	String5   OtherOwnedPropertyProximity;
	String2   VerificationOfOccupancyScore;
END;


EXPORT Layout_VOOAttributes := RECORD
	Layout_VOOAttributesV1 version1;
END;


EXPORT Subject_Addresses := RECORD
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 city_name;
	STRING18 county;
	STRING2  st;
	STRING5  z5;
	STRING10 lat := '';
	STRING11 long := '';
	REAL		 DistanceFromTarget := -1;
	STRING8	 Date := '';
	STRING7  AddressStatus := ''; // Contains TARGET, CURRENT, OTHER
	STRING1	 DwellingType := '';
	STRING4	 AddrCleanerStatus := '';
	DATASET(Risk_Indicators.Layout_Desc) HRIAddress; // HRI Address (SIC Codes/Descriptions)
	STRING1	 ADVOResidentialBusiness := '';
	STRING1	 ADVOType := '';
	STRING1	 ADVOMixedUse := '';
	BOOLEAN	 ADVOVacant := FALSE;
	BOOLEAN	 ADVOSeasonal := FALSE;
	BOOLEAN	 InvalidAddress := FALSE;
	BOOLEAN	 CorrectionalFacility := FALSE;
END;


EXPORT Watchdog_Best := RECORD
	UNSIGNED8 LexID := 0;
	STRING5 Title := '';
	STRING20 FName := '';
	STRING20 MName := '';
	STRING20 LName := '';
	STRING5 Suffix := '';
	STRING8 DOB := '';
	UNSIGNED1 Age := 0;
END;


EXPORT SupportingRecords := RECORD
	STRING16 ServiceType := '';
	STRING8 DateFirstSeen := '';
	STRING8 DateLastSeen := '';
	// Populated for Target Property Records
	UNSIGNED8 LexID := 0;
	BOOLEAN PropertySearch := FALSE;
	STRING20 ReportedFName := '';
	STRING20 ReportedMName := '';
	STRING20 ReportedLName := '';
	// Populated for Subject Records
	BOOLEAN SubjectSearch := FALSE;
	STRING120 ReportedStreetAddress := '';
	STRING25 ReportedCity := '';
	STRING2 ReportedState := '';
	STRING5 ReportedZIP := '';
	STRING5 ReportedZIP5 := '';
	STRING4 ReportedZIP4 := '';
	STRING10 ReportedPrim_Range := '';
	STRING2  ReportedPredir := '';
	STRING28 ReportedPrim_Name := '';
	STRING4  ReportedAddr_Suffix := '';
	STRING2  ReportedPostdir := '';
	STRING10 ReportedUnit_Desig := '';
	STRING8  ReportedSec_Range := '';
END;


EXPORT SupportingRecordsAddr := RECORD
	STRING20 FName := '';
	STRING20 LName := '';
	UNSIGNED8 LexID := 0;
	STRING8 DateFirstSeen := '';
	STRING8 DateLastSeen := '';
	STRING32 AssociationToSubject := '';
	UNSIGNED1 age;
END;


EXPORT Layout_VOOShell := RECORD
	Risk_Indicators.Layout_Input;
	STRING30 AcctNo := '';
	Recordof(doxie.key_header) h;
	integer1  target_addr;
	integer1  other_addr;
	integer1  Transunion_seen;
	integer1  Equifax_seen;
	integer1  Experian_seen;
	integer1  pub_src_seen;
	string2		src_group;
	string1		prop_source_code_1;
	string10	prop_prim_range;
	string2		prop_predir;
	string28	prop_prim_name;
	string4		prop_suffix;
	string2		prop_postdir;
	string5		prop_zip;
	integer1	target_addr_other := 0;
	UNSIGNED2 other_addr_owned_count := 0;
	UNSIGNED2 other_addr_sold_count := 0;
	integer1  target_addr_relatives := 0;
	integer1  other_addr_relatives := 0;
	integer1  Transunion_seen_relatives := 0;
	integer1  Equifax_seen_relatives := 0;
	integer1  Experian_seen_relatives := 0;
	integer1  pub_src_seen_relatives := 0;
	unsigned6	relativeDID;
	string20	relativeTitle;
	unsigned6	ownership_DID;
	string12  ownership_Fares_ID; 
	integer1	srchconfaddr3mos;
	integer1	srchconfaddr1yr;
	integer1	srchprevaddr3mos;
	integer1	srchprevaddr1yr;
	integer1	srchdiffaddr3mos;
	integer1	srchdiffaddr1yr;
	string1 	valid_dob := '';
	unsigned6 hhid := 0;
	STRING18 	county_name := '';
	STRING120 listed_name := '';
	STRING10 	listed_phone := '';
	boolean   DIDdeceased;
	unsigned4 DIDdeceasedDate;
	unsigned4 DIDdeceasedDOB;
	string8   DIDdeceasedfirst;
	string8   DIDdeceasedlast;	
	string8   DIDdeceasedsrc;	
	boolean		incarc_Offenders; //use in non-historical mode only
	boolean		incarc_Offenses;
	boolean		incarc_Punishments;
	string60	incarc_Offender_key;
	string1	  util_source; 	//indicates whether this record is from the GONG file or the Utility file (G or U)
	string10  util_prim_range; 	
	string2   util_predir;		
	string28  util_prim_name;	
	string4   util_suffix;  
	string2   util_postdir;		
	string10  util_unit_desig;	
	string8   util_sec_range;	
	string25  util_p_city_name;	
	string25  util_v_city_name; 
	string2   util_st;	
	string5   util_z5;	
	string6		util_dt_first_seen;
	string6		util_dt_last_seen;
	string6		util_deletion_date;
	integer1  util_target_addr;
	integer1  util_other_addr;
	boolean		util_disconnect;
	string12  Fares_ID; 
	integer4	Fares_dt_first_seen;
	integer4	Fares_dt_last_seen;
	string10  Fares_mail_prim_range; 	
	string2   Fares_mail_predir;		
	string28  Fares_mail_prim_name;	
	string4   Fares_mail_suffix;  
	string2   Fares_mail_postdir;		
	string10  Fares_mail_unit_desig;	
	string8   Fares_mail_sec_range;	
	string25  Fares_mail_city;	
	string2   Fares_mail_st;	
	string5   Fares_mail_zip;	
	integer1  Fares_mail_addr_flag;
	string12  Fares_mail_Fares_ID;
	string1   Fares_mail_addr_owned;
	string1   Fares_mail_addr_sold;
	unsigned6	prior_res_DID;
	unsigned6	prior_res_HHID;
	integer4	prior_res_dt_first_seen;
	integer4	prior_res_dt_last_seen;
	boolean		prior_res_target_addrmatch;
	string1		prior_res_owned_target;
	string1		prior_res_sold_target;
	string1		prior_res_owned_other;
	string1		prior_res_sold_other;
	boolean		prior_res_owned_newer;
	boolean		prior_res_new_addr;
	boolean		prior_res_acct_open;
	string10  prior_res_prim_range; 	
	string2   prior_res_predir;		
	string28  prior_res_prim_name;	
	string4   prior_res_addr_suffix;  
	string2   prior_res_postdir;		
	string10  prior_res_unit_desig;	
	string8   prior_res_sec_range;	
	string25  prior_res_city;	
	string2   prior_res_st;	
	string5   prior_res_zip;
	string12	prior_res_Fares_ID;
	integer4	prior_res_Fares_target_dt_first_seen;
	integer4	prior_res_Fares_other_dt_first_seen;
	string20  prior_res_fname;
	string20  prior_res_lname;
	unsigned1	prior_addr_address_history_seq;
	unsigned1	prior_addr_address_history_reseq;
	string1		prior_addr_owned;
	string1		prior_addr_sold;
	boolean		prior_addr_current;
	boolean		prior_addr_rpting_subject;
	boolean		prior_addr_rpting_newID;
	unsigned6	prior_addr_DID;
	unsigned6	prior_addr_HHID;
	integer4	prior_addr_dt_first_seen;
	integer4	prior_addr_dt_last_seen;
	string12	prior_addr_Fares_ID;
	boolean 	prior_addr_match;
	string10  other_prox_prim_range; 	
	string2   other_prox_predir;		
	string28  other_prox_prim_name;	
	string4   other_prox_suffix;  
	string2   other_prox_postdir;		
	string8   other_prox_sec_range;	
	string25  other_prox_city;	
	string2   other_prox_st;	
	string5   other_prox_zip;
	string10  other_prox_lat;
	string11  other_prox_long;
	string12  other_prox_fares_ID;
	string1   other_prox_owned;
	string1   other_prox_sold;
	real      other_prox_distance;
	string8   other_prox_date;
	string1		other_prox_owned_AsOf;
	string1		other_prox_sold_AsOf;
	boolean		other_prox_person_match;
	integer4	other_prox_dt_first_seen;
	integer4	other_prox_dt_last_seen;
	string1		target_addr_owned;
	string1		target_addr_sold;
	string1   target_owned_spouse;
	string1   other_owned_spouse;
	integer3 	zip_score;	
	integer3 	cityst_score;	
	integer3 	addrmatchscore;	
	boolean		target_addr_current;
	unsigned6	target_addr_DID;
	unsigned6	target_addr_HHID;
	boolean		target_addr_rpting_other;
	string12  target_addr_fares_ID;
	unsigned8 lookup_did := 0;
	Risk_Indicators.Layouts.advo_fields ADVO;
	string4  	sic_code;
	INTEGER1 	SubjectPropertyIndicator := -1;
	DATASET(Subject_Addresses) SubjectAddresses := DATASET([], Subject_Addresses);
	unsigned8 infer_own_relatedDID;
	unsigned8 infer_own_targetDID;
	boolean		infer_own_current;
	boolean		infer_own_unrelated;
END;

EXPORT Layout_property := RECORD
	Risk_Indicators.Layout_Input;
	string10  property_prim_range; 	
	string2   property_predir;		
	string28  property_prim_name;	
	string4   property_suffix;  
	string2   property_postdir;	
	string10  property_unit_desig;	
	string8   property_sec_range;	
	string25  property_city;	
	string2   property_st;	
	string5   property_zip;
	string10  property_lat;
	string11  property_long;
	string12  property_fares_ID;
	string1   property_owned;
	string1   property_sold;
	real      property_distance;
	string8   property_date;
	string1		property_owned_AsOf;
	string1		property_sold_AsOf;
	boolean		property_person_match;
	integer4	property_dt_first_seen;
	integer4	property_dt_last_seen;
	boolean 	property_match;
	real      other_prox_distance;
END;

EXPORT Layout_address := RECORD
	Risk_Indicators.Layout_Input;
	UNSIGNED  s_did;
	STRING10  address_prim_range;
	STRING2   address_predir;
	STRING28  address_prim_name;
	STRING4   address_suffix;
	STRING2   address_postdir;
	STRING10  address_unit_desig;
	STRING8   address_sec_range;
	STRING30  address_city;
	STRING2   address_state;
	STRING5   address_zip;
	UNSIGNED3 address_date_first_seen;
	UNSIGNED3 address_date_last_seen;
	INTEGER   address_history_seq;
	UNSIGNED2 source_count;
	UNSIGNED2 insurance_source_count;
  STRING5   addressstatus;
  STRING3   addresstype;
	UNSIGNED2 bureau_source_count;
	UNSIGNED2 property_source_count;
	UNSIGNED2 utility_source_count;
	UNSIGNED2 vehicle_source_count;
	UNSIGNED2 dl_source_count;
	UNSIGNED2 voter_source_count;
END;

EXPORT Layout_VOOIn  := RECORD
  string30  AcctNo;
  unsigned4 seq;
	unsigned6 LexID;
	STRING70  Name_Full;
	STRING5   Name_Title;
	STRING20  Name_First;
	STRING20  Name_Middle;
	STRING20  Name_Last;
	STRING5   Name_Suffix;
	STRING9   ssn;
	STRING8   dob;
	STRING10	phone10;
	STRING120 street_addr;
	String10  streetnumber;
	String2		streetpredirection;
	String28	streetname;
	String4		streetsuffix;
	String2		streetpostdirection;
	String10	unitdesignation;
	String8		unitnumber;
	STRING25  City_name;
	STRING2   st;
	STRING5   z5;
	STRING25 	country;
	string8 	AsOf;
END;


EXPORT Layout_VOOBatchIn  := RECORD
  string30  AcctNo;
  unsigned6 seq;
	unsigned6 LexID;
	STRING20  Name_First;
	STRING20  Name_Middle;
	STRING20  Name_Last;
	STRING9   ssn;
	STRING8   dob;
	STRING10 	phone10;
	STRING120 street_addr;
	STRING25  City_name;
	STRING2   st;
	STRING5   z5;
	string8 	AsOf;
END;

EXPORT Layout_VOOBatchOut := RECORD
  string30 	AcctNo;
	unsigned6	Seq;
	unsigned6 LexID;
	Layout_VOOAttributes 		attributes;
END;

EXPORT Layout_VOOBatchOutReport := RECORD
	Layout_VOOBatchOut;
	iesp.verificationofoccupancy.t_VOOReport Report := ROW([], iesp.verificationofoccupancy.t_VOOReport); // This is removed from Layout_VOOBatchOutFlat since it will only be returned in the XML service
END;

EXPORT Layout_PARBatchOutReport := RECORD
	Layout_VOOBatchOut;
	iesp.premiseassociation.t_PremiseAssociationReport Report := ROW([], iesp.premiseassociation.t_PremiseAssociationReport); 
END;

EXPORT Layout_VOOBatchOutFlat := RECORD
  string30 	AcctNo;
	unsigned6	Seq;
	unsigned6 LexID;
	String2 	v1_AddressReportingSourceIndex;
	String2 	v1_AddressReportingHistoryIndex;
	String2 	v1_AddressSearchHistoryIndex;
	String2 	v1_AddressUtilityHistoryIndex;
	String2 	v1_AddressOwnershipHistoryIndex;
	String2 	v1_AddressPropertyTypeIndex;
	String2 	v1_AddressValidityIndex; 
	String2 	v1_RelativesConfirmingAddressIndex;
	String2 	v1_AddressOwnerMailingAddressIndex;
	String2 	v1_PriorAddressMoveIndex;
	String2 	v1_PriorResidentMoveIndex;
	String6 	v1_AddressDateFirstSeen;
	String6 	v1_AddressDateLastSeen;
	String2 	v1_OccupancyOverride;
	String2 	v1_InferredOwnershipTypeIndex;
	String5   v1_OtherOwnedPropertyProximity;
	String2   v1_VerificationOfOccupancyScore;
END; 

END;