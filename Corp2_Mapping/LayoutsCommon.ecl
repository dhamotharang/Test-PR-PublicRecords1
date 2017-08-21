import corp2, aid;

EXPORT LayoutsCommon := MODULE

Export Main					:=	record
	unsigned4   dt_vendor_first_reported;
	unsigned4   dt_vendor_last_reported;
	unsigned4   dt_first_seen;
	unsigned4   dt_last_seen;
	unsigned4   Corp_ra_dt_first_seen;
	unsigned4   Corp_ra_dt_last_seen;
	
	string30   	Corp_key;
	string30   	Corp_supp_key;
	string2	   	Corp_vendor;
	string3    	Corp_vendor_county;
	string5    	Corp_vendor_subcode;
	string2	   	Corp_state_origin;
	string8	   	Corp_process_date;
	string32   	Corp_orig_sos_charter_nbr;
	
	string350  	Corp_legal_name;
	string2    	Corp_ln_name_type_cd;
	string30   	Corp_ln_name_type_desc;
	string32   	Corp_supp_nbr;
	string250  	Corp_name_comment;  //modified length from 100 to 250
	
	string8	   	Corp_address1_type_cd;
	string60   	Corp_address1_type_desc;
	string70   	Corp_address1_line1;
	string70   	Corp_address1_line2;
	string70   	Corp_address1_line3;
	string8	   	Corp_address1_effective_date;
	
	string8	   	Corp_address2_type_cd;
	string60   	Corp_address2_type_desc;
	string70   	Corp_address2_line1;
	string70   	Corp_address2_line2;
	string70   	Corp_address2_line3;
	string8	   	Corp_address2_effective_date;
	
	string30   	Corp_phone_number;
	string8	   	Corp_phone_number_type_cd;
	string60   	Corp_phone_number_type_desc;
	string15   	Corp_fax_nbr;
	string30   	Corp_email_address;
	string30   	Corp_web_address;
	
	string30   	Corp_filing_reference_nbr;
	string8	   	Corp_filing_date;
	string8	   	Corp_filing_cd;
	string60   	Corp_filing_desc;
	
	string8	   	Corp_status_cd;
	string60   	Corp_status_desc;
	string8	   	Corp_status_date;
	string1    	Corp_standing;
	string350  	Corp_status_comment; //modified length from 100 to 350
	
	string8	   	Corp_ticker_symbol;
	string8	   	Corp_stock_exchange;
	
	string2	   	Corp_inc_state;
	string30   	Corp_inc_county;
	string8	   	Corp_inc_date;
	string15   	Corp_anniversary_month;
	string32   	Corp_fed_tax_id;
	string32   	Corp_state_tax_id;
	string8	   	Corp_term_exist_cd;
	string8	   	Corp_term_exist_exp;
	string60   	Corp_term_exist_desc;
	string1	   	Corp_foreign_domestic_ind;
	
	string3	   	Corp_forgn_state_cd;
	string60   	Corp_forgn_state_desc;
	string32   	Corp_forgn_sos_charter_nbr;
	string8	   	Corp_forgn_date;
	string32   	Corp_forgn_fed_tax_id;
	string32   	Corp_forgn_state_tax_id;
	string8	   	Corp_forgn_term_exist_cd;
	string8	   	Corp_forgn_term_exist_exp;
	string60   	Corp_forgn_term_exist_desc;
	
	string8	   	Corp_orig_org_structure_cd;
	string60   	Corp_orig_org_structure_desc;
	string1	   	Corp_for_profit_ind;
	string1    	Corp_public_or_private_ind;
	string8	   	Corp_sic_code;
	string8    	Corp_naic_code;
	string8	   	Corp_orig_bus_type_cd;
	string350  	Corp_orig_bus_type_desc;  //modified length from 70 to 350
	string350  	Corp_entity_desc;         //modified length from 60 to 350
	string32   	Corp_certificate_nbr;
	string32   	Corp_internal_nbr;
	string32   	Corp_previous_nbr;
	string32   	Corp_microfilm_nbr;
	string5    	Corp_amendments_filed;
	string50   	Corp_acts;
	string1    	Corp_partnership_ind;
	string1    	Corp_mfg_ind;
	string250  	Corp_addl_info;        //modified length from 100 to 250

	string10   	Corp_taxes;
	string8    	Corp_franchise_taxes;
	string8    	Corp_tax_program_cd;
	string30   	Corp_tax_program_desc;
	
	string100  	Corp_ra_full_name;
	string20	 	Corp_ra_fname;
	string20	 	Corp_ra_mname;
	string20	 	Corp_ra_lname;	
	string5		 	Corp_ra_suffix;	
	string8	   	Corp_ra_title_cd;
	string60   	Corp_ra_title_desc;
	string10   	Corp_ra_fein;
	string9	   	Corp_ra_ssn;
	string8	   	Corp_ra_dob;
	string8	   	Corp_ra_effective_date;
	string8    	Corp_ra_resign_date;
	string5    	Corp_ra_no_comp;
	string5    	Corp_ra_no_comp_igs;
	string250  	Corp_ra_addl_info; //modified length from 100 to 250
	
	string8	   	Corp_ra_address_type_cd;
	string60   	Corp_ra_address_type_desc;
	string70   	Corp_ra_address_line1;
	string70   	Corp_ra_address_line2;
	string70   	Corp_ra_address_line3;
	
	string30   	Corp_ra_phone_number;
	string8	   	Corp_ra_phone_number_type_cd;
	string60   	Corp_ra_phone_number_type_desc;
	string15   	Corp_ra_fax_nbr;
	string30   	Corp_ra_email_address;
	string30   	Corp_ra_web_address;
	string100	 	Corp_prep_addr1_line1;
	string50	 	Corp_prep_addr1_last_line;	
	string100	 	Corp_prep_addr2_line1;
	string50	 	Corp_prep_addr2_last_line;
	string100		RA_prep_addr_line1;
	string50		RA_prep_addr_last_line;

	string30   	Cont_filing_reference_nbr;
	string8	   	Cont_filing_date;
	string8	   	Cont_filing_cd;
	string60   	Cont_filing_desc;
	
	string8	   	Cont_type_cd;
	string60   	Cont_type_desc;
	string100  	Cont_full_name;
	string20	 	Cont_fname;
	string20	 	Cont_mname;
	string20	 	Cont_lname;
	string5		 	Cont_suffix;		
	string60   	Cont_title1_desc;
	string60   	Cont_title2_desc;
	string60   	Cont_title3_desc;
	string60   	Cont_title4_desc;
	string60   	Cont_title5_desc;
	string10   	Cont_fein;
	string9	   	Cont_ssn;
	string8	   	Cont_dob;
	string8    	Cont_status_cd;
	string60   	Cont_status_desc;
	string8	   	Cont_effective_date;
	string1	   	Cont_effective_cd;
	string60   	Cont_effective_desc;
	string350  	Cont_addl_info;   //modified length from 100 to 350
	
	string8	   	Cont_address_type_cd;
	string60   	Cont_address_type_desc;
	string70   	Cont_address_line1;
	string70   	Cont_address_line2;
	string70   	Cont_address_line3;
	string8	   	Cont_address_effective_date;
	string30   	Cont_address_county;
	
	string30   	Cont_phone_number;
	string8	   	Cont_phone_number_type_cd;
	string60   	Cont_phone_number_type_desc;
	string15   	Cont_fax_nbr;
	string30   	Cont_email_address;
	string30   	Cont_web_address;
	
//new fields

	string50	 	Corp_Acres;
	string10	 	Corp_Action;
	string10	 	Corp_Action_Date;
	string8		 	Corp_Action_Employment_Security_Approval_Date;
	string1		 	Corp_Action_Pending_Cd;
	string50	 	Corp_Action_Pending_Desc;
	string8		 	Corp_Action_Statement_Of_Intent_Date;
	string8		 	Corp_Action_Tax_Dept_Approval_Date;
	string50	 	Corp_Acts2;
	string50	 	Corp_Acts3;
	string1		 	Corp_Additional_Principals;
	string50	 	Corp_Address_Office_Type;
	string8			Corp_Agent_Assign_Date;
	string1 	 	Corp_Agent_Commercial;
	string50	 	Corp_Agent_Country;
	string20	 	Corp_Agent_County;
	string5		 	Corp_Agent_Status_cd;
	string50	 	Corp_Agent_Status_desc;
	string8		 	Corp_Agent_Id;
	string1		 	Corp_Agriculture_Flag;
	string100	 	Corp_Authorized_Partners;
	string300	 	Corp_Comment;
	string1		 	Corp_Consent_Flag_For_Protected_Name;
	string1		 	Corp_Converted;
	string50	 	Corp_Converted_From;
	string50	 	Corp_Country_Of_Formation;
	string8		 	Corp_Date_Of_Organization_Meeting;
	string8		 	Corp_Delayed_Effective_Date;
	string10	 	Corp_Directors_From_To;
	string8		 	Corp_Dissolved_Date;
	string30 	 	Corp_Farm_Exemptions;
	string10	 	Corp_Farm_Qual_Date;
	string1		 	Corp_Farm_Status_CD;
	string10	 	Corp_Farm_Status_Date;
	string100		Corp_Farm_Status_Desc;
	string8		 	Corp_Fiscal_Year_Month;
	string1		 	Corp_Foreign_Fiduciary_Capacity_In_State;
	string20	 	Corp_Governing_Statute;
	string1		 	Corp_Has_members;
	string1		 	Corp_Has_vested_managers;
	string60	 	Corp_Home_Incorporated_County;
	string30 	 	Corp_Home_State_Name;
	string1		 	Corp_Is_Professional;
	string1		 	Corp_Is_non_profit_irs_approved;
	string8		 	Corp_Last_Renewal_Date;
	string4		 	Corp_Last_Renewal_Year;
	string1		 	Corp_License_Type;
	string100		Corp_LLC_Managed_Desc;
	string1		 	Corp_LLC_Managed_Ind;	
	string50	 	Corp_Management_Desc;
	string1		 	Corp_Management_Type;
	string1		 	Corp_Manager_Managed;
	string32	 	Corp_Merged_Corporation_Id;
	string9		 	Corp_Merged_Fein;
	string1		 	Corp_Merger_Allowed_Flag;
	string8		 	Corp_Merger_Date;
	string250	 	Corp_Merger_Desc;
	string8		 	Corp_Merger_Effective_Date;
	string32	 	Corp_Merger_Id;
	string1		 	Corp_Merger_Indicator;
	string100	 	Corp_Merger_Name;
	string4		 	Corp_Merger_Type_Converted_To_Cd;
	string100	 	Corp_Merger_Type_Converted_To_Desc;
	string60	 	Corp_Naics_Desc;
	string8		 	Corp_Name_Effective_Date;
	string8		 	Corp_Name_Reservation_Date;
	string250		Corp_Name_Reservation_Desc;
	string8		 	Corp_Name_Reservation_Expiration_Date;
	string32	 	Corp_Name_Reservation_Nbr;
	string100	 	Corp_Name_Reservation_Type;
	string5		 	Corp_Name_Status_Cd;
	string8		 	Corp_Name_Status_Date;
	string100	 	Corp_Name_Status_Desc;
	string50	 	Corp_Non_profit_irs_approved_purpose;
	string1		 	Corp_Non_profit_solicit_donations;
	string10	 	Corp_Nbr_Of_Amendments;
	string10		Corp_Nbr_Of_Initial_Llc_Members;
	string10	 	Corp_Nbr_Of_Partners;
	string1		 	Corp_Operating_Agreement;
	string50	 	Corp_Opt_In_Llc_Act_Desc;
	string1		 	Corp_Opt_In_Llc_Act_Ind;
	string250	 	Corp_Organizational_Comments;
	string15	 	Corp_Partner_Contributions_Total;
	string200	 	Corp_Partner_Terms;
	string10	 	Corp_Percentage_Voters_Required_To_Approve_Amendments;
	string250	 	Corp_Profession;
	string20	 	Corp_Province;
	string10	 	Corp_Public_Mutual_Corporation;
	string250	 	Corp_Purpose;
	string1		 	Corp_Ra_Required_Flag;
	string500	 	Corp_Registered_Counties;
	string1		 	Corp_Regulated_Ind;
	string8		 	Corp_Renewal_Date;
	string50	 	Corp_Standing_Other;
	string32	 	Corp_Survivor_Corporation_Id;
	string1		 	Corp_Tax_Base;
	string50	 	Corp_Tax_Standing;
	string2		 	Corp_Termination_Cd;
	string100	 	Corp_Termination_Desc;
	string8		 	Corp_Termination_Date;
	string20	 	Corp_Trademark_Business_Mark_Type;
	string8		 	Corp_Trademark_Cancelled_Date;
	string250	 	Corp_Trademark_Class_Desc1;
	string250	 	Corp_Trademark_Class_Desc2;
	string250	 	Corp_Trademark_Class_Desc3;
	string250	 	Corp_Trademark_Class_Desc4;
	string250	 	Corp_Trademark_Class_Desc5;
	string250	 	Corp_Trademark_Class_Desc6;	
	string10	 	Corp_Trademark_Classification_Nbr;
	string50	 	Corp_Trademark_Disclaimer1;
	string50	 	Corp_Trademark_Disclaimer2;	
	string8		 	Corp_Trademark_Expiration_Date;
	string8		 	Corp_Trademark_Filing_Date;
	string8		 	Corp_Trademark_First_Use_Date;
	string8		 	Corp_Trademark_First_Use_Date_In_State;
	string250	 	Corp_Trademark_Keywords;
	string250	 	Corp_Trademark_Logo;
	string8		 	Corp_Trademark_Name_Expiration_Date;
	string12	 	Corp_Trademark_Nbr;
	string8		 	Corp_Trademark_Renewal_Date;
	string1		 	Corp_Trademark_Status;
	string50	 	Corp_Trademark_Used_1;
	string50	 	Corp_Trademark_Used_2;
	string50	 	Corp_Trademark_Used_3;
	unsigned2	 	Cont_Owner_Percentage;
	string50 		Cont_Country;
	string50 		Cont_Country_Mailing;
	string1			Cont_Nondislosure;
	
//---- end of new fields

	string100	 	Cont_prep_addr_line1;				// This is a contact field. Map with the contact address specified in the mapping instructions
	string50	 	Cont_prep_addr_last_line;		// This is a contact field. Map with the contact csz specified in the mapping instructions
	string1			recordOrigin;								// C = Corp; T = Contact;
	//---- These internal fields are needed for scrubs during the mapping process.
	//---- They are not utilized by the build process.	
	string100		InternalField1;
	string100		InternalField2;
	string100		InternalField3;
	string100		InternalField4;
	string100		InternalField5;
end;

Export AR	:=	record

	string30  	corp_key;
	string2   	corp_vendor;
	string3   	corp_vendor_county;
	string5   	corp_vendor_subcode;
	string2   	corp_state_origin;
	string8   	corp_process_date;
	string32  	corp_sos_charter_nbr;

	string4   	ar_year;
	string8   	ar_mailed_dt;
	string8   	ar_due_dt;
	string8   	ar_filed_dt;
	string8   	ar_report_dt;
	string30  	ar_report_nbr;  //modified length from 10 to 30
	string8   	ar_franchise_tax_paid_dt;
	string8   	ar_delinquent_dt;
	string10  	ar_tax_factor;
	string10  	ar_tax_amount_paid;
	string10  	ar_annual_report_cap;
	string10  	ar_illinois_capital;
	string10  	ar_roll;
	string10  	ar_frame;
	string10  	ar_extension;
	string10  	ar_microfilm_nbr;
	string350 	ar_comment; //modified length from 100 to 350
	string60  	ar_type; //modified length from 1 to 60

	string1 		ar_exempt;
	string20		ar_license_tax_amount;
	string50		ar_status;
	string8			ar_paid_date;
	string8			ar_prev_paid_date;
	string10		ar_prev_tax_factor;
	string8			ar_extension_date;
	string8			ar_report_mail_date;
	string8			ar_deliquent_report_mail_date;
	string8			ar_report_filed_date;
	string8			ar_year_and_month_due;
	string50		ar_amount_paid;
	//---- These internal fields are needed for scrubs during the mapping process.
	//---- They are not utilized by the build process.
	string100		InternalField1;
	string100		InternalField2;
	string100		InternalField3;
	string100		InternalField4;
	string100		InternalField5;
end;

Export Events				:=	record
	string30  	corp_key;
	string30  	corp_supp_key;
	string2	  	corp_vendor;
	string3   	corp_vendor_county;
	string5   	corp_vendor_subcode;
	string2	  	corp_state_origin;
	string8	  	corp_process_date;
	string32  	corp_sos_charter_nbr;
	
	string30  	event_filing_reference_nbr;
	string3  		event_amendment_nbr;
	string8		  event_filing_date;
	string3   	event_date_type_cd;
	string30  	event_date_type_desc;
	string8	  	event_filing_cd;
	string60  	event_filing_desc;
	string32  	event_corp_nbr;
	string1   	event_corp_nbr_cd;
	string30  	event_corp_nbr_desc;
	string10  	event_roll;
	string10  	event_frame;
	string8   	event_start;
	string8   	event_end;
	string10  	event_microfilm_nbr;
	
	string500 	event_desc; //modified length from 100 to 500
	
	//---- New fields
	string250		event_revocation_comment1;
	string250		event_revocation_comment2;
	string9			event_book_nbr;
	string9			event_page_nbr;
	string9			event_certification_nbr;
	//---- These internal fields are needed for scrubs during the mapping process.
	//---- They are not utilized by the build process.
	string100		InternalField1;
	string100		InternalField2;
	string100		InternalField3;
	string100		InternalField4;
	string100		InternalField5;
end;

Export Stock				:=	record
	string30  	corp_key;
	string2   	corp_vendor;
	string3   	corp_vendor_county;
	string5   	corp_vendor_subcode;
	string2   	corp_state_origin;
	string8   	corp_process_date;
	string32  	corp_sos_charter_nbr;

	string5   	stock_ticker_symbol;
	string5   	stock_exchange;
	string20  	stock_type;
	string20  	stock_class;
	string15  	stock_shares_issued;
	string50	  stock_authorized_nbr;
	string15 	 	stock_par_value;
	string15  	stock_nbr_par_shares;
	string1  		stock_change_ind;
	string8   	stock_change_date;
	string1   	stock_voting_rights_ind;
	string1   	stock_convert_ind;
	string8   	stock_convert_date;
	string8   	stock_change_in_cap;
	string15  	stock_tax_capital;
	string15  	stock_total_capital;
	string250 	stock_addl_info; 

	string250		stock_stock_description;
	string250		stock_stock_series;
	string1			stock_non_par_value_flag;
	string1			stock_additional_stock;
	unsigned8		stock_shares_proportion_to_ohio_for_foreign_license;
	unsigned8		stock_share_credits;
	unsigned8		stock_authorized_capital;
	unsigned8		stock_stock_paid_in_capital;
	string1			stock_pay_higher_stock_fees;
	unsigned8		stock_actual_amt_invested_in_state;
	string1			stock_share_exchange_during_merger;
	string8			stock_date_stock_limit_approved;
	unsigned8		stock_number_of_shares_paid_for;
	unsigned8		stock_total_value_of_shares_paid_for;
	unsigned8		stock_sharesofbeneficialinterest;
	unsigned8		stock_beneficialsharevalue;
	//---- These internal fields are needed for scrubs during the mapping process.
	//---- They are not utilized by the build process.
	string100		InternalField1;
	string100		InternalField2;
	string100		InternalField3;
	string100		InternalField4;
	string100		InternalField5;
end;

Export Temporary		:=	record
	unsigned8		unique_id;
	corp2.Layout_Corporate_Direct_Corp_Base_Expanded;
	unsigned6 	did := 0;
	string30  	cont_filing_reference_nbr;
	string8  		cont_filing_date;
	string8   	cont_filing_cd;
	string60  	cont_filing_desc;
	string8   	cont_type_cd;
	string60  	cont_type_desc;
	string100 	cont_name;
	string60  	cont_title_desc;
	string32  	cont_sos_charter_nbr; // new
	string10  	cont_fein;
	string9   	cont_ssn;
	string8   	cont_dob;
	string8   	cont_status_cd; // new
	string60  	cont_status_desc; // new
	string8   	cont_effective_date;
	string1	  	cont_effective_cd; // new
	string60  	cont_effective_desc; // new
	string350 	cont_addl_info; // new
	string8   	cont_address_type_cd;
	string60  	cont_address_type_desc;
	string70  	cont_address_line1;
	string70  	cont_address_line2;
	string70  	cont_address_line3;
	string70  	cont_address_line4;
	string70  	cont_address_line5;
	string70  	cont_address_line6;
	string8   	cont_address_effective_date;
	string30  	cont_address_county; // new
	string30  	cont_phone_number;
	string8   	cont_phone_number_type_cd;
	string60  	cont_phone_number_type_desc;
	string15  	cont_fax_nbr; // new
	string30  	cont_email_address;
	string30  	cont_web_address;
	string5   	cont_title;
	string20  	cont_fname;
	string20  	cont_mname;
	string20  	cont_lname;
	string5   	cont_name_suffix;
	string3   	cont_score;
	string70  	cont_cname;
	string3   	cont_cname_score;
	string10  	cont_prim_range;
	string2   	cont_predir;
	string28  	cont_prim_name;
	string4   	cont_addr_suffix;
	string2   	cont_postdir;
	string10  	cont_unit_desig;
	string8   	cont_sec_range;
	string25  	cont_p_city_name;
	string25  	cont_v_city_name;
	string2   	cont_state;
	string5   	cont_zip5;
	string4   	cont_zip4;
	string4   	cont_cart;
	string1   	cont_cr_sort_sz;
	string4   	cont_lot;
	string1   	cont_lot_order;
	string2   	cont_dpbc;
	string1   	cont_chk_digit;
	string2   	cont_rec_type;
	string2   	cont_ace_fips_st;
	string3   	cont_county;
	string10  	cont_geo_lat;
	string11  	cont_geo_long;
	string4   	cont_msa;
	string7   	cont_geo_blk;
	string1   	cont_geo_match;
	string4   	cont_err_stat;
	string10  	cont_phone10;
	
	unsigned2	 	Cont_Owner_Percentage;
	string50 		Cont_Country;
	string50 		Cont_Country_Mailing;
	string1			Cont_Nondislosure;
	
	AID.Common.xAID	Append_Corp_Addr_RawAID;
	AID.Common.xAID	Append_Corp_Addr_ACEAID;
	string100		corp_prep_addr_line1;
	string50		corp_prep_addr_last_line;
	AID.Common.xAID	Append_Cont_Addr_RawAID;	
	AID.Common.xAID	Append_Cont_Addr_ACEAID;
	string100		cont_prep_addr_line1;
	string50		cont_prep_addr_last_line;
	string100		Corp_ra_full_name;
	string20		Corp_ra_fname;
	string20		Corp_ra_mname;
	string20		Corp_ra_lname;	
	string100		Cont_full_name;	
	string1			recordOrigin;
	string1			processedState;
end;

Export ProcessedStates		:=	record
	string2 state;
end;

export CorpBaseTemp	:=	record
	Corp2.Layout_Corporate_Direct_Corp_Base_expanded;
	string1	ProcessedState;
end;
		
export ContBaseTemp	:=	record
	Corp2.Layout_Corporate_Direct_Cont_Base_expanded;
	string1	ProcessedState;
end;

end;