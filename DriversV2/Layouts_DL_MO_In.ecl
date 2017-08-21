export Layouts_DL_MO_In := module

  // basic file record lenght 376
	export Layout_MO_Basic := record
		 ebcdic	string10 UNIQUE_KEY;
		 ebcdic	string25 STREET;
		 ebcdic	string20 CITY;
		 ebcdic	string2  STATE;
		 ebcdic	string9  ZIP;
		 ebcdic	string4  COUTY_MODL;
		 ebcdic string3  HEIGHT; 
		 ebcdic string3  WEIGHT;
		 ebcdic string1  EYES;
		 ebcdic string8	 LIC_EXP_DATE; 
		 ebcdic string8  ID_EXP_DATE;
		 ebcdic string2	 CLASS;
		 ebcdic string2  OPER_STATUS;
		 ebcdic string2  COMM_STATUS;
		 ebcdic string2  SCHL_BUS_STATUS;
		 ebcdic string2  STOP_ACTIVITY;
		 ebcdic string1	 HOLD_ACTION; 
		 ebcdic string1  ID_CARD_IC;
		 ebcdic string1	 LIC_IC;
		 ebcdic string1	 PERMIT_IND; 
		 ebcdic string1	 DONOR_IND; 
		 ebcdic string1	 MULTI_IC;
		 ebcdic string1  DECEASED_IND;
		 ebcdic string1	 SPEC_HANDLG;
		 ebcdic string1	 LIS_HIST;
		 ebcdic string11 MICRO_FILM;
		 ebcdic string8	 DOC_DATE;
		 ebcdic string8	 NA_USER_ID; 
		 ebcdic string8	 LUPT_DATE;
		 ebcdic string1	 RDP_TDP_CD;
		 ebcdic string1	 PEND_ACTION;
		 ebcdic string1	 MUST_TEST;
		 ebcdic string1	 RDPA_ELIG;
		 ebcdic string1  LIC_ISS_CD;
		 ebcdic string8  ISS_DATE;
		 ebcdic string2	 PREV_CLASS;
		 ebcdic string1	 OPEN_MI;
		 ebcdic string1  PDPS_PTR;
		 ebcdic string1  LIS_PTR;
		 ebcdic string8  WALKIN_DATE;
		 ebcdic string1  DPPA_CODE;
		 ebcdic string66 FILLER_1;
		 ebcdic string25 Lastname;
		 ebcdic string15 Firstname;
		 ebcdic string12 Middlename;
		 ebcdic string3  NAME;
		 ebcdic string10 CLN;
		 ebcdic string2	 FILLER_2;
		 ebcdic string8  BIRTHDATE;
		 ebcdic string1	 SEX;
		 ebcdic string1	 RECORD_TYPE;
		 ebcdic string8  USER_ID_DRV;
		 ebcdic string8  LUPDT_BD;
		 ebcdic string43 FILLER_3;
	end;
	
	export Layout_MO_Basic_with_processdte := record
	    string8 process_date;
		Layout_MO_Basic;		
	end;
	
	// Issues file record lenght 392
	export Layout_MO_Icissu := record
		 ebcdic string10 D_NO_UNIQUE_ID_ISKEY;
		 ebcdic string6  D_DA_DATE_ADDED_ISKEY;
		 ebcdic string8  D_DA_PURGE_ISKEY;
		 ebcdic string2  D_CD_SPECIAL_ISKEY;
		 ebcdic string8  D_NA_USER_ID_ISKEY;
		 ebcdic string8  D_DA_PROCESS_ISKEY;
		 ebcdic string30 FILLER; 
		 ebcdic string1  D_CD_RECORD_TYPE_ISHIS;
		 ebcdic string2  D_CD_TRANS_TYPE_ISHIS;
		 ebcdic string1  D_CD_TRANS_CHG_ISHIS;
		 ebcdic string2  D_NO_SEQUENTIAL_YY_ISHIS;
		 ebcdic string3  D_NO_SEQUENTIAL_OFFICE_ISHIS;
		 ebcdic string3  D_NO_SEQUENTIAL_JUL_ISHIS;
		 ebcdic string1  D_NO_SEQUENTIAL_NO1_ISHIS;
		 ebcdic string3  D_NO_SEQUENTIAL_NO2_ISHIS;
		 ebcdic string8  D_DA_EXPIRATION_ISHIS;
		 ebcdic string1  D_CD_CLASS_ISHIS;
		 ebcdic string1  FILLER1; 
		 ebcdic string10 D_CD_ENDORSEMENTS_X_ISHIS;
		 ebcdic string5  D_CD_RESTRICTIONS_X_ISHS;
		 ebcdic string5	 FILLER2; 
		 ebcdic string7  D_NO_TEST_NUMBER_ISHIS;
		 ebcdic string11 D_NO_MICROFILM_ISHIS;
		 ebcdic string6	 D_DA_MICROFILM_ISHIS;
		 ebcdic string8	 D_DA_PROCESS_ISHIS;
		 ebcdic string8  D_DA_LICENSE_MAILED_ISHIS;
		 ebcdic string2	 D_CD_PROCESS_ISHIS;
		 ebcdic string3  D_CD_PROCESS_REASON_ISHIS;
		 ebcdic string8  D_DA_RETAKE_ISSUED_ISHIS;
		 ebcdic string3  D_CD_RETAKE_ISHIS;
		 ebcdic string8  D_DA_LAST_UPDATE_ISHIS;
		 ebcdic string8  D_NA_USER_ID_ISHIS;
		 ebcdic string42 FILLER3;
		 ebcdic string1  D_CD_COMPACT_TYPE_ISCPS;
		 ebcdic string8  D_DA_SURRENDER_ISCPS;
		 ebcdic string2  D_NA_STATE_ISCPS;
		 ebcdic string1  D_CD_SURRENDER_TYPE_ISCPS;
		 ebcdic string25 D_NO_OS_LICENSE_NO_ISCPS;
		 ebcdic string8  D_DA_PROCESS_ISCPS;
		 ebcdic string8  D_NA_USER_ID_ISCPS;
		 ebcdic string27 FILLER4;
		 ebcdic string1  D_CD_COMPACT_TYPE_ISCPS_1;
		 ebcdic string8  D_DA_SURRENDER_ISCPS_1;
		 ebcdic string2  D_NA_STATE_ISCPS_1;
		 ebcdic string1	 D_CD_SURRENDER_TYPE_ISCPS_1;
		 ebcdic string25 D_NO_OS_LICENSE_NO_ISCPS_1;
		 ebcdic string8  D_DA_PROCESS_ISCPS_1;
		 ebcdic string8  D_NA_USER_ID_ISCPS_1;
		 ebcdic string27 FILLER5;
	end;

	export Layout_MO_Icissu_with_processdte := record
	    string8 process_date;
		Layout_MO_Icissu;		
	end;
	
    // Actions file record lenght 328
	export Layout_MO_Actions := record
        ebcdic string10	D_NO_UNIQUE_ID_ATKEY;
        ebcdic string8	D_DA_DATE_ADDED_ATKEY;
        ebcdic string8	D_DA_LAST_PURGED_ATKEY;
        ebcdic string8	D_DA_SURRENDERED_ATKEY;
        ebcdic string1	D_IC_LIC_DESTROYED_ATKEY;
        ebcdic string8	D_DA_SURR_PURGED_ATKEY;
        ebcdic string37	FILLER;
        ebcdic string4	D_CD_ACTION_TYPE_ATCAS;
        ebcdic string11	D_NO_CASE_ATCAS;
        ebcdic string9	D_DSC_NEXT_ACTION_ATCAS;
        ebcdic string8	D_DA_EFFECTIVE_ATCAS;
        ebcdic string8	D_DA_ELIG_REINST_ATCAS;
        ebcdic string3	D_CD_ACTION_STAT_ATCAS;
        ebcdic string8	D_DA_ACTION_STAT_ATCAS;
        ebcdic string8	D_DA_FIN_RESP_REQ_ATCAS;
        ebcdic string8	D_DA_ELIG_RDP_ATCAS;
        ebcdic string8	D_DA_OFFENSE_ATCAS;
        ebcdic string2	D_ADR_STATE_OF_OFFENSE_ATCAS;
        ebcdic string11	D_NO_OUTPUT_MICROFILM_ATCAS;
        ebcdic string1	D_IC_MULT_NOTICE_ATCAS;
        ebcdic string10	D_NO_CERT_MAIL_NO_ATCAS;
        ebcdic string1	D_CD_COMPLIANCE_ATCAS;
        ebcdic string1	FILLER1;
        ebcdic string9	D_NO_TICKET_NO_ATCAS;
        ebcdic string1	D_IC_MATCH_INDICATION_ATCAS;
        ebcdic string1	D_IC_ALCOHOL_INVOLVED_ATCAS;
        ebcdic string2	D_NO_OF_MATCHES_ATCAS;
        ebcdic string1	D_IC_SUPERSEDE_ATCAS;
        ebcdic string1	D_IC_MILT_PT_RED_ATCAS;
        ebcdic string1	D_IC_JOINT_OWN_ATCAS;
        ebcdic string1	D_IC_CONVERSION_ATCAS;
        ebcdic string1	D_IC_HAZ_MAT_INV_ATCAS;
        ebcdic string2	D_IC_CDL_HIST_MATCH_ATCAS;
        ebcdic string1	D_IC_PT_RED_ATCAS;
        ebcdic string1	D_IC_FEE_REQ_ATCAS;
        ebcdic string8	D_DA_CONVICTED_ATCAS;
        ebcdic string1	D_IC_ALCOHOL_FEE_REQ_ATCAS;
        ebcdic string3	D_CD_TRANS_TYPE_ATCAS;
        ebcdic string8	D_NA_USER_ID_ATCAS;
        ebcdic string8	D_DA_UPDATED_ATCAS;
        ebcdic string2	D_NO_PLATES_ATCAS;
        ebcdic string8	D_DA_FEE_REQ_THRU_ATCAS;
        ebcdic string1	D_IC_MANUAL_MANIP_ATCAS;
        ebcdic string1	D_CD_REINST_FEE_REQ_ATCAS;
        ebcdic string1	D_IC_LSF_REQ_ATCAS;
        ebcdic string1	D_IC_REINST_FEE_PD_ATCAS;
        ebcdic string1	D_IC_ALCOHOL_FEE_PD_ATCAS;
        ebcdic string1	D_IC_LSF_PD_ATCAS;
        ebcdic string1	D_IC_PURGE_CASE_ATCAS;
        ebcdic string1	D_IC_SATOP_REQ_ATCAS;
        ebcdic string8	D_DA_ARREST_ATCAS;
        ebcdic string3	D_PCT_BAC_LEVEL_ATCAS;
        ebcdic string1	D_IC_CONV_PLT_INV_ATCAS;
        ebcdic string8	D_DA_PROOF_REQ_ATCAS;
        ebcdic string1	D_CD_PROOF_MET_ATCAS;
        ebcdic string58	FILLER2;
	end;

	export Layout_MO_Actions_Pdate := record
	    string8 process_date;
		Layout_MO_Actions;		
	end;
	
	// Points file record lenght 217
	export Layout_MO_Points := record
        ebcdic string10	D_NO_UNIQUE_ID_PTUKEY;
        ebcdic string8	D_DA_PURGE_PTUKEY;
        ebcdic string8	D_DA_WARNING_PTUKEY;
        ebcdic string14	FILLER_1;
        ebcdic string1	NUM;
        ebcdic string11	D_NO_MICROFILM_PTCONV;
        ebcdic string8	D_DA_CONVICTION_PTCONV;
        ebcdic string9	D_NO_COURT_ORI_PTCONV;
        ebcdic string9	D_DSC_ORI_PTCONV;
        ebcdic string10	D_NO_COURT_CASE_PTCONV;
        ebcdic string8	D_DA_CONV_ADDED_PTCONV;
        ebcdic string1	D_IC_DELETE_PTCONV;
        ebcdic string8	D_NA_ADD_USERID_PTCONV;
        ebcdic string9	D_NO_ARST_AGY_ORI_PTCONV;
        ebcdic string9	D_NO_TICKET_PTCONV;
        ebcdic string8	D_DA_ARREST_PTCONV;
        ebcdic string1	D_IC_CMV_INVOLVED_PTCONV;
        ebcdic string1	D_IC_HAZ_MAT_INVOLVED_PTCONV;
        ebcdic string8	D_CD_ARST_CHARGE_PTCONV;
        ebcdic string4	D_CD_ARST_VIOL_PTCONV;
        ebcdic string8	D_CD_CONV_CHARGE_PTCONV;
        ebcdic string4	D_CD_CONV_VIOL_PTCONV;
        ebcdic string1	D_IC_ADDTL_PTS_REQ_PTCONV;
        ebcdic string1	D_IC_DIP_TICKET_PTCONV;
        ebcdic string2	D_NO_POINTS_ASSESSED_PTCONV;
        ebcdic string3	FILLER_2;
        ebcdic string1	D_IC_LIC_RECD_PTCONV;
        ebcdic string1	D_IC_OLD_CONV_PTCONV;
        ebcdic string1	D_IC_CONVERTED_OLD_SYS_PTCONV;
        ebcdic string1	D_IC_MATCHED_PTCONV;
        ebcdic string2	D_IC_CDL_MATCH_PTCONV;
        ebcdic string8	D_DA_ASSESSMENT_PTCONV;
        ebcdic string1	D_IC_PURGE_CONV_PTCONV;
        ebcdic string38	FILLER_3;
	end;

	export Layout_MO_Points_Pdate := record
	    string8 process_date;
		Layout_MO_Points;		
	end;
	
	// DPRDPS file record lenght 74
	export Layout_MO_DPRDPS := record
        ebcdic string10	D_NO_UNIKEY;
        ebcdic string4	D_CD_PRIV_TYPE_LDPRDP;
        ebcdic string8	D_DA_EFFECTIVE_LDPRDP;
        ebcdic string8	D_DA_EXPIRATION_LDPRDP;
        ebcdic string2	D_CD_LDP_STATUS_LDPRDP;
        ebcdic string8	D_NA_USER_ID_LDPRDP;
        ebcdic string8	D_DA_UPDATED_LDPRDP;
        ebcdic string4	D_NO_DURATION_LDPRDP;
        ebcdic string1	D_IC_EFF_REINST_LDPRDP;
        ebcdic string21	FILLER;
	end;

	export Layout_MO_DPRDPS_Pdate := record
	    string8 process_date;
		Layout_MO_DPRDPS;		
	end;


end;