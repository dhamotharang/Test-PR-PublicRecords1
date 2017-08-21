export Layout_Liens_Superior_Sub_Judgment_In := record
   string50 tmsid ;
   string50 rmsid;
   string50 vdi;
   string8 process_date ; 
   string1 header_domain;
   string2 header_filing_state;
   string2 header_casenumber_num_prefix;
   string8 header_casenumber_seq_num;
   string4 header_casenumber_year;
   string2 header_casenumber_suffix;
   string3 header_venue_code;
   string9 header_cji_action_number;
   string3 header_cji_case_type_code;
   string1 header_sort_context;
   string3 header_subjudgement_num;
   string1 header_sort_value;
   string4 header_seq_number;
   string1 header_rec_type;
   string2 header_remarks_seq;
   string14   AMOUNT;
   string12   AMOUNT1 ;// SF Monthly Payment
   string12   AMOUNT2;
   string12   AMOUNT3;
   string12   AMOUNT4;
   string12	CREDIT_AMOUNT;
   string14	TOTAL_AMOUNT;
   string8	second_DOCKET_DATE;
   string15	DEBT_DESCRIPTION;	//SF Book/Page
   string8	INTEREST_DATE ;//SF Mortgage Date
   string3	CREDITOR_COUNT;
   string3	DEBTOR_COUNT;
   string1	DISPOSITION_CODE;
   string8	DISPOSITION_DATE;
   string1	STATUS;
   string8	ASDATE_USED_PD;
   string72	COMMENT;
    string30 disp_code_desc ;
 string30 status_code_desc; 

end ;