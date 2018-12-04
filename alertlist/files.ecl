EXPORT files := MODULE

		EXPORT Layout_Batch_Input := RECORD
																		STRING		Entity_Id; /* Unique ID supplied by the customer */
																		QSTRING120 original_company_name; /* Company Name provided by the customer */
																		UNSIGNED3	original_company_zip;   /* Company zip provided by the customer */
																		UNSIGNED8	BDID;
																		UNSIGNED8	BDID_Score; /* A feature exists in the ECL now that will remove any records that have an appended BDID or DID with a low score Â– low score specified by user */
																		QSTRING20 original_fname; /* First Name provided by the customer */
																		QSTRING20 original_mname; /* Middle Name provided by the customer */
																		QSTRING20 original_lname; /* Lastn Name provided by the customer */
																		QSTRING5  original_name_suffix; /* Name Suffix provided by the customer */
																		UNSIGNED8	DID; /* or rather LexID */
																		UNSIGNED8	DID_Score; /* A feature exists in the ECL now that will remove any records that have an appended BDID or DID with a low score Â– low score specified by user */
																		STRING15	customer_id;
																		STRING1		product_id;
																		BOOLEAN		Flag1_Active; /* Flag used for if this is an active record or for whatever flag the customer wants set */
																		BOOLEAN		Flag2_Alert; /* Flag used for if this is an alert record or for whatever flag the customer wants set */
																		BOOLEAN		Flag3 := false; /* Additional flag that can be used by customer */
																		BOOLEAN		Flag4 := false; /* Additional flag that can be used by customer */
																		BOOLEAN		Flag5 := false; /* Additional flag that can be used by customer */
																	END;
																	
		EXPORT Batch_Input := DATASET(alertlist.constants.prefix + 'in::alertlist::batch_input', Layout_Batch_Input, csv);

		EXPORT Layout_Batch_Input_did_Index := RECORD
																		QSTRING20 original_fname; /* First Name provided by the customer */
																		QSTRING20 original_mname; /* Middle Name provided by the customer */
																		QSTRING20 original_lname; /* Lastn Name provided by the customer */
																		QSTRING5  original_name_suffix; /* Name Suffix provided by the customer */
																		BOOLEAN		Flag1_Active; /* Flag used for if this is an active record or for whatever flag the customer wants set */
																		BOOLEAN		Flag2_Alert; /* Flag used for if this is an alert record or for whatever flag the customer wants set */
																		BOOLEAN		Flag3 := false; /* Additional flag that can be used by customer */
																		BOOLEAN		Flag4 := false; /* Additional flag that can be used by customer */
																		BOOLEAN		Flag5 := false; /* Additional flag that can be used by customer */
		END;
		
		EXPORT Layout_Accurint_Business_Contacts := RECORD
																									string id;
																									string10 lid_type;
																									unsigned8 lid;
																									unsigned8 lidscore;
																									unsigned8 minlidscore;
																									STRING120 original_company_name; /* Company Name provided by the customer */
																									UNSIGNED3	original_company_zip;   /* Company zip provided by the customer */
																									STRING20 original_fname; /* First Name provided by the customer */
																									STRING20 original_mname; /* Middle Name provided by the customer */
																									STRING20 original_lname; /* Lastn Name provided by the customer */
																									STRING5  original_name_suffix; /* Name Suffix provided by the customer */
																									boolean isactive;
																									boolean isalert;
																									BOOLEAN	isFlag3 := false; /* Additional flag that can be used by customer */
																									BOOLEAN	isFlag4 := false; /* Additional flag that can be used by customer */
																									BOOLEAN	isFlag5 := false; /* Additional flag that can be used by customer */
																									boolean did_active_alert;
																									boolean bdid_active_alert;
																									unsigned8 idid;
																									unsigned8 ibdid;
																									string15 customer_id;
																									string1 product_id;
																									unsigned6 bdid;
																									unsigned6 did;
																									unsigned1 contact_score;
																									qstring34 vendor_id;
																									unsigned4 dt_first_seen;
																									unsigned4 dt_last_seen;
																									string2 source;
																									string1 record_type;
																									string1 from_hdr;
																									boolean glb;
																									boolean dppa;
																									qstring35 company_title;
																									qstring35 company_department;
																									qstring5 title;
																									qstring20 fname;
																									qstring20 mname;
																									qstring20 lname;
																									qstring5 name_suffix;
																									string1 name_score;
																									qstring10 prim_range;
																									string2 predir;
																									qstring28 prim_name;
																									qstring4 addr_suffix;
																									string2 postdir;
																									qstring5 unit_desig;
																									qstring8 sec_range;
																									qstring25 city;
																									string2 state;
																									unsigned3 zip;
																									unsigned2 zip4;
																									string3 county;
																									string4 msa;
																									qstring10 geo_lat;
																									qstring11 geo_long;
																									unsigned6 phone;
																									string60 email_address;
																									unsigned4 ssn;
																									qstring34 company_source_group;
																									qstring120 company_name;
																									qstring10 company_prim_range;
																									string2 company_predir;
																									qstring28 company_prim_name;
																									qstring4 company_addr_suffix;
																									string2 company_postdir;
																									qstring5 company_unit_desig;
																									qstring8 company_sec_range;
																									qstring25 company_city;
																									string2 company_state;
																									unsigned3 company_zip;
																									unsigned2 company_zip4;
																									unsigned6 company_phone;
																									unsigned4 company_fein;
																									string34 vl_id;
																									unsigned8 rawaid;
																									unsigned8 company_rawaid;
																								 END;

		EXPORT Accurint_Business_Contacts := DATASET(alertlist.constants.prefix + 'out::social_alert_business_contacts', Layout_Accurint_Business_Contacts, thor);

		EXPORT Layout_Social_Accurint := RECORD
																					unsigned8 cluster_id;
																					unsigned2 totalcnt;
																					unsigned2 firstdegrees;
																					unsigned2 seconddegrees;
																					real4 cohesivity;
																					unsigned8 did;
																					unsigned8 bdid;
																					string id;
																					string10 lid_type;
																					unsigned8 lid;
																					unsigned8 lidscore;
																					unsigned8 minlidscore;
																					STRING120 original_company_name; /* Company Name provided by the customer */
																					UNSIGNED3	original_company_zip;   /* Company zip provided by the customer */
																					STRING20 original_fname; /* First Name provided by the customer */
																					STRING20 original_mname; /* Middle Name provided by the customer */
																					STRING20 original_lname; /* Lastn Name provided by the customer */
																					STRING5  original_name_suffix; /* Name Suffix provided by the customer */
																					boolean isactive;
																					boolean isalert;
																					boolean	isFlag3 := false; /* Additional flag that can be used by customer */
																					boolean	isFlag4 := false; /* Additional flag that can be used by customer */
																					boolean	isFlag5 := false; /* Additional flag that can be used by customer */
																					boolean did_active_alert;
																					boolean bdid_active_alert;
																					unsigned8 idid;
																					unsigned8 ibdid;
																					string15 customer_id;
																					string1 product_id;
																					real4 degree;
																					unsigned8 associated_did;
																				 END;

		EXPORT Social_Accurint 	:= dataset(alertlist.constants.prefix + 'out::social_alert_clusters', Layout_Social_Accurint, thor);

		EXPORT Layout_Accurint_Social_Stats := RECORD
																							string id;
																							string customer_id;
																							string product_id;
																							string lid_type;
																							unsigned8 lid;
																							STRING120 original_company_name; /* Company Name provided by the customer */
																							UNSIGNED3	original_company_zip;   /* Company zip provided by the customer */
																							STRING20 original_fname; /* First Name provided by the customer */
																							STRING20 original_mname; /* Middle Name provided by the customer */
																							STRING20 original_lname; /* Lastn Name provided by the customer */
																							STRING5  original_name_suffix; /* Name Suffix provided by the customer */
																							unsigned8 cluster_id;
																							unsigned2 totalcnt;
																							unsigned2 firstdegrees;
																							unsigned2 seconddegrees;
																							real4 cohesivity;
																							integer8 score;
																							integer8 active_company_count;
																							integer8 active_company_0;
																							integer8 active_company_1;
																							integer8 active_company_2;
																							integer8 alert_company_count;
																							integer8 alert_company_0;
																							integer8 alert_company_1;
																							integer8 alert_company_2;
																							integer8 flag3_company_count;
																							integer8 flag3_company_0;
																							integer8 flag3_company_1;
																							integer8 flag3_company_2;
																							integer8 flag4_company_count;
																							integer8 flag4_company_0;
																							integer8 flag4_company_1;
																							integer8 flag4_company_2;
																							integer8 flag5_company_count;
																							integer8 flag5_company_0;
																							integer8 flag5_company_1;
																							integer8 flag5_company_2;
																							integer8 active_person_count;
																							integer8 active_person_0;
																							integer8 active_person_1;
																							integer8 active_person_2;
																							integer8 alert_person_count;
																							integer8 alert_person_0;
																							integer8 alert_person_1;
																							integer8 alert_person_2;
																							integer8 flag3_person_count;
																							integer8 flag3_person_0;
																							integer8 flag3_person_1;
																							integer8 flag3_person_2;
																							integer8 flag4_person_count;
																							integer8 flag4_person_0;
																							integer8 flag4_person_1;
																							integer8 flag4_person_2;
																							integer8 flag5_person_count;
																							integer8 flag5_person_0;
																							integer8 flag5_person_1;
																							integer8 flag5_person_2;
																						END;



		EXPORT Accurint_Social_Stats 	:= dataset(alertlist.constants.prefix + 'out::social_alert_results', Layout_Accurint_Social_Stats, thor);
    
END;