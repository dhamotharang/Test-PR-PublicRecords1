IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, std;

EXPORT HCP1206_0_0 (DATASET(Risk_Indicators.Layout_Provider_Scoring.Clam_Plus_Healthcare) combinedShells, UNSIGNED1 numberOfReasonCodes = 4) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Provider_Scoring.Clam_Plus_Healthcare combinedShells;

			/* Model Input Variables */
      INTEGER archive_date;
			INTEGER header_first_seen;
			INTEGER date_last_seen;
			STRING ver_sources;
			STRING ver_sources_first_seen;
			STRING ver_sources_NAS;
			STRING ver_sources_last_seen;
			STRING ver_sources_count;
			STRING ver_fname_sources;
			STRING ver_fname_sources_first_seen;
			STRING ver_fname_sources_count;
			STRING ver_lname_sources;
			STRING ver_lname_sources_first_seen;
			STRING ver_lname_sources_count;
			STRING ver_addr_sources;
			STRING ver_addr_sources_first_seen;
			STRING ver_addr_sources_count;
			STRING ver_ssn_sources;
			STRING ver_ssn_sources_first_seen;
			STRING ver_ssn_sources_count;
			STRING email_source_list;
			STRING email_source_first_seen;
			STRING email_source_count;
			INTEGER nas_summary;
			STRING rc_hriskaddrflag;
			STRING rc_ziptypeflag;
			STRING rc_dwelltype;
			STRING rc_zipclass;
			STRING out_addr_type;
			STRING rc_hriskphoneflag;
			STRING rc_hphonetypeflag;
			STRING rc_hphonevalflag;
			STRING rc_addrcommflag;
			STRING ssnlength;
			STRING rc_ssndobflag;
			STRING rc_pwssndobflag;
			STRING rc_ssnvalflag;
			STRING rc_pwssnvalflag;
			STRING rc_decsflag;
			INTEGER impulse_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER did;
			STRING nap_status;
			STRING rc_addrvalflag;
			BOOLEAN dobpop;
			INTEGER combo_dobcount;
			INTEGER combo_fnamecount;
			INTEGER combo_lnamecount;
			INTEGER combo_addrcount;
			INTEGER combo_hphonecount;
			INTEGER combo_ssncount;
			BOOLEAN fnamepop;
			BOOLEAN lnamepop;
			BOOLEAN addrpop;
			BOOLEAN hphnpop;
			STRING add1_advo_address_vacancy;
			STRING add1_advo_throw_back;
			STRING add1_advo_college;
			STRING add1_advo_dnd;
			STRING rc_bansflag;
			BOOLEAN bankrupt;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER Inq_count03;
			INTEGER attr_num_nonderogs180;
			BOOLEAN incar_flag;
			BOOLEAN addrs_prison_history;
			
			// Healthcare Shell Fields
			BOOLEAN sanc_OIG_LEIE_Count;
			BOOLEAN sanc_OIG_LEIE_RAN_Count;
			BOOLEAN sanc_OIG_LEIE_Count_CAff;
			BOOLEAN in_MedLicProfLic_None;
			BOOLEAN in_MedLicProfLic_Exp;
			BOOLEAN in_MedLicProfLic_Same_State;
			BOOLEAN in_MedLicProfLic_Same_State_Exp;
			INTEGER Overall_Year_Min;
			INTEGER Time_On_PS;
			INTEGER Sex_Offense_Count_24;
			INTEGER Sex_Offense_Count_60;
			INTEGER Sex_Offense_Count_61;
			INTEGER sanc_f02_Current_Count;
			INTEGER sanc_f05_Current_Count;
			INTEGER sanc_f06_Current_Count;
			INTEGER sanc_F07_Current_Count;
			INTEGER sanc_F08_Current_Count;
			INTEGER sanc_f11_Current_Count;
			INTEGER sanc_f19_Current_Count;
			INTEGER sanc_f20_Current_Count;
			INTEGER sanc_f21_Current_Count;
			INTEGER sanc_f22_Current_Count;
			INTEGER sanc_f23_Current_Count;
			INTEGER sanc_f24_Current_Count;
			INTEGER sanc_f25_Current_Count;
			INTEGER sanc_f12_Current_Count;
			INTEGER sanc_f16_Current_Count;
			BOOLEAN sanc_os_Current_Count;
			INTEGER sanc_f03_Current_Count;
			INTEGER sanc_f04_Current_Count;
			INTEGER sanc_f09_Current_Count;
			INTEGER sanc_f10_Current_Count;
			INTEGER sanc_f13_Current_Count;
			INTEGER sanc_f17_Current_Count;
			INTEGER sanc_f18_Current_Count;
			INTEGER sanc_f26_Current_Count;
			INTEGER sanc_f01_Current_Count;
			INTEGER sanc_f14_Current_Count;
			INTEGER sanc_f15_Current_Count;
			INTEGER sanc_f02_24_Count;
			INTEGER sanc_f05_24_Count;
			INTEGER sanc_f06_24_Count;
			INTEGER sanc_F07_24_Count;
			INTEGER sanc_F08_24_Count;
			INTEGER sanc_f11_24_Count;
			INTEGER sanc_f19_24_Count;
			INTEGER sanc_f20_24_Count;
			INTEGER sanc_f21_24_Count;
			INTEGER sanc_f22_24_Count;
			INTEGER sanc_f23_24_Count;
			INTEGER sanc_f24_24_Count;
			INTEGER sanc_f25_24_Count;
			INTEGER sanc_f12_24_Count;
			INTEGER sanc_f16_24_Count;
			BOOLEAN sanc_os_24_Count;
			INTEGER sanc_f03_24_Count;
			INTEGER sanc_f04_24_Count;
			INTEGER sanc_f09_24_Count;
			INTEGER sanc_f10_24_Count;
			INTEGER sanc_f13_24_Count;
			INTEGER sanc_f17_24_Count;
			INTEGER sanc_f18_24_Count;
			INTEGER sanc_f26_24_Count;
			INTEGER sanc_f01_24_Count;
			INTEGER sanc_f14_24_Count;
			INTEGER sanc_f15_24_Count;
			INTEGER sanc_f02_60_Count;
			INTEGER sanc_f05_60_Count;
			INTEGER sanc_f06_60_Count;
			INTEGER sanc_F07_60_Count;
			INTEGER sanc_F08_60_Count;
			INTEGER sanc_f11_60_Count;
			INTEGER sanc_f19_60_Count;
			INTEGER sanc_f20_60_Count;
			INTEGER sanc_f21_60_Count;
			INTEGER sanc_f22_60_Count;
			INTEGER sanc_f23_60_Count;
			INTEGER sanc_f24_60_Count;
			INTEGER sanc_f25_60_Count;
			INTEGER sanc_f12_60_Count;
			INTEGER sanc_f16_60_Count;
			BOOLEAN sanc_os_60_Count;
			INTEGER sanc_f03_60_Count;
			INTEGER sanc_f04_60_Count;
			INTEGER sanc_f09_60_Count;
			INTEGER sanc_f10_60_Count;
			INTEGER sanc_f13_60_Count;
			INTEGER sanc_f17_60_Count;
			INTEGER sanc_f18_60_Count;
			INTEGER sanc_f26_60_Count;
			INTEGER sanc_f01_60_Count;
			INTEGER sanc_f14_60_Count;
			INTEGER sanc_f15_60_Count;
			INTEGER sanc_f02_61_Count;
			INTEGER sanc_f05_61_Count;
			INTEGER sanc_f06_61_Count;
			INTEGER sanc_F07_61_Count;
			INTEGER sanc_F08_61_Count;
			INTEGER sanc_f11_61_Count;
			INTEGER sanc_f19_61_Count;
			INTEGER sanc_f20_61_Count;
			INTEGER sanc_f21_61_Count;
			INTEGER sanc_f22_61_Count;
			INTEGER sanc_f23_61_Count;
			INTEGER sanc_f24_61_Count;
			INTEGER sanc_f25_61_Count;
			INTEGER sanc_f12_61_Count;
			INTEGER sanc_f16_61_Count;
			BOOLEAN sanc_os_61_Count;
			INTEGER sanc_f03_61_Count;
			INTEGER sanc_f04_61_Count;
			INTEGER sanc_f09_61_Count;
			INTEGER sanc_f10_61_Count;
			INTEGER sanc_f13_61_Count;
			INTEGER sanc_f17_61_Count;
			INTEGER sanc_f18_61_Count;
			INTEGER sanc_f26_61_Count;
			INTEGER sanc_f01_61_Count;
			INTEGER sanc_f14_61_Count;
			INTEGER sanc_f15_61_Count;
			INTEGER sanc_f02_Current_Count_RAN;
			INTEGER sanc_f05_Current_Count_RAN;
			INTEGER sanc_f06_Current_Count_RAN;
			INTEGER sanc_F07_Current_Count_RAN;
			INTEGER sanc_F08_Current_Count_RAN;
			INTEGER sanc_f11_Current_Count_RAN;
			INTEGER sanc_f19_Current_Count_RAN;
			INTEGER sanc_f20_Current_Count_RAN;
			INTEGER sanc_f21_Current_Count_RAN;
			INTEGER sanc_f22_Current_Count_RAN;
			INTEGER sanc_f23_Current_Count_RAN;
			INTEGER sanc_f24_Current_Count_RAN;
			INTEGER sanc_f25_Current_Count_RAN;
			INTEGER sanc_f12_Current_Count_RAN;
			INTEGER sanc_f16_Current_Count_RAN;
			BOOLEAN sanc_os_Current_Count_RAN;
			INTEGER sanc_f03_Current_Count_RAN;
			INTEGER sanc_f04_Current_Count_RAN;
			INTEGER sanc_f09_Current_Count_RAN;
			INTEGER sanc_f10_Current_Count_RAN;
			INTEGER sanc_f13_Current_Count_RAN;
			INTEGER sanc_f17_Current_Count_RAN;
			INTEGER sanc_f18_Current_Count_RAN;
			INTEGER sanc_f26_Current_Count_RAN;
			INTEGER sanc_f01_Current_Count_RAN;
			INTEGER sanc_f14_Current_Count_RAN;
			INTEGER sanc_f15_Current_Count_RAN;
			INTEGER sanc_f02_24_Count_RAN;
			INTEGER sanc_f05_24_Count_RAN;
			INTEGER sanc_f06_24_Count_RAN;
			INTEGER sanc_F07_24_Count_RAN;
			INTEGER sanc_F08_24_Count_RAN;
			INTEGER sanc_f11_24_Count_RAN;
			INTEGER sanc_f19_24_Count_RAN;
			INTEGER sanc_f20_24_Count_RAN;
			INTEGER sanc_f21_24_Count_RAN;
			INTEGER sanc_f22_24_Count_RAN;
			INTEGER sanc_f23_24_Count_RAN;
			INTEGER sanc_f24_24_Count_RAN;
			INTEGER sanc_f25_24_Count_RAN;
			INTEGER sanc_f12_24_Count_RAN;
			INTEGER sanc_f16_24_Count_RAN;
			BOOLEAN sanc_os_24_Count_RAN;
			INTEGER sanc_f03_24_Count_RAN;
			INTEGER sanc_f04_24_Count_RAN;
			INTEGER sanc_f09_24_Count_RAN;
			INTEGER sanc_f10_24_Count_RAN;
			INTEGER sanc_f13_24_Count_RAN;
			INTEGER sanc_f17_24_Count_RAN;
			INTEGER sanc_f18_24_Count_RAN;
			INTEGER sanc_f26_24_Count_RAN;
			INTEGER sanc_f01_24_Count_RAN;
			INTEGER sanc_f14_24_Count_RAN;
			INTEGER sanc_f15_24_Count_RAN;
			INTEGER sanc_f02_60_Count_RAN;
			INTEGER sanc_f05_60_Count_RAN;
			INTEGER sanc_f06_60_Count_RAN;
			INTEGER sanc_F07_60_Count_RAN;
			INTEGER sanc_F08_60_Count_RAN;
			INTEGER sanc_f11_60_Count_RAN;
			INTEGER sanc_f19_60_Count_RAN;
			INTEGER sanc_f20_60_Count_RAN;
			INTEGER sanc_f21_60_Count_RAN;
			INTEGER sanc_f22_60_Count_RAN;
			INTEGER sanc_f23_60_Count_RAN;
			INTEGER sanc_f24_60_Count_RAN;
			INTEGER sanc_f25_60_Count_RAN;
			INTEGER sanc_f12_60_Count_RAN;
			INTEGER sanc_f16_60_Count_RAN;
			BOOLEAN sanc_os_60_Count_RAN;
			INTEGER sanc_f03_60_Count_RAN;
			INTEGER sanc_f04_60_Count_RAN;
			INTEGER sanc_f09_60_Count_RAN;
			INTEGER sanc_f10_60_Count_RAN;
			INTEGER sanc_f13_60_Count_RAN;
			INTEGER sanc_f17_60_Count_RAN;
			INTEGER sanc_f18_60_Count_RAN;
			INTEGER sanc_f26_60_Count_RAN;
			INTEGER sanc_f01_60_Count_RAN;
			INTEGER sanc_f14_60_Count_RAN;
			INTEGER sanc_f15_60_Count_RAN;
			INTEGER sanc_f02_61_Count_RAN;
			INTEGER sanc_f05_61_Count_RAN;
			INTEGER sanc_f06_61_Count_RAN;
			INTEGER sanc_F07_61_Count_RAN;
			INTEGER sanc_F08_61_Count_RAN;
			INTEGER sanc_f11_61_Count_RAN;
			INTEGER sanc_f19_61_Count_RAN;
			INTEGER sanc_f20_61_Count_RAN;
			INTEGER sanc_f21_61_Count_RAN;
			INTEGER sanc_f22_61_Count_RAN;
			INTEGER sanc_f23_61_Count_RAN;
			INTEGER sanc_f24_61_Count_RAN;
			INTEGER sanc_f25_61_Count_RAN;
			INTEGER sanc_f12_61_Count_RAN;
			INTEGER sanc_f16_61_Count_RAN;
			BOOLEAN sanc_os_61_Count_RAN;
			INTEGER sanc_f03_61_Count_RAN;
			INTEGER sanc_f04_61_Count_RAN;
			INTEGER sanc_f09_61_Count_RAN;
			INTEGER sanc_f10_61_Count_RAN;
			INTEGER sanc_f13_61_Count_RAN;
			INTEGER sanc_f17_61_Count_RAN;
			INTEGER sanc_f18_61_Count_RAN;
			INTEGER sanc_f26_61_Count_RAN;
			INTEGER sanc_f01_61_Count_RAN;
			INTEGER sanc_f14_61_Count_RAN;
			INTEGER sanc_f15_61_Count_RAN;
			INTEGER sanc_f02_Current_Count_CAff;
			INTEGER sanc_f05_Current_Count_CAff;
			INTEGER sanc_f06_Current_Count_CAff;
			INTEGER sanc_F07_Current_Count_CAff;
			INTEGER sanc_F08_Current_Count_CAff;
			INTEGER sanc_f11_Current_Count_CAff;
			INTEGER sanc_f19_Current_Count_CAff;
			INTEGER sanc_f20_Current_Count_CAff;
			INTEGER sanc_f21_Current_Count_CAff;
			INTEGER sanc_f22_Current_Count_CAff;
			INTEGER sanc_f23_Current_Count_CAff;
			INTEGER sanc_f24_Current_Count_CAff;
			INTEGER sanc_f25_Current_Count_CAff;
			INTEGER sanc_f12_Current_Count_CAff;
			INTEGER sanc_f16_Current_Count_CAff;
			BOOLEAN sanc_os_Current_Count_CAff;
			INTEGER sanc_f03_Current_Count_CAff;
			INTEGER sanc_f04_Current_Count_CAff;
			INTEGER sanc_f09_Current_Count_CAff;
			INTEGER sanc_f10_Current_Count_CAff;
			INTEGER sanc_f13_Current_Count_CAff;
			INTEGER sanc_f17_Current_Count_CAff;
			INTEGER sanc_f18_Current_Count_CAff;
			INTEGER sanc_f26_Current_Count_CAff;
			INTEGER sanc_f01_Current_Count_CAff;
			INTEGER sanc_f14_Current_Count_CAff;
			INTEGER sanc_f15_Current_Count_CAff;
			INTEGER sanc_f02_24_Count_CAff;
			INTEGER sanc_f05_24_Count_CAff;
			INTEGER sanc_f06_24_Count_CAff;
			INTEGER sanc_F07_24_Count_CAff;
			INTEGER sanc_F08_24_Count_CAff;
			INTEGER sanc_f11_24_Count_CAff;
			INTEGER sanc_f19_24_Count_CAff;
			INTEGER sanc_f20_24_Count_CAff;
			INTEGER sanc_f21_24_Count_CAff;
			INTEGER sanc_f22_24_Count_CAff;
			INTEGER sanc_f23_24_Count_CAff;
			INTEGER sanc_f24_24_Count_CAff;
			INTEGER sanc_f25_24_Count_CAff;
			INTEGER sanc_f12_24_Count_CAff;
			INTEGER sanc_f16_24_Count_CAff;
			BOOLEAN sanc_os_24_Count_CAff;
			INTEGER sanc_f03_24_Count_CAff;
			INTEGER sanc_f04_24_Count_CAff;
			INTEGER sanc_f09_24_Count_CAff;
			INTEGER sanc_f10_24_Count_CAff;
			INTEGER sanc_f13_24_Count_CAff;
			INTEGER sanc_f17_24_Count_CAff;
			INTEGER sanc_f18_24_Count_CAff;
			INTEGER sanc_f26_24_Count_CAff;
			INTEGER sanc_f01_24_Count_CAff;
			INTEGER sanc_f14_24_Count_CAff;
			INTEGER sanc_f15_24_Count_CAff;
			INTEGER sanc_f02_60_Count_CAff;
			INTEGER sanc_f05_60_Count_CAff;
			INTEGER sanc_f06_60_Count_CAff;
			INTEGER sanc_F07_60_Count_CAff;
			INTEGER sanc_F08_60_Count_CAff;
			INTEGER sanc_f11_60_Count_CAff;
			INTEGER sanc_f19_60_Count_CAff;
			INTEGER sanc_f20_60_Count_CAff;
			INTEGER sanc_f21_60_Count_CAff;
			INTEGER sanc_f22_60_Count_CAff;
			INTEGER sanc_f23_60_Count_CAff;
			INTEGER sanc_f24_60_Count_CAff;
			INTEGER sanc_f25_60_Count_CAff;
			INTEGER sanc_f12_60_Count_CAff;
			INTEGER sanc_f16_60_Count_CAff;
			BOOLEAN sanc_os_60_Count_CAff;
			INTEGER sanc_f03_60_Count_CAff;
			INTEGER sanc_f04_60_Count_CAff;
			INTEGER sanc_f09_60_Count_CAff;
			INTEGER sanc_f10_60_Count_CAff;
			INTEGER sanc_f13_60_Count_CAff;
			INTEGER sanc_f17_60_Count_CAff;
			INTEGER sanc_f18_60_Count_CAff;
			INTEGER sanc_f26_60_Count_CAff;
			INTEGER sanc_f01_60_Count_CAff;
			INTEGER sanc_f14_60_Count_CAff;
			INTEGER sanc_f15_60_Count_CAff;
			INTEGER sanc_f02_61_Count_CAff;
			INTEGER sanc_f05_61_Count_CAff;
			INTEGER sanc_f06_61_Count_CAff;
			INTEGER sanc_F07_61_Count_CAff;
			INTEGER sanc_F08_61_Count_CAff;
			INTEGER sanc_f11_61_Count_CAff;
			INTEGER sanc_f19_61_Count_CAff;
			INTEGER sanc_f20_61_Count_CAff;
			INTEGER sanc_f21_61_Count_CAff;
			INTEGER sanc_f22_61_Count_CAff;
			INTEGER sanc_f23_61_Count_CAff;
			INTEGER sanc_f24_61_Count_CAff;
			INTEGER sanc_f25_61_Count_CAff;
			INTEGER sanc_f12_61_Count_CAff;
			INTEGER sanc_f16_61_Count_CAff;
			BOOLEAN sanc_os_61_Count_CAff;
			INTEGER sanc_f03_61_Count_CAff;
			INTEGER sanc_f04_61_Count_CAff;
			INTEGER sanc_f09_61_Count_CAff;
			INTEGER sanc_f10_61_Count_CAff;
			INTEGER sanc_f13_61_Count_CAff;
			INTEGER sanc_f17_61_Count_CAff;
			INTEGER sanc_f18_61_Count_CAff;
			INTEGER sanc_f26_61_Count_CAff;
			INTEGER sanc_f01_61_Count_CAff;
			INTEGER sanc_f14_61_Count_CAff;
			INTEGER sanc_f15_61_Count_CAff;
			INTEGER GSA_Prov_Recip_24_Curr_cnt;
			INTEGER GSA_Prov_Recip_60_Curr_cnt;
			INTEGER GSA_Prov_Recip_61_Curr_cnt;
			INTEGER GSA_Prov_Proc_24_Curr_cnt;
			INTEGER GSA_Prov_Proc_60_Curr_cnt;
			INTEGER GSA_Prov_Proc_61_Curr_cnt;
			INTEGER GSA_Prov_NonProc_24_Curr_cnt;
			INTEGER GSA_Prov_NonProc_60_Curr_cnt;
			INTEGER GSA_Prov_NonProc_61_Curr_cnt;
			INTEGER GSA_Prov_Recip_24_Old_cnt;
			INTEGER GSA_Prov_Recip_60_Old_cnt;
			INTEGER GSA_Prov_Recip_61_Old_cnt;
			INTEGER GSA_Prov_Proc_24_Old_cnt;
			INTEGER GSA_Prov_Proc_60_Old_cnt;
			INTEGER GSA_Prov_Proc_61_Old_cnt;
			INTEGER GSA_Prov_NonProc_24_Old_cnt;
			INTEGER GSA_Prov_NonProc_60_Old_cnt;
			INTEGER GSA_Prov_NonProc_61_Old_cnt;
			INTEGER GSA_Bus_Recip_24_Curr_cnt;
			INTEGER GSA_Bus_Recip_60_Curr_cnt;
			INTEGER GSA_Bus_Recip_61_Curr_cnt;
			INTEGER GSA_Bus_Proc_24_Curr_cnt;
			INTEGER GSA_Bus_Proc_60_Curr_cnt;
			INTEGER GSA_Bus_Proc_61_Curr_cnt;
			INTEGER GSA_Bus_NonProc_24_Curr_cnt;
			INTEGER GSA_Bus_NonProc_60_Curr_cnt;
			INTEGER GSA_Bus_NonProc_61_Curr_cnt;
			INTEGER GSA_Bus_Recip_24_Old_cnt;
			INTEGER GSA_Bus_Recip_60_Old_cnt;
			INTEGER GSA_Bus_Recip_61_Old_cnt;
			INTEGER GSA_Bus_Proc_24_Old_cnt;
			INTEGER GSA_Bus_Proc_60_Old_cnt;
			INTEGER GSA_Bus_Proc_61_Old_cnt;
			INTEGER GSA_Bus_NonProc_24_Old_cnt;
			INTEGER GSA_Bus_NonProc_60_Old_cnt;
			INTEGER GSA_Bus_NonProc_61_Old_cnt;
			INTEGER GSA_Prov_Recip_24_Curr_cnt_RAN;
			INTEGER GSA_Prov_Recip_60_Curr_cnt_RAN;
			INTEGER GSA_Prov_Recip_61_Curr_cnt_RAN;
			INTEGER GSA_Prov_Proc_24_Curr_cnt_RAN;
			INTEGER GSA_Prov_Proc_60_Curr_cnt_RAN;
			INTEGER GSA_Prov_Proc_61_Curr_cnt_RAN;
			INTEGER GSA_Prov_NonProc_24_Curr_cnt_RAN;
			INTEGER GSA_Prov_NonProc_60_Curr_cnt_RAN;
			INTEGER GSA_Prov_NonProc_61_Curr_cnt_RAN;
			INTEGER GSA_Prov_Recip_24_Old_cnt_RAN;
			INTEGER GSA_Prov_Recip_60_Old_cnt_RAN;
			INTEGER GSA_Prov_Recip_61_Old_cnt_RAN;
			INTEGER GSA_Prov_Proc_24_Old_cnt_RAN;
			INTEGER GSA_Prov_Proc_60_Old_cnt_RAN;
			INTEGER GSA_Prov_Proc_61_Old_cnt_RAN;
			INTEGER GSA_Prov_NonProc_24_Old_cnt_RAN;
			INTEGER GSA_Prov_NonProc_60_Old_cnt_RAN;
			INTEGER GSA_Prov_NonProc_61_Old_cnt_RAN;
			INTEGER GSA_CAff_Recip_24_Curr_cnt;
			INTEGER GSA_CAff_Recip_60_Curr_cnt;
			INTEGER GSA_CAff_Recip_61_Curr_cnt;
			INTEGER GSA_CAff_Proc_24_Curr_cnt;
			INTEGER GSA_CAff_Proc_60_Curr_cnt;
			INTEGER GSA_CAff_Proc_61_Curr_cnt;
			INTEGER GSA_CAff_NonProc_24_Curr_cnt;
			INTEGER GSA_CAff_NonProc_60_Curr_cnt;
			INTEGER GSA_CAff_NonProc_61_Curr_cnt;
			INTEGER GSA_CAff_Recip_24_Old_cnt;
			INTEGER GSA_CAff_Recip_60_Old_cnt;
			INTEGER GSA_CAff_Recip_61_Old_cnt;
			INTEGER GSA_CAff_Proc_24_Old_cnt;
			INTEGER GSA_CAff_Proc_60_Old_cnt;
			INTEGER GSA_CAff_Proc_61_Old_cnt;
			INTEGER GSA_CAff_NonProc_24_Old_cnt;
			INTEGER GSA_CAff_NonProc_60_Old_cnt;
			INTEGER GSA_CAff_NonProc_61_Old_cnt;
			INTEGER GSA_RANCAff_Recip_24_Curr_cnt;
			INTEGER GSA_RANCAff_Recip_60_Curr_cnt;
			INTEGER GSA_RANCAff_Recip_61_Curr_cnt;
			INTEGER GSA_RANCAff_Proc_24_Curr_cnt;
			INTEGER GSA_RANCAff_Proc_60_Curr_cnt;
			INTEGER GSA_RANCAff_Proc_61_Curr_cnt;
			INTEGER GSA_RANCAff_NonProc_24_Curr_cnt;
			INTEGER GSA_RANCAff_NonProc_60_Curr_cnt;
			INTEGER GSA_RANCAff_NonProc_61_Curr_cnt;
			INTEGER GSA_RANCAff_Recip_24_Old_cnt;
			INTEGER GSA_RANCAff_Recip_60_Old_cnt;
			INTEGER GSA_RANCAff_Recip_61_Old_cnt;
			INTEGER GSA_RANCAff_Proc_24_Old_cnt;
			INTEGER GSA_RANCAff_Proc_60_Old_cnt;
			INTEGER GSA_RANCAff_Proc_61_Old_cnt;
			INTEGER GSA_RANCAff_NonProc_24_Old_cnt;
			INTEGER GSA_RANCAff_NonProc_60_Old_cnt;
			INTEGER GSA_RANCAff_NonProc_61_Old_cnt;
			INTEGER JGMT_Foreclosure_Count_24;
			INTEGER JGMT_Forcible_Entry_Count_24;
			INTEGER JGMT_Lien_Other_Count_24;
			INTEGER JGMT_Tax_Lien_Count_24;
			INTEGER JGMT_Landlord_Tenant_Count_24;
			INTEGER JGMT_Civil_Judgment_Count_24;
			INTEGER JGMT_Child_Support_Count_24;
			INTEGER JGMT_Small_Claims_Count_24;
			INTEGER JGMT_Judgment_Other_Count_24;
			INTEGER JGMT_Lawsuit_Pending_Count_24;
			INTEGER JGMT_Other_Count_24;
			INTEGER JGMT_Foreclosure_Count_60;
			INTEGER JGMT_Forcible_Entry_Count_60;
			INTEGER JGMT_Lien_Other_Count_60;
			INTEGER JGMT_Tax_Lien_Count_60;
			INTEGER JGMT_Landlord_Tenant_Count_60;
			INTEGER JGMT_Civil_Judgment_Count_60;
			INTEGER JGMT_Child_Support_Count_60;
			INTEGER JGMT_Small_Claims_Count_60;
			INTEGER JGMT_Judgment_Other_Count_60;
			INTEGER JGMT_Lawsuit_Pending_Count_60;
			INTEGER JGMT_Other_Count_60;
			INTEGER JGMT_Foreclosure_Count_61;
			INTEGER JGMT_Forcible_Entry_Count_61;
			INTEGER JGMT_Lien_Other_Count_61;
			INTEGER JGMT_Tax_Lien_Count_61;
			INTEGER JGMT_Landlord_Tenant_Count_61;
			INTEGER JGMT_Civil_Judgment_Count_61;
			INTEGER JGMT_Child_Support_Count_61;
			INTEGER JGMT_Small_Claims_Count_61;
			INTEGER JGMT_Judgment_Other_Count_61;
			INTEGER JGMT_Lawsuit_Pending_Count_61;
			INTEGER JGMT_Other_Count_61;
			INTEGER JGMT_Foreclosure_Count_ND;
			INTEGER JGMT_Forcible_Entry_Count_ND;
			INTEGER JGMT_Lien_Other_Count_ND;
			INTEGER JGMT_Tax_Lien_Count_ND;
			INTEGER JGMT_Landlord_Tenant_Count_ND;
			INTEGER JGMT_Civil_Judgment_Count_ND;
			INTEGER JGMT_Child_Support_Count_ND;
			INTEGER JGMT_Small_Claims_Count_ND;
			INTEGER JGMT_Judgment_Other_Count_ND;
			INTEGER JGMT_Lawsuit_Pending_Count_ND;
			INTEGER JGMT_Other_Count_ND;
			INTEGER JGMT_Eviction_Flag_Count;
			INTEGER Crim_Red_Misc_cnt_24;
			INTEGER crim_Assault_cnt_24;
			INTEGER crim_Weapon_cnt_24;
			INTEGER crim_Murder_cnt_24;
			INTEGER crim_Child_Abuse_cnt_24;
			INTEGER crim_Forgery_cnt_24;
			INTEGER crim_Theft_cnt_24;
			INTEGER crim_Fraud_cnt_24;
			INTEGER crim_Robbery_cnt_24;
			INTEGER crim_Break_Enter_cnt_24;
			INTEGER crim_Burg_cnt_24;
			INTEGER crim_Harassment_cnt_24;
			INTEGER crim_DWLS_cnt_24;
			INTEGER crim_DUI_cnt_24;
			INTEGER crim_Cont_Subst_cnt_24;
			INTEGER crim_Sex_Crime_cnt_24;
			INTEGER crim_Felony_cnt_24;
			INTEGER crim_Other_cnt_24;
			INTEGER crim_Traffic_cnt_24;
			INTEGER crim_Parking_cnt_24;
			INTEGER crim_Misdemeanor_cnt_24;
			INTEGER crim_Prop_Dmg_cnt_24;
			INTEGER crim_Disorderly_cnt_24;
			INTEGER crim_Trespassing_cnt_24;
			INTEGER crim_Alcohol_cnt_24;
			INTEGER crim_Res_Arrest_cnt_24;
			INTEGER crim_Bad_Check_cnt_24;
			INTEGER Crim_Red_Misc_cnt_60;
			INTEGER crim_Assault_cnt_60;
			INTEGER crim_Weapon_cnt_60;
			INTEGER crim_Murder_cnt_60;
			INTEGER crim_Child_Abuse_cnt_60;
			INTEGER crim_Forgery_cnt_60;
			INTEGER crim_Theft_cnt_60;
			INTEGER crim_Fraud_cnt_60;
			INTEGER crim_Robbery_cnt_60;
			INTEGER crim_Break_Enter_cnt_60;
			INTEGER crim_Burg_cnt_60;
			INTEGER crim_Harassment_cnt_60;
			INTEGER crim_DWLS_cnt_60;
			INTEGER crim_DUI_cnt_60;
			INTEGER crim_Cont_Subst_cnt_60;
			INTEGER crim_Sex_Crime_cnt_60;
			INTEGER crim_Felony_cnt_60;
			INTEGER crim_Other_cnt_60;
			INTEGER crim_Traffic_cnt_60;
			INTEGER crim_Parking_cnt_60;
			INTEGER crim_Misdemeanor_cnt_60;
			INTEGER crim_Prop_Dmg_cnt_60;
			INTEGER crim_Disorderly_cnt_60;
			INTEGER crim_Trespassing_cnt_60;
			INTEGER crim_Alcohol_cnt_60;
			INTEGER crim_Res_Arrest_cnt_60;
			INTEGER crim_Bad_Check_cnt_60;
			INTEGER Crim_Red_Misc_cnt_61;
			INTEGER crim_Assault_cnt_61;
			INTEGER crim_Weapon_cnt_61;
			INTEGER crim_Murder_cnt_61;
			INTEGER crim_Child_Abuse_cnt_61;
			INTEGER crim_Forgery_cnt_61;
			INTEGER crim_Theft_cnt_61;
			INTEGER crim_Fraud_cnt_61;
			INTEGER crim_Robbery_cnt_61;
			INTEGER crim_Break_Enter_cnt_61;
			INTEGER crim_Burg_cnt_61;
			INTEGER crim_Harassment_cnt_61;
			INTEGER crim_DWLS_cnt_61;
			INTEGER crim_DUI_cnt_61;
			INTEGER crim_Cont_Subst_cnt_61;
			INTEGER crim_Sex_Crime_cnt_61;
			INTEGER crim_Felony_cnt_61;
			INTEGER crim_Other_cnt_61;
			INTEGER crim_Traffic_cnt_61;
			INTEGER crim_Parking_cnt_61;
			INTEGER crim_Misdemeanor_cnt_61;
			INTEGER crim_Prop_Dmg_cnt_61;
			INTEGER crim_Disorderly_cnt_61;
			INTEGER crim_Trespassing_cnt_61;
			INTEGER crim_Alcohol_cnt_61;
			INTEGER crim_Res_Arrest_cnt_61;
			INTEGER crim_Bad_Check_cnt_61;
			INTEGER Crim_Red_Misc_cnt_121;
			INTEGER crim_Assault_cnt_121;
			INTEGER crim_Weapon_cnt_121;
			INTEGER crim_Murder_cnt_121;
			INTEGER crim_Child_Abuse_cnt_121;
			INTEGER crim_Forgery_cnt_121;
			INTEGER crim_Theft_cnt_121;
			INTEGER crim_Fraud_cnt_121;
			INTEGER crim_Robbery_cnt_121;
			INTEGER crim_Break_Enter_cnt_121;
			INTEGER crim_Burg_cnt_121;
			INTEGER crim_Harassment_cnt_121;
			INTEGER crim_DWLS_cnt_121;
			INTEGER crim_DUI_cnt_121;
			INTEGER crim_Cont_Subst_cnt_121;
			INTEGER crim_Sex_Crime_cnt_121;
			INTEGER crim_Felony_cnt_121;
			INTEGER crim_Other_cnt_121;
			INTEGER crim_Traffic_cnt_121;
			INTEGER crim_Parking_cnt_121;
			INTEGER crim_Misdemeanor_cnt_121;
			INTEGER crim_Prop_Dmg_cnt_121;
			INTEGER crim_Disorderly_cnt_121;
			INTEGER crim_Trespassing_cnt_121;
			INTEGER crim_Alcohol_cnt_121;
			INTEGER crim_Res_Arrest_cnt_121;
			INTEGER crim_Bad_Check_cnt_121;
			INTEGER crim_RAN_Red_Misc_cnt_24;
			INTEGER crim_RAN_Assault_cnt_24;
			INTEGER crim_RAN_Weapon_cnt_24;
			INTEGER crim_RAN_Murder_cnt_24;
			INTEGER crim_RAN_Child_Abuse_cnt_24;
			INTEGER crim_RAN_Forgery_cnt_24;
			INTEGER crim_RAN_Theft_cnt_24;
			INTEGER crim_RAN_Fraud_cnt_24;
			INTEGER crim_RAN_Robbery_cnt_24;
			INTEGER crim_RAN_Break_Enter_cnt_24;
			INTEGER crim_RAN_Burg_cnt_24;
			INTEGER crim_RAN_Harassment_cnt_24;
			INTEGER crim_RAN_DWLS_cnt_24;
			INTEGER crim_RAN_DUI_cnt_24;
			INTEGER crim_RAN_Cont_Subst_cnt_24;
			INTEGER crim_RAN_Sex_Crime_cnt_24;
			INTEGER crim_RAN_Felony_cnt_24;
			INTEGER crim_RAN_Red_Misc_cnt_60;
			INTEGER crim_RAN_Assault_cnt_60;
			INTEGER crim_RAN_Weapon_cnt_60;
			INTEGER crim_RAN_Murder_cnt_60;
			INTEGER crim_RAN_Child_Abuse_cnt_60;
			INTEGER crim_RAN_Forgery_cnt_60;
			INTEGER crim_RAN_Theft_cnt_60;
			INTEGER crim_RAN_Fraud_cnt_60;
			INTEGER crim_RAN_Robbery_cnt_60;
			INTEGER crim_RAN_Break_Enter_cnt_60;
			INTEGER crim_RAN_Burg_cnt_60;
			INTEGER crim_RAN_Harassment_cnt_60;
			INTEGER crim_RAN_DWLS_cnt_60;
			INTEGER crim_RAN_DUI_cnt_60;
			INTEGER crim_RAN_Cont_Subst_cnt_60;
			INTEGER crim_RAN_Sex_Crime_cnt_60;
			INTEGER crim_RAN_Felony_cnt_60;
			INTEGER crim_RAN_Red_Misc_cnt_61;
			INTEGER crim_RAN_Assault_cnt_61;
			INTEGER crim_RAN_Weapon_cnt_61;
			INTEGER crim_RAN_Murder_cnt_61;
			INTEGER crim_RAN_Child_Abuse_cnt_61;
			INTEGER crim_RAN_Forgery_cnt_61;
			INTEGER crim_RAN_Theft_cnt_61;
			INTEGER crim_RAN_Fraud_cnt_61;
			INTEGER crim_RAN_Robbery_cnt_61;
			INTEGER crim_RAN_Break_Enter_cnt_61;
			INTEGER crim_RAN_Burg_cnt_61;
			INTEGER crim_RAN_Harassment_cnt_61;
			INTEGER crim_RAN_DWLS_cnt_61;
			INTEGER crim_RAN_DUI_cnt_61;
			INTEGER crim_RAN_Cont_Subst_cnt_61;
			INTEGER crim_RAN_Sex_Crime_cnt_61;
			INTEGER crim_RAN_Felony_cnt_61;
			INTEGER crim_RAN_Red_Misc_cnt_121;
			INTEGER crim_RAN_Assault_cnt_121;
			INTEGER crim_RAN_Weapon_cnt_121;
			INTEGER crim_RAN_Murder_cnt_121;
			INTEGER crim_RAN_Child_Abuse_cnt_121;
			INTEGER crim_RAN_Forgery_cnt_121;
			INTEGER crim_RAN_Theft_cnt_121;
			INTEGER crim_RAN_Fraud_cnt_121;
			INTEGER crim_RAN_Robbery_cnt_121;
			INTEGER crim_RAN_Break_Enter_cnt_121;
			INTEGER crim_RAN_Burg_cnt_121;
			INTEGER crim_RAN_Harassment_cnt_121;
			INTEGER crim_RAN_DWLS_cnt_121;
			INTEGER crim_RAN_DUI_cnt_121;
			INTEGER crim_RAN_Cont_Subst_cnt_121;
			INTEGER crim_RAN_Sex_Crime_cnt_121;
			INTEGER crim_RAN_Felony_cnt_121;
			INTEGER Crim_WC_Count;
			INTEGER Crim_WC_Misdemeanor_Count;
			INTEGER Crim_WC_Felony_Count;
			INTEGER Crim_WC_SexCrime_Count;
			INTEGER JGMT_Sum;
			INTEGER JGMT_Flag_Count;
			INTEGER GSA_Provider_Current_Flag;
			INTEGER GSA_Business_Current_Flag;
			INTEGER GSA_Provider_Old_Flag;
			INTEGER GSA_Business_Old_Flag;
			INTEGER Crim_RAN_WC_Felony_Count;
			INTEGER Crim_RAN_WC_Misd_Count;

			/* Model Intermediate Variables */
			INTEGER sysdate;
			INTEGER header_first_seen2;
			REAL8 mth_header_first_seen;
			INTEGER date_last_seen2;
			REAL8 mth_date_last_seen;
			INTEGER ver_src_ak_pos;
			BOOLEAN ver_src_ak;
			INTEGER ver_src_am_pos;
			BOOLEAN ver_src_am;
			INTEGER ver_src_ar_pos;
			BOOLEAN ver_src_ar;
			INTEGER ver_src_cg_pos;
			BOOLEAN ver_src_cg;
			INTEGER ver_src_ds_pos;
			BOOLEAN ver_src_ds;
			INTEGER ver_src_eb_pos;
			BOOLEAN ver_src_eb;
			INTEGER ver_src_em_pos;
			BOOLEAN ver_src_em;
			INTEGER ver_src_e1_pos;
			BOOLEAN ver_src_e1;
			INTEGER ver_src_e2_pos;
			BOOLEAN ver_src_e2;
			INTEGER ver_src_e3_pos;
			BOOLEAN ver_src_e3;
			INTEGER ver_src_e4_pos;
			BOOLEAN ver_src_e4;
			INTEGER ver_src_en_pos;
			BOOLEAN ver_src_en;
			INTEGER ver_src_eq_pos;
			BOOLEAN ver_src_eq;
			INTEGER ver_src_fr_pos;
			REAL8 ver_src_nas_fr;
			INTEGER ver_src_pl_pos;
			BOOLEAN ver_src_pl;
			INTEGER ver_src_vo_pos;
			BOOLEAN ver_src_vo;
			INTEGER ver_src_w_pos;
			BOOLEAN ver_src_w;
			INTEGER ver_src_wp_pos;
			BOOLEAN ver_src_wp;
			INTEGER ver_src_tn_pos;
			BOOLEAN ver_src_tn;
			INTEGER ver_fname_src_ds_pos;
			BOOLEAN ver_fname_src_ds;
			INTEGER ver_fname_src_de_pos;
			BOOLEAN ver_fname_src_de;
			INTEGER ver_lname_src_ds_pos;
			BOOLEAN ver_lname_src_ds;
			INTEGER ver_lname_src_de_pos;
			BOOLEAN ver_lname_src_de;
			INTEGER ver_addr_src_ds_pos;
			BOOLEAN ver_addr_src_ds;
			INTEGER ver_addr_src_de_pos;
			BOOLEAN ver_addr_src_de;
			INTEGER ver_ssn_src_ds_pos;
			BOOLEAN ver_ssn_src_ds;
			INTEGER ver_ssn_src_de_pos;
			BOOLEAN ver_ssn_src_de;
			INTEGER email_src_im_pos;
			BOOLEAN email_src_im;
			BOOLEAN verfst_s;
			BOOLEAN verlst_s;
			BOOLEAN verssn_s;
			BOOLEAN add_pobox_1;
			BOOLEAN phn_disconnected;
			BOOLEAN phn_highrisk_1;
			BOOLEAN ssnpop;
			BOOLEAN ssn_priordob_1;
			BOOLEAN ssn_inval_1;
			BOOLEAN ssn_deceased_1;
			BOOLEAN impulse_flag;
			BOOLEAN lien_rec_unrel_flag;
			BOOLEAN lien_hist_unrel_flag;
			INTEGER did_found;
			BOOLEAN pk_disconnected_1;
			BOOLEAN pk_addinval_1;
			INTEGER pk_num_elements_ver;
			INTEGER pk_num_elements_pop;
			INTEGER pk_rc_numelever_0_2;
			INTEGER pk_rc_numelever_2_2;
			INTEGER pk_rc_numelever_34_3;
			INTEGER pk_rc_numelever_5_3;
			INTEGER pk_rc_numelever_6_3;
			INTEGER pk_rc_numelever_partial_3;
			INTEGER pk_rc_numelever_5_c463;
			INTEGER pk_rc_numelever_6_c463;
			INTEGER pk_rc_numelever_34_c463;
			INTEGER pk_rc_numelever_2_c464;
			INTEGER pk_rc_numelever_partial_c464;
			INTEGER pk_rc_numelever_0_c464;
			INTEGER pk_rc_numelever_5_2;
			INTEGER pk_rc_numelever_2_1;
			INTEGER pk_rc_numelever_partial_2;
			INTEGER pk_rc_numelever_6_2;
			INTEGER pk_rc_numelever_34_2;
			INTEGER pk_rc_numelever_0_1;
			BOOLEAN ver_src_bureau;
			INTEGER pk_r_pos_src_minor;
			BOOLEAN pk_r_pos_src_minor_flag;
			INTEGER ver_src_emerge;
			INTEGER pk_r_pos_src_major;
			INTEGER pk_r_pos_src_cnt;
			INTEGER pk_r_pos_src_cnt_0_2;
			INTEGER pk_r_pos_src_cnt_1_2;
			INTEGER pk_r_pos_src_cnt_2_3;
			INTEGER pk_r_pos_src_cnt_3_3;
			INTEGER pk_r_pos_src_cnt_4_3;
			INTEGER pk_r_pos_src_cnt_5_3;
			INTEGER pk_r_pos_src_cnt_0_1;
			INTEGER pk_r_pos_src_cnt_1_1;
			INTEGER pk_r_pos_src_cnt_2_2;
			INTEGER pk_r_pos_src_cnt_3_2;
			INTEGER pk_r_pos_src_cnt_4_2;
			INTEGER pk_r_pos_src_cnt_5_2;
			INTEGER pk_add1_advo_address_vacancy_1;
			INTEGER pk_add1_advo_throw_back_1;
			INTEGER pk_add1_advo_college_1;
			INTEGER pk_add1_advo_dnd_1;
			INTEGER pk_impulse_flag_1;
			BOOLEAN pk_lien_flag_1;
			BOOLEAN pk_bk_flag_1;
			INTEGER pk_foreclosure_1;
			INTEGER pk_inq_count70_2;
			INTEGER pk_inq_count40_2;
			INTEGER pk_inq_count10_2;
			INTEGER pk_inq_count09_2;
			INTEGER pk_inq_count40_1;
			INTEGER pk_inq_count10_1;
			INTEGER pk_inq_count09_1;
			INTEGER pk_inq_count70_1;
			INTEGER pk_attr_num_nonderogs180_0_2;
			INTEGER pk_attr_num_nonderogs180_1_2;
			INTEGER pk_attr_num_nonderogs180_3_3;
			INTEGER pk_attr_num_nonderogs180_4_3;
			INTEGER pk_attr_num_nonderogs180_5_3;
			INTEGER pk_attr_num_nonderogs180_6_3;
			INTEGER pk_attr_num_nonderogs180_3_2;
			INTEGER pk_attr_num_nonderogs180_6_2;
			INTEGER pk_attr_num_nonderogs180_5_2;
			INTEGER pk_attr_num_nonderogs180_0_1;
			INTEGER pk_attr_num_nonderogs180_1_1;
			INTEGER pk_attr_num_nonderogs180_4_2;
			INTEGER yr_header_first_seen;
			INTEGER pk_yr_header_first_seen_0_2;
			INTEGER pk_yr_header_first_seen_7_2;
			INTEGER pk_yr_header_first_seen_9_2;
			INTEGER pk_yr_header_first_seen_17_3;
			INTEGER pk_yr_header_first_seen_18plus_3;
			INTEGER pk_yr_header_first_seen_9_1;
			INTEGER pk_yr_header_first_seen_17_2;
			INTEGER pk_yr_header_first_seen_18plus_2;
			INTEGER pk_yr_header_first_seen_0_1;
			INTEGER pk_yr_header_first_seen_7_1;
			BOOLEAN did_not_found;
			INTEGER addrs_prison_history_1;
			INTEGER pk_yr_header_first_seen_17_1;
			INTEGER pk_add1_advo_throw_back;
			INTEGER pk_r_pos_src_cnt_5_1;
			INTEGER pk_bk_flag;
			INTEGER pk_inq_count09;
			INTEGER pk_impulse_flag;
			INTEGER pk_rc_numelever_5_1;
			INTEGER pk_add1_advo_dnd;
			INTEGER pk_attr_num_nonderogs180_0;
			INTEGER pk_attr_num_nonderogs180_1;
			INTEGER pk_inq_count10;
			INTEGER pk_attr_num_nonderogs180_3_1;
			INTEGER pk_yr_header_first_seen_9;
			INTEGER ssn_inval;
			INTEGER pk_r_pos_src_cnt_3_1;
			INTEGER pk_yr_header_first_seen_0;
			INTEGER pk_inq_count40;
			INTEGER ssn_deceased;
			INTEGER pk_rc_numelever_34_1;
			INTEGER pk_r_pos_src_cnt_1;
			INTEGER pk_lien_flag;
			INTEGER add_pobox;
			INTEGER pk_add1_advo_college;
			INTEGER pk_rc_numelever_2;
			INTEGER pk_disconnected;
			INTEGER pk_attr_num_nonderogs180_6_1;
			INTEGER ssn_priordob;
			INTEGER pk_r_pos_src_cnt_0;
			INTEGER pk_addinval;
			INTEGER pk_inq_count70;
			INTEGER pk_rc_numelever_6_1;
			INTEGER phn_highrisk;
			INTEGER pk_rc_numelever_0;
			INTEGER pk_attr_num_nonderogs180_5_1;
			INTEGER pk_r_pos_src_cnt_4_1;
			INTEGER pk_add1_advo_address_vacancy;
			INTEGER pk_rc_numelever_partial_1;
			INTEGER pk_yr_header_first_seen_18plus_1;
			INTEGER pk_attr_num_nonderogs180_4_1;
			INTEGER pk_yr_header_first_seen_7;
			INTEGER pk_r_pos_src_cnt_2_1;
			INTEGER pk_foreclosure;
			REAL8 pk_bk_flag2_c486;
			REAL8 pk_bk_flag2;
			BOOLEAN ver_name_src_ds_1;
			BOOLEAN ver_name_src_de_1;
			INTEGER pk_deceased2;
			INTEGER incarceration_y;
			INTEGER leie_hit;
			INTEGER leie_ran_hit;
			INTEGER leie_caff_hit;
			INTEGER medlicproflic_none;
			INTEGER medlicproflic_exp;
			INTEGER medlicproflic_same_state_none;
			INTEGER medlicproflic_same_state_exp;
			INTEGER time_on_ps_unknown_1;
			INTEGER time_on_ps_03_1;
			INTEGER time_on_ps_06_1;
			INTEGER time_on_ps_09_2;
			INTEGER time_on_ps_13_2;
			INTEGER time_on_ps_18_2;
			INTEGER time_on_ps_24_2;
			INTEGER time_on_ps_30_2;
			INTEGER time_on_ps_38_2;
			INTEGER time_on_ps_39_2;
			INTEGER time_on_ps_unknown;
			INTEGER time_on_ps_39_1;
			INTEGER time_on_ps_03;
			INTEGER time_on_ps_13_1;
			INTEGER time_on_ps_18_1;
			INTEGER time_on_ps_38_1;
			INTEGER time_on_ps_24_1;
			INTEGER time_on_ps_30_1;
			INTEGER time_on_ps_06;
			INTEGER time_on_ps_09_1;
			REAL8 sex_offense_tot_1;
			REAL8 sex_offense_tot;
			INTEGER sanction_black_current_count_1;
			INTEGER sanction_red_current_count_1;
			INTEGER sanction_yellow_current_count_2;
			INTEGER sanc_accusation_current_count;
			INTEGER mult_accusation_adj_3;
			INTEGER sanction_yellow_current_count_1;
			INTEGER sanction_black_24_count_1;
			INTEGER sanction_red_24_count_1;
			INTEGER sanction_yellow_24_count_2;
			INTEGER sanc_accusation_24_count;
			INTEGER mult_accusation_adj_2;
			INTEGER sanction_yellow_24_count_1;
			INTEGER sanction_black_60_count_1;
			INTEGER sanction_red_60_count_1;
			INTEGER sanction_yellow_60_count_2;
			INTEGER sanc_accusation_60_count;
			INTEGER mult_accusation_adj_1;
			INTEGER sanction_yellow_60_count_1;
			INTEGER sanction_black_61_count_1;
			INTEGER sanction_red_61_count_1;
			INTEGER sanction_yellow_61_count_2;
			INTEGER sanc_accusation_61_count;
			INTEGER mult_accusation_adj;
			INTEGER sanction_yellow_61_count_1;
			INTEGER sanction_black_current_count;
			INTEGER sanction_red_current_count;
			INTEGER sanction_yellow_current_count;
			INTEGER sanction_black_24_count;
			INTEGER sanction_red_24_count;
			INTEGER sanction_yellow_24_count;
			INTEGER sanction_black_60_count;
			INTEGER sanction_red_60_count;
			INTEGER sanction_yellow_60_count;
			INTEGER sanction_black_61_count;
			INTEGER sanction_red_61_count;
			INTEGER sanction_yellow_61_count;
			REAL8 sanction_black_count;
			REAL8 sanction_red_count;
			REAL8 sanction_yellow_count;
			REAL8 sanction_points_1;
			REAL8 sanction_points;
			INTEGER wc_sanction_count;
			INTEGER sanc_black_current_count_ran_1;
			INTEGER sanc_red_current_count_ran_1;
			INTEGER sanc_yellow_current_count_ran_2;
			INTEGER sanc_acc_curr_cnt_ran;
			INTEGER mult_accusation_adj_current_ran;
			INTEGER sanc_yellow_current_count_ran_1;
			INTEGER sanc_black_24_count_ran_1;
			INTEGER sanc_red_24_count_ran_1;
			INTEGER sanc_yellow_24_count_ran_2;
			INTEGER sanc_accusation_24_count_ran;
			INTEGER mult_accusation_adj_24_ran;
			INTEGER sanc_yellow_24_count_ran_1;
			INTEGER sanc_black_60_count_ran_1;
			INTEGER sanc_red_60_count_ran_1;
			INTEGER sanc_yellow_60_count_ran_2;
			INTEGER sanc_accusation_60_count_ran;
			INTEGER mult_accusation_adj_60_ran;
			INTEGER sanc_yellow_60_count_ran_1;
			INTEGER sanc_black_61_count_ran_1;
			INTEGER sanc_red_61_count_ran_1;
			INTEGER sanc_yellow_61_count_ran_2;
			INTEGER sanc_accusation_61_count_ran;
			INTEGER mult_accusation_adj_61_ran;
			INTEGER sanc_yellow_61_count_ran_1;
			INTEGER sanc_black_current_count_ran;
			INTEGER sanc_red_current_count_ran;
			INTEGER sanc_yellow_current_count_ran;
			INTEGER sanc_black_24_count_ran;
			INTEGER sanc_red_24_count_ran;
			INTEGER sanc_yellow_24_count_ran;
			INTEGER sanc_black_60_count_ran;
			INTEGER sanc_red_60_count_ran;
			INTEGER sanc_yellow_60_count_ran;
			INTEGER sanc_black_61_count_ran;
			INTEGER sanc_red_61_count_ran;
			INTEGER sanc_yellow_61_count_ran;
			REAL8 sanc_black_count_ran;
			REAL8 sanc_red_count_ran;
			REAL8 sanc_yellow_count_ran;
			REAL8 sanction_points_ran_1;
			REAL8 sanction_points_ran;
			INTEGER sanc_black_current_count_caff_1;
			INTEGER sanc_red_current_count_caff_1;
			INTEGER sanc_yellow_current_count_caff_2;
			INTEGER sanc_acc_curr_cnt_caff;
			INTEGER mult_accusation_adj_current_caff;
			INTEGER sanc_yellow_current_count_caff_1;
			INTEGER sanc_black_24_count_caff_1;
			INTEGER sanc_red_24_count_caff_1;
			INTEGER sanc_yellow_24_count_caff_2;
			INTEGER sanc_accusation_24_count_caff;
			INTEGER mult_accusation_adj_24_caff;
			INTEGER sanc_yellow_24_count_caff_1;
			INTEGER sanc_black_60_count_caff_1;
			INTEGER sanc_red_60_count_caff_1;
			INTEGER sanc_yellow_60_count_caff_2;
			INTEGER sanc_accusation_60_count_caff;
			INTEGER mult_accusation_adj_60_caff;
			INTEGER sanc_yellow_60_count_caff_1;
			INTEGER sanc_black_61_count_caff_1;
			INTEGER sanc_red_61_count_caff_1;
			INTEGER sanc_yellow_61_count_caff_2;
			INTEGER sanc_accusation_61_count_caff;
			INTEGER mult_accusation_adj_61_caff;
			INTEGER sanc_yellow_61_count_caff_1;
			INTEGER sanc_black_current_count_caff;
			INTEGER sanc_red_current_count_caff;
			INTEGER sanc_yellow_current_count_caff;
			INTEGER sanc_black_24_count_caff;
			INTEGER sanc_red_24_count_caff;
			INTEGER sanc_yellow_24_count_caff;
			INTEGER sanc_black_60_count_caff;
			INTEGER sanc_red_60_count_caff;
			INTEGER sanc_yellow_60_count_caff;
			INTEGER sanc_black_61_count_caff;
			INTEGER sanc_red_61_count_caff;
			INTEGER sanc_yellow_61_count_caff;
			REAL8 sanc_black_count_caff;
			REAL8 sanc_red_count_caff;
			REAL8 sanc_yellow_count_caff;
			REAL8 sanction_points_caff_1;
			REAL8 sanction_points_caff;
			REAL8 gsa_corporate_affiliation_count;
			REAL8 gsa_rancaff_count_2;
			REAL8 gsa_rancaff_count_1;
			REAL8 gsa_rancaff_count;
			INTEGER judgment_red_count_24_1;
			INTEGER judgment_yellow_count_24_1;
			INTEGER judgment_green_count_24_1;
			INTEGER judgment_red_count_24;
			INTEGER judgment_yellow_count_24;
			INTEGER judgment_green_count_24;
			INTEGER judgment_red_count_60_1;
			INTEGER judgment_yellow_count_60_1;
			INTEGER judgment_green_count_60_1;
			INTEGER judgment_red_count_60;
			INTEGER judgment_yellow_count_60;
			INTEGER judgment_green_count_60;
			INTEGER judgment_red_count_61_1;
			INTEGER judgment_yellow_count_61_1;
			INTEGER judgment_green_count_61_1;
			INTEGER judgment_red_count_61;
			INTEGER judgment_yellow_count_61;
			INTEGER judgment_green_count_61;
			INTEGER judgment_red_count_nd_1;
			INTEGER judgment_yellow_count_nd_1;
			INTEGER judgment_green_count_nd_1;
			INTEGER judgment_red_count_nd;
			INTEGER judgment_yellow_count_nd;
			INTEGER judgment_green_count_nd;
			REAL8 judgment_red_count;
			REAL8 judgment_yellow_count;
			REAL8 judgment_green_count;
			REAL8 judgment_points_1;
			REAL8 judgment_points;
			INTEGER criminal_offense_red_cnt_24_1;
			INTEGER criminal_offense_yellow_cnt_24_1;
			INTEGER criminal_offense_green_cnt_24_1;
			INTEGER criminal_offense_red_cnt_60_1;
			INTEGER criminal_offense_yellow_cnt_60_1;
			INTEGER criminal_offense_green_cnt_60_1;
			INTEGER criminal_offense_red_cnt_61_1;
			INTEGER criminal_offense_yellow_cnt_61_1;
			INTEGER criminal_offense_green_cnt_61_1;
			INTEGER criminal_offense_red_cnt_121_1;
			INTEGER criminal_offense_yellow_cnt_121_1;
			INTEGER criminal_offense_green_cnt_121_1;
			INTEGER criminal_offense_red_cnt_24;
			INTEGER criminal_offense_yellow_cnt_24;
			INTEGER criminal_offense_green_cnt_24;
			INTEGER criminal_offense_red_cnt_60;
			INTEGER criminal_offense_yellow_cnt_60;
			INTEGER criminal_offense_green_cnt_60;
			INTEGER criminal_offense_red_cnt_61;
			INTEGER criminal_offense_yellow_cnt_61;
			INTEGER criminal_offense_green_cnt_61;
			INTEGER criminal_offense_red_cnt_121;
			INTEGER criminal_offense_yellow_cnt_121;
			INTEGER criminal_offense_green_cnt_121;
			REAL8 criminal_offense_red_count;
			REAL8 criminal_offense_yellow_count;
			REAL8 criminal_offense_green_count;
			REAL8 criminal_offense_points_1;
			REAL8 criminal_offense_points;
			INTEGER crim_ran_offense_red_cnt_24_1;
			INTEGER crim_ran_offense_yellow_cnt_24_1;
			INTEGER crim_ran_offense_red_cnt_60_1;
			INTEGER crim_ran_offense_yellow_cnt_60_1;
			INTEGER crim_ran_offense_red_cnt_61_1;
			INTEGER crim_ran_offense_yellow_cnt_61_1;
			INTEGER crim_ran_offense_red_cnt_121_1;
			INTEGER crim_ran_offense_yellow_cnt_121_1;
			INTEGER crim_ran_offense_red_cnt_24;
			INTEGER crim_ran_offense_yellow_cnt_24;
			INTEGER crim_ran_offense_red_cnt_60;
			INTEGER crim_ran_offense_yellow_cnt_60;
			INTEGER crim_ran_offense_red_cnt_61;
			INTEGER crim_ran_offense_yellow_cnt_61;
			INTEGER crim_ran_offense_red_cnt_121;
			INTEGER crim_ran_offense_yellow_cnt_121;
			REAL8 crim_ran_offense_red_count;
			REAL8 crim_ran_offense_yellow_count;
			REAL8 criminal_offense_points_ran_1;
			REAL8 criminal_offense_points_ran;
			INTEGER pk_attr_num_nonderogs180_6;
			INTEGER pk_yr_header_first_seen_17;
			INTEGER pk_r_pos_src_cnt_5;
			INTEGER pk_rc_numelever_5;
			INTEGER time_on_ps_38;
			INTEGER pk_rc_numelever_6;
			INTEGER time_on_ps_09;
			INTEGER pk_attr_num_nonderogs180_5;
			INTEGER time_on_ps_39;
			INTEGER pk_r_pos_src_cnt_4;
			INTEGER time_on_ps_13;
			INTEGER time_on_ps_18;
			INTEGER pk_attr_num_nonderogs180_3;
			INTEGER pk_yr_header_first_seen_18plus;
			INTEGER time_on_ps_24;
			INTEGER pk_r_pos_src_cnt_3;
			INTEGER pk_rc_numelever_partial;
			INTEGER time_on_ps_30;
			INTEGER pk_attr_num_nonderogs180_4;
			INTEGER pk_r_pos_src_cnt_2;
			INTEGER pk_rc_numelever_34;
			REAL8 gsa_count_2;
			REAL8 gsa_count_1;
			REAL8 gsa_count;
			REAL8 gsa_ran_count_2;
			REAL8 gsa_ran_count_1;
			REAL8 gsa_ran_count;
			REAL8 hps_score_7;
			REAL8 hps_score_diff_1;
			REAL8 hps_score_diff;
			REAL8 hps_score_diff2;
			REAL8 hps_score_6;
			INTEGER hps_score_5;
			INTEGER hps_score_4;
			INTEGER hps_score_3;
			INTEGER hps_score_2;
			INTEGER hps_score_1;
			INTEGER hps_score;
			INTEGER wc_c100_2;
			INTEGER wc_c200_3;
			INTEGER wc_c300_1;
			INTEGER wc_c400_1;
			INTEGER wc_c500_1;
			INTEGER wc_c600_1;
			INTEGER wc_c700_1;
			INTEGER wc_c800_1;
			INTEGER wc_c900_1;
			INTEGER wc_d100_1;
			INTEGER wc_d200_1;
			INTEGER wc_d300_1;
			INTEGER wc_f100_1;
			INTEGER wc_f200_1;
			INTEGER wc_f300;
			INTEGER wc_f400;
			INTEGER wc_f500_1;
			INTEGER wc_f600_1;
			INTEGER wc_id100_1;
			INTEGER wc_l100_1;
			INTEGER wc_l200_1;
			INTEGER wc_l300_1;
			INTEGER wc_s100_2;
			INTEGER wc_s200_1;
			INTEGER wc_s300_1;
			INTEGER wc_s400_1;
			INTEGER wc_s500_1;
			INTEGER wc_a100_1;
			INTEGER wc_a200_1;
			INTEGER wc_a300_1;
			INTEGER wc_a400_1;
			INTEGER wc_a450_1;
			INTEGER wc_a500_1;
			INTEGER wc_a600_1;
			INTEGER wc_a700_1;
			INTEGER wc_a800_1;
			INTEGER wc_a900_1;
			INTEGER wc_x100_1;
			INTEGER wc_x200_1;
			INTEGER wc_x300_1;
			INTEGER wc_v100_1;
			INTEGER wc_v200_1;
			INTEGER wc_v300_1;
			INTEGER wc_c200_2;
			INTEGER wc_c100_1;
			INTEGER wc_c400;
			INTEGER wc_c300;
			INTEGER wc_c600;
			INTEGER wc_c500;
			INTEGER wc_c700;
			INTEGER wc_c800;
			INTEGER wc_c900;
			BOOLEAN ver_name_src_ds;
			BOOLEAN ver_name_src_de;
			INTEGER wc_d100;
			INTEGER wc_d300;
			INTEGER wc_d200;
			INTEGER wc_f200;
			INTEGER wc_f100;
			INTEGER wc_f500;
			INTEGER wc_f600;
			BOOLEAN ver_name_s;
			INTEGER wc_id100;
			INTEGER wc_id200;
			INTEGER wc_l200;
			INTEGER wc_l300;
			INTEGER wc_l100;
			INTEGER wc_s200;
			INTEGER wc_s100_1;
			INTEGER wc_s100;
			INTEGER wc_s300;
			INTEGER wc_s400;
			INTEGER wc_s500;
			INTEGER wc_a100;
			INTEGER wc_a200;
			INTEGER wc_a300;
			INTEGER wc_a400;
			INTEGER wc_a450;
			INTEGER wc_a600;
			INTEGER wc_a500;
			INTEGER wc_a800;
			INTEGER wc_a700;
			INTEGER wc_a900;
			INTEGER wc_x100;
			INTEGER wc_x200;
			INTEGER wc_x300;
			INTEGER wc_v100;
			INTEGER wc_v200;
			INTEGER wc_v300;
			INTEGER wc_c100;
			INTEGER wc_c200_1;
			INTEGER wc_c200;
			INTEGER wc_c100_pts_2;
			INTEGER wc_c200_pts_2;
			INTEGER wc_c300_pts_2;
			INTEGER wc_c400_pts_2;
			INTEGER wc_c500_pts_2;
			INTEGER wc_c600_pts_2;
			INTEGER wc_c700_pts_3;
			INTEGER wc_c800_pts_3;
			INTEGER wc_c900_pts_3;
			INTEGER wc_d100_pts_2;
			INTEGER wc_d200_pts_2;
			INTEGER wc_d300_pts_2;
			INTEGER wc_f100_pts_2;
			INTEGER wc_f200_pts_2;
			INTEGER wc_f300_pts_1;
			INTEGER wc_f400_pts_1;
			INTEGER wc_f500_pts_4;
			INTEGER wc_f600_pts_4;
			INTEGER wc_id100_pts_2;
			INTEGER wc_id200_pts_5;
			INTEGER wc_l100_pts_5;
			INTEGER wc_l200_pts_5;
			INTEGER wc_l300_pts_5;
			INTEGER wc_s100_pts_2;
			INTEGER wc_s200_pts_2;
			INTEGER wc_s300_pts_2;
			INTEGER wc_s400_pts_2;
			INTEGER wc_s500_pts_2;
			INTEGER wc_a100_pts_2;
			INTEGER wc_a200_pts_2;
			INTEGER wc_a300_pts_2;
			INTEGER wc_a400_pts_2;
			INTEGER wc_a450_pts_2;
			INTEGER wc_a500_pts_2;
			INTEGER wc_a600_pts_2;
			INTEGER wc_a700_pts_2;
			INTEGER wc_a800_pts_2;
			INTEGER wc_a900_pts_2;
			INTEGER wc_x100_pts_2;
			INTEGER wc_x200_pts_3;
			INTEGER wc_x300_pts_7;
			INTEGER wc_v100_pts_4;
			INTEGER wc_v200_pts_2;
			INTEGER wc_v300_pts_4;
			REAL8 wc_c100_pts_1;
			REAL8 wc_c200_pts_1;
			REAL8 wc_c300_pts_1;
			REAL8 wc_c400_pts_1;
			REAL8 wc_c500_pts_1;
			REAL8 wc_c600_pts_1;
			INTEGER wc_c700_pts_2;
			INTEGER wc_c700_pts_1;
			REAL8 wc_c800_pts_2;
			REAL8 wc_c800_pts_1;
			REAL8 wc_c900_pts_2;
			REAL8 wc_c900_pts_1;
			INTEGER wc_d100_pts_1;
			INTEGER wc_d200_pts_1;
			INTEGER wc_d300_pts_1;
			REAL8 wc_f100_pts_1;
			REAL8 wc_f200_pts_1;
			INTEGER wc_f500_pts_3;
			INTEGER wc_f500_pts_2;
			REAL8 wc_f500_pts_1;
			INTEGER wc_f600_pts_3;
			INTEGER wc_f600_pts_2;
			REAL8 wc_f600_pts_1;
			INTEGER wc_id100_pts_1;
			INTEGER wc_id200_pts_4;
			INTEGER wc_id200_pts_3;
			INTEGER wc_id200_pts_2;
			INTEGER wc_id200_pts_1;
			INTEGER wc_l100_pts_4;
			INTEGER wc_l100_pts_3;
			INTEGER wc_l100_pts_2;
			INTEGER wc_l100_pts_1;
			INTEGER wc_l200_pts_4;
			INTEGER wc_l200_pts_3;
			INTEGER wc_l200_pts_2;
			INTEGER wc_l200_pts_1;
			INTEGER wc_l300_pts_4;
			INTEGER wc_l300_pts_3;
			INTEGER wc_l300_pts_2;
			INTEGER wc_l300_pts_1;
			REAL8 wc_s100_pts_1;
			REAL8 wc_s200_pts_1;
			REAL8 wc_s300_pts_1;
			REAL8 wc_s400_pts_1;
			REAL8 wc_s500_pts_1;
			REAL8 wc_a100_pts_1;
			REAL8 wc_a200_pts_1;
			REAL8 wc_a300_pts_1;
			REAL8 wc_a400_pts_1;
			REAL8 wc_a450_pts_1;
			REAL8 wc_a500_pts_1;
			REAL8 wc_a600_pts_1;
			REAL8 wc_a700_pts_1;
			REAL8 wc_a800_pts_1;
			REAL8 wc_a900_pts_1;
			INTEGER wc_x100_pts_1;
			INTEGER wc_x200_pts_2;
			INTEGER wc_x200_pts_1;
			INTEGER wc_x300_pts_6;
			INTEGER wc_x300_pts_5;
			INTEGER wc_x300_pts_4;
			INTEGER wc_x300_pts_3;
			INTEGER wc_x300_pts_2;
			INTEGER wc_x300_pts_1;
			INTEGER wc_v100_pts_3;
			INTEGER wc_v100_pts_2;
			INTEGER wc_v100_pts_1;
			INTEGER wc_v200_pts_1;
			INTEGER wc_v300_pts_3;
			INTEGER wc_v300_pts_2;
			INTEGER wc_v300_pts_1;
			REAL8 wc_c100_pts;
			REAL8 wc_c200_pts;
			REAL8 wc_c300_pts;
			REAL8 wc_c400_pts;
			REAL8 wc_c500_pts;
			REAL8 wc_c600_pts;
			INTEGER wc_c700_pts;
			REAL8 wc_c800_pts;
			REAL8 wc_c900_pts;
			INTEGER wc_d100_pts;
			INTEGER wc_d200_pts;
			INTEGER wc_d300_pts;
			REAL8 wc_f100_pts;
			REAL8 wc_f200_pts;
			INTEGER wc_f300_pts;
			INTEGER wc_f400_pts;
			REAL8 wc_f500_pts;
			REAL8 wc_f600_pts;
			INTEGER wc_id100_pts;
			INTEGER wc_id200_pts;
			INTEGER wc_l100_pts;
			INTEGER wc_l200_pts;
			INTEGER wc_l300_pts;
			REAL8 wc_s100_pts;
			REAL8 wc_s200_pts;
			REAL8 wc_s300_pts;
			REAL8 wc_s400_pts;
			REAL8 wc_s500_pts;
			REAL8 wc_a100_pts;
			REAL8 wc_a200_pts;
			REAL8 wc_a300_pts;
			REAL8 wc_a400_pts;
			REAL8 wc_a450_pts;
			REAL8 wc_a500_pts;
			REAL8 wc_a600_pts;
			REAL8 wc_a700_pts;
			REAL8 wc_a800_pts;
			REAL8 wc_a900_pts;
			INTEGER wc_x100_pts;
			INTEGER wc_x200_pts;
			INTEGER wc_x300_pts;
			INTEGER wc_v100_pts;
			INTEGER wc_v200_pts;
			INTEGER wc_v300_pts;
			REAL8 pts1;
			REAL8 pts2;
			REAL8 pts3;
			REAL8 pts4;
			REAL8 pts5;
			REAL8 pts6;
			INTEGER pts7;
			REAL8 pts8;
			INTEGER pts9;
			REAL8 pts10;
			INTEGER pts11;
			INTEGER pts12;
			REAL8 pts13;
			REAL8 pts14;
			INTEGER pts15;
			INTEGER pts16;
			REAL8 pts17;
			REAL8 pts18;
			INTEGER pts19;
			INTEGER pts20;
			INTEGER pts21;
			INTEGER pts22;
			INTEGER pts23;
			REAL8 pts24;
			REAL8 pts25;
			REAL8 pts26;
			REAL8 pts27;
			REAL8 pts28;
			REAL8 pts29;
			REAL8 pts30;
			REAL8 pts31;
			REAL8 pts32;
			REAL8 pts33;
			REAL8 pts34;
			REAL8 pts35;
			REAL8 pts36;
			REAL8 pts37;
			INTEGER pts38;
			INTEGER pts39;
			INTEGER pts40;
			INTEGER pts41;
			INTEGER pts42;
			INTEGER pts43;
			REAL8 pts44;

			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
			STRING4 rc5;
			STRING4 rc6;
			STRING4 rc7;
			STRING4 rc8;
		END;
		Layout_Debug doModel(combinedShells le) := TRANSFORM
	#else
		Layout_ModelOut doModel(combinedShells le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	 // Boca Shell Fields
		archive_date	 := IF(le.BocaShell.historydate = 999999, (INTEGER)(((STRING)Std.Date.Today())[1..6]), (INTEGER)(((STRING)le.BocaShell.historydate)[1..6]));
		header_first_seen	 := le.BocaShell.ssn_verification.header_first_seen;
		date_last_seen	 := le.BocaShell.bjl.date_last_seen;
		ver_sources	 := le.BocaShell.header_summary.ver_sources;
		ver_sources_first_seen	 := le.BocaShell.header_summary.ver_sources_first_seen_date;
		ver_sources_NAS	 := le.BocaShell.header_summary.ver_sources_nas;
		ver_sources_last_seen	 := le.BocaShell.header_summary.ver_sources_last_seen_date;
		ver_sources_count	 := le.BocaShell.header_summary.ver_sources_recordcount;
		ver_fname_sources	 := le.BocaShell.header_summary.ver_fname_sources;
		ver_fname_sources_first_seen	 := le.BocaShell.header_summary.ver_fname_sources_first_seen_date;
		ver_fname_sources_count	 := le.BocaShell.header_summary.ver_fname_sources_recordcount;
		ver_lname_sources	 := le.BocaShell.header_summary.ver_lname_sources;
		ver_lname_sources_first_seen	 := le.BocaShell.header_summary.ver_lname_sources_first_seen_date;
		ver_lname_sources_count	 := le.BocaShell.header_summary.ver_lname_sources_recordcount;
		ver_addr_sources	 := le.BocaShell.header_summary.ver_addr_sources;
		ver_addr_sources_first_seen	 := le.BocaShell.header_summary.ver_addr_sources_first_seen_date;
		ver_addr_sources_count	 := le.BocaShell.header_summary.ver_addr_sources_recordcount;
		ver_ssn_sources	 := le.BocaShell.header_summary.ver_ssn_sources;
		ver_ssn_sources_first_seen	 := le.BocaShell.header_summary.ver_ssn_sources_first_seen_date;
		ver_ssn_sources_count	 := le.BocaShell.header_summary.ver_ssn_sources_recordcount;
		email_source_list	 := le.BocaShell.email_summary.email_source_list;
		email_source_first_seen	 := le.BocaShell.email_summary.email_source_first_seen;
		email_source_count	 := le.BocaShell.email_summary.email_source_ct;
		nas_summary	 := le.BocaShell.iid.nas_summary;
		rc_hriskaddrflag	 := le.BocaShell.iid.hriskaddrflag;
		rc_ziptypeflag	 := le.BocaShell.iid.ziptypeflag;
		rc_dwelltype	 := le.BocaShell.iid.dwelltype;
		rc_zipclass	 := le.BocaShell.iid.zipclass;
		out_addr_type	 := le.BocaShell.shell_input.addr_type;
		rc_hriskphoneflag	 := le.BocaShell.iid.hriskphoneflag;
		rc_hphonetypeflag	 := le.BocaShell.iid.hphonetypeflag;
		rc_hphonevalflag	 := le.BocaShell.iid.hphonevalflag;
		rc_addrcommflag	 := le.BocaShell.iid.addrcommflag;
		ssnlength	 := le.BocaShell.input_validation.ssn_length;
		rc_ssndobflag	 := le.BocaShell.iid.socsdobflag;
		rc_pwssndobflag	 := le.BocaShell.iid.pwsocsdobflag;
		rc_ssnvalflag	 := le.BocaShell.iid.socsvalflag;
		rc_pwssnvalflag	 := le.BocaShell.iid.pwsocsvalflag;
		rc_decsflag	 := le.BocaShell.iid.decsflag;
		impulse_count	 := le.BocaShell.impulse.count;
		liens_recent_unreleased_count	 := le.BocaShell.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct	 := le.BocaShell.bjl.liens_historical_unreleased_count;
		did	 := le.BocaShell.did;
		nap_status	 := le.BocaShell.iid.nap_status;
		rc_addrvalflag	 := le.BocaShell.iid.addrvalflag;
		dobpop	 := le.BocaShell.input_validation.dateofbirth;
		combo_dobcount	 := le.BocaShell.iid.combo_dobcount;
		combo_fnamecount	 := le.BocaShell.iid.combo_firstcount;
		combo_lnamecount	 := le.BocaShell.iid.combo_lastcount;
		combo_addrcount	 := le.BocaShell.iid.combo_addrcount;
		combo_hphonecount	 := le.BocaShell.iid.combo_hphonecount;
		combo_ssncount	 := le.BocaShell.iid.combo_ssncount;
		fnamepop	 := le.BocaShell.input_validation.firstname;
		lnamepop	 := le.BocaShell.input_validation.lastname;
		addrpop	 := le.BocaShell.input_validation.address;
		hphnpop	 := le.BocaShell.input_validation.homephone;
		add1_advo_address_vacancy	 := le.BocaShell.advo_input_addr.address_vacancy_indicator;
		add1_advo_throw_back	 := le.BocaShell.advo_input_addr.throw_back_indicator;
		add1_advo_college	 := le.BocaShell.advo_input_addr.college_indicator;
		add1_advo_dnd	 := le.BocaShell.advo_input_addr.dnd_indicator;
		rc_bansflag	 := le.BocaShell.iid.bansflag;
		bankrupt	 := le.BocaShell.bjl.bankrupt;
		filing_count	 := le.BocaShell.bjl.filing_count;
		bk_recent_count	 := le.BocaShell.bjl.bk_recent_count;
		Inq_count03	 := le.BocaShell.acc_logs.inquiries.count03;
		attr_num_nonderogs180	 := le.BocaShell.source_verification.num_nonderogs180;
		addrs_prison_history             := le.BocaShell.other_address_info.isprison;
		
		
		// HealthCare Shell Fields
		incar_flag	 := le.HealthCareShell.PossibleIncarceration;
		in_MedLicProfLic_None	 := le.HealthCareShell.MedLicProfLic_hit = FALSE;
		Overall_Year_Min	 := le.HealthCareShell.Overall_Year_Min;
		Time_On_PS	 := le.HealthCareShell.Time_On_PS;
		Sex_Offense_Count_24	 := le.HealthCareShell.Sex_Offense_Count_24;
		Sex_Offense_Count_60	 := le.HealthCareShell.Sex_Offense_Count_60;
		Sex_Offense_Count_61	 := le.HealthCareShell.Sex_Offense_Count_61;		
		in_MedLicProfLic_Exp	 := le.HealthCareShell.MedLicProfLic_Exp;
		in_MedLicProfLic_Same_State	 := le.HealthCareShell.MedLicProfLic_Same_State;
		in_MedLicProfLic_Same_State_Exp	 := le.HealthCareShell.MedLicProfLic_Same_State_Exp; 
		
		// Sanctions Data
		sanc_f02_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f02_current;
		sanc_f05_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f05_Current;
		sanc_f06_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f06_Current;
		sanc_F07_Current_Count	 := le.HealthCareShell.Sanctions.sanc_F07_Current;
		sanc_F08_Current_Count	 := le.HealthCareShell.Sanctions.sanc_F08_Current;
		sanc_f11_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f11_Current;
		sanc_f19_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f19_Current;
		sanc_f20_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f20_Current;
		sanc_f21_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f21_Current;
		sanc_f22_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f22_Current;
		sanc_f23_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f23_Current; 
		sanc_f24_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f24_Current;
		sanc_f25_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f25_Current;
		sanc_f12_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f12_Current;
		sanc_f16_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f16_Current;
		sanc_os_Current_Count	 := le.HealthCareShell.Sanctions.sanc_os_Current;
		sanc_f03_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f03_Current;
		sanc_f04_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f04_Current;
		sanc_f09_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f09_Current;
		sanc_f10_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f10_Current;
		sanc_f13_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f13_Current;
		sanc_f17_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f17_Current;
		sanc_f18_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f18_Current;
		sanc_f26_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f26_Current;
		sanc_f01_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f01_Current;
		sanc_f14_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f14_Current;
		sanc_f15_Current_Count	 := le.HealthCareShell.Sanctions.sanc_f15_Current;
		sanc_f02_24_Count	 := le.HealthCareShell.Sanctions.sanc_f02_24;
		sanc_f05_24_Count	 := le.HealthCareShell.Sanctions.sanc_f05_24;
		sanc_f06_24_Count	 := le.HealthCareShell.Sanctions.sanc_f06_24;
		sanc_F07_24_Count	 := le.HealthCareShell.Sanctions.sanc_F07_24;
		sanc_F08_24_Count	 := le.HealthCareShell.Sanctions.sanc_F08_24;
		sanc_f11_24_Count	 := le.HealthCareShell.Sanctions.sanc_f11_24;
		sanc_f19_24_Count	 := le.HealthCareShell.Sanctions.sanc_f19_24;
		sanc_f20_24_Count	 := le.HealthCareShell.Sanctions.sanc_f20_24;
		sanc_f21_24_Count	 := le.HealthCareShell.Sanctions.sanc_f21_24;
		sanc_f22_24_Count	 := le.HealthCareShell.Sanctions.sanc_f22_24;
		sanc_f23_24_Count	 := le.HealthCareShell.Sanctions.sanc_f23_24;
		sanc_f24_24_Count	 := le.HealthCareShell.Sanctions.sanc_f24_24;
		sanc_f25_24_Count	 := le.HealthCareShell.Sanctions.sanc_f25_24;
		sanc_f12_24_Count	 := le.HealthCareShell.Sanctions.sanc_f12_24;
		sanc_f16_24_Count	 := le.HealthCareShell.Sanctions.sanc_f16_24;
		sanc_os_24_Count	 := le.HealthCareShell.Sanctions.sanc_os_24;
		sanc_f03_24_Count	 := le.HealthCareShell.Sanctions.sanc_f03_24;
		sanc_f04_24_Count	 := le.HealthCareShell.Sanctions.sanc_f04_24;
		sanc_f09_24_Count	 := le.HealthCareShell.Sanctions.sanc_f09_24;
		sanc_f10_24_Count	 := le.HealthCareShell.Sanctions.sanc_f10_24;
		sanc_f13_24_Count	 := le.HealthCareShell.Sanctions.sanc_f13_24;
		sanc_f17_24_Count	 := le.HealthCareShell.Sanctions.sanc_f17_24;
		sanc_f18_24_Count	 := le.HealthCareShell.Sanctions.sanc_f18_24;
		sanc_f26_24_Count	 := le.HealthCareShell.Sanctions.sanc_f26_24;
		sanc_f01_24_Count	 := le.HealthCareShell.Sanctions.sanc_f01_24;
		sanc_f14_24_Count	 := le.HealthCareShell.Sanctions.sanc_f14_24;
		sanc_f15_24_Count	 := le.HealthCareShell.Sanctions.sanc_f15_24;
		sanc_f02_60_Count	 := le.HealthCareShell.Sanctions.sanc_f02_60;
		sanc_f05_60_Count	 := le.HealthCareShell.Sanctions.sanc_f05_60;
		sanc_f06_60_Count	 := le.HealthCareShell.Sanctions.sanc_f06_60;
		sanc_F07_60_Count	 := le.HealthCareShell.Sanctions.sanc_F07_60;
		sanc_F08_60_Count	 := le.HealthCareShell.Sanctions.sanc_F08_60;
		sanc_f11_60_Count	 := le.HealthCareShell.Sanctions.sanc_f11_60;
		sanc_f19_60_Count	 := le.HealthCareShell.Sanctions.sanc_f19_60;
		sanc_f20_60_Count	 := le.HealthCareShell.Sanctions.sanc_f20_60;
		sanc_f21_60_Count	 := le.HealthCareShell.Sanctions.sanc_f21_60;
		sanc_f22_60_Count	 := le.HealthCareShell.Sanctions.sanc_f22_60;
		sanc_f23_60_Count	 := le.HealthCareShell.Sanctions.sanc_f23_60;
		sanc_f24_60_Count	 := le.HealthCareShell.Sanctions.sanc_f24_60;
		sanc_f25_60_Count	 := le.HealthCareShell.Sanctions.sanc_f25_60;
		sanc_f12_60_Count	 := le.HealthCareShell.Sanctions.sanc_f12_60;
		sanc_f16_60_Count	 := le.HealthCareShell.Sanctions.sanc_f16_60;
		sanc_os_60_Count	 := le.HealthCareShell.Sanctions.sanc_os_60;
		sanc_f03_60_Count	 := le.HealthCareShell.Sanctions.sanc_f03_60;
		sanc_f04_60_Count	 := le.HealthCareShell.Sanctions.sanc_f04_60;
		sanc_f09_60_Count	 := le.HealthCareShell.Sanctions.sanc_f09_60;
		sanc_f10_60_Count	 := le.HealthCareShell.Sanctions.sanc_f10_60;
		sanc_f13_60_Count	 := le.HealthCareShell.Sanctions.sanc_f13_60;
		sanc_f17_60_Count	 := le.HealthCareShell.Sanctions.sanc_f17_60;
		sanc_f18_60_Count	 := le.HealthCareShell.Sanctions.sanc_f18_60;
		sanc_f26_60_Count	 := le.HealthCareShell.Sanctions.sanc_f26_60;
		sanc_f01_60_Count	 := le.HealthCareShell.Sanctions.sanc_f01_60;
		sanc_f14_60_Count	 := le.HealthCareShell.Sanctions.sanc_f14_60;
		sanc_f15_60_Count	 := le.HealthCareShell.Sanctions.sanc_f15_60;
		sanc_f02_61_Count	 := le.HealthCareShell.Sanctions.sanc_f02_61;
		sanc_f05_61_Count	 := le.HealthCareShell.Sanctions.sanc_f05_61;
		sanc_f06_61_Count	 := le.HealthCareShell.Sanctions.sanc_f06_61;
		sanc_F07_61_Count	 := le.HealthCareShell.Sanctions.sanc_F07_61;
		sanc_F08_61_Count	 := le.HealthCareShell.Sanctions.sanc_F08_61;
		sanc_f11_61_Count	 := le.HealthCareShell.Sanctions.sanc_f11_61;
		sanc_f19_61_Count	 := le.HealthCareShell.Sanctions.sanc_f19_61;
		sanc_f20_61_Count	 := le.HealthCareShell.Sanctions.sanc_f20_61;
		sanc_f21_61_Count	 := le.HealthCareShell.Sanctions.sanc_f21_61;
		sanc_f22_61_Count	 := le.HealthCareShell.Sanctions.sanc_f22_61;
		sanc_f23_61_Count	 := le.HealthCareShell.Sanctions.sanc_f23_61;
		sanc_f24_61_Count	 := le.HealthCareShell.Sanctions.sanc_f24_61;
		sanc_f25_61_Count	 := le.HealthCareShell.Sanctions.sanc_f25_61;
		sanc_f12_61_Count	 := le.HealthCareShell.Sanctions.sanc_f12_61;
		sanc_f16_61_Count	 := le.HealthCareShell.Sanctions.sanc_f16_61;
		sanc_os_61_Count	 := le.HealthCareShell.Sanctions.sanc_os_61;
		sanc_f03_61_Count	 := le.HealthCareShell.Sanctions.sanc_f03_61;
		sanc_f04_61_Count	 := le.HealthCareShell.Sanctions.sanc_f04_61;
		sanc_f09_61_Count	 := le.HealthCareShell.Sanctions.sanc_f09_61;
		sanc_f10_61_Count	 := le.HealthCareShell.Sanctions.sanc_f10_61;
		sanc_f13_61_Count	 := le.HealthCareShell.Sanctions.sanc_f13_61;
		sanc_f17_61_Count	 := le.HealthCareShell.Sanctions.sanc_f17_61;
		sanc_f18_61_Count	 := le.HealthCareShell.Sanctions.sanc_f18_61;
		sanc_f26_61_Count	 := le.HealthCareShell.Sanctions.sanc_f26_61;
		sanc_f01_61_Count	 := le.HealthCareShell.Sanctions.sanc_f01_61;
		sanc_f14_61_Count	 := le.HealthCareShell.Sanctions.sanc_f14_61;
		sanc_f15_61_Count	 := le.HealthCareShell.Sanctions.sanc_f15_61;
		sanc_OIG_LEIE_Count	 := le.HealthCareShell.Sanctions.sanc_OIG_LEIE;
		
		// Sanctions -- Relatives Data
		sanc_f02_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f02_Current;
		sanc_f05_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f05_Current;
		sanc_f06_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f06_Current;
		sanc_F07_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_F07_Current;
		sanc_F08_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_F08_Current;
		sanc_f11_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f11_Current;
		sanc_f19_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f19_Current;
		sanc_f20_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f20_Current;
		sanc_f21_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f21_Current;
		sanc_f22_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f22_Current;
		sanc_f23_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f23_Current;
		sanc_f24_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f24_Current;
		sanc_f25_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f25_Current;
		sanc_f12_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f12_Current;
		sanc_f16_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f16_Current;
		sanc_os_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_os_Current;
		sanc_f03_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f03_Current;
		sanc_f04_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f04_Current;
		sanc_f09_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f09_Current;
		sanc_f10_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f10_Current;
		sanc_f13_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f13_Current;
		sanc_f17_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f17_Current;
		sanc_f18_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f18_Current;
		sanc_f26_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f26_Current;
		sanc_f01_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f01_Current;
		sanc_f14_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f14_Current;
		sanc_f15_Current_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f15_Current;
		sanc_f02_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f02_24;
		sanc_f05_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f05_24;
		sanc_f06_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f06_24;
		sanc_F07_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_F07_24;
		sanc_F08_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_F08_24;
		sanc_f11_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f11_24;
		sanc_f19_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f19_24;
		sanc_f20_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f20_24;
		sanc_f21_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f21_24;
		sanc_f22_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f22_24;
		sanc_f23_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f23_24;
		sanc_f24_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f24_24;
		sanc_f25_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f25_24;
		sanc_f12_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f12_24;
		sanc_f16_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f16_24;
		sanc_os_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_os_24;
		sanc_f03_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f03_24;
		sanc_f04_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f04_24;
		sanc_f09_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f09_24;
		sanc_f10_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f10_24;
		sanc_f13_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f13_24;
		sanc_f17_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f17_24;
		sanc_f18_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f18_24;
		sanc_f26_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f26_24;
		sanc_f01_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f01_24;
		sanc_f14_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f14_24;
		sanc_f15_24_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f15_24;
		sanc_f02_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f02_60;
		sanc_f05_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f05_60;
		sanc_f06_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f06_60;
		sanc_F07_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_F07_60;
		sanc_F08_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_F08_60;
		sanc_f11_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f11_60;
		sanc_f19_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f19_60;
		sanc_f20_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f20_60;
		sanc_f21_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f21_60;
		sanc_f22_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f22_60;
		sanc_f23_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f23_60;
		sanc_f24_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f24_60;
		sanc_f25_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f25_60;
		sanc_f12_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f12_60;
		sanc_f16_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f16_60;
		sanc_os_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_os_60;
		sanc_f03_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f03_60;
		sanc_f04_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f04_60;
		sanc_f09_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f09_60;
		sanc_f10_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f10_60;
		sanc_f13_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f13_60;
		sanc_f17_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f17_60;
		sanc_f18_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f18_60;
		sanc_f26_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f26_60;
		sanc_f01_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f01_60;
		sanc_f14_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f14_60;
		sanc_f15_60_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f15_60;
		sanc_f02_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f02_61;
		sanc_f05_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f05_61;
		sanc_f06_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f06_61;
		sanc_F07_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_F07_61;
		sanc_F08_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_F08_61;
		sanc_f11_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f11_61;
		sanc_f19_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f19_61;
		sanc_f20_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f20_61;
		sanc_f21_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f21_61;
		sanc_f22_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f22_61;
		sanc_f23_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f23_61;
		sanc_f24_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f24_61;
		sanc_f25_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f25_61;
		sanc_f12_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f12_61;
		sanc_f16_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f16_61;
		sanc_os_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_os_61;
		sanc_f03_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f03_61;
		sanc_f04_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f04_61;
		sanc_f09_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f09_61;
		sanc_f10_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f10_61;
		sanc_f13_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f13_61;
		sanc_f17_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f17_61;
		sanc_f18_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f18_61;
		sanc_f26_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f26_61;
		sanc_f01_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f01_61;
		sanc_f14_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f14_61;
		sanc_f15_61_Count_RAN	 := le.HealthCareShell.RAN_Sanctions.sanc_f15_61;
		sanc_OIG_LEIE_RAN_Count	 := le.HealthCareShell.RAN_Sanctions.sanc_OIG_LEIE;
		
		// Sanctions -- Business Data
		sanc_f02_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f02_Current;
		sanc_f05_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f05_Current;
		sanc_f06_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f06_Current;
		sanc_F07_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_F07_Current;
		sanc_F08_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_F08_Current;
		sanc_f11_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f11_Current;
		sanc_f19_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f19_Current;
		sanc_f20_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f20_Current;
		sanc_f21_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f21_Current;
		sanc_f22_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f22_Current;
		sanc_f23_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f23_Current;
		sanc_f24_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f24_Current;
		sanc_f25_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f25_Current;
		sanc_f12_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f12_Current;
		sanc_f16_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f16_Current;
		sanc_os_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_os_Current;
		sanc_f03_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f03_Current;
		sanc_f04_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f04_Current;
		sanc_f09_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f09_Current;
		sanc_f10_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f10_Current;
		sanc_f13_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f13_Current;
		sanc_f17_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f17_Current;
		sanc_f18_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f18_Current;
		sanc_f26_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f26_Current;
		sanc_f01_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f01_Current;
		sanc_f14_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f14_Current;
		sanc_f15_Current_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f15_Current;
		sanc_f02_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f02_24;
		sanc_f05_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f05_24;
		sanc_f06_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f06_24;
		sanc_F07_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_F07_24;
		sanc_F08_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_F08_24;
		sanc_f11_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f11_24;
		sanc_f19_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f19_24;
		sanc_f20_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f20_24;
		sanc_f21_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f21_24;
		sanc_f22_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f22_24;
		sanc_f23_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f23_24;
		sanc_f24_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f24_24;
		sanc_f25_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f25_24;
		sanc_f12_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f12_24;
		sanc_f16_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f16_24;
		sanc_os_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_os_24;
		sanc_f03_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f03_24;
		sanc_f04_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f04_24;
		sanc_f09_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f09_24;
		sanc_f10_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f10_24;
		sanc_f13_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f13_24;
		sanc_f17_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f17_24;
		sanc_f18_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f18_24;
		sanc_f26_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f26_24;
		sanc_f01_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f01_24;
		sanc_f14_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f14_24;
		sanc_f15_24_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f15_24;
		sanc_f02_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f02_60;
		sanc_f05_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f05_60;
		sanc_f06_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f06_60;
		sanc_F07_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_F07_60;
		sanc_F08_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_F08_60;
		sanc_f11_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f11_60;
		sanc_f19_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f19_60;
		sanc_f20_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f20_60;
		sanc_f21_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f21_60;
		sanc_f22_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f22_60;
		sanc_f23_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f23_60;
		sanc_f24_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f24_60;
		sanc_f25_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f25_60;
		sanc_f12_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f12_60;
		sanc_f16_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f16_60;
		sanc_os_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_os_60;
		sanc_f03_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f03_60;
		sanc_f04_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f04_60;
		sanc_f09_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f09_60;
		sanc_f10_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f10_60;
		sanc_f13_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f13_60;
		sanc_f17_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f17_60;
		sanc_f18_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f18_60;
		sanc_f26_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f26_60;
		sanc_f01_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f01_60;
		sanc_f14_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f14_60;
		sanc_f15_60_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f15_60;
		sanc_f02_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f02_61;
		sanc_f05_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f05_61;
		sanc_f06_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f06_61;
		sanc_F07_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_F07_61;
		sanc_F08_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_F08_61;
		sanc_f11_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f11_61;
		sanc_f19_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f19_61;
		sanc_f20_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f20_61;
		sanc_f21_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f21_61;
		sanc_f22_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f22_61;
		sanc_f23_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f23_61;
		sanc_f24_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f24_61;
		sanc_f25_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f25_61;
		sanc_f12_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f12_61;
		sanc_f16_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f16_61;
		sanc_os_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_os_61;
		sanc_f03_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f03_61;
		sanc_f04_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f04_61;
		sanc_f09_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f09_61;
		sanc_f10_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f10_61;
		sanc_f13_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f13_61;
		sanc_f17_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f17_61;
		sanc_f18_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f18_61;
		sanc_f26_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f26_61;
		sanc_f01_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f01_61;
		sanc_f14_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f14_61;
		sanc_f15_61_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_f15_61;
		sanc_OIG_LEIE_Count_CAff	 := le.HealthCareShell.Bus_Sanctions.sanc_OIG_LEIE;
				
		// Provider Data
		GSA_Prov_Recip_24_Curr_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Recip_24_Curr;
		GSA_Prov_Recip_60_Curr_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Recip_60_Curr;
		GSA_Prov_Recip_61_Curr_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Recip_61_Curr;
		GSA_Prov_Proc_24_Curr_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Proc_24_Curr;
		GSA_Prov_Proc_60_Curr_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Proc_60_Curr;
		GSA_Prov_Proc_61_Curr_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Proc_61_Curr;
		GSA_Prov_NonProc_24_Curr_cnt	 := le.HealthCareShell.Provider.GSA_Prov_NonProc_24_Curr;
		GSA_Prov_NonProc_60_Curr_cnt	 := le.HealthCareShell.Provider.GSA_Prov_NonProc_60_Curr;
		GSA_Prov_NonProc_61_Curr_cnt	 := le.HealthCareShell.Provider.GSA_Prov_NonProc_61_Curr;
		GSA_Prov_Recip_24_Old_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Recip_24_Old;
		GSA_Prov_Recip_60_Old_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Recip_60_Old;
		GSA_Prov_Recip_61_Old_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Recip_61_Old;
		GSA_Prov_Proc_24_Old_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Proc_24_Old;
		GSA_Prov_Proc_60_Old_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Proc_60_Old;
		GSA_Prov_Proc_61_Old_cnt	 := le.HealthCareShell.Provider.GSA_Prov_Proc_61_Old;
		GSA_Prov_NonProc_24_Old_cnt	 := le.HealthCareShell.Provider.GSA_Prov_NonProc_24_Old;
		GSA_Prov_NonProc_60_Old_cnt	 := le.HealthCareShell.Provider.GSA_Prov_NonProc_60_Old;
		GSA_Prov_NonProc_61_Old_cnt	 := le.HealthCareShell.Provider.GSA_Prov_NonProc_61_Old;
		GSA_Provider_Current_Flag	 := le.HealthCareShell.Provider.GSA_Provider_Current_Flag;
		GSA_Provider_Old_Flag	 := le.HealthCareShell.Provider.GSA_Provider_Old_Flag;
				
		// Provider -- Business Data
		GSA_Bus_Recip_24_Curr_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Recip_24_Curr;
		GSA_Bus_Recip_60_Curr_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Recip_60_Curr;
		GSA_Bus_Recip_61_Curr_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Recip_61_Curr;
		GSA_Bus_Proc_24_Curr_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Proc_24_Curr;
		GSA_Bus_Proc_60_Curr_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Proc_60_Curr;
		GSA_Bus_Proc_61_Curr_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Proc_61_Curr;
		GSA_Bus_NonProc_24_Curr_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_NonProc_24_Curr;
		GSA_Bus_NonProc_60_Curr_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_NonProc_60_Curr;
		GSA_Bus_NonProc_61_Curr_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_NonProc_61_Curr;
		GSA_Bus_Recip_24_Old_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Recip_24_Old;
		GSA_Bus_Recip_60_Old_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Recip_60_Old;
		GSA_Bus_Recip_61_Old_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Recip_61_Old;
		GSA_Bus_Proc_24_Old_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Proc_24_Old;
		GSA_Bus_Proc_60_Old_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Proc_60_Old;
		GSA_Bus_Proc_61_Old_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_Proc_61_Old;
		GSA_Bus_NonProc_24_Old_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_NonProc_24_Old;
		GSA_Bus_NonProc_60_Old_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_NonProc_60_Old;
		GSA_Bus_NonProc_61_Old_cnt	 := le.HealthCareShell.Bus_Provider.GSA_Prov_NonProc_61_Old;
		GSA_Business_Current_Flag	 := le.HealthCareShell.Bus_Provider.GSA_Provider_Current_Flag;
		GSA_Business_Old_Flag	 := le.HealthCareShell.Bus_Provider.GSA_Provider_Old_Flag;
				
		// Provider -- Relatives Data
		GSA_Prov_Recip_24_Curr_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Recip_24_Curr;
		GSA_Prov_Recip_60_Curr_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Recip_60_Curr;
		GSA_Prov_Recip_61_Curr_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Recip_61_Curr;
		GSA_Prov_Proc_24_Curr_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Proc_24_Curr;
		GSA_Prov_Proc_60_Curr_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Proc_60_Curr;
		GSA_Prov_Proc_61_Curr_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Proc_61_Curr;
		GSA_Prov_NonProc_24_Curr_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_NonProc_24_Curr;
		GSA_Prov_NonProc_60_Curr_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_NonProc_60_Curr;
		GSA_Prov_NonProc_61_Curr_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_NonProc_61_Curr;
		GSA_Prov_Recip_24_Old_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Recip_24_Old;
		GSA_Prov_Recip_60_Old_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Recip_60_Old;
		GSA_Prov_Recip_61_Old_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Recip_61_Old;
		GSA_Prov_Proc_24_Old_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Proc_24_Old;
		GSA_Prov_Proc_60_Old_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Proc_60_Old;
		GSA_Prov_Proc_61_Old_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_Proc_61_Old;
		GSA_Prov_NonProc_24_Old_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_NonProc_24_Old;
		GSA_Prov_NonProc_60_Old_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_NonProc_60_Old;
		GSA_Prov_NonProc_61_Old_cnt_RAN	 := le.HealthCareShell.RAN_Provider.GSA_Prov_NonProc_61_Old;
		
		// Provider -- Corporate Affiliations Data
		GSA_CAff_Recip_24_Curr_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Recip_24_Curr;
		GSA_CAff_Recip_60_Curr_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Recip_60_Curr;
		GSA_CAff_Recip_61_Curr_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Recip_61_Curr;
		GSA_CAff_Proc_24_Curr_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Proc_24_Curr;
		GSA_CAff_Proc_60_Curr_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Proc_60_Curr;
		GSA_CAff_Proc_61_Curr_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Proc_61_Curr;
		GSA_CAff_NonProc_24_Curr_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_NonProc_24_Curr;
		GSA_CAff_NonProc_60_Curr_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_NonProc_60_Curr;
		GSA_CAff_NonProc_61_Curr_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_NonProc_61_Curr;
		GSA_CAff_Recip_24_Old_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Recip_24_Old;
		GSA_CAff_Recip_60_Old_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Recip_60_Old;
		GSA_CAff_Recip_61_Old_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Recip_61_Old;
		GSA_CAff_Proc_24_Old_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Proc_24_Old;
		GSA_CAff_Proc_60_Old_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Proc_60_Old;
		GSA_CAff_Proc_61_Old_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_Proc_61_Old;
		GSA_CAff_NonProc_24_Old_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_NonProc_24_Old;
		GSA_CAff_NonProc_60_Old_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_NonProc_60_Old;
		GSA_CAff_NonProc_61_Old_cnt	 := le.HealthCareShell.CorpAffil_Provider.GSA_Prov_NonProc_61_Old;
		
		// Provider -- Relatives Corporate Affiliations Data
		GSA_RANCAff_Recip_24_Curr_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Recip_24_Curr;
		GSA_RANCAff_Recip_60_Curr_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Recip_60_Curr;
		GSA_RANCAff_Recip_61_Curr_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Recip_61_Curr;
		GSA_RANCAff_Proc_24_Curr_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Proc_24_Curr;
		GSA_RANCAff_Proc_60_Curr_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Proc_60_Curr;
		GSA_RANCAff_Proc_61_Curr_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Proc_61_Curr;
		GSA_RANCAff_NonProc_24_Curr_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_NonProc_24_Curr;
		GSA_RANCAff_NonProc_60_Curr_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_NonProc_60_Curr;
		GSA_RANCAff_NonProc_61_Curr_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_NonProc_61_Curr;
		GSA_RANCAff_Recip_24_Old_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Recip_24_Old;
		GSA_RANCAff_Recip_60_Old_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Recip_60_Old;
		GSA_RANCAff_Recip_61_Old_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Recip_61_Old;
		GSA_RANCAff_Proc_24_Old_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Proc_24_Old;
		GSA_RANCAff_Proc_60_Old_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Proc_60_Old;
		GSA_RANCAff_Proc_61_Old_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_Proc_61_Old;
		GSA_RANCAff_NonProc_24_Old_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_NonProc_24_Old;
		GSA_RANCAff_NonProc_60_Old_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_NonProc_60_Old;
		GSA_RANCAff_NonProc_61_Old_cnt	 := le.HealthCareShell.RAN_CorpAffil_Provider.GSA_Prov_NonProc_61_Old;
		
		// Judgements Data
		JGMT_Foreclosure_Count_24	 := le.HealthCareShell.Liens.JGMT_Foreclosure_Count_24;
		JGMT_Forcible_Entry_Count_24	 := le.HealthCareShell.Liens.JGMT_Forcible_Entry_Count_24;
		JGMT_Lien_Other_Count_24	 := le.HealthCareShell.Liens.JGMT_Lien_Other_Count_24;
		JGMT_Tax_Lien_Count_24	 := le.HealthCareShell.Liens.JGMT_Tax_Lien_Count_24;
		JGMT_Landlord_Tenant_Count_24	 := le.HealthCareShell.Liens.JGMT_Landlord_Tenant_Count_24;
		JGMT_Civil_Judgment_Count_24	 := le.HealthCareShell.Liens.JGMT_Civil_Judgment_Count_24;
		JGMT_Child_Support_Count_24	 := le.HealthCareShell.Liens.JGMT_Child_Support_Count_24;
		JGMT_Small_Claims_Count_24	 := le.HealthCareShell.Liens.JGMT_Small_Claims_Count_24;
		JGMT_Judgment_Other_Count_24	 := le.HealthCareShell.Liens.JGMT_Judgment_Other_Count_24;
		JGMT_Lawsuit_Pending_Count_24	 := le.HealthCareShell.Liens.JGMT_Lawsuit_Pending_Count_24;
		JGMT_Other_Count_24	 := le.HealthCareShell.Liens.JGMT_Other_Count_24;
		JGMT_Foreclosure_Count_60	 := le.HealthCareShell.Liens.JGMT_Foreclosure_Count_60;
		JGMT_Forcible_Entry_Count_60	 := le.HealthCareShell.Liens.JGMT_Forcible_Entry_Count_60;
		JGMT_Lien_Other_Count_60	 := le.HealthCareShell.Liens.JGMT_Lien_Other_Count_60;
		JGMT_Tax_Lien_Count_60	 := le.HealthCareShell.Liens.JGMT_Tax_Lien_Count_60;
		JGMT_Landlord_Tenant_Count_60	 := le.HealthCareShell.Liens.JGMT_Landlord_Tenant_Count_60;
		JGMT_Civil_Judgment_Count_60	 := le.HealthCareShell.Liens.JGMT_Civil_Judgment_Count_60;
		JGMT_Child_Support_Count_60	 := le.HealthCareShell.Liens.JGMT_Child_Support_Count_60;
		JGMT_Small_Claims_Count_60	 := le.HealthCareShell.Liens.JGMT_Small_Claims_Count_60;
		JGMT_Judgment_Other_Count_60	 := le.HealthCareShell.Liens.JGMT_Judgment_Other_Count_60;
		JGMT_Lawsuit_Pending_Count_60	 := le.HealthCareShell.Liens.JGMT_Lawsuit_Pending_Count_60;
		JGMT_Other_Count_60	 := le.HealthCareShell.Liens.JGMT_Other_Count_60;
		JGMT_Foreclosure_Count_61	 := le.HealthCareShell.Liens.JGMT_Foreclosure_Count_61;
		JGMT_Forcible_Entry_Count_61	 := le.HealthCareShell.Liens.JGMT_Forcible_Entry_Count_61;
		JGMT_Lien_Other_Count_61	 := le.HealthCareShell.Liens.JGMT_Lien_Other_Count_61;
		JGMT_Tax_Lien_Count_61	 := le.HealthCareShell.Liens.JGMT_Tax_Lien_Count_61;
		JGMT_Landlord_Tenant_Count_61	 := le.HealthCareShell.Liens.JGMT_Landlord_Tenant_Count_61;
		JGMT_Civil_Judgment_Count_61	 := le.HealthCareShell.Liens.JGMT_Civil_Judgment_Count_61;
		JGMT_Child_Support_Count_61	 := le.HealthCareShell.Liens.JGMT_Child_Support_Count_61;
		JGMT_Small_Claims_Count_61	 := le.HealthCareShell.Liens.JGMT_Small_Claims_Count_61;
		JGMT_Judgment_Other_Count_61	 := le.HealthCareShell.Liens.JGMT_Judgment_Other_Count_61;
		JGMT_Lawsuit_Pending_Count_61	 := le.HealthCareShell.Liens.JGMT_Lawsuit_Pending_Count_61;
		JGMT_Other_Count_61	 := le.HealthCareShell.Liens.JGMT_Other_Count_61;
		JGMT_Foreclosure_Count_ND	 := le.HealthCareShell.Liens.JGMT_Foreclosure_Count_ND;
		JGMT_Forcible_Entry_Count_ND	 := le.HealthCareShell.Liens.JGMT_Forcible_Entry_Count_ND;
		JGMT_Lien_Other_Count_ND	 := le.HealthCareShell.Liens.JGMT_Lien_Other_Count_ND;
		JGMT_Tax_Lien_Count_ND	 := le.HealthCareShell.Liens.JGMT_Tax_Lien_Count_ND;
		JGMT_Landlord_Tenant_Count_ND	 := le.HealthCareShell.Liens.JGMT_Landlord_Tenant_Count_ND;
		JGMT_Civil_Judgment_Count_ND	 := le.HealthCareShell.Liens.JGMT_Civil_Judgment_Count_ND;
		JGMT_Child_Support_Count_ND	 := le.HealthCareShell.Liens.JGMT_Child_Support_Count_ND;
		JGMT_Small_Claims_Count_ND	 := le.HealthCareShell.Liens.JGMT_Small_Claims_Count_ND;
		JGMT_Judgment_Other_Count_ND	 := le.HealthCareShell.Liens.JGMT_Judgment_Other_Count_ND;
		JGMT_Lawsuit_Pending_Count_ND	 := le.HealthCareShell.Liens.JGMT_Lawsuit_Pending_Count_ND;
		JGMT_Other_Count_ND	 := le.HealthCareShell.Liens.JGMT_Other_Count_ND;
		JGMT_Eviction_Flag_Count	 := le.HealthCareShell.Liens.JGMT_Eviction_Flag_Count;
		JGMT_Sum	 := le.HealthCareShell.Liens.JGMT_Sum;
		JGMT_Flag_Count	 := le.HealthCareShell.Liens.JGMT_Flag_Count;
		
		// Criminal Data
		Crim_Red_Misc_cnt_24	 := le.HealthCareShell.Criminal.Red_Misc_Count_24;
		crim_Assault_cnt_24	 := le.HealthCareShell.Criminal.Assault_Count_24;
		crim_Weapon_cnt_24	 := le.HealthCareShell.Criminal.Weapon_Count_24;
		crim_Murder_cnt_24	 := le.HealthCareShell.Criminal.Murder_Count_24;
		crim_Child_Abuse_cnt_24	 := le.HealthCareShell.Criminal.Child_Abuse_Count_24;
		crim_Forgery_cnt_24	 := le.HealthCareShell.Criminal.Forgery_Count_24;
		crim_Theft_cnt_24	 := le.HealthCareShell.Criminal.Theft_Count_24;
		crim_Fraud_cnt_24	 := le.HealthCareShell.Criminal.Fraud_Count_24;
		crim_Robbery_cnt_24	 := le.HealthCareShell.Criminal.Robbery_Count_24;
		crim_Break_Enter_cnt_24	 := le.HealthCareShell.Criminal.Break_Enter_Count_24;
		crim_Burg_cnt_24	 := le.HealthCareShell.Criminal.Burg_Count_24;
		crim_Harassment_cnt_24	 := le.HealthCareShell.Criminal.Harassment_Count_24;
		crim_DWLS_cnt_24	 := le.HealthCareShell.Criminal.DWLS_Count_24;
		crim_DUI_cnt_24	 := le.HealthCareShell.Criminal.DUI_Count_24;
		crim_Cont_Subst_cnt_24	 := le.HealthCareShell.Criminal.Cont_Subst_Count_24;
		crim_Sex_Crime_cnt_24	 := le.HealthCareShell.Criminal.Sex_Crime_Count_24;
		crim_Felony_cnt_24	 := le.HealthCareShell.Criminal.Felony_Count_24;
		crim_Other_cnt_24	 := le.HealthCareShell.Criminal.Other_Count_24;
		crim_Traffic_cnt_24	 := le.HealthCareShell.Criminal.Traffic_Count_24;
		crim_Parking_cnt_24	 := le.HealthCareShell.Criminal.Parking_Count_24;
		crim_Misdemeanor_cnt_24	 := le.HealthCareShell.Criminal.Misdemeanor_Count_24;
		crim_Prop_Dmg_cnt_24	 := le.HealthCareShell.Criminal.Prop_Dmg_Count_24;
		crim_Disorderly_cnt_24	 := le.HealthCareShell.Criminal.Disorderly_Count_24;
		crim_Trespassing_cnt_24	 := le.HealthCareShell.Criminal.Trespassing_Count_24;
		crim_Alcohol_cnt_24	 := le.HealthCareShell.Criminal.Alcohol_Count_24;
		crim_Res_Arrest_cnt_24	 := le.HealthCareShell.Criminal.Res_Arrest_Count_24;
		crim_Bad_Check_cnt_24	 := le.HealthCareShell.Criminal.Bad_Check_Count_24;
		Crim_Red_Misc_cnt_60	 := le.HealthCareShell.Criminal.Red_Misc_Count_60;
		crim_Assault_cnt_60	 := le.HealthCareShell.Criminal.Assault_Count_60;
		crim_Weapon_cnt_60	 := le.HealthCareShell.Criminal.Weapon_Count_60;
		crim_Murder_cnt_60	 := le.HealthCareShell.Criminal.Murder_Count_60;
		crim_Child_Abuse_cnt_60	 := le.HealthCareShell.Criminal.Child_Abuse_Count_60;
		crim_Forgery_cnt_60	 := le.HealthCareShell.Criminal.Forgery_Count_60;
		crim_Theft_cnt_60	 := le.HealthCareShell.Criminal.Theft_Count_60;
		crim_Fraud_cnt_60	 := le.HealthCareShell.Criminal.Fraud_Count_60;
		crim_Robbery_cnt_60	 := le.HealthCareShell.Criminal.Robbery_Count_60;
		crim_Break_Enter_cnt_60	 := le.HealthCareShell.Criminal.Break_Enter_Count_60;
		crim_Burg_cnt_60	 := le.HealthCareShell.Criminal.Burg_Count_60;
		crim_Harassment_cnt_60	 := le.HealthCareShell.Criminal.Harassment_Count_60;
		crim_DWLS_cnt_60	 := le.HealthCareShell.Criminal.DWLS_Count_60;
		crim_DUI_cnt_60	 := le.HealthCareShell.Criminal.DUI_Count_60;
		crim_Cont_Subst_cnt_60	 := le.HealthCareShell.Criminal.Cont_Subst_Count_60;
		crim_Sex_Crime_cnt_60	 := le.HealthCareShell.Criminal.Sex_Crime_Count_60;
		crim_Felony_cnt_60	 := le.HealthCareShell.Criminal.Felony_Count_60;
		crim_Other_cnt_60	 := le.HealthCareShell.Criminal.Other_Count_60;
		crim_Traffic_cnt_60	 := le.HealthCareShell.Criminal.Traffic_Count_60;
		crim_Parking_cnt_60	 := le.HealthCareShell.Criminal.Parking_Count_60;
		crim_Misdemeanor_cnt_60	 := le.HealthCareShell.Criminal.Misdemeanor_Count_60;
		crim_Prop_Dmg_cnt_60	 := le.HealthCareShell.Criminal.Prop_Dmg_Count_60;
		crim_Disorderly_cnt_60	 := le.HealthCareShell.Criminal.Disorderly_Count_60;
		crim_Trespassing_cnt_60	 := le.HealthCareShell.Criminal.Trespassing_Count_60;
		crim_Alcohol_cnt_60	 := le.HealthCareShell.Criminal.Alcohol_Count_60;
		crim_Res_Arrest_cnt_60	 := le.HealthCareShell.Criminal.Res_Arrest_Count_60;
		crim_Bad_Check_cnt_60	 := le.HealthCareShell.Criminal.Bad_Check_Count_60;
		Crim_Red_Misc_cnt_61	 := le.HealthCareShell.Criminal.Red_Misc_Count_61;
		crim_Assault_cnt_61	 := le.HealthCareShell.Criminal.Assault_Count_61;
		crim_Weapon_cnt_61	 := le.HealthCareShell.Criminal.Weapon_Count_61;
		crim_Murder_cnt_61	 := le.HealthCareShell.Criminal.Murder_Count_61;
		crim_Child_Abuse_cnt_61	 := le.HealthCareShell.Criminal.Child_Abuse_Count_61;
		crim_Forgery_cnt_61	 := le.HealthCareShell.Criminal.Forgery_Count_61;
		crim_Theft_cnt_61	 := le.HealthCareShell.Criminal.Theft_Count_61;
		crim_Fraud_cnt_61	 := le.HealthCareShell.Criminal.Fraud_Count_61;
		crim_Robbery_cnt_61	 := le.HealthCareShell.Criminal.Robbery_Count_61;
		crim_Break_Enter_cnt_61	 := le.HealthCareShell.Criminal.Break_Enter_Count_61;
		crim_Burg_cnt_61	 := le.HealthCareShell.Criminal.Burg_Count_61;
		crim_Harassment_cnt_61	 := le.HealthCareShell.Criminal.Harassment_Count_61;
		crim_DWLS_cnt_61	 := le.HealthCareShell.Criminal.DWLS_Count_61;
		crim_DUI_cnt_61	 := le.HealthCareShell.Criminal.DUI_Count_61;
		crim_Cont_Subst_cnt_61	 := le.HealthCareShell.Criminal.Cont_Subst_Count_61;
		crim_Sex_Crime_cnt_61	 := le.HealthCareShell.Criminal.Sex_Crime_Count_61;
		crim_Felony_cnt_61	 := le.HealthCareShell.Criminal.Felony_Count_61;
		crim_Other_cnt_61	 := le.HealthCareShell.Criminal.Other_Count_61;
		crim_Traffic_cnt_61	 := le.HealthCareShell.Criminal.Traffic_Count_61;
		crim_Parking_cnt_61	 := le.HealthCareShell.Criminal.Parking_Count_61;
		crim_Misdemeanor_cnt_61	 := le.HealthCareShell.Criminal.Misdemeanor_Count_61;
		crim_Prop_Dmg_cnt_61	 := le.HealthCareShell.Criminal.Prop_Dmg_Count_61;
		crim_Disorderly_cnt_61	 := le.HealthCareShell.Criminal.Disorderly_Count_61;
		crim_Trespassing_cnt_61	 := le.HealthCareShell.Criminal.Trespassing_Count_61;
		crim_Alcohol_cnt_61	 := le.HealthCareShell.Criminal.Alcohol_Count_61;
		crim_Res_Arrest_cnt_61	 := le.HealthCareShell.Criminal.Res_Arrest_Count_61;
		crim_Bad_Check_cnt_61	 := le.HealthCareShell.Criminal.Bad_Check_Count_61;
		Crim_Red_Misc_cnt_121	 := le.HealthCareShell.Criminal.Red_Misc_Count_121;
		crim_Assault_cnt_121	 := le.HealthCareShell.Criminal.Assault_Count_121;
		crim_Weapon_cnt_121	 := le.HealthCareShell.Criminal.Weapon_Count_121;
		crim_Murder_cnt_121	 := le.HealthCareShell.Criminal.Murder_Count_121;
		crim_Child_Abuse_cnt_121	 := le.HealthCareShell.Criminal.Child_Abuse_Count_121;
		crim_Forgery_cnt_121	 := le.HealthCareShell.Criminal.Forgery_Count_121;
		crim_Theft_cnt_121	 := le.HealthCareShell.Criminal.Theft_Count_121;
		crim_Fraud_cnt_121	 := le.HealthCareShell.Criminal.Fraud_Count_121;
		crim_Robbery_cnt_121	 := le.HealthCareShell.Criminal.Robbery_Count_121;
		crim_Break_Enter_cnt_121	 := le.HealthCareShell.Criminal.Break_Enter_Count_121;
		crim_Burg_cnt_121	 := le.HealthCareShell.Criminal.Burg_Count_121;
		crim_Harassment_cnt_121	 := le.HealthCareShell.Criminal.Harassment_Count_121;
		crim_DWLS_cnt_121	 := le.HealthCareShell.Criminal.DWLS_Count_121;
		crim_DUI_cnt_121	 := le.HealthCareShell.Criminal.DUI_Count_121;
		crim_Cont_Subst_cnt_121	 := le.HealthCareShell.Criminal.Cont_Subst_Count_121;
		crim_Sex_Crime_cnt_121	 := le.HealthCareShell.Criminal.Sex_Crime_Count_121;
		crim_Felony_cnt_121	 := le.HealthCareShell.Criminal.Felony_Count_121;
		crim_Other_cnt_121	 := le.HealthCareShell.Criminal.Other_Count_121;
		crim_Traffic_cnt_121	 := le.HealthCareShell.Criminal.Traffic_Count_121;
		crim_Parking_cnt_121	 := le.HealthCareShell.Criminal.Parking_Count_121;
		crim_Misdemeanor_cnt_121	 := le.HealthCareShell.Criminal.Misdemeanor_Count_121;
		crim_Prop_Dmg_cnt_121	 := le.HealthCareShell.Criminal.Prop_Dmg_Count_121;
		crim_Disorderly_cnt_121	 := le.HealthCareShell.Criminal.Disorderly_Count_121;
		crim_Trespassing_cnt_121	 := le.HealthCareShell.Criminal.Trespassing_Count_121;
		crim_Alcohol_cnt_121	 := le.HealthCareShell.Criminal.Alcohol_Count_121;
		crim_Res_Arrest_cnt_121	 := le.HealthCareShell.Criminal.Res_Arrest_Count_121;
		crim_Bad_Check_cnt_121	 := le.HealthCareShell.Criminal.Bad_Check_Count_121;
		Crim_WC_Count	 := le.HealthCareShell.Criminal.WC_Count;
		Crim_WC_Misdemeanor_Count	 := le.HealthCareShell.Criminal.WC_Misdemeanor_Count;
		Crim_WC_Felony_Count	 := le.HealthCareShell.Criminal.WC_Felony_Count;
		Crim_WC_SexCrime_Count	 := le.HealthCareShell.Criminal.WC_SexCrime_Count;
		
		// Criminal Relatives Data
		crim_RAN_Red_Misc_cnt_24	 := le.HealthCareShell.RAN_Criminal.Red_Misc_Count_24;
		crim_RAN_Assault_cnt_24	 := le.HealthCareShell.RAN_Criminal.Assault_Count_24;
		crim_RAN_Weapon_cnt_24	 := le.HealthCareShell.RAN_Criminal.Weapon_Count_24;
		crim_RAN_Murder_cnt_24	 := le.HealthCareShell.RAN_Criminal.Murder_Count_24;
		crim_RAN_Child_Abuse_cnt_24	 := le.HealthCareShell.RAN_Criminal.Child_Abuse_Count_24;
		crim_RAN_Forgery_cnt_24	 := le.HealthCareShell.RAN_Criminal.Forgery_Count_24;
		crim_RAN_Theft_cnt_24	 := le.HealthCareShell.RAN_Criminal.Theft_Count_24;
		crim_RAN_Fraud_cnt_24	 := le.HealthCareShell.RAN_Criminal.Fraud_Count_24;
		crim_RAN_Robbery_cnt_24	 := le.HealthCareShell.RAN_Criminal.Robbery_Count_24;
		crim_RAN_Break_Enter_cnt_24	 := le.HealthCareShell.RAN_Criminal.Break_Enter_Count_24;
		crim_RAN_Burg_cnt_24	 := le.HealthCareShell.RAN_Criminal.Burg_Count_24;
		crim_RAN_Harassment_cnt_24	 := le.HealthCareShell.RAN_Criminal.Harassment_Count_24;
		crim_RAN_DWLS_cnt_24	 := le.HealthCareShell.RAN_Criminal.DWLS_Count_24;
		crim_RAN_DUI_cnt_24	 := le.HealthCareShell.RAN_Criminal.DUI_Count_24;
		crim_RAN_Cont_Subst_cnt_24	 := le.HealthCareShell.RAN_Criminal.Cont_Subst_Count_24;
		crim_RAN_Sex_Crime_cnt_24	 := le.HealthCareShell.RAN_Criminal.Sex_Crime_Count_24;
		crim_RAN_Felony_cnt_24	 := le.HealthCareShell.RAN_Criminal.Felony_Count_24;
		crim_RAN_Red_Misc_cnt_60	 := le.HealthCareShell.RAN_Criminal.Red_Misc_Count_60;
		crim_RAN_Assault_cnt_60	 := le.HealthCareShell.RAN_Criminal.Assault_Count_60;
		crim_RAN_Weapon_cnt_60	 := le.HealthCareShell.RAN_Criminal.Weapon_Count_60;
		crim_RAN_Murder_cnt_60	 := le.HealthCareShell.RAN_Criminal.Murder_Count_60;
		crim_RAN_Child_Abuse_cnt_60	 := le.HealthCareShell.RAN_Criminal.Child_Abuse_Count_60;
		crim_RAN_Forgery_cnt_60	 := le.HealthCareShell.RAN_Criminal.Forgery_Count_60;
		crim_RAN_Theft_cnt_60	 := le.HealthCareShell.RAN_Criminal.Theft_Count_60;
		crim_RAN_Fraud_cnt_60	 := le.HealthCareShell.RAN_Criminal.Fraud_Count_60;
		crim_RAN_Robbery_cnt_60	 := le.HealthCareShell.RAN_Criminal.Robbery_Count_60;
		crim_RAN_Break_Enter_cnt_60	 := le.HealthCareShell.RAN_Criminal.Break_Enter_Count_60;
		crim_RAN_Burg_cnt_60	 := le.HealthCareShell.RAN_Criminal.Burg_Count_60;
		crim_RAN_Harassment_cnt_60	 := le.HealthCareShell.RAN_Criminal.Harassment_Count_60;
		crim_RAN_DWLS_cnt_60	 := le.HealthCareShell.RAN_Criminal.DWLS_Count_60;
		crim_RAN_DUI_cnt_60	 := le.HealthCareShell.RAN_Criminal.DUI_Count_60;
		crim_RAN_Cont_Subst_cnt_60	 := le.HealthCareShell.RAN_Criminal.Cont_Subst_Count_60;
		crim_RAN_Sex_Crime_cnt_60	 := le.HealthCareShell.RAN_Criminal.Sex_Crime_Count_60;
		crim_RAN_Felony_cnt_60	 := le.HealthCareShell.RAN_Criminal.Felony_Count_60;
		crim_RAN_Red_Misc_cnt_61	 := le.HealthCareShell.RAN_Criminal.Red_Misc_Count_61;
		crim_RAN_Assault_cnt_61	 := le.HealthCareShell.RAN_Criminal.Assault_Count_61;
		crim_RAN_Weapon_cnt_61	 := le.HealthCareShell.RAN_Criminal.Weapon_Count_61;
		crim_RAN_Murder_cnt_61	 := le.HealthCareShell.RAN_Criminal.Murder_Count_61;
		crim_RAN_Child_Abuse_cnt_61	 := le.HealthCareShell.RAN_Criminal.Child_Abuse_Count_61;
		crim_RAN_Forgery_cnt_61	 := le.HealthCareShell.RAN_Criminal.Forgery_Count_61;
		crim_RAN_Theft_cnt_61	 := le.HealthCareShell.RAN_Criminal.Theft_Count_61;
		crim_RAN_Fraud_cnt_61	 := le.HealthCareShell.RAN_Criminal.Fraud_Count_61;
		crim_RAN_Robbery_cnt_61	 := le.HealthCareShell.RAN_Criminal.Robbery_Count_61;
		crim_RAN_Break_Enter_cnt_61	 := le.HealthCareShell.RAN_Criminal.Break_Enter_Count_61;
		crim_RAN_Burg_cnt_61	 := le.HealthCareShell.RAN_Criminal.Burg_Count_61;
		crim_RAN_Harassment_cnt_61	 := le.HealthCareShell.RAN_Criminal.Harassment_Count_61;
		crim_RAN_DWLS_cnt_61	 := le.HealthCareShell.RAN_Criminal.DWLS_Count_61;
		crim_RAN_DUI_cnt_61	 := le.HealthCareShell.RAN_Criminal.DUI_Count_61;
		crim_RAN_Cont_Subst_cnt_61	 := le.HealthCareShell.RAN_Criminal.Cont_Subst_Count_61;
		crim_RAN_Sex_Crime_cnt_61	 := le.HealthCareShell.RAN_Criminal.Sex_Crime_Count_61;
		crim_RAN_Felony_cnt_61	 := le.HealthCareShell.RAN_Criminal.Felony_Count_61;
		crim_RAN_Red_Misc_cnt_121	 := le.HealthCareShell.RAN_Criminal.Red_Misc_Count_121;
		crim_RAN_Assault_cnt_121	 := le.HealthCareShell.RAN_Criminal.Assault_Count_121;
		crim_RAN_Weapon_cnt_121	 := le.HealthCareShell.RAN_Criminal.Weapon_Count_121;
		crim_RAN_Murder_cnt_121	 := le.HealthCareShell.RAN_Criminal.Murder_Count_121;
		crim_RAN_Child_Abuse_cnt_121	 := le.HealthCareShell.RAN_Criminal.Child_Abuse_Count_121;
		crim_RAN_Forgery_cnt_121	 := le.HealthCareShell.RAN_Criminal.Forgery_Count_121;
		crim_RAN_Theft_cnt_121	 := le.HealthCareShell.RAN_Criminal.Theft_Count_121;
		crim_RAN_Fraud_cnt_121	 := le.HealthCareShell.RAN_Criminal.Fraud_Count_121;
		crim_RAN_Robbery_cnt_121	 := le.HealthCareShell.RAN_Criminal.Robbery_Count_121;
		crim_RAN_Break_Enter_cnt_121	 := le.HealthCareShell.RAN_Criminal.Break_Enter_Count_121;
		crim_RAN_Burg_cnt_121	 := le.HealthCareShell.RAN_Criminal.Burg_Count_121;
		crim_RAN_Harassment_cnt_121	 := le.HealthCareShell.RAN_Criminal.Harassment_Count_121;
		crim_RAN_DWLS_cnt_121	 := le.HealthCareShell.RAN_Criminal.DWLS_Count_121;
		crim_RAN_DUI_cnt_121	 := le.HealthCareShell.RAN_Criminal.DUI_Count_121;
		crim_RAN_Cont_Subst_cnt_121	 := le.HealthCareShell.RAN_Criminal.Cont_Subst_Count_121;
		crim_RAN_Sex_Crime_cnt_121	 := le.HealthCareShell.RAN_Criminal.Sex_Crime_Count_121;
		crim_RAN_Felony_cnt_121	 := le.HealthCareShell.RAN_Criminal.Felony_Count_121;
		Crim_RAN_WC_Felony_Count	 := le.HealthCareShell.RAN_Criminal.WC_Felony_Count;
		Crim_RAN_WC_Misd_Count	 := le.HealthCareShell.RAN_Criminal.WC_Misdemeanor_Count;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	INTEGER year(integer sas_date) :=
		if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));
	
	sysdate := map(
	    trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.BocaShell.historydate=999999, (STRING)Std.Date.Today(), (string6)le.BocaShell.historydate+'01')),
	    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
	                                                           NULL);
	
	header_first_seen2 := Common.SAS_Date((STRING)(header_first_seen));
	
	mth_header_first_seen := if(min(sysdate, header_first_seen2) = NULL, NULL, (sysdate - header_first_seen2) / 30.5);
	
	date_last_seen2 := Common.SAS_Date((STRING)(date_last_seen));
	
	mth_date_last_seen := if(min(sysdate, date_last_seen2) = NULL, NULL, (sysdate - date_last_seen2) / 30.5);
	
	ver_src_ak_pos := Models.Common.findw_cpp(ver_sources, 'AK' , '  ,', 'ie');
	
	ver_src_ak := ver_src_ak_pos > 0;
	
	ver_src_am_pos := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');
	
	ver_src_am := ver_src_am_pos > 0;
	
	ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');
	
	ver_src_ar := ver_src_ar_pos > 0;
	
	ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');
	
	ver_src_cg := ver_src_cg_pos > 0;
	
	ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');
	
	ver_src_ds := ver_src_ds_pos > 0;
	
	ver_src_eb_pos := Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie');
	
	ver_src_eb := ver_src_eb_pos > 0;
	
	ver_src_em_pos := Models.Common.findw_cpp(ver_sources, 'EM' , '  ,', 'ie');
	
	ver_src_em := ver_src_em_pos > 0;
	
	ver_src_e1_pos := Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie');
	
	ver_src_e1 := ver_src_e1_pos > 0;
	
	ver_src_e2_pos := Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie');
	
	ver_src_e2 := ver_src_e2_pos > 0;
	
	ver_src_e3_pos := Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie');
	
	ver_src_e3 := ver_src_e3_pos > 0;
	
	ver_src_e4_pos := Models.Common.findw_cpp(ver_sources, 'E4' , '  ,', 'ie');
	
	ver_src_e4 := ver_src_e4_pos > 0;
	
	ver_src_en_pos := Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie');
	
	ver_src_en := ver_src_en_pos > 0;
	
	ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');
	
	ver_src_eq := ver_src_eq_pos > 0;
	
	ver_src_fr_pos := Models.Common.findw_cpp(ver_sources, 'FR' , '  ,', 'ie');
	
	ver_src_nas_fr := if(ver_src_fr_pos > 0, (real)Models.Common.getw(ver_sources_NAS, ver_src_fr_pos), 0);
	
	ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');
	
	ver_src_pl := ver_src_pl_pos > 0;
	
	ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie');
	
	ver_src_vo := ver_src_vo_pos > 0;
	
	ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');
	
	ver_src_w := ver_src_w_pos > 0;
	
	ver_src_wp_pos := Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie');
	
	ver_src_wp := ver_src_wp_pos > 0;
	
	ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie');
	
	ver_src_tn := ver_src_tn_pos > 0;
	
	ver_fname_src_ds_pos := Models.Common.findw_cpp(ver_fname_sources, 'DS' , '  ,', 'ie');
	
	ver_fname_src_ds := ver_fname_src_ds_pos > 0;
	
	ver_fname_src_de_pos := Models.Common.findw_cpp(ver_fname_sources, 'DE' , '  ,', 'ie');
	
	ver_fname_src_de := ver_fname_src_de_pos > 0;
	
	ver_lname_src_ds_pos := Models.Common.findw_cpp(ver_lname_sources, 'DS' , '  ,', 'ie');
	
	ver_lname_src_ds := ver_lname_src_ds_pos > 0;
	
	ver_lname_src_de_pos := Models.Common.findw_cpp(ver_lname_sources, 'DE' , '  ,', 'ie');
	
	ver_lname_src_de := ver_lname_src_de_pos > 0;
	
	ver_addr_src_ds_pos := Models.Common.findw_cpp(ver_addr_sources, 'DS' , '  ,', 'ie');
	
	ver_addr_src_ds := ver_addr_src_ds_pos > 0;
	
	ver_addr_src_de_pos := Models.Common.findw_cpp(ver_addr_sources, 'DE' , '  ,', 'ie');
	
	ver_addr_src_de := ver_addr_src_de_pos > 0;
	
	ver_ssn_src_ds_pos := Models.Common.findw_cpp(ver_ssn_sources, 'DS' , '  ,', 'ie');
	
	ver_ssn_src_ds := ver_ssn_src_ds_pos > 0;
	
	ver_ssn_src_de_pos := Models.Common.findw_cpp(ver_ssn_sources, 'DE' , '  ,', 'ie');
	
	ver_ssn_src_de := ver_ssn_src_de_pos > 0;
	
	email_src_im_pos := Models.Common.findw_cpp(email_source_list, 'IM' , '  ,', 'ie');
	
	email_src_im := email_src_im_pos > 0;
	
	verfst_s := (nas_summary in [2, 3, 4, 8, 9, 10, 12]);
	
	verlst_s := (nas_summary in [2, 5, 7, 8, 9, 11, 12]);
	
	verssn_s := (nas_summary in [4, 6, 7, 9, 10, 11, 12]);
	
	add_pobox_1 := (INTEGER)rc_hriskaddrflag = 1 or 
									(INTEGER)rc_ziptypeflag = 1 or 
									StringLib.StringToUpperCase(trim(rc_dwelltype)) = 'E' or 
									StringLib.StringToUpperCase(trim(rc_zipclass)) = 'P' or 
									StringLib.StringToUpperCase(trim(out_addr_type)) = 'P';
	
	phn_disconnected := (INTEGER)rc_hriskphoneflag = 5;
	
	phn_highrisk_1 := (INTEGER)rc_hriskphoneflag = 6 or TRIM(rc_hphonetypeflag) = '5' or (INTEGER)rc_hphonevalflag = 3 or (INTEGER)rc_addrcommflag = 1;
	
	ssnpop := (INTEGER)ssnlength > 0;
	
	ssn_priordob_1 := (INTEGER)rc_ssndobflag = 1 or (INTEGER)rc_pwssndobflag = 1;
	
	ssn_inval_1 := (INTEGER)rc_ssnvalflag = 1 or (TRIM(rc_pwssnvalflag) in ['1', '2', '3']);
	
	ssn_deceased_1 := (INTEGER)rc_decsflag = 1 or (INTEGER)ver_src_ds = 1;
	
	impulse_flag := (INTEGER)impulse_count > 0;
	
	lien_rec_unrel_flag := (INTEGER)liens_recent_unreleased_count > 0;
	
	lien_hist_unrel_flag := (INTEGER)liens_historical_unreleased_ct > 0;
	
	did_found := if(did > 0, 1, 0);
	
	pk_disconnected_1 := (INTEGER)phn_disconnected = 1 or trim(nap_status) = 'D';
	
	pk_addinval_1 := trim(rc_addrvalflag) = 'N';
	
	pk_num_elements_ver := (integer)(combo_fnamecount > 0) +
	    (integer)(combo_lnamecount > 0) +
	    (integer)(combo_addrcount > 0) +
	    (integer)(combo_hphonecount > 0) +
	    (integer)(combo_ssncount > 0) +
	    (integer)(combo_dobcount > 0);
	
	pk_num_elements_pop := if(max((integer)fnamepop, (integer)lnamepop, (integer)addrpop, (integer)ssnpop, (integer)dobpop, (integer)hphnpop) = NULL, NULL, sum((integer)fnamepop, (integer)lnamepop, (integer)addrpop, (integer)ssnpop, (integer)dobpop, (integer)hphnpop));
	
	pk_rc_numelever_0_2 := 0;
	
	pk_rc_numelever_2_2 := 0;
	
	pk_rc_numelever_34_3 := 0;
	
	pk_rc_numelever_5_3 := 0;
	
	pk_rc_numelever_6_3 := 0;
	
	pk_rc_numelever_partial_3 := 0;
	
	pk_rc_numelever_5_c463 := map(
	    pk_num_elements_ver = 6 => 0,
	    pk_num_elements_ver = 5 => 1,
	    pk_num_elements_ver = 4 => 0,
	                               0);
	
	pk_rc_numelever_6_c463 := map(
	    pk_num_elements_ver = 6 => 1,
	    pk_num_elements_ver = 5 => 0,
	    pk_num_elements_ver = 4 => 0,
	                               0);
	
	pk_rc_numelever_34_c463 := map(
	    pk_num_elements_ver = 6 => 0,
	    pk_num_elements_ver = 5 => 0,
	    pk_num_elements_ver = 4 => 1,
	                               1);
	
	pk_rc_numelever_2_c464 := map(
	    pk_num_elements_ver = 0  => 0,
	    pk_num_elements_ver <= 2 => 1,
	                                0);
	
	pk_rc_numelever_partial_c464 := map(
	    pk_num_elements_ver = 0  => 0,
	    pk_num_elements_ver <= 2 => 0,
	                                1);
	
	pk_rc_numelever_0_c464 := map(
	    pk_num_elements_ver = 0  => 1,
	    pk_num_elements_ver <= 2 => 0,
	                                0);
	
	pk_rc_numelever_5_2 := if(pk_num_elements_pop = pk_num_elements_ver and pk_num_elements_ver >= 3, pk_rc_numelever_5_c463, pk_rc_numelever_5_3);
	
	pk_rc_numelever_2_1 := if(pk_num_elements_pop = pk_num_elements_ver and pk_num_elements_ver >= 3, pk_rc_numelever_2_2, pk_rc_numelever_2_c464);
	
	pk_rc_numelever_partial_2 := if(pk_num_elements_pop = pk_num_elements_ver and pk_num_elements_ver >= 3, pk_rc_numelever_partial_3, pk_rc_numelever_partial_c464);
	
	pk_rc_numelever_6_2 := if(pk_num_elements_pop = pk_num_elements_ver and pk_num_elements_ver >= 3, pk_rc_numelever_6_c463, pk_rc_numelever_6_3);
	
	pk_rc_numelever_34_2 := if(pk_num_elements_pop = pk_num_elements_ver and pk_num_elements_ver >= 3, pk_rc_numelever_34_c463, pk_rc_numelever_34_3);
	
	pk_rc_numelever_0_1 := if(pk_num_elements_pop = pk_num_elements_ver and pk_num_elements_ver >= 3, pk_rc_numelever_0_2, pk_rc_numelever_0_c464);
	
	ver_src_bureau := ver_src_en or ver_src_eq or ver_src_tn;
	
	pk_r_pos_src_minor := if(max((integer)ver_src_ak, (integer)ver_src_am, (integer)ver_src_ar, (integer)ver_src_cg, (integer)ver_src_w, (integer)ver_src_eb) = NULL, NULL, sum((integer)ver_src_ak, (integer)ver_src_am, (integer)ver_src_ar, (integer)ver_src_cg, (integer)ver_src_w, (integer)ver_src_eb));
	
	pk_r_pos_src_minor_flag := pk_r_pos_src_minor > 0;
	
	ver_src_emerge := max((integer)ver_src_em, (integer)(integer)ver_src_e1, (integer)(integer)ver_src_e2, (integer)(integer)ver_src_e3, (integer)(integer)ver_src_e4);
	
	pk_r_pos_src_major := if(max(ver_src_emerge, (integer)ver_src_bureau, (integer)ver_src_pl, (integer)ver_src_vo, (integer)ver_src_wp, (integer)pk_r_pos_src_minor_flag) = NULL, NULL, sum(if(ver_src_emerge = NULL, 0, ver_src_emerge), (integer)ver_src_bureau, (integer)ver_src_pl, (integer)ver_src_vo, (integer)ver_src_wp, (integer)pk_r_pos_src_minor_flag));
	
	pk_r_pos_src_cnt := max(0, min(5, if(pk_r_pos_src_major = NULL, -NULL, pk_r_pos_src_major)));
	
	pk_r_pos_src_cnt_0_2 := 0;
	
	pk_r_pos_src_cnt_1_2 := 0;
	
	pk_r_pos_src_cnt_2_3 := 0;
	
	pk_r_pos_src_cnt_3_3 := 0;
	
	pk_r_pos_src_cnt_4_3 := 0;
	
	pk_r_pos_src_cnt_5_3 := 0;
	
	pk_r_pos_src_cnt_0_1 := if(pk_r_pos_src_cnt = 0, 1, pk_r_pos_src_cnt_0_2);
	
	pk_r_pos_src_cnt_1_1 := if(pk_r_pos_src_cnt = 1, 1, pk_r_pos_src_cnt_1_2);
	
	pk_r_pos_src_cnt_2_2 := if(pk_r_pos_src_cnt = 2, 1, pk_r_pos_src_cnt_2_3);
	
	pk_r_pos_src_cnt_3_2 := if(pk_r_pos_src_cnt = 3, 1, pk_r_pos_src_cnt_3_3);
	
	pk_r_pos_src_cnt_4_2 := if(pk_r_pos_src_cnt = 4, 1, pk_r_pos_src_cnt_4_3);
	
	pk_r_pos_src_cnt_5_2 := if(pk_r_pos_src_cnt = 5, 1, pk_r_pos_src_cnt_5_3);
	
	pk_add1_advo_address_vacancy_1 := if(trim(trim(add1_advo_address_vacancy, LEFT), LEFT, RIGHT) = 'Y', 1, 0);
	
	pk_add1_advo_throw_back_1 := if(trim(trim(add1_advo_throw_back, LEFT), LEFT, RIGHT) = 'Y', 1, 0);
	
	pk_add1_advo_college_1 := if(trim(trim(add1_advo_college, LEFT), LEFT, RIGHT) = 'Y', 1, 0);
	
	pk_add1_advo_dnd_1 := if(trim(trim(add1_advo_dnd, LEFT), LEFT, RIGHT) = 'Y', 1, 0);
	
	pk_impulse_flag_1 := if((INTEGER)impulse_flag > 0 or (INTEGER)email_src_im > 0, 1, 0);
	
	pk_lien_flag_1 := lien_rec_unrel_flag or lien_hist_unrel_flag;
	
	pk_bk_flag_1 := (TRIM(rc_bansflag) in ['1', '2']) or (INTEGER)bankrupt = 1 or (INTEGER)filing_count > 0 or (INTEGER)bk_recent_count > 0;
	
	pk_foreclosure_1 := if(ver_src_nas_fr >= 8, 1, 0);
	
	pk_inq_count70_2 := 0;
	
	pk_inq_count40_2 := 0;
	
	pk_inq_count10_2 := 0;
	
	pk_inq_count09_2 := 0;
	
	pk_inq_count40_1 := map(
	    Inq_count03 >= 70 => pk_inq_count40_2,
	    Inq_count03 >= 40 => 1,
	    Inq_count03 >= 10 => pk_inq_count40_2,
	                         pk_inq_count40_2);
	
	pk_inq_count10_1 := map(
	    Inq_count03 >= 70 => pk_inq_count10_2,
	    Inq_count03 >= 40 => pk_inq_count10_2,
	    Inq_count03 >= 10 => 1,
	                         pk_inq_count10_2);
	
	pk_inq_count09_1 := map(
	    Inq_count03 >= 70 => pk_inq_count09_2,
	    Inq_count03 >= 40 => pk_inq_count09_2,
	    Inq_count03 >= 10 => pk_inq_count09_2,
	                         1);
	
	pk_inq_count70_1 := map(
	    Inq_count03 >= 70 => 1,
	    Inq_count03 >= 40 => pk_inq_count70_2,
	    Inq_count03 >= 10 => pk_inq_count70_2,
	                         pk_inq_count70_2);
	
	pk_attr_num_nonderogs180_0_2 := 0;
	
	pk_attr_num_nonderogs180_1_2 := 0;
	
	pk_attr_num_nonderogs180_3_3 := 0;
	
	pk_attr_num_nonderogs180_4_3 := 0;
	
	pk_attr_num_nonderogs180_5_3 := 0;
	
	pk_attr_num_nonderogs180_6_3 := 0;
	
	pk_attr_num_nonderogs180_3_2 := map(
	    attr_num_nonderogs180 <= 0 => pk_attr_num_nonderogs180_3_3,
	    attr_num_nonderogs180 <= 1 => pk_attr_num_nonderogs180_3_3,
	    attr_num_nonderogs180 <= 3 => 1,
	    attr_num_nonderogs180 <= 4 => pk_attr_num_nonderogs180_3_3,
	    attr_num_nonderogs180 <= 5 => pk_attr_num_nonderogs180_3_3,
	                                  pk_attr_num_nonderogs180_3_3);
	
	pk_attr_num_nonderogs180_6_2 := map(
	    attr_num_nonderogs180 <= 0 => pk_attr_num_nonderogs180_6_3,
	    attr_num_nonderogs180 <= 1 => pk_attr_num_nonderogs180_6_3,
	    attr_num_nonderogs180 <= 3 => pk_attr_num_nonderogs180_6_3,
	    attr_num_nonderogs180 <= 4 => pk_attr_num_nonderogs180_6_3,
	    attr_num_nonderogs180 <= 5 => pk_attr_num_nonderogs180_6_3,
	                                  1);
	
	pk_attr_num_nonderogs180_5_2 := map(
	    attr_num_nonderogs180 <= 0 => pk_attr_num_nonderogs180_5_3,
	    attr_num_nonderogs180 <= 1 => pk_attr_num_nonderogs180_5_3,
	    attr_num_nonderogs180 <= 3 => pk_attr_num_nonderogs180_5_3,
	    attr_num_nonderogs180 <= 4 => pk_attr_num_nonderogs180_5_3,
	    attr_num_nonderogs180 <= 5 => 1,
	                                  pk_attr_num_nonderogs180_5_3);
	
	pk_attr_num_nonderogs180_0_1 := map(
	    attr_num_nonderogs180 <= 0 => 1,
	    attr_num_nonderogs180 <= 1 => pk_attr_num_nonderogs180_0_2,
	    attr_num_nonderogs180 <= 3 => pk_attr_num_nonderogs180_0_2,
	    attr_num_nonderogs180 <= 4 => pk_attr_num_nonderogs180_0_2,
	    attr_num_nonderogs180 <= 5 => pk_attr_num_nonderogs180_0_2,
	                                  pk_attr_num_nonderogs180_0_2);
	
	pk_attr_num_nonderogs180_1_1 := map(
	    attr_num_nonderogs180 <= 0 => pk_attr_num_nonderogs180_1_2,
	    attr_num_nonderogs180 <= 1 => 1,
	    attr_num_nonderogs180 <= 3 => pk_attr_num_nonderogs180_1_2,
	    attr_num_nonderogs180 <= 4 => pk_attr_num_nonderogs180_1_2,
	    attr_num_nonderogs180 <= 5 => pk_attr_num_nonderogs180_1_2,
	                                  pk_attr_num_nonderogs180_1_2);
	
	pk_attr_num_nonderogs180_4_2 := map(
	    attr_num_nonderogs180 <= 0 => pk_attr_num_nonderogs180_4_3,
	    attr_num_nonderogs180 <= 1 => pk_attr_num_nonderogs180_4_3,
	    attr_num_nonderogs180 <= 3 => pk_attr_num_nonderogs180_4_3,
	    attr_num_nonderogs180 <= 4 => 1,
	    attr_num_nonderogs180 <= 5 => pk_attr_num_nonderogs180_4_3,
	                                  pk_attr_num_nonderogs180_4_3);
	
	yr_header_first_seen := IF(mth_header_first_seen = NULL, NULL, roundup(mth_header_first_seen / 12));
	
	pk_yr_header_first_seen_0_2 := 0;
	
	pk_yr_header_first_seen_7_2 := 0;
	
	pk_yr_header_first_seen_9_2 := 0;
	
	pk_yr_header_first_seen_17_3 := 0;
	
	pk_yr_header_first_seen_18plus_3 := 0;
	
	pk_yr_header_first_seen_9_1 := map(
	    (yr_header_first_seen in [NULL, 0]) => pk_yr_header_first_seen_9_2,
	    yr_header_first_seen <= 7           => pk_yr_header_first_seen_9_2,
	    yr_header_first_seen <= 9           => 1,
	    yr_header_first_seen <= 17          => pk_yr_header_first_seen_9_2,
	                                           pk_yr_header_first_seen_9_2);
	
	pk_yr_header_first_seen_17_2 := map(
	    (yr_header_first_seen in [NULL, 0]) => pk_yr_header_first_seen_17_3,
	    yr_header_first_seen <= 7           => pk_yr_header_first_seen_17_3,
	    yr_header_first_seen <= 9           => pk_yr_header_first_seen_17_3,
	    yr_header_first_seen <= 17          => 1,
	                                           pk_yr_header_first_seen_17_3);
	
	pk_yr_header_first_seen_18plus_2 := map(
	    (yr_header_first_seen in [NULL, 0]) => pk_yr_header_first_seen_18plus_3,
	    yr_header_first_seen <= 7           => pk_yr_header_first_seen_18plus_3,
	    yr_header_first_seen <= 9           => pk_yr_header_first_seen_18plus_3,
	    yr_header_first_seen <= 17          => pk_yr_header_first_seen_18plus_3,
	                                           1);
	
	pk_yr_header_first_seen_0_1 := map(
	    (yr_header_first_seen in [NULL, 0]) => 1,
	    yr_header_first_seen <= 7           => pk_yr_header_first_seen_0_2,
	    yr_header_first_seen <= 9           => pk_yr_header_first_seen_0_2,
	    yr_header_first_seen <= 17          => pk_yr_header_first_seen_0_2,
	                                           pk_yr_header_first_seen_0_2);
	
	pk_yr_header_first_seen_7_1 := map(
	    (yr_header_first_seen in [NULL, 0]) => pk_yr_header_first_seen_7_2,
	    yr_header_first_seen <= 7           => 1,
	    yr_header_first_seen <= 9           => pk_yr_header_first_seen_7_2,
	    yr_header_first_seen <= 17          => pk_yr_header_first_seen_7_2,
	                                           pk_yr_header_first_seen_7_2);
	
	did_not_found := not((boolean)(integer)did_found);
	
	addrs_prison_history_1 := if(did_not_found, 0, (INTEGER)addrs_prison_history);
	
	pk_yr_header_first_seen_17_1 := if(did_not_found, 0, pk_yr_header_first_seen_17_2);
	
	pk_add1_advo_throw_back := if(did_not_found, 0, pk_add1_advo_throw_back_1);
	
	pk_r_pos_src_cnt_5_1 := if(did_not_found, 0, pk_r_pos_src_cnt_5_2);
	
	pk_bk_flag := if(did_not_found, 0, (INTEGER)pk_bk_flag_1);
	
	pk_inq_count09 := if(did_not_found, 0, pk_inq_count09_1);
	
	pk_impulse_flag := if(did_not_found, 0, pk_impulse_flag_1);
	
	pk_rc_numelever_5_1 := if(did_not_found, 0, pk_rc_numelever_5_2);
	
	pk_add1_advo_dnd := if(did_not_found, 0, pk_add1_advo_dnd_1);
	
	pk_attr_num_nonderogs180_0 := if(did_not_found, 0, pk_attr_num_nonderogs180_0_1);
	
	pk_attr_num_nonderogs180_1 := if(did_not_found, 0, pk_attr_num_nonderogs180_1_1);
	
	pk_inq_count10 := if(did_not_found, 0, pk_inq_count10_1);
	
	pk_attr_num_nonderogs180_3_1 := if(did_not_found, 0, pk_attr_num_nonderogs180_3_2);
	
	pk_yr_header_first_seen_9 := if(did_not_found, 0, pk_yr_header_first_seen_9_1);
	
	ssn_inval := if(did_not_found, 0, (INTEGER)ssn_inval_1);
	
	pk_r_pos_src_cnt_3_1 := if(did_not_found, 0, pk_r_pos_src_cnt_3_2);
	
	pk_yr_header_first_seen_0 := if(did_not_found, 0, pk_yr_header_first_seen_0_1);
	
	pk_inq_count40 := if(did_not_found, 0, pk_inq_count40_1);
	
	ssn_deceased := if(did_not_found, 0, (INTEGER)ssn_deceased_1);
	
	pk_rc_numelever_34_1 := if(did_not_found, 0, pk_rc_numelever_34_2);
	
	pk_r_pos_src_cnt_1 := if(did_not_found, 0, pk_r_pos_src_cnt_1_1);
	
	pk_lien_flag := if(did_not_found, 0, (INTEGER)pk_lien_flag_1);
	
	add_pobox := if(did_not_found, 0, (INTEGER)add_pobox_1);
	
	pk_add1_advo_college := if(did_not_found, 0, pk_add1_advo_college_1);
	
	pk_rc_numelever_2 := if(did_not_found, 0, pk_rc_numelever_2_1);
	
	pk_disconnected := if(did_not_found, 0, (INTEGER)pk_disconnected_1);
	
	pk_attr_num_nonderogs180_6_1 := if(did_not_found, 0, pk_attr_num_nonderogs180_6_2);
	
	ssn_priordob := if(did_not_found, 0, (INTEGER)ssn_priordob_1);
	
	pk_r_pos_src_cnt_0 := if(did_not_found, 0, pk_r_pos_src_cnt_0_1);
	
	pk_addinval := if(did_not_found, 0, (INTEGER)pk_addinval_1);
	
	pk_inq_count70 := if(did_not_found, 0, pk_inq_count70_1);
	
	pk_rc_numelever_6_1 := if(did_not_found, 0, pk_rc_numelever_6_2);
	
	phn_highrisk := if(did_not_found, 0, (INTEGER)phn_highrisk_1);
	
	pk_rc_numelever_0 := if(did_not_found, 0, pk_rc_numelever_0_1);
	
	pk_attr_num_nonderogs180_5_1 := if(did_not_found, 0, pk_attr_num_nonderogs180_5_2);
	
	pk_r_pos_src_cnt_4_1 := if(did_not_found, 0, pk_r_pos_src_cnt_4_2);
	
	pk_add1_advo_address_vacancy := if(did_not_found, 0, pk_add1_advo_address_vacancy_1);
	
	pk_rc_numelever_partial_1 := if(did_not_found, 0, pk_rc_numelever_partial_2);
	
	pk_yr_header_first_seen_18plus_1 := if(did_not_found, 0, pk_yr_header_first_seen_18plus_2);
	
	pk_attr_num_nonderogs180_4_1 := if(did_not_found, 0, pk_attr_num_nonderogs180_4_2);
	
	pk_yr_header_first_seen_7 := if(did_not_found, 0, pk_yr_header_first_seen_7_1);
	
	pk_r_pos_src_cnt_2_1 := if(did_not_found, 0, pk_r_pos_src_cnt_2_2);
	
	pk_foreclosure := if(did_not_found, 0, pk_foreclosure_1);
	
	pk_bk_flag2_c486 := map(
	    mth_date_last_seen = NULL => 0.50,
	    mth_date_last_seen <= 24  => 1.00,
	    mth_date_last_seen <= 60  => 0.67,
	                                 0.50);
	
	pk_bk_flag2 := if(pk_bk_flag = 1, pk_bk_flag2_c486, 0);
	
	ver_name_src_ds_1 := ver_fname_src_ds or ver_lname_src_ds;
	
	ver_name_src_de_1 := ver_fname_src_de or ver_lname_src_de;
	
	pk_deceased2 := if((INTEGER)ver_ssn_src_ds = 1 and (INTEGER)ver_name_src_ds_1 = 1 or 
										(INTEGER)ver_ssn_src_de = 1 and (INTEGER)ver_name_src_de_1 = 1 or 
										(INTEGER)ver_addr_src_ds = 1 and (INTEGER)ver_name_src_ds_1 = 1 or 
										(INTEGER)ver_addr_src_de = 1 and (INTEGER)ver_name_src_de_1 = 1 or 
										(INTEGER)ver_ssn_src_ds = 1 or (INTEGER)ver_ssn_src_de = 1 or (INTEGER)ssn_deceased = 1, 1, 0);
	
	incarceration_y := if((INTEGER)incar_flag = 1, 1, 0);
	
	leie_hit := if((INTEGER)sanc_OIG_LEIE_Count > 0, 1, 0);
	
	leie_ran_hit := if((INTEGER)sanc_OIG_LEIE_RAN_Count > 0, 1, 0);
	
	leie_caff_hit := if((INTEGER)sanc_OIG_LEIE_Count_CAff > 0, 1, 0);
	
	medlicproflic_none := if(in_MedLicProfLic_None, 1, 0);
	
	medlicproflic_exp := if(in_MedLicProfLic_Exp, 1, 0);
	
	medlicproflic_same_state_none := if((INTEGER)in_MedLicProfLic_Same_State = 0, 1, 0);
	
	medlicproflic_same_state_exp := if(in_MedLicProfLic_Same_State_Exp, 1, 0);
	
	time_on_ps_unknown_1 := 0;
	
	time_on_ps_03_1 := 0;
	
	time_on_ps_06_1 := 0;
	
	time_on_ps_09_2 := 0;
	
	time_on_ps_13_2 := 0;
	
	time_on_ps_18_2 := 0;
	
	time_on_ps_24_2 := 0;
	
	time_on_ps_30_2 := 0;
	
	time_on_ps_38_2 := 0;
	
	time_on_ps_39_2 := 0;
	
	time_on_ps_unknown := map(
	    Overall_Year_Min = 9999 => 1,
	    Time_On_PS = NULL       => time_on_ps_unknown_1,
	    Time_On_PS < 3          => time_on_ps_unknown_1,
	    Time_On_PS < 6          => time_on_ps_unknown_1,
	    Time_On_PS < 9          => time_on_ps_unknown_1,
	    Time_On_PS < 13         => time_on_ps_unknown_1,
	    Time_On_PS < 18         => time_on_ps_unknown_1,
	    Time_On_PS < 24         => time_on_ps_unknown_1,
	    Time_On_PS < 30         => time_on_ps_unknown_1,
	    Time_On_PS < 38         => time_on_ps_unknown_1,
	                               time_on_ps_unknown_1);
	
	time_on_ps_39_1 := map(
	    Overall_Year_Min = 9999 => time_on_ps_39_2,
	    Time_On_PS = NULL       => time_on_ps_39_2,
	    Time_On_PS < 3          => time_on_ps_39_2,
	    Time_On_PS < 6          => time_on_ps_39_2,
	    Time_On_PS < 9          => time_on_ps_39_2,
	    Time_On_PS < 13         => time_on_ps_39_2,
	    Time_On_PS < 18         => time_on_ps_39_2,
	    Time_On_PS < 24         => time_on_ps_39_2,
	    Time_On_PS < 30         => time_on_ps_39_2,
	    Time_On_PS < 38         => time_on_ps_39_2,
	                               1);
	
	time_on_ps_03 := map(
	    Overall_Year_Min = 9999 => time_on_ps_03_1,
	    Time_On_PS = NULL       => time_on_ps_03_1,
	    Time_On_PS < 3          => 1,
	    Time_On_PS < 6          => time_on_ps_03_1,
	    Time_On_PS < 9          => time_on_ps_03_1,
	    Time_On_PS < 13         => time_on_ps_03_1,
	    Time_On_PS < 18         => time_on_ps_03_1,
	    Time_On_PS < 24         => time_on_ps_03_1,
	    Time_On_PS < 30         => time_on_ps_03_1,
	    Time_On_PS < 38         => time_on_ps_03_1,
	                               time_on_ps_03_1);
	
	time_on_ps_13_1 := map(
	    Overall_Year_Min = 9999 => time_on_ps_13_2,
	    Time_On_PS = NULL       => time_on_ps_13_2,
	    Time_On_PS < 3          => time_on_ps_13_2,
	    Time_On_PS < 6          => time_on_ps_13_2,
	    Time_On_PS < 9          => time_on_ps_13_2,
	    Time_On_PS < 13         => 1,
	    Time_On_PS < 18         => time_on_ps_13_2,
	    Time_On_PS < 24         => time_on_ps_13_2,
	    Time_On_PS < 30         => time_on_ps_13_2,
	    Time_On_PS < 38         => time_on_ps_13_2,
	                               time_on_ps_13_2);
	
	time_on_ps_18_1 := map(
	    Overall_Year_Min = 9999 => time_on_ps_18_2,
	    Time_On_PS = NULL       => time_on_ps_18_2,
	    Time_On_PS < 3          => time_on_ps_18_2,
	    Time_On_PS < 6          => time_on_ps_18_2,
	    Time_On_PS < 9          => time_on_ps_18_2,
	    Time_On_PS < 13         => time_on_ps_18_2,
	    Time_On_PS < 18         => 1,
	    Time_On_PS < 24         => time_on_ps_18_2,
	    Time_On_PS < 30         => time_on_ps_18_2,
	    Time_On_PS < 38         => time_on_ps_18_2,
	                               time_on_ps_18_2);
	
	time_on_ps_38_1 := map(
	    Overall_Year_Min = 9999 => time_on_ps_38_2,
	    Time_On_PS = NULL       => time_on_ps_38_2,
	    Time_On_PS < 3          => time_on_ps_38_2,
	    Time_On_PS < 6          => time_on_ps_38_2,
	    Time_On_PS < 9          => time_on_ps_38_2,
	    Time_On_PS < 13         => time_on_ps_38_2,
	    Time_On_PS < 18         => time_on_ps_38_2,
	    Time_On_PS < 24         => time_on_ps_38_2,
	    Time_On_PS < 30         => time_on_ps_38_2,
	    Time_On_PS < 38         => 1,
	                               time_on_ps_38_2);
	
	time_on_ps_24_1 := map(
	    Overall_Year_Min = 9999 => time_on_ps_24_2,
	    Time_On_PS = NULL       => time_on_ps_24_2,
	    Time_On_PS < 3          => time_on_ps_24_2,
	    Time_On_PS < 6          => time_on_ps_24_2,
	    Time_On_PS < 9          => time_on_ps_24_2,
	    Time_On_PS < 13         => time_on_ps_24_2,
	    Time_On_PS < 18         => time_on_ps_24_2,
	    Time_On_PS < 24         => 1,
	    Time_On_PS < 30         => time_on_ps_24_2,
	    Time_On_PS < 38         => time_on_ps_24_2,
	                               time_on_ps_24_2);
	
	time_on_ps_30_1 := map(
	    Overall_Year_Min = 9999 => time_on_ps_30_2,
	    Time_On_PS = NULL       => time_on_ps_30_2,
	    Time_On_PS < 3          => time_on_ps_30_2,
	    Time_On_PS < 6          => time_on_ps_30_2,
	    Time_On_PS < 9          => time_on_ps_30_2,
	    Time_On_PS < 13         => time_on_ps_30_2,
	    Time_On_PS < 18         => time_on_ps_30_2,
	    Time_On_PS < 24         => time_on_ps_30_2,
	    Time_On_PS < 30         => 1,
	    Time_On_PS < 38         => time_on_ps_30_2,
	                               time_on_ps_30_2);
	
	time_on_ps_06 := map(
	    Overall_Year_Min = 9999 => time_on_ps_06_1,
	    Time_On_PS = NULL       => 1,
	    Time_On_PS < 3          => time_on_ps_06_1,
	    Time_On_PS < 6          => 1,
	    Time_On_PS < 9          => time_on_ps_06_1,
	    Time_On_PS < 13         => time_on_ps_06_1,
	    Time_On_PS < 18         => time_on_ps_06_1,
	    Time_On_PS < 24         => time_on_ps_06_1,
	    Time_On_PS < 30         => time_on_ps_06_1,
	    Time_On_PS < 38         => time_on_ps_06_1,
	                               time_on_ps_06_1);
	
	time_on_ps_09_1 := map(
	    Overall_Year_Min = 9999 => time_on_ps_09_2,
	    Time_On_PS = NULL       => time_on_ps_09_2,
	    Time_On_PS < 3          => time_on_ps_09_2,
	    Time_On_PS < 6          => time_on_ps_09_2,
	    Time_On_PS < 9          => 1,
	    Time_On_PS < 13         => time_on_ps_09_2,
	    Time_On_PS < 18         => time_on_ps_09_2,
	    Time_On_PS < 24         => time_on_ps_09_2,
	    Time_On_PS < 30         => time_on_ps_09_2,
	    Time_On_PS < 38         => time_on_ps_09_2,
	                               time_on_ps_09_2);
	
	sex_offense_tot_1 := 1.00 * sex_offense_count_24 +
	    0.67 * sex_offense_count_60 +
	    0.50 * sex_offense_count_61;
	
	sex_offense_tot := if(sex_offense_tot_1 = NULL, 0, sex_offense_tot_1);
	
	sanction_black_current_count_1 := if(max(sanc_f02_Current_Count, sanc_f05_Current_Count, sanc_f06_Current_Count, sanc_F07_Current_Count, sanc_F08_Current_Count, sanc_f11_Current_Count, sanc_f19_Current_Count, sanc_f20_Current_Count, sanc_f21_Current_Count, sanc_f22_Current_Count, sanc_f23_Current_Count, sanc_f24_Current_Count, sanc_f25_Current_Count) = NULL, NULL, sum(if(sanc_f02_Current_Count = NULL, 0, sanc_f02_Current_Count), if(sanc_f05_Current_Count = NULL, 0, sanc_f05_Current_Count), if(sanc_f06_Current_Count = NULL, 0, sanc_f06_Current_Count), if(sanc_F07_Current_Count = NULL, 0, sanc_F07_Current_Count), if(sanc_F08_Current_Count = NULL, 0, sanc_F08_Current_Count), if(sanc_f11_Current_Count = NULL, 0, sanc_f11_Current_Count), if(sanc_f19_Current_Count = NULL, 0, sanc_f19_Current_Count), if(sanc_f20_Current_Count = NULL, 0, sanc_f20_Current_Count), if(sanc_f21_Current_Count = NULL, 0, sanc_f21_Current_Count), if(sanc_f22_Current_Count = NULL, 0, sanc_f22_Current_Count), if(sanc_f23_Current_Count = NULL, 0, sanc_f23_Current_Count), if(sanc_f24_Current_Count = NULL, 0, sanc_f24_Current_Count), if(sanc_f25_Current_Count = NULL, 0, sanc_f25_Current_Count)));
	
	sanction_red_current_count_1 := if(max((INTEGER)sanc_f12_Current_Count, (INTEGER)sanc_f16_Current_Count, (INTEGER)sanc_os_Current_Count) = NULL, NULL, sum(if((INTEGER)sanc_f12_Current_Count = NULL, 0, (INTEGER)sanc_f12_Current_Count), if((INTEGER)sanc_f16_Current_Count = NULL, 0, (INTEGER)sanc_f16_Current_Count), if((INTEGER)sanc_os_Current_Count = NULL, 0, (INTEGER)sanc_os_Current_Count)));
	
	sanction_yellow_current_count_2 := if(max(sanc_f03_Current_Count, sanc_f04_Current_Count, sanc_f09_Current_Count, sanc_f10_Current_Count, sanc_f13_Current_Count, sanc_f17_Current_Count, sanc_f18_Current_Count, sanc_f26_Current_Count) = NULL, NULL, sum(if(sanc_f03_Current_Count = NULL, 0, sanc_f03_Current_Count), if(sanc_f04_Current_Count = NULL, 0, sanc_f04_Current_Count), if(sanc_f09_Current_Count = NULL, 0, sanc_f09_Current_Count), if(sanc_f10_Current_Count = NULL, 0, sanc_f10_Current_Count), if(sanc_f13_Current_Count = NULL, 0, sanc_f13_Current_Count), if(sanc_f17_Current_Count = NULL, 0, sanc_f17_Current_Count), if(sanc_f18_Current_Count = NULL, 0, sanc_f18_Current_Count), if(sanc_f26_Current_Count = NULL, 0, sanc_f26_Current_Count)));
	
	sanc_accusation_current_count := sanc_f01_Current_Count;
	
	mult_accusation_adj_3 := truncate(sanc_accusation_current_count / 5);
	
	sanction_yellow_current_count_1 := if(mult_accusation_adj_3 > 0, sanction_yellow_current_count_2 + mult_accusation_adj_3, sanction_yellow_current_count_2);
	
	sanction_black_24_count_1 := if(max(sanc_f02_24_Count, sanc_f05_24_Count, sanc_f06_24_Count, sanc_F07_24_Count, sanc_F08_24_Count, sanc_f11_24_Count, sanc_f19_24_Count, sanc_f20_24_Count, sanc_f21_24_Count, sanc_f22_24_Count, sanc_f23_24_Count, sanc_f24_24_Count, sanc_f25_24_Count) = NULL, NULL, sum(if(sanc_f02_24_Count = NULL, 0, sanc_f02_24_Count), if(sanc_f05_24_Count = NULL, 0, sanc_f05_24_Count), if(sanc_f06_24_Count = NULL, 0, sanc_f06_24_Count), if(sanc_F07_24_Count = NULL, 0, sanc_F07_24_Count), if(sanc_F08_24_Count = NULL, 0, sanc_F08_24_Count), if(sanc_f11_24_Count = NULL, 0, sanc_f11_24_Count), if(sanc_f19_24_Count = NULL, 0, sanc_f19_24_Count), if(sanc_f20_24_Count = NULL, 0, sanc_f20_24_Count), if(sanc_f21_24_Count = NULL, 0, sanc_f21_24_Count), if(sanc_f22_24_Count = NULL, 0, sanc_f22_24_Count), if(sanc_f23_24_Count = NULL, 0, sanc_f23_24_Count), if(sanc_f24_24_Count = NULL, 0, sanc_f24_24_Count), if(sanc_f25_24_Count = NULL, 0, sanc_f25_24_Count)));
	
	sanction_red_24_count_1 := if(max((INTEGER)sanc_f12_24_Count, (INTEGER)sanc_f16_24_Count, (INTEGER)sanc_os_24_Count) = NULL, NULL, sum(if((INTEGER)sanc_f12_24_Count = NULL, 0, (INTEGER)sanc_f12_24_Count), if((INTEGER)sanc_f16_24_Count = NULL, 0, (INTEGER)sanc_f16_24_Count), if((INTEGER)sanc_os_24_Count = NULL, 0, (INTEGER)sanc_os_24_Count)));
	
	sanction_yellow_24_count_2 := if(max(sanc_f03_24_Count, sanc_f04_24_Count, sanc_f09_24_Count, sanc_f10_24_Count, sanc_f13_24_Count, sanc_f17_24_Count, sanc_f18_24_Count, sanc_f26_24_Count) = NULL, NULL, sum(if(sanc_f03_24_Count = NULL, 0, sanc_f03_24_Count), if(sanc_f04_24_Count = NULL, 0, sanc_f04_24_Count), if(sanc_f09_24_Count = NULL, 0, sanc_f09_24_Count), if(sanc_f10_24_Count = NULL, 0, sanc_f10_24_Count), if(sanc_f13_24_Count = NULL, 0, sanc_f13_24_Count), if(sanc_f17_24_Count = NULL, 0, sanc_f17_24_Count), if(sanc_f18_24_Count = NULL, 0, sanc_f18_24_Count), if(sanc_f26_24_Count = NULL, 0, sanc_f26_24_Count)));
	
	sanc_accusation_24_count := sanc_f01_24_Count;
	
	mult_accusation_adj_2 := truncate(sanc_accusation_24_count / 5);
	
	sanction_yellow_24_count_1 := if(mult_accusation_adj_2 > 0, sanction_yellow_24_count_2 + mult_accusation_adj_2, sanction_yellow_24_count_2);
	
	sanction_black_60_count_1 := if(max(sanc_f02_60_Count, sanc_f05_60_Count, sanc_f06_60_Count, sanc_F07_60_Count, sanc_F08_60_Count, sanc_f11_60_Count, sanc_f19_60_Count, sanc_f20_60_Count, sanc_f21_60_Count, sanc_f22_60_Count, sanc_f23_60_Count, sanc_f24_60_Count, sanc_f25_60_Count) = NULL, NULL, sum(if(sanc_f02_60_Count = NULL, 0, sanc_f02_60_Count), if(sanc_f05_60_Count = NULL, 0, sanc_f05_60_Count), if(sanc_f06_60_Count = NULL, 0, sanc_f06_60_Count), if(sanc_F07_60_Count = NULL, 0, sanc_F07_60_Count), if(sanc_F08_60_Count = NULL, 0, sanc_F08_60_Count), if(sanc_f11_60_Count = NULL, 0, sanc_f11_60_Count), if(sanc_f19_60_Count = NULL, 0, sanc_f19_60_Count), if(sanc_f20_60_Count = NULL, 0, sanc_f20_60_Count), if(sanc_f21_60_Count = NULL, 0, sanc_f21_60_Count), if(sanc_f22_60_Count = NULL, 0, sanc_f22_60_Count), if(sanc_f23_60_Count = NULL, 0, sanc_f23_60_Count), if(sanc_f24_60_Count = NULL, 0, sanc_f24_60_Count), if(sanc_f25_60_Count = NULL, 0, sanc_f25_60_Count)));
	
	sanction_red_60_count_1 := if(max((INTEGER)sanc_f12_60_Count, (INTEGER)sanc_f16_60_Count, (INTEGER)sanc_os_60_Count) = NULL, NULL, sum(if((INTEGER)sanc_f12_60_Count = NULL, 0, (INTEGER)sanc_f12_60_Count), if((INTEGER)sanc_f16_60_Count = NULL, 0, (INTEGER)sanc_f16_60_Count), if((INTEGER)sanc_os_60_Count = NULL, 0, (INTEGER)sanc_os_60_Count)));
	
	sanction_yellow_60_count_2 := if(max(sanc_f03_60_Count, sanc_f04_60_Count, sanc_f09_60_Count, sanc_f10_60_Count, sanc_f13_60_Count, sanc_f17_60_Count, sanc_f18_60_Count, sanc_f26_60_Count) = NULL, NULL, sum(if(sanc_f03_60_Count = NULL, 0, sanc_f03_60_Count), if(sanc_f04_60_Count = NULL, 0, sanc_f04_60_Count), if(sanc_f09_60_Count = NULL, 0, sanc_f09_60_Count), if(sanc_f10_60_Count = NULL, 0, sanc_f10_60_Count), if(sanc_f13_60_Count = NULL, 0, sanc_f13_60_Count), if(sanc_f17_60_Count = NULL, 0, sanc_f17_60_Count), if(sanc_f18_60_Count = NULL, 0, sanc_f18_60_Count), if(sanc_f26_60_Count = NULL, 0, sanc_f26_60_Count)));
	
	sanc_accusation_60_count := sanc_f01_60_Count;
	
	mult_accusation_adj_1 := truncate(sanc_accusation_60_count / 5);
	
	sanction_yellow_60_count_1 := if(mult_accusation_adj_1 > 0, sanction_yellow_60_count_2 + mult_accusation_adj_1, sanction_yellow_60_count_2);
	
	sanction_black_61_count_1 := if(max(sanc_f02_61_Count, sanc_f05_61_Count, sanc_f06_61_Count, sanc_F07_61_Count, sanc_F08_61_Count, sanc_f11_61_Count, sanc_f19_61_Count, sanc_f20_61_Count, sanc_f21_61_Count, sanc_f22_61_Count, sanc_f23_61_Count, sanc_f24_61_Count, sanc_f25_61_Count) = NULL, NULL, sum(if(sanc_f02_61_Count = NULL, 0, sanc_f02_61_Count), if(sanc_f05_61_Count = NULL, 0, sanc_f05_61_Count), if(sanc_f06_61_Count = NULL, 0, sanc_f06_61_Count), if(sanc_F07_61_Count = NULL, 0, sanc_F07_61_Count), if(sanc_F08_61_Count = NULL, 0, sanc_F08_61_Count), if(sanc_f11_61_Count = NULL, 0, sanc_f11_61_Count), if(sanc_f19_61_Count = NULL, 0, sanc_f19_61_Count), if(sanc_f20_61_Count = NULL, 0, sanc_f20_61_Count), if(sanc_f21_61_Count = NULL, 0, sanc_f21_61_Count), if(sanc_f22_61_Count = NULL, 0, sanc_f22_61_Count), if(sanc_f23_61_Count = NULL, 0, sanc_f23_61_Count), if(sanc_f24_61_Count = NULL, 0, sanc_f24_61_Count), if(sanc_f25_61_Count = NULL, 0, sanc_f25_61_Count)));
	
	sanction_red_61_count_1 := if(max((INTEGER)sanc_f12_61_Count, (INTEGER)sanc_f16_61_Count, (INTEGER)sanc_os_61_Count) = NULL, NULL, sum(if((INTEGER)sanc_f12_61_Count = NULL, 0, (INTEGER)sanc_f12_61_Count), if((INTEGER)sanc_f16_61_Count = NULL, 0, (INTEGER)sanc_f16_61_Count), if((INTEGER)sanc_os_61_Count = NULL, 0, (INTEGER)sanc_os_61_Count)));
	
	sanction_yellow_61_count_2 := if(max(sanc_f03_61_Count, sanc_f04_61_Count, sanc_f09_61_Count, sanc_f10_61_Count, sanc_f13_61_Count, sanc_f17_61_Count, sanc_f18_61_Count, sanc_f26_61_Count) = NULL, NULL, sum(if(sanc_f03_61_Count = NULL, 0, sanc_f03_61_Count), if(sanc_f04_61_Count = NULL, 0, sanc_f04_61_Count), if(sanc_f09_61_Count = NULL, 0, sanc_f09_61_Count), if(sanc_f10_61_Count = NULL, 0, sanc_f10_61_Count), if(sanc_f13_61_Count = NULL, 0, sanc_f13_61_Count), if(sanc_f17_61_Count = NULL, 0, sanc_f17_61_Count), if(sanc_f18_61_Count = NULL, 0, sanc_f18_61_Count), if(sanc_f26_61_Count = NULL, 0, sanc_f26_61_Count)));
	
	sanc_accusation_61_count := sanc_f01_61_Count;
	
	mult_accusation_adj := truncate(sanc_accusation_61_count / 5);
	
	sanction_yellow_61_count_1 := if(mult_accusation_adj > 0, sanction_yellow_61_count_2 + mult_accusation_adj, sanction_yellow_61_count_2);
	
	sanction_black_current_count := if(sanction_black_current_count_1 = NULL, 0, sanction_black_current_count_1);
	
	sanction_red_current_count := if(sanction_red_current_count_1 = NULL, 0, sanction_red_current_count_1);
	
	sanction_yellow_current_count := if(sanction_yellow_current_count_1 = NULL, 0, sanction_yellow_current_count_1);
	
	sanction_black_24_count := if(sanction_black_24_count_1 = NULL, 0, sanction_black_24_count_1);
	
	sanction_red_24_count := if(sanction_red_24_count_1 = NULL, 0, sanction_red_24_count_1);
	
	sanction_yellow_24_count := if(sanction_yellow_24_count_1 = NULL, 0, sanction_yellow_24_count_1);
	
	sanction_black_60_count := if(sanction_black_60_count_1 = NULL, 0, sanction_black_60_count_1);
	
	sanction_red_60_count := if(sanction_red_60_count_1 = NULL, 0, sanction_red_60_count_1);
	
	sanction_yellow_60_count := if(sanction_yellow_60_count_1 = NULL, 0, sanction_yellow_60_count_1);
	
	sanction_black_61_count := if(sanction_black_61_count_1 = NULL, 0, sanction_black_61_count_1);
	
	sanction_red_61_count := if(sanction_red_61_count_1 = NULL, 0, sanction_red_61_count_1);
	
	sanction_yellow_61_count := if(sanction_yellow_61_count_1 = NULL, 0, sanction_yellow_61_count_1);
	
	sanction_black_count := sanction_black_current_count * 1.00 +
	    sanction_black_24_count * 1.00 +
	    sanction_black_60_count * 0.67 +
	    sanction_black_61_count * 0.50;
	
	sanction_red_count := sanction_red_current_count * 1.00 +
	    sanction_red_24_count * 1.00 +
	    sanction_red_60_count * 0.67 +
	    sanction_red_61_count * 0.50;
	
	sanction_yellow_count := sanction_yellow_current_count * 1.00 +
	    sanction_yellow_24_count * 1.00 +
	    sanction_yellow_60_count * 0.67 +
	    sanction_yellow_61_count * 0.50;
	
	sanction_points_1 := -400 * sanction_black_count +
	    -300 * sanction_red_count +
	    -200 * sanction_yellow_count;
	
	sanction_points := if(sanction_points_1 < -450, -450, sanction_points_1);
	
	wc_sanction_count := if(max(sanction_black_current_count, sanction_black_24_count, sanction_black_60_count, sanction_black_61_count, sanction_red_current_count, sanction_red_24_count, sanction_red_60_count, sanction_red_61_count, sanction_yellow_current_count, sanction_yellow_24_count, sanction_yellow_60_count, sanction_yellow_61_count) = NULL, NULL, sum(if(sanction_black_current_count = NULL, 0, sanction_black_current_count), if(sanction_black_24_count = NULL, 0, sanction_black_24_count), if(sanction_black_60_count = NULL, 0, sanction_black_60_count), if(sanction_black_61_count = NULL, 0, sanction_black_61_count), if(sanction_red_current_count = NULL, 0, sanction_red_current_count), if(sanction_red_24_count = NULL, 0, sanction_red_24_count), if(sanction_red_60_count = NULL, 0, sanction_red_60_count), if(sanction_red_61_count = NULL, 0, sanction_red_61_count), if(sanction_yellow_current_count = NULL, 0, sanction_yellow_current_count), if(sanction_yellow_24_count = NULL, 0, sanction_yellow_24_count), if(sanction_yellow_60_count = NULL, 0, sanction_yellow_60_count), if(sanction_yellow_61_count = NULL, 0, sanction_yellow_61_count)));
	
	sanc_black_current_count_ran_1 := if(max(sanc_f02_Current_Count_RAN, sanc_f05_Current_Count_RAN, sanc_f06_Current_Count_RAN, sanc_F07_Current_Count_RAN, sanc_F08_Current_Count_RAN, sanc_f11_Current_Count_RAN, sanc_f19_Current_Count_RAN, sanc_f20_Current_Count_RAN, sanc_f21_Current_Count_RAN, sanc_f22_Current_Count_RAN, sanc_f23_Current_Count_RAN, sanc_f24_Current_Count_RAN, sanc_f25_Current_Count_RAN) = NULL, NULL, sum(if(sanc_f02_Current_Count_RAN = NULL, 0, sanc_f02_Current_Count_RAN), if(sanc_f05_Current_Count_RAN = NULL, 0, sanc_f05_Current_Count_RAN), if(sanc_f06_Current_Count_RAN = NULL, 0, sanc_f06_Current_Count_RAN), if(sanc_F07_Current_Count_RAN = NULL, 0, sanc_F07_Current_Count_RAN), if(sanc_F08_Current_Count_RAN = NULL, 0, sanc_F08_Current_Count_RAN), if(sanc_f11_Current_Count_RAN = NULL, 0, sanc_f11_Current_Count_RAN), if(sanc_f19_Current_Count_RAN = NULL, 0, sanc_f19_Current_Count_RAN), if(sanc_f20_Current_Count_RAN = NULL, 0, sanc_f20_Current_Count_RAN), if(sanc_f21_Current_Count_RAN = NULL, 0, sanc_f21_Current_Count_RAN), if(sanc_f22_Current_Count_RAN = NULL, 0, sanc_f22_Current_Count_RAN), if(sanc_f23_Current_Count_RAN = NULL, 0, sanc_f23_Current_Count_RAN), if(sanc_f24_Current_Count_RAN = NULL, 0, sanc_f24_Current_Count_RAN), if(sanc_f25_Current_Count_RAN = NULL, 0, sanc_f25_Current_Count_RAN)));
	
	sanc_red_current_count_ran_1 := if(max((INTEGER)sanc_f12_Current_Count_RAN, (INTEGER)sanc_f16_Current_Count_RAN, (INTEGER)sanc_os_Current_Count_RAN) = NULL, NULL, sum(if((INTEGER)sanc_f12_Current_Count_RAN = NULL, 0, (INTEGER)sanc_f12_Current_Count_RAN), if((INTEGER)sanc_f16_Current_Count_RAN = NULL, 0, (INTEGER)sanc_f16_Current_Count_RAN), if((INTEGER)sanc_os_Current_Count_RAN = NULL, 0, (INTEGER)sanc_os_Current_Count_RAN)));
	
	sanc_yellow_current_count_ran_2 := if(max(sanc_f03_Current_Count_RAN, sanc_f04_Current_Count_RAN, sanc_f09_Current_Count_RAN, sanc_f10_Current_Count_RAN, sanc_f13_Current_Count_RAN, sanc_f17_Current_Count_RAN, sanc_f18_Current_Count_RAN, sanc_f26_Current_Count_RAN) = NULL, NULL, sum(if(sanc_f03_Current_Count_RAN = NULL, 0, sanc_f03_Current_Count_RAN), if(sanc_f04_Current_Count_RAN = NULL, 0, sanc_f04_Current_Count_RAN), if(sanc_f09_Current_Count_RAN = NULL, 0, sanc_f09_Current_Count_RAN), if(sanc_f10_Current_Count_RAN = NULL, 0, sanc_f10_Current_Count_RAN), if(sanc_f13_Current_Count_RAN = NULL, 0, sanc_f13_Current_Count_RAN), if(sanc_f17_Current_Count_RAN = NULL, 0, sanc_f17_Current_Count_RAN), if(sanc_f18_Current_Count_RAN = NULL, 0, sanc_f18_Current_Count_RAN), if(sanc_f26_Current_Count_RAN = NULL, 0, sanc_f26_Current_Count_RAN)));
	
	sanc_acc_curr_cnt_ran := sanc_f01_Current_Count_RAN;
	
	mult_accusation_adj_current_ran := truncate(sanc_acc_curr_cnt_ran / 5);
	
	sanc_yellow_current_count_ran_1 := if(mult_accusation_adj_current_ran > 0, sanc_yellow_current_count_ran_2 + mult_accusation_adj_current_ran, sanc_yellow_current_count_ran_2);
	
	sanc_black_24_count_ran_1 := if(max(sanc_f02_24_Count_RAN, sanc_f05_24_Count_RAN, sanc_f06_24_Count_RAN, sanc_F07_24_Count_RAN, sanc_F08_24_Count_RAN, sanc_f11_24_Count_RAN, sanc_f19_24_Count_RAN, sanc_f20_24_Count_RAN, sanc_f21_24_Count_RAN, sanc_f22_24_Count_RAN, sanc_f23_24_Count_RAN, sanc_f24_24_Count_RAN, sanc_f25_24_Count_RAN) = NULL, NULL, sum(if(sanc_f02_24_Count_RAN = NULL, 0, sanc_f02_24_Count_RAN), if(sanc_f05_24_Count_RAN = NULL, 0, sanc_f05_24_Count_RAN), if(sanc_f06_24_Count_RAN = NULL, 0, sanc_f06_24_Count_RAN), if(sanc_F07_24_Count_RAN = NULL, 0, sanc_F07_24_Count_RAN), if(sanc_F08_24_Count_RAN = NULL, 0, sanc_F08_24_Count_RAN), if(sanc_f11_24_Count_RAN = NULL, 0, sanc_f11_24_Count_RAN), if(sanc_f19_24_Count_RAN = NULL, 0, sanc_f19_24_Count_RAN), if(sanc_f20_24_Count_RAN = NULL, 0, sanc_f20_24_Count_RAN), if(sanc_f21_24_Count_RAN = NULL, 0, sanc_f21_24_Count_RAN), if(sanc_f22_24_Count_RAN = NULL, 0, sanc_f22_24_Count_RAN), if(sanc_f23_24_Count_RAN = NULL, 0, sanc_f23_24_Count_RAN), if(sanc_f24_24_Count_RAN = NULL, 0, sanc_f24_24_Count_RAN), if(sanc_f25_24_Count_RAN = NULL, 0, sanc_f25_24_Count_RAN)));
	
	sanc_red_24_count_ran_1 := if(max((INTEGER)sanc_f12_24_Count_RAN, (INTEGER)sanc_f16_24_Count_RAN, (INTEGER)sanc_os_24_Count_RAN) = NULL, NULL, sum(if((INTEGER)sanc_f12_24_Count_RAN = NULL, 0, (INTEGER)sanc_f12_24_Count_RAN), if((INTEGER)sanc_f16_24_Count_RAN = NULL, 0, (INTEGER)sanc_f16_24_Count_RAN), if((INTEGER)sanc_os_24_Count_RAN = NULL, 0, (INTEGER)sanc_os_24_Count_RAN)));
	
	sanc_yellow_24_count_ran_2 := if(max(sanc_f03_24_Count_RAN, sanc_f04_24_Count_RAN, sanc_f09_24_Count_RAN, sanc_f10_24_Count_RAN, sanc_f13_24_Count_RAN, sanc_f17_24_Count_RAN, sanc_f18_24_Count_RAN, sanc_f26_24_Count_RAN) = NULL, NULL, sum(if(sanc_f03_24_Count_RAN = NULL, 0, sanc_f03_24_Count_RAN), if(sanc_f04_24_Count_RAN = NULL, 0, sanc_f04_24_Count_RAN), if(sanc_f09_24_Count_RAN = NULL, 0, sanc_f09_24_Count_RAN), if(sanc_f10_24_Count_RAN = NULL, 0, sanc_f10_24_Count_RAN), if(sanc_f13_24_Count_RAN = NULL, 0, sanc_f13_24_Count_RAN), if(sanc_f17_24_Count_RAN = NULL, 0, sanc_f17_24_Count_RAN), if(sanc_f18_24_Count_RAN = NULL, 0, sanc_f18_24_Count_RAN), if(sanc_f26_24_Count_RAN = NULL, 0, sanc_f26_24_Count_RAN)));
	
	sanc_accusation_24_count_ran := sanc_f01_24_Count_RAN;
	
	mult_accusation_adj_24_ran := truncate(sanc_accusation_24_count_ran / 5);
	
	sanc_yellow_24_count_ran_1 := if(mult_accusation_adj_24_ran > 0, sanc_yellow_24_count_ran_2 + mult_accusation_adj_24_ran, sanc_yellow_24_count_ran_2);
	
	sanc_black_60_count_ran_1 := if(max(sanc_f02_60_Count_RAN, sanc_f05_60_Count_RAN, sanc_f06_60_Count_RAN, sanc_F07_60_Count_RAN, sanc_F08_60_Count_RAN, sanc_f11_60_Count_RAN, sanc_f19_60_Count_RAN, sanc_f20_60_Count_RAN, sanc_f21_60_Count_RAN, sanc_f22_60_Count_RAN, sanc_f23_60_Count_RAN, sanc_f24_60_Count_RAN, sanc_f25_60_Count_RAN) = NULL, NULL, sum(if(sanc_f02_60_Count_RAN = NULL, 0, sanc_f02_60_Count_RAN), if(sanc_f05_60_Count_RAN = NULL, 0, sanc_f05_60_Count_RAN), if(sanc_f06_60_Count_RAN = NULL, 0, sanc_f06_60_Count_RAN), if(sanc_F07_60_Count_RAN = NULL, 0, sanc_F07_60_Count_RAN), if(sanc_F08_60_Count_RAN = NULL, 0, sanc_F08_60_Count_RAN), if(sanc_f11_60_Count_RAN = NULL, 0, sanc_f11_60_Count_RAN), if(sanc_f19_60_Count_RAN = NULL, 0, sanc_f19_60_Count_RAN), if(sanc_f20_60_Count_RAN = NULL, 0, sanc_f20_60_Count_RAN), if(sanc_f21_60_Count_RAN = NULL, 0, sanc_f21_60_Count_RAN), if(sanc_f22_60_Count_RAN = NULL, 0, sanc_f22_60_Count_RAN), if(sanc_f23_60_Count_RAN = NULL, 0, sanc_f23_60_Count_RAN), if(sanc_f24_60_Count_RAN = NULL, 0, sanc_f24_60_Count_RAN), if(sanc_f25_60_Count_RAN = NULL, 0, sanc_f25_60_Count_RAN)));
	
	sanc_red_60_count_ran_1 := if(max((INTEGER)sanc_f12_60_Count_RAN, (INTEGER)sanc_f16_60_Count_RAN, (INTEGER)sanc_os_60_Count_RAN) = NULL, NULL, sum(if((INTEGER)sanc_f12_60_Count_RAN = NULL, 0, (INTEGER)sanc_f12_60_Count_RAN), if((INTEGER)sanc_f16_60_Count_RAN = NULL, 0, (INTEGER)sanc_f16_60_Count_RAN), if((INTEGER)sanc_os_60_Count_RAN = NULL, 0, (INTEGER)sanc_os_60_Count_RAN)));
	
	sanc_yellow_60_count_ran_2 := if(max(sanc_f03_60_Count_RAN, sanc_f04_60_Count_RAN, sanc_f09_60_Count_RAN, sanc_f10_60_Count_RAN, sanc_f13_60_Count_RAN, sanc_f17_60_Count_RAN, sanc_f18_60_Count_RAN, sanc_f26_60_Count_RAN) = NULL, NULL, sum(if(sanc_f03_60_Count_RAN = NULL, 0, sanc_f03_60_Count_RAN), if(sanc_f04_60_Count_RAN = NULL, 0, sanc_f04_60_Count_RAN), if(sanc_f09_60_Count_RAN = NULL, 0, sanc_f09_60_Count_RAN), if(sanc_f10_60_Count_RAN = NULL, 0, sanc_f10_60_Count_RAN), if(sanc_f13_60_Count_RAN = NULL, 0, sanc_f13_60_Count_RAN), if(sanc_f17_60_Count_RAN = NULL, 0, sanc_f17_60_Count_RAN), if(sanc_f18_60_Count_RAN = NULL, 0, sanc_f18_60_Count_RAN), if(sanc_f26_60_Count_RAN = NULL, 0, sanc_f26_60_Count_RAN)));
	
	sanc_accusation_60_count_ran := sanc_f01_60_Count_RAN;
	
	mult_accusation_adj_60_ran := truncate(sanc_accusation_60_count_ran / 5);
	
	sanc_yellow_60_count_ran_1 := if(mult_accusation_adj_60_ran > 0, sanc_yellow_60_count_ran_2 + mult_accusation_adj_60_ran, sanc_yellow_60_count_ran_2);
	
	sanc_black_61_count_ran_1 := if(max(sanc_f02_61_Count_RAN, sanc_f05_61_Count_RAN, sanc_f06_61_Count_RAN, sanc_F07_61_Count_RAN, sanc_F08_61_Count_RAN, sanc_f11_61_Count_RAN, sanc_f19_61_Count_RAN, sanc_f20_61_Count_RAN, sanc_f21_61_Count_RAN, sanc_f22_61_Count_RAN, sanc_f23_61_Count_RAN, sanc_f24_61_Count_RAN, sanc_f25_61_Count_RAN) = NULL, NULL, sum(if(sanc_f02_61_Count_RAN = NULL, 0, sanc_f02_61_Count_RAN), if(sanc_f05_61_Count_RAN = NULL, 0, sanc_f05_61_Count_RAN), if(sanc_f06_61_Count_RAN = NULL, 0, sanc_f06_61_Count_RAN), if(sanc_F07_61_Count_RAN = NULL, 0, sanc_F07_61_Count_RAN), if(sanc_F08_61_Count_RAN = NULL, 0, sanc_F08_61_Count_RAN), if(sanc_f11_61_Count_RAN = NULL, 0, sanc_f11_61_Count_RAN), if(sanc_f19_61_Count_RAN = NULL, 0, sanc_f19_61_Count_RAN), if(sanc_f20_61_Count_RAN = NULL, 0, sanc_f20_61_Count_RAN), if(sanc_f21_61_Count_RAN = NULL, 0, sanc_f21_61_Count_RAN), if(sanc_f22_61_Count_RAN = NULL, 0, sanc_f22_61_Count_RAN), if(sanc_f23_61_Count_RAN = NULL, 0, sanc_f23_61_Count_RAN), if(sanc_f24_61_Count_RAN = NULL, 0, sanc_f24_61_Count_RAN), if(sanc_f25_61_Count_RAN = NULL, 0, sanc_f25_61_Count_RAN)));
	
	sanc_red_61_count_ran_1 := if(max((INTEGER)sanc_f12_61_Count_RAN, (INTEGER)sanc_f16_61_Count_RAN, (INTEGER)sanc_os_61_Count_RAN) = NULL, NULL, sum(if((INTEGER)sanc_f12_61_Count_RAN = NULL, 0, (INTEGER)sanc_f12_61_Count_RAN), if((INTEGER)sanc_f16_61_Count_RAN = NULL, 0, (INTEGER)sanc_f16_61_Count_RAN), if((INTEGER)sanc_os_61_Count_RAN = NULL, 0, (INTEGER)sanc_os_61_Count_RAN)));
	
	sanc_yellow_61_count_ran_2 := if(max(sanc_f03_61_Count_RAN, sanc_f04_61_Count_RAN, sanc_f09_61_Count_RAN, sanc_f10_61_Count_RAN, sanc_f13_61_Count_RAN, sanc_f17_61_Count_RAN, sanc_f18_61_Count_RAN, sanc_f26_61_Count_RAN) = NULL, NULL, sum(if(sanc_f03_61_Count_RAN = NULL, 0, sanc_f03_61_Count_RAN), if(sanc_f04_61_Count_RAN = NULL, 0, sanc_f04_61_Count_RAN), if(sanc_f09_61_Count_RAN = NULL, 0, sanc_f09_61_Count_RAN), if(sanc_f10_61_Count_RAN = NULL, 0, sanc_f10_61_Count_RAN), if(sanc_f13_61_Count_RAN = NULL, 0, sanc_f13_61_Count_RAN), if(sanc_f17_61_Count_RAN = NULL, 0, sanc_f17_61_Count_RAN), if(sanc_f18_61_Count_RAN = NULL, 0, sanc_f18_61_Count_RAN), if(sanc_f26_61_Count_RAN = NULL, 0, sanc_f26_61_Count_RAN)));
	
	sanc_accusation_61_count_ran := sanc_f01_61_Count_RAN;
	
	mult_accusation_adj_61_ran := truncate(sanc_accusation_61_count_ran / 5);
	
	sanc_yellow_61_count_ran_1 := if(mult_accusation_adj_61_ran > 0, sanc_yellow_61_count_ran_2 + mult_accusation_adj_61_ran, sanc_yellow_61_count_ran_2);
	
	sanc_black_current_count_ran := if(sanc_black_current_count_ran_1 = NULL, 0, sanc_black_current_count_ran_1);
	
	sanc_red_current_count_ran := if(sanc_red_current_count_ran_1 = NULL, 0, sanc_red_current_count_ran_1);
	
	sanc_yellow_current_count_ran := if(sanc_yellow_current_count_ran_1 = NULL, 0, sanc_yellow_current_count_ran_1);
	
	sanc_black_24_count_ran := if(sanc_black_24_count_ran_1 = NULL, 0, sanc_black_24_count_ran_1);
	
	sanc_red_24_count_ran := if(sanc_red_24_count_ran_1 = NULL, 0, sanc_red_24_count_ran_1);
	
	sanc_yellow_24_count_ran := if(sanc_yellow_24_count_ran_1 = NULL, 0, sanc_yellow_24_count_ran_1);
	
	sanc_black_60_count_ran := if(sanc_black_60_count_ran_1 = NULL, 0, sanc_black_60_count_ran_1);
	
	sanc_red_60_count_ran := if(sanc_red_60_count_ran_1 = NULL, 0, sanc_red_60_count_ran_1);
	
	sanc_yellow_60_count_ran := if(sanc_yellow_60_count_ran_1 = NULL, 0, sanc_yellow_60_count_ran_1);
	
	sanc_black_61_count_ran := if(sanc_black_61_count_ran_1 = NULL, 0, sanc_black_61_count_ran_1);
	
	sanc_red_61_count_ran := if(sanc_red_61_count_ran_1 = NULL, 0, sanc_red_61_count_ran_1);
	
	sanc_yellow_61_count_ran := if(sanc_yellow_61_count_ran_1 = NULL, 0, sanc_yellow_61_count_ran_1);
	
	sanc_black_count_ran := sanc_black_current_count_ran * 1.00 +
	    sanc_black_24_count_ran * 1.00 +
	    sanc_black_60_count_ran * 0.67 +
	    sanc_black_61_count_ran * 0.50;
	
	sanc_red_count_ran := sanc_red_current_count_ran * 1.00 +
	    sanc_red_24_count_ran * 1.00 +
	    sanc_red_60_count_ran * 0.67 +
	    sanc_red_61_count_ran * 0.50;
	
	sanc_yellow_count_ran := sanc_yellow_current_count_ran * 1.00 +
	    sanc_yellow_24_count_ran * 1.00 +
	    sanc_yellow_60_count_ran * 0.67 +
	    sanc_yellow_61_count_ran * 0.50;
	
	sanction_points_ran_1 := -50 * sanc_black_count_ran +
	    -37 * sanc_red_count_ran +
	    -25 * sanc_yellow_count_ran;
	
	sanction_points_ran := if(sanction_points_ran_1 < -150, -150, sanction_points_ran_1);
	
	sanc_black_current_count_caff_1 := if(max(sanc_f02_Current_Count_CAff, sanc_f05_Current_Count_CAff, sanc_f06_Current_Count_CAff, sanc_F07_Current_Count_CAff, sanc_F08_Current_Count_CAff, sanc_f11_Current_Count_CAff, sanc_f19_Current_Count_CAff, sanc_f20_Current_Count_CAff, sanc_f21_Current_Count_CAff, sanc_f22_Current_Count_CAff, sanc_f23_Current_Count_CAff, sanc_f24_Current_Count_CAff, sanc_f25_Current_Count_CAff) = NULL, NULL, sum(if(sanc_f02_Current_Count_CAff = NULL, 0, sanc_f02_Current_Count_CAff), if(sanc_f05_Current_Count_CAff = NULL, 0, sanc_f05_Current_Count_CAff), if(sanc_f06_Current_Count_CAff = NULL, 0, sanc_f06_Current_Count_CAff), if(sanc_F07_Current_Count_CAff = NULL, 0, sanc_F07_Current_Count_CAff), if(sanc_F08_Current_Count_CAff = NULL, 0, sanc_F08_Current_Count_CAff), if(sanc_f11_Current_Count_CAff = NULL, 0, sanc_f11_Current_Count_CAff), if(sanc_f19_Current_Count_CAff = NULL, 0, sanc_f19_Current_Count_CAff), if(sanc_f20_Current_Count_CAff = NULL, 0, sanc_f20_Current_Count_CAff), if(sanc_f21_Current_Count_CAff = NULL, 0, sanc_f21_Current_Count_CAff), if(sanc_f22_Current_Count_CAff = NULL, 0, sanc_f22_Current_Count_CAff), if(sanc_f23_Current_Count_CAff = NULL, 0, sanc_f23_Current_Count_CAff), if(sanc_f24_Current_Count_CAff = NULL, 0, sanc_f24_Current_Count_CAff), if(sanc_f25_Current_Count_CAff = NULL, 0, sanc_f25_Current_Count_CAff)));
	
	sanc_red_current_count_caff_1 := if(max((INTEGER)sanc_f12_Current_Count_CAff, (INTEGER)sanc_f16_Current_Count_CAff, (INTEGER)sanc_os_Current_Count_CAff) = NULL, NULL, sum(if((INTEGER)sanc_f12_Current_Count_CAff = NULL, 0, (INTEGER)sanc_f12_Current_Count_CAff), if((INTEGER)sanc_f16_Current_Count_CAff = NULL, 0, (INTEGER)sanc_f16_Current_Count_CAff), if((INTEGER)sanc_os_Current_Count_CAff = NULL, 0, (INTEGER)sanc_os_Current_Count_CAff)));
	
	sanc_yellow_current_count_caff_2 := if(max(sanc_f03_Current_Count_CAff, sanc_f04_Current_Count_CAff, sanc_f09_Current_Count_CAff, sanc_f10_Current_Count_CAff, sanc_f13_Current_Count_CAff, sanc_f17_Current_Count_CAff, sanc_f18_Current_Count_CAff, sanc_f26_Current_Count_CAff) = NULL, NULL, sum(if(sanc_f03_Current_Count_CAff = NULL, 0, sanc_f03_Current_Count_CAff), if(sanc_f04_Current_Count_CAff = NULL, 0, sanc_f04_Current_Count_CAff), if(sanc_f09_Current_Count_CAff = NULL, 0, sanc_f09_Current_Count_CAff), if(sanc_f10_Current_Count_CAff = NULL, 0, sanc_f10_Current_Count_CAff), if(sanc_f13_Current_Count_CAff = NULL, 0, sanc_f13_Current_Count_CAff), if(sanc_f17_Current_Count_CAff = NULL, 0, sanc_f17_Current_Count_CAff), if(sanc_f18_Current_Count_CAff = NULL, 0, sanc_f18_Current_Count_CAff), if(sanc_f26_Current_Count_CAff = NULL, 0, sanc_f26_Current_Count_CAff)));
	
	sanc_acc_curr_cnt_caff := sanc_f01_Current_Count_CAff;
	
	mult_accusation_adj_current_caff := truncate(sanc_acc_curr_cnt_caff / 5);
	
	sanc_yellow_current_count_caff_1 := if(mult_accusation_adj_current_caff > 0, sanc_yellow_current_count_caff_2 + mult_accusation_adj_current_caff, sanc_yellow_current_count_caff_2);
	
	sanc_black_24_count_caff_1 := if(max(sanc_f02_24_Count_CAff, sanc_f05_24_Count_CAff, sanc_f06_24_Count_CAff, sanc_F07_24_Count_CAff, sanc_F08_24_Count_CAff, sanc_f11_24_Count_CAff, sanc_f19_24_Count_CAff, sanc_f20_24_Count_CAff, sanc_f21_24_Count_CAff, sanc_f22_24_Count_CAff, sanc_f23_24_Count_CAff, sanc_f24_24_Count_CAff, sanc_f25_24_Count_CAff) = NULL, NULL, sum(if(sanc_f02_24_Count_CAff = NULL, 0, sanc_f02_24_Count_CAff), if(sanc_f05_24_Count_CAff = NULL, 0, sanc_f05_24_Count_CAff), if(sanc_f06_24_Count_CAff = NULL, 0, sanc_f06_24_Count_CAff), if(sanc_F07_24_Count_CAff = NULL, 0, sanc_F07_24_Count_CAff), if(sanc_F08_24_Count_CAff = NULL, 0, sanc_F08_24_Count_CAff), if(sanc_f11_24_Count_CAff = NULL, 0, sanc_f11_24_Count_CAff), if(sanc_f19_24_Count_CAff = NULL, 0, sanc_f19_24_Count_CAff), if(sanc_f20_24_Count_CAff = NULL, 0, sanc_f20_24_Count_CAff), if(sanc_f21_24_Count_CAff = NULL, 0, sanc_f21_24_Count_CAff), if(sanc_f22_24_Count_CAff = NULL, 0, sanc_f22_24_Count_CAff), if(sanc_f23_24_Count_CAff = NULL, 0, sanc_f23_24_Count_CAff), if(sanc_f24_24_Count_CAff = NULL, 0, sanc_f24_24_Count_CAff), if(sanc_f25_24_Count_CAff = NULL, 0, sanc_f25_24_Count_CAff)));
	
	sanc_red_24_count_caff_1 := if(max((INTEGER)sanc_f12_24_Count_CAff, (INTEGER)sanc_f16_24_Count_CAff, (INTEGER)sanc_os_24_Count_CAff) = NULL, NULL, sum(if((INTEGER)sanc_f12_24_Count_CAff = NULL, 0, (INTEGER)sanc_f12_24_Count_CAff), if((INTEGER)sanc_f16_24_Count_CAff = NULL, 0, (INTEGER)sanc_f16_24_Count_CAff), if((INTEGER)sanc_os_24_Count_CAff = NULL, 0, (INTEGER)sanc_os_24_Count_CAff)));
	
	sanc_yellow_24_count_caff_2 := if(max(sanc_f03_24_Count_CAff, sanc_f04_24_Count_CAff, sanc_f09_24_Count_CAff, sanc_f10_24_Count_CAff, sanc_f13_24_Count_CAff, sanc_f17_24_Count_CAff, sanc_f18_24_Count_CAff, sanc_f26_24_Count_CAff) = NULL, NULL, sum(if(sanc_f03_24_Count_CAff = NULL, 0, sanc_f03_24_Count_CAff), if(sanc_f04_24_Count_CAff = NULL, 0, sanc_f04_24_Count_CAff), if(sanc_f09_24_Count_CAff = NULL, 0, sanc_f09_24_Count_CAff), if(sanc_f10_24_Count_CAff = NULL, 0, sanc_f10_24_Count_CAff), if(sanc_f13_24_Count_CAff = NULL, 0, sanc_f13_24_Count_CAff), if(sanc_f17_24_Count_CAff = NULL, 0, sanc_f17_24_Count_CAff), if(sanc_f18_24_Count_CAff = NULL, 0, sanc_f18_24_Count_CAff), if(sanc_f26_24_Count_CAff = NULL, 0, sanc_f26_24_Count_CAff)));
	
	sanc_accusation_24_count_caff := sanc_f01_24_Count_CAff;
	
	mult_accusation_adj_24_caff := truncate(sanc_accusation_24_count_caff / 5);
	
	sanc_yellow_24_count_caff_1 := if(mult_accusation_adj_24_caff > 0, sanc_yellow_24_count_caff_2 + mult_accusation_adj_24_caff, sanc_yellow_24_count_caff_2);
	
	sanc_black_60_count_caff_1 := if(max(sanc_f02_60_Count_CAff, sanc_f05_60_Count_CAff, sanc_f06_60_Count_CAff, sanc_F07_60_Count_CAff, sanc_F08_60_Count_CAff, sanc_f11_60_Count_CAff, sanc_f19_60_Count_CAff, sanc_f20_60_Count_CAff, sanc_f21_60_Count_CAff, sanc_f22_60_Count_CAff, sanc_f23_60_Count_CAff, sanc_f24_60_Count_CAff, sanc_f25_60_Count_CAff) = NULL, NULL, sum(if(sanc_f02_60_Count_CAff = NULL, 0, sanc_f02_60_Count_CAff), if(sanc_f05_60_Count_CAff = NULL, 0, sanc_f05_60_Count_CAff), if(sanc_f06_60_Count_CAff = NULL, 0, sanc_f06_60_Count_CAff), if(sanc_F07_60_Count_CAff = NULL, 0, sanc_F07_60_Count_CAff), if(sanc_F08_60_Count_CAff = NULL, 0, sanc_F08_60_Count_CAff), if(sanc_f11_60_Count_CAff = NULL, 0, sanc_f11_60_Count_CAff), if(sanc_f19_60_Count_CAff = NULL, 0, sanc_f19_60_Count_CAff), if(sanc_f20_60_Count_CAff = NULL, 0, sanc_f20_60_Count_CAff), if(sanc_f21_60_Count_CAff = NULL, 0, sanc_f21_60_Count_CAff), if(sanc_f22_60_Count_CAff = NULL, 0, sanc_f22_60_Count_CAff), if(sanc_f23_60_Count_CAff = NULL, 0, sanc_f23_60_Count_CAff), if(sanc_f24_60_Count_CAff = NULL, 0, sanc_f24_60_Count_CAff), if(sanc_f25_60_Count_CAff = NULL, 0, sanc_f25_60_Count_CAff)));
	
	sanc_red_60_count_caff_1 := if(max((INTEGER)sanc_f12_60_Count_CAff, (INTEGER)sanc_f16_60_Count_CAff, (INTEGER)sanc_os_60_Count_CAff) = NULL, NULL, sum(if((INTEGER)sanc_f12_60_Count_CAff = NULL, 0, (INTEGER)sanc_f12_60_Count_CAff), if((INTEGER)sanc_f16_60_Count_CAff = NULL, 0, (INTEGER)sanc_f16_60_Count_CAff), if((INTEGER)sanc_os_60_Count_CAff = NULL, 0, (INTEGER)sanc_os_60_Count_CAff)));
	
	sanc_yellow_60_count_caff_2 := if(max(sanc_f03_60_Count_CAff, sanc_f04_60_Count_CAff, sanc_f09_60_Count_CAff, sanc_f10_60_Count_CAff, sanc_f13_60_Count_CAff, sanc_f17_60_Count_CAff, sanc_f18_60_Count_CAff, sanc_f26_60_Count_CAff) = NULL, NULL, sum(if(sanc_f03_60_Count_CAff = NULL, 0, sanc_f03_60_Count_CAff), if(sanc_f04_60_Count_CAff = NULL, 0, sanc_f04_60_Count_CAff), if(sanc_f09_60_Count_CAff = NULL, 0, sanc_f09_60_Count_CAff), if(sanc_f10_60_Count_CAff = NULL, 0, sanc_f10_60_Count_CAff), if(sanc_f13_60_Count_CAff = NULL, 0, sanc_f13_60_Count_CAff), if(sanc_f17_60_Count_CAff = NULL, 0, sanc_f17_60_Count_CAff), if(sanc_f18_60_Count_CAff = NULL, 0, sanc_f18_60_Count_CAff), if(sanc_f26_60_Count_CAff = NULL, 0, sanc_f26_60_Count_CAff)));
	
	sanc_accusation_60_count_caff := sanc_f01_60_Count_CAff;
	
	mult_accusation_adj_60_caff := truncate(sanc_accusation_60_count_caff / 5);
	
	sanc_yellow_60_count_caff_1 := if(mult_accusation_adj_60_caff > 0, sanc_yellow_60_count_caff_2 + mult_accusation_adj_60_caff, sanc_yellow_60_count_caff_2);
	
	sanc_black_61_count_caff_1 := if(max(sanc_f02_61_Count_CAff, sanc_f05_61_Count_CAff, sanc_f06_61_Count_CAff, sanc_F07_61_Count_CAff, sanc_F08_61_Count_CAff, sanc_f11_61_Count_CAff, sanc_f19_61_Count_CAff, sanc_f20_61_Count_CAff, sanc_f21_61_Count_CAff, sanc_f22_61_Count_CAff, sanc_f23_61_Count_CAff, sanc_f24_61_Count_CAff, sanc_f25_61_Count_CAff) = NULL, NULL, sum(if(sanc_f02_61_Count_CAff = NULL, 0, sanc_f02_61_Count_CAff), if(sanc_f05_61_Count_CAff = NULL, 0, sanc_f05_61_Count_CAff), if(sanc_f06_61_Count_CAff = NULL, 0, sanc_f06_61_Count_CAff), if(sanc_F07_61_Count_CAff = NULL, 0, sanc_F07_61_Count_CAff), if(sanc_F08_61_Count_CAff = NULL, 0, sanc_F08_61_Count_CAff), if(sanc_f11_61_Count_CAff = NULL, 0, sanc_f11_61_Count_CAff), if(sanc_f19_61_Count_CAff = NULL, 0, sanc_f19_61_Count_CAff), if(sanc_f20_61_Count_CAff = NULL, 0, sanc_f20_61_Count_CAff), if(sanc_f21_61_Count_CAff = NULL, 0, sanc_f21_61_Count_CAff), if(sanc_f22_61_Count_CAff = NULL, 0, sanc_f22_61_Count_CAff), if(sanc_f23_61_Count_CAff = NULL, 0, sanc_f23_61_Count_CAff), if(sanc_f24_61_Count_CAff = NULL, 0, sanc_f24_61_Count_CAff), if(sanc_f25_61_Count_CAff = NULL, 0, sanc_f25_61_Count_CAff)));
	
	sanc_red_61_count_caff_1 := if(max((INTEGER)sanc_f12_61_Count_CAff, (INTEGER)sanc_f16_61_Count_CAff, (INTEGER)sanc_os_61_Count_CAff) = NULL, NULL, sum(if((INTEGER)sanc_f12_61_Count_CAff = NULL, 0, (INTEGER)sanc_f12_61_Count_CAff), if((INTEGER)sanc_f16_61_Count_CAff = NULL, 0, (INTEGER)sanc_f16_61_Count_CAff), if((INTEGER)sanc_os_61_Count_CAff = NULL, 0, (INTEGER)sanc_os_61_Count_CAff)));
	
	sanc_yellow_61_count_caff_2 := if(max(sanc_f03_61_Count_CAff, sanc_f04_61_Count_CAff, sanc_f09_61_Count_CAff, sanc_f10_61_Count_CAff, sanc_f13_61_Count_CAff, sanc_f17_61_Count_CAff, sanc_f18_61_Count_CAff, sanc_f26_61_Count_CAff) = NULL, NULL, sum(if(sanc_f03_61_Count_CAff = NULL, 0, sanc_f03_61_Count_CAff), if(sanc_f04_61_Count_CAff = NULL, 0, sanc_f04_61_Count_CAff), if(sanc_f09_61_Count_CAff = NULL, 0, sanc_f09_61_Count_CAff), if(sanc_f10_61_Count_CAff = NULL, 0, sanc_f10_61_Count_CAff), if(sanc_f13_61_Count_CAff = NULL, 0, sanc_f13_61_Count_CAff), if(sanc_f17_61_Count_CAff = NULL, 0, sanc_f17_61_Count_CAff), if(sanc_f18_61_Count_CAff = NULL, 0, sanc_f18_61_Count_CAff), if(sanc_f26_61_Count_CAff = NULL, 0, sanc_f26_61_Count_CAff)));
	
	sanc_accusation_61_count_caff := sanc_f01_61_Count_CAff;
	
	mult_accusation_adj_61_caff := truncate(sanc_accusation_61_count_caff / 5);
	
	sanc_yellow_61_count_caff_1 := if(mult_accusation_adj_61_caff > 0, sanc_yellow_61_count_caff_2 + mult_accusation_adj_61_caff, sanc_yellow_61_count_caff_2);
	
	sanc_black_current_count_caff := if(sanc_black_current_count_caff_1 = NULL, 0, sanc_black_current_count_caff_1);
	
	sanc_red_current_count_caff := if(sanc_red_current_count_caff_1 = NULL, 0, sanc_red_current_count_caff_1);
	
	sanc_yellow_current_count_caff := if(sanc_yellow_current_count_caff_1 = NULL, 0, sanc_yellow_current_count_caff_1);
	
	sanc_black_24_count_caff := if(sanc_black_24_count_caff_1 = NULL, 0, sanc_black_24_count_caff_1);
	
	sanc_red_24_count_caff := if(sanc_red_24_count_caff_1 = NULL, 0, sanc_red_24_count_caff_1);
	
	sanc_yellow_24_count_caff := if(sanc_yellow_24_count_caff_1 = NULL, 0, sanc_yellow_24_count_caff_1);
	
	sanc_black_60_count_caff := if(sanc_black_60_count_caff_1 = NULL, 0, sanc_black_60_count_caff_1);
	
	sanc_red_60_count_caff := if(sanc_red_60_count_caff_1 = NULL, 0, sanc_red_60_count_caff_1);
	
	sanc_yellow_60_count_caff := if(sanc_yellow_60_count_caff_1 = NULL, 0, sanc_yellow_60_count_caff_1);
	
	sanc_black_61_count_caff := if(sanc_black_61_count_caff_1 = NULL, 0, sanc_black_61_count_caff_1);
	
	sanc_red_61_count_caff := if(sanc_red_61_count_caff_1 = NULL, 0, sanc_red_61_count_caff_1);
	
	sanc_yellow_61_count_caff := if(sanc_yellow_61_count_caff_1 = NULL, 0, sanc_yellow_61_count_caff_1);
	
	sanc_black_count_caff := sanc_black_current_count_caff * 1.00 +
	    sanc_black_24_count_caff * 1.00 +
	    sanc_black_60_count_caff * 0.67 +
	    sanc_black_61_count_caff * 0.50;
	
	sanc_red_count_caff := sanc_red_current_count_caff * 1.00 +
	    sanc_red_24_count_caff * 1.00 +
	    sanc_red_60_count_caff * 0.67 +
	    sanc_red_61_count_caff * 0.50;
	
	sanc_yellow_count_caff := sanc_yellow_current_count_caff * 1.00 +
	    sanc_yellow_24_count_caff * 1.00 +
	    sanc_yellow_60_count_caff * 0.67 +
	    sanc_yellow_61_count_caff * 0.50;
	
	sanction_points_caff_1 := -150 * sanc_black_count_caff +
	    -100 * sanc_red_count_caff +
	    -75 * sanc_yellow_count_caff;
	
	sanction_points_caff := if(sanction_points_caff_1 < -300, -300, sanction_points_caff_1);
	
	gsa_provider_count := 1.3 * gsa_prov_recip_24_curr_cnt +
	    0.871 * gsa_prov_recip_60_curr_cnt +
	    0.65 * gsa_prov_recip_61_curr_cnt +
	    1.0 * gsa_prov_proc_24_curr_cnt +
	    0.67 * gsa_prov_proc_60_curr_cnt +
	    0.5 * gsa_prov_proc_61_curr_cnt +
	    0.7 * gsa_prov_nonproc_24_curr_cnt +
	    0.469 * gsa_prov_nonproc_60_curr_cnt +
	    0.35 * gsa_prov_nonproc_61_curr_cnt +
	    0.65 * gsa_prov_recip_24_old_cnt +
	    0.4355 * gsa_prov_recip_60_old_cnt +
	    0.325 * gsa_prov_recip_61_old_cnt +
	    0.5 * gsa_prov_proc_24_old_cnt +
	    0.335 * gsa_prov_proc_60_old_cnt +
	    0.25 * gsa_prov_proc_61_old_cnt +
	    0.35 * gsa_prov_nonproc_24_old_cnt +
	    0.2345 * gsa_prov_nonproc_60_old_cnt +
	    0.175 * gsa_prov_nonproc_61_old_cnt;
	
	gsa_business_count := 1.3 * gsa_bus_recip_24_curr_cnt +
	    0.871 * gsa_bus_recip_60_curr_cnt +
	    0.65 * gsa_bus_recip_61_curr_cnt +
	    1.0 * gsa_bus_proc_24_curr_cnt +
	    0.67 * gsa_bus_proc_60_curr_cnt +
	    0.5 * gsa_bus_proc_61_curr_cnt +
	    0.7 * gsa_bus_nonproc_24_curr_cnt +
	    0.469 * gsa_bus_nonproc_60_curr_cnt +
	    0.35 * gsa_bus_nonproc_61_curr_cnt +
	    0.65 * gsa_bus_recip_24_old_cnt +
	    0.4355 * gsa_bus_recip_60_old_cnt +
	    0.325 * gsa_bus_recip_61_old_cnt +
	    0.5 * gsa_bus_proc_24_old_cnt +
	    0.335 * gsa_bus_proc_60_old_cnt +
	    0.25 * gsa_bus_proc_61_old_cnt +
	    0.35 * gsa_bus_nonproc_24_old_cnt +
	    0.2345 * gsa_bus_nonproc_60_old_cnt +
	    0.175 * gsa_bus_nonproc_61_old_cnt;
	
	gsa_ran_provider_count := 1.3 * gsa_prov_recip_24_curr_cnt_ran +
	    0.871 * gsa_prov_recip_60_curr_cnt_ran +
	    0.65 * gsa_prov_recip_61_curr_cnt_ran +
	    1.0 * gsa_prov_proc_24_curr_cnt_ran +
	    0.67 * gsa_prov_proc_60_curr_cnt_ran +
	    0.5 * gsa_prov_proc_61_curr_cnt_ran +
	    0.7 * gsa_prov_nonproc_24_curr_cnt_ran +
	    0.469 * gsa_prov_nonproc_60_curr_cnt_ran +
	    0.35 * gsa_prov_nonproc_61_curr_cnt_ran +
	    0.65 * gsa_prov_recip_24_old_cnt_ran +
	    0.4355 * gsa_prov_recip_60_old_cnt_ran +
	    0.325 * gsa_prov_recip_61_old_cnt_ran +
	    0.5 * gsa_prov_proc_24_old_cnt_ran +
	    0.335 * gsa_prov_proc_60_old_cnt_ran +
	    0.25 * gsa_prov_proc_61_old_cnt_ran +
	    0.35 * gsa_prov_nonproc_24_old_cnt_ran +
	    0.2345 * gsa_prov_nonproc_60_old_cnt_ran +
	    0.175 * gsa_prov_nonproc_61_old_cnt_ran;
	
	gsa_count_2 := if(max(gsa_provider_count, gsa_business_count) = NULL, NULL, sum(if(gsa_provider_count = NULL, 0, gsa_provider_count), if(gsa_business_count = NULL, 0, gsa_business_count)));
	
	gsa_count_1 := if(gsa_count_2 = NULL, 0, gsa_count_2);
	
	gsa_count := if(gsa_count_1 >= 10, 10, gsa_count_1);
	
	gsa_ran_count_2 := gsa_ran_provider_count;
	
	gsa_ran_count_1 := if(gsa_ran_count_2 = NULL, 0, gsa_ran_count_2);
	
	gsa_ran_count := if(gsa_ran_count_1 >= 10, 10, gsa_ran_count_1);
	
	gsa_corporate_affiliation_count := 1.3 * gsa_caff_recip_24_curr_cnt +
	    0.871 * gsa_caff_recip_60_curr_cnt +
	    0.65 * gsa_caff_recip_61_curr_cnt +
	    1.0 * gsa_caff_proc_24_curr_cnt +
	    0.67 * gsa_caff_proc_60_curr_cnt +
	    0.5 * gsa_caff_proc_61_curr_cnt +
	    0.7 * gsa_caff_nonproc_24_curr_cnt +
	    0.469 * gsa_caff_nonproc_60_curr_cnt +
	    0.35 * gsa_caff_nonproc_61_curr_cnt +
	    0.65 * gsa_caff_recip_24_old_cnt +
	    0.4355 * gsa_caff_recip_60_old_cnt +
	    0.325 * gsa_caff_recip_61_old_cnt +
	    0.5 * gsa_caff_proc_24_old_cnt +
	    0.335 * gsa_caff_proc_60_old_cnt +
	    0.25 * gsa_caff_proc_61_old_cnt +
	    0.35 * gsa_caff_nonproc_24_old_cnt +
	    0.2345 * gsa_caff_nonproc_60_old_cnt +
	    0.175 * gsa_caff_nonproc_61_old_cnt;
	
	gsa_rancaff_count_2 := 1.3 * gsa_rancaff_recip_24_curr_cnt +
	    0.871 * gsa_rancaff_recip_60_curr_cnt +
	    0.65 * gsa_rancaff_recip_61_curr_cnt +
	    1.0 * gsa_rancaff_proc_24_curr_cnt +
	    0.67 * gsa_rancaff_proc_60_curr_cnt +
	    0.5 * gsa_rancaff_proc_61_curr_cnt +
	    0.7 * gsa_rancaff_nonproc_24_curr_cnt +
	    0.469 * gsa_rancaff_nonproc_60_curr_cnt +
	    0.35 * gsa_rancaff_nonproc_61_curr_cnt +
	    0.65 * gsa_rancaff_recip_24_old_cnt +
	    0.4355 * gsa_rancaff_recip_60_old_cnt +
	    0.325 * gsa_rancaff_recip_61_old_cnt +
	    0.5 * gsa_rancaff_proc_24_old_cnt +
	    0.335 * gsa_rancaff_proc_60_old_cnt +
	    0.25 * gsa_rancaff_proc_61_old_cnt +
	    0.35 * gsa_rancaff_nonproc_24_old_cnt +
	    0.2345 * gsa_rancaff_nonproc_60_old_cnt +
	    0.175 * gsa_rancaff_nonproc_61_old_cnt;
	
	gsa_rancaff_count_1 := if(gsa_rancaff_count_2 = NULL, 0.0, gsa_rancaff_count_2);
	
	gsa_rancaff_count := if(gsa_rancaff_count_1 >= 10.0, 10.0, gsa_rancaff_count_1);
	
	judgment_red_count_24_1 := if(max(JGMT_Foreclosure_Count_24, JGMT_Forcible_Entry_Count_24, JGMT_Lien_Other_Count_24, JGMT_Tax_Lien_Count_24) = NULL, NULL, sum(if(JGMT_Foreclosure_Count_24 = NULL, 0, JGMT_Foreclosure_Count_24), if(JGMT_Forcible_Entry_Count_24 = NULL, 0, JGMT_Forcible_Entry_Count_24), if(JGMT_Lien_Other_Count_24 = NULL, 0, JGMT_Lien_Other_Count_24), if(JGMT_Tax_Lien_Count_24 = NULL, 0, JGMT_Tax_Lien_Count_24)));
	
	judgment_yellow_count_24_1 := if(max(JGMT_Landlord_Tenant_Count_24) = NULL, NULL, sum(if(JGMT_Landlord_Tenant_Count_24 = NULL, 0, JGMT_Landlord_Tenant_Count_24)));
	
	judgment_green_count_24_1 := if(max(JGMT_Civil_Judgment_Count_24, JGMT_Child_Support_Count_24, JGMT_Small_Claims_Count_24, JGMT_Judgment_Other_Count_24, JGMT_Lawsuit_Pending_Count_24, JGMT_Other_Count_24) = NULL, NULL, sum(if(JGMT_Civil_Judgment_Count_24 = NULL, 0, JGMT_Civil_Judgment_Count_24), if(JGMT_Child_Support_Count_24 = NULL, 0, JGMT_Child_Support_Count_24), if(JGMT_Small_Claims_Count_24 = NULL, 0, JGMT_Small_Claims_Count_24), if(JGMT_Judgment_Other_Count_24 = NULL, 0, JGMT_Judgment_Other_Count_24), if(JGMT_Lawsuit_Pending_Count_24 = NULL, 0, JGMT_Lawsuit_Pending_Count_24), if(JGMT_Other_Count_24 = NULL, 0, JGMT_Other_Count_24)));
	
	judgment_red_count_24 := if(judgment_red_count_24_1 = NULL, 0, judgment_red_count_24_1);
	
	judgment_yellow_count_24 := if(judgment_yellow_count_24_1 = NULL, 0, judgment_yellow_count_24_1);
	
	judgment_green_count_24 := if(judgment_green_count_24_1 = NULL, 0, judgment_green_count_24_1);
	
	judgment_red_count_60_1 := if(max(JGMT_Foreclosure_Count_60, JGMT_Forcible_Entry_Count_60, JGMT_Lien_Other_Count_60, JGMT_Tax_Lien_Count_60) = NULL, NULL, sum(if(JGMT_Foreclosure_Count_60 = NULL, 0, JGMT_Foreclosure_Count_60), if(JGMT_Forcible_Entry_Count_60 = NULL, 0, JGMT_Forcible_Entry_Count_60), if(JGMT_Lien_Other_Count_60 = NULL, 0, JGMT_Lien_Other_Count_60), if(JGMT_Tax_Lien_Count_60 = NULL, 0, JGMT_Tax_Lien_Count_60)));
	
	judgment_yellow_count_60_1 := if(max(JGMT_Landlord_Tenant_Count_60) = NULL, NULL, sum(if(JGMT_Landlord_Tenant_Count_60 = NULL, 0, JGMT_Landlord_Tenant_Count_60)));
	
	judgment_green_count_60_1 := if(max(JGMT_Civil_Judgment_Count_60, JGMT_Child_Support_Count_60, JGMT_Small_Claims_Count_60, JGMT_Judgment_Other_Count_60, JGMT_Lawsuit_Pending_Count_60, JGMT_Other_Count_60) = NULL, NULL, sum(if(JGMT_Civil_Judgment_Count_60 = NULL, 0, JGMT_Civil_Judgment_Count_60), if(JGMT_Child_Support_Count_60 = NULL, 0, JGMT_Child_Support_Count_60), if(JGMT_Small_Claims_Count_60 = NULL, 0, JGMT_Small_Claims_Count_60), if(JGMT_Judgment_Other_Count_60 = NULL, 0, JGMT_Judgment_Other_Count_60), if(JGMT_Lawsuit_Pending_Count_60 = NULL, 0, JGMT_Lawsuit_Pending_Count_60), if(JGMT_Other_Count_60 = NULL, 0, JGMT_Other_Count_60)));
	
	judgment_red_count_60 := if(judgment_red_count_60_1 = NULL, 0, judgment_red_count_60_1);
	
	judgment_yellow_count_60 := if(judgment_yellow_count_60_1 = NULL, 0, judgment_yellow_count_60_1);
	
	judgment_green_count_60 := if(judgment_green_count_60_1 = NULL, 0, judgment_green_count_60_1);
	
	judgment_red_count_61_1 := if(max(JGMT_Foreclosure_Count_61, JGMT_Forcible_Entry_Count_61, JGMT_Lien_Other_Count_61, JGMT_Tax_Lien_Count_61) = NULL, NULL, sum(if(JGMT_Foreclosure_Count_61 = NULL, 0, JGMT_Foreclosure_Count_61), if(JGMT_Forcible_Entry_Count_61 = NULL, 0, JGMT_Forcible_Entry_Count_61), if(JGMT_Lien_Other_Count_61 = NULL, 0, JGMT_Lien_Other_Count_61), if(JGMT_Tax_Lien_Count_61 = NULL, 0, JGMT_Tax_Lien_Count_61)));
	
	judgment_yellow_count_61_1 := if(max(JGMT_Landlord_Tenant_Count_61) = NULL, NULL, sum(if(JGMT_Landlord_Tenant_Count_61 = NULL, 0, JGMT_Landlord_Tenant_Count_61)));
	
	judgment_green_count_61_1 := if(max(JGMT_Civil_Judgment_Count_61, JGMT_Child_Support_Count_61, JGMT_Small_Claims_Count_61, JGMT_Judgment_Other_Count_61, JGMT_Lawsuit_Pending_Count_61, JGMT_Other_Count_61) = NULL, NULL, sum(if(JGMT_Civil_Judgment_Count_61 = NULL, 0, JGMT_Civil_Judgment_Count_61), if(JGMT_Child_Support_Count_61 = NULL, 0, JGMT_Child_Support_Count_61), if(JGMT_Small_Claims_Count_61 = NULL, 0, JGMT_Small_Claims_Count_61), if(JGMT_Judgment_Other_Count_61 = NULL, 0, JGMT_Judgment_Other_Count_61), if(JGMT_Lawsuit_Pending_Count_61 = NULL, 0, JGMT_Lawsuit_Pending_Count_61), if(JGMT_Other_Count_61 = NULL, 0, JGMT_Other_Count_61)));
	
	judgment_red_count_61 := if(judgment_red_count_61_1 = NULL, 0, judgment_red_count_61_1);
	
	judgment_yellow_count_61 := if(judgment_yellow_count_61_1 = NULL, 0, judgment_yellow_count_61_1);
	
	judgment_green_count_61 := if(judgment_green_count_61_1 = NULL, 0, judgment_green_count_61_1);
	
	judgment_red_count_nd_1 := if(max(JGMT_Foreclosure_Count_ND, JGMT_Forcible_Entry_Count_ND, JGMT_Lien_Other_Count_ND, JGMT_Tax_Lien_Count_ND) = NULL, NULL, sum(if(JGMT_Foreclosure_Count_ND = NULL, 0, JGMT_Foreclosure_Count_ND), if(JGMT_Forcible_Entry_Count_ND = NULL, 0, JGMT_Forcible_Entry_Count_ND), if(JGMT_Lien_Other_Count_ND = NULL, 0, JGMT_Lien_Other_Count_ND), if(JGMT_Tax_Lien_Count_ND = NULL, 0, JGMT_Tax_Lien_Count_ND)));
	
	judgment_yellow_count_nd_1 := if(max(JGMT_Landlord_Tenant_Count_ND) = NULL, NULL, sum(if(JGMT_Landlord_Tenant_Count_ND = NULL, 0, JGMT_Landlord_Tenant_Count_ND)));
	
	judgment_green_count_nd_1 := if(max(JGMT_Civil_Judgment_Count_ND, JGMT_Child_Support_Count_ND, JGMT_Small_Claims_Count_ND, JGMT_Judgment_Other_Count_ND, JGMT_Lawsuit_Pending_Count_ND, JGMT_Other_Count_ND) = NULL, NULL, sum(if(JGMT_Civil_Judgment_Count_ND = NULL, 0, JGMT_Civil_Judgment_Count_ND), if(JGMT_Child_Support_Count_ND = NULL, 0, JGMT_Child_Support_Count_ND), if(JGMT_Small_Claims_Count_ND = NULL, 0, JGMT_Small_Claims_Count_ND), if(JGMT_Judgment_Other_Count_ND = NULL, 0, JGMT_Judgment_Other_Count_ND), if(JGMT_Lawsuit_Pending_Count_ND = NULL, 0, JGMT_Lawsuit_Pending_Count_ND), if(JGMT_Other_Count_ND = NULL, 0, JGMT_Other_Count_ND)));
	
	judgment_red_count_nd := if(judgment_red_count_nd_1 = NULL, 0, judgment_red_count_nd_1);
	
	judgment_yellow_count_nd := if(judgment_yellow_count_nd_1 = NULL, 0, judgment_yellow_count_nd_1);
	
	judgment_green_count_nd := if(judgment_green_count_nd_1 = NULL, 0, judgment_green_count_nd_1);
	
	judgment_red_count := 1.00 * judgment_red_count_24 +
	    0.67 * judgment_red_count_60 +
	    0.50 * judgment_red_count_61 +
	    0.50 * judgment_red_count_nd;
	
	judgment_yellow_count := 1.00 * judgment_yellow_count_24 +
	    0.67 * judgment_yellow_count_60 +
	    0.50 * judgment_yellow_count_61 +
	    0.50 * judgment_yellow_count_nd;
	
	judgment_green_count := 1.00 * judgment_green_count_24 +
	    0.67 * judgment_green_count_60 +
	    0.50 * judgment_green_count_61 +
	    0.50 * judgment_green_count_nd;
		
	judgment_points_1 := -50 * judgment_red_count +
	    -25 * judgment_yellow_count +
	    -7 * judgment_green_count +
	    -50 * jgmt_eviction_flag_count;
	
	judgment_points := if(judgment_points_1 < -200, -200, judgment_points_1);
	
	criminal_offense_red_cnt_24_1 := if(max(Crim_Red_Misc_cnt_24, crim_Assault_cnt_24, crim_Weapon_cnt_24, crim_Murder_cnt_24, crim_Child_Abuse_cnt_24, crim_Forgery_cnt_24, crim_Theft_cnt_24, crim_Fraud_cnt_24) = NULL, NULL, sum(if(Crim_Red_Misc_cnt_24 = NULL, 0, Crim_Red_Misc_cnt_24), if(crim_Assault_cnt_24 = NULL, 0, crim_Assault_cnt_24), if(crim_Weapon_cnt_24 = NULL, 0, crim_Weapon_cnt_24), if(crim_Murder_cnt_24 = NULL, 0, crim_Murder_cnt_24), if(crim_Child_Abuse_cnt_24 = NULL, 0, crim_Child_Abuse_cnt_24), if(crim_Forgery_cnt_24 = NULL, 0, crim_Forgery_cnt_24), if(crim_Theft_cnt_24 = NULL, 0, crim_Theft_cnt_24), if(crim_Fraud_cnt_24 = NULL, 0, crim_Fraud_cnt_24)));
	
	criminal_offense_yellow_cnt_24_1 := if(max(crim_Robbery_cnt_24, crim_Break_Enter_cnt_24, crim_Burg_cnt_24, crim_Harassment_cnt_24, crim_DWLS_cnt_24, crim_DUI_cnt_24, crim_Cont_Subst_cnt_24, crim_Sex_Crime_cnt_24, crim_Felony_cnt_24) = NULL, NULL, sum(if(crim_Robbery_cnt_24 = NULL, 0, crim_Robbery_cnt_24), if(crim_Break_Enter_cnt_24 = NULL, 0, crim_Break_Enter_cnt_24), if(crim_Burg_cnt_24 = NULL, 0, crim_Burg_cnt_24), if(crim_Harassment_cnt_24 = NULL, 0, crim_Harassment_cnt_24), if(crim_DWLS_cnt_24 = NULL, 0, crim_DWLS_cnt_24), if(crim_DUI_cnt_24 = NULL, 0, crim_DUI_cnt_24), if(crim_Cont_Subst_cnt_24 = NULL, 0, crim_Cont_Subst_cnt_24), if(crim_Sex_Crime_cnt_24 = NULL, 0, crim_Sex_Crime_cnt_24), if(crim_Felony_cnt_24 = NULL, 0, crim_Felony_cnt_24)));
	
	criminal_offense_green_cnt_24_1 := if(max(crim_Other_cnt_24, crim_Traffic_cnt_24, crim_Parking_cnt_24, crim_Misdemeanor_cnt_24, crim_Prop_Dmg_cnt_24, crim_Disorderly_cnt_24, crim_Trespassing_cnt_24, crim_Alcohol_cnt_24, crim_Res_Arrest_cnt_24, crim_Bad_Check_cnt_24) = NULL, NULL, sum(if(crim_Other_cnt_24 = NULL, 0, crim_Other_cnt_24), if(crim_Traffic_cnt_24 = NULL, 0, crim_Traffic_cnt_24), if(crim_Parking_cnt_24 = NULL, 0, crim_Parking_cnt_24), if(crim_Misdemeanor_cnt_24 = NULL, 0, crim_Misdemeanor_cnt_24), if(crim_Prop_Dmg_cnt_24 = NULL, 0, crim_Prop_Dmg_cnt_24), if(crim_Disorderly_cnt_24 = NULL, 0, crim_Disorderly_cnt_24), if(crim_Trespassing_cnt_24 = NULL, 0, crim_Trespassing_cnt_24), if(crim_Alcohol_cnt_24 = NULL, 0, crim_Alcohol_cnt_24), if(crim_Res_Arrest_cnt_24 = NULL, 0, crim_Res_Arrest_cnt_24), if(crim_Bad_Check_cnt_24 = NULL, 0, crim_Bad_Check_cnt_24)));
	
	criminal_offense_red_cnt_60_1 := if(max(Crim_Red_Misc_cnt_60, crim_Assault_cnt_60, crim_Weapon_cnt_60, crim_Murder_cnt_60, crim_Child_Abuse_cnt_60, crim_Forgery_cnt_60, crim_Theft_cnt_60, crim_Fraud_cnt_60) = NULL, NULL, sum(if(Crim_Red_Misc_cnt_60 = NULL, 0, Crim_Red_Misc_cnt_60), if(crim_Assault_cnt_60 = NULL, 0, crim_Assault_cnt_60), if(crim_Weapon_cnt_60 = NULL, 0, crim_Weapon_cnt_60), if(crim_Murder_cnt_60 = NULL, 0, crim_Murder_cnt_60), if(crim_Child_Abuse_cnt_60 = NULL, 0, crim_Child_Abuse_cnt_60), if(crim_Forgery_cnt_60 = NULL, 0, crim_Forgery_cnt_60), if(crim_Theft_cnt_60 = NULL, 0, crim_Theft_cnt_60), if(crim_Fraud_cnt_60 = NULL, 0, crim_Fraud_cnt_60)));
	
	criminal_offense_yellow_cnt_60_1 := if(max(crim_Robbery_cnt_60, crim_Break_Enter_cnt_60, crim_Burg_cnt_60, crim_Harassment_cnt_60, crim_DWLS_cnt_60, crim_DUI_cnt_60, crim_Cont_Subst_cnt_60, crim_Sex_Crime_cnt_60, crim_Felony_cnt_60) = NULL, NULL, sum(if(crim_Robbery_cnt_60 = NULL, 0, crim_Robbery_cnt_60), if(crim_Break_Enter_cnt_60 = NULL, 0, crim_Break_Enter_cnt_60), if(crim_Burg_cnt_60 = NULL, 0, crim_Burg_cnt_60), if(crim_Harassment_cnt_60 = NULL, 0, crim_Harassment_cnt_60), if(crim_DWLS_cnt_60 = NULL, 0, crim_DWLS_cnt_60), if(crim_DUI_cnt_60 = NULL, 0, crim_DUI_cnt_60), if(crim_Cont_Subst_cnt_60 = NULL, 0, crim_Cont_Subst_cnt_60), if(crim_Sex_Crime_cnt_60 = NULL, 0, crim_Sex_Crime_cnt_60), if(crim_Felony_cnt_60 = NULL, 0, crim_Felony_cnt_60)));
	
	criminal_offense_green_cnt_60_1 := if(max(crim_Other_cnt_60, crim_Traffic_cnt_60, crim_Parking_cnt_60, crim_Misdemeanor_cnt_60, crim_Prop_Dmg_cnt_60, crim_Disorderly_cnt_60, crim_Trespassing_cnt_60, crim_Alcohol_cnt_60, crim_Res_Arrest_cnt_60, crim_Bad_Check_cnt_60) = NULL, NULL, sum(if(crim_Other_cnt_60 = NULL, 0, crim_Other_cnt_60), if(crim_Traffic_cnt_60 = NULL, 0, crim_Traffic_cnt_60), if(crim_Parking_cnt_60 = NULL, 0, crim_Parking_cnt_60), if(crim_Misdemeanor_cnt_60 = NULL, 0, crim_Misdemeanor_cnt_60), if(crim_Prop_Dmg_cnt_60 = NULL, 0, crim_Prop_Dmg_cnt_60), if(crim_Disorderly_cnt_60 = NULL, 0, crim_Disorderly_cnt_60), if(crim_Trespassing_cnt_60 = NULL, 0, crim_Trespassing_cnt_60), if(crim_Alcohol_cnt_60 = NULL, 0, crim_Alcohol_cnt_60), if(crim_Res_Arrest_cnt_60 = NULL, 0, crim_Res_Arrest_cnt_60), if(crim_Bad_Check_cnt_60 = NULL, 0, crim_Bad_Check_cnt_60)));
	
	criminal_offense_red_cnt_61_1 := if(max(Crim_Red_Misc_cnt_61, crim_Assault_cnt_61, crim_Weapon_cnt_61, crim_Murder_cnt_61, crim_Child_Abuse_cnt_61, crim_Forgery_cnt_61, crim_Theft_cnt_61, crim_Fraud_cnt_61) = NULL, NULL, sum(if(Crim_Red_Misc_cnt_61 = NULL, 0, Crim_Red_Misc_cnt_61), if(crim_Assault_cnt_61 = NULL, 0, crim_Assault_cnt_61), if(crim_Weapon_cnt_61 = NULL, 0, crim_Weapon_cnt_61), if(crim_Murder_cnt_61 = NULL, 0, crim_Murder_cnt_61), if(crim_Child_Abuse_cnt_61 = NULL, 0, crim_Child_Abuse_cnt_61), if(crim_Forgery_cnt_61 = NULL, 0, crim_Forgery_cnt_61), if(crim_Theft_cnt_61 = NULL, 0, crim_Theft_cnt_61), if(crim_Fraud_cnt_61 = NULL, 0, crim_Fraud_cnt_61)));
	
	criminal_offense_yellow_cnt_61_1 := if(max(crim_Robbery_cnt_61, crim_Break_Enter_cnt_61, crim_Burg_cnt_61, crim_Harassment_cnt_61, crim_DWLS_cnt_61, crim_DUI_cnt_61, crim_Cont_Subst_cnt_61, crim_Sex_Crime_cnt_61, crim_Felony_cnt_61) = NULL, NULL, sum(if(crim_Robbery_cnt_61 = NULL, 0, crim_Robbery_cnt_61), if(crim_Break_Enter_cnt_61 = NULL, 0, crim_Break_Enter_cnt_61), if(crim_Burg_cnt_61 = NULL, 0, crim_Burg_cnt_61), if(crim_Harassment_cnt_61 = NULL, 0, crim_Harassment_cnt_61), if(crim_DWLS_cnt_61 = NULL, 0, crim_DWLS_cnt_61), if(crim_DUI_cnt_61 = NULL, 0, crim_DUI_cnt_61), if(crim_Cont_Subst_cnt_61 = NULL, 0, crim_Cont_Subst_cnt_61), if(crim_Sex_Crime_cnt_61 = NULL, 0, crim_Sex_Crime_cnt_61), if(crim_Felony_cnt_61 = NULL, 0, crim_Felony_cnt_61)));
	
	criminal_offense_green_cnt_61_1 := if(max(crim_Other_cnt_61, crim_Traffic_cnt_61, crim_Parking_cnt_61, crim_Misdemeanor_cnt_61, crim_Prop_Dmg_cnt_61, crim_Disorderly_cnt_61, crim_Trespassing_cnt_61, crim_Alcohol_cnt_61, crim_Res_Arrest_cnt_61, crim_Bad_Check_cnt_61) = NULL, NULL, sum(if(crim_Other_cnt_61 = NULL, 0, crim_Other_cnt_61), if(crim_Traffic_cnt_61 = NULL, 0, crim_Traffic_cnt_61), if(crim_Parking_cnt_61 = NULL, 0, crim_Parking_cnt_61), if(crim_Misdemeanor_cnt_61 = NULL, 0, crim_Misdemeanor_cnt_61), if(crim_Prop_Dmg_cnt_61 = NULL, 0, crim_Prop_Dmg_cnt_61), if(crim_Disorderly_cnt_61 = NULL, 0, crim_Disorderly_cnt_61), if(crim_Trespassing_cnt_61 = NULL, 0, crim_Trespassing_cnt_61), if(crim_Alcohol_cnt_61 = NULL, 0, crim_Alcohol_cnt_61), if(crim_Res_Arrest_cnt_61 = NULL, 0, crim_Res_Arrest_cnt_61), if(crim_Bad_Check_cnt_61 = NULL, 0, crim_Bad_Check_cnt_61)));
	
	criminal_offense_red_cnt_121_1 := if(max(Crim_Red_Misc_cnt_121, crim_Assault_cnt_121, crim_Weapon_cnt_121, crim_Murder_cnt_121, crim_Child_Abuse_cnt_121, crim_Forgery_cnt_121, crim_Theft_cnt_121, crim_Fraud_cnt_121) = NULL, NULL, sum(if(Crim_Red_Misc_cnt_121 = NULL, 0, Crim_Red_Misc_cnt_121), if(crim_Assault_cnt_121 = NULL, 0, crim_Assault_cnt_121), if(crim_Weapon_cnt_121 = NULL, 0, crim_Weapon_cnt_121), if(crim_Murder_cnt_121 = NULL, 0, crim_Murder_cnt_121), if(crim_Child_Abuse_cnt_121 = NULL, 0, crim_Child_Abuse_cnt_121), if(crim_Forgery_cnt_121 = NULL, 0, crim_Forgery_cnt_121), if(crim_Theft_cnt_121 = NULL, 0, crim_Theft_cnt_121), if(crim_Fraud_cnt_121 = NULL, 0, crim_Fraud_cnt_121)));
	
	criminal_offense_yellow_cnt_121_1 := if(max(crim_Robbery_cnt_121, crim_Break_Enter_cnt_121, crim_Burg_cnt_121, crim_Harassment_cnt_121, crim_DWLS_cnt_121, crim_DUI_cnt_121, crim_Cont_Subst_cnt_121, crim_Sex_Crime_cnt_121, crim_Felony_cnt_121) = NULL, NULL, sum(if(crim_Robbery_cnt_121 = NULL, 0, crim_Robbery_cnt_121), if(crim_Break_Enter_cnt_121 = NULL, 0, crim_Break_Enter_cnt_121), if(crim_Burg_cnt_121 = NULL, 0, crim_Burg_cnt_121), if(crim_Harassment_cnt_121 = NULL, 0, crim_Harassment_cnt_121), if(crim_DWLS_cnt_121 = NULL, 0, crim_DWLS_cnt_121), if(crim_DUI_cnt_121 = NULL, 0, crim_DUI_cnt_121), if(crim_Cont_Subst_cnt_121 = NULL, 0, crim_Cont_Subst_cnt_121), if(crim_Sex_Crime_cnt_121 = NULL, 0, crim_Sex_Crime_cnt_121), if(crim_Felony_cnt_121 = NULL, 0, crim_Felony_cnt_121)));
	
	criminal_offense_green_cnt_121_1 := if(max(crim_Other_cnt_121, crim_Traffic_cnt_121, crim_Parking_cnt_121, crim_Misdemeanor_cnt_121, crim_Prop_Dmg_cnt_121, crim_Disorderly_cnt_121, crim_Trespassing_cnt_121, crim_Alcohol_cnt_121, crim_Res_Arrest_cnt_121, crim_Bad_Check_cnt_121) = NULL, NULL, sum(if(crim_Other_cnt_121 = NULL, 0, crim_Other_cnt_121), if(crim_Traffic_cnt_121 = NULL, 0, crim_Traffic_cnt_121), if(crim_Parking_cnt_121 = NULL, 0, crim_Parking_cnt_121), if(crim_Misdemeanor_cnt_121 = NULL, 0, crim_Misdemeanor_cnt_121), if(crim_Prop_Dmg_cnt_121 = NULL, 0, crim_Prop_Dmg_cnt_121), if(crim_Disorderly_cnt_121 = NULL, 0, crim_Disorderly_cnt_121), if(crim_Trespassing_cnt_121 = NULL, 0, crim_Trespassing_cnt_121), if(crim_Alcohol_cnt_121 = NULL, 0, crim_Alcohol_cnt_121), if(crim_Res_Arrest_cnt_121 = NULL, 0, crim_Res_Arrest_cnt_121), if(crim_Bad_Check_cnt_121 = NULL, 0, crim_Bad_Check_cnt_121)));
	
	criminal_offense_red_cnt_24 := if(criminal_offense_red_cnt_24_1 = NULL, 0, criminal_offense_red_cnt_24_1);
	
	criminal_offense_yellow_cnt_24 := if(criminal_offense_yellow_cnt_24_1 = NULL, 0, criminal_offense_yellow_cnt_24_1);
	
	criminal_offense_green_cnt_24 := if(criminal_offense_green_cnt_24_1 = NULL, 0, criminal_offense_green_cnt_24_1);
	
	criminal_offense_red_cnt_60 := if(criminal_offense_red_cnt_60_1 = NULL, 0, criminal_offense_red_cnt_60_1);
	
	criminal_offense_yellow_cnt_60 := if(criminal_offense_yellow_cnt_60_1 = NULL, 0, criminal_offense_yellow_cnt_60_1);
	
	criminal_offense_green_cnt_60 := if(criminal_offense_green_cnt_60_1 = NULL, 0, criminal_offense_green_cnt_60_1);
	
	criminal_offense_red_cnt_61 := if(criminal_offense_red_cnt_61_1 = NULL, 0, criminal_offense_red_cnt_61_1);
	
	criminal_offense_yellow_cnt_61 := if(criminal_offense_yellow_cnt_61_1 = NULL, 0, criminal_offense_yellow_cnt_61_1);
	
	criminal_offense_green_cnt_61 := if(criminal_offense_green_cnt_61_1 = NULL, 0, criminal_offense_green_cnt_61_1);
	
	criminal_offense_red_cnt_121 := if(criminal_offense_red_cnt_121_1 = NULL, 0, criminal_offense_red_cnt_121_1);
	
	criminal_offense_yellow_cnt_121 := if(criminal_offense_yellow_cnt_121_1 = NULL, 0, criminal_offense_yellow_cnt_121_1);
	
	criminal_offense_green_cnt_121 := if(criminal_offense_green_cnt_121_1 = NULL, 0, criminal_offense_green_cnt_121_1);
	
	criminal_offense_red_count := 1.00 * criminal_offense_red_cnt_24 +
	    0.67 * criminal_offense_red_cnt_60 +
	    0.50 * criminal_offense_red_cnt_61 +
	    0.25 * criminal_offense_red_cnt_121;
	
	criminal_offense_yellow_count := 1.00 * criminal_offense_yellow_cnt_24 +
	    0.67 * criminal_offense_yellow_cnt_60 +
	    0.50 * criminal_offense_yellow_cnt_61 +
	    0.25 * criminal_offense_yellow_cnt_121;
	
	criminal_offense_green_count := 1.00 * criminal_offense_green_cnt_24 +
	    0.67 * criminal_offense_green_cnt_60 +
	    0.50 * criminal_offense_green_cnt_61 +
	    0.25 * criminal_offense_green_cnt_121;
	
	criminal_offense_points_1 := -250 * criminal_offense_red_count +
	    -50 * criminal_offense_yellow_count +
	    -3 * criminal_offense_green_count;
	
	criminal_offense_points := if(criminal_offense_points_1 < -400, -400, criminal_offense_points_1);
	
	crim_ran_offense_red_cnt_24_1 := if(max(crim_RAN_Red_Misc_cnt_24, crim_RAN_Assault_cnt_24, crim_RAN_Weapon_cnt_24, crim_RAN_Murder_cnt_24, crim_RAN_Child_Abuse_cnt_24, crim_RAN_Forgery_cnt_24, crim_RAN_Theft_cnt_24, crim_RAN_Fraud_cnt_24) = NULL, NULL, sum(if(crim_RAN_Red_Misc_cnt_24 = NULL, 0, crim_RAN_Red_Misc_cnt_24), if(crim_RAN_Assault_cnt_24 = NULL, 0, crim_RAN_Assault_cnt_24), if(crim_RAN_Weapon_cnt_24 = NULL, 0, crim_RAN_Weapon_cnt_24), if(crim_RAN_Murder_cnt_24 = NULL, 0, crim_RAN_Murder_cnt_24), if(crim_RAN_Child_Abuse_cnt_24 = NULL, 0, crim_RAN_Child_Abuse_cnt_24), if(crim_RAN_Forgery_cnt_24 = NULL, 0, crim_RAN_Forgery_cnt_24), if(crim_RAN_Theft_cnt_24 = NULL, 0, crim_RAN_Theft_cnt_24), if(crim_RAN_Fraud_cnt_24 = NULL, 0, crim_RAN_Fraud_cnt_24)));
	
	crim_ran_offense_yellow_cnt_24_1 := if(max(crim_RAN_Robbery_cnt_24, crim_RAN_Break_Enter_cnt_24, crim_RAN_Burg_cnt_24, crim_RAN_Harassment_cnt_24, crim_RAN_DWLS_cnt_24, crim_RAN_DUI_cnt_24, crim_RAN_Cont_Subst_cnt_24, crim_RAN_Sex_Crime_cnt_24, crim_RAN_Felony_cnt_24) = NULL, NULL, sum(if(crim_RAN_Robbery_cnt_24 = NULL, 0, crim_RAN_Robbery_cnt_24), if(crim_RAN_Break_Enter_cnt_24 = NULL, 0, crim_RAN_Break_Enter_cnt_24), if(crim_RAN_Burg_cnt_24 = NULL, 0, crim_RAN_Burg_cnt_24), if(crim_RAN_Harassment_cnt_24 = NULL, 0, crim_RAN_Harassment_cnt_24), if(crim_RAN_DWLS_cnt_24 = NULL, 0, crim_RAN_DWLS_cnt_24), if(crim_RAN_DUI_cnt_24 = NULL, 0, crim_RAN_DUI_cnt_24), if(crim_RAN_Cont_Subst_cnt_24 = NULL, 0, crim_RAN_Cont_Subst_cnt_24), if(crim_RAN_Sex_Crime_cnt_24 = NULL, 0, crim_RAN_Sex_Crime_cnt_24), if(crim_RAN_Felony_cnt_24 = NULL, 0, crim_RAN_Felony_cnt_24)));
	
	crim_ran_offense_red_cnt_60_1 := if(max(crim_RAN_Red_Misc_cnt_60, crim_RAN_Assault_cnt_60, crim_RAN_Weapon_cnt_60, crim_RAN_Murder_cnt_60, crim_RAN_Child_Abuse_cnt_60, crim_RAN_Forgery_cnt_60, crim_RAN_Theft_cnt_60, crim_RAN_Fraud_cnt_60) = NULL, NULL, sum(if(crim_RAN_Red_Misc_cnt_60 = NULL, 0, crim_RAN_Red_Misc_cnt_60), if(crim_RAN_Assault_cnt_60 = NULL, 0, crim_RAN_Assault_cnt_60), if(crim_RAN_Weapon_cnt_60 = NULL, 0, crim_RAN_Weapon_cnt_60), if(crim_RAN_Murder_cnt_60 = NULL, 0, crim_RAN_Murder_cnt_60), if(crim_RAN_Child_Abuse_cnt_60 = NULL, 0, crim_RAN_Child_Abuse_cnt_60), if(crim_RAN_Forgery_cnt_60 = NULL, 0, crim_RAN_Forgery_cnt_60), if(crim_RAN_Theft_cnt_60 = NULL, 0, crim_RAN_Theft_cnt_60), if(crim_RAN_Fraud_cnt_60 = NULL, 0, crim_RAN_Fraud_cnt_60)));
	
	crim_ran_offense_yellow_cnt_60_1 := if(max(crim_RAN_Robbery_cnt_60, crim_RAN_Break_Enter_cnt_60, crim_RAN_Burg_cnt_60, crim_RAN_Harassment_cnt_60, crim_RAN_DWLS_cnt_60, crim_RAN_DUI_cnt_60, crim_RAN_Cont_Subst_cnt_60, crim_RAN_Sex_Crime_cnt_60, crim_RAN_Felony_cnt_60) = NULL, NULL, sum(if(crim_RAN_Robbery_cnt_60 = NULL, 0, crim_RAN_Robbery_cnt_60), if(crim_RAN_Break_Enter_cnt_60 = NULL, 0, crim_RAN_Break_Enter_cnt_60), if(crim_RAN_Burg_cnt_60 = NULL, 0, crim_RAN_Burg_cnt_60), if(crim_RAN_Harassment_cnt_60 = NULL, 0, crim_RAN_Harassment_cnt_60), if(crim_RAN_DWLS_cnt_60 = NULL, 0, crim_RAN_DWLS_cnt_60), if(crim_RAN_DUI_cnt_60 = NULL, 0, crim_RAN_DUI_cnt_60), if(crim_RAN_Cont_Subst_cnt_60 = NULL, 0, crim_RAN_Cont_Subst_cnt_60), if(crim_RAN_Sex_Crime_cnt_60 = NULL, 0, crim_RAN_Sex_Crime_cnt_60), if(crim_RAN_Felony_cnt_60 = NULL, 0, crim_RAN_Felony_cnt_60)));
	
	crim_ran_offense_red_cnt_61_1 := if(max(crim_RAN_Red_Misc_cnt_61, crim_RAN_Assault_cnt_61, crim_RAN_Weapon_cnt_61, crim_RAN_Murder_cnt_61, crim_RAN_Child_Abuse_cnt_61, crim_RAN_Forgery_cnt_61, crim_RAN_Theft_cnt_61, crim_RAN_Fraud_cnt_61) = NULL, NULL, sum(if(crim_RAN_Red_Misc_cnt_61 = NULL, 0, crim_RAN_Red_Misc_cnt_61), if(crim_RAN_Assault_cnt_61 = NULL, 0, crim_RAN_Assault_cnt_61), if(crim_RAN_Weapon_cnt_61 = NULL, 0, crim_RAN_Weapon_cnt_61), if(crim_RAN_Murder_cnt_61 = NULL, 0, crim_RAN_Murder_cnt_61), if(crim_RAN_Child_Abuse_cnt_61 = NULL, 0, crim_RAN_Child_Abuse_cnt_61), if(crim_RAN_Forgery_cnt_61 = NULL, 0, crim_RAN_Forgery_cnt_61), if(crim_RAN_Theft_cnt_61 = NULL, 0, crim_RAN_Theft_cnt_61), if(crim_RAN_Fraud_cnt_61 = NULL, 0, crim_RAN_Fraud_cnt_61)));
	
	crim_ran_offense_yellow_cnt_61_1 := if(max(crim_RAN_Robbery_cnt_61, crim_RAN_Break_Enter_cnt_61, crim_RAN_Burg_cnt_61, crim_RAN_Harassment_cnt_61, crim_RAN_DWLS_cnt_61, crim_RAN_DUI_cnt_61, crim_RAN_Cont_Subst_cnt_61, crim_RAN_Sex_Crime_cnt_61, crim_RAN_Felony_cnt_61) = NULL, NULL, sum(if(crim_RAN_Robbery_cnt_61 = NULL, 0, crim_RAN_Robbery_cnt_61), if(crim_RAN_Break_Enter_cnt_61 = NULL, 0, crim_RAN_Break_Enter_cnt_61), if(crim_RAN_Burg_cnt_61 = NULL, 0, crim_RAN_Burg_cnt_61), if(crim_RAN_Harassment_cnt_61 = NULL, 0, crim_RAN_Harassment_cnt_61), if(crim_RAN_DWLS_cnt_61 = NULL, 0, crim_RAN_DWLS_cnt_61), if(crim_RAN_DUI_cnt_61 = NULL, 0, crim_RAN_DUI_cnt_61), if(crim_RAN_Cont_Subst_cnt_61 = NULL, 0, crim_RAN_Cont_Subst_cnt_61), if(crim_RAN_Sex_Crime_cnt_61 = NULL, 0, crim_RAN_Sex_Crime_cnt_61), if(crim_RAN_Felony_cnt_61 = NULL, 0, crim_RAN_Felony_cnt_61)));
	
	crim_ran_offense_red_cnt_121_1 := if(max(crim_RAN_Red_Misc_cnt_121, crim_RAN_Assault_cnt_121, crim_RAN_Weapon_cnt_121, crim_RAN_Murder_cnt_121, crim_RAN_Child_Abuse_cnt_121, crim_RAN_Forgery_cnt_121, crim_RAN_Theft_cnt_121, crim_RAN_Fraud_cnt_121) = NULL, NULL, sum(if(crim_RAN_Red_Misc_cnt_121 = NULL, 0, crim_RAN_Red_Misc_cnt_121), if(crim_RAN_Assault_cnt_121 = NULL, 0, crim_RAN_Assault_cnt_121), if(crim_RAN_Weapon_cnt_121 = NULL, 0, crim_RAN_Weapon_cnt_121), if(crim_RAN_Murder_cnt_121 = NULL, 0, crim_RAN_Murder_cnt_121), if(crim_RAN_Child_Abuse_cnt_121 = NULL, 0, crim_RAN_Child_Abuse_cnt_121), if(crim_RAN_Forgery_cnt_121 = NULL, 0, crim_RAN_Forgery_cnt_121), if(crim_RAN_Theft_cnt_121 = NULL, 0, crim_RAN_Theft_cnt_121), if(crim_RAN_Fraud_cnt_121 = NULL, 0, crim_RAN_Fraud_cnt_121)));
	
	crim_ran_offense_yellow_cnt_121_1 := if(max(crim_RAN_Robbery_cnt_121, crim_RAN_Break_Enter_cnt_121, crim_RAN_Burg_cnt_121, crim_RAN_Harassment_cnt_121, crim_RAN_DWLS_cnt_121, crim_RAN_DUI_cnt_121, crim_RAN_Cont_Subst_cnt_121, crim_RAN_Sex_Crime_cnt_121, crim_RAN_Felony_cnt_121) = NULL, NULL, sum(if(crim_RAN_Robbery_cnt_121 = NULL, 0, crim_RAN_Robbery_cnt_121), if(crim_RAN_Break_Enter_cnt_121 = NULL, 0, crim_RAN_Break_Enter_cnt_121), if(crim_RAN_Burg_cnt_121 = NULL, 0, crim_RAN_Burg_cnt_121), if(crim_RAN_Harassment_cnt_121 = NULL, 0, crim_RAN_Harassment_cnt_121), if(crim_RAN_DWLS_cnt_121 = NULL, 0, crim_RAN_DWLS_cnt_121), if(crim_RAN_DUI_cnt_121 = NULL, 0, crim_RAN_DUI_cnt_121), if(crim_RAN_Cont_Subst_cnt_121 = NULL, 0, crim_RAN_Cont_Subst_cnt_121), if(crim_RAN_Sex_Crime_cnt_121 = NULL, 0, crim_RAN_Sex_Crime_cnt_121), if(crim_RAN_Felony_cnt_121 = NULL, 0, crim_RAN_Felony_cnt_121)));
	
	crim_ran_offense_red_cnt_24 := if(crim_ran_offense_red_cnt_24_1 = NULL, 0, crim_ran_offense_red_cnt_24_1);
	
	crim_ran_offense_yellow_cnt_24 := if(crim_ran_offense_yellow_cnt_24_1 = NULL, 0, crim_ran_offense_yellow_cnt_24_1);
	
	crim_ran_offense_red_cnt_60 := if(crim_ran_offense_red_cnt_60_1 = NULL, 0, crim_ran_offense_red_cnt_60_1);
	
	crim_ran_offense_yellow_cnt_60 := if(crim_ran_offense_yellow_cnt_60_1 = NULL, 0, crim_ran_offense_yellow_cnt_60_1);
	
	crim_ran_offense_red_cnt_61 := if(crim_ran_offense_red_cnt_61_1 = NULL, 0, crim_ran_offense_red_cnt_61_1);
	
	crim_ran_offense_yellow_cnt_61 := if(crim_ran_offense_yellow_cnt_61_1 = NULL, 0, crim_ran_offense_yellow_cnt_61_1);
	
	crim_ran_offense_red_cnt_121 := if(crim_ran_offense_red_cnt_121_1 = NULL, 0, crim_ran_offense_red_cnt_121_1);
	
	crim_ran_offense_yellow_cnt_121 := if(crim_ran_offense_yellow_cnt_121_1 = NULL, 0, crim_ran_offense_yellow_cnt_121_1);
	
	crim_ran_offense_red_count := 1.00 * crim_ran_offense_red_cnt_24 +
	    0.67 * crim_ran_offense_red_cnt_60 +
	    0.50 * crim_ran_offense_red_cnt_61 +
	    0.25 * crim_ran_offense_red_cnt_121;
	
	crim_ran_offense_yellow_count := 1.00 * crim_ran_offense_yellow_cnt_24 +
	    0.67 * crim_ran_offense_yellow_cnt_60 +
	    0.50 * crim_ran_offense_yellow_cnt_61 +
	    0.25 * crim_ran_offense_yellow_cnt_121;
	
	criminal_offense_points_ran_1 := -175 * crim_ran_offense_red_count + -100 * crim_ran_offense_yellow_count;
	
	criminal_offense_points_ran := if(criminal_offense_points_ran_1 < -150, -150, criminal_offense_points_ran_1);
	
	pk_attr_num_nonderogs180_6 := if((INTEGER)pk_deceased2 = 1, 0, pk_attr_num_nonderogs180_6_1);
	
	pk_yr_header_first_seen_17 := if((INTEGER)pk_deceased2 = 1, 0, pk_yr_header_first_seen_17_1);
	
	pk_r_pos_src_cnt_5 := if((INTEGER)pk_deceased2 = 1, 0, pk_r_pos_src_cnt_5_1);
	
	pk_rc_numelever_5 := if((INTEGER)pk_deceased2 = 1, 0, pk_rc_numelever_5_1);
	
	time_on_ps_38 := if((INTEGER)pk_deceased2 = 1, 0, time_on_ps_38_1);
	
	pk_rc_numelever_6 := if((INTEGER)pk_deceased2 = 1, 0, pk_rc_numelever_6_1);
	
	time_on_ps_09 := if((INTEGER)pk_deceased2 = 1, 0, time_on_ps_09_1);
	
	pk_attr_num_nonderogs180_5 := if((INTEGER)pk_deceased2 = 1, 0, pk_attr_num_nonderogs180_5_1);
	
	time_on_ps_39 := if((INTEGER)pk_deceased2 = 1, 0, time_on_ps_39_1);
	
	pk_r_pos_src_cnt_4 := if((INTEGER)pk_deceased2 = 1, 0, pk_r_pos_src_cnt_4_1);
	
	time_on_ps_13 := if((INTEGER)pk_deceased2 = 1, 0, time_on_ps_13_1);
	
	time_on_ps_18 := if((INTEGER)pk_deceased2 = 1, 0, time_on_ps_18_1);
	
	pk_attr_num_nonderogs180_3 := if((INTEGER)pk_deceased2 = 1, 0, (INTEGER)pk_attr_num_nonderogs180_3_1);
	
	pk_yr_header_first_seen_18plus := if((INTEGER)pk_deceased2 = 1, 0, (INTEGER)pk_yr_header_first_seen_18plus_1);
	
	time_on_ps_24 := if((INTEGER)pk_deceased2 = 1, 0, time_on_ps_24_1);
	
	pk_r_pos_src_cnt_3 := if((INTEGER)pk_deceased2 = 1, 0, pk_r_pos_src_cnt_3_1);
	
	pk_rc_numelever_partial := if((INTEGER)pk_deceased2 = 1, 0, pk_rc_numelever_partial_1);
	
	time_on_ps_30 := if((INTEGER)pk_deceased2 = 1, 0, time_on_ps_30_1);
	
	pk_attr_num_nonderogs180_4 := if((INTEGER)pk_deceased2 = 1, 0, pk_attr_num_nonderogs180_4_1);
	
	pk_r_pos_src_cnt_2 := if((INTEGER)pk_deceased2 = 1, 0, pk_r_pos_src_cnt_2_1);
	
	pk_rc_numelever_34 := if((INTEGER)pk_deceased2 = 1, 0, pk_rc_numelever_34_1);
	
	hps_score_7 := 824 - 
			49 * (integer)did_not_found - 
			349 * (INTEGER)pk_deceased2 - 
			124 * (INTEGER)ssn_priordob - 
			11 * (INTEGER)ssn_inval - 
			12 * (INTEGER)pk_disconnected - 
			13 * phn_highrisk - 
			8 * add_pobox - 
			6 * pk_addinval - 
			24 * pk_add1_advo_address_vacancy - 
			6 * pk_add1_advo_throw_back - 
			6 * pk_add1_advo_college - 
			7 * pk_add1_advo_dnd - 
			7 * pk_rc_numelever_0 - 
			0 * pk_rc_numelever_2 +
	    5 * pk_rc_numelever_partial +
	    8 * pk_rc_numelever_34 +
	    10 * pk_rc_numelever_5 +
	    13 * pk_rc_numelever_6 - 
			18 * pk_attr_num_nonderogs180_0 - 
			0 * pk_attr_num_nonderogs180_1 +
	    6 * pk_attr_num_nonderogs180_3 +
	    12 * pk_attr_num_nonderogs180_4 +
	    15 * pk_attr_num_nonderogs180_5 +
	    23 * pk_attr_num_nonderogs180_6 - 
			18 * pk_r_pos_src_cnt_0 - 
			0 * pk_r_pos_src_cnt_1 +
	    6 * pk_r_pos_src_cnt_2 +
	    11 * pk_r_pos_src_cnt_3 +
	    14 * pk_r_pos_src_cnt_4 +
	    22 * pk_r_pos_src_cnt_5 - 
			15 * pk_yr_header_first_seen_0 - 
			7 * pk_yr_header_first_seen_7 - 
			4 * pk_yr_header_first_seen_9 +
	    0 * pk_yr_header_first_seen_17 +
	    6 * pk_yr_header_first_seen_18plus - 
			26 * pk_impulse_flag - 
			24 * pk_inq_count70 - 
			9 * pk_inq_count40 - 
			4 * pk_inq_count10 - 
			0 * pk_inq_count09 - 
			148 * addrs_prison_history_1 - 
			9 * pk_lien_flag - 
			26 * pk_foreclosure - 
			11 * pk_bk_flag2 - 
			500 * sex_offense_tot - 
			50 * medlicproflic_none - 
			8 * medlicproflic_exp - 
			100 * medlicproflic_same_state_none - 
			18 * medlicproflic_same_state_exp - 
			350 * incarceration_y - 
			22 * time_on_ps_unknown - 
			7 * time_on_ps_03 - 
			0 * time_on_ps_06 +
	    2 * time_on_ps_09 +
	    4 * time_on_ps_13 +
	    6 * time_on_ps_18 +
	    8 * time_on_ps_24 +
	    10 * time_on_ps_30 +
	    12 * time_on_ps_38 +
	    14 * time_on_ps_39 - 
			250 * gsa_count - 
			100 * gsa_ran_count - 
			150 * gsa_corporate_affiliation_count - 
			50 * gsa_rancaff_count +
	    sanction_points +
	    criminal_offense_points +
	    judgment_points +
	    sanction_points_ran +
	    criminal_offense_points_ran +
	    sanction_points_caff;
	
	hps_score_diff_1 := if(min(900, hps_score_7) = NULL, NULL, (900 - hps_score_7) / 900);
	
	hps_score_diff := min(if(max(hps_score_diff_1, (real)0) = NULL, -NULL, max(hps_score_diff_1, (real)0)), 1);
	
	hps_score_diff2 := hps_score_diff * hps_score_diff;
	
	hps_score_6 := hps_score_7 + 300 * hps_score_diff2;
	
	hps_score_5 := min(if(max(round(hps_score_6), 300) = NULL, -NULL, max(round(hps_score_6), 300)), 900);
	
	hps_score_4 := if(criminal_offense_red_count > 0 and hps_score_5 > 545, 545, hps_score_5);
	
	hps_score_3 := if(criminal_offense_yellow_count > 0 and hps_score_4 > 635, 635, hps_score_4);
	
	hps_score_2 := if(sanction_black_count > 0 and hps_score_3 > 545, 545, hps_score_3);
	
	hps_score_1 := if(sanction_red_count > 0 and hps_score_2 > 550, 550, hps_score_2);
	
	hps_score := if(pk_deceased2 = 1 and hps_score_1 > 550, 550, hps_score_1);
	
	wc_c100_2 := 0;
	
	wc_c200_3 := 0;
	
	wc_c300_1 := 0;
	
	wc_c400_1 := 0;
	
	wc_c500_1 := 0;
	
	wc_c600_1 := 0;
	
	wc_c700_1 := 0;
	
	wc_c800_1 := 0;
	
	wc_c900_1 := 0;
	
	wc_d100_1 := 0;
	
	wc_d200_1 := 0;
	
	wc_d300_1 := 0;
	
	wc_f100_1 := 0;
	
	wc_f200_1 := 0;
	
	wc_f300 := 0;
	
	wc_f400 := 0;
	
	wc_f500_1 := 0;
	
	wc_f600_1 := 0;
	
	wc_id100_1 := 0;
	
	wc_l100_1 := 0;
	
	wc_l200_1 := 0;
	
	wc_l300_1 := 0;
	
	wc_s100_2 := 0;
	
	wc_s200_1 := 0;
	
	wc_s300_1 := 0;
	
	wc_s400_1 := 0;
	
	wc_s500_1 := 0;
	
	wc_a100_1 := 0;
	
	wc_a200_1 := 0;
	
	wc_a300_1 := 0;
	
	wc_a400_1 := 0;
	
	wc_a450_1 := 0;
	
	wc_a500_1 := 0;
	
	wc_a600_1 := 0;
	
	wc_a700_1 := 0;
	
	wc_a800_1 := 0;
	
	wc_a900_1 := 0;
	
	wc_x100_1 := 0;
	
	wc_x200_1 := 0;
	
	wc_x300_1 := 0;
	
	wc_v100_1 := 0;
	
	wc_v200_1 := 0;
	
	wc_v300_1 := 0;
	
	wc_c200_2 := map(
	    Crim_WC_Count >= 2 => 1,
	                          wc_c200_3);
	
	wc_c100_1 := map(
	    Crim_WC_Count >= 2 => wc_c100_2,
	                          1);
	
	wc_c400 := map(
	    Crim_WC_Misdemeanor_Count >= 2 => 1,
	                                      wc_c400_1);
	
	wc_c300 := map(
	    Crim_WC_Misdemeanor_Count >= 2 => wc_c300_1,
	                                      1);
	
	wc_c600 := map(
	    Crim_WC_Felony_Count >= 2 => 1,
	                                 wc_c600_1);
	
	wc_c500 := map(
	    Crim_WC_Felony_Count >= 2 => wc_c500_1,
	                                 1);
	
	wc_c700 := if(addrs_prison_history_1 > 0 or incarceration_y > 0, 1, wc_c700_1);
	
	wc_c800 := map(
	    Crim_WC_SexCrime_Count >= 2 => wc_c800_1,
	                                   1);
	
	wc_c900 := map(
	    Crim_WC_SexCrime_Count >= 2 => 1,
	                                   wc_c900_1);
	
	ver_name_src_ds := ver_fname_src_ds or ver_lname_src_ds;
	
	ver_name_src_de := ver_fname_src_de or ver_lname_src_de;
	
	wc_d100 := map(
	    (INTEGER)ver_ssn_src_ds = 1 and (INTEGER)ver_name_src_ds = 1 or (INTEGER)ver_ssn_src_de = 1 and (INTEGER)ver_name_src_de = 1   => 1,
	    (INTEGER)ver_addr_src_ds = 1 and (INTEGER)ver_name_src_ds = 1 or (INTEGER)ver_addr_src_de = 1 and (INTEGER)ver_name_src_de = 1 => (INTEGER)wc_d100_1,
	                                                                                                  (INTEGER)wc_d100_1);
	
	wc_d300 := map(
	    (INTEGER)ver_ssn_src_ds = 1 and (INTEGER)ver_name_src_ds = 1 or (INTEGER)ver_ssn_src_de = 1 and (INTEGER)ver_name_src_de = 1   => (INTEGER)wc_d300_1,
	    (INTEGER)ver_addr_src_ds = 1 and (INTEGER)ver_name_src_ds = 1 or (INTEGER)ver_addr_src_de = 1 and (INTEGER)ver_name_src_de = 1 => (INTEGER)wc_d300_1,
	                                                                                                  1);
	
	wc_d200 := map(
	    (INTEGER)ver_ssn_src_ds = 1 and (INTEGER)ver_name_src_ds = 1 or (INTEGER)ver_ssn_src_de = 1 and (INTEGER)ver_name_src_de = 1   => (INTEGER)wc_d200_1,
	    (INTEGER)ver_addr_src_ds = 1 and (INTEGER)ver_name_src_ds = 1 or (INTEGER)ver_addr_src_de = 1 and (INTEGER)ver_name_src_de = 1 => 1,
	                                                                                                  (INTEGER)wc_d200_1);
	
	wc_f200 := map(
	    (INTEGER)pk_bk_flag2 > 0 and filing_count >= 2 => 1,
	                                             (INTEGER)wc_f200_1);
	
	wc_f100 := map(
	    (INTEGER)pk_bk_flag2 > 0 and filing_count >= 2 => (INTEGER)wc_f100_1,
	                                             1);
	
	wc_f500 := map(
	    JGMT_Sum >= 2 or JGMT_Flag_Count >= 2 or jgmt_eviction_flag_count >= 2 => (INTEGER)wc_f500_1,
	                                                                              1);
	
	wc_f600 := map(
	    JGMT_Sum >= 2 or JGMT_Flag_Count >= 2 or jgmt_eviction_flag_count >= 2 => 1,
	                                                                              (INTEGER)wc_f600_1);
	
	ver_name_s := verfst_s or verlst_s;
	
	wc_id100 := if((INTEGER)ssn_inval = 1 or (INTEGER)ssnpop = 1 and ((INTEGER)verssn_s = 0 or (INTEGER)ver_name_s = 0), 1, (INTEGER)wc_id100_1);
	
	wc_id200 := map(
	    Time_On_PS > 3 or mth_header_first_seen >= 36               => 0,
	    Time_On_PS >= 0 and Time_On_PS <= 3                         => 1,
	    mth_header_first_seen = NULL or mth_header_first_seen <= 36 => 1,
	    time_on_ps_unknown = 1                                      => 1,
	                                                                   1);
	
	wc_l200 := map(
	    (INTEGER)medlicproflic_none = 1                                    => 1,
	    (INTEGER)medlicproflic_exp = 1 or (INTEGER)medlicproflic_same_state_exp = 1 => (INTEGER)wc_l200_1,
	                                                                 (INTEGER)wc_l200_1);
	
	wc_l300 := map(
	    (INTEGER)medlicproflic_none = 1                                    => (INTEGER)wc_l300_1,
	    (INTEGER)medlicproflic_exp = 1 or (INTEGER)medlicproflic_same_state_exp = 1 => 1,
	                                                                 (INTEGER)wc_l300_1);
	
	wc_l100 := map(
	    (INTEGER)medlicproflic_none = 1                                    => (INTEGER)wc_l100_1,
	    (INTEGER)medlicproflic_exp = 1 or (INTEGER)medlicproflic_same_state_exp = 1 => (INTEGER)wc_l100_1,
	                                                                 1);
	
	wc_s200 := map(
	    wc_sanction_count >= 2 => 1,
	                              (INTEGER)wc_s200_1);
	
	wc_s100_1 := map(
	    wc_sanction_count >= 2 => (INTEGER)wc_s100_2,
	                              1);
	
	wc_s100 := if((INTEGER)leie_hit = 1, 0, (INTEGER)wc_s100_1);
	
	wc_s300 := if((INTEGER)leie_hit = 1, 1, (INTEGER)wc_s300_1);
	
	wc_s400 := if((INTEGER)GSA_Provider_Current_Flag > 0 or (INTEGER)GSA_Business_Current_Flag > 0, 1, (INTEGER)wc_s400_1);
	
	wc_s500 := if((INTEGER)GSA_Provider_Old_Flag > 0 or (INTEGER)GSA_Business_Old_Flag > 0, 1, (INTEGER)wc_s500_1);
	
	wc_a100 := if((INTEGER)leie_caff_hit = 1 and sanction_points_caff != 0, 1, (INTEGER)wc_a100_1);
	
	wc_a200 := if((INTEGER)leie_ran_hit = 1 and sanction_points_ran != 0, 1, (INTEGER)wc_a200_1);
	
	wc_a300 := if((INTEGER)gsa_corporate_affiliation_count > 0, 1, (INTEGER)wc_a300_1);
	
	wc_a400 := if((INTEGER)gsa_ran_count > 0, 1, (INTEGER)wc_a400_1);
	
	wc_a450 := if((INTEGER)gsa_rancaff_count > 0, 1, (INTEGER)wc_a450_1);
	
	wc_a600 := map(
	    Crim_RAN_WC_Felony_Count >= 2 => 1,
	                                     (INTEGER)wc_a600_1);
	
	wc_a500 := map(
	    Crim_RAN_WC_Felony_Count >= 2 => (INTEGER)wc_a500_1,
	                                     1);
	
	wc_a800 := map(
	    Crim_RAN_WC_Misd_Count >= 2 => 1,
	                                   (INTEGER)wc_a800_1);
	
	wc_a700 := map(
	    Crim_RAN_WC_Misd_Count >= 2 => (INTEGER)wc_a700_1,
	                                   1);
	
	wc_a900 := if((INTEGER)crim_ran_offense_red_count > 0, 1, (INTEGER)wc_a900_1);
	
	wc_x100 := if(ssn_priordob = 1, 1, (INTEGER)wc_x100_1);
	
	wc_x200 := if((INTEGER)pk_disconnected = 1 or (INTEGER)phn_highrisk = 1, 1, (INTEGER)wc_x200_1);
	
	wc_x300 := if((INTEGER)add_pobox = 1 or 
								(INTEGER)pk_addinval = 1 or 
								(INTEGER)pk_add1_advo_address_vacancy = 1 or 
								(INTEGER)pk_add1_advo_throw_back = 1 or 
								(INTEGER)pk_add1_advo_college = 1 or 
								(INTEGER)pk_add1_advo_dnd = 1, 1, (INTEGER)wc_x300_1);
	
	wc_v100 := if(did_not_found or (INTEGER)pk_rc_numelever_0 = 1 or (INTEGER)pk_r_pos_src_cnt_0 = 1, 1, (INTEGER)wc_v100_1);
	
	wc_v200 := if((INTEGER)pk_attr_num_nonderogs180_0 = 1, 1, (INTEGER)wc_v200_1);
	
	wc_v300 := if((INTEGER)pk_yr_header_first_seen_0 = 1 or (INTEGER)pk_yr_header_first_seen_7 = 1 or (INTEGER)pk_yr_header_first_seen_9 = 1, 1, (INTEGER)wc_v300_1);
	
	wc_c100 := if((INTEGER)wc_c100_1 = 1 and ((INTEGER)wc_c300 = 1 or (INTEGER)wc_c500 = 1 or (INTEGER)wc_c800 = 1), 0, (INTEGER)wc_c100_1);
	
	wc_c200_1 := if((INTEGER)wc_c200_2 = 1 and ((INTEGER)wc_c400 = 1 or (INTEGER)wc_c600 = 1 or (INTEGER)wc_c900 = 1), 0, (INTEGER)wc_c200_2);
	
	wc_c200 := if((INTEGER)wc_c200_1 = 1 and if(max((INTEGER)wc_c300, (INTEGER)wc_c500, (INTEGER)wc_c800) = NULL, NULL, sum(if((INTEGER)wc_c300 = NULL, 0, wc_c300), if((INTEGER)wc_c500 = NULL, 0, wc_c500), if((INTEGER)wc_c800 = NULL, 0, wc_c800))) >= 2, 0, (INTEGER)wc_c200_1);
	
	wc_c100_pts_2 := 0;
	
	wc_c200_pts_2 := 0;
	
	wc_c300_pts_2 := 0;
	
	wc_c400_pts_2 := 0;
	
	wc_c500_pts_2 := 0;
	
	wc_c600_pts_2 := 0;
	
	wc_c700_pts_3 := 0;
	
	wc_c800_pts_3 := 0;
	
	wc_c900_pts_3 := 0;
	
	wc_d100_pts_2 := 0;
	
	wc_d200_pts_2 := 0;
	
	wc_d300_pts_2 := 0;
	
	wc_f100_pts_2 := 0;
	
	wc_f200_pts_2 := 0;
	
	wc_f300_pts_1 := 0;
	
	wc_f400_pts_1 := 0;
	
	wc_f500_pts_4 := 0;
	
	wc_f600_pts_4 := 0;
	
	wc_id100_pts_2 := 0;
	
	wc_id200_pts_5 := 0;
	
	wc_l100_pts_5 := 0;
	
	wc_l200_pts_5 := 0;
	
	wc_l300_pts_5 := 0;
	
	wc_s100_pts_2 := 0;
	
	wc_s200_pts_2 := 0;
	
	wc_s300_pts_2 := 0;
	
	wc_s400_pts_2 := 0;
	
	wc_s500_pts_2 := 0;
	
	wc_a100_pts_2 := 0;
	
	wc_a200_pts_2 := 0;
	
	wc_a300_pts_2 := 0;
	
	wc_a400_pts_2 := 0;
	
	wc_a450_pts_2 := 0;
	
	wc_a500_pts_2 := 0;
	
	wc_a600_pts_2 := 0;
	
	wc_a700_pts_2 := 0;
	
	wc_a800_pts_2 := 0;
	
	wc_a900_pts_2 := 0;
	
	wc_x100_pts_2 := 0;
	
	wc_x200_pts_3 := 0;
	
	wc_x300_pts_7 := 0;
	
	wc_v100_pts_4 := 0;
	
	wc_v200_pts_2 := 0;
	
	wc_v300_pts_4 := 0;
	
	wc_c100_pts_1 := wc_c100_pts_2 + criminal_offense_points;
	
	wc_c200_pts_1 := wc_c200_pts_2 + criminal_offense_points;
	
	wc_c300_pts_1 := wc_c300_pts_2 + criminal_offense_points;
	
	wc_c400_pts_1 := wc_c400_pts_2 + criminal_offense_points;
	
	wc_c500_pts_1 := wc_c500_pts_2 + criminal_offense_points;
	
	wc_c600_pts_1 := wc_c600_pts_2 + criminal_offense_points;
	
	wc_c700_pts_2 := wc_c700_pts_3 + - 148 * addrs_prison_history_1;
	
	wc_c700_pts_1 := wc_c700_pts_2 + - 350 * incarceration_y;
	
	wc_c800_pts_2 := wc_c800_pts_3 + criminal_offense_points;
	
	wc_c800_pts_1 := wc_c800_pts_2 + - 500 * sex_offense_tot;
	
	wc_c900_pts_2 := wc_c900_pts_3 + criminal_offense_points;
	
	wc_c900_pts_1 := wc_c900_pts_2 + - 500 * sex_offense_tot;
	
	wc_d100_pts_1 := wc_d100_pts_2 + -  349 * pk_deceased2;
	
	wc_d200_pts_1 := wc_d200_pts_2 + -  349 * pk_deceased2;
	
	wc_d300_pts_1 := wc_d300_pts_2 + -  349 * pk_deceased2;
	
	wc_f100_pts_1 := wc_f100_pts_2 + -   11 * pk_bk_flag2;
	
	wc_f200_pts_1 := wc_f200_pts_2 + -   11 * pk_bk_flag2;
	
	wc_f500_pts_3 := wc_f500_pts_4 + -    9 * pk_lien_flag;
	
	wc_f500_pts_2 := wc_f500_pts_3 + -   26 * pk_foreclosure;
	
	wc_f500_pts_1 := wc_f500_pts_2 + judgment_points;
	
	wc_f600_pts_3 := wc_f600_pts_4 + -    9 * pk_lien_flag;
	
	wc_f600_pts_2 := wc_f600_pts_3 + -   26 * pk_foreclosure;
	
	wc_f600_pts_1 := wc_f600_pts_2 + judgment_points;
	
	wc_id100_pts_1 := wc_id100_pts_2 + - 11 * ssn_inval;
	
	wc_id200_pts_4 := wc_id200_pts_5 + - 15 * pk_yr_header_first_seen_0;
	
	wc_id200_pts_3 := wc_id200_pts_4 + -  7 * pk_yr_header_first_seen_7;
	
	wc_id200_pts_2 := wc_id200_pts_3 + -  7 * time_on_ps_03;
	
	wc_id200_pts_1 := wc_id200_pts_2 + - 22 * time_on_ps_unknown;
	
	wc_l100_pts_4 := wc_l100_pts_5 + -   50 * medlicproflic_none;
	
	wc_l100_pts_3 := wc_l100_pts_4 + -    8 * medlicproflic_exp;
	
	wc_l100_pts_2 := wc_l100_pts_3 + -  100 * medlicproflic_same_state_none;
	
	wc_l100_pts_1 := wc_l100_pts_2 + -   18 * medlicproflic_same_state_exp;
	
	wc_l200_pts_4 := wc_l200_pts_5 + -   50 * medlicproflic_none;
	
	wc_l200_pts_3 := wc_l200_pts_4 + -    8 * medlicproflic_exp;
	
	wc_l200_pts_2 := wc_l200_pts_3 + -  100 * medlicproflic_same_state_none;
	
	wc_l200_pts_1 := wc_l200_pts_2 + -   18 * medlicproflic_same_state_exp;
	
	wc_l300_pts_4 := wc_l300_pts_5 + -   50 * medlicproflic_none;
	
	wc_l300_pts_3 := wc_l300_pts_4 + -    8 * medlicproflic_exp;
	
	wc_l300_pts_2 := wc_l300_pts_3 + -  100 * medlicproflic_same_state_none;
	
	wc_l300_pts_1 := wc_l300_pts_2 + -   18 * medlicproflic_same_state_exp;
	
	wc_s100_pts_1 := wc_s100_pts_2 + sanction_points;
	
	wc_s200_pts_1 := wc_s200_pts_2 + sanction_points;
	
	wc_s300_pts_1 := wc_s300_pts_2 + sanction_points;
	
	wc_s400_pts_1 := wc_s400_pts_2 + -  250 * gsa_count;
	
	wc_s500_pts_1 := wc_s500_pts_2 + -  250 * gsa_count;
	
	wc_a100_pts_1 := wc_a100_pts_2 + sanction_points_caff;
	
	wc_a200_pts_1 := wc_a200_pts_2 + sanction_points_ran;
	
	wc_a300_pts_1 := wc_a300_pts_2 + -  150 * gsa_corporate_affiliation_count;
	
	wc_a400_pts_1 := wc_a400_pts_2 + -  100 * gsa_ran_count;
	
	wc_a450_pts_1 := wc_a450_pts_2 + -   50 * gsa_rancaff_count;
	
	wc_a500_pts_1 := wc_a500_pts_2 + criminal_offense_points_ran;
	
	wc_a600_pts_1 := wc_a600_pts_2 + criminal_offense_points_ran;
	
	wc_a700_pts_1 := wc_a700_pts_2 + criminal_offense_points_ran;
	
	wc_a800_pts_1 := wc_a800_pts_2 + criminal_offense_points_ran;
	
	wc_a900_pts_1 := wc_a900_pts_2 + criminal_offense_points_ran;
	
	wc_x100_pts_1 := wc_x100_pts_2 + -  124 * ssn_priordob;
	
	wc_x200_pts_2 := wc_x200_pts_3 + -   12 * pk_disconnected;
	
	wc_x200_pts_1 := wc_x200_pts_2 + -   13 * phn_highrisk;
	
	wc_x300_pts_6 := wc_x300_pts_7 + -    8 * add_pobox;
	
	wc_x300_pts_5 := wc_x300_pts_6 + -    6 * pk_addinval;
	
	wc_x300_pts_4 := wc_x300_pts_5 + -  24 * pk_add1_advo_address_vacancy;
	
	wc_x300_pts_3 := wc_x300_pts_4 + -   6 * pk_add1_advo_throw_back;
	
	wc_x300_pts_2 := wc_x300_pts_3 + -   6 * pk_add1_advo_college;
	
	wc_x300_pts_1 := wc_x300_pts_2 + -   7 * pk_add1_advo_dnd;
	
	wc_v100_pts_3 := wc_v100_pts_4 + -   49 * (integer)did_not_found;
	
	wc_v100_pts_2 := wc_v100_pts_3 + -    7 * pk_rc_numelever_0;
	
	wc_v100_pts_1 := wc_v100_pts_2 + -   18 * pk_r_pos_src_cnt_0;
	
	wc_v200_pts_1 := wc_v200_pts_2 + -   18 * pk_attr_num_nonderogs180_0;
	
	wc_v300_pts_3 := wc_v300_pts_4 + -   15 * pk_yr_header_first_seen_0;
	
	wc_v300_pts_2 := wc_v300_pts_3 + -    7 * pk_yr_header_first_seen_7;
	
	wc_v300_pts_1 := wc_v300_pts_2 + -    4 * pk_yr_header_first_seen_9;
	
	wc_c100_pts := wc_c100_pts_1 * wc_c100;
	
	wc_c200_pts := wc_c200_pts_1 * wc_c200;
	
	wc_c300_pts := wc_c300_pts_1 * wc_c300;
	
	wc_c400_pts := wc_c400_pts_1 * wc_c400;
	
	wc_c500_pts := wc_c500_pts_1 * wc_c500;
	
	wc_c600_pts := wc_c600_pts_1 * wc_c600;
	
	wc_c700_pts := wc_c700_pts_1 * wc_c700;
	
	wc_c800_pts := wc_c800_pts_1 * wc_c800;
	
	wc_c900_pts := wc_c900_pts_1 * wc_c900;
	
	wc_d100_pts := wc_d100_pts_1 * wc_d100;
	
	wc_d200_pts := wc_d200_pts_1 * wc_d200;
	
	wc_d300_pts := wc_d300_pts_1 * wc_d300;
	
	wc_f100_pts := wc_f100_pts_1 * wc_f100;
	
	wc_f200_pts := wc_f200_pts_1 * wc_f200;
	
	wc_f300_pts := wc_f300_pts_1 * wc_f300;
	
	wc_f400_pts := wc_f400_pts_1 * wc_f400;
	
	wc_f500_pts := wc_f500_pts_1 * wc_f500;
	
	wc_f600_pts := wc_f600_pts_1 * wc_f600;
	
	wc_id100_pts := wc_id100_pts_1 * wc_id100;
	
	wc_id200_pts := wc_id200_pts_1 * wc_id200;
	
	wc_l100_pts := wc_l100_pts_1 * wc_l100;
	
	wc_l200_pts := wc_l200_pts_1 * wc_l200;
	
	wc_l300_pts := wc_l300_pts_1 * wc_l300;
	
	wc_s100_pts := wc_s100_pts_1 * wc_s100;
	
	wc_s200_pts := wc_s200_pts_1 * wc_s200;
	
	wc_s300_pts := wc_s300_pts_1 * wc_s300;
	
	wc_s400_pts := wc_s400_pts_1 * wc_s400;
	
	wc_s500_pts := wc_s500_pts_1 * wc_s500;
	
	wc_a100_pts := wc_a100_pts_1 * wc_a100;
	
	wc_a200_pts := wc_a200_pts_1 * wc_a200;
	
	wc_a300_pts := wc_a300_pts_1 * wc_a300;
	
	wc_a400_pts := wc_a400_pts_1 * wc_a400;
	
	wc_a450_pts := wc_a450_pts_1 * wc_a450;
	
	wc_a500_pts := wc_a500_pts_1 * wc_a500;
	
	wc_a600_pts := wc_a600_pts_1 * wc_a600;
	
	wc_a700_pts := wc_a700_pts_1 * wc_a700;
	
	wc_a800_pts := wc_a800_pts_1 * wc_a800;
	
	wc_a900_pts := wc_a900_pts_1 * wc_a900;
	
	wc_x100_pts := wc_x100_pts_1 * wc_x100;
	
	wc_x200_pts := wc_x200_pts_1 * wc_x200;
	
	wc_x300_pts := wc_x300_pts_1 * wc_x300;
	
	wc_v100_pts := wc_v100_pts_1 * wc_v100;
	
	wc_v200_pts := wc_v200_pts_1 * wc_v200;
	
	wc_v300_pts := wc_v300_pts_1 * wc_v300;
	
	pts1 := ABS(wc_c100_pts);
	
	pts2 := ABS(wc_c200_pts);
	
	pts3 := ABS(wc_c300_pts);
	
	pts4 := ABS(wc_c400_pts);
	
	pts5 := ABS(wc_c500_pts);
	
	pts6 := ABS(wc_c600_pts);
	
	pts7 := ABS(wc_c700_pts);
	
	pts8 := ABS(wc_c800_pts);
	
	pts9 := ABS(wc_c900_pts);
	
	pts10 := ABS(wc_d100_pts);
	
	pts11 := ABS(wc_d200_pts);
	
	pts12 := ABS(wc_d300_pts);
	
	pts13 := ABS(wc_f100_pts);
	
	pts14 := ABS(wc_f200_pts);
	
	pts15 := ABS(wc_f300_pts);
	
	pts16 := ABS(wc_f400_pts);
	
	pts17 := ABS(wc_f500_pts);
	
	pts18 := ABS(wc_f600_pts);
	
	pts19 := ABS(wc_id100_pts);
	
	pts20 := ABS(wc_id200_pts);
	
	pts21 := ABS(wc_l100_pts);
	
	pts22 := ABS(wc_l200_pts);
	
	pts23 := ABS(wc_l300_pts);
	
	pts24 := ABS(wc_s100_pts);
	
	pts25 := ABS(wc_s200_pts);
	
	pts26 := ABS(wc_s300_pts);
	
	pts27 := ABS(wc_s400_pts);
	
	pts28 := ABS(wc_s500_pts);
	
	pts29 := ABS(wc_a100_pts);
	
	pts30 := ABS(wc_a200_pts);
	
	pts31 := ABS(wc_a300_pts);
	
	pts32 := ABS(wc_a400_pts);
	
	pts33 := ABS(wc_a500_pts);
	
	pts34 := ABS(wc_a600_pts);
	
	pts35 := ABS(wc_a700_pts);
	
	pts36 := ABS(wc_a800_pts);
	
	pts37 := ABS(wc_a900_pts);
	
	pts38 := ABS(wc_x100_pts);
	
	pts39 := ABS(wc_x200_pts);
	
	pts40 := ABS(wc_x300_pts);
	
	pts41 := ABS(wc_v100_pts);
	
	pts42 := ABS(wc_v200_pts);
	
	pts43 := ABS(wc_v300_pts);
	
	pts44 := ABS(wc_a450_pts);
	
	wc1 := 'C100 ';
	
	wc2 := 'C200 ';
	
	wc3 := 'C300 ';
	
	wc4 := 'C400 ';
	
	wc5 := 'C500 ';
	
	wc6 := 'C600 ';
	
	wc7 := 'C700 ';
	
	wc8 := 'C800 ';
	
	wc9 := 'C900 ';
	
	wc10 := 'D100 ';
	
	wc11 := 'D200 ';
	
	wc12 := 'D300 ';
	
	wc13 := 'F100 ';
	
	wc14 := 'F200 ';
	
	wc15 := 'F300 ';
	
	wc16 := 'F400 ';
	
	wc17 := 'F500 ';
	
	wc18 := 'F600 ';
	
	wc19 := 'ID10 ';
	
	wc20 := 'ID20 ';
	
	wc21 := 'L100 ';
	
	wc22 := 'L200 ';
	
	wc23 := 'L300 ';
	
	wc24 := 'S100 ';
	
	wc25 := 'S200 ';
	
	wc26 := 'S300 ';
	
	wc27 := 'S400 ';
	
	wc28 := 'S500 ';
	
	wc29 := 'A100 ';
	
	wc30 := 'A200 ';
	
	wc31 := 'A300 ';
	
	wc32 := 'A400 ';
	
	wc33 := 'A500 ';
	
	wc34 := 'A600 ';
	
	wc35 := 'A700 ';
	
	wc36 := 'A800 ';
	
	wc37 := 'A900 ';
	
	wc38 := 'X100 ';
	
	wc39 := 'X200 ';
	
	wc40 := 'X300 ';
	
	wc41 := 'V100 ';
	
	wc42 := 'V200 ';
	
	wc43 := 'V300 ';
	
	wc44 := 'A450 ';
	
	temp_code := '     ';
	
	ds_layout := {STRING rc, REAL value};
	rc_dataset := DATASET([
	    {wc1, pts1}, 
	    {wc2, pts2}, 
	    {wc3, pts3}, 
	    {wc4, pts4}, 
	    {wc5, pts5}, 
	    {wc6, pts6}, 
	    {wc7, pts7}, 
	    {wc8, pts8}, 
	    {wc9, pts9}, 
	    {wc10, pts10}, 
	    {wc11, pts11}, 
	    {wc12, pts12}, 
	    {wc13, pts13}, 
	    {wc14, pts14}, 
	    {wc15, pts15}, 
	    {wc16, pts16}, 
	    {wc17, pts17}, 
	    {wc18, pts18}, 
	    {wc19, pts19}, 
	    {wc20, pts20}, 
	    {wc21, pts21}, 
	    {wc22, pts22}, 
	    {wc23, pts23}, 
	    {wc24, pts24}, 
	    {wc25, pts25}, 
	    {wc26, pts26}, 
	    {wc27, pts27}, 
	    {wc28, pts28}, 
	    {wc29, pts29}, 
	    {wc30, pts30}, 
	    {wc31, pts31}, 
	    {wc32, pts32}, 
	    {wc33, pts33}, 
	    {wc34, pts34}, 
	    {wc35, pts35}, 
	    {wc36, pts36}, 
	    {wc37, pts37}, 
	    // {wc38, pts38}, 
	    // {wc39, pts39}, 
	    // {wc40, pts40}, 
	    {wc41, pts41}, 
	    {wc42, pts42}, 
	    {wc43, pts43}, 
	    {wc44, pts44}
	    ], ds_layout)(value > 0);

			rcs_top := PROJECT(CHOOSEN(SORT(rc_dataset, -value, rc), numberOfReasonCodes), TRANSFORM(Risk_Indicators.Layout_Desc, SELF.HRI := (STRING)LEFT.rc; SELF.Desc := (STRING)LEFT.value));
			zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
			reasonsTemp := CHOOSEN(rcs_top & zeros, numberOfReasonCodes);
			// A reason code of 1100 means that no derogitory info was found
			reasons := IF(reasonsTemp[1].HRI = '00', CHOOSEN(DATASET([{'1100', ''}], Risk_Indicators.Layout_Desc) & zeros, numberOfReasonCodes), reasonsTemp);

	// #warning: Make sure to put the reason code logic here

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		// Boca Shell Fields
		SELF.archive_date := 	archive_date;
		SELF.header_first_seen := 	header_first_seen;
		SELF.date_last_seen := 	date_last_seen;
		SELF.ver_sources := 	ver_sources;
		SELF.ver_sources_first_seen := 	ver_sources_first_seen;
		SELF.ver_sources_NAS := 	ver_sources_NAS;
		SELF.ver_sources_last_seen := 	ver_sources_last_seen;
		SELF.ver_sources_count := 	ver_sources_count;
		SELF.ver_fname_sources := 	ver_fname_sources;
		SELF.ver_fname_sources_first_seen := 	ver_fname_sources_first_seen;
		SELF.ver_fname_sources_count := 	ver_fname_sources_count;
		SELF.ver_lname_sources := 	ver_lname_sources;
		SELF.ver_lname_sources_first_seen := 	ver_lname_sources_first_seen;
		SELF.ver_lname_sources_count := 	ver_lname_sources_count;
		SELF.ver_addr_sources := 	ver_addr_sources;
		SELF.ver_addr_sources_first_seen := 	ver_addr_sources_first_seen;
		SELF.ver_addr_sources_count := 	ver_addr_sources_count;
		SELF.ver_ssn_sources := 	ver_ssn_sources;
		SELF.ver_ssn_sources_first_seen := 	ver_ssn_sources_first_seen;
		SELF.ver_ssn_sources_count := 	ver_ssn_sources_count;
		SELF.email_source_list := 	email_source_list;
		SELF.email_source_first_seen := 	email_source_first_seen;
		SELF.email_source_count := 	email_source_count;
		SELF.nas_summary := 	nas_summary;
		SELF.rc_hriskaddrflag := 	rc_hriskaddrflag;
		SELF.rc_ziptypeflag := 	rc_ziptypeflag;
		SELF.rc_dwelltype := 	rc_dwelltype;
		SELF.rc_zipclass := 	rc_zipclass;
		SELF.out_addr_type := 	out_addr_type;
		SELF.rc_hriskphoneflag := 	rc_hriskphoneflag;
		SELF.rc_hphonetypeflag := 	rc_hphonetypeflag;
		SELF.rc_hphonevalflag := 	rc_hphonevalflag;
		SELF.rc_addrcommflag := 	rc_addrcommflag;
		SELF.ssnlength := 	ssnlength;
		SELF.rc_ssndobflag := 	rc_ssndobflag;
		SELF.rc_pwssndobflag := 	rc_pwssndobflag;
		SELF.rc_ssnvalflag := 	rc_ssnvalflag;
		SELF.rc_pwssnvalflag := 	rc_pwssnvalflag;
		SELF.rc_decsflag := 	rc_decsflag;
		SELF.impulse_count := 	impulse_count;
		SELF.liens_recent_unreleased_count := 	liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := 	liens_historical_unreleased_ct;
		SELF.did := 	did;
		SELF.nap_status := 	nap_status;
		SELF.rc_addrvalflag := 	rc_addrvalflag;
		SELF.dobpop := 	dobpop;
		SELF.combo_dobcount := 	combo_dobcount;
		SELF.combo_fnamecount := 	combo_fnamecount;
		SELF.combo_lnamecount := 	combo_lnamecount;
		SELF.combo_addrcount := 	combo_addrcount;
		SELF.combo_hphonecount := 	combo_hphonecount;
		SELF.combo_ssncount := 	combo_ssncount;
		SELF.fnamepop := 	fnamepop;
		SELF.lnamepop := 	lnamepop;
		SELF.addrpop := 	addrpop;
		SELF.hphnpop := 	hphnpop;
		SELF.add1_advo_address_vacancy := 	add1_advo_address_vacancy;
		SELF.add1_advo_throw_back := 	add1_advo_throw_back;
		SELF.add1_advo_college := 	add1_advo_college;
		SELF.add1_advo_dnd := 	add1_advo_dnd;
		SELF.rc_bansflag := 	rc_bansflag;
		SELF.bankrupt := 	bankrupt;
		SELF.filing_count := 	filing_count;
		SELF.bk_recent_count := 	bk_recent_count;
		SELF.Inq_count03 := 	Inq_count03;
		SELF.attr_num_nonderogs180 := 	attr_num_nonderogs180;
		SELF.incar_flag := 	incar_flag;
		SELF.addrs_prison_history := addrs_prison_history;
		
		// Healthcare Shell Fields
		SELF.sanc_OIG_LEIE_Count := 	sanc_OIG_LEIE_Count;
		SELF.sanc_OIG_LEIE_RAN_Count := 	sanc_OIG_LEIE_RAN_Count;
		SELF.sanc_OIG_LEIE_Count_CAff := 	sanc_OIG_LEIE_Count_CAff;
		SELF.in_MedLicProfLic_None := 	in_MedLicProfLic_None;
		SELF.in_MedLicProfLic_Exp := 	in_MedLicProfLic_Exp;
		SELF.in_MedLicProfLic_Same_State := 	in_MedLicProfLic_Same_State;
		SELF.in_MedLicProfLic_Same_State_Exp := 	in_MedLicProfLic_Same_State_Exp;
		SELF.Overall_Year_Min := 	Overall_Year_Min;
		SELF.Time_On_PS := 	Time_On_PS;
		SELF.Sex_Offense_Count_24 := 	Sex_Offense_Count_24;
		SELF.Sex_Offense_Count_60 := 	Sex_Offense_Count_60;
		SELF.Sex_Offense_Count_61 := 	Sex_Offense_Count_61;
		SELF.sanc_f02_Current_Count := 	sanc_f02_Current_Count;
		SELF.sanc_f05_Current_Count := 	sanc_f05_Current_Count;
		SELF.sanc_f06_Current_Count := 	sanc_f06_Current_Count;
		SELF.sanc_F07_Current_Count := 	sanc_F07_Current_Count;
		SELF.sanc_F08_Current_Count := 	sanc_F08_Current_Count;
		SELF.sanc_f11_Current_Count := 	sanc_f11_Current_Count;
		SELF.sanc_f19_Current_Count := 	sanc_f19_Current_Count;
		SELF.sanc_f20_Current_Count := 	sanc_f20_Current_Count;
		SELF.sanc_f21_Current_Count := 	sanc_f21_Current_Count;
		SELF.sanc_f22_Current_Count := 	sanc_f22_Current_Count;
		SELF.sanc_f23_Current_Count := 	sanc_f23_Current_Count;
		SELF.sanc_f24_Current_Count := 	sanc_f24_Current_Count;
		SELF.sanc_f25_Current_Count := 	sanc_f25_Current_Count;
		SELF.sanc_f12_Current_Count := 	sanc_f12_Current_Count;
		SELF.sanc_f16_Current_Count := 	sanc_f16_Current_Count;
		SELF.sanc_os_Current_Count := 	sanc_os_Current_Count;
		SELF.sanc_f03_Current_Count := 	sanc_f03_Current_Count;
		SELF.sanc_f04_Current_Count := 	sanc_f04_Current_Count;
		SELF.sanc_f09_Current_Count := 	sanc_f09_Current_Count;
		SELF.sanc_f10_Current_Count := 	sanc_f10_Current_Count;
		SELF.sanc_f13_Current_Count := 	sanc_f13_Current_Count;
		SELF.sanc_f17_Current_Count := 	sanc_f17_Current_Count;
		SELF.sanc_f18_Current_Count := 	sanc_f18_Current_Count;
		SELF.sanc_f26_Current_Count := 	sanc_f26_Current_Count;
		SELF.sanc_f01_Current_Count := 	sanc_f01_Current_Count;
		SELF.sanc_f14_Current_Count := 	sanc_f14_Current_Count;
		SELF.sanc_f15_Current_Count := 	sanc_f15_Current_Count;
		SELF.sanc_f02_24_Count := 	sanc_f02_24_Count;
		SELF.sanc_f05_24_Count := 	sanc_f05_24_Count;
		SELF.sanc_f06_24_Count := 	sanc_f06_24_Count;
		SELF.sanc_F07_24_Count := 	sanc_F07_24_Count;
		SELF.sanc_F08_24_Count := 	sanc_F08_24_Count;
		SELF.sanc_f11_24_Count := 	sanc_f11_24_Count;
		SELF.sanc_f19_24_Count := 	sanc_f19_24_Count;
		SELF.sanc_f20_24_Count := 	sanc_f20_24_Count;
		SELF.sanc_f21_24_Count := 	sanc_f21_24_Count;
		SELF.sanc_f22_24_Count := 	sanc_f22_24_Count;
		SELF.sanc_f23_24_Count := 	sanc_f23_24_Count;
		SELF.sanc_f24_24_Count := 	sanc_f24_24_Count;
		SELF.sanc_f25_24_Count := 	sanc_f25_24_Count;
		SELF.sanc_f12_24_Count := 	sanc_f12_24_Count;
		SELF.sanc_f16_24_Count := 	sanc_f16_24_Count;
		SELF.sanc_os_24_Count := 	sanc_os_24_Count;
		SELF.sanc_f03_24_Count := 	sanc_f03_24_Count;
		SELF.sanc_f04_24_Count := 	sanc_f04_24_Count;
		SELF.sanc_f09_24_Count := 	sanc_f09_24_Count;
		SELF.sanc_f10_24_Count := 	sanc_f10_24_Count;
		SELF.sanc_f13_24_Count := 	sanc_f13_24_Count;
		SELF.sanc_f17_24_Count := 	sanc_f17_24_Count;
		SELF.sanc_f18_24_Count := 	sanc_f18_24_Count;
		SELF.sanc_f26_24_Count := 	sanc_f26_24_Count;
		SELF.sanc_f01_24_Count := 	sanc_f01_24_Count;
		SELF.sanc_f14_24_Count := 	sanc_f14_24_Count;
		SELF.sanc_f15_24_Count := 	sanc_f15_24_Count;
		SELF.sanc_f02_60_Count := 	sanc_f02_60_Count;
		SELF.sanc_f05_60_Count := 	sanc_f05_60_Count;
		SELF.sanc_f06_60_Count := 	sanc_f06_60_Count;
		SELF.sanc_F07_60_Count := 	sanc_F07_60_Count;
		SELF.sanc_F08_60_Count := 	sanc_F08_60_Count;
		SELF.sanc_f11_60_Count := 	sanc_f11_60_Count;
		SELF.sanc_f19_60_Count := 	sanc_f19_60_Count;
		SELF.sanc_f20_60_Count := 	sanc_f20_60_Count;
		SELF.sanc_f21_60_Count := 	sanc_f21_60_Count;
		SELF.sanc_f22_60_Count := 	sanc_f22_60_Count;
		SELF.sanc_f23_60_Count := 	sanc_f23_60_Count;
		SELF.sanc_f24_60_Count := 	sanc_f24_60_Count;
		SELF.sanc_f25_60_Count := 	sanc_f25_60_Count;
		SELF.sanc_f12_60_Count := 	sanc_f12_60_Count;
		SELF.sanc_f16_60_Count := 	sanc_f16_60_Count;
		SELF.sanc_os_60_Count := 	sanc_os_60_Count;
		SELF.sanc_f03_60_Count := 	sanc_f03_60_Count;
		SELF.sanc_f04_60_Count := 	sanc_f04_60_Count;
		SELF.sanc_f09_60_Count := 	sanc_f09_60_Count;
		SELF.sanc_f10_60_Count := 	sanc_f10_60_Count;
		SELF.sanc_f13_60_Count := 	sanc_f13_60_Count;
		SELF.sanc_f17_60_Count := 	sanc_f17_60_Count;
		SELF.sanc_f18_60_Count := 	sanc_f18_60_Count;
		SELF.sanc_f26_60_Count := 	sanc_f26_60_Count;
		SELF.sanc_f01_60_Count := 	sanc_f01_60_Count;
		SELF.sanc_f14_60_Count := 	sanc_f14_60_Count;
		SELF.sanc_f15_60_Count := 	sanc_f15_60_Count;
		SELF.sanc_f02_61_Count := 	sanc_f02_61_Count;
		SELF.sanc_f05_61_Count := 	sanc_f05_61_Count;
		SELF.sanc_f06_61_Count := 	sanc_f06_61_Count;
		SELF.sanc_F07_61_Count := 	sanc_F07_61_Count;
		SELF.sanc_F08_61_Count := 	sanc_F08_61_Count;
		SELF.sanc_f11_61_Count := 	sanc_f11_61_Count;
		SELF.sanc_f19_61_Count := 	sanc_f19_61_Count;
		SELF.sanc_f20_61_Count := 	sanc_f20_61_Count;
		SELF.sanc_f21_61_Count := 	sanc_f21_61_Count;
		SELF.sanc_f22_61_Count := 	sanc_f22_61_Count;
		SELF.sanc_f23_61_Count := 	sanc_f23_61_Count;
		SELF.sanc_f24_61_Count := 	sanc_f24_61_Count;
		SELF.sanc_f25_61_Count := 	sanc_f25_61_Count;
		SELF.sanc_f12_61_Count := 	sanc_f12_61_Count;
		SELF.sanc_f16_61_Count := 	sanc_f16_61_Count;
		SELF.sanc_os_61_Count := 	sanc_os_61_Count;
		SELF.sanc_f03_61_Count := 	sanc_f03_61_Count;
		SELF.sanc_f04_61_Count := 	sanc_f04_61_Count;
		SELF.sanc_f09_61_Count := 	sanc_f09_61_Count;
		SELF.sanc_f10_61_Count := 	sanc_f10_61_Count;
		SELF.sanc_f13_61_Count := 	sanc_f13_61_Count;
		SELF.sanc_f17_61_Count := 	sanc_f17_61_Count;
		SELF.sanc_f18_61_Count := 	sanc_f18_61_Count;
		SELF.sanc_f26_61_Count := 	sanc_f26_61_Count;
		SELF.sanc_f01_61_Count := 	sanc_f01_61_Count;
		SELF.sanc_f14_61_Count := 	sanc_f14_61_Count;
		SELF.sanc_f15_61_Count := 	sanc_f15_61_Count;
		SELF.sanc_f02_Current_Count_RAN := 	sanc_f02_Current_Count_RAN;
		SELF.sanc_f05_Current_Count_RAN := 	sanc_f05_Current_Count_RAN;
		SELF.sanc_f06_Current_Count_RAN := 	sanc_f06_Current_Count_RAN;
		SELF.sanc_F07_Current_Count_RAN := 	sanc_F07_Current_Count_RAN;
		SELF.sanc_F08_Current_Count_RAN := 	sanc_F08_Current_Count_RAN;
		SELF.sanc_f11_Current_Count_RAN := 	sanc_f11_Current_Count_RAN;
		SELF.sanc_f19_Current_Count_RAN := 	sanc_f19_Current_Count_RAN;
		SELF.sanc_f20_Current_Count_RAN := 	sanc_f20_Current_Count_RAN;
		SELF.sanc_f21_Current_Count_RAN := 	sanc_f21_Current_Count_RAN;
		SELF.sanc_f22_Current_Count_RAN := 	sanc_f22_Current_Count_RAN;
		SELF.sanc_f23_Current_Count_RAN := 	sanc_f23_Current_Count_RAN;
		SELF.sanc_f24_Current_Count_RAN := 	sanc_f24_Current_Count_RAN;
		SELF.sanc_f25_Current_Count_RAN := 	sanc_f25_Current_Count_RAN;
		SELF.sanc_f12_Current_Count_RAN := 	sanc_f12_Current_Count_RAN;
		SELF.sanc_f16_Current_Count_RAN := 	sanc_f16_Current_Count_RAN;
		SELF.sanc_os_Current_Count_RAN := 	sanc_os_Current_Count_RAN;
		SELF.sanc_f03_Current_Count_RAN := 	sanc_f03_Current_Count_RAN;
		SELF.sanc_f04_Current_Count_RAN := 	sanc_f04_Current_Count_RAN;
		SELF.sanc_f09_Current_Count_RAN := 	sanc_f09_Current_Count_RAN;
		SELF.sanc_f10_Current_Count_RAN := 	sanc_f10_Current_Count_RAN;
		SELF.sanc_f13_Current_Count_RAN := 	sanc_f13_Current_Count_RAN;
		SELF.sanc_f17_Current_Count_RAN := 	sanc_f17_Current_Count_RAN;
		SELF.sanc_f18_Current_Count_RAN := 	sanc_f18_Current_Count_RAN;
		SELF.sanc_f26_Current_Count_RAN := 	sanc_f26_Current_Count_RAN;
		SELF.sanc_f01_Current_Count_RAN := 	sanc_f01_Current_Count_RAN;
		SELF.sanc_f14_Current_Count_RAN := 	sanc_f14_Current_Count_RAN;
		SELF.sanc_f15_Current_Count_RAN := 	sanc_f15_Current_Count_RAN;
		SELF.sanc_f02_24_Count_RAN := 	sanc_f02_24_Count_RAN;
		SELF.sanc_f05_24_Count_RAN := 	sanc_f05_24_Count_RAN;
		SELF.sanc_f06_24_Count_RAN := 	sanc_f06_24_Count_RAN;
		SELF.sanc_F07_24_Count_RAN := 	sanc_F07_24_Count_RAN;
		SELF.sanc_F08_24_Count_RAN := 	sanc_F08_24_Count_RAN;
		SELF.sanc_f11_24_Count_RAN := 	sanc_f11_24_Count_RAN;
		SELF.sanc_f19_24_Count_RAN := 	sanc_f19_24_Count_RAN;
		SELF.sanc_f20_24_Count_RAN := 	sanc_f20_24_Count_RAN;
		SELF.sanc_f21_24_Count_RAN := 	sanc_f21_24_Count_RAN;
		SELF.sanc_f22_24_Count_RAN := 	sanc_f22_24_Count_RAN;
		SELF.sanc_f23_24_Count_RAN := 	sanc_f23_24_Count_RAN;
		SELF.sanc_f24_24_Count_RAN := 	sanc_f24_24_Count_RAN;
		SELF.sanc_f25_24_Count_RAN := 	sanc_f25_24_Count_RAN;
		SELF.sanc_f12_24_Count_RAN := 	sanc_f12_24_Count_RAN;
		SELF.sanc_f16_24_Count_RAN := 	sanc_f16_24_Count_RAN;
		SELF.sanc_os_24_Count_RAN := 	sanc_os_24_Count_RAN;
		SELF.sanc_f03_24_Count_RAN := 	sanc_f03_24_Count_RAN;
		SELF.sanc_f04_24_Count_RAN := 	sanc_f04_24_Count_RAN;
		SELF.sanc_f09_24_Count_RAN := 	sanc_f09_24_Count_RAN;
		SELF.sanc_f10_24_Count_RAN := 	sanc_f10_24_Count_RAN;
		SELF.sanc_f13_24_Count_RAN := 	sanc_f13_24_Count_RAN;
		SELF.sanc_f17_24_Count_RAN := 	sanc_f17_24_Count_RAN;
		SELF.sanc_f18_24_Count_RAN := 	sanc_f18_24_Count_RAN;
		SELF.sanc_f26_24_Count_RAN := 	sanc_f26_24_Count_RAN;
		SELF.sanc_f01_24_Count_RAN := 	sanc_f01_24_Count_RAN;
		SELF.sanc_f14_24_Count_RAN := 	sanc_f14_24_Count_RAN;
		SELF.sanc_f15_24_Count_RAN := 	sanc_f15_24_Count_RAN;
		SELF.sanc_f02_60_Count_RAN := 	sanc_f02_60_Count_RAN;
		SELF.sanc_f05_60_Count_RAN := 	sanc_f05_60_Count_RAN;
		SELF.sanc_f06_60_Count_RAN := 	sanc_f06_60_Count_RAN;
		SELF.sanc_F07_60_Count_RAN := 	sanc_F07_60_Count_RAN;
		SELF.sanc_F08_60_Count_RAN := 	sanc_F08_60_Count_RAN;
		SELF.sanc_f11_60_Count_RAN := 	sanc_f11_60_Count_RAN;
		SELF.sanc_f19_60_Count_RAN := 	sanc_f19_60_Count_RAN;
		SELF.sanc_f20_60_Count_RAN := 	sanc_f20_60_Count_RAN;
		SELF.sanc_f21_60_Count_RAN := 	sanc_f21_60_Count_RAN;
		SELF.sanc_f22_60_Count_RAN := 	sanc_f22_60_Count_RAN;
		SELF.sanc_f23_60_Count_RAN := 	sanc_f23_60_Count_RAN;
		SELF.sanc_f24_60_Count_RAN := 	sanc_f24_60_Count_RAN;
		SELF.sanc_f25_60_Count_RAN := 	sanc_f25_60_Count_RAN;
		SELF.sanc_f12_60_Count_RAN := 	sanc_f12_60_Count_RAN;
		SELF.sanc_f16_60_Count_RAN := 	sanc_f16_60_Count_RAN;
		SELF.sanc_os_60_Count_RAN := 	sanc_os_60_Count_RAN;
		SELF.sanc_f03_60_Count_RAN := 	sanc_f03_60_Count_RAN;
		SELF.sanc_f04_60_Count_RAN := 	sanc_f04_60_Count_RAN;
		SELF.sanc_f09_60_Count_RAN := 	sanc_f09_60_Count_RAN;
		SELF.sanc_f10_60_Count_RAN := 	sanc_f10_60_Count_RAN;
		SELF.sanc_f13_60_Count_RAN := 	sanc_f13_60_Count_RAN;
		SELF.sanc_f17_60_Count_RAN := 	sanc_f17_60_Count_RAN;
		SELF.sanc_f18_60_Count_RAN := 	sanc_f18_60_Count_RAN;
		SELF.sanc_f26_60_Count_RAN := 	sanc_f26_60_Count_RAN;
		SELF.sanc_f01_60_Count_RAN := 	sanc_f01_60_Count_RAN;
		SELF.sanc_f14_60_Count_RAN := 	sanc_f14_60_Count_RAN;
		SELF.sanc_f15_60_Count_RAN := 	sanc_f15_60_Count_RAN;
		SELF.sanc_f02_61_Count_RAN := 	sanc_f02_61_Count_RAN;
		SELF.sanc_f05_61_Count_RAN := 	sanc_f05_61_Count_RAN;
		SELF.sanc_f06_61_Count_RAN := 	sanc_f06_61_Count_RAN;
		SELF.sanc_F07_61_Count_RAN := 	sanc_F07_61_Count_RAN;
		SELF.sanc_F08_61_Count_RAN := 	sanc_F08_61_Count_RAN;
		SELF.sanc_f11_61_Count_RAN := 	sanc_f11_61_Count_RAN;
		SELF.sanc_f19_61_Count_RAN := 	sanc_f19_61_Count_RAN;
		SELF.sanc_f20_61_Count_RAN := 	sanc_f20_61_Count_RAN;
		SELF.sanc_f21_61_Count_RAN := 	sanc_f21_61_Count_RAN;
		SELF.sanc_f22_61_Count_RAN := 	sanc_f22_61_Count_RAN;
		SELF.sanc_f23_61_Count_RAN := 	sanc_f23_61_Count_RAN;
		SELF.sanc_f24_61_Count_RAN := 	sanc_f24_61_Count_RAN;
		SELF.sanc_f25_61_Count_RAN := 	sanc_f25_61_Count_RAN;
		SELF.sanc_f12_61_Count_RAN := 	sanc_f12_61_Count_RAN;
		SELF.sanc_f16_61_Count_RAN := 	sanc_f16_61_Count_RAN;
		SELF.sanc_os_61_Count_RAN := 	sanc_os_61_Count_RAN;
		SELF.sanc_f03_61_Count_RAN := 	sanc_f03_61_Count_RAN;
		SELF.sanc_f04_61_Count_RAN := 	sanc_f04_61_Count_RAN;
		SELF.sanc_f09_61_Count_RAN := 	sanc_f09_61_Count_RAN;
		SELF.sanc_f10_61_Count_RAN := 	sanc_f10_61_Count_RAN;
		SELF.sanc_f13_61_Count_RAN := 	sanc_f13_61_Count_RAN;
		SELF.sanc_f17_61_Count_RAN := 	sanc_f17_61_Count_RAN;
		SELF.sanc_f18_61_Count_RAN := 	sanc_f18_61_Count_RAN;
		SELF.sanc_f26_61_Count_RAN := 	sanc_f26_61_Count_RAN;
		SELF.sanc_f01_61_Count_RAN := 	sanc_f01_61_Count_RAN;
		SELF.sanc_f14_61_Count_RAN := 	sanc_f14_61_Count_RAN;
		SELF.sanc_f15_61_Count_RAN := 	sanc_f15_61_Count_RAN;
		SELF.sanc_f02_Current_Count_CAff := 	sanc_f02_Current_Count_CAff;
		SELF.sanc_f05_Current_Count_CAff := 	sanc_f05_Current_Count_CAff;
		SELF.sanc_f06_Current_Count_CAff := 	sanc_f06_Current_Count_CAff;
		SELF.sanc_F07_Current_Count_CAff := 	sanc_F07_Current_Count_CAff;
		SELF.sanc_F08_Current_Count_CAff := 	sanc_F08_Current_Count_CAff;
		SELF.sanc_f11_Current_Count_CAff := 	sanc_f11_Current_Count_CAff;
		SELF.sanc_f19_Current_Count_CAff := 	sanc_f19_Current_Count_CAff;
		SELF.sanc_f20_Current_Count_CAff := 	sanc_f20_Current_Count_CAff;
		SELF.sanc_f21_Current_Count_CAff := 	sanc_f21_Current_Count_CAff;
		SELF.sanc_f22_Current_Count_CAff := 	sanc_f22_Current_Count_CAff;
		SELF.sanc_f23_Current_Count_CAff := 	sanc_f23_Current_Count_CAff;
		SELF.sanc_f24_Current_Count_CAff := 	sanc_f24_Current_Count_CAff;
		SELF.sanc_f25_Current_Count_CAff := 	sanc_f25_Current_Count_CAff;
		SELF.sanc_f12_Current_Count_CAff := 	sanc_f12_Current_Count_CAff;
		SELF.sanc_f16_Current_Count_CAff := 	sanc_f16_Current_Count_CAff;
		SELF.sanc_os_Current_Count_CAff := 	sanc_os_Current_Count_CAff;
		SELF.sanc_f03_Current_Count_CAff := 	sanc_f03_Current_Count_CAff;
		SELF.sanc_f04_Current_Count_CAff := 	sanc_f04_Current_Count_CAff;
		SELF.sanc_f09_Current_Count_CAff := 	sanc_f09_Current_Count_CAff;
		SELF.sanc_f10_Current_Count_CAff := 	sanc_f10_Current_Count_CAff;
		SELF.sanc_f13_Current_Count_CAff := 	sanc_f13_Current_Count_CAff;
		SELF.sanc_f17_Current_Count_CAff := 	sanc_f17_Current_Count_CAff;
		SELF.sanc_f18_Current_Count_CAff := 	sanc_f18_Current_Count_CAff;
		SELF.sanc_f26_Current_Count_CAff := 	sanc_f26_Current_Count_CAff;
		SELF.sanc_f01_Current_Count_CAff := 	sanc_f01_Current_Count_CAff;
		SELF.sanc_f14_Current_Count_CAff := 	sanc_f14_Current_Count_CAff;
		SELF.sanc_f15_Current_Count_CAff := 	sanc_f15_Current_Count_CAff;
		SELF.sanc_f02_24_Count_CAff := 	sanc_f02_24_Count_CAff;
		SELF.sanc_f05_24_Count_CAff := 	sanc_f05_24_Count_CAff;
		SELF.sanc_f06_24_Count_CAff := 	sanc_f06_24_Count_CAff;
		SELF.sanc_F07_24_Count_CAff := 	sanc_F07_24_Count_CAff;
		SELF.sanc_F08_24_Count_CAff := 	sanc_F08_24_Count_CAff;
		SELF.sanc_f11_24_Count_CAff := 	sanc_f11_24_Count_CAff;
		SELF.sanc_f19_24_Count_CAff := 	sanc_f19_24_Count_CAff;
		SELF.sanc_f20_24_Count_CAff := 	sanc_f20_24_Count_CAff;
		SELF.sanc_f21_24_Count_CAff := 	sanc_f21_24_Count_CAff;
		SELF.sanc_f22_24_Count_CAff := 	sanc_f22_24_Count_CAff;
		SELF.sanc_f23_24_Count_CAff := 	sanc_f23_24_Count_CAff;
		SELF.sanc_f24_24_Count_CAff := 	sanc_f24_24_Count_CAff;
		SELF.sanc_f25_24_Count_CAff := 	sanc_f25_24_Count_CAff;
		SELF.sanc_f12_24_Count_CAff := 	sanc_f12_24_Count_CAff;
		SELF.sanc_f16_24_Count_CAff := 	sanc_f16_24_Count_CAff;
		SELF.sanc_os_24_Count_CAff := 	sanc_os_24_Count_CAff;
		SELF.sanc_f03_24_Count_CAff := 	sanc_f03_24_Count_CAff;
		SELF.sanc_f04_24_Count_CAff := 	sanc_f04_24_Count_CAff;
		SELF.sanc_f09_24_Count_CAff := 	sanc_f09_24_Count_CAff;
		SELF.sanc_f10_24_Count_CAff := 	sanc_f10_24_Count_CAff;
		SELF.sanc_f13_24_Count_CAff := 	sanc_f13_24_Count_CAff;
		SELF.sanc_f17_24_Count_CAff := 	sanc_f17_24_Count_CAff;
		SELF.sanc_f18_24_Count_CAff := 	sanc_f18_24_Count_CAff;
		SELF.sanc_f26_24_Count_CAff := 	sanc_f26_24_Count_CAff;
		SELF.sanc_f01_24_Count_CAff := 	sanc_f01_24_Count_CAff;
		SELF.sanc_f14_24_Count_CAff := 	sanc_f14_24_Count_CAff;
		SELF.sanc_f15_24_Count_CAff := 	sanc_f15_24_Count_CAff;
		SELF.sanc_f02_60_Count_CAff := 	sanc_f02_60_Count_CAff;
		SELF.sanc_f05_60_Count_CAff := 	sanc_f05_60_Count_CAff;
		SELF.sanc_f06_60_Count_CAff := 	sanc_f06_60_Count_CAff;
		SELF.sanc_F07_60_Count_CAff := 	sanc_F07_60_Count_CAff;
		SELF.sanc_F08_60_Count_CAff := 	sanc_F08_60_Count_CAff;
		SELF.sanc_f11_60_Count_CAff := 	sanc_f11_60_Count_CAff;
		SELF.sanc_f19_60_Count_CAff := 	sanc_f19_60_Count_CAff;
		SELF.sanc_f20_60_Count_CAff := 	sanc_f20_60_Count_CAff;
		SELF.sanc_f21_60_Count_CAff := 	sanc_f21_60_Count_CAff;
		SELF.sanc_f22_60_Count_CAff := 	sanc_f22_60_Count_CAff;
		SELF.sanc_f23_60_Count_CAff := 	sanc_f23_60_Count_CAff;
		SELF.sanc_f24_60_Count_CAff := 	sanc_f24_60_Count_CAff;
		SELF.sanc_f25_60_Count_CAff := 	sanc_f25_60_Count_CAff;
		SELF.sanc_f12_60_Count_CAff := 	sanc_f12_60_Count_CAff;
		SELF.sanc_f16_60_Count_CAff := 	sanc_f16_60_Count_CAff;
		SELF.sanc_os_60_Count_CAff := 	sanc_os_60_Count_CAff;
		SELF.sanc_f03_60_Count_CAff := 	sanc_f03_60_Count_CAff;
		SELF.sanc_f04_60_Count_CAff := 	sanc_f04_60_Count_CAff;
		SELF.sanc_f09_60_Count_CAff := 	sanc_f09_60_Count_CAff;
		SELF.sanc_f10_60_Count_CAff := 	sanc_f10_60_Count_CAff;
		SELF.sanc_f13_60_Count_CAff := 	sanc_f13_60_Count_CAff;
		SELF.sanc_f17_60_Count_CAff := 	sanc_f17_60_Count_CAff;
		SELF.sanc_f18_60_Count_CAff := 	sanc_f18_60_Count_CAff;
		SELF.sanc_f26_60_Count_CAff := 	sanc_f26_60_Count_CAff;
		SELF.sanc_f01_60_Count_CAff := 	sanc_f01_60_Count_CAff;
		SELF.sanc_f14_60_Count_CAff := 	sanc_f14_60_Count_CAff;
		SELF.sanc_f15_60_Count_CAff := 	sanc_f15_60_Count_CAff;
		SELF.sanc_f02_61_Count_CAff := 	sanc_f02_61_Count_CAff;
		SELF.sanc_f05_61_Count_CAff := 	sanc_f05_61_Count_CAff;
		SELF.sanc_f06_61_Count_CAff := 	sanc_f06_61_Count_CAff;
		SELF.sanc_F07_61_Count_CAff := 	sanc_F07_61_Count_CAff;
		SELF.sanc_F08_61_Count_CAff := 	sanc_F08_61_Count_CAff;
		SELF.sanc_f11_61_Count_CAff := 	sanc_f11_61_Count_CAff;
		SELF.sanc_f19_61_Count_CAff := 	sanc_f19_61_Count_CAff;
		SELF.sanc_f20_61_Count_CAff := 	sanc_f20_61_Count_CAff;
		SELF.sanc_f21_61_Count_CAff := 	sanc_f21_61_Count_CAff;
		SELF.sanc_f22_61_Count_CAff := 	sanc_f22_61_Count_CAff;
		SELF.sanc_f23_61_Count_CAff := 	sanc_f23_61_Count_CAff;
		SELF.sanc_f24_61_Count_CAff := 	sanc_f24_61_Count_CAff;
		SELF.sanc_f25_61_Count_CAff := 	sanc_f25_61_Count_CAff;
		SELF.sanc_f12_61_Count_CAff := 	sanc_f12_61_Count_CAff;
		SELF.sanc_f16_61_Count_CAff := 	sanc_f16_61_Count_CAff;
		SELF.sanc_os_61_Count_CAff := 	sanc_os_61_Count_CAff;
		SELF.sanc_f03_61_Count_CAff := 	sanc_f03_61_Count_CAff;
		SELF.sanc_f04_61_Count_CAff := 	sanc_f04_61_Count_CAff;
		SELF.sanc_f09_61_Count_CAff := 	sanc_f09_61_Count_CAff;
		SELF.sanc_f10_61_Count_CAff := 	sanc_f10_61_Count_CAff;
		SELF.sanc_f13_61_Count_CAff := 	sanc_f13_61_Count_CAff;
		SELF.sanc_f17_61_Count_CAff := 	sanc_f17_61_Count_CAff;
		SELF.sanc_f18_61_Count_CAff := 	sanc_f18_61_Count_CAff;
		SELF.sanc_f26_61_Count_CAff := 	sanc_f26_61_Count_CAff;
		SELF.sanc_f01_61_Count_CAff := 	sanc_f01_61_Count_CAff;
		SELF.sanc_f14_61_Count_CAff := 	sanc_f14_61_Count_CAff;
		SELF.sanc_f15_61_Count_CAff := 	sanc_f15_61_Count_CAff;
		SELF.GSA_Prov_Recip_24_Curr_cnt := 	GSA_Prov_Recip_24_Curr_cnt;
		SELF.GSA_Prov_Recip_60_Curr_cnt := 	GSA_Prov_Recip_60_Curr_cnt;
		SELF.GSA_Prov_Recip_61_Curr_cnt := 	GSA_Prov_Recip_61_Curr_cnt;
		SELF.GSA_Prov_Proc_24_Curr_cnt := 	GSA_Prov_Proc_24_Curr_cnt;
		SELF.GSA_Prov_Proc_60_Curr_cnt := 	GSA_Prov_Proc_60_Curr_cnt;
		SELF.GSA_Prov_Proc_61_Curr_cnt := 	GSA_Prov_Proc_61_Curr_cnt;
		SELF.GSA_Prov_NonProc_24_Curr_cnt := 	GSA_Prov_NonProc_24_Curr_cnt;
		SELF.GSA_Prov_NonProc_60_Curr_cnt := 	GSA_Prov_NonProc_60_Curr_cnt;
		SELF.GSA_Prov_NonProc_61_Curr_cnt := 	GSA_Prov_NonProc_61_Curr_cnt;
		SELF.GSA_Prov_Recip_24_Old_cnt := 	GSA_Prov_Recip_24_Old_cnt;
		SELF.GSA_Prov_Recip_60_Old_cnt := 	GSA_Prov_Recip_60_Old_cnt;
		SELF.GSA_Prov_Recip_61_Old_cnt := 	GSA_Prov_Recip_61_Old_cnt;
		SELF.GSA_Prov_Proc_24_Old_cnt := 	GSA_Prov_Proc_24_Old_cnt;
		SELF.GSA_Prov_Proc_60_Old_cnt := 	GSA_Prov_Proc_60_Old_cnt;
		SELF.GSA_Prov_Proc_61_Old_cnt := 	GSA_Prov_Proc_61_Old_cnt;
		SELF.GSA_Prov_NonProc_24_Old_cnt := 	GSA_Prov_NonProc_24_Old_cnt;
		SELF.GSA_Prov_NonProc_60_Old_cnt := 	GSA_Prov_NonProc_60_Old_cnt;
		SELF.GSA_Prov_NonProc_61_Old_cnt := 	GSA_Prov_NonProc_61_Old_cnt;
		SELF.GSA_Bus_Recip_24_Curr_cnt := 	GSA_Bus_Recip_24_Curr_cnt;
		SELF.GSA_Bus_Recip_60_Curr_cnt := 	GSA_Bus_Recip_60_Curr_cnt;
		SELF.GSA_Bus_Recip_61_Curr_cnt := 	GSA_Bus_Recip_61_Curr_cnt;
		SELF.GSA_Bus_Proc_24_Curr_cnt := 	GSA_Bus_Proc_24_Curr_cnt;
		SELF.GSA_Bus_Proc_60_Curr_cnt := 	GSA_Bus_Proc_60_Curr_cnt;
		SELF.GSA_Bus_Proc_61_Curr_cnt := 	GSA_Bus_Proc_61_Curr_cnt;
		SELF.GSA_Bus_NonProc_24_Curr_cnt := 	GSA_Bus_NonProc_24_Curr_cnt;
		SELF.GSA_Bus_NonProc_60_Curr_cnt := 	GSA_Bus_NonProc_60_Curr_cnt;
		SELF.GSA_Bus_NonProc_61_Curr_cnt := 	GSA_Bus_NonProc_61_Curr_cnt;
		SELF.GSA_Bus_Recip_24_Old_cnt := 	GSA_Bus_Recip_24_Old_cnt;
		SELF.GSA_Bus_Recip_60_Old_cnt := 	GSA_Bus_Recip_60_Old_cnt;
		SELF.GSA_Bus_Recip_61_Old_cnt := 	GSA_Bus_Recip_61_Old_cnt;
		SELF.GSA_Bus_Proc_24_Old_cnt := 	GSA_Bus_Proc_24_Old_cnt;
		SELF.GSA_Bus_Proc_60_Old_cnt := 	GSA_Bus_Proc_60_Old_cnt;
		SELF.GSA_Bus_Proc_61_Old_cnt := 	GSA_Bus_Proc_61_Old_cnt;
		SELF.GSA_Bus_NonProc_24_Old_cnt := 	GSA_Bus_NonProc_24_Old_cnt;
		SELF.GSA_Bus_NonProc_60_Old_cnt := 	GSA_Bus_NonProc_60_Old_cnt;
		SELF.GSA_Bus_NonProc_61_Old_cnt := 	GSA_Bus_NonProc_61_Old_cnt;
		SELF.GSA_Prov_Recip_24_Curr_cnt_RAN := 	GSA_Prov_Recip_24_Curr_cnt_RAN;
		SELF.GSA_Prov_Recip_60_Curr_cnt_RAN := 	GSA_Prov_Recip_60_Curr_cnt_RAN;
		SELF.GSA_Prov_Recip_61_Curr_cnt_RAN := 	GSA_Prov_Recip_61_Curr_cnt_RAN;
		SELF.GSA_Prov_Proc_24_Curr_cnt_RAN := 	GSA_Prov_Proc_24_Curr_cnt_RAN;
		SELF.GSA_Prov_Proc_60_Curr_cnt_RAN := 	GSA_Prov_Proc_60_Curr_cnt_RAN;
		SELF.GSA_Prov_Proc_61_Curr_cnt_RAN := 	GSA_Prov_Proc_61_Curr_cnt_RAN;
		SELF.GSA_Prov_NonProc_24_Curr_cnt_RAN := 	GSA_Prov_NonProc_24_Curr_cnt_RAN;
		SELF.GSA_Prov_NonProc_60_Curr_cnt_RAN := 	GSA_Prov_NonProc_60_Curr_cnt_RAN;
		SELF.GSA_Prov_NonProc_61_Curr_cnt_RAN := 	GSA_Prov_NonProc_61_Curr_cnt_RAN;
		SELF.GSA_Prov_Recip_24_Old_cnt_RAN := 	GSA_Prov_Recip_24_Old_cnt_RAN;
		SELF.GSA_Prov_Recip_60_Old_cnt_RAN := 	GSA_Prov_Recip_60_Old_cnt_RAN;
		SELF.GSA_Prov_Recip_61_Old_cnt_RAN := 	GSA_Prov_Recip_61_Old_cnt_RAN;
		SELF.GSA_Prov_Proc_24_Old_cnt_RAN := 	GSA_Prov_Proc_24_Old_cnt_RAN;
		SELF.GSA_Prov_Proc_60_Old_cnt_RAN := 	GSA_Prov_Proc_60_Old_cnt_RAN;
		SELF.GSA_Prov_Proc_61_Old_cnt_RAN := 	GSA_Prov_Proc_61_Old_cnt_RAN;
		SELF.GSA_Prov_NonProc_24_Old_cnt_RAN := 	GSA_Prov_NonProc_24_Old_cnt_RAN;
		SELF.GSA_Prov_NonProc_60_Old_cnt_RAN := 	GSA_Prov_NonProc_60_Old_cnt_RAN;
		SELF.GSA_Prov_NonProc_61_Old_cnt_RAN := 	GSA_Prov_NonProc_61_Old_cnt_RAN;
		SELF.GSA_CAff_Recip_24_Curr_cnt := 	GSA_CAff_Recip_24_Curr_cnt;
		SELF.GSA_CAff_Recip_60_Curr_cnt := 	GSA_CAff_Recip_60_Curr_cnt;
		SELF.GSA_CAff_Recip_61_Curr_cnt := 	GSA_CAff_Recip_61_Curr_cnt;
		SELF.GSA_CAff_Proc_24_Curr_cnt := 	GSA_CAff_Proc_24_Curr_cnt;
		SELF.GSA_CAff_Proc_60_Curr_cnt := 	GSA_CAff_Proc_60_Curr_cnt;
		SELF.GSA_CAff_Proc_61_Curr_cnt := 	GSA_CAff_Proc_61_Curr_cnt;
		SELF.GSA_CAff_NonProc_24_Curr_cnt := 	GSA_CAff_NonProc_24_Curr_cnt;
		SELF.GSA_CAff_NonProc_60_Curr_cnt := 	GSA_CAff_NonProc_60_Curr_cnt;
		SELF.GSA_CAff_NonProc_61_Curr_cnt := 	GSA_CAff_NonProc_61_Curr_cnt;
		SELF.GSA_CAff_Recip_24_Old_cnt := 	GSA_CAff_Recip_24_Old_cnt;
		SELF.GSA_CAff_Recip_60_Old_cnt := 	GSA_CAff_Recip_60_Old_cnt;
		SELF.GSA_CAff_Recip_61_Old_cnt := 	GSA_CAff_Recip_61_Old_cnt;
		SELF.GSA_CAff_Proc_24_Old_cnt := 	GSA_CAff_Proc_24_Old_cnt;
		SELF.GSA_CAff_Proc_60_Old_cnt := 	GSA_CAff_Proc_60_Old_cnt;
		SELF.GSA_CAff_Proc_61_Old_cnt := 	GSA_CAff_Proc_61_Old_cnt;
		SELF.GSA_CAff_NonProc_24_Old_cnt := 	GSA_CAff_NonProc_24_Old_cnt;
		SELF.GSA_CAff_NonProc_60_Old_cnt := 	GSA_CAff_NonProc_60_Old_cnt;
		SELF.GSA_CAff_NonProc_61_Old_cnt := 	GSA_CAff_NonProc_61_Old_cnt;
		SELF.GSA_RANCAff_Recip_24_Curr_cnt := 	GSA_RANCAff_Recip_24_Curr_cnt;
		SELF.GSA_RANCAff_Recip_60_Curr_cnt := 	GSA_RANCAff_Recip_60_Curr_cnt;
		SELF.GSA_RANCAff_Recip_61_Curr_cnt := 	GSA_RANCAff_Recip_61_Curr_cnt;
		SELF.GSA_RANCAff_Proc_24_Curr_cnt := 	GSA_RANCAff_Proc_24_Curr_cnt;
		SELF.GSA_RANCAff_Proc_60_Curr_cnt := 	GSA_RANCAff_Proc_60_Curr_cnt;
		SELF.GSA_RANCAff_Proc_61_Curr_cnt := 	GSA_RANCAff_Proc_61_Curr_cnt;
		SELF.GSA_RANCAff_NonProc_24_Curr_cnt := 	GSA_RANCAff_NonProc_24_Curr_cnt;
		SELF.GSA_RANCAff_NonProc_60_Curr_cnt := 	GSA_RANCAff_NonProc_60_Curr_cnt;
		SELF.GSA_RANCAff_NonProc_61_Curr_cnt := 	GSA_RANCAff_NonProc_61_Curr_cnt;
		SELF.GSA_RANCAff_Recip_24_Old_cnt := 	GSA_RANCAff_Recip_24_Old_cnt;
		SELF.GSA_RANCAff_Recip_60_Old_cnt := 	GSA_RANCAff_Recip_60_Old_cnt;
		SELF.GSA_RANCAff_Recip_61_Old_cnt := 	GSA_RANCAff_Recip_61_Old_cnt;
		SELF.GSA_RANCAff_Proc_24_Old_cnt := 	GSA_RANCAff_Proc_24_Old_cnt;
		SELF.GSA_RANCAff_Proc_60_Old_cnt := 	GSA_RANCAff_Proc_60_Old_cnt;
		SELF.GSA_RANCAff_Proc_61_Old_cnt := 	GSA_RANCAff_Proc_61_Old_cnt;
		SELF.GSA_RANCAff_NonProc_24_Old_cnt := 	GSA_RANCAff_NonProc_24_Old_cnt;
		SELF.GSA_RANCAff_NonProc_60_Old_cnt := 	GSA_RANCAff_NonProc_60_Old_cnt;
		SELF.GSA_RANCAff_NonProc_61_Old_cnt := 	GSA_RANCAff_NonProc_61_Old_cnt;
		SELF.JGMT_Foreclosure_Count_24 := 	JGMT_Foreclosure_Count_24;
		SELF.JGMT_Forcible_Entry_Count_24 := 	JGMT_Forcible_Entry_Count_24;
		SELF.JGMT_Lien_Other_Count_24 := 	JGMT_Lien_Other_Count_24;
		SELF.JGMT_Tax_Lien_Count_24 := 	JGMT_Tax_Lien_Count_24;
		SELF.JGMT_Landlord_Tenant_Count_24 := 	JGMT_Landlord_Tenant_Count_24;
		SELF.JGMT_Civil_Judgment_Count_24 := 	JGMT_Civil_Judgment_Count_24;
		SELF.JGMT_Child_Support_Count_24 := 	JGMT_Child_Support_Count_24;
		SELF.JGMT_Small_Claims_Count_24 := 	JGMT_Small_Claims_Count_24;
		SELF.JGMT_Judgment_Other_Count_24 := 	JGMT_Judgment_Other_Count_24;
		SELF.JGMT_Lawsuit_Pending_Count_24 := 	JGMT_Lawsuit_Pending_Count_24;
		SELF.JGMT_Other_Count_24 := 	JGMT_Other_Count_24;
		SELF.JGMT_Foreclosure_Count_60 := 	JGMT_Foreclosure_Count_60;
		SELF.JGMT_Forcible_Entry_Count_60 := 	JGMT_Forcible_Entry_Count_60;
		SELF.JGMT_Lien_Other_Count_60 := 	JGMT_Lien_Other_Count_60;
		SELF.JGMT_Tax_Lien_Count_60 := 	JGMT_Tax_Lien_Count_60;
		SELF.JGMT_Landlord_Tenant_Count_60 := 	JGMT_Landlord_Tenant_Count_60;
		SELF.JGMT_Civil_Judgment_Count_60 := 	JGMT_Civil_Judgment_Count_60;
		SELF.JGMT_Child_Support_Count_60 := 	JGMT_Child_Support_Count_60;
		SELF.JGMT_Small_Claims_Count_60 := 	JGMT_Small_Claims_Count_60;
		SELF.JGMT_Judgment_Other_Count_60 := 	JGMT_Judgment_Other_Count_60;
		SELF.JGMT_Lawsuit_Pending_Count_60 := 	JGMT_Lawsuit_Pending_Count_60;
		SELF.JGMT_Other_Count_60 := 	JGMT_Other_Count_60;
		SELF.JGMT_Foreclosure_Count_61 := 	JGMT_Foreclosure_Count_61;
		SELF.JGMT_Forcible_Entry_Count_61 := 	JGMT_Forcible_Entry_Count_61;
		SELF.JGMT_Lien_Other_Count_61 := 	JGMT_Lien_Other_Count_61;
		SELF.JGMT_Tax_Lien_Count_61 := 	JGMT_Tax_Lien_Count_61;
		SELF.JGMT_Landlord_Tenant_Count_61 := 	JGMT_Landlord_Tenant_Count_61;
		SELF.JGMT_Civil_Judgment_Count_61 := 	JGMT_Civil_Judgment_Count_61;
		SELF.JGMT_Child_Support_Count_61 := 	JGMT_Child_Support_Count_61;
		SELF.JGMT_Small_Claims_Count_61 := 	JGMT_Small_Claims_Count_61;
		SELF.JGMT_Judgment_Other_Count_61 := 	JGMT_Judgment_Other_Count_61;
		SELF.JGMT_Lawsuit_Pending_Count_61 := 	JGMT_Lawsuit_Pending_Count_61;
		SELF.JGMT_Other_Count_61 := 	JGMT_Other_Count_61;
		SELF.JGMT_Foreclosure_Count_ND := 	JGMT_Foreclosure_Count_ND;
		SELF.JGMT_Forcible_Entry_Count_ND := 	JGMT_Forcible_Entry_Count_ND;
		SELF.JGMT_Lien_Other_Count_ND := 	JGMT_Lien_Other_Count_ND;
		SELF.JGMT_Tax_Lien_Count_ND := 	JGMT_Tax_Lien_Count_ND;
		SELF.JGMT_Landlord_Tenant_Count_ND := 	JGMT_Landlord_Tenant_Count_ND;
		SELF.JGMT_Civil_Judgment_Count_ND := 	JGMT_Civil_Judgment_Count_ND;
		SELF.JGMT_Child_Support_Count_ND := 	JGMT_Child_Support_Count_ND;
		SELF.JGMT_Small_Claims_Count_ND := 	JGMT_Small_Claims_Count_ND;
		SELF.JGMT_Judgment_Other_Count_ND := 	JGMT_Judgment_Other_Count_ND;
		SELF.JGMT_Lawsuit_Pending_Count_ND := 	JGMT_Lawsuit_Pending_Count_ND;
		SELF.JGMT_Other_Count_ND := 	JGMT_Other_Count_ND;
		SELF.JGMT_Eviction_Flag_Count := 	JGMT_Eviction_Flag_Count;
		SELF.Crim_Red_Misc_cnt_24 := 	Crim_Red_Misc_cnt_24;
		SELF.crim_Assault_cnt_24 := 	crim_Assault_cnt_24;
		SELF.crim_Weapon_cnt_24 := 	crim_Weapon_cnt_24;
		SELF.crim_Murder_cnt_24 := 	crim_Murder_cnt_24;
		SELF.crim_Child_Abuse_cnt_24 := 	crim_Child_Abuse_cnt_24;
		SELF.crim_Forgery_cnt_24 := 	crim_Forgery_cnt_24;
		SELF.crim_Theft_cnt_24 := 	crim_Theft_cnt_24;
		SELF.crim_Fraud_cnt_24 := 	crim_Fraud_cnt_24;
		SELF.crim_Robbery_cnt_24 := 	crim_Robbery_cnt_24;
		SELF.crim_Break_Enter_cnt_24 := 	crim_Break_Enter_cnt_24;
		SELF.crim_Burg_cnt_24 := 	crim_Burg_cnt_24;
		SELF.crim_Harassment_cnt_24 := 	crim_Harassment_cnt_24;
		SELF.crim_DWLS_cnt_24 := 	crim_DWLS_cnt_24;
		SELF.crim_DUI_cnt_24 := 	crim_DUI_cnt_24;
		SELF.crim_Cont_Subst_cnt_24 := 	crim_Cont_Subst_cnt_24;
		SELF.crim_Sex_Crime_cnt_24 := 	crim_Sex_Crime_cnt_24;
		SELF.crim_Felony_cnt_24 := 	crim_Felony_cnt_24;
		SELF.crim_Other_cnt_24 := 	crim_Other_cnt_24;
		SELF.crim_Traffic_cnt_24 := 	crim_Traffic_cnt_24;
		SELF.crim_Parking_cnt_24 := 	crim_Parking_cnt_24;
		SELF.crim_Misdemeanor_cnt_24 := 	crim_Misdemeanor_cnt_24;
		SELF.crim_Prop_Dmg_cnt_24 := 	crim_Prop_Dmg_cnt_24;
		SELF.crim_Disorderly_cnt_24 := 	crim_Disorderly_cnt_24;
		SELF.crim_Trespassing_cnt_24 := 	crim_Trespassing_cnt_24;
		SELF.crim_Alcohol_cnt_24 := 	crim_Alcohol_cnt_24;
		SELF.crim_Res_Arrest_cnt_24 := 	crim_Res_Arrest_cnt_24;
		SELF.crim_Bad_Check_cnt_24 := 	crim_Bad_Check_cnt_24;
		SELF.Crim_Red_Misc_cnt_60 := 	Crim_Red_Misc_cnt_60;
		SELF.crim_Assault_cnt_60 := 	crim_Assault_cnt_60;
		SELF.crim_Weapon_cnt_60 := 	crim_Weapon_cnt_60;
		SELF.crim_Murder_cnt_60 := 	crim_Murder_cnt_60;
		SELF.crim_Child_Abuse_cnt_60 := 	crim_Child_Abuse_cnt_60;
		SELF.crim_Forgery_cnt_60 := 	crim_Forgery_cnt_60;
		SELF.crim_Theft_cnt_60 := 	crim_Theft_cnt_60;
		SELF.crim_Fraud_cnt_60 := 	crim_Fraud_cnt_60;
		SELF.crim_Robbery_cnt_60 := 	crim_Robbery_cnt_60;
		SELF.crim_Break_Enter_cnt_60 := 	crim_Break_Enter_cnt_60;
		SELF.crim_Burg_cnt_60 := 	crim_Burg_cnt_60;
		SELF.crim_Harassment_cnt_60 := 	crim_Harassment_cnt_60;
		SELF.crim_DWLS_cnt_60 := 	crim_DWLS_cnt_60;
		SELF.crim_DUI_cnt_60 := 	crim_DUI_cnt_60;
		SELF.crim_Cont_Subst_cnt_60 := 	crim_Cont_Subst_cnt_60;
		SELF.crim_Sex_Crime_cnt_60 := 	crim_Sex_Crime_cnt_60;
		SELF.crim_Felony_cnt_60 := 	crim_Felony_cnt_60;
		SELF.crim_Other_cnt_60 := 	crim_Other_cnt_60;
		SELF.crim_Traffic_cnt_60 := 	crim_Traffic_cnt_60;
		SELF.crim_Parking_cnt_60 := 	crim_Parking_cnt_60;
		SELF.crim_Misdemeanor_cnt_60 := 	crim_Misdemeanor_cnt_60;
		SELF.crim_Prop_Dmg_cnt_60 := 	crim_Prop_Dmg_cnt_60;
		SELF.crim_Disorderly_cnt_60 := 	crim_Disorderly_cnt_60;
		SELF.crim_Trespassing_cnt_60 := 	crim_Trespassing_cnt_60;
		SELF.crim_Alcohol_cnt_60 := 	crim_Alcohol_cnt_60;
		SELF.crim_Res_Arrest_cnt_60 := 	crim_Res_Arrest_cnt_60;
		SELF.crim_Bad_Check_cnt_60 := 	crim_Bad_Check_cnt_60;
		SELF.Crim_Red_Misc_cnt_61 := 	Crim_Red_Misc_cnt_61;
		SELF.crim_Assault_cnt_61 := 	crim_Assault_cnt_61;
		SELF.crim_Weapon_cnt_61 := 	crim_Weapon_cnt_61;
		SELF.crim_Murder_cnt_61 := 	crim_Murder_cnt_61;
		SELF.crim_Child_Abuse_cnt_61 := 	crim_Child_Abuse_cnt_61;
		SELF.crim_Forgery_cnt_61 := 	crim_Forgery_cnt_61;
		SELF.crim_Theft_cnt_61 := 	crim_Theft_cnt_61;
		SELF.crim_Fraud_cnt_61 := 	crim_Fraud_cnt_61;
		SELF.crim_Robbery_cnt_61 := 	crim_Robbery_cnt_61;
		SELF.crim_Break_Enter_cnt_61 := 	crim_Break_Enter_cnt_61;
		SELF.crim_Burg_cnt_61 := 	crim_Burg_cnt_61;
		SELF.crim_Harassment_cnt_61 := 	crim_Harassment_cnt_61;
		SELF.crim_DWLS_cnt_61 := 	crim_DWLS_cnt_61;
		SELF.crim_DUI_cnt_61 := 	crim_DUI_cnt_61;
		SELF.crim_Cont_Subst_cnt_61 := 	crim_Cont_Subst_cnt_61;
		SELF.crim_Sex_Crime_cnt_61 := 	crim_Sex_Crime_cnt_61;
		SELF.crim_Felony_cnt_61 := 	crim_Felony_cnt_61;
		SELF.crim_Other_cnt_61 := 	crim_Other_cnt_61;
		SELF.crim_Traffic_cnt_61 := 	crim_Traffic_cnt_61;
		SELF.crim_Parking_cnt_61 := 	crim_Parking_cnt_61;
		SELF.crim_Misdemeanor_cnt_61 := 	crim_Misdemeanor_cnt_61;
		SELF.crim_Prop_Dmg_cnt_61 := 	crim_Prop_Dmg_cnt_61;
		SELF.crim_Disorderly_cnt_61 := 	crim_Disorderly_cnt_61;
		SELF.crim_Trespassing_cnt_61 := 	crim_Trespassing_cnt_61;
		SELF.crim_Alcohol_cnt_61 := 	crim_Alcohol_cnt_61;
		SELF.crim_Res_Arrest_cnt_61 := 	crim_Res_Arrest_cnt_61;
		SELF.crim_Bad_Check_cnt_61 := 	crim_Bad_Check_cnt_61;
		SELF.Crim_Red_Misc_cnt_121 := 	Crim_Red_Misc_cnt_121;
		SELF.crim_Assault_cnt_121 := 	crim_Assault_cnt_121;
		SELF.crim_Weapon_cnt_121 := 	crim_Weapon_cnt_121;
		SELF.crim_Murder_cnt_121 := 	crim_Murder_cnt_121;
		SELF.crim_Child_Abuse_cnt_121 := 	crim_Child_Abuse_cnt_121;
		SELF.crim_Forgery_cnt_121 := 	crim_Forgery_cnt_121;
		SELF.crim_Theft_cnt_121 := 	crim_Theft_cnt_121;
		SELF.crim_Fraud_cnt_121 := 	crim_Fraud_cnt_121;
		SELF.crim_Robbery_cnt_121 := 	crim_Robbery_cnt_121;
		SELF.crim_Break_Enter_cnt_121 := 	crim_Break_Enter_cnt_121;
		SELF.crim_Burg_cnt_121 := 	crim_Burg_cnt_121;
		SELF.crim_Harassment_cnt_121 := 	crim_Harassment_cnt_121;
		SELF.crim_DWLS_cnt_121 := 	crim_DWLS_cnt_121;
		SELF.crim_DUI_cnt_121 := 	crim_DUI_cnt_121;
		SELF.crim_Cont_Subst_cnt_121 := 	crim_Cont_Subst_cnt_121;
		SELF.crim_Sex_Crime_cnt_121 := 	crim_Sex_Crime_cnt_121;
		SELF.crim_Felony_cnt_121 := 	crim_Felony_cnt_121;
		SELF.crim_Other_cnt_121 := 	crim_Other_cnt_121;
		SELF.crim_Traffic_cnt_121 := 	crim_Traffic_cnt_121;
		SELF.crim_Parking_cnt_121 := 	crim_Parking_cnt_121;
		SELF.crim_Misdemeanor_cnt_121 := 	crim_Misdemeanor_cnt_121;
		SELF.crim_Prop_Dmg_cnt_121 := 	crim_Prop_Dmg_cnt_121;
		SELF.crim_Disorderly_cnt_121 := 	crim_Disorderly_cnt_121;
		SELF.crim_Trespassing_cnt_121 := 	crim_Trespassing_cnt_121;
		SELF.crim_Alcohol_cnt_121 := 	crim_Alcohol_cnt_121;
		SELF.crim_Res_Arrest_cnt_121 := 	crim_Res_Arrest_cnt_121;
		SELF.crim_Bad_Check_cnt_121 := 	crim_Bad_Check_cnt_121;
		SELF.crim_RAN_Red_Misc_cnt_24 := 	crim_RAN_Red_Misc_cnt_24;
		SELF.crim_RAN_Assault_cnt_24 := 	crim_RAN_Assault_cnt_24;
		SELF.crim_RAN_Weapon_cnt_24 := 	crim_RAN_Weapon_cnt_24;
		SELF.crim_RAN_Murder_cnt_24 := 	crim_RAN_Murder_cnt_24;
		SELF.crim_RAN_Child_Abuse_cnt_24 := 	crim_RAN_Child_Abuse_cnt_24;
		SELF.crim_RAN_Forgery_cnt_24 := 	crim_RAN_Forgery_cnt_24;
		SELF.crim_RAN_Theft_cnt_24 := 	crim_RAN_Theft_cnt_24;
		SELF.crim_RAN_Fraud_cnt_24 := 	crim_RAN_Fraud_cnt_24;
		SELF.crim_RAN_Robbery_cnt_24 := 	crim_RAN_Robbery_cnt_24;
		SELF.crim_RAN_Break_Enter_cnt_24 := 	crim_RAN_Break_Enter_cnt_24;
		SELF.crim_RAN_Burg_cnt_24 := 	crim_RAN_Burg_cnt_24;
		SELF.crim_RAN_Harassment_cnt_24 := 	crim_RAN_Harassment_cnt_24;
		SELF.crim_RAN_DWLS_cnt_24 := 	crim_RAN_DWLS_cnt_24;
		SELF.crim_RAN_DUI_cnt_24 := 	crim_RAN_DUI_cnt_24;
		SELF.crim_RAN_Cont_Subst_cnt_24 := 	crim_RAN_Cont_Subst_cnt_24;
		SELF.crim_RAN_Sex_Crime_cnt_24 := 	crim_RAN_Sex_Crime_cnt_24;
		SELF.crim_RAN_Felony_cnt_24 := 	crim_RAN_Felony_cnt_24;
		SELF.crim_RAN_Red_Misc_cnt_60 := 	crim_RAN_Red_Misc_cnt_60;
		SELF.crim_RAN_Assault_cnt_60 := 	crim_RAN_Assault_cnt_60;
		SELF.crim_RAN_Weapon_cnt_60 := 	crim_RAN_Weapon_cnt_60;
		SELF.crim_RAN_Murder_cnt_60 := 	crim_RAN_Murder_cnt_60;
		SELF.crim_RAN_Child_Abuse_cnt_60 := 	crim_RAN_Child_Abuse_cnt_60;
		SELF.crim_RAN_Forgery_cnt_60 := 	crim_RAN_Forgery_cnt_60;
		SELF.crim_RAN_Theft_cnt_60 := 	crim_RAN_Theft_cnt_60;
		SELF.crim_RAN_Fraud_cnt_60 := 	crim_RAN_Fraud_cnt_60;
		SELF.crim_RAN_Robbery_cnt_60 := 	crim_RAN_Robbery_cnt_60;
		SELF.crim_RAN_Break_Enter_cnt_60 := 	crim_RAN_Break_Enter_cnt_60;
		SELF.crim_RAN_Burg_cnt_60 := 	crim_RAN_Burg_cnt_60;
		SELF.crim_RAN_Harassment_cnt_60 := 	crim_RAN_Harassment_cnt_60;
		SELF.crim_RAN_DWLS_cnt_60 := 	crim_RAN_DWLS_cnt_60;
		SELF.crim_RAN_DUI_cnt_60 := 	crim_RAN_DUI_cnt_60;
		SELF.crim_RAN_Cont_Subst_cnt_60 := 	crim_RAN_Cont_Subst_cnt_60;
		SELF.crim_RAN_Sex_Crime_cnt_60 := 	crim_RAN_Sex_Crime_cnt_60;
		SELF.crim_RAN_Felony_cnt_60 := 	crim_RAN_Felony_cnt_60;
		SELF.crim_RAN_Red_Misc_cnt_61 := 	crim_RAN_Red_Misc_cnt_61;
		SELF.crim_RAN_Assault_cnt_61 := 	crim_RAN_Assault_cnt_61;
		SELF.crim_RAN_Weapon_cnt_61 := 	crim_RAN_Weapon_cnt_61;
		SELF.crim_RAN_Murder_cnt_61 := 	crim_RAN_Murder_cnt_61;
		SELF.crim_RAN_Child_Abuse_cnt_61 := 	crim_RAN_Child_Abuse_cnt_61;
		SELF.crim_RAN_Forgery_cnt_61 := 	crim_RAN_Forgery_cnt_61;
		SELF.crim_RAN_Theft_cnt_61 := 	crim_RAN_Theft_cnt_61;
		SELF.crim_RAN_Fraud_cnt_61 := 	crim_RAN_Fraud_cnt_61;
		SELF.crim_RAN_Robbery_cnt_61 := 	crim_RAN_Robbery_cnt_61;
		SELF.crim_RAN_Break_Enter_cnt_61 := 	crim_RAN_Break_Enter_cnt_61;
		SELF.crim_RAN_Burg_cnt_61 := 	crim_RAN_Burg_cnt_61;
		SELF.crim_RAN_Harassment_cnt_61 := 	crim_RAN_Harassment_cnt_61;
		SELF.crim_RAN_DWLS_cnt_61 := 	crim_RAN_DWLS_cnt_61;
		SELF.crim_RAN_DUI_cnt_61 := 	crim_RAN_DUI_cnt_61;
		SELF.crim_RAN_Cont_Subst_cnt_61 := 	crim_RAN_Cont_Subst_cnt_61;
		SELF.crim_RAN_Sex_Crime_cnt_61 := 	crim_RAN_Sex_Crime_cnt_61;
		SELF.crim_RAN_Felony_cnt_61 := 	crim_RAN_Felony_cnt_61;
		SELF.crim_RAN_Red_Misc_cnt_121 := 	crim_RAN_Red_Misc_cnt_121;
		SELF.crim_RAN_Assault_cnt_121 := 	crim_RAN_Assault_cnt_121;
		SELF.crim_RAN_Weapon_cnt_121 := 	crim_RAN_Weapon_cnt_121;
		SELF.crim_RAN_Murder_cnt_121 := 	crim_RAN_Murder_cnt_121;
		SELF.crim_RAN_Child_Abuse_cnt_121 := 	crim_RAN_Child_Abuse_cnt_121;
		SELF.crim_RAN_Forgery_cnt_121 := 	crim_RAN_Forgery_cnt_121;
		SELF.crim_RAN_Theft_cnt_121 := 	crim_RAN_Theft_cnt_121;
		SELF.crim_RAN_Fraud_cnt_121 := 	crim_RAN_Fraud_cnt_121;
		SELF.crim_RAN_Robbery_cnt_121 := 	crim_RAN_Robbery_cnt_121;
		SELF.crim_RAN_Break_Enter_cnt_121 := 	crim_RAN_Break_Enter_cnt_121;
		SELF.crim_RAN_Burg_cnt_121 := 	crim_RAN_Burg_cnt_121;
		SELF.crim_RAN_Harassment_cnt_121 := 	crim_RAN_Harassment_cnt_121;
		SELF.crim_RAN_DWLS_cnt_121 := 	crim_RAN_DWLS_cnt_121;
		SELF.crim_RAN_DUI_cnt_121 := 	crim_RAN_DUI_cnt_121;
		SELF.crim_RAN_Cont_Subst_cnt_121 := 	crim_RAN_Cont_Subst_cnt_121;
		SELF.crim_RAN_Sex_Crime_cnt_121 := 	crim_RAN_Sex_Crime_cnt_121;
		SELF.crim_RAN_Felony_cnt_121 := 	crim_RAN_Felony_cnt_121;
		SELF.Crim_WC_Count := 	Crim_WC_Count;
		SELF.Crim_WC_Misdemeanor_Count := 	Crim_WC_Misdemeanor_Count;
		SELF.Crim_WC_Felony_Count := 	Crim_WC_Felony_Count;
		SELF.Crim_WC_SexCrime_Count := 	Crim_WC_SexCrime_Count;
		SELF.JGMT_Sum := 	JGMT_Sum;
		SELF.JGMT_Flag_Count := 	JGMT_Flag_Count;
		SELF.GSA_Provider_Current_Flag := 	GSA_Provider_Current_Flag;
		SELF.GSA_Business_Current_Flag := 	GSA_Business_Current_Flag;
		SELF.GSA_Provider_Old_Flag := 	GSA_Provider_Old_Flag;
		SELF.GSA_Business_Old_Flag := 	GSA_Business_Old_Flag;
		SELF.Crim_RAN_WC_Felony_Count := 	Crim_RAN_WC_Felony_Count;
		SELF.Crim_RAN_WC_Misd_Count := 	Crim_RAN_WC_Misd_Count;
		
		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.header_first_seen2 := header_first_seen2;
		SELF.mth_header_first_seen := mth_header_first_seen;
		SELF.date_last_seen2 := date_last_seen2;
		SELF.mth_date_last_seen := mth_date_last_seen;
		SELF.ver_src_ak_pos := ver_src_ak_pos;
		SELF.ver_src_ak := ver_src_ak;
		SELF.ver_src_am_pos := ver_src_am_pos;
		SELF.ver_src_am := ver_src_am;
		SELF.ver_src_ar_pos := ver_src_ar_pos;
		SELF.ver_src_ar := ver_src_ar;
		SELF.ver_src_cg_pos := ver_src_cg_pos;
		SELF.ver_src_cg := ver_src_cg;
		SELF.ver_src_ds_pos := ver_src_ds_pos;
		SELF.ver_src_ds := ver_src_ds;
		SELF.ver_src_eb_pos := ver_src_eb_pos;
		SELF.ver_src_eb := ver_src_eb;
		SELF.ver_src_em_pos := ver_src_em_pos;
		SELF.ver_src_em := ver_src_em;
		SELF.ver_src_e1_pos := ver_src_e1_pos;
		SELF.ver_src_e1 := ver_src_e1;
		SELF.ver_src_e2_pos := ver_src_e2_pos;
		SELF.ver_src_e2 := ver_src_e2;
		SELF.ver_src_e3_pos := ver_src_e3_pos;
		SELF.ver_src_e3 := ver_src_e3;
		SELF.ver_src_e4_pos := ver_src_e4_pos;
		SELF.ver_src_e4 := ver_src_e4;
		SELF.ver_src_en_pos := ver_src_en_pos;
		SELF.ver_src_en := ver_src_en;
		SELF.ver_src_eq_pos := ver_src_eq_pos;
		SELF.ver_src_eq := ver_src_eq;
		SELF.ver_src_fr_pos := ver_src_fr_pos;
		SELF.ver_src_nas_fr := ver_src_nas_fr;
		SELF.ver_src_pl_pos := ver_src_pl_pos;
		SELF.ver_src_pl := ver_src_pl;
		SELF.ver_src_vo_pos := ver_src_vo_pos;
		SELF.ver_src_vo := ver_src_vo;
		SELF.ver_src_w_pos := ver_src_w_pos;
		SELF.ver_src_w := ver_src_w;
		SELF.ver_src_wp_pos := ver_src_wp_pos;
		SELF.ver_src_wp := ver_src_wp;
		SELF.ver_src_tn_pos := ver_src_tn_pos;
		SELF.ver_src_tn := ver_src_tn;
		SELF.ver_fname_src_ds_pos := ver_fname_src_ds_pos;
		SELF.ver_fname_src_ds := ver_fname_src_ds;
		SELF.ver_fname_src_de_pos := ver_fname_src_de_pos;
		SELF.ver_fname_src_de := ver_fname_src_de;
		SELF.ver_lname_src_ds_pos := ver_lname_src_ds_pos;
		SELF.ver_lname_src_ds := ver_lname_src_ds;
		SELF.ver_lname_src_de_pos := ver_lname_src_de_pos;
		SELF.ver_lname_src_de := ver_lname_src_de;
		SELF.ver_addr_src_ds_pos := ver_addr_src_ds_pos;
		SELF.ver_addr_src_ds := ver_addr_src_ds;
		SELF.ver_addr_src_de_pos := ver_addr_src_de_pos;
		SELF.ver_addr_src_de := ver_addr_src_de;
		SELF.ver_ssn_src_ds_pos := ver_ssn_src_ds_pos;
		SELF.ver_ssn_src_ds := ver_ssn_src_ds;
		SELF.ver_ssn_src_de_pos := ver_ssn_src_de_pos;
		SELF.ver_ssn_src_de := ver_ssn_src_de;
		SELF.email_src_im_pos := email_src_im_pos;
		SELF.email_src_im := email_src_im;
		SELF.verfst_s := verfst_s;
		SELF.verlst_s := verlst_s;
		SELF.verssn_s := verssn_s;
		SELF.add_pobox_1 := add_pobox_1;
		SELF.phn_disconnected := phn_disconnected;
		SELF.phn_highrisk_1 := phn_highrisk_1;
		SELF.ssnpop := ssnpop;
		SELF.ssn_priordob_1 := ssn_priordob_1;
		SELF.ssn_inval_1 := ssn_inval_1;
		SELF.ssn_deceased_1 := ssn_deceased_1;
		SELF.impulse_flag := impulse_flag;
		SELF.lien_rec_unrel_flag := lien_rec_unrel_flag;
		SELF.lien_hist_unrel_flag := lien_hist_unrel_flag;
		SELF.did_found := did_found;
		SELF.pk_disconnected_1 := pk_disconnected_1;
		SELF.pk_addinval_1 := pk_addinval_1;
		SELF.pk_num_elements_ver := pk_num_elements_ver;
		SELF.pk_num_elements_pop := pk_num_elements_pop;
		SELF.pk_rc_numelever_0_2 := pk_rc_numelever_0_2;
		SELF.pk_rc_numelever_2_2 := pk_rc_numelever_2_2;
		SELF.pk_rc_numelever_34_3 := pk_rc_numelever_34_3;
		SELF.pk_rc_numelever_5_3 := pk_rc_numelever_5_3;
		SELF.pk_rc_numelever_6_3 := pk_rc_numelever_6_3;
		SELF.pk_rc_numelever_partial_3 := pk_rc_numelever_partial_3;
		SELF.pk_rc_numelever_5_c463 := pk_rc_numelever_5_c463;
		SELF.pk_rc_numelever_6_c463 := pk_rc_numelever_6_c463;
		SELF.pk_rc_numelever_34_c463 := pk_rc_numelever_34_c463;
		SELF.pk_rc_numelever_2_c464 := pk_rc_numelever_2_c464;
		SELF.pk_rc_numelever_partial_c464 := pk_rc_numelever_partial_c464;
		SELF.pk_rc_numelever_0_c464 := pk_rc_numelever_0_c464;
		SELF.pk_rc_numelever_5_2 := pk_rc_numelever_5_2;
		SELF.pk_rc_numelever_2_1 := pk_rc_numelever_2_1;
		SELF.pk_rc_numelever_partial_2 := pk_rc_numelever_partial_2;
		SELF.pk_rc_numelever_6_2 := pk_rc_numelever_6_2;
		SELF.pk_rc_numelever_34_2 := pk_rc_numelever_34_2;
		SELF.pk_rc_numelever_0_1 := pk_rc_numelever_0_1;
		SELF.ver_src_bureau := ver_src_bureau;
		SELF.pk_r_pos_src_minor := pk_r_pos_src_minor;
		SELF.pk_r_pos_src_minor_flag := pk_r_pos_src_minor_flag;
		SELF.ver_src_emerge := ver_src_emerge;
		SELF.pk_r_pos_src_major := pk_r_pos_src_major;
		SELF.pk_r_pos_src_cnt := pk_r_pos_src_cnt;
		SELF.pk_r_pos_src_cnt_0_2 := pk_r_pos_src_cnt_0_2;
		SELF.pk_r_pos_src_cnt_1_2 := pk_r_pos_src_cnt_1_2;
		SELF.pk_r_pos_src_cnt_2_3 := pk_r_pos_src_cnt_2_3;
		SELF.pk_r_pos_src_cnt_3_3 := pk_r_pos_src_cnt_3_3;
		SELF.pk_r_pos_src_cnt_4_3 := pk_r_pos_src_cnt_4_3;
		SELF.pk_r_pos_src_cnt_5_3 := pk_r_pos_src_cnt_5_3;
		SELF.pk_r_pos_src_cnt_0_1 := pk_r_pos_src_cnt_0_1;
		SELF.pk_r_pos_src_cnt_1_1 := pk_r_pos_src_cnt_1_1;
		SELF.pk_r_pos_src_cnt_2_2 := pk_r_pos_src_cnt_2_2;
		SELF.pk_r_pos_src_cnt_3_2 := pk_r_pos_src_cnt_3_2;
		SELF.pk_r_pos_src_cnt_4_2 := pk_r_pos_src_cnt_4_2;
		SELF.pk_r_pos_src_cnt_5_2 := pk_r_pos_src_cnt_5_2;
		SELF.pk_add1_advo_address_vacancy_1 := pk_add1_advo_address_vacancy_1;
		SELF.pk_add1_advo_throw_back_1 := pk_add1_advo_throw_back_1;
		SELF.pk_add1_advo_college_1 := pk_add1_advo_college_1;
		SELF.pk_add1_advo_dnd_1 := pk_add1_advo_dnd_1;
		SELF.pk_impulse_flag_1 := pk_impulse_flag_1;
		SELF.pk_lien_flag_1 := pk_lien_flag_1;
		SELF.pk_bk_flag_1 := pk_bk_flag_1;
		SELF.pk_foreclosure_1 := pk_foreclosure_1;
		SELF.pk_inq_count70_2 := pk_inq_count70_2;
		SELF.pk_inq_count40_2 := pk_inq_count40_2;
		SELF.pk_inq_count10_2 := pk_inq_count10_2;
		SELF.pk_inq_count09_2 := pk_inq_count09_2;
		SELF.pk_inq_count40_1 := pk_inq_count40_1;
		SELF.pk_inq_count10_1 := pk_inq_count10_1;
		SELF.pk_inq_count09_1 := pk_inq_count09_1;
		SELF.pk_inq_count70_1 := pk_inq_count70_1;
		SELF.pk_attr_num_nonderogs180_0_2 := pk_attr_num_nonderogs180_0_2;
		SELF.pk_attr_num_nonderogs180_1_2 := pk_attr_num_nonderogs180_1_2;
		SELF.pk_attr_num_nonderogs180_3_3 := pk_attr_num_nonderogs180_3_3;
		SELF.pk_attr_num_nonderogs180_4_3 := pk_attr_num_nonderogs180_4_3;
		SELF.pk_attr_num_nonderogs180_5_3 := pk_attr_num_nonderogs180_5_3;
		SELF.pk_attr_num_nonderogs180_6_3 := pk_attr_num_nonderogs180_6_3;
		SELF.pk_attr_num_nonderogs180_3_2 := pk_attr_num_nonderogs180_3_2;
		SELF.pk_attr_num_nonderogs180_6_2 := pk_attr_num_nonderogs180_6_2;
		SELF.pk_attr_num_nonderogs180_5_2 := pk_attr_num_nonderogs180_5_2;
		SELF.pk_attr_num_nonderogs180_0_1 := pk_attr_num_nonderogs180_0_1;
		SELF.pk_attr_num_nonderogs180_1_1 := pk_attr_num_nonderogs180_1_1;
		SELF.pk_attr_num_nonderogs180_4_2 := pk_attr_num_nonderogs180_4_2;
		SELF.yr_header_first_seen := yr_header_first_seen;
		SELF.pk_yr_header_first_seen_0_2 := pk_yr_header_first_seen_0_2;
		SELF.pk_yr_header_first_seen_7_2 := pk_yr_header_first_seen_7_2;
		SELF.pk_yr_header_first_seen_9_2 := pk_yr_header_first_seen_9_2;
		SELF.pk_yr_header_first_seen_17_3 := pk_yr_header_first_seen_17_3;
		SELF.pk_yr_header_first_seen_18plus_3 := pk_yr_header_first_seen_18plus_3;
		SELF.pk_yr_header_first_seen_9_1 := pk_yr_header_first_seen_9_1;
		SELF.pk_yr_header_first_seen_17_2 := pk_yr_header_first_seen_17_2;
		SELF.pk_yr_header_first_seen_18plus_2 := pk_yr_header_first_seen_18plus_2;
		SELF.pk_yr_header_first_seen_0_1 := pk_yr_header_first_seen_0_1;
		SELF.pk_yr_header_first_seen_7_1 := pk_yr_header_first_seen_7_1;
		SELF.did_not_found := did_not_found;
		SELF.addrs_prison_history_1 := addrs_prison_history_1;
		SELF.pk_yr_header_first_seen_17_1 := pk_yr_header_first_seen_17_1;
		SELF.pk_add1_advo_throw_back := pk_add1_advo_throw_back;
		SELF.pk_r_pos_src_cnt_5_1 := pk_r_pos_src_cnt_5_1;
		SELF.pk_bk_flag := pk_bk_flag;
		SELF.pk_inq_count09 := pk_inq_count09;
		SELF.pk_impulse_flag := pk_impulse_flag;
		SELF.pk_rc_numelever_5_1 := pk_rc_numelever_5_1;
		SELF.pk_add1_advo_dnd := pk_add1_advo_dnd;
		SELF.pk_attr_num_nonderogs180_0 := pk_attr_num_nonderogs180_0;
		SELF.pk_attr_num_nonderogs180_1 := pk_attr_num_nonderogs180_1;
		SELF.pk_inq_count10 := pk_inq_count10;
		SELF.pk_attr_num_nonderogs180_3_1 := pk_attr_num_nonderogs180_3_1;
		SELF.pk_yr_header_first_seen_9 := pk_yr_header_first_seen_9;
		SELF.ssn_inval := ssn_inval;
		SELF.pk_r_pos_src_cnt_3_1 := pk_r_pos_src_cnt_3_1;
		SELF.pk_yr_header_first_seen_0 := pk_yr_header_first_seen_0;
		SELF.pk_inq_count40 := pk_inq_count40;
		SELF.ssn_deceased := ssn_deceased;
		SELF.pk_rc_numelever_34_1 := pk_rc_numelever_34_1;
		SELF.pk_r_pos_src_cnt_1 := pk_r_pos_src_cnt_1;
		SELF.pk_lien_flag := pk_lien_flag;
		SELF.add_pobox := add_pobox;
		SELF.pk_add1_advo_college := pk_add1_advo_college;
		SELF.pk_rc_numelever_2 := pk_rc_numelever_2;
		SELF.pk_disconnected := pk_disconnected;
		SELF.pk_attr_num_nonderogs180_6_1 := pk_attr_num_nonderogs180_6_1;
		SELF.ssn_priordob := ssn_priordob;
		SELF.pk_r_pos_src_cnt_0 := pk_r_pos_src_cnt_0;
		SELF.pk_addinval := pk_addinval;
		SELF.pk_inq_count70 := pk_inq_count70;
		SELF.pk_rc_numelever_6_1 := pk_rc_numelever_6_1;
		SELF.phn_highrisk := phn_highrisk;
		SELF.pk_rc_numelever_0 := pk_rc_numelever_0;
		SELF.pk_attr_num_nonderogs180_5_1 := pk_attr_num_nonderogs180_5_1;
		SELF.pk_r_pos_src_cnt_4_1 := pk_r_pos_src_cnt_4_1;
		SELF.pk_add1_advo_address_vacancy := pk_add1_advo_address_vacancy;
		SELF.pk_rc_numelever_partial_1 := pk_rc_numelever_partial_1;
		SELF.pk_yr_header_first_seen_18plus_1 := pk_yr_header_first_seen_18plus_1;
		SELF.pk_attr_num_nonderogs180_4_1 := pk_attr_num_nonderogs180_4_1;
		SELF.pk_yr_header_first_seen_7 := pk_yr_header_first_seen_7;
		SELF.pk_r_pos_src_cnt_2_1 := pk_r_pos_src_cnt_2_1;
		SELF.pk_foreclosure := pk_foreclosure;
		SELF.pk_bk_flag2_c486 := pk_bk_flag2_c486;
		SELF.pk_bk_flag2 := pk_bk_flag2;
		SELF.ver_name_src_ds_1 := ver_name_src_ds_1;
		SELF.ver_name_src_de_1 := ver_name_src_de_1;
		SELF.pk_deceased2 := pk_deceased2;
		SELF.incarceration_y := incarceration_y;
		SELF.leie_hit := leie_hit;
		SELF.leie_ran_hit := leie_ran_hit;
		SELF.leie_caff_hit := leie_caff_hit;
		SELF.medlicproflic_none := medlicproflic_none;
		SELF.medlicproflic_exp := medlicproflic_exp;
		SELF.medlicproflic_same_state_none := medlicproflic_same_state_none;
		SELF.medlicproflic_same_state_exp := medlicproflic_same_state_exp;
		SELF.time_on_ps_unknown_1 := time_on_ps_unknown_1;
		SELF.time_on_ps_03_1 := time_on_ps_03_1;
		SELF.time_on_ps_06_1 := time_on_ps_06_1;
		SELF.time_on_ps_09_2 := time_on_ps_09_2;
		SELF.time_on_ps_13_2 := time_on_ps_13_2;
		SELF.time_on_ps_18_2 := time_on_ps_18_2;
		SELF.time_on_ps_24_2 := time_on_ps_24_2;
		SELF.time_on_ps_30_2 := time_on_ps_30_2;
		SELF.time_on_ps_38_2 := time_on_ps_38_2;
		SELF.time_on_ps_39_2 := time_on_ps_39_2;
		SELF.time_on_ps_unknown := time_on_ps_unknown;
		SELF.time_on_ps_39_1 := time_on_ps_39_1;
		SELF.time_on_ps_03 := time_on_ps_03;
		SELF.time_on_ps_13_1 := time_on_ps_13_1;
		SELF.time_on_ps_18_1 := time_on_ps_18_1;
		SELF.time_on_ps_38_1 := time_on_ps_38_1;
		SELF.time_on_ps_24_1 := time_on_ps_24_1;
		SELF.time_on_ps_30_1 := time_on_ps_30_1;
		SELF.time_on_ps_06 := time_on_ps_06;
		SELF.time_on_ps_09_1 := time_on_ps_09_1;
		SELF.sex_offense_tot_1 := sex_offense_tot_1;
		SELF.sex_offense_tot := sex_offense_tot;
		SELF.sanction_black_current_count_1 := sanction_black_current_count_1;
		SELF.sanction_red_current_count_1 := sanction_red_current_count_1;
		SELF.sanction_yellow_current_count_2 := sanction_yellow_current_count_2;
		SELF.sanc_accusation_current_count := sanc_accusation_current_count;
		SELF.mult_accusation_adj_3 := mult_accusation_adj_3;
		SELF.sanction_yellow_current_count_1 := sanction_yellow_current_count_1;
		SELF.sanction_black_24_count_1 := sanction_black_24_count_1;
		SELF.sanction_red_24_count_1 := sanction_red_24_count_1;
		SELF.sanction_yellow_24_count_2 := sanction_yellow_24_count_2;
		SELF.sanc_accusation_24_count := sanc_accusation_24_count;
		SELF.mult_accusation_adj_2 := mult_accusation_adj_2;
		SELF.sanction_yellow_24_count_1 := sanction_yellow_24_count_1;
		SELF.sanction_black_60_count_1 := sanction_black_60_count_1;
		SELF.sanction_red_60_count_1 := sanction_red_60_count_1;
		SELF.sanction_yellow_60_count_2 := sanction_yellow_60_count_2;
		SELF.sanc_accusation_60_count := sanc_accusation_60_count;
		SELF.mult_accusation_adj_1 := mult_accusation_adj_1;
		SELF.sanction_yellow_60_count_1 := sanction_yellow_60_count_1;
		SELF.sanction_black_61_count_1 := sanction_black_61_count_1;
		SELF.sanction_red_61_count_1 := sanction_red_61_count_1;
		SELF.sanction_yellow_61_count_2 := sanction_yellow_61_count_2;
		SELF.sanc_accusation_61_count := sanc_accusation_61_count;
		SELF.mult_accusation_adj := mult_accusation_adj;
		SELF.sanction_yellow_61_count_1 := sanction_yellow_61_count_1;
		SELF.sanction_black_current_count := sanction_black_current_count;
		SELF.sanction_red_current_count := sanction_red_current_count;
		SELF.sanction_yellow_current_count := sanction_yellow_current_count;
		SELF.sanction_black_24_count := sanction_black_24_count;
		SELF.sanction_red_24_count := sanction_red_24_count;
		SELF.sanction_yellow_24_count := sanction_yellow_24_count;
		SELF.sanction_black_60_count := sanction_black_60_count;
		SELF.sanction_red_60_count := sanction_red_60_count;
		SELF.sanction_yellow_60_count := sanction_yellow_60_count;
		SELF.sanction_black_61_count := sanction_black_61_count;
		SELF.sanction_red_61_count := sanction_red_61_count;
		SELF.sanction_yellow_61_count := sanction_yellow_61_count;
		SELF.sanction_black_count := sanction_black_count;
		SELF.sanction_red_count := sanction_red_count;
		SELF.sanction_yellow_count := sanction_yellow_count;
		SELF.sanction_points_1 := sanction_points_1;
		SELF.sanction_points := sanction_points;
		SELF.wc_sanction_count := wc_sanction_count;
		SELF.sanc_black_current_count_ran_1 := sanc_black_current_count_ran_1;
		SELF.sanc_red_current_count_ran_1 := sanc_red_current_count_ran_1;
		SELF.sanc_yellow_current_count_ran_2 := sanc_yellow_current_count_ran_2;
		SELF.sanc_acc_curr_cnt_ran := sanc_acc_curr_cnt_ran;
		SELF.mult_accusation_adj_current_ran := mult_accusation_adj_current_ran;
		SELF.sanc_yellow_current_count_ran_1 := sanc_yellow_current_count_ran_1;
		SELF.sanc_black_24_count_ran_1 := sanc_black_24_count_ran_1;
		SELF.sanc_red_24_count_ran_1 := sanc_red_24_count_ran_1;
		SELF.sanc_yellow_24_count_ran_2 := sanc_yellow_24_count_ran_2;
		SELF.sanc_accusation_24_count_ran := sanc_accusation_24_count_ran;
		SELF.mult_accusation_adj_24_ran := mult_accusation_adj_24_ran;
		SELF.sanc_yellow_24_count_ran_1 := sanc_yellow_24_count_ran_1;
		SELF.sanc_black_60_count_ran_1 := sanc_black_60_count_ran_1;
		SELF.sanc_red_60_count_ran_1 := sanc_red_60_count_ran_1;
		SELF.sanc_yellow_60_count_ran_2 := sanc_yellow_60_count_ran_2;
		SELF.sanc_accusation_60_count_ran := sanc_accusation_60_count_ran;
		SELF.mult_accusation_adj_60_ran := mult_accusation_adj_60_ran;
		SELF.sanc_yellow_60_count_ran_1 := sanc_yellow_60_count_ran_1;
		SELF.sanc_black_61_count_ran_1 := sanc_black_61_count_ran_1;
		SELF.sanc_red_61_count_ran_1 := sanc_red_61_count_ran_1;
		SELF.sanc_yellow_61_count_ran_2 := sanc_yellow_61_count_ran_2;
		SELF.sanc_accusation_61_count_ran := sanc_accusation_61_count_ran;
		SELF.mult_accusation_adj_61_ran := mult_accusation_adj_61_ran;
		SELF.sanc_yellow_61_count_ran_1 := sanc_yellow_61_count_ran_1;
		SELF.sanc_black_current_count_ran := sanc_black_current_count_ran;
		SELF.sanc_red_current_count_ran := sanc_red_current_count_ran;
		SELF.sanc_yellow_current_count_ran := sanc_yellow_current_count_ran;
		SELF.sanc_black_24_count_ran := sanc_black_24_count_ran;
		SELF.sanc_red_24_count_ran := sanc_red_24_count_ran;
		SELF.sanc_yellow_24_count_ran := sanc_yellow_24_count_ran;
		SELF.sanc_black_60_count_ran := sanc_black_60_count_ran;
		SELF.sanc_red_60_count_ran := sanc_red_60_count_ran;
		SELF.sanc_yellow_60_count_ran := sanc_yellow_60_count_ran;
		SELF.sanc_black_61_count_ran := sanc_black_61_count_ran;
		SELF.sanc_red_61_count_ran := sanc_red_61_count_ran;
		SELF.sanc_yellow_61_count_ran := sanc_yellow_61_count_ran;
		SELF.sanc_black_count_ran := sanc_black_count_ran;
		SELF.sanc_red_count_ran := sanc_red_count_ran;
		SELF.sanc_yellow_count_ran := sanc_yellow_count_ran;
		SELF.sanction_points_ran_1 := sanction_points_ran_1;
		SELF.sanction_points_ran := sanction_points_ran;
		SELF.sanc_black_current_count_caff_1 := sanc_black_current_count_caff_1;
		SELF.sanc_red_current_count_caff_1 := sanc_red_current_count_caff_1;
		SELF.sanc_yellow_current_count_caff_2 := sanc_yellow_current_count_caff_2;
		SELF.sanc_acc_curr_cnt_caff := sanc_acc_curr_cnt_caff;
		SELF.mult_accusation_adj_current_caff := mult_accusation_adj_current_caff;
		SELF.sanc_yellow_current_count_caff_1 := sanc_yellow_current_count_caff_1;
		SELF.sanc_black_24_count_caff_1 := sanc_black_24_count_caff_1;
		SELF.sanc_red_24_count_caff_1 := sanc_red_24_count_caff_1;
		SELF.sanc_yellow_24_count_caff_2 := sanc_yellow_24_count_caff_2;
		SELF.sanc_accusation_24_count_caff := sanc_accusation_24_count_caff;
		SELF.mult_accusation_adj_24_caff := mult_accusation_adj_24_caff;
		SELF.sanc_yellow_24_count_caff_1 := sanc_yellow_24_count_caff_1;
		SELF.sanc_black_60_count_caff_1 := sanc_black_60_count_caff_1;
		SELF.sanc_red_60_count_caff_1 := sanc_red_60_count_caff_1;
		SELF.sanc_yellow_60_count_caff_2 := sanc_yellow_60_count_caff_2;
		SELF.sanc_accusation_60_count_caff := sanc_accusation_60_count_caff;
		SELF.mult_accusation_adj_60_caff := mult_accusation_adj_60_caff;
		SELF.sanc_yellow_60_count_caff_1 := sanc_yellow_60_count_caff_1;
		SELF.sanc_black_61_count_caff_1 := sanc_black_61_count_caff_1;
		SELF.sanc_red_61_count_caff_1 := sanc_red_61_count_caff_1;
		SELF.sanc_yellow_61_count_caff_2 := sanc_yellow_61_count_caff_2;
		SELF.sanc_accusation_61_count_caff := sanc_accusation_61_count_caff;
		SELF.mult_accusation_adj_61_caff := mult_accusation_adj_61_caff;
		SELF.sanc_yellow_61_count_caff_1 := sanc_yellow_61_count_caff_1;
		SELF.sanc_black_current_count_caff := sanc_black_current_count_caff;
		SELF.sanc_red_current_count_caff := sanc_red_current_count_caff;
		SELF.sanc_yellow_current_count_caff := sanc_yellow_current_count_caff;
		SELF.sanc_black_24_count_caff := sanc_black_24_count_caff;
		SELF.sanc_red_24_count_caff := sanc_red_24_count_caff;
		SELF.sanc_yellow_24_count_caff := sanc_yellow_24_count_caff;
		SELF.sanc_black_60_count_caff := sanc_black_60_count_caff;
		SELF.sanc_red_60_count_caff := sanc_red_60_count_caff;
		SELF.sanc_yellow_60_count_caff := sanc_yellow_60_count_caff;
		SELF.sanc_black_61_count_caff := sanc_black_61_count_caff;
		SELF.sanc_red_61_count_caff := sanc_red_61_count_caff;
		SELF.sanc_yellow_61_count_caff := sanc_yellow_61_count_caff;
		SELF.sanc_black_count_caff := sanc_black_count_caff;
		SELF.sanc_red_count_caff := sanc_red_count_caff;
		SELF.sanc_yellow_count_caff := sanc_yellow_count_caff;
		SELF.sanction_points_caff_1 := sanction_points_caff_1;
		SELF.sanction_points_caff := sanction_points_caff;
		SELF.gsa_count_2 := gsa_count_2;
		SELF.gsa_count_1 := gsa_count_1;
		SELF.gsa_count := gsa_count;
		SELF.gsa_ran_count_2 := gsa_ran_count_2;
		SELF.gsa_ran_count_1 := gsa_ran_count_1;
		SELF.gsa_ran_count := gsa_ran_count;
		SELF.pk_attr_num_nonderogs180_6 := pk_attr_num_nonderogs180_6;
		SELF.pk_yr_header_first_seen_17 := pk_yr_header_first_seen_17;
		SELF.pk_r_pos_src_cnt_5 := pk_r_pos_src_cnt_5;
		SELF.pk_rc_numelever_5 := pk_rc_numelever_5;
		SELF.time_on_ps_38 := time_on_ps_38;
		SELF.pk_rc_numelever_6 := pk_rc_numelever_6;
		SELF.time_on_ps_09 := time_on_ps_09;
		SELF.pk_attr_num_nonderogs180_5 := pk_attr_num_nonderogs180_5;
		SELF.time_on_ps_39 := time_on_ps_39;
		SELF.pk_r_pos_src_cnt_4 := pk_r_pos_src_cnt_4;
		SELF.time_on_ps_13 := time_on_ps_13;
		SELF.time_on_ps_18 := time_on_ps_18;
		SELF.pk_attr_num_nonderogs180_3 := pk_attr_num_nonderogs180_3;
		SELF.pk_yr_header_first_seen_18plus := pk_yr_header_first_seen_18plus;
		SELF.time_on_ps_24 := time_on_ps_24;
		SELF.pk_r_pos_src_cnt_3 := pk_r_pos_src_cnt_3;
		SELF.pk_rc_numelever_partial := pk_rc_numelever_partial;
		SELF.time_on_ps_30 := time_on_ps_30;
		SELF.pk_attr_num_nonderogs180_4 := pk_attr_num_nonderogs180_4;
		SELF.pk_r_pos_src_cnt_2 := pk_r_pos_src_cnt_2;
		SELF.pk_rc_numelever_34 := pk_rc_numelever_34;
		SELF.gsa_corporate_affiliation_count := gsa_corporate_affiliation_count;
		SELF.gsa_rancaff_count_2 := gsa_rancaff_count_2;
		SELF.gsa_rancaff_count_1 := gsa_rancaff_count_1;
		SELF.gsa_rancaff_count := gsa_rancaff_count;
		SELF.judgment_red_count_24_1 := judgment_red_count_24_1;
		SELF.judgment_yellow_count_24_1 := judgment_yellow_count_24_1;
		SELF.judgment_green_count_24_1 := judgment_green_count_24_1;
		SELF.judgment_red_count_24 := judgment_red_count_24;
		SELF.judgment_yellow_count_24 := judgment_yellow_count_24;
		SELF.judgment_green_count_24 := judgment_green_count_24;
		SELF.judgment_red_count_60_1 := judgment_red_count_60_1;
		SELF.judgment_yellow_count_60_1 := judgment_yellow_count_60_1;
		SELF.judgment_green_count_60_1 := judgment_green_count_60_1;
		SELF.judgment_red_count_60 := judgment_red_count_60;
		SELF.judgment_yellow_count_60 := judgment_yellow_count_60;
		SELF.judgment_green_count_60 := judgment_green_count_60;
		SELF.judgment_red_count_61_1 := judgment_red_count_61_1;
		SELF.judgment_yellow_count_61_1 := judgment_yellow_count_61_1;
		SELF.judgment_green_count_61_1 := judgment_green_count_61_1;
		SELF.judgment_red_count_61 := judgment_red_count_61;
		SELF.judgment_yellow_count_61 := judgment_yellow_count_61;
		SELF.judgment_green_count_61 := judgment_green_count_61;
		SELF.judgment_red_count_nd_1 := judgment_red_count_nd_1;
		SELF.judgment_yellow_count_nd_1 := judgment_yellow_count_nd_1;
		SELF.judgment_green_count_nd_1 := judgment_green_count_nd_1;
		SELF.judgment_red_count_nd := judgment_red_count_nd;
		SELF.judgment_yellow_count_nd := judgment_yellow_count_nd;
		SELF.judgment_green_count_nd := judgment_green_count_nd;
		SELF.judgment_red_count := judgment_red_count;
		SELF.judgment_yellow_count := judgment_yellow_count;
		SELF.judgment_green_count := judgment_green_count;
		SELF.judgment_points_1 := judgment_points_1;
		SELF.judgment_points := judgment_points;
		SELF.criminal_offense_red_cnt_24_1 := criminal_offense_red_cnt_24_1;
		SELF.criminal_offense_yellow_cnt_24_1 := criminal_offense_yellow_cnt_24_1;
		SELF.criminal_offense_green_cnt_24_1 := criminal_offense_green_cnt_24_1;
		SELF.criminal_offense_red_cnt_60_1 := criminal_offense_red_cnt_60_1;
		SELF.criminal_offense_yellow_cnt_60_1 := criminal_offense_yellow_cnt_60_1;
		SELF.criminal_offense_green_cnt_60_1 := criminal_offense_green_cnt_60_1;
		SELF.criminal_offense_red_cnt_61_1 := criminal_offense_red_cnt_61_1;
		SELF.criminal_offense_yellow_cnt_61_1 := criminal_offense_yellow_cnt_61_1;
		SELF.criminal_offense_green_cnt_61_1 := criminal_offense_green_cnt_61_1;
		SELF.criminal_offense_red_cnt_121_1 := criminal_offense_red_cnt_121_1;
		SELF.criminal_offense_yellow_cnt_121_1 := criminal_offense_yellow_cnt_121_1;
		SELF.criminal_offense_green_cnt_121_1 := criminal_offense_green_cnt_121_1;
		SELF.criminal_offense_red_cnt_24 := criminal_offense_red_cnt_24;
		SELF.criminal_offense_yellow_cnt_24 := criminal_offense_yellow_cnt_24;
		SELF.criminal_offense_green_cnt_24 := criminal_offense_green_cnt_24;
		SELF.criminal_offense_red_cnt_60 := criminal_offense_red_cnt_60;
		SELF.criminal_offense_yellow_cnt_60 := criminal_offense_yellow_cnt_60;
		SELF.criminal_offense_green_cnt_60 := criminal_offense_green_cnt_60;
		SELF.criminal_offense_red_cnt_61 := criminal_offense_red_cnt_61;
		SELF.criminal_offense_yellow_cnt_61 := criminal_offense_yellow_cnt_61;
		SELF.criminal_offense_green_cnt_61 := criminal_offense_green_cnt_61;
		SELF.criminal_offense_red_cnt_121 := criminal_offense_red_cnt_121;
		SELF.criminal_offense_yellow_cnt_121 := criminal_offense_yellow_cnt_121;
		SELF.criminal_offense_green_cnt_121 := criminal_offense_green_cnt_121;
		SELF.criminal_offense_red_count := criminal_offense_red_count;
		SELF.criminal_offense_yellow_count := criminal_offense_yellow_count;
		SELF.criminal_offense_green_count := criminal_offense_green_count;
		SELF.criminal_offense_points_1 := criminal_offense_points_1;
		SELF.criminal_offense_points := criminal_offense_points;
		SELF.crim_ran_offense_red_cnt_24_1 := crim_ran_offense_red_cnt_24_1;
		SELF.crim_ran_offense_yellow_cnt_24_1 := crim_ran_offense_yellow_cnt_24_1;
		SELF.crim_ran_offense_red_cnt_60_1 := crim_ran_offense_red_cnt_60_1;
		SELF.crim_ran_offense_yellow_cnt_60_1 := crim_ran_offense_yellow_cnt_60_1;
		SELF.crim_ran_offense_red_cnt_61_1 := crim_ran_offense_red_cnt_61_1;
		SELF.crim_ran_offense_yellow_cnt_61_1 := crim_ran_offense_yellow_cnt_61_1;
		SELF.crim_ran_offense_red_cnt_121_1 := crim_ran_offense_red_cnt_121_1;
		SELF.crim_ran_offense_yellow_cnt_121_1 := crim_ran_offense_yellow_cnt_121_1;
		SELF.crim_ran_offense_red_cnt_24 := crim_ran_offense_red_cnt_24;
		SELF.crim_ran_offense_yellow_cnt_24 := crim_ran_offense_yellow_cnt_24;
		SELF.crim_ran_offense_red_cnt_60 := crim_ran_offense_red_cnt_60;
		SELF.crim_ran_offense_yellow_cnt_60 := crim_ran_offense_yellow_cnt_60;
		SELF.crim_ran_offense_red_cnt_61 := crim_ran_offense_red_cnt_61;
		SELF.crim_ran_offense_yellow_cnt_61 := crim_ran_offense_yellow_cnt_61;
		SELF.crim_ran_offense_red_cnt_121 := crim_ran_offense_red_cnt_121;
		SELF.crim_ran_offense_yellow_cnt_121 := crim_ran_offense_yellow_cnt_121;
		SELF.crim_ran_offense_red_count := crim_ran_offense_red_count;
		SELF.crim_ran_offense_yellow_count := crim_ran_offense_yellow_count;
		SELF.criminal_offense_points_ran_1 := criminal_offense_points_ran_1;
		SELF.criminal_offense_points_ran := criminal_offense_points_ran;				
		SELF.hps_score_7 := hps_score_7;
		SELF.hps_score_diff_1 := hps_score_diff_1;
		SELF.hps_score_diff := hps_score_diff;
		SELF.hps_score_diff2 := hps_score_diff2;
		SELF.hps_score_6 := hps_score_6;
		SELF.hps_score_5 := hps_score_5;
		SELF.hps_score_4 := hps_score_4;
		SELF.hps_score_3 := hps_score_3;
		SELF.hps_score_2 := hps_score_2;
		SELF.hps_score_1 := hps_score_1;
		SELF.hps_score := hps_score;
		SELF.wc_c100_2 := wc_c100_2;
		SELF.wc_c200_3 := wc_c200_3;
		SELF.wc_c300_1 := wc_c300_1;
		SELF.wc_c400_1 := wc_c400_1;
		SELF.wc_c500_1 := wc_c500_1;
		SELF.wc_c600_1 := wc_c600_1;
		SELF.wc_c700_1 := wc_c700_1;
		SELF.wc_c800_1 := wc_c800_1;
		SELF.wc_c900_1 := wc_c900_1;
		SELF.wc_d100_1 := wc_d100_1;
		SELF.wc_d200_1 := wc_d200_1;
		SELF.wc_d300_1 := wc_d300_1;
		SELF.wc_f100_1 := wc_f100_1;
		SELF.wc_f200_1 := wc_f200_1;
		SELF.wc_f300 := wc_f300;
		SELF.wc_f400 := wc_f400;
		SELF.wc_f500_1 := wc_f500_1;
		SELF.wc_f600_1 := wc_f600_1;
		SELF.wc_id100_1 := wc_id100_1;
		SELF.wc_l100_1 := wc_l100_1;
		SELF.wc_l200_1 := wc_l200_1;
		SELF.wc_l300_1 := wc_l300_1;
		SELF.wc_s100_2 := wc_s100_2;
		SELF.wc_s200_1 := wc_s200_1;
		SELF.wc_s300_1 := wc_s300_1;
		SELF.wc_s400_1 := wc_s400_1;
		SELF.wc_s500_1 := wc_s500_1;
		SELF.wc_a100_1 := wc_a100_1;
		SELF.wc_a200_1 := wc_a200_1;
		SELF.wc_a300_1 := wc_a300_1;
		SELF.wc_a400_1 := wc_a400_1;
		SELF.wc_a450_1 := wc_a450_1;
		SELF.wc_a500_1 := wc_a500_1;
		SELF.wc_a600_1 := wc_a600_1;
		SELF.wc_a700_1 := wc_a700_1;
		SELF.wc_a800_1 := wc_a800_1;
		SELF.wc_a900_1 := wc_a900_1;
		SELF.wc_x100_1 := wc_x100_1;
		SELF.wc_x200_1 := wc_x200_1;
		SELF.wc_x300_1 := wc_x300_1;
		SELF.wc_v100_1 := wc_v100_1;
		SELF.wc_v200_1 := wc_v200_1;
		SELF.wc_v300_1 := wc_v300_1;
		SELF.wc_c200_2 := wc_c200_2;
		SELF.wc_c100_1 := wc_c100_1;
		SELF.wc_c400 := wc_c400;
		SELF.wc_c300 := wc_c300;
		SELF.wc_c600 := wc_c600;
		SELF.wc_c500 := wc_c500;
		SELF.wc_c700 := wc_c700;
		SELF.wc_c800 := wc_c800;
		SELF.wc_c900 := wc_c900;
		SELF.ver_name_src_ds := ver_name_src_ds;
		SELF.ver_name_src_de := ver_name_src_de;
		SELF.wc_d100 := wc_d100;
		SELF.wc_d300 := wc_d300;
		SELF.wc_d200 := wc_d200;
		SELF.wc_f200 := wc_f200;
		SELF.wc_f100 := wc_f100;
		SELF.wc_f500 := wc_f500;
		SELF.wc_f600 := wc_f600;
		SELF.ver_name_s := ver_name_s;
		SELF.wc_id100 := wc_id100;
		SELF.wc_id200 := wc_id200;
		SELF.wc_l200 := wc_l200;
		SELF.wc_l300 := wc_l300;
		SELF.wc_l100 := wc_l100;
		SELF.wc_s200 := wc_s200;
		SELF.wc_s100_1 := wc_s100_1;
		SELF.wc_s100 := wc_s100;
		SELF.wc_s300 := wc_s300;
		SELF.wc_s400 := wc_s400;
		SELF.wc_s500 := wc_s500;
		SELF.wc_a100 := wc_a100;
		SELF.wc_a200 := wc_a200;
		SELF.wc_a300 := wc_a300;
		SELF.wc_a400 := wc_a400;
		SELF.wc_a450 := wc_a450;
		SELF.wc_a600 := wc_a600;
		SELF.wc_a500 := wc_a500;
		SELF.wc_a800 := wc_a800;
		SELF.wc_a700 := wc_a700;
		SELF.wc_a900 := wc_a900;
		SELF.wc_x100 := wc_x100;
		SELF.wc_x200 := wc_x200;
		SELF.wc_x300 := wc_x300;
		SELF.wc_v100 := wc_v100;
		SELF.wc_v200 := wc_v200;
		SELF.wc_v300 := wc_v300;
		SELF.wc_c100 := wc_c100;
		SELF.wc_c200_1 := wc_c200_1;
		SELF.wc_c200 := wc_c200;
		SELF.wc_c100_pts_2 := wc_c100_pts_2;
		SELF.wc_c200_pts_2 := wc_c200_pts_2;
		SELF.wc_c300_pts_2 := wc_c300_pts_2;
		SELF.wc_c400_pts_2 := wc_c400_pts_2;
		SELF.wc_c500_pts_2 := wc_c500_pts_2;
		SELF.wc_c600_pts_2 := wc_c600_pts_2;
		SELF.wc_c700_pts_3 := wc_c700_pts_3;
		SELF.wc_c800_pts_3 := wc_c800_pts_3;
		SELF.wc_c900_pts_3 := wc_c900_pts_3;
		SELF.wc_d100_pts_2 := wc_d100_pts_2;
		SELF.wc_d200_pts_2 := wc_d200_pts_2;
		SELF.wc_d300_pts_2 := wc_d300_pts_2;
		SELF.wc_f100_pts_2 := wc_f100_pts_2;
		SELF.wc_f200_pts_2 := wc_f200_pts_2;
		SELF.wc_f300_pts_1 := wc_f300_pts_1;
		SELF.wc_f400_pts_1 := wc_f400_pts_1;
		SELF.wc_f500_pts_4 := wc_f500_pts_4;
		SELF.wc_f600_pts_4 := wc_f600_pts_4;
		SELF.wc_id100_pts_2 := wc_id100_pts_2;
		SELF.wc_id200_pts_5 := wc_id200_pts_5;
		SELF.wc_l100_pts_5 := wc_l100_pts_5;
		SELF.wc_l200_pts_5 := wc_l200_pts_5;
		SELF.wc_l300_pts_5 := wc_l300_pts_5;
		SELF.wc_s100_pts_2 := wc_s100_pts_2;
		SELF.wc_s200_pts_2 := wc_s200_pts_2;
		SELF.wc_s300_pts_2 := wc_s300_pts_2;
		SELF.wc_s400_pts_2 := wc_s400_pts_2;
		SELF.wc_s500_pts_2 := wc_s500_pts_2;
		SELF.wc_a100_pts_2 := wc_a100_pts_2;
		SELF.wc_a200_pts_2 := wc_a200_pts_2;
		SELF.wc_a300_pts_2 := wc_a300_pts_2;
		SELF.wc_a400_pts_2 := wc_a400_pts_2;
		SELF.wc_a450_pts_2 := wc_a450_pts_2;
		SELF.wc_a500_pts_2 := wc_a500_pts_2;
		SELF.wc_a600_pts_2 := wc_a600_pts_2;
		SELF.wc_a700_pts_2 := wc_a700_pts_2;
		SELF.wc_a800_pts_2 := wc_a800_pts_2;
		SELF.wc_a900_pts_2 := wc_a900_pts_2;
		SELF.wc_x100_pts_2 := wc_x100_pts_2;
		SELF.wc_x200_pts_3 := wc_x200_pts_3;
		SELF.wc_x300_pts_7 := wc_x300_pts_7;
		SELF.wc_v100_pts_4 := wc_v100_pts_4;
		SELF.wc_v200_pts_2 := wc_v200_pts_2;
		SELF.wc_v300_pts_4 := wc_v300_pts_4;
		SELF.wc_c100_pts_1 := wc_c100_pts_1;
		SELF.wc_c200_pts_1 := wc_c200_pts_1;
		SELF.wc_c300_pts_1 := wc_c300_pts_1;
		SELF.wc_c400_pts_1 := wc_c400_pts_1;
		SELF.wc_c500_pts_1 := wc_c500_pts_1;
		SELF.wc_c600_pts_1 := wc_c600_pts_1;
		SELF.wc_c700_pts_2 := wc_c700_pts_2;
		SELF.wc_c700_pts_1 := wc_c700_pts_1;
		SELF.wc_c800_pts_2 := wc_c800_pts_2;
		SELF.wc_c800_pts_1 := wc_c800_pts_1;
		SELF.wc_c900_pts_2 := wc_c900_pts_2;
		SELF.wc_c900_pts_1 := wc_c900_pts_1;
		SELF.wc_d100_pts_1 := wc_d100_pts_1;
		SELF.wc_d200_pts_1 := wc_d200_pts_1;
		SELF.wc_d300_pts_1 := wc_d300_pts_1;
		SELF.wc_f100_pts_1 := wc_f100_pts_1;
		SELF.wc_f200_pts_1 := wc_f200_pts_1;
		SELF.wc_f500_pts_3 := wc_f500_pts_3;
		SELF.wc_f500_pts_2 := wc_f500_pts_2;
		SELF.wc_f500_pts_1 := wc_f500_pts_1;
		SELF.wc_f600_pts_3 := wc_f600_pts_3;
		SELF.wc_f600_pts_2 := wc_f600_pts_2;
		SELF.wc_f600_pts_1 := wc_f600_pts_1;
		SELF.wc_id100_pts_1 := wc_id100_pts_1;
		SELF.wc_id200_pts_4 := wc_id200_pts_4;
		SELF.wc_id200_pts_3 := wc_id200_pts_3;
		SELF.wc_id200_pts_2 := wc_id200_pts_2;
		SELF.wc_id200_pts_1 := wc_id200_pts_1;
		SELF.wc_l100_pts_4 := wc_l100_pts_4;
		SELF.wc_l100_pts_3 := wc_l100_pts_3;
		SELF.wc_l100_pts_2 := wc_l100_pts_2;
		SELF.wc_l100_pts_1 := wc_l100_pts_1;
		SELF.wc_l200_pts_4 := wc_l200_pts_4;
		SELF.wc_l200_pts_3 := wc_l200_pts_3;
		SELF.wc_l200_pts_2 := wc_l200_pts_2;
		SELF.wc_l200_pts_1 := wc_l200_pts_1;
		SELF.wc_l300_pts_4 := wc_l300_pts_4;
		SELF.wc_l300_pts_3 := wc_l300_pts_3;
		SELF.wc_l300_pts_2 := wc_l300_pts_2;
		SELF.wc_l300_pts_1 := wc_l300_pts_1;
		SELF.wc_s100_pts_1 := wc_s100_pts_1;
		SELF.wc_s200_pts_1 := wc_s200_pts_1;
		SELF.wc_s300_pts_1 := wc_s300_pts_1;
		SELF.wc_s400_pts_1 := wc_s400_pts_1;
		SELF.wc_s500_pts_1 := wc_s500_pts_1;
		SELF.wc_a100_pts_1 := wc_a100_pts_1;
		SELF.wc_a200_pts_1 := wc_a200_pts_1;
		SELF.wc_a300_pts_1 := wc_a300_pts_1;
		SELF.wc_a400_pts_1 := wc_a400_pts_1;
		SELF.wc_a450_pts_1 := wc_a450_pts_1;
		SELF.wc_a500_pts_1 := wc_a500_pts_1;
		SELF.wc_a600_pts_1 := wc_a600_pts_1;
		SELF.wc_a700_pts_1 := wc_a700_pts_1;
		SELF.wc_a800_pts_1 := wc_a800_pts_1;
		SELF.wc_a900_pts_1 := wc_a900_pts_1;
		SELF.wc_x100_pts_1 := wc_x100_pts_1;
		SELF.wc_x200_pts_2 := wc_x200_pts_2;
		SELF.wc_x200_pts_1 := wc_x200_pts_1;
		SELF.wc_x300_pts_6 := wc_x300_pts_6;
		SELF.wc_x300_pts_5 := wc_x300_pts_5;
		SELF.wc_x300_pts_4 := wc_x300_pts_4;
		SELF.wc_x300_pts_3 := wc_x300_pts_3;
		SELF.wc_x300_pts_2 := wc_x300_pts_2;
		SELF.wc_x300_pts_1 := wc_x300_pts_1;
		SELF.wc_v100_pts_3 := wc_v100_pts_3;
		SELF.wc_v100_pts_2 := wc_v100_pts_2;
		SELF.wc_v100_pts_1 := wc_v100_pts_1;
		SELF.wc_v200_pts_1 := wc_v200_pts_1;
		SELF.wc_v300_pts_3 := wc_v300_pts_3;
		SELF.wc_v300_pts_2 := wc_v300_pts_2;
		SELF.wc_v300_pts_1 := wc_v300_pts_1;
		SELF.wc_c100_pts := wc_c100_pts;
		SELF.wc_c200_pts := wc_c200_pts;
		SELF.wc_c300_pts := wc_c300_pts;
		SELF.wc_c400_pts := wc_c400_pts;
		SELF.wc_c500_pts := wc_c500_pts;
		SELF.wc_c600_pts := wc_c600_pts;
		SELF.wc_c700_pts := wc_c700_pts;
		SELF.wc_c800_pts := wc_c800_pts;
		SELF.wc_c900_pts := wc_c900_pts;
		SELF.wc_d100_pts := wc_d100_pts;
		SELF.wc_d200_pts := wc_d200_pts;
		SELF.wc_d300_pts := wc_d300_pts;
		SELF.wc_f100_pts := wc_f100_pts;
		SELF.wc_f200_pts := wc_f200_pts;
		SELF.wc_f300_pts := wc_f300_pts;
		SELF.wc_f400_pts := wc_f400_pts;
		SELF.wc_f500_pts := wc_f500_pts;
		SELF.wc_f600_pts := wc_f600_pts;
		SELF.wc_id100_pts := wc_id100_pts;
		SELF.wc_id200_pts := wc_id200_pts;
		SELF.wc_l100_pts := wc_l100_pts;
		SELF.wc_l200_pts := wc_l200_pts;
		SELF.wc_l300_pts := wc_l300_pts;
		SELF.wc_s100_pts := wc_s100_pts;
		SELF.wc_s200_pts := wc_s200_pts;
		SELF.wc_s300_pts := wc_s300_pts;
		SELF.wc_s400_pts := wc_s400_pts;
		SELF.wc_s500_pts := wc_s500_pts;
		SELF.wc_a100_pts := wc_a100_pts;
		SELF.wc_a200_pts := wc_a200_pts;
		SELF.wc_a300_pts := wc_a300_pts;
		SELF.wc_a400_pts := wc_a400_pts;
		SELF.wc_a450_pts := wc_a450_pts;
		SELF.wc_a500_pts := wc_a500_pts;
		SELF.wc_a600_pts := wc_a600_pts;
		SELF.wc_a700_pts := wc_a700_pts;
		SELF.wc_a800_pts := wc_a800_pts;
		SELF.wc_a900_pts := wc_a900_pts;
		SELF.wc_x100_pts := wc_x100_pts;
		SELF.wc_x200_pts := wc_x200_pts;
		SELF.wc_x300_pts := wc_x300_pts;
		SELF.wc_v100_pts := wc_v100_pts;
		SELF.wc_v200_pts := wc_v200_pts;
		SELF.wc_v300_pts := wc_v300_pts;
		SELF.pts1 := pts1;
		SELF.pts2 := pts2;
		SELF.pts3 := pts3;
		SELF.pts4 := pts4;
		SELF.pts5 := pts5;
		SELF.pts6 := pts6;
		SELF.pts7 := pts7;
		SELF.pts8 := pts8;
		SELF.pts9 := pts9;
		SELF.pts10 := pts10;
		SELF.pts11 := pts11;
		SELF.pts12 := pts12;
		SELF.pts13 := pts13;
		SELF.pts14 := pts14;
		SELF.pts15 := pts15;
		SELF.pts16 := pts16;
		SELF.pts17 := pts17;
		SELF.pts18 := pts18;
		SELF.pts19 := pts19;
		SELF.pts20 := pts20;
		SELF.pts21 := pts21;
		SELF.pts22 := pts22;
		SELF.pts23 := pts23;
		SELF.pts24 := pts24;
		SELF.pts25 := pts25;
		SELF.pts26 := pts26;
		SELF.pts27 := pts27;
		SELF.pts28 := pts28;
		SELF.pts29 := pts29;
		SELF.pts30 := pts30;
		SELF.pts31 := pts31;
		SELF.pts32 := pts32;
		SELF.pts33 := pts33;
		SELF.pts34 := pts34;
		SELF.pts35 := pts35;
		SELF.pts36 := pts36;
		SELF.pts37 := pts37;
		SELF.pts38 := pts38;
		SELF.pts39 := pts39;
		SELF.pts40 := pts40;
		SELF.pts41 := pts41;
		SELF.pts42 := pts42;
		SELF.pts43 := pts43;
		SELF.pts44 := pts44;

		SELF.rc1 := reasons[1].hri;
		SELF.rc2 := reasons[2].hri;
		SELF.rc3 := reasons[3].hri;
		SELF.rc4 := reasons[4].hri;
		SELF.rc5 := reasons[5].hri;
		SELF.rc6 := reasons[6].hri;
		SELF.rc7 := reasons[7].hri;
		SELF.rc8 := reasons[8].hri;

		SELF.combinedShells := le;
	#else
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)hps_score;
		SELF.seq := le.BocaShell.seq;
	#end
	END;

	model := PROJECT(combinedShells, doModel(LEFT));

	RETURN(model);
END;